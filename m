Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8667B3F81
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 10:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjI3Imf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 04:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3Imf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:42:35 -0400
X-Greylist: delayed 1796 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Sep 2023 01:42:29 PDT
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E91A5;
        Sat, 30 Sep 2023 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=fUruxNtcRvEU1JZvILE4i5OuTvYHFqE/tEektqUKj20=; b=J4v58+xlZ2JKkK9o1WatUARvRe
        4FxNcdBrwk36Z+/z0fKujXMVEe806lnjOpNLo50lxYEgIx5Ii/FdSTa/wxK1LjgRegNd96CbqiXle
        DpHI4zu7fAwTAn7Ak48c5DASwnB2aC0P5CNTbeJAyd1TzQzAvimtkMpD688dN5Lq5Wh3LsW1LDNQ6
        xmxs1FoDC6/8VsHBO8tQDFqktSuohy/oS2TClmoL+xIaq0mwZzcOyHQmH01MhPQ31ezVfWhw8z6wx
        CQ+nsZ0GGJ1/gTgQ5gPtzWjMC1GBshn/6QZLjprJ2yg4RgvUUInsafD3Np1qCRqAadqnTMq1LbPXL
        k1IOyfN9uJbwpqzUVrcH08iUaH3SbanBKe1j2sbNJ/ZhDVOyG/nH2qp6p1eutk/p93l69fdibtoZm
        Cz5J25Q8LtbOgA/Bh1/7uZwgAqAaCuUdg58DNUhgr+u4udlozVYwbwRASLV44foNEnl/2+ScS/1qb
        I1M0pGIJ0NoY8WRrL5IlYkxAVx5CqmTFExsA5NmsKnppyhzPiSZ+1Ujx//FiIhrFfXSE6ElX/c2J8
        O5uKDUIMDYkgFCKwW8Xjf7Y7tk1iJ0d5dEzn8ya6ea3CwI8Ydh0q41VkFldljKbpQ+nyFnqrJNllS
        1q0eijrY3YKfMuchLIYKWi9Czz4SaCTHr1SxGgPQ4=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        v9fs@lists.linux.dev
Subject: Re: [PATCH 03/29] 9p: move xattr-related structs to .rodata
Date:   Sat, 30 Sep 2023 10:12:25 +0200
Message-ID: <41368837.HejemxxR3G@silver>
In-Reply-To: <20230930050033.41174-4-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
 <20230930050033.41174-4-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Saturday, September 30, 2023 7:00:07 AM CEST Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This makes it harder for accidental or malicious changes to
> v9fs_xattr_user_handler, v9fs_xattr_trusted_handler,
> v9fs_xattr_security_handler, or v9fs_xattr_handlers at runtime.
> 
> Cc: Eric Van Hensbergen <ericvh@kernel.org>
> Cc: Latchesar Ionkov <lucho@ionkov.net>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> Cc: v9fs@lists.linux.dev
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>

> ---
>  fs/9p/xattr.c | 8 ++++----
>  fs/9p/xattr.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index e00cf8109b3f..053d1cef6e13 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -162,27 +162,27 @@ static int v9fs_xattr_handler_set(const struct xattr_handler *handler,
>  	return v9fs_xattr_set(dentry, full_name, value, size, flags);
>  }
>  
> -static struct xattr_handler v9fs_xattr_user_handler = {
> +static const struct xattr_handler v9fs_xattr_user_handler = {
>  	.prefix	= XATTR_USER_PREFIX,
>  	.get	= v9fs_xattr_handler_get,
>  	.set	= v9fs_xattr_handler_set,
>  };
>  
> -static struct xattr_handler v9fs_xattr_trusted_handler = {
> +static const struct xattr_handler v9fs_xattr_trusted_handler = {
>  	.prefix	= XATTR_TRUSTED_PREFIX,
>  	.get	= v9fs_xattr_handler_get,
>  	.set	= v9fs_xattr_handler_set,
>  };
>  
>  #ifdef CONFIG_9P_FS_SECURITY
> -static struct xattr_handler v9fs_xattr_security_handler = {
> +static const struct xattr_handler v9fs_xattr_security_handler = {
>  	.prefix	= XATTR_SECURITY_PREFIX,
>  	.get	= v9fs_xattr_handler_get,
>  	.set	= v9fs_xattr_handler_set,
>  };
>  #endif
>  
> -const struct xattr_handler *v9fs_xattr_handlers[] = {
> +const struct xattr_handler * const v9fs_xattr_handlers[] = {
>  	&v9fs_xattr_user_handler,
>  	&v9fs_xattr_trusted_handler,
>  #ifdef CONFIG_9P_FS_SECURITY
> diff --git a/fs/9p/xattr.h b/fs/9p/xattr.h
> index b5636e544c8a..3ad5a802352a 100644
> --- a/fs/9p/xattr.h
> +++ b/fs/9p/xattr.h
> @@ -10,7 +10,7 @@
>  #include <net/9p/9p.h>
>  #include <net/9p/client.h>
>  
> -extern const struct xattr_handler *v9fs_xattr_handlers[];
> +extern const struct xattr_handler * const v9fs_xattr_handlers[];
>  
>  ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
>  			   void *buffer, size_t buffer_size);
> 


