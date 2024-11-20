Return-Path: <linux-fsdevel+bounces-35323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 465EC9D3CFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 15:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49251F22C43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 14:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE46D1A9B53;
	Wed, 20 Nov 2024 14:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrMlR0i6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A019E804
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111535; cv=none; b=fPrPoZgTjJkcZkGGeOdMbX5e3RUPDSbeBAIVCLcoNe4AjRuHNoaHEpi+px5GhB9T1k62DZm5WJE/F4UcdZiNzrlDXk54WdQ4YPmh1OMRi919LQ605qEsMAgxkunTnhg8Kj78PEixiqZaLMpY3JfO6zsDcM26U0z+/bU2Uze6FXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111535; c=relaxed/simple;
	bh=ZG2agr9YKv9vY6LK3VsO2Cz9sA6qKnnMQJv1p7D1KC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwwGpK43Y5zITI9Uhr8CCdu3gdDcjFQmimRqbcPGei/fkRJvTEc656fS7calt0iBrNMVEnUDm3ghvuI5w6Peka5et/6hmYnFjqu2ovqEOeJb7SZH5LCNygdu60JeOWV1KjZsD3qa4uz6OBDShxGMhXuV93v5dIs69c6vDSds3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrMlR0i6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732111532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lZ8zkxd9i0HO8zyxRsaMmA5VwckXIWnTVoItJwHtzes=;
	b=UrMlR0i62GILMhlqTz3jes8+jeEyDgfKqj3DNnAmmCg0aieFqhsoWQ729MCyeDJcLPlIn9
	3raQVkgN+K6EwBcTa3uDMcrO3seI3kegRq8d31qQaKCvu90q+WEThrZnnGuL7G7TeFgvwP
	zhVc8VI6oyxtuC9/bSiDECdCLycvYyI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-fEP9m0A0NhyClwF0cvKrGQ-1; Wed,
 20 Nov 2024 09:05:28 -0500
X-MC-Unique: fEP9m0A0NhyClwF0cvKrGQ-1
X-Mimecast-MFC-AGG-ID: fEP9m0A0NhyClwF0cvKrGQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 307F91953944;
	Wed, 20 Nov 2024 14:05:25 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFA9230001A0;
	Wed, 20 Nov 2024 14:05:22 +0000 (UTC)
Date: Wed, 20 Nov 2024 22:05:15 +0800
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
Message-ID: <Zz3sm+BhCrTO3bId@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com>
 <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
 <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/20/24 at 11:48am, David Hildenbrand wrote:
> On 20.11.24 11:13, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > s390 allocates+prepares the elfcore hdr in the dump (2nd) kernel, not in
> > > the crashed kernel.
> > > 
> > > RAM provided by memory devices such as virtio-mem can only be detected
> > > using the device driver; when vmcore_init() is called, these device
> > > drivers are usually not loaded yet, or the devices did not get probed
> > > yet. Consequently, on s390 these RAM ranges will not be included in
> > > the crash dump, which makes the dump partially corrupt and is
> > > unfortunate.
> > > 
> > > Instead of deferring the vmcore_init() call, to an (unclear?) later point,
> > > let's reuse the vmcore_cb infrastructure to obtain device RAM ranges as
> > > the device drivers probe the device and get access to this information.
> > > 
> > > Then, we'll add these ranges to the vmcore, adding more PT_LOAD
> > > entries and updating the offsets+vmcore size.
> > > 
> > > Use Kconfig tricks to include this code automatically only if (a) there is
> > > a device driver compiled that implements the callback
> > > (PROVIDE_PROC_VMCORE_DEVICE_RAM) and; (b) the architecture actually needs
> > > this information (NEED_PROC_VMCORE_DEVICE_RAM).
> > > 
> > > The current target use case is s390, which only creates an elf64
> > > elfcore, so focusing on elf64 is sufficient.
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   fs/proc/Kconfig            |  25 ++++++
> > >   fs/proc/vmcore.c           | 156 +++++++++++++++++++++++++++++++++++++
> > >   include/linux/crash_dump.h |   9 +++
> > >   3 files changed, 190 insertions(+)
> > > 
> > > diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
> > > index d80a1431ef7b..1e11de5f9380 100644
> > > --- a/fs/proc/Kconfig
> > > +++ b/fs/proc/Kconfig
> > > @@ -61,6 +61,31 @@ config PROC_VMCORE_DEVICE_DUMP
> > >   	  as ELF notes to /proc/vmcore. You can still disable device
> > >   	  dump using the kernel command line option 'novmcoredd'.
> > > +config PROVIDE_PROC_VMCORE_DEVICE_RAM
> > > +	def_bool n
> > > +
> > > +config NEED_PROC_VMCORE_DEVICE_RAM
> > > +	def_bool n
> > > +
> > > +config PROC_VMCORE_DEVICE_RAM
> > > +	def_bool y
> > > +	depends on PROC_VMCORE
> > > +	depends on NEED_PROC_VMCORE_DEVICE_RAM
> > > +	depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> > 
> > Kconfig item is always a thing I need learn to master.
> 
> Yes, it's usually a struggle to get it right. It took me a couple of
> iterations to get to this point :)
> 
> > When I checked
> > this part, I have to write them down to deliberate. I am wondering if
> > below 'simple version' works too and more understandable. Please help
> > point out what I have missed.
> > 
> > ===========simple version======
> > config PROC_VMCORE_DEVICE_RAM
> >          def_bool y
> >          depends on PROC_VMCORE && VIRTIO_MEM
> >          depends on NEED_PROC_VMCORE_DEVICE_RAM
> > 
> > config S390
> >          select NEED_PROC_VMCORE_DEVICE_RAM
> > ============

Sorry, things written down didn't correctly reflect them in my mind. 

===========simple version======
fs/proc/Kconfig:
config PROC_VMCORE_DEVICE_RAM
        def_bool y
        depends on PROC_VMCORE && VIRTIO_MEM
        depends on NEED_PROC_VMCORE_DEVICE_RAM

arch/s390/Kconfig:
config NEED_PROC_VMCORE_DEVICE_RAM
        def y
==================================


> 
> So the three changes you did are
> 
> (a) Remove the config option but select/depend on them.
> 
> (b) Remove the "depends on PROC_VMCORE" from PROC_VMCORE_DEVICE_RAM,
>     and the "if PROC_VMCORE" from s390.
> 
> (c) Remove the PROVIDE_PROC_VMCORE_DEVICE_RAM
> 
> 
> Regarding (a), that doesn't work. If you select a config option that doesn't
> exist, it is silently dropped. It's always treated as if it wouldn't be set.
> 
> Regarding (b), I think that's an anti-pattern (having config options enabled
> that are completely ineffective) and I don't see a benefit dropping them.
> 
> Regarding (c), it would mean that s390x unconditionally includes that code
> even if virtio-mem is not configured in.
> 
> So while we could drop PROVIDE_PROC_VMCORE_DEVICE_RAM -- (c), it would that
> we end up including code in configurations that don't possibly need it.
> That's why I included that part.
> 
> > 
> > 
> > ======= config items extracted from this patchset====
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
> > config VIRTIO_MEM
> > 	depends on X86_64 || ARM64 || RISCV
> >           ~~~~~ I don't get why VIRTIO_MEM dones't depend on S390 if
> >                 s390 need PROC_VMCORE_DEVICE_RAM.
> 
> This series depends on s390 support for virtio-mem, which just went
> upstream.

Got It, I just applied this series on top of the latest mainline's
master branch. Thanks for telling.

> 
> 
> commit 38968bcdcc1d46f2fdcd3a72599d5193bf8baf84
> Author: David Hildenbrand <david@redhat.com>
> Date:   Fri Oct 25 16:14:49 2024 +0200
> 
>     virtio-mem: s390 support
> 
> 
> >          ......
> >          select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> > 
> > config S390
> >          select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> > =================================================
> > 
> 
> Thanks for having a look!
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


