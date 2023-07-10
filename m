Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D32F74DB39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 18:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjGJQhd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 12:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjGJQhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:37:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA80AB;
        Mon, 10 Jul 2023 09:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF80E61119;
        Mon, 10 Jul 2023 16:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D99EC433C7;
        Mon, 10 Jul 2023 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689007048;
        bh=JA1EquXrPGxoYRpIsacqXDoz6GpwP+8rSYei9H/PT+g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jB5VXSU+47cERawOBFzpTrJGdh8LObqXzP/8hseYON/hlIPEtVc4Kfu6N46xRQ/0z
         JplRS+fc9gs/ffoFNdFEt6pmbhnArByt8QSSCcPI4XaKHCmO6jv61yRLrtxP3+KjNQ
         YKeCi+wV0YjlXrpynm30HUY2P1JpWe+phceBCHoZ4J3d83wzDQcBu4fN+BDR9bj3nv
         WTqgrLSHvZFM8Cj6UNcEuwfIpoWR4A6PKUhuP/b4EffXjBwQpnmxQUBaNVAAxU9JqR
         fjS2COpGeO6Lh6/lR2luEBNsllr4NhHOQuuS5FsI6Uqll2UGgpPl3X97Ek6667CFH/
         NdJQYmI7ONPOg==
Date:   Tue, 11 Jul 2023 01:37:23 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Zehao Zhang <zhangzehao@vivo.com>
Cc:     linkinjeon@kernel.org, sj1557.seo@samsung.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: Add ftrace support for exfat and add some
 tracepoints
Message-Id: <20230711013723.1b677cae2870bd509f77babd@kernel.org>
In-Reply-To: <20230710092559.19087-1-zhangzehao@vivo.com>
References: <20230710092559.19087-1-zhangzehao@vivo.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 10 Jul 2023 17:25:59 +0800
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

It seems like most of them are address_space_operations' operators.
Is that OK to define those events (~= user exposed interface) from
exFAT filesystem? I wonder why we can not make a generic VFS events
for those. (Or all FS-wide generic events).

Thank you,

> 
> Signed-off-by: Zehao Zhang <zhangzehao@vivo.com>
> ---
>  MAINTAINERS                  |   1 +
>  fs/exfat/inode.c             |  16 +++
>  fs/exfat/namei.c             |  10 +-
>  include/trace/events/exfat.h | 192 +++++++++++++++++++++++++++++++++++
>  4 files changed, 218 insertions(+), 1 deletion(-)
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
> index 481dd338f2b8..48fec3fa10af 100644
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
> @@ -335,6 +338,10 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
>  
>  static int exfat_read_folio(struct file *file, struct folio *folio)
>  {
> +	struct inode *inode = folio->mapping->host;
> +
> +	trace_exfat_read_folio(inode, folio);
> +
>  	return mpage_read_folio(folio, exfat_get_block);
>  }
>  
> @@ -346,6 +353,10 @@ static void exfat_readahead(struct readahead_control *rac)
>  static int exfat_writepages(struct address_space *mapping,
>  		struct writeback_control *wbc)
>  {
> +	struct inode *inode = mapping->host;
> +
> +	trace_exfat_writepages(inode, wbc);
> +
>  	return mpage_writepages(mapping, wbc, exfat_get_block);
>  }
>  
> @@ -364,6 +375,7 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
>  		loff_t pos, unsigned int len,
>  		struct page **pagep, void **fsdata)
>  {
> +	struct inode *inode = mapping->host;
>  	int ret;
>  
>  	*pagep = NULL;
> @@ -371,6 +383,8 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
>  			       exfat_get_block,
>  			       &EXFAT_I(mapping->host)->i_size_ondisk);
>  
> +	trace_exfat_write_begin(inode, pos, len);
> +
>  	if (ret < 0)
>  		exfat_write_failed(mapping, pos+len);
>  
> @@ -394,6 +408,8 @@ static int exfat_write_end(struct file *file, struct address_space *mapping,
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
> index 000000000000..67ac91c75cc6
> --- /dev/null
> +++ b/include/trace/events/exfat.h
> @@ -0,0 +1,192 @@
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
> +#define show_dev(dev)		(MAJOR(dev), MINOR(dev))
> +#define show_dev_ino(entry)	(show_dev(entry->dev), (unsigned long)entry->ino)
> +
> +
> +TRACE_EVENT(exfat_write_begin,
> +	TP_PROTO(struct inode *inode, loff_t pos, unsigned int len),
> +
> +	TP_ARGS(inode, pos, len),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,        dev)
> +		__field(ino_t,        ino)
> +		__field(loff_t,       pos)
> +		__field(unsigned int, len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev    = inode->i_sb->s_dev;
> +		__entry->ino    = inode->i_ino;
> +		__entry->pos    = pos;
> +		__entry->len    = len;
> +	),
> +
> +	TP_printk("dev (%d,%d) ino %lu pos %lld len %u",
> +		show_dev(__entry->dev),
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
> +		show_dev(__entry->dev),
> +		(unsigned long) __entry->ino,
> +		__entry->pos, __entry->len, __entry->copied)
> +);
> +
> +TRACE_EVENT(exfat_read_folio,
> +	TP_PROTO(struct inode *inode, struct folio *folio),
> +
> +	TP_ARGS(inode, folio),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,	dev)
> +		__field(ino_t,	ino)
> +		__field(pgoff_t, index)
> +
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev	= inode->i_sb->s_dev;
> +		__entry->ino	= inode->i_ino;
> +		__entry->index	= folio->index;
> +	),
> +
> +	TP_printk("dev (%d,%d) ino %lu folio_index %lu",
> +		show_dev(__entry->dev),
> +		(unsigned long) __entry->ino,
> +		(unsigned long) __entry->index)
> +);
> +
> +TRACE_EVENT(exfat_writepages,
> +	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
> +
> +	TP_ARGS(inode, wbc),
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
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->nr_to_write	= wbc->nr_to_write;
> +		__entry->pages_skipped	= wbc->pages_skipped;
> +		__entry->range_start	= wbc->range_start;
> +		__entry->range_end	= wbc->range_end;
> +		__entry->writeback_index = inode->i_mapping->writeback_index;
> +		__entry->sync_mode	= wbc->sync_mode;
> +		__entry->for_kupdate	= wbc->for_kupdate;
> +		__entry->range_cyclic	= wbc->range_cyclic;
> +	),
> +
> +	TP_printk("dev (%d,%d) ino %lu nr_to_write %ld pages_skipped %ld "
> +		"range_start %lld range_end %lld sync_mode %d "
> +		"for_kupdate %d range_cyclic %d writeback_index %lu",
> +		show_dev(__entry->dev),
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
> +		show_dev_ino(__entry),
> +		__get_str(name),
> +		__entry->flags)
> +);
> +
> +TRACE_EVENT(exfat_lookup_end,
> +
> +	TP_PROTO(struct inode *dir, struct dentry *dentry,
> +		int err),
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
> +		show_dev_ino(__entry),
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
