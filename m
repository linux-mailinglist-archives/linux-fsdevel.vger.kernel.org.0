Return-Path: <linux-fsdevel+bounces-7501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F4C825E9F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 08:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE12A285321
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jan 2024 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677984428;
	Sat,  6 Jan 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G75U+o1P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C904402
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jan 2024 07:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11E6C433C8;
	Sat,  6 Jan 2024 07:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704524556;
	bh=g/u+z+UpcU9riCcSd0l7qoQZf02O5QWaUySleiyBoEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G75U+o1PL+XFwI7940Oo/QR+vedVsUQnSQznd3Gfsr8AA4/CL/m4d3EbVGlNOcN9K
	 iu3W1yWKQTnkvbtP3DoSYNGDnRSwmK3MaC3GPfIqcgXjOmT5JAbKHEVSSL4PDDrFDN
	 SfV0sn2/yHl3dXbzBgbMxbPGEYAbFeMiSMyPg+n4=
Date: Sat, 6 Jan 2024 08:02:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com, miklos@szeredi.hu,
	stefanha@redhat.com, mzxreary@0pointer.de, gmaglione@redhat.com
Subject: Re: [PATCH] virtiofs: Export filesystem tags through sysfs
Message-ID: <2024010648-reptile-sandstone-8062@gregkh>
References: <20231005203030.223489-1-vgoyal@redhat.com>
 <2023111113-stubbed-camping-5089@gregkh>
 <ZZhqR-ulDFXKVlde@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZhqR-ulDFXKVlde@redhat.com>

On Fri, Jan 05, 2024 at 03:44:55PM -0500, Vivek Goyal wrote:
> On Sat, Nov 11, 2023 at 06:53:40AM -0500, Greg KH wrote:
> > On Thu, Oct 05, 2023 at 04:30:30PM -0400, Vivek Goyal wrote:
> > > virtiofs filesystem is mounted using a "tag" which is exported by the
> > > virtiofs device. virtiofs driver knows about all the available tags but
> > > these are not exported to user space.
> > > 
> > > People have asked these tags to be exported to user space. Most recently
> > > Lennart Poettering has asked for it as he wants to scan the tags and mount
> > > virtiofs automatically in certain cases.
> > > 
> > > https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> > > 
> > > This patch exports tags through sysfs. One tag is associated with each
> > > virtiofs device. A new "tag" file appears under virtiofs device dir.
> > > Actual filesystem tag can be obtained by reading this "tag" file.
> > > 
> > > For example, if a virtiofs device exports tag "myfs", a new file "tag"
> > > will show up here.
> > > 
> > > /sys/bus/virtio/devices/virtio<N>/tag
> > > 
> > > # cat /sys/bus/virtio/devices/virtio<N>/tag
> > > myfs
> > > 
> > > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> > > ---
> > >  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 34 insertions(+)
> > > 
> > > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > > index 5f1be1da92ce..a5b11e18f331 100644
> > > --- a/fs/fuse/virtio_fs.c
> > > +++ b/fs/fuse/virtio_fs.c
> > > @@ -107,6 +107,21 @@ static const struct fs_parameter_spec virtio_fs_parameters[] = {
> > >  	{}
> > >  };
> > >  
> > > +/* Forward Declarations */
> > > +static void virtio_fs_stop_all_queues(struct virtio_fs *fs);
> > > +
> > > +/* sysfs related */
> > > +static ssize_t tag_show(struct device *dev, struct device_attribute *attr,
> > > +			char *buf)
> > > +{
> > > +	struct virtio_device *vdev = container_of(dev, struct virtio_device,
> > > +						  dev);
> > > +	struct virtio_fs *fs = vdev->priv;
> > > +
> > > +	return sysfs_emit(buf, "%s", fs->tag);
> > > +}
> > > +static DEVICE_ATTR_RO(tag);
> > > +
> > >  static int virtio_fs_parse_param(struct fs_context *fsc,
> > >  				 struct fs_parameter *param)
> > >  {
> > > @@ -265,6 +280,15 @@ static int virtio_fs_add_instance(struct virtio_fs *fs)
> > >  	return 0;
> > >  }
> > >  
> > > +static void virtio_fs_remove_instance(struct virtio_fs *fs)
> > > +{
> > > +	mutex_lock(&virtio_fs_mutex);
> > > +	list_del_init(&fs->list);
> > > +	virtio_fs_stop_all_queues(fs);
> > > +	virtio_fs_drain_all_queues_locked(fs);
> > > +	mutex_unlock(&virtio_fs_mutex);
> > > +}
> > > +
> > >  /* Return the virtio_fs with a given tag, or NULL */
> > >  static struct virtio_fs *virtio_fs_find_instance(const char *tag)
> > >  {
> > > @@ -891,8 +915,15 @@ static int virtio_fs_probe(struct virtio_device *vdev)
> > >  	if (ret < 0)
> > >  		goto out_vqs;
> > >  
> > > +	/* Export tag through sysfs */
> > > +	ret = device_create_file(&vdev->dev, &dev_attr_tag);
> > > +	if (ret < 0)
> > > +		goto out_sysfs_attr;
> > 
> > You just raced with userspace and lost :(
> > 
> > Please use default groups for your device/bus, that is what they are
> > there for.
> 
> Hi Greg,
> 
> Getting back to this thread after a long time. Sorry, got busy in other
> things.
> 
> Trying to understand the races with user space. IIUC, your primary concern
> is that kobject has already been published to the user space and I am
> trying to add/remove attributes to the object after the fact and that
> makes it racy?

Yes.

> And suggestion is to first fully create kobject (including attrs) before
> publishing it to user space. Do I understand it correctly or I missed
> the point completely?

Use the default groups pointer in the device instead which makes the
driver core create/remove the files automatically for you.  Here's
something I wrote over a decade ago as to how to prevent this:
	http://www.kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/

thanks,

greg k-h

