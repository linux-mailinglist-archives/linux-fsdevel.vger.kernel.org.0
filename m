Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDFC357C3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 08:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhDHGO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 02:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhDHGO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:14:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0AC061762;
        Wed,  7 Apr 2021 23:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0yv3MJ3oAVnJYQ+0/a4f1v89qsCDdNpeUxyalRyWzAQ=; b=PPdSlFGNFYyVM+AMh7mv3DAoY9
        cy8zdEJ428v0rYh8BpeJN/IUVMvi49c/VnWqQHMGg9RdxW6fM9ZiPh4dtmxLAt+vb0UcAQdOZs1CZ
        2qxwSUk6WQtsdwnZqO+Z91tQN14jogtTGkTmOmgvNRnWR5Xlhdf6K5fzdOG06tjaEYOdC2a0vjgan
        wcRVm8chosZ8O2B5gU0H5UrZlvpI7+XVHvW0mm4fQF5l6rDnsyAgAaY/re5HHaAJ+sy4devHdJbD/
        L+IrHDt09CyNTEMw4EGmh0XHSfQd7bKtly0bizh6DFnXqYTUi+AWaKdkXwKelOqpr2iPcNA/ExjhT
        vNWrQu4g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUNvV-00FfxS-L9; Thu, 08 Apr 2021 06:14:09 +0000
Date:   Thu, 8 Apr 2021 07:14:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, jolsa@kernel.org, hannes@cmpxchg.org,
        yhs@fb.com
Subject: Re: [RFC bpf-next 1/1] bpf: Introduce iter_pagecache
Message-ID: <20210408061401.GI2531743@casper.infradead.org>
References: <cover.1617831474.git.dxu@dxuuu.xyz>
 <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22bededbd502e0df45326a54b3056941de65a101.1617831474.git.dxu@dxuuu.xyz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:46:11PM -0700, Daniel Xu wrote:
> +struct bpf_iter_seq_pagecache_info {
> +	struct mnt_namespace *ns;
> +	struct radix_tree_root superblocks;

Why are you adding a new radix tree?  Use an XArray instead.

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

Why do you feel the need to poke around in i_pages directly?  Is there
something wrong with find_get_entries()?

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

I'm not really keen on the idea of random BPF programs being able to poke
at pages in the page cache like this.  From your initial description,
it sounded like all you needed was a list of which pages are present.

> +	INIT_RADIX_TREE(&info->superblocks, GFP_KERNEL);
> +
> +	spin_lock(&info->ns->ns_lock);
> +	list_for_each_entry(mnt, &info->ns->list, mnt_list) {
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
> +	}

Uh.  What on earth made you think this was a good way to use the radix
tree?  And, no, the XArray doesn't change that.

If you don't understand why this is so bad, call xa_dump() on it after
constructing it.  I'll wait.
