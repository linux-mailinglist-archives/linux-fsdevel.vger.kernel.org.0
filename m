Return-Path: <linux-fsdevel+bounces-34884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E38E9CDBD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 10:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27798B2109B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC418FC81;
	Fri, 15 Nov 2024 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FxIXpwQq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5009D14F9D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Nov 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664149; cv=none; b=Ui4qnbuq7Wxx4uYxQQK5hcw1gLu1Z9SaNGCw+6CzT4wrG2JAXvQgN03srwKqgt9pHth7M8HHUzJ42i7KyvoNNAgG7KPHuhJ8oybu7AxTvKj8/nvuBjUXVAz98eDyVn9sPt5dKsNNYcmZoZfsJRVMEMdkcnqqz6KbSjDrgGMt2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664149; c=relaxed/simple;
	bh=5JV+Q8/uDzvNYDwkc+mCN1HUPeABFq9Hs2oXi52V+FA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOoDize/gCWlG1qKUzE2oGHaNYS1o5pbZXz1ov6wOMhRUiO7h2Dya1JF2u9B5B8qZ2toU6bodo0bMaOAVMgJf5AbbvD6QWi63u1tckUf3NinYjKlbsOS74B0usgCBKqEUDet5UXWMuGZ25rLy5yv3rMtVZ18PDASGt28G6R2G0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FxIXpwQq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731664146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e5/Gv1K21sheGKIrlLPLsT5HVFSu0SIwMyx7mgZQnuI=;
	b=FxIXpwQqjFhsUeXhb39lYHLfWkpTz2ZmEPm5ZGsp5ISTEihusQhedTmIqiFNAoWzNCsWpY
	5OIO/x0nkoeDwI1ig2IQ/ZJXd/NKyPf/pc136G6FWnHrHtJEaKgklYd47VLgEfpw4wY16t
	fYvy9UM0Fl/2limzUpf6NXwdzrp/5bg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-YdO3XG1bNzqs4Bb4j1wJcg-1; Fri,
 15 Nov 2024 04:49:02 -0500
X-MC-Unique: YdO3XG1bNzqs4Bb4j1wJcg-1
X-Mimecast-MFC-AGG-ID: YdO3XG1bNzqs4Bb4j1wJcg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE9CB1955E92;
	Fri, 15 Nov 2024 09:48:59 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3935D3003B71;
	Fri, 15 Nov 2024 09:48:58 +0000 (UTC)
Date: Fri, 15 Nov 2024 17:48:53 +0800
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
Message-ID: <ZzcZBU0USDP/CHcv@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <ZzcKY8hap3OMqTjC@MiWiFi-R3L-srv>
 <d7353fde-f560-4925-8ef8-0fe10654e87f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7353fde-f560-4925-8ef8-0fe10654e87f@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/15/24 at 09:55am, David Hildenbrand wrote:
> On 15.11.24 09:46, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > This is based on "[PATCH v3 0/7] virtio-mem: s390 support" [1], which adds
> > > virtio-mem support on s390.
> > > 
> > > The only "different than everything else" thing about virtio-mem on s390
> > > is kdump: The crash (2nd) kernel allocates+prepares the elfcore hdr
> > > during fs_init()->vmcore_init()->elfcorehdr_alloc(). Consequently, the
> > > crash kernel must detect memory ranges of the crashed/panicked kernel to
> > > include via PT_LOAD in the vmcore.
> > > 
> > > On other architectures, all RAM regions (boot + hotplugged) can easily be
> > > observed on the old (to crash) kernel (e.g., using /proc/iomem) to create
> > > the elfcore hdr.
> > > 
> > > On s390, information about "ordinary" memory (heh, "storage") can be
> > > obtained by querying the hypervisor/ultravisor via SCLP/diag260, and
> > > that information is stored early during boot in the "physmem" memblock
> > > data structure.
> > > 
> > > But virtio-mem memory is always detected by as device driver, which is
> > > usually build as a module. So in the crash kernel, this memory can only be
> >                                         ~~~~~~~~~~~
> >                                         Is it 1st kernel or 2nd kernel?
> > Usually we call the 1st kernel as panicked kernel, crashed kernel, the
> > 2nd kernel as kdump kernel.
> 
> It should have been called "kdump (2nd) kernel" here indeed.
> 
> > > properly detected once the virtio-mem driver started up.
> > > 
> > > The virtio-mem driver already supports the "kdump mode", where it won't
> > > hotplug any memory but instead queries the device to implement the
> > > pfn_is_ram() callback, to avoid reading unplugged memory holes when reading
> > > the vmcore.
> > > 
> > > With this series, if the virtio-mem driver is included in the kdump
> > > initrd -- which dracut already takes care of under Fedora/RHEL -- it will
> > > now detect the device RAM ranges on s390 once it probes the devices, to add
> > > them to the vmcore using the same callback mechanism we already have for
> > > pfn_is_ram().
> > 
> > Do you mean on s390 virtio-mem memory region will be detected and added
> > to vmcore in kdump kernel when virtio-mem driver is initialized? Not
> > sure if I understand it correctly.
> 
> Yes exactly. In the kdump kernel, the driver gets probed and registers the
> vmcore callbacks. From there, we detect and add the device regions.

I see now, thanks for your confirmation.


