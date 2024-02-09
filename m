Return-Path: <linux-fsdevel+bounces-10912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B000984F396
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2ADD1C22702
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73FF1E534;
	Fri,  9 Feb 2024 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V3c53xZE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467CF1EB36;
	Fri,  9 Feb 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475147; cv=none; b=Re5Yf8OkYGGOkbEU/lJJIjHjOUz1UacscH6Q5eV4cOKhbD3hGvdxGBAec3d19V98P6N0/T9bm62TZxd/oSt9HgK0OLdo+MhrcRUG+7iJd4YOnVaJBROG6yzjRSL5G7TBTj0FWiuzJgj4YjOBCdqx68GXxX8bnduSzNzSQNpmIQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475147; c=relaxed/simple;
	bh=s1wJHIiMI3uS9GjnxpD32C4Cuqb0JxInYNa6ghFQE5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neRb6jj5zrITSPQQAqoI7wijb52GAXRFw/WI5RFuTDejI+qRERkjwnnVQykHm7RDS7Jn4FcItm+OcH8g6Jl7jwI9YstOfewOYq72wtlGcrN5Ln0SyIf5Nf0wjKFWQMh6S57oKCi0iNt/8kyo8bsacVWaRlqZl678KaO/mFycQn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V3c53xZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77224C433F1;
	Fri,  9 Feb 2024 10:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707475146;
	bh=s1wJHIiMI3uS9GjnxpD32C4Cuqb0JxInYNa6ghFQE5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3c53xZEPBSSv86Phr2VXwv+0NWXD5J/A5CwUnkaWA+58tjBc8ZiY8fz7BoGSxd7n
	 sdgcYwT3ytwkeEkyCrtlxk8XQtu3qBg0wXTLls/G0Y/QnhhtXEyQayVO/TaXQPgkP1
	 4TqyDxpP+B2MwVu8i+RT9Na3BsIxQF+po/rrwJAw=
Date: Fri, 9 Feb 2024 10:39:04 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
	gmaglione@redhat.com, virtio-fs@lists.linux.dev, vgoyal@redhat.com,
	mzxreary@0pointer.de, miklos@szeredi.hu
Subject: Re: [PATCH v2 3/3] virtiofs: emit uevents on filesystem events
Message-ID: <2024020943-hedge-majority-ef34@gregkh>
References: <20240208193212.731978-1-stefanha@redhat.com>
 <20240208193212.731978-4-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208193212.731978-4-stefanha@redhat.com>

On Thu, Feb 08, 2024 at 02:32:11PM -0500, Stefan Hajnoczi wrote:
> Alyssa Ross <hi@alyssa.is> requested that virtiofs notifies userspace
> when filesytems become available. This can be used to detect when a
> filesystem with a given tag is hotplugged, for example. uevents allow
> userspace to detect changes without resorting to polling.
> 
> The tag is included as a uevent property so it's easy for userspace to
> identify the filesystem in question even when the sysfs directory goes
> away during removal.
> 
> Here are example uevents:
> 
>   # udevadm monitor -k -p
> 
>   KERNEL[111.113221] add      /fs/virtiofs/2 (virtiofs)
>   ACTION=add
>   DEVPATH=/fs/virtiofs/2
>   SUBSYSTEM=virtiofs
>   TAG=test
> 
>   KERNEL[165.527167] remove   /fs/virtiofs/2 (virtiofs)
>   ACTION=remove
>   DEVPATH=/fs/virtiofs/2
>   SUBSYSTEM=virtiofs
>   TAG=test
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 28e96b7cde00..18a8f531e5d4 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -270,6 +270,17 @@ static void virtio_fs_start_all_queues(struct virtio_fs *fs)
>  	}
>  }
>  
> +static void virtio_fs_uevent(struct virtio_fs *fs, enum kobject_action action)
> +{
> +	char tag_str[sizeof("TAG=") +
> +		     sizeof_field(struct virtio_fs_config, tag) + 1];
> +	char *envp[] = {tag_str, NULL};
> +
> +	snprintf(tag_str, sizeof(tag_str), "TAG=%s", fs->tag);
> +
> +	kobject_uevent_env(&fs->kobj, action, envp);
> +}
> +
>  /* Add a new instance to the list or return -EEXIST if tag name exists*/
>  static int virtio_fs_add_instance(struct virtio_device *vdev,
>  				  struct virtio_fs *fs)
> @@ -309,6 +320,8 @@ static int virtio_fs_add_instance(struct virtio_device *vdev,
>  
>  	mutex_unlock(&virtio_fs_mutex);
>  
> +	virtio_fs_uevent(fs, KOBJ_ADD);

Why do you have to explicitly ask for the event?  Doesn't sysfs trigger
this for you automatically?  Set the kset uevent callback for this,
right?

thanks,

greg k-h

