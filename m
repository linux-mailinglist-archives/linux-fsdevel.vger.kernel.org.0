Return-Path: <linux-fsdevel+bounces-35292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FA99D3739
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A7A1F21F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127A919D89B;
	Wed, 20 Nov 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFa3JGgF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A2619C551
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2024 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732095757; cv=none; b=aWnUbnNq05z73g0dBGnr54wX+PFEFk0tSlCvoaBRUaBCNiafL5dmf2/+7qYYmeJdOmivzJ6g+JKiIEZlc4gkcw0Y8Qdekx2e6rKbxxxqZRf6hx1dyzqtPrXa8w6V60j5muoT+PBSsK1kPy/7LTHwc0tWAqIBsBvUR4sFaoUrx8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732095757; c=relaxed/simple;
	bh=+MfqtJzp+ShAy/X+9uRsWq7bOah9Lc4YrSYMKQjQ8Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blt8tCMW4K8qxS7bIL2HG2ofuxrDnWFaB3d+36fyZRoBFjOfzbrcoo4Yk1WG3TBKkzYUrSZJ0E7DtYXKxYhtNmuyKCBVdcbvSF+corRGbCqpkZICL0V3x2IJmP2APHaGaV2F3GBRKCQTt3iy0yNGKO/8vAP6MmOTiVoxRsbZIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFa3JGgF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732095755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BtnWcCy/RhXE31KVrvFbhBplS1bhLk3pDVg35AMkfJY=;
	b=SFa3JGgFffyR/3hvrW9iYeEMHJgTU8gcb2mDsls2+xrGPdX+XRru01t6kGBruqGoGGBXXY
	9vD4AR3mDnzHsV9t921BWw6DqaxM3vrxpkDxOTA93YDUf7GG7EFI65ZRx74fgFFGGl8rnY
	hCRsDDBC617RTq5QUebFNIsko/Dlef4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-MR-qE1QFOU6higATofrtoA-1; Wed,
 20 Nov 2024 04:42:30 -0500
X-MC-Unique: MR-qE1QFOU6higATofrtoA-1
X-Mimecast-MFC-AGG-ID: MR-qE1QFOU6higATofrtoA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B67019560BA;
	Wed, 20 Nov 2024 09:42:27 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5BE5319560A3;
	Wed, 20 Nov 2024 09:42:25 +0000 (UTC)
Date: Wed, 20 Nov 2024 17:42:19 +0800
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
Subject: Re: [PATCH v1 04/11] fs/proc/vmcore: move vmcore definitions from
 kcore.h to crash_dump.h
Message-ID: <Zz2u+2abswlwVcer@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-5-david@redhat.com>
 <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
 <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/15/24 at 10:59am, David Hildenbrand wrote:
> On 15.11.24 10:44, Baoquan He wrote:
> > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > These defines are not related to /proc/kcore, move them to crash_dump.h
> > > instead. While at it, rename "struct vmcore" to "struct
> > > vmcore_mem_node", which is a more fitting name.
> > 
> > Agree it's inappropriate to put the defintions in kcore.h. However for
> > 'struct vmcore', it's only used in fs/proc/vmcore.c from my code
> > serching, do you think if we can put it in fs/proc/vmcore.c directly?
> > And 'struct vmcoredd_node' too.
> 
> See the next patches and how virtio-mem will make use of the feactored out
> functions. Not putting them as inline functions into a header will require
> exporting symbols just do add a vmcore memory node to the list, which I want
> to avoid -- overkill for these simple helpers.

I see. It makes sense to put them in crash_dump.h. Thanks for
explanation.

> 
> > 
> > And about the renaming, with my understanding each instance of struct
> > vmcore represents one memory region, isn't it a little confusing to be
> > called vmcore_mem_node? I understand you probablly want to unify the
> > vmcore and vmcoredd's naming. I have to admit I don't know vmcoredd well
> > and its naming, while most of people have been knowing vmcore representing
> > memory region very well.
> 
> I chose "vmcore_mem_node" because it is a memory range stored in a list.
> Note the symmetry with "vmcoredd_node"

I would say the justification of naming "vmcore_mem_node" is to keep
symmetry with "vmcoredd_node". If because it is a memory range, it really
should not be called vmcore_mem_node. As we know, memory node has
specific meaning in kernel, it's the memory range existing on a NUMA node.

And vmcoredd is not a widely used feature. At least in fedora/RHEL, we
leave it to customers themselves to use and handle, we don't support it.
And we add 'novmcoredd' to kdump kernel cmdline by default to disable it
in fedora/RHEL. So a rarely used feature should not be taken to decide
the naming of a mature and and widely used feature's name. My personal
opinion.

> 
> If there are strong feelings I can use a different name, but

Yes, I would suggest we better keep the old name or take a more
appropriate one if have to change.

> "vmcore_mem_node" really describes what it actually is. Especially now that
> we have different vmcore nodes.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 


