Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4463CEF46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 00:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389841AbhGSVg6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 17:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1385868AbhGSTOY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626724500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ibg4Lx1brl8A2uQKTgR9ICt6oCv2YJSZ2UO5NpUhpFQ=;
        b=UkFnXWNUiS5zgMdbrj8Nkq9ILulVI40L5rBGmcOzLjRDL+HQw1nSgMlLLT1jC1ouGiOGok
        eehn+3ty1MEW8KUDHNwWnPXAzUHxKpTnbm+PD2BLCfPUIdpdzTzjBtgRjd3tyaOI2OyBGE
        +qIlHT1Ar4BpgFwYgNbJcCarZt6+lBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-XlKDk-YIOO2EesBUIZXWOA-1; Mon, 19 Jul 2021 15:54:58 -0400
X-MC-Unique: XlKDk-YIOO2EesBUIZXWOA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B269A1937FC4;
        Mon, 19 Jul 2021 19:54:57 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-17.rdu2.redhat.com [10.10.118.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEC905D9FC;
        Mon, 19 Jul 2021 19:54:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 24269223E4F; Mon, 19 Jul 2021 15:54:53 -0400 (EDT)
Date:   Mon, 19 Jul 2021 15:54:53 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        bo.liu@linux.alibaba.com, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2 4/4] fuse: support changing per-file DAX flag inside
 guest
Message-ID: <YPXYjcv2wq4ixj/x@redhat.com>
References: <20210716104753.74377-1-jefflexu@linux.alibaba.com>
 <20210716104753.74377-5-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716104753.74377-5-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 06:47:53PM +0800, Jeffle Xu wrote:
> Fuse client can enable or disable per-file DAX inside guest by
> chattr(1). Similarly the new state won't be updated until the file is
> closed and reopened later.
> 
> It is worth nothing that it is a best-effort style, since whether
> per-file DAX is enabled or not is controlled by fuse_attr.flags retrieved
> by FUSE LOOKUP routine, while the algorithm constructing fuse_attr.flags
> is totally fuse server specific, not to mention ioctl may not be
> supported by fuse server at all.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/fuse/ioctl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
> index 546ea3d58fb4..172e05c3f038 100644
> --- a/fs/fuse/ioctl.c
> +++ b/fs/fuse/ioctl.c
> @@ -460,6 +460,7 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
>  	struct fuse_file *ff;
>  	unsigned int flags = fa->flags;
>  	struct fsxattr xfa;
> +	bool newdax;
>  	int err;
>  
>  	ff = fuse_priv_ioctl_prepare(inode);
> @@ -467,10 +468,9 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
>  		return PTR_ERR(ff);
>  
>  	if (fa->flags_valid) {
> +		newdax = flags & FS_DAX_FL;
>  		err = fuse_priv_ioctl(inode, ff, FS_IOC_SETFLAGS,
>  				      &flags, sizeof(flags));
> -		if (err)
> -			goto cleanup;
>  	} else {
>  		memset(&xfa, 0, sizeof(xfa));
>  		xfa.fsx_xflags = fa->fsx_xflags;
> @@ -479,11 +479,14 @@ int fuse_fileattr_set(struct user_namespace *mnt_userns,
>  		xfa.fsx_projid = fa->fsx_projid;
>  		xfa.fsx_cowextsize = fa->fsx_cowextsize;
>  
> +		newdax = fa->fsx_xflags & FS_XFLAG_DAX;
>  		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
>  				      &xfa, sizeof(xfa));
>  	}
>  
> -cleanup:
> +	if (!err && IS_ENABLED(CONFIG_FUSE_DAX))
> +		fuse_dax_dontcache(inode, newdax);

This assumes that server will set ATTR_DAX flag for inode based on
whether inode has FS_DAX_FL set or not.

So that means server first will have to know that client has DAX enabled
so that it can query FS_DAX_FL. And in current framework we don't have
a way for server to know if client is using DAX or not.

I think there is little disconnect here. So either client should be
checking FS_DAX_FL flag on inode. But we probably don't want to pay
extra round trip cost for this. 

That means somehow server should return this information as part of
inode attrs only if client wants this extra file attr informaiton. So
may be GETATTR should be enhanced instead to return file attr information
too if client asked for it?

I have not looked what it takes to implement this. If this is too 
complicated, then alternate approach will be that it is up to the
server to decide what inodes should use DAX and there is no guarantee
that server will make sue of FS_DAX_FL flag. fuse will still support
setting FS_DAX_FL but server could choose to not use it at all. In
that case fuse client will not have to query file attrs in GETATTR
and just rely on ATTR_DAX flag set by server. I think that's what
you are implementing.  If that's the case then dontcache does not make
much sense because you don't even know if server is looking at
FS_DAX_FL to decide whether DAX should be used or not.

Thanks
Vivek

> +
>  	fuse_priv_ioctl_cleanup(inode, ff);
>  
>  	return err;
> -- 
> 2.27.0
> 

