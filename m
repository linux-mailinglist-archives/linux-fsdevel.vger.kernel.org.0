Return-Path: <linux-fsdevel+bounces-35831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 582B49D8844
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DB1167626
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA01B218F;
	Mon, 25 Nov 2024 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxPMeu9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2FE1B0F25
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545722; cv=none; b=d+hH99WYq015FXXMLp0K59N1fGbbxJmNOUiQYe+ZIld/KjpTjmE8IkK3YYvW3Y4CggtfHzHbDS5NViyhCRA+vMH6gdROb6txW8E7/0Y1r6goWiRn5vCRvgHQJPLzfiM4mF4HjBNnEUdp5QP8AfjErh/6h4r+gylA7pbW8XuN/7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545722; c=relaxed/simple;
	bh=Tr/cQ1TM/FF9xGvPfcuB0kYLT2zKMPvRvPes1SuHlCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRsOYd+MVSNj0+MTegriKmFmge1p3IfvMAfzXhYSy9c1p6yTDFiZ46NAcz5rLDTu3lNE/rRbu7BT5jsvxEe9+nWwQS03B1yOXMvMvvOLUwGB6Kcu12ttCMtzot0ZI8a3KUvC0j5TPutbJeOZH0sNfCI9/05ADsUMvgVAQp30rUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxPMeu9P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732545719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=46wCtS3Eh2MWHiDHvSqDOE0J1G+zlgwVIrX5wgmHpV8=;
	b=gxPMeu9PHHjx6Oyw0VNLauLKzVKRu1D9xMcMQwofSnaL8kP9FkK6M8j+uTAMuCt9Z3AkpA
	ho14xvXB/ZfQAoJnlcha+8azbdAvhKambU7YABobi0QP1WpVhmwcmz3ZozrdOoYMoh33v1
	5D47O7PspPaBzeH6NQABUnBAULsRGDE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-bEyv-BAOPx6TDm6pRFxqBA-1; Mon,
 25 Nov 2024 09:41:55 -0500
X-MC-Unique: bEyv-BAOPx6TDm6pRFxqBA-1
X-Mimecast-MFC-AGG-ID: bEyv-BAOPx6TDm6pRFxqBA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BFA41954B0A;
	Mon, 25 Nov 2024 14:41:52 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28945195E483;
	Mon, 25 Nov 2024 14:41:50 +0000 (UTC)
Date: Mon, 25 Nov 2024 22:41:45 +0800
From: Baoquan He <bhe@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 03/11] fs/proc/vmcore: disallow vmcore modifications
 after the vmcore was opened
Message-ID: <Z0SMqYX8gMvdiU4T@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-4-david@redhat.com>
 <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
 <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/22/24 at 10:30am, David Hildenbrand wrote:
> On 22.11.24 10:16, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > ......snip...
> > > @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> > >   		return -EINVAL;
> > >   	}
> > > +	/* We'll recheck under lock later. */
> > > +	if (data_race(vmcore_opened))
> > > +		return -EBUSY;
> > 
> 
> Hi,
> 
> > As I commented to patch 7, if vmcore is opened and closed after
> > checking, do we need to give up any chance to add device dumping
> > as below?
> > 
> > fd = open(/proc/vmcore);
> > ...do checking;
> > close(fd);
> > 
> > quit any device dump adding;
> > 
> > run makedumpfile on s390;
> >    ->fd = open(/proc/vmcore);
> >      -> try to dump;
> >    ->close(fd);
> 
> The only reasonable case where this could happen (with virtio_mem) would be
> when you hotplug a virtio-mem device into a VM that is currently in the
> kdump kernel. However, in this case, the device would not provide any memory
> we want to dump:
> 
> (1) The memory was not available to the 1st (crashed) kernel, because
>     the device got hotplugged later.
> (2) Hotplugged virtio-mem devices show up with "no plugged memory",
>     meaning there wouldn't be even something to dump.
> 
> Drivers will be loaded (as part of the kernel or as part of the initrd)
> before any kdump action is happening. Similarly, just imagine your NIC
> driver not being loaded when you start dumping to a network share ...
> 
> This should similarly apply to vmcoredd providers.
> 
> There is another concern I had at some point with changing the effective
> /proc/vmcore size after someone already opened it, and might assume the size
> will stay unmodified (IOW, the file was completely static before vmcoredd
> showed up).
> 
> So unless there is a real use case that requires tracking whether the file
> is no longer open, to support modifying the vmcore afterwards, we should
> keep it simple.
> 
> I am not aware of any such cases, and my experiments with virtio_mem showed
> that the driver get loaded extremely early from the initrd, compared to when
> we actually start messing with /proc/vmcore from user space.

Hmm, thanks for sharing your thoughts. I personally think if we could,
we had better make code as robust as possible. Here, since we have
already integrated the lock with one vmcore_mutex, whether the vmcoredd 
is added before or after /proc/vmcore opening/closing, it won't harm.
The benefit is it works well with the current kwown case, virtio-mem 
probing, makedumpfile running. And it also works well with other
possible cases, e.g if you doubt virtio-mem dumping and want to debug,
you set rd.break or take any way to drop into emengency shell of kdump
kernel, you can play it to poke virtio-mem module again and run makedumpfile
manually or reversing the order or taking any testing. Then kernel
implementation should not preset that user space have to run the
makedumpfile after the much earlier virtio-mem probing. If we implement
codes according to preset userspace scenario, that limit the future
adapttion, IMHO.


