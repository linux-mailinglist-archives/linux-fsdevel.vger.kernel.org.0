Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079D118F401
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 13:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCWMCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 08:02:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:41110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgCWMCH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:02:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 410FFAE70;
        Mon, 23 Mar 2020 12:02:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8A8D1E10DA; Mon, 23 Mar 2020 13:02:04 +0100 (CET)
Date:   Mon, 23 Mar 2020 13:02:04 +0100
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH] ext2: fix empty body warnings when -Wextra is used
Message-ID: <20200323120204.GB28951@quack2.suse.cz>
References: <e18a7395-61fb-2093-18e8-ed4f8cf56248@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e18a7395-61fb-2093-18e8-ed4f8cf56248@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 22-03-20 19:45:41, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> When EXT2_ATTR_DEBUG is not defined, modify the 2 debug macros
> to use the no_printk() macro instead of <nothing>.
> This fixes gcc warnings when -Wextra is used:
> 
> ../fs/ext2/xattr.c:252:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../fs/ext2/xattr.c:258:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../fs/ext2/xattr.c:330:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../fs/ext2/xattr.c:872:45: warning: suggest braces around empty body in an ‘else’ statement [-Wempty-body]
> 
> I have verified that the only object code change (with gcc 7.5.0) is
> the reversal of some instructions from 'cmp a,b' to 'cmp b,a'.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org

Thanks! I've queued the patch to my tree.

								Honza

> ---
>  fs/ext2/xattr.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200320.orig/fs/ext2/xattr.c
> +++ linux-next-20200320/fs/ext2/xattr.c
> @@ -56,6 +56,7 @@
>  
>  #include <linux/buffer_head.h>
>  #include <linux/init.h>
> +#include <linux/printk.h>
>  #include <linux/slab.h>
>  #include <linux/mbcache.h>
>  #include <linux/quotaops.h>
> @@ -84,8 +85,8 @@
>  		printk("\n"); \
>  	} while (0)
>  #else
> -# define ea_idebug(f...)
> -# define ea_bdebug(f...)
> +# define ea_idebug(inode, f...)	no_printk(f)
> +# define ea_bdebug(bh, f...)	no_printk(f)
>  #endif
>  
>  static int ext2_xattr_set2(struct inode *, struct buffer_head *,
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
