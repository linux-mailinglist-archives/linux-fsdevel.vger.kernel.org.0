Return-Path: <linux-fsdevel+bounces-35547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A79D5A64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 08:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53365B23AFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D9A17DFE0;
	Fri, 22 Nov 2024 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID2bmyye"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30F170A27
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 07:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261929; cv=none; b=RGps2pA/1m4uYfpixXfa1QgloGCYUCHCzwvtcYc+JicoFCktkvej0MVYhX/Z5iu9NLjvhCzilBiLZv1RHm+B6+IWQlWJ7LU7hzHZBv0PgyMMDhJ6iZzwtQ/ki0WQXJRLCvvYAFzvLFOOm+w5tgsCwx0VdgyLbuMIhmoB3d8quxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261929; c=relaxed/simple;
	bh=14gNrbZwr4FwtDxhLh5ypoXNB6/niQbMSNKxqDfxcFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsB4prIXbQHlzIUwtllhbnL4pVoDYBk9WgnxyQkkhvn2jPcbVllPWm2v4e29gaaLVi4dJ3RE73NKZmtWjIkh5+NhGRgxZBaNnb0uyQnUQxgO0QJE5IDZsvFlC5K9N6NxyruRz/lHwSXrzT0sljBpiFyatjed4Dk2yg7GfzD44w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ID2bmyye; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732261926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D9p/amWDuKtYCK1WkCl/Fua58/N/1s7xV60ca3EpfR4=;
	b=ID2bmyye9hOvaD9jt6Be9fjV/tq/p16I4/v7Owmc6NQx6v09oAMAaATolfu5mkNTTbwqUE
	GpcRj9Aj+q2EPhzAk4odda3wPJZ4aVkEguoY8AAwoMh3TrjJu8t+yyGAStNRK9Azt/RaAl
	gHTHd+7bkPKcdnFe/8ORMKS7WQcJzfY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-HBEew0p3NECkehH9sfpIIQ-1; Fri,
 22 Nov 2024 02:52:04 -0500
X-MC-Unique: HBEew0p3NECkehH9sfpIIQ-1
X-Mimecast-MFC-AGG-ID: HBEew0p3NECkehH9sfpIIQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53B6E1955F3D;
	Fri, 22 Nov 2024 07:52:01 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B9441955F43;
	Fri, 22 Nov 2024 07:51:59 +0000 (UTC)
Date: Fri, 22 Nov 2024 15:51:54 +0800
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
Subject: Re: [PATCH v1 07/11] fs/proc/vmcore: introduce
 PROC_VMCORE_DEVICE_RAM to detect device RAM ranges in 2nd kernel
Message-ID: <Z0A4Gl1dUINrTTUX@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com>
 <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
 <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
 <Zz3sm+BhCrTO3bId@MiWiFi-R3L-srv>
 <3ed18ba1-e4b1-461e-a3a7-5de2df59ca60@redhat.com>
 <Zz63aGL7NcrONk+p@MiWiFi-R3L-srv>
 <c353466b-6860-4ca2-a4fa-490648246ddc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c353466b-6860-4ca2-a4fa-490648246ddc@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 11/21/24 at 08:47pm, David Hildenbrand wrote:
> > > 
> > > That would work, but I don't completely like it.
> > > 
> > > (a) I want s390x to select NEED_PROC_VMCORE_DEVICE_RAM instead. Staring at a
> > > bunch of similar cases (git grep "config NEED" | grep Kconfig, git grep
> > > "config ARCH_WANTS" | grep Kconfig), "select" is the common way to do it.
> > > 
> > > So unless there is a pretty good reason, I'll keep
> > > NEED_PROC_VMCORE_DEVICE_RAM as is.
> > 
> > That's easy to satify, see below:
> 
> Yes, this is mostly what I have right now, except
> 
> > 
> > ============simple version=====
> > fs/proc/Kconfig:
> > config NEED_PROC_VMCORE_DEVICE_RAM
> >          def n
> 
> using "bool" here like other code. (I assume you meant "def_bool n", "bool"
> seems to achieve the same thing)

Yes, you are right. I didn't check it carefully.

> 
> > 
...... 
> > ===================
> > fs/proc/Kconfig:
> > config PROVIDE_PROC_VMCORE_DEVICE_RAM
> >          def_bool n
> > 
> > config NEED_PROC_VMCORE_DEVICE_RAM
> >          def_bool n
> > 
> > config PROC_VMCORE_DEVICE_RAM
> >          def_bool y
> >          depends on PROC_VMCORE
> >          depends on NEED_PROC_VMCORE_DEVICE_RAM
> >          depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> > 
> > drivers/virtio/Kconfig:
> > config VIRTIO_MEM
> >          select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> >                                                ~~~~~~~~~~~~~~
> > 
> > arch/s390/Kconfig:
> > config S390
> >          select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> >                                             ~~~~~~~~~~~~~~
> > ========================
> > 
> > One last thing I haven't got well, If PROC_VMCORE_DEVICE_RAM has had
> > dependency on PROC_VMCORE, can we take off the ' if PROC_VMCORE' when
> > select PROVIDE_PROC_VMCORE_DEVICE_RAM and NEED_PROC_VMCORE_DEVICE_RAM?
> 
> We could; it would mean that in a .config file you would end up with
> "NEED_PROC_VMCORE_DEVICE_RAM=y" with "#PROC_VMCORE" and no notion of
> "PROC_VMCORE_DEVICE_RAM".

Fair enough. I didn't think of this. Then keeping it is obvisouly
better. Thanks.

> 
> I don't particularly like that -- needing something that apparently does not
> exist. Not sure if there is a best practice here, staring at some examples I
> don't seem to find a consistent rule. I can just drop it, not the end of the
> world.
> 
> 
> Did you get to look at the other code changes in this patch set? Your
> feedback would be highly appreciated!

Will try. While I may not have valuable input about virtio-mem code.


