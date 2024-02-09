Return-Path: <linux-fsdevel+bounces-10911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D82784F38A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320D71F28D48
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65CC1B971;
	Fri,  9 Feb 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESa/NnrQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC01CF91;
	Fri,  9 Feb 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707475011; cv=none; b=OZivqo/aN1a0xfEHCtX/Vfiyf6obXt2ZT1dFBJm61+IKSxKECYsXrn7f9LtEmkV+cfJC8zGvds7sHwVRKgNlLwJgBen+WU1BWIfMW5+ZfSoUbKB5Ahe+wspvtrSlmFsW9ESyqSg67Wm6zUhrYDUK2jQTf3uir0iBaGaWwkuESko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707475011; c=relaxed/simple;
	bh=jwvoSxSJWkh+cKwiJMwZMN7tCeY1C4UOfpI98al0t2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UseHf5n31tVi2JrQLL3euIh0oh/ndoJEY5lV8V1WVcsCAUJEqHYPKo6dbebLaf8qL/+VghQ9EVJkmZRxbaR24arkHe1mtwyMZQHqKPRhB/gDB0YL3L94jOOsXaZDJ5tgRF7u+0Q04Cn0/jzi9AcUpUftfIeEWFXIJDNWUo4kWFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESa/NnrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D2DC433C7;
	Fri,  9 Feb 2024 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707475010;
	bh=jwvoSxSJWkh+cKwiJMwZMN7tCeY1C4UOfpI98al0t2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESa/NnrQ8Wv3W1VjXJIWQoK/V9aOkZqMV6XtlqbuO2rCYDvZcByHLkXqFYTB9ey0N
	 QD/p/E0XpLoOT0h2yWM9BFnpaqH5cXC+lSxwqBjmz79Mmp32EZnywzwL5+M5d1k+JR
	 tbTdfTxggKaYRjMNLHmpnwYwiupOnZqtp6rRFOjM=
Date: Fri, 9 Feb 2024 10:36:47 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
	gmaglione@redhat.com, virtio-fs@lists.linux.dev, vgoyal@redhat.com,
	mzxreary@0pointer.de, miklos@szeredi.hu
Subject: Re: [PATCH v2 2/3] virtiofs: export filesystem tags through sysfs
Message-ID: <2024020940-stinking-encrust-3754@gregkh>
References: <20240208193212.731978-1-stefanha@redhat.com>
 <20240208193212.731978-3-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208193212.731978-3-stefanha@redhat.com>

On Thu, Feb 08, 2024 at 02:32:10PM -0500, Stefan Hajnoczi wrote:
> The virtiofs filesystem is mounted using a "tag" which is exported by
> the virtiofs device:
> 
>   # mount -t virtiofs <tag> /mnt
> 
> The virtiofs driver knows about all the available tags but these are
> currently not exported to user space.
> 
> People have asked for these tags to be exported to user space. Most
> recently Lennart Poettering has asked for it as he wants to scan the
> tags and mount virtiofs automatically in certain cases.
> 
> https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> 
> This patch exports tags at /sys/fs/virtiofs/<N>/tag where N is the id of
> the virtiofs device. The filesystem tag can be obtained by reading this
> "tag" file.
> 
> There is also a symlink at /sys/fs/virtiofs/<N>/device that points to
> the virtiofs device that exports this tag.
> 
> This patch converts the existing struct virtio_fs into a full kobject.
> It already had a refcount so it's an easy change. The virtio_fs objects
> can then be exposed in a kset at /sys/fs/virtiofs/. Note that virtio_fs
> objects may live slightly longer than we wish for them to be exposed to
> userspace, so kobject_del() is called explicitly when the underlying
> virtio_device is removed. The virtio_fs object is freed when all
> references are dropped (e.g. active mounts) but disappears as soon as
> the virtiofs device is gone.
> 
> Originally-by: Vivek Goyal <vgoyal@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  fs/fuse/virtio_fs.c                         | 113 ++++++++++++++++----
>  Documentation/ABI/testing/sysfs-fs-virtiofs |  11 ++
>  2 files changed, 103 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-fs-virtiofs
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index de9a38efdf1e..28e96b7cde00 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -31,6 +31,9 @@
>  static DEFINE_MUTEX(virtio_fs_mutex);
>  static LIST_HEAD(virtio_fs_instances);
>  
> +/* The /sys/fs/virtio_fs/ kset */
> +static struct kset *virtio_fs_kset;
> +
>  enum {
>  	VQ_HIPRIO,
>  	VQ_REQUEST
> @@ -55,7 +58,7 @@ struct virtio_fs_vq {
>  
>  /* A virtio-fs device instance */
>  struct virtio_fs {
> -	struct kref refcount;
> +	struct kobject kobj;
>  	struct list_head list;    /* on virtio_fs_instances */
>  	char *tag;
>  	struct virtio_fs_vq *vqs;
> @@ -161,18 +164,43 @@ static inline void dec_in_flight_req(struct virtio_fs_vq *fsvq)
>  		complete(&fsvq->in_flight_zero);
>  }
>  
> -static void release_virtio_fs_obj(struct kref *ref)
> +static ssize_t virtio_fs_tag_attr_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
>  {
> -	struct virtio_fs *vfs = container_of(ref, struct virtio_fs, refcount);
> +	struct virtio_fs *fs = container_of(kobj, struct virtio_fs, kobj);
> +
> +	return sysfs_emit(buf, fs->tag);
> +}
> +
> +static struct kobj_attribute virtio_fs_tag_attr = {
> +	.attr = { .name = "tag", .mode= 0644 },
> +	.show = virtio_fs_tag_attr_show,
> +};

__ATTR_RO()?
That way we all know you got the mode setting correct :)

Other than that minor thing, looks good, nice job!

greg k-h

