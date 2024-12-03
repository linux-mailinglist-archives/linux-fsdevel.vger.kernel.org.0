Return-Path: <linux-fsdevel+bounces-36322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08499E19A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 11:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66CF11667E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 10:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19791E285C;
	Tue,  3 Dec 2024 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IBf3vuai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968671E2854
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222564; cv=none; b=NJgJZWAObRmtSu1RwxW86EzsTrBJgmJnNPt0WXZOxYkWZczS28cr3SdbwdDz6CJps2Gt4JhnLM+ewOjEv412+fb3r7tkvgH6TN72BZNpVzzvbJq+hFyCq15eGQ5jQx9kaYFO5RFxoSeGK/ulx8KL+9vBws/1opcqPRmTcMfZcus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222564; c=relaxed/simple;
	bh=GClxry7kOfIsY1EQO6Rm5I2oCXDUT6JUC3Wc7LhTng0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uC8wVl2NpuJSUAgNZheh+VyeZGaUZBBonwaHOvpgbYaY8WiBMv1Q0LuKjJSLb/uAt1pNiVdxZ0xyYxGfAiBWiq4qvrJ9zbyUs+os2g66COYfykPP9AF+hNi2L/zs+AerI5huZWaO4mwFOVi275uifoUz95CXk8Nsj+q+67dLgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IBf3vuai; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733222560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D5AHi0uk+oN+zpkzvh/QNmG2L3UPAKNwXGcHrJAQaZM=;
	b=IBf3vuaiex7xxuF0Uw9ZzOY9JXxPRGRVWxeBhqeAZEgumQRHc4QDka4xrtoh+gbe7BSNhf
	Vp5ECnlOkaBRnbXhnxsBg0E9tEyUP3ja5Wyro5lCqMnZR82B0N/ZaCXnuxUFwtOz/HNebt
	LTlWOBNfgzEgW5M+0QpMmPV8itCPgUM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-P5838zgdOW6m0hg0rLlvbA-1; Tue,
 03 Dec 2024 05:42:36 -0500
X-MC-Unique: P5838zgdOW6m0hg0rLlvbA-1
X-Mimecast-MFC-AGG-ID: P5838zgdOW6m0hg0rLlvbA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE7BF19560BD;
	Tue,  3 Dec 2024 10:42:32 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A28330000DF;
	Tue,  3 Dec 2024 10:42:29 +0000 (UTC)
Date: Tue, 3 Dec 2024 18:42:25 +0800
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
Message-ID: <Z07gkXQDrNfL10hu@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-4-david@redhat.com>
 <Z0BL/UopaH5Xg5jS@MiWiFi-R3L-srv>
 <d29d7816-a3e5-4f34-bb0c-dd427931efb4@redhat.com>
 <Z0SMqYX8gMvdiU4T@MiWiFi-R3L-srv>
 <a7ccbd86-2a62-4191-8742-ce45b6e8f73c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ccbd86-2a62-4191-8742-ce45b6e8f73c@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/29/24 at 11:38am, David Hildenbrand wrote:
> On 25.11.24 15:41, Baoquan He wrote:
> > On 11/22/24 at 10:30am, David Hildenbrand wrote:
> > > On 22.11.24 10:16, Baoquan He wrote:
> > > > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > > ......snip...
> > > > > @@ -1482,6 +1470,10 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
> > > > >    		return -EINVAL;
> > > > >    	}
> > > > > +	/* We'll recheck under lock later. */
> > > > > +	if (data_race(vmcore_opened))
> > > > > +		return -EBUSY;
> > > > 
> > > 
> > > Hi,
> > > 
> > > > As I commented to patch 7, if vmcore is opened and closed after
> > > > checking, do we need to give up any chance to add device dumping
> > > > as below?
> > > > 
> > > > fd = open(/proc/vmcore);
> > > > ...do checking;
> > > > close(fd);
> > > > 
> > > > quit any device dump adding;
> > > > 
> > > > run makedumpfile on s390;
> > > >     ->fd = open(/proc/vmcore);
> > > >       -> try to dump;
> > > >     ->close(fd);
> > > 
> > > The only reasonable case where this could happen (with virtio_mem) would be
> > > when you hotplug a virtio-mem device into a VM that is currently in the
> > > kdump kernel. However, in this case, the device would not provide any memory
> > > we want to dump:
> > > 
> > > (1) The memory was not available to the 1st (crashed) kernel, because
> > >      the device got hotplugged later.
> > > (2) Hotplugged virtio-mem devices show up with "no plugged memory",
> > >      meaning there wouldn't be even something to dump.
> > > 
> > > Drivers will be loaded (as part of the kernel or as part of the initrd)
> > > before any kdump action is happening. Similarly, just imagine your NIC
> > > driver not being loaded when you start dumping to a network share ...
> > > 
> > > This should similarly apply to vmcoredd providers.
> > > 
> > > There is another concern I had at some point with changing the effective
> > > /proc/vmcore size after someone already opened it, and might assume the size
> > > will stay unmodified (IOW, the file was completely static before vmcoredd
> > > showed up).
> > > 
> > > So unless there is a real use case that requires tracking whether the file
> > > is no longer open, to support modifying the vmcore afterwards, we should
> > > keep it simple.
> > > 
> > > I am not aware of any such cases, and my experiments with virtio_mem showed
> > > that the driver get loaded extremely early from the initrd, compared to when
> > > we actually start messing with /proc/vmcore from user space.

It's OK, David, I don't have strong opinion about the current
implementation. I raised this concern because

1) I saw the original vmcoredd only warn when doing register if
vmcore_opened is true;

2) in patch 1, it says vmcore_mutex is introduced to protect vmcore
modifications from concurrent opening. If we are confident, the old
vmcoredd_mutex can guarantee it, I could be wrong here.

Anyway, it's just a tiny concern, I believe it won't cause issue at
present. So it's up to you. 

Thanks


