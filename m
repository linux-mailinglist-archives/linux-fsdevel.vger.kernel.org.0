Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9422D357DF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhDHITw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 04:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhDHITv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:19:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5519B61154;
        Thu,  8 Apr 2021 08:19:38 +0000 (UTC)
Date:   Thu, 8 Apr 2021 10:19:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <20210408081935.b3xollrzl6lejbyf@wittgenstein>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:46:11PM -0700, Daniel Xu wrote:
> This commit introduces the bpf page cache iterator. This iterator allows
> users to run a bpf prog against each page in the "page cache".
> Internally, the "page cache" is extremely tied to VFS superblock + inode
> combo. Because of this, iter_pagecache will only examine pages in the
> caller's mount namespace.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  kernel/bpf/Makefile         |   2 +-
>  kernel/bpf/pagecache_iter.c | 293 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 294 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/pagecache_iter.c
> 
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 7f33098ca63f..3deb6a8d3f75 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
>  endif
>  CFLAGS_core.o += $(call cc-disable-warning, override-init) $(cflags-nogcse-yy)
>  
> -obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o map_iter.o task_iter.o prog_iter.o
> +obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o bpf_iter.o pagecache_iter.o map_iter.o task_iter.o prog_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o
>  obj-$(CONFIG_BPF_SYSCALL) += local_storage.o queue_stack_maps.o ringbuf.o
>  obj-$(CONFIG_BPF_SYSCALL) += bpf_local_storage.o bpf_task_storage.o
> diff --git a/kernel/bpf/pagecache_iter.c b/kernel/bpf/pagecache_iter.c
> new file mode 100644
> index 000000000000..8442ab0d4221
> --- /dev/null
> +++ b/kernel/bpf/pagecache_iter.c
> @@ -0,0 +1,293 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/init.h>
> +#include <linux/mm_types.h>
> +#include <linux/mnt_namespace.h>
> +#include <linux/nsproxy.h>
> +#include <linux/pagemap.h>
> +#include <linux/radix-tree.h>
> +#include <linux/seq_file.h>
> +#include "../../fs/mount.h"

This is a private header on purpose. Outside of fs/ poking around in
struct mount or struct mount_namespace should not be done.

> +
> +struct bpf_iter_seq_pagecache_info {
> +	struct mnt_namespace *ns;
> +	struct radix_tree_root superblocks;
> +	struct super_block *cur_sb;
> +	struct inode *cur_inode;
> +	unsigned long cur_page_idx;
> +};
> +
> +static struct super_block *goto_next_sb(struct bpf_iter_seq_pagecache_info *info)
> +{
> +	struct super_block *sb = NULL;
> +	struct radix_tree_iter iter;
> +	void **slot;
> +
> +	radix_tree_for_each_slot(slot, &info->superblocks, &iter,
> +				 ((unsigned long)info->cur_sb + 1)) {
> +		sb = (struct super_block *)iter.index;
> +		break;
> +	}
> +
> +	info->cur_sb = sb;
> +	info->cur_inode = NULL;
> +	info->cur_page_idx = 0;
> +	return sb;
> +}
> +
> +static bool inode_unusual(struct inode *inode) {
> +	return ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
> +		(inode->i_mapping->nrpages == 0));
> +}
> +
> +static struct inode *goto_next_inode(struct bpf_iter_seq_pagecache_info *info)
> +{
> +	struct inode *prev_inode = info->cur_inode;
> +	struct inode *inode;
> +
> +retry:
> +	BUG_ON(!info->cur_sb);
> +	spin_lock(&info->cur_sb->s_inode_list_lock);
> +
> +	if (!info->cur_inode) {
> +		list_for_each_entry(inode, &info->cur_sb->s_inodes, i_sb_list) {
> +			spin_lock(&inode->i_lock);
> +			if (inode_unusual(inode)) {
> +				spin_unlock(&inode->i_lock);
> +				continue;
> +			}
> +			__iget(inode);
> +			spin_unlock(&inode->i_lock);
> +			info->cur_inode = inode;
> +			break;
> +		}
> +	} else {
> +		inode = info->cur_inode;
> +		info->cur_inode = NULL;
> +		list_for_each_entry_continue(inode, &info->cur_sb->s_inodes,
> +					     i_sb_list) {
> +			spin_lock(&inode->i_lock);
> +			if (inode_unusual(inode)) {
> +				spin_unlock(&inode->i_lock);
> +				continue;
> +			}
> +			__iget(inode);
> +			spin_unlock(&inode->i_lock);
> +			info->cur_inode = inode;
> +			break;
> +		}
> +	}
> +
> +	/* Seen all inodes in this superblock */
> +	if (!info->cur_inode) {
> +		spin_unlock(&info->cur_sb->s_inode_list_lock);
> +		if (!goto_next_sb(info)) {
> +			inode = NULL;
> +			goto out;
> +		}
> +
> +		goto retry;
> +	}
> +
> +	spin_unlock(&info->cur_sb->s_inode_list_lock);
> +	info->cur_page_idx = 0;
> +out:
> +	iput(prev_inode);
> +	return info->cur_inode;
> +}
> +
> +static struct page *goto_next_page(struct bpf_iter_seq_pagecache_info *info)
> +{
> +	struct page *page, *ret = NULL;
> +	unsigned long idx;
> +
> +	rcu_read_lock();
> +retry:
> +	BUG_ON(!info->cur_inode);
> +	ret = NULL;
> +	xa_for_each_start(&info->cur_inode->i_data.i_pages, idx, page,
> +			  info->cur_page_idx) {
> +		if (!page_cache_get_speculative(page))
> +			continue;
> +
> +		ret = page;
> +		info->cur_page_idx = idx + 1;
> +		break;
> +	}
> +
> +	if (!ret) {
> +		/* Seen all inodes and superblocks */
> +		if (!goto_next_inode(info))
> +			goto out;
> +
> +		goto retry;
> +	}
> +
> +out:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static void *pagecache_seq_start(struct seq_file *seq, loff_t *pos)
> +{
> +	struct bpf_iter_seq_pagecache_info *info = seq->private;
> +	struct page *page;
> +
> +	if (!info->cur_sb && !goto_next_sb(info))
> +		return NULL;
> +	if (!info->cur_inode && !goto_next_inode(info))
> +		return NULL;
> +
> +	page = goto_next_page(info);
> +	if (!page)
> +		return NULL;
> +
> +	if (*pos == 0)
> +		++*pos;
> +
> +	return page;
> +
> +}
> +
> +static void *pagecache_seq_next(struct seq_file *seq, void *v, loff_t *pos)
> +{
> +	struct bpf_iter_seq_pagecache_info *info = seq->private;
> +	struct page *page;
> +
> +	++*pos;
> +	put_page((struct page *)v);
> +	page = goto_next_page(info);
> +	if (!page)
> +		return NULL;
> +
> +	return page;
> +}
> +
> +struct bpf_iter__pagecache {
> +	__bpf_md_ptr(struct bpf_iter_meta *, meta);
> +	__bpf_md_ptr(struct page *, page);
> +};
> +
> +DEFINE_BPF_ITER_FUNC(pagecache, struct bpf_iter_meta *meta, struct page *page)
> +
> +static int __pagecache_seq_show(struct seq_file *seq, struct page *page,
> +				bool in_stop)
> +{
> +	struct bpf_iter_meta meta;
> +	struct bpf_iter__pagecache ctx;
> +	struct bpf_prog *prog;
> +
> +	meta.seq = seq;
> +	prog = bpf_iter_get_info(&meta, in_stop);
> +	if (!prog)
> +		return 0;
> +
> +	meta.seq = seq;
> +	ctx.meta = &meta;
> +	ctx.page = page;
> +	return bpf_iter_run_prog(prog, &ctx);
> +}
> +
> +static int pagecache_seq_show(struct seq_file *seq, void *v)
> +{
> +	return __pagecache_seq_show(seq, v, false);
> +}
> +
> +static void pagecache_seq_stop(struct seq_file *seq, void *v)
> +{
> +	(void)__pagecache_seq_show(seq, v, true);
> +	if (v)
> +		put_page((struct page *)v);
> +}
> +
> +static int init_seq_pagecache(void *priv_data, struct bpf_iter_aux_info *aux)
> +{
> +	struct bpf_iter_seq_pagecache_info *info = priv_data;
> +	struct radix_tree_iter iter;
> +	struct super_block *sb;
> +	struct mount *mnt;
> +	void **slot;
> +	int err;
> +
> +	info->ns = current->nsproxy->mnt_ns;
> +	get_mnt_ns(info->ns);
> +	INIT_RADIX_TREE(&info->superblocks, GFP_KERNEL);
> +
> +	spin_lock(&info->ns->ns_lock);
> +	list_for_each_entry(mnt, &info->ns->list, mnt_list) {

Not just are there helpers for taking ns_lock
static inline void lock_ns_list(struct mnt_namespace *ns)
static inline void unlock_ns_list(struct mnt_namespace *ns)
they are private to fs/namespace.c because it's the only place that
should ever walk this list.

This seems buggy: why is it ok here to only take ns_lock and not also
namespace_sem like mnt_already_visible() and __is_local_mountpoint() or
the relevant proc iterators? I might be missing something.

> +		sb = mnt->mnt.mnt_sb;
> +
> +		/* The same mount may be mounted in multiple places */
> +		if (radix_tree_lookup(&info->superblocks, (unsigned long)sb))
> +			continue;
> +
> +		err = radix_tree_insert(&info->superblocks,
> +				        (unsigned long)sb, (void *)1);
> +		if (err)
> +			goto out;
> +	}
> +
> +	radix_tree_for_each_slot(slot, &info->superblocks, &iter, 0) {
> +		sb = (struct super_block *)iter.index;
> +		atomic_inc(&sb->s_active);

It also isn't nice that you mess with sb->s_active directly.

Imho, this is poking around in a lot of fs/ specific stuff that other
parts of the kernel should not care about or have access to.

Christian
