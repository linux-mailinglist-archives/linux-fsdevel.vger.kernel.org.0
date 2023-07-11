Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBBF74EFEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjGKNNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjGKNNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:13:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7540518D;
        Tue, 11 Jul 2023 06:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD438614E2;
        Tue, 11 Jul 2023 13:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D794C433C7;
        Tue, 11 Jul 2023 13:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689081186;
        bh=CDiITJi0TzBDerA5pWdZRvyrcN76IEn7mHYE+hfx6C0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WuW6qI3/sCz7cPrPEc/CVZ6sHawnIzRYXSo/HS/QN6cUc0VMEvh9JghArjjCKxkhv
         IRS9CSWqxXva+Nbq5YIzDWo+L0800zIiDzGmb5umHplm5hcs3ricVfMHD8uRP5ugE6
         qVGHY5F3O91nKfMCTB/umEXABebWxYIYuH5kshhoWthZFIpEtpSE+RbN1aDWNMlcXL
         nI2PjHasOg3GffJiw2UBrsDP5yQTRYPef36NL4l0JWt+pCC4zEMxTBsdp9xExrDEys
         cujJiw/hsH1JHP9AaKq1zqVB9ex+22bD3pf3AUK7qf/rnNjotF1sj7MkqnMl+dht65
         FbxWudf49a+mw==
Date:   Tue, 11 Jul 2023 22:13:02 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zehao Zhang <zhangzehao@vivo.com>
Cc:     linkinjeon@kernel.org, sj1557.seo@samsung.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] exfat: Add ftrace support for exfat and add some
 tracepoints
Message-Id: <20230711221302.f046a5e42db5f822669059d1@kernel.org>
In-Reply-To: <20230711122208.65020-1-zhangzehao@vivo.com>
References: <20230711122208.65020-1-zhangzehao@vivo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Tue, 11 Jul 2023 20:22:08 +0800
Zehao Zhang <zhangzehao@vivo.com> wrote:

> Add ftrace support for exFAT file system,
> and add some tracepoints:
> exfat_read_folio(), exfat_writepages(), exfat_write_begin(),
> exfat_write_end(), exfat_lookup_start(), exfat_lookup_end()
> 
> exfat_read_folio():
> shows the dev number, inode and the folio index.
> 
> exfat_writepages():
> shows the inode and fields in struct writeback_control.
> 
> exfat_write_begin():
> shows the inode, file position offset and length.
> 
> exfat_write_end():
> shows the inode, file position offset, bytes write to page
> and bytes copied from user.
> 
> exfat_lookup_start():
> shows the target inode, dentry and flags.
> 
> exfat_lookup_end():
> shows the target inode, dentry and err code.
> 

I still doubt including these. If VFS layer maintainer rejects the generic
events, that means they expect to change the VFS layer in the future.

If so, is that good to expose the trace event which is visible to users
from exFAT? If VFS layer changes the interface in the future, these events
can be out-of-dated.

I think some of events looks good because those are enough , like
exfat_write_begin/end, exfat_lookup_start/end (BTW, why one is 'begin' and
another is 'start'?) But I think exfat_read_folio and exfat_writepages
expose some implement depending parameters.

Zehao, could you tell me what you really want to do with these?
Maybe you can expose tracepoint instead of traceevent for tracing such
implement depending parameters.

Thank you,

> Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>
> ---
> v2:
> - Keep the dereferencing logic out of the code path,
>   only happens in the trace event functions.
> 
> Thanks for Steve's advice.
> 
>  MAINTAINERS                  |   1 +
>  fs/exfat/inode.c             |   9 ++
>  fs/exfat/namei.c             |  10 +-
>  include/trace/events/exfat.h | 190 +++++++++++++++++++++++++++++++++++
>  4 files changed, 209 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/exfat.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f115c355a41..fbe1caa61a38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7752,6 +7752,7 @@ L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
>  F:	fs/exfat/
> +F:	include/trace/events/exfat.h
>  
>  EXT2 FILE SYSTEM
>  M:	Jan Kara <jack@suse.com>
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index 481dd338f2b8..81fe715baab0 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -17,6 +17,9 @@
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/exfat.h>
> +
>  int __exfat_write_inode(struct inode *inode, int sync)
>  {
>  	unsigned long long on_disk_size;
> @@ -335,6 +338,7 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>  
>  static int exfat_read_folio(struct file *file, struct folio *folio)
>  {
> +	trace_exfat_read_folio(folio);
>  	return mpage_read_folio(folio, exfat_get_block);
>  }
>  
> @@ -346,6 +350,7 @@ static void exfat_readahead(struct readahead_control *rac)
>  static int exfat_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
> +	trace_exfat_writepages(mapping, wbc);
>  	return mpage_writepages(mapping, wbc, exfat_get_block);
>  }
>  
> @@ -371,6 +376,8 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
>  			       exfat_get_block,
>  			       &EXFAT_I(mapping->host)->i_size_ondisk);
>  
> +	trace_exfat_write_begin(mapping, pos, len);
> +
>  	if (ret < 0)
>  		exfat_write_failed(mapping, pos+len);
>  
> @@ -394,6 +401,8 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
>  		return -EIO;
>  	}
>  
> +	trace_exfat_write_end(inode, pos, len, copied);
> +
>  	if (err < len)
>  		exfat_write_failed(mapping, pos+len);
>  
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index e0ff9d156f6f..f4f36de4ca0d 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -12,6 +12,8 @@
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
>  
> +#include <trace/events/exfat.h>
> +
>  static inline unsigned long exfat_d_version(struct dentry *dentry)
>  {
>  	return (unsigned long) dentry->d_fsdata;
> @@ -707,6 +709,8 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
>  	loff_t i_pos;
>  	mode_t i_mode;
>  
> +	trace_exfat_lookup_start(dir, dentry, flags);
> +
>  	mutex_lock(&EXFAT_SB(sb)->s_lock);
>  	err = exfat_find(dir, &dentry->d_name, &info);
>  	if (err) {
> @@ -766,7 +770,11 @@ static struct dentry *exfat_lookup(struct inode *dir, struct dentry *dentry,
>  	if (!inode)
>  		exfat_d_version_set(dentry, inode_query_iversion(dir));
>  
> -	return d_splice_alias(inode, dentry);
> +	alias = d_splice_alias(inode, dentry);
> +	trace_exfat_lookup_end(dir, !IS_ERR_OR_NULL(alias) ? alias : dentry,
> +			IS_ERR(alias) ? PTR_ERR(alias) : err);
> +
> +	return alias;
>  unlock:
>  	mutex_unlock(&EXFAT_SB(sb)->s_lock);
>  	return ERR_PTR(err);
> diff --git a/include/trace/events/exfat.h b/include/trace/events/exfat.h
> new file mode 100644
> index 000000000000..782dae6e2e42
> --- /dev/null
> +++ b/include/trace/events/exfat.h
> @@ -0,0 +1,190 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM exfat
> +
> +#if !defined(_TRACE_EXFAT_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_EXFAT_H
> +
> +#include <linux/tracepoint.h>
> +
> +#define EXFAT_I(inode)	(container_of(inode, struct exfat_inode_info, vfs_inode))
> +
> +
> +TRACE_EVENT(exfat_write_begin,
> +	TP_PROTO(struct address_space *mapping, loff_t pos, unsigned int len),
> +
> +	TP_ARGS(mapping, pos, len),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,        dev)
> +		__field(ino_t,        ino)
> +		__field(loff_t,       pos)
> +		__field(unsigned int, len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev    = mapping->host->i_sb->s_dev;
> +		__entry->ino    = mapping->host->i_ino;
> +		__entry->pos    = pos;
> +		__entry->len    = len;
> +	),
> +
> +	TP_printk("dev (%d,%d) ino %lu pos %lld len %u",
> +		MAJOR(__entry->dev), MINOR(__entry->dev),
> +		(unsigned long) __entry->ino,
> +		__entry->pos, __entry->len)
> +
> +);
> +
> +TRACE_EVENT(exfat_write_end,
> +	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len,
> +			unsigned int copied),
> +
> +	TP_ARGS(inode, pos, len, copied),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__field(loff_t,	pos)
> +		__field(unsigned int, len)
> +		__field(unsigned int, copied)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	= inode->i_sb->s_dev;
> +		__entry->ino	= inode->i_ino;
> +		__entry->pos	= pos;
> +		__entry->len	= len;
> +		__entry->copied	= copied;
> +	),
> +
> +	TP_printk("dev (%d,%d) ino %lu pos %lld len %u copied %u",
> +		MAJOR(__entry->dev), MINOR(__entry->dev),
> +		(unsigned long) __entry->ino,
> +		__entry->pos, __entry->len, __entry->copied)
> +);
> +
> +TRACE_EVENT(exfat_read_folio,
> +	TP_PROTO(struct folio *folio),
> +
> +	TP_ARGS(folio),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__field(pgoff_t, index)
> +
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	= folio->mapping->host->i_sb->s_dev;
> +		__entry->ino	= folio->mapping->host->i_ino;
> +		__entry->index	= folio->index;
> +	),
> +
> +	TP_printk("dev (%d,%d) ino %lu folio_index %lu",
> +		MAJOR(__entry->dev), MINOR(__entry->dev),
> +		(unsigned long) __entry->ino,
> +		(unsigned long) __entry->index)
> +);
> +
> +TRACE_EVENT(exfat_writepages,
> +	TP_PROTO(struct address_space *mapping, struct writeback_control *wbc),
> +
> +	TP_ARGS(mapping, wbc),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__field(long,	nr_to_write)
> +		__field(long,	pages_skipped)
> +		__field(loff_t,		range_start)
> +		__field(loff_t,		range_end)
> +		__field(pgoff_t,	writeback_index)
> +		__field(int,	sync_mode)
> +		__field(char,	for_kupdate)
> +		__field(char,	range_cyclic)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= mapping->host->i_sb->s_dev;
> +		__entry->ino		= mapping->host->i_ino;
> +		__entry->nr_to_write	= wbc->nr_to_write;
> +		__entry->pages_skipped	= wbc->pages_skipped;
> +		__entry->range_start	= wbc->range_start;
> +		__entry->range_end	= wbc->range_end;
> +		__entry->writeback_index = mapping->host->i_mapping->writeback_index;
> +		__entry->sync_mode	= wbc->sync_mode;
> +		__entry->for_kupdate	= wbc->for_kupdate;
> +		__entry->range_cyclic	= wbc->range_cyclic;
> +	),
> +
> +	TP_printk("dev (%d,%d) ino %lu nr_to_write %ld pages_skipped %ld "
> +		"range_start %lld range_end %lld sync_mode %d "
> +		"for_kupdate %d range_cyclic %d writeback_index %lu",
> +		MAJOR(__entry->dev), MINOR(__entry->dev),
> +		(unsigned long) __entry->ino, __entry->nr_to_write,
> +		__entry->pages_skipped, __entry->range_start,
> +		__entry->range_end, __entry->sync_mode,
> +		__entry->for_kupdate, __entry->range_cyclic,
> +		(unsigned long) __entry->writeback_index)
> +);
> +
> +TRACE_EVENT(exfat_lookup_start,
> +
> +	TP_PROTO(struct inode *dir, struct dentry *dentry, unsigned int flags),
> +
> +	TP_ARGS(dir, dentry, flags),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__string(name,	dentry->d_name.name)
> +		__field(unsigned int, flags)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	= dir->i_sb->s_dev;
> +		__entry->ino	= dir->i_ino;
> +		__assign_str(name, dentry->d_name.name);
> +		__entry->flags	= flags;
> +	),
> +
> +	TP_printk("dev = (%d,%d), pino = %lu, name:%s, flags:%u",
> +		MAJOR(__entry->dev), MINOR(__entry->dev),
> +		(unsigned long)__entry->ino,
> +		__get_str(name),
> +		__entry->flags)
> +);
> +
> +TRACE_EVENT(exfat_lookup_end,
> +
> +	TP_PROTO(struct inode *dir, struct dentry *dentry, int err),
> +
> +	TP_ARGS(dir, dentry, err),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__string(name,	dentry->d_name.name)
> +		__field(int,	err)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	= dir->i_sb->s_dev;
> +		__entry->ino	= dir->i_ino;
> +		__assign_str(name, dentry->d_name.name);
> +		__entry->err	= err;
> +	),
> +
> +	TP_printk("dev = (%d,%d), pino = %lu, name:%s, err:%d",
> +		MAJOR(__entry->dev), MINOR(__entry->dev),
> +		(unsigned long)__entry->ino,
> +		__get_str(name),
> +		__entry->err)
> +);
> +
> +#endif /* _TRACE_EXFAT_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> -- 
> 2.35.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
