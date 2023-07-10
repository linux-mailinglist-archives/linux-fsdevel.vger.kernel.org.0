Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAD474D9AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjGJPRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjGJPRH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90001B7;
        Mon, 10 Jul 2023 08:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EEB96105C;
        Mon, 10 Jul 2023 15:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1879C433C8;
        Mon, 10 Jul 2023 15:17:04 +0000 (UTC)
Date:   Mon, 10 Jul 2023 11:17:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zehao Zhang <zhangzehao@vivo.com>
Cc:     linkinjeon@kernel.org, sj1557.seo@samsung.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: Add ftrace support for exfat and add some
 tracepoints
Message-ID: <20230710111703.33bb48c5@gandalf.local.home>
In-Reply-To: <20230710092559.19087-1-zhangzehao@vivo.com>
References: <20230710092559.19087-1-zhangzehao@vivo.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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

Why dereference here and not just use the folio that is passed in?

That will keep the dereferencing logic out of the code path and only happen
when the trace event is enabled.

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

Here you could just pass in mapping and do the dereference in the TP_fast_assign().

> +
>  	return mpage_writepages(mapping, wbc, exfat_get_block);
>  }
>  
> @@ -364,6 +375,7 @@ static int exfat_write_begin(struct file *file, struct address_space *mapping,
>  		loff_t pos, unsigned int len,
>  		struct page **pagep, void **fsdata)
>  {
> +	struct inode *inode = mapping->host;

And here too.

-- Steve

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
