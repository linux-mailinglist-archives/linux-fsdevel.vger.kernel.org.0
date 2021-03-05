Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F4E32EC47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 14:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhCENej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Mar 2021 08:34:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41303 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229759AbhCENeS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614951258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lztWhIhyeRU9+BT8ofsmCpcqB35EVmEZjLzkfBjUb6E=;
        b=hrrsDDBodmn4Ha+sIemJAuEYetirc9b2Ijn4MB66tiLUHq5abWFIH0zR5uDDdKw1KcC139
        duaHjouWFSWxoT3yBTDYbOmM34bqhjV3kz+zI3MoVXe1P8izBvIarWI3f4UUeJPsqgWilu
        Km1lb0FdmuXGGJd4pfcd61gp7186QnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-9MCDCRbcNre70QVfB3xJ9A-1; Fri, 05 Mar 2021 08:34:16 -0500
X-MC-Unique: 9MCDCRbcNre70QVfB3xJ9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D25E83DD20;
        Fri,  5 Mar 2021 13:34:15 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-238.rdu2.redhat.com [10.10.113.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 511795D9C0;
        Fri,  5 Mar 2021 13:34:02 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4268D220BCF; Fri,  5 Mar 2021 08:34:01 -0500 (EST)
Date:   Fri, 5 Mar 2021 08:34:01 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofs: Fail dax mount if device does not support it
Message-ID: <20210305133401.GA109162@redhat.com>
References: <20210209224754.GG3171@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209224754.GG3171@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 05:47:54PM -0500, Vivek Goyal wrote:
> Right now "mount -t virtiofs -o dax myfs /mnt/virtiofs" succeeds even
> if filesystem deivce does not have a cache window and hence DAX can't
> be supported.
> 
> This gives a false sense to user that they are using DAX with virtiofs
> but fact of the matter is that they are not.
> 
> Fix this by returning error if dax can't be supported and user has asked
> for it.

Hi Miklos,

Did you get a chance to look at this patch.

Vivek

> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  fs/fuse/virtio_fs.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> Index: redhat-linux/fs/fuse/virtio_fs.c
> ===================================================================
> --- redhat-linux.orig/fs/fuse/virtio_fs.c	2021-02-04 10:40:21.704370721 -0500
> +++ redhat-linux/fs/fuse/virtio_fs.c	2021-02-09 15:56:45.693653979 -0500
> @@ -1324,8 +1324,15 @@ static int virtio_fs_fill_super(struct s
>  
>  	/* virtiofs allocates and installs its own fuse devices */
>  	ctx->fudptr = NULL;
> -	if (ctx->dax)
> +	if (ctx->dax) {
> +		if (!fs->dax_dev) {
> +			err = -EINVAL;
> +			pr_err("virtio-fs: dax can't be enabled as filesystem"
> +			       " device does not support it.\n");
> +			goto err_free_fuse_devs;
> +		}
>  		ctx->dax_dev = fs->dax_dev;
> +	}
>  	err = fuse_fill_super_common(sb, ctx);
>  	if (err < 0)
>  		goto err_free_fuse_devs;

