Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB93ACD32
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhFRONH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 10:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37383 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231877AbhFRONE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 10:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624025454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ajv9GHZqwhwdqHmInEP3t514hzTn+CylcSgzTQPjYrk=;
        b=LOErCS6Zv1mCHF5RO+Vp8M3ZMzIn2gV00N6DNhzpd+U9KchaneW+g3AwjkEA/LyQL2/lfp
        Fo43BfYhlDnpngsJ0+evTtYQ2XhwBbitlZwSt9+ZLDCvq0hfha5Bcty3iI39XKeU0W8qsL
        XXMbu4tZuODfqM892SQACeDaLlj9tQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-ziznzbOoNd6RDq0QxqqqLA-1; Fri, 18 Jun 2021 10:10:45 -0400
X-MC-Unique: ziznzbOoNd6RDq0QxqqqLA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5E8E801B33;
        Fri, 18 Jun 2021 14:10:43 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-2.rdu2.redhat.com [10.10.114.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B3060BE5;
        Fri, 18 Jun 2021 14:10:31 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2E22722054F; Fri, 18 Jun 2021 10:10:31 -0400 (EDT)
Date:   Fri, 18 Jun 2021 10:10:31 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 2/2] init: allow mounting arbitrary non-blockdevice
 filesystems as root
Message-ID: <20210618141031.GC1234055@redhat.com>
References: <20210617153649.1886693-1-hch@lst.de>
 <20210617153649.1886693-3-hch@lst.de>
 <20210617162610.GC1142820@redhat.com>
 <20210618132038.GA13406@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618132038.GA13406@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 03:20:38PM +0200, Christoph Hellwig wrote:
> On Thu, Jun 17, 2021 at 12:26:10PM -0400, Vivek Goyal wrote:
> > Not sure what FS_BINARY_MOUNTDATA is why fs should not have that set. nfs
> > seems to set it too. So that means they can't use try_mount_nodev().
> 
> We can't really pass actual binary mountdata using the string separation
> scheme used by the rootfstype= option.  But given that NFS only uses
> binary mountdata for legacy reasons and people get what they ask for
> using the option I think we can drop the check.
> 
> > In case of success err == 0, but we still panic(). We will need to
> > check for success as well.
> 
> Indeed.
> 
> > root_fs_names can be NULL and it crashes with NULL pointer dereference.
> 
> True.
> 
> What do you think of this version?

[ Cc Dominique Martinet ]

Hi Christoph,

This one works well for me. Just one minor nit. root_device_name, can
be NULL as well if user passes following.

"rootfstype=virtiofs rw".

And currently mount_nodev_root() is assuming root_device_name is not NULL
and we crash with null pointer dereference.

May be something like this.

        if (ROOT_DEV == 0 && root_device_name && root_fs_names) {
                if (mount_nodev_root() == 0)
                        return;
        }

Strangely people are using "rootfstype=virtiofs rw" to mount virtiofs
as rootfs. They give their filesystem a tag named "/dev/root". And
currently it works and they can mount virtiofs as rootfs.

With above change, current hackish way will also continue to work and
not break existing setups.

Thanks
Vivek

> 
> ---
> From 141caa79a619b5f5d100eeb8e94ecf8b3b1c9af7 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 18 Jun 2021 15:10:39 +0200
> Subject: init: allow mounting arbitrary non-blockdevice filesystems as root
> 
> Currently the only non-blockdevice filesystems that can be used as the
> initial root filesystem are NFS and CIFS, which use the magic
> "root=/dev/nfs" and "root=/dev/cifs" syntax that requires the root
> device file system details to come from filesystem specific kernel
> command line options.
> 
> Add a little bit of new code that allows to just pass arbitrary
> string mount options to any non-blockdevice filesystems so that it can
> be mounted as the root file system.
> 
> For example a virtiofs root file system can be mounted using the
> following syntax:
> 
> "root=myfs rootfstype=virtiofs rw"
> 
> Based on an earlier patch from Vivek Goyal <vgoyal@redhat.com>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  init/do_mounts.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index ec32de3ad52b..66c47193e9ee 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -534,6 +534,45 @@ static int __init mount_cifs_root(void)
>  }
>  #endif
>  
> +static bool __init fs_is_nodev(char *fstype)
> +{
> +	struct file_system_type *fs = get_fs_type(fstype);
> +	bool ret = false;
> +
> +	if (fs) {
> +		ret = !(fs->fs_flags & FS_REQUIRES_DEV);
> +		put_filesystem(fs);
> +	}
> +
> +	return ret;
> +}
> +
> +static int __init mount_nodev_root(void)
> +{
> +	char *fs_names, *fstype;
> +	int err = -EINVAL;
> +
> +	fs_names = (void *)__get_free_page(GFP_KERNEL);
> +	if (!fs_names)
> +		return -EINVAL;
> +	split_fs_names(fs_names, root_fs_names);
> +
> +	for (fstype = fs_names; *fstype; fstype += strlen(fstype) + 1) {
> +		if (!fs_is_nodev(fstype))
> +			continue;
> +		err = do_mount_root(root_device_name, fstype, root_mountflags,
> +				    root_mount_data);
> +		if (!err)
> +			break;
> +		if (err != -EACCES && err != -EINVAL)
> +			panic("VFS: Unable to mount root \"%s\" (%s), err=%d\n",
> +			      root_device_name, fstype, err);
> +	}
> +
> +	free_page((unsigned long)fs_names);
> +	return err;
> +}
> +
>  void __init mount_root(void)
>  {
>  #ifdef CONFIG_ROOT_NFS
> @@ -550,6 +589,10 @@ void __init mount_root(void)
>  		return;
>  	}
>  #endif
> +	if (ROOT_DEV == 0 && root_fs_names) {
> +		if (mount_nodev_root() == 0)
> +			return;
> +	}
>  #ifdef CONFIG_BLOCK
>  	{
>  		int err = create_dev("/dev/root", ROOT_DEV);
> -- 
> 2.30.2
> 

