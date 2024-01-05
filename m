Return-Path: <linux-fsdevel+bounces-7488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F4D825BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 21:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8CD1C23499
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 20:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFF2111D;
	Fri,  5 Jan 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YqoyGhoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74721200AE
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jan 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704487500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Kn8rnNnobM1oE2nVIkftWAWQAliDYxNF8m2le6NwI8c=;
	b=YqoyGhoPfuL2ATuSGmaQv8qa5RuAOSlf33MpyEIXXWBGCHxXBnG/XND1+ZQRYpYYux9oUj
	Wh0MjL0Er/wITMN72ggf5eCMESmEHgy9CMeQ9MtS947vML7C2I4K2buHMyUGKojNje7/oF
	g6lXQ//7CFFIxrWTg24uqqnGdBs1euM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-hV2hfT_yPBKgBkW_sd_gtA-1; Fri, 05 Jan 2024 15:44:57 -0500
X-MC-Unique: hV2hfT_yPBKgBkW_sd_gtA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1483845DC0;
	Fri,  5 Jan 2024 20:44:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.8.247])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 733F4492BC7;
	Fri,  5 Jan 2024 20:44:56 +0000 (UTC)
Received: by fedora.redhat.com (Postfix, from userid 1000)
	id D6F5628EBDE; Fri,  5 Jan 2024 15:44:55 -0500 (EST)
Date: Fri, 5 Jan 2024 15:44:55 -0500
From: Vivek Goyal <vgoyal@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu,
	stefanha@redhat.com, mzxreary@0pointer.de, gmaglione@redhat.com
Subject: Re: [PATCH] virtiofs: Export filesystem tags through sysfs
Message-ID: <ZZhqR-ulDFXKVlde@redhat.com>
References: <20231005203030.223489-1-vgoyal@redhat.com>
 <2023111113-stubbed-camping-5089@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023111113-stubbed-camping-5089@gregkh>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Sat, Nov 11, 2023 at 06:53:40AM -0500, Greg KH wrote:
> On Thu, Oct 05, 2023 at 04:30:30PM -0400, Vivek Goyal wrote:
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
> > will show up here.
> > 
> > /sys/bus/virtio/devices/virtio<N>/tag
> > 
> > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > myfs
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 5f1be1da92ce..a5b11e18f331 100644
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
> > +	return sysfs_emit(buf, "%s", fs->tag);
> > +}
> > +static DEVICE_ATTR_RO(tag);
> > +
> >  static int virtio_fs_parse_param(struct fs_context *fsc,
> >  				 struct fs_parameter *param)
> >  {
> > @@ -265,6 +280,15 @@ static int virtio_fs_add_instance(struct virtio_fs *fs)
> >  	return 0;
> >  }
> >  
> > +static void virtio_fs_remove_instance(struct virtio_fs *fs)
> > +{
> > +	mutex_lock(&virtio_fs_mutex);
> > +	list_del_init(&fs->list);
> > +	virtio_fs_stop_all_queues(fs);
> > +	virtio_fs_drain_all_queues_locked(fs);
> > +	mutex_unlock(&virtio_fs_mutex);
> > +}
> > +
> >  /* Return the virtio_fs with a given tag, or NULL */
> >  static struct virtio_fs *virtio_fs_find_instance(const char *tag)
> >  {
> > @@ -891,8 +915,15 @@ static int virtio_fs_probe(struct virtio_device *vdev)
> >  	if (ret < 0)
> >  		goto out_vqs;
> >  
> > +	/* Export tag through sysfs */
> > +	ret = device_create_file(&vdev->dev, &dev_attr_tag);
> > +	if (ret < 0)
> > +		goto out_sysfs_attr;
> 
> You just raced with userspace and lost :(
> 
> Please use default groups for your device/bus, that is what they are
> there for.

Hi Greg,

Getting back to this thread after a long time. Sorry, got busy in other
things.

Trying to understand the races with user space. IIUC, your primary concern
is that kobject has already been published to the user space and I am
trying to add/remove attributes to the object after the fact and that
makes it racy?

And suggestion is to first fully create kobject (including attrs) before
publishing it to user space. Do I understand it correctly or I missed
the point completely?

Thanks
Vivek


