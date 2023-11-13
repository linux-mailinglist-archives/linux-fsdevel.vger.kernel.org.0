Return-Path: <linux-fsdevel+bounces-2809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC0C7EA6E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 00:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37AF2810E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Nov 2023 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2307D3D984;
	Mon, 13 Nov 2023 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx7OBwGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DB3D973
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 23:19:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2BC99
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Nov 2023 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699917582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r5OW3UvdkaMZAdupZ2Vz/uah3y7nvsgWQznOEIBp+WY=;
	b=Lx7OBwGW5HAzQlMS2hleIt1N9Csv3NUyaxLZP0Ohf4+TjXbmYo2I06DFZTi8YovfCFaxmf
	0clHCAO5nhi6iCQ4wGUkR3+R3cKIBQmkSHj9mg2YfwQgJkeaaGt25yznwdbCB4HSov6KLd
	DA3JLSDCWoS2Nm75Fy4yey0PZfv7xZc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Kk0jHHuzOFa1hrTPJ6fY1Q-1; Mon, 13 Nov 2023 18:19:40 -0500
X-MC-Unique: Kk0jHHuzOFa1hrTPJ6fY1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17443810FC0;
	Mon, 13 Nov 2023 23:19:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.17.204])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C298A2026D4C;
	Mon, 13 Nov 2023 23:19:39 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id 3814022CE0A; Mon, 13 Nov 2023 18:19:39 -0500 (EST)
Date: Mon, 13 Nov 2023 18:19:39 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, mzxreary@0pointer.de,
	gmaglione@redhat.com, hi@alyssa.is
Subject: Re: [PATCH v2] virtiofs: Export filesystem tags through sysfs
Message-ID: <ZVKvC0F1PSwqrACn@redhat.com>
References: <20231108213333.132599-1-vgoyal@redhat.com>
 <20231109012825.GB1101655@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109012825.GB1101655@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Thu, Nov 09, 2023 at 09:28:25AM +0800, Stefan Hajnoczi wrote:
> On Wed, Nov 08, 2023 at 04:33:33PM -0500, Vivek Goyal wrote:
> > virtiofs filesystem is mounted using a "tag" which is exported by the
> > virtiofs device. virtiofs driver knows about all the available tags but
> > these are not exported to user space.
> > 
> > People have asked these tags to be exported to user space. Most recently
> > Lennart Poettering has asked for it as he wants to scan the tags and mount
> > virtiofs automatically in certain cases.
> > 
> > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> > 
> > This patch exports tags through sysfs. One tag is associated with each
> > virtiofs device. A new "tag" file appears under virtiofs device dir.
> > Actual filesystem tag can be obtained by reading this "tag" file.
> > 
> > For example, if a virtiofs device exports tag "myfs", a new file "tag"
> > will show up here. Tag has a newline char at the end.
> > 
> > /sys/bus/virtio/devices/virtio<N>/tag
> > 
> > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > myfs
> > 
> > Note, tag is available at KOBJ_BIND time and not at KOBJ_ADD event time.
> > 
> > v2:
> > - Add a newline char at the end in tag file. (Alyssa Ross)
> > - Add a line in commit logs about tag file being available at KOBJ_BIND
> >   time and not KOBJ_ADD time.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 5f1be1da92ce..9f76c9697e6f 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -107,6 +107,21 @@ static const struct fs_parameter_spec virtio_fs_parameters[] = {
> >  	{}
> >  };
> >  
> > +/* Forward Declarations */
> > +static void virtio_fs_stop_all_queues(struct virtio_fs *fs);
> > +
> > +/* sysfs related */
> > +static ssize_t tag_show(struct device *dev, struct device_attribute *attr,
> > +			char *buf)
> > +{
> > +	struct virtio_device *vdev = container_of(dev, struct virtio_device,
> > +						  dev);
> > +	struct virtio_fs *fs = vdev->priv;
> > +
> > +	return sysfs_emit(buf, "%s\n", fs->tag);
> > +}
> > +static DEVICE_ATTR_RO(tag);
> 
> Is there a race between tag_show() and virtio_fs_remove()?
> virtio_fs_mutex is not held. I'm thinking of the case where userspace
> opens the sysfs file and invokes read(2) on one CPU while
> virtio_fs_remove() runs on another CPU.

Hi Stefan,

Good point. I started testing it and realized that something else
is providing mutual exclusion and race does not occur. I added
an artifial msleep(10 seconds) in tag_show() and removed the device
and let tag_show() continue, hoping kernel will crash. But that
did not happen. 

Further investation revealed that device_remove_file() call in 
virtio_fs_remove() blocks till tag_show() has finished.

I have not looked too deep but my guess is that is is probably
kernfs_node->kernfs_rwsem which is providing mutual exclusion
and eliminating this race.

So I don't think we need to take virtio_fs_mutex in tag_show().

Thanks
Vivek 
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



