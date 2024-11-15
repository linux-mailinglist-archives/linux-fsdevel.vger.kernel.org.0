Return-Path: <linux-fsdevel+bounces-34876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B8B9CDAD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A101F21904
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 08:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CC318D622;
	Fri, 15 Nov 2024 08:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNvcV98o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6318A6A3
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 08:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660405; cv=none; b=q+xPTwXIqppXeKfm4HMDfpXlC1pTan3yixjINmk7WprKmcdUSnJML8jAagaOi+nJNh3+DSEpjPMm/11uRZLd8+WV8ygGxfNweK8tpepYWT5cdl/O68ZcUlOiEGI9hgbNKq+szooZlT77o99F/LHNXb+IVfnThZVlBQW8B20tOYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660405; c=relaxed/simple;
	bh=Y+MsEKnzmc/83yMVSNfuCtSeI6/WxsCKwrXXNhZ5XLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLRjfT0N+7OB7kecWq3ABh1z/N49p3GN0BJz6WJJquDKMsaOMUW78UNt7m+6uJsyzd4eEkfjic/P0jp4eAUJzlpY/654lPyqCpPugRCqyRkr9rj0nzegtkiJWET/46jZoTsdiKOhvlE3MSZvsvXNidm4FxaqW5rPAnmdcBLAzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DNvcV98o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731660401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iU3AwiO23RxdWGWn7Yp7jp33a5YtE5yN//tDV9uC5Ss=;
	b=DNvcV98o95278eYdFS1fxbZWTBdd+ftk0xI+ACyvgbNcnHigC5VNIp/BQj+DbiSpjs97pZ
	RBw+hdC9CWy/jjyjbZUHjnzAReCYclgkEARqjWH8fR9ECuwgO/Ed1xjfOauoNW/fA47oGh
	P/76ZS8viMMPgjyUTGpfIZ7KWfDFmMw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-Ae3uHm1KMM642lvste8crA-1; Fri,
 15 Nov 2024 03:46:37 -0500
X-MC-Unique: Ae3uHm1KMM642lvste8crA-1
X-Mimecast-MFC-AGG-ID: Ae3uHm1KMM642lvste8crA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C2E31955F41;
	Fri, 15 Nov 2024 08:46:35 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A99EE1956054;
	Fri, 15 Nov 2024 08:46:32 +0000 (UTC)
Date: Fri, 15 Nov 2024 16:46:27 +0800
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
Subject: Re: [PATCH v1 00/11] fs/proc/vmcore: kdump support for virtio-mem on
 s390
Message-ID: <ZzcKY8hap3OMqTjC@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241025151134.1275575-1-david@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> This is based on "[PATCH v3 0/7] virtio-mem: s390 support" [1], which adds
> virtio-mem support on s390.
> 
> The only "different than everything else" thing about virtio-mem on s390
> is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> crash kernel must detect memory ranges of the crashed/panicked kernel to
> include via PT_LOAD in the vmcore.
> 
> On other architectures, all RAM regions (boot + hotplugged) can easily be
> observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
> the elfcore hdr.
> 
> On s390, information about "ordinary" memory (heh, "storage") can be
> obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
> that information is stored early during boot in the "physmem" memblock
> data structure.
> 
> But virtio-mem memory is always detected by as device driver, which is
> usually build as a module. So in the crash kernel, this memory can only be
                                       ~~~~~~~~~~~
                                       Is it 1st kernel or 2nd kernel?
Usually we call the 1st kernel as panicked kernel, crashed kernel, the
2nd kernel as kdump kernel. 
> properly detected once the virtio-mem driver started up.
> 
> The virtio-mem driver already supports the "kdump mode", where it won't
> hotplug any memory but instead queries the device to implement the
> pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
> the vmcore.
> 
> With this series, if the virtio-mem driver is included in the kdump
> initrd -- which dracut already takes care of under Fedora/RHEL -- it will
> now detect the device RAM ranges on s390 once it probes the devices, to add
> them to the vmcore using the same callback mechanism we already have for
> pfn_is_ram().

Do you mean on s390 virtio-mem memory region will be detected and added
to vmcore in kdump kernel when virtio-mem driver is initialized? Not
sure if I understand it correctly.

> 
> To add these device RAM ranges to the vmcore ("patch the vmcore"), we will
> add new PT_LOAD entries that describe these memory ranges, and update
> all offsets vmcore size so it is all consistent.
> 
> Note that makedumfile is shaky with v6.12-rcX, I made the "obvious" things
> (e.g., free page detection) work again while testing as documented in [2].
> 
> Creating the dumps using makedumpfile seems to work fine, and the
> dump regions (PT_LOAD) are as expected. I yet have to check in more detail
> if the created dumps are good (IOW, the right memory was dumped, but it
> looks like makedumpfile reads the right memory when interpreting the
> kernel data structures, which is promising).
> 
> Patch #1 -- #6 are vmcore preparations and cleanups
> Patch #7 adds the infrastructure for drivers to report device RAM
> Patch #8 + #9 are virtio-mem preparations
> Patch #10 implements virtio-mem support to report device RAM
> Patch #11 activates it for s390, implementing a new function to fill
>           PT_LOAD entry for device RAM
> 
> [1] https://lkml.kernel.org/r/20241025141453.1210600-1-david@redhat.com
> [2] https://github.com/makedumpfile/makedumpfile/issues/16
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Cc: "Eugenio Pérez" <eperezma@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Eric Farman <farman@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> 
> David Hildenbrand (11):
>   fs/proc/vmcore: convert vmcore_cb_lock into vmcore_mutex
>   fs/proc/vmcore: replace vmcoredd_mutex by vmcore_mutex
>   fs/proc/vmcore: disallow vmcore modifications after the vmcore was
>     opened
>   fs/proc/vmcore: move vmcore definitions from kcore.h to crash_dump.h
>   fs/proc/vmcore: factor out allocating a vmcore memory node
>   fs/proc/vmcore: factor out freeing a list of vmcore ranges
>   fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM to detect device RAM
>     ranges in 2nd kernel
>   virtio-mem: mark device ready before registering callbacks in kdump
>     mode
>   virtio-mem: remember usable region size
>   virtio-mem: support CONFIG_PROC_VMCORE_DEVICE_RAM
>   s390/kdump: virtio-mem kdump support (CONFIG_PROC_VMCORE_DEVICE_RAM)
> 
>  arch/s390/Kconfig             |   1 +
>  arch/s390/kernel/crash_dump.c |  39 +++--
>  drivers/virtio/Kconfig        |   1 +
>  drivers/virtio/virtio_mem.c   | 103 +++++++++++++-
>  fs/proc/Kconfig               |  25 ++++
>  fs/proc/vmcore.c              | 258 +++++++++++++++++++++++++---------
>  include/linux/crash_dump.h    |  47 +++++++
>  include/linux/kcore.h         |  13 --
>  8 files changed, 396 insertions(+), 91 deletions(-)
> 
> -- 
> 2.46.1
> 


