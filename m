Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDFBB4733AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 19:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbhLMSLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 13:11:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236073AbhLMSLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639419074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hczmCIea7+uhOauPWihXRpfam+3iNuYFj3CcV7sO6T8=;
        b=dQ6U7NgrPptPIUMgn4ROJtiwy2SxfXmjBrHebqz7fWednygnEqg+DfJ2mKxZC0TH2ACugy
        V4VTR7JD1apbM3qZP6mHUiTTGeHzJkVoIjEvv3mYePcEMHlDoHk56Wl+SWBX/6Rf0WdMbk
        PoFS42UiP/A+4QqN6F4MNPWyTQ11/UM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-Zl-Mb0q3P1KYx80W9nXiaw-1; Mon, 13 Dec 2021 13:11:10 -0500
X-MC-Unique: Zl-Mb0q3P1KYx80W9nXiaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2CD2801ADC;
        Mon, 13 Dec 2021 18:11:09 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.17.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9DFF24ABA2;
        Mon, 13 Dec 2021 18:11:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id CDD312233DF; Mon, 13 Dec 2021 13:11:08 -0500 (EST)
Date:   Mon, 13 Dec 2021 13:11:08 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     stefanha@redhat.com, miklos@szeredi.hu, virtio-fs@redhat.com,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v8 7/7] Documentation/filesystem/dax: DAX on virtiofs
Message-ID: <YbeMvKVmzUwmrZhC@redhat.com>
References: <20211125070530.79602-1-jefflexu@linux.alibaba.com>
 <20211125070530.79602-8-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125070530.79602-8-jefflexu@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 03:05:30PM +0800, Jeffle Xu wrote:
> Record DAX on virtiofs and the semantic difference with that on ext4
> and xfs.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  Documentation/filesystems/dax.rst | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
> index 9a1b8fd9e82b..e3b30429d703 100644
> --- a/Documentation/filesystems/dax.rst
> +++ b/Documentation/filesystems/dax.rst
> @@ -23,8 +23,8 @@ on it as usual.  The `DAX` code currently only supports files with a block
>  size equal to your kernel's `PAGE_SIZE`, so you may need to specify a block
>  size when creating the filesystem.
>  
> -Currently 3 filesystems support `DAX`: ext2, ext4 and xfs.  Enabling `DAX` on them
> -is different.
> +Currently 4 filesystems support `DAX`: ext2, ext4, xfs and virtiofs.
> +Enabling `DAX` on them is different.
>  
>  Enabling DAX on ext2
>  --------------------
> @@ -168,6 +168,22 @@ if the underlying media does not support dax and/or the filesystem is
>  overridden with a mount option.
>  
>  
> +Enabling DAX on virtiofs
> +----------------------------
> +The semantic of DAX on virtiofs is basically equal to that on ext4 and xfs,
> +except that when '-o dax=inode' is specified, virtiofs client derives the hint
> +whether DAX shall be enabled or not from virtiofs server through FUSE protocol,
> +rather than the persistent `FS_XFLAG_DAX` flag. That is, whether DAX shall be
> +enabled or not is completely determined by virtiofs server, while virtiofs
> +server itself may deploy various algorithm making this decision, e.g. depending
> +on the persistent `FS_XFLAG_DAX` flag on the host.
> +
> +It is still supported to set or clear persistent `FS_XFLAG_DAX` flag inside
> +guest, but it is not guaranteed that DAX will be enabled or disabled for
> +corresponding file then. Users inside guest still need to call statx(2) and
> +check the statx flag `STATX_ATTR_DAX` to see if DAX is enabled for this file.
> +
> +
>  Implementation Tips for Block Driver Writers
>  --------------------------------------------
>  
> -- 
> 2.27.0
> 

