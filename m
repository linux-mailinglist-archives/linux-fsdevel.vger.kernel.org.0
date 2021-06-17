Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A913AB98F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 18:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhFQQ2V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 12:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhFQQ2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:28:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623947173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YHaYKbSQCSs+IkcHGYTNjMBqubkgrIZAEznhO8tVtjw=;
        b=DCfJUamOYhPtSZc4+PenfI44tMeGTgGdjW2EvFNKooF1+DnpN1CQ3Vd87WVUPI/tLU09BX
        7UhipgERlqw0112C0SKaTXs//PcFxdw4Y2zIwSdxtyJM59TAywGNurBTdUsBR3mOvmtHcR
        Xz3df9qaTLIzQ2LJjoNMXXVA/qsp6pM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-HWgQe1-KNJuHVC402lIziQ-1; Thu, 17 Jun 2021 12:26:11 -0400
X-MC-Unique: HWgQe1-KNJuHVC402lIziQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD87E107ACF6;
        Thu, 17 Jun 2021 16:26:10 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-162.rdu2.redhat.com [10.10.116.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B02E45C1BB;
        Thu, 17 Jun 2021 16:26:10 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 4B9D1220BCF; Thu, 17 Jun 2021 12:26:10 -0400 (EDT)
Date:   Thu, 17 Jun 2021 12:26:10 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: Re: [PATCH 2/2] init: allow mounting arbitrary non-blockdevice
 filesystems as root
Message-ID: <20210617162610.GC1142820@redhat.com>
References: <20210617153649.1886693-1-hch@lst.de>
 <20210617153649.1886693-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617153649.1886693-3-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 05:36:49PM +0200, Christoph Hellwig wrote:

[..]
> +static int __init try_mount_nodev(char *fstype)
> +{
> +	struct file_system_type *fs = get_fs_type(fstype);
> +	int err = -EINVAL;
> +
> +	if (!fs)
> +		return -EINVAL;
> +	if (!(fs->fs_flags & (FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA)))

Not sure what FS_BINARY_MOUNTDATA is why fs should not have that set. nfs
seems to set it too. So that means they can't use try_mount_nodev().

> +		err = do_mount_root(root_device_name, fstype, root_mountflags,
> +					root_mount_data);
> +	put_filesystem(fs);
> +
> +	if (err != -EACCES && err != -EINVAL)

In case of success err == 0, but we still panic(). We will need to
check for success as well.
	if (err && err != -EACCES && err != -EINVAL)

> +		panic("VFS: Unable to mount root \"%s\" (%s), err=%d\n",
> +			      root_device_name, fstype, err);
> +	return err;
> +}
> +
> +static int __init mount_nodev_root(void)
> +{
> +	char *fs_names, *p;
> +	int err = -EINVAL;
> +
> +	fs_names = (void *)__get_free_page(GFP_KERNEL);
> +	if (!fs_names)
> +		return -EINVAL;
> +	split_fs_names(fs_names, root_fs_names);

root_fs_names can be NULL and it crashes with NULL pointer dereference.

Vivek

> +
> +	for (p = fs_names; *p; p += strlen(p) + 1) {
> +		err = try_mount_nodev(p);
> +		if (!err)
> +			break;
> +	}
> +
> +	free_page((unsigned long)fs_names);
> +	return err;
> +}
> +
>  void __init mount_root(void)
>  {
>  #ifdef CONFIG_ROOT_NFS
> @@ -550,6 +588,8 @@ void __init mount_root(void)
>  		return;
>  	}
>  #endif
> +	if (ROOT_DEV == 0 && mount_nodev_root() == 0)
> +		return;
>  #ifdef CONFIG_BLOCK
>  	{
>  		int err = create_dev("/dev/root", ROOT_DEV);
> -- 
> 2.30.2
> 

