Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957603AB4C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 15:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhFQNdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 09:33:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232327AbhFQNdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623936665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMovp/d/024BNKenOEssFH9bGIj4wb2wQ+scwOxwK/o=;
        b=RnYGCoirfJLXSfbmUxVdJBXIAD/axBjOwi9Fxigui1gVwR48qoMFhT0v4U0/3FiKutDJBm
        pcm01wEFYDpimV7MqohYhHXpbkSj/Xv+R5ON7Cw3EaIYVjjwpCDoxSLdLsKTqO6T5wZh4N
        Pdm07HYkczFZu0L7yMIRFgwNGseQa9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-Bpa5gYRbOL-FXBAJ9jWMlw-1; Thu, 17 Jun 2021 09:31:02 -0400
X-MC-Unique: Bpa5gYRbOL-FXBAJ9jWMlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10775192FDA8;
        Thu, 17 Jun 2021 13:31:01 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-162.rdu2.redhat.com [10.10.116.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F58A62462;
        Thu, 17 Jun 2021 13:30:53 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id E8277220BCF; Thu, 17 Jun 2021 09:30:52 -0400 (EDT)
Date:   Thu, 17 Jun 2021 09:30:52 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        richard.weinberger@gmail.com, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2 0/2] Add support to boot virtiofs and 9pfs as rootfs
Message-ID: <20210617133052.GA1142820@redhat.com>
References: <20210614174454.903555-1-vgoyal@redhat.com>
 <YMsgaPS90iKIqSvi@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMsgaPS90iKIqSvi@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:14:00AM +0100, Christoph Hellwig wrote:
> Why not something like the version below that should work for all nodev
> file systems?

Hi Christoph,

Thanks for this patch. It definitely looks much better. I had a fear
of breaking something if I were to go through this path of using
FS_REQUIRES_DEV.

This patch works for me with "root=myfs rootfstype=virtiofs rw". Have
few thoughts inline.
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index 74aede860de7..3c5676603fef 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -530,6 +530,39 @@ static int __init mount_cifs_root(void)
>  }
>  #endif
>  
> +static int __init mount_nodev_root(void)
> +{
> +	struct file_system_type *fs = get_fs_type(root_fs_names);

get_fs_type() assumes root_fs_names is not null. So if I pass
"root=myfs rw", it crashes with null pointer dereference.


> +	char *fs_names, *p;
> +	int err = -ENODEV;
> +
> +	if (!fs)
> +		goto out;
> +	if (fs->fs_flags & FS_REQUIRES_DEV)
> +		goto out_put_filesystem;
> +
> +	fs_names = (void *)__get_free_page(GFP_KERNEL);
> +	if (!fs_names)
> +		goto out_put_filesystem;
> +	get_fs_names(fs_names);

I am wondering what use case we are trying to address by calling
get_fs_names() and trying do_mount_root() on all filesystems
returned by get_fs_names(). I am assuming following use cases
you have in mind.

A. User passes a single filesystem in rootfstype.
   
   root=myfs rootfstype=virtiofs rw

B. User passes multiple filesystems in rootfstype and kernel tries all
   of them one after the other

   root=myfs, rootfstype=9p,virtiofs rw

C. User does not pass a filesystem type at all. And kernel will get a
   list of in-built filesystems and will try these one after the other.

   root=myfs rw

If that's the thought, will it make sense to call get_fs_names() first
and then inside the for loop call get_fs_type() and try mounting
only if FS_REQUIRES_DEV is not set, otherwise skip and move onto th
next filesystem in the list (fs_names).

Thanks
Vivek

> +
> +	for (p = fs_names; *p; p += strlen(p) + 1) {
> +		err = do_mount_root(root_device_name, p, root_mountflags,
> +					root_mount_data);
> +		if (!err)
> +			break;
> +		if (err != -EACCES && err != -EINVAL)
> +			panic("VFS: Unable to mount root \"%s\" (%s), err=%d\n",
> +				      root_device_name, p, err);
> +	}
> +
> +	free_page((unsigned long)fs_names);
> +out_put_filesystem:
> +	put_filesystem(fs);
> +out:
> +	return err;
> +}
> +
>  void __init mount_root(void)
>  {
>  #ifdef CONFIG_ROOT_NFS
> @@ -546,6 +579,8 @@ void __init mount_root(void)
>  		return;
>  	}
>  #endif
> +	if (ROOT_DEV == 0 && mount_nodev_root() == 0)
> +		return;
>  #ifdef CONFIG_BLOCK
>  	{
>  		int err = create_dev("/dev/root", ROOT_DEV);
> 

