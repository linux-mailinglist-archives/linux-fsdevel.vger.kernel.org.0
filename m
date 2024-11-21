Return-Path: <linux-fsdevel+bounces-35379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F33FC9D46CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 05:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106CFB21C4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 04:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05635146D6B;
	Thu, 21 Nov 2024 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G30m4Xqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D85234
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 04:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163722; cv=none; b=j/Iz7Nrg4padwRaXp/UO+l+hhlmiCS047l0eGueh4vmebfpcDXbMiigt4odehAKMcjaZdXTuHem6ZMMWCclPTnXKGLLcrjsyvgnQPatJ/UxvFBFMWKdFINeb8TQ7Gik9LsJJ0xToimfzw5CpIE89qbjtiLe4YEzHBF/lBN/bdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163722; c=relaxed/simple;
	bh=E2sGYIEW4FeEoEaJR7y1bs/G/4XWUr2LpZKVyBuu2t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZjYvZimGHgSEmAy130uf8Ft9rwiM2mdWgjBXAIsk4aTIRW6ogenlR3UeX6rRqZSfxRrHCPFlQHOEOI1I1NCIcOduNcPOo/I7NaSEOIEYL+5uVYOP5CaLGyk1UH5ReILL2Vn/tpbok0G1UNSiNtNH5wq9X4erdThA1ORUTilEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G30m4Xqn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732163719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mKMqxRLlVvUCqserKLr/Bagm1GzwWwOkUXng3lrWCp4=;
	b=G30m4Xqn+/rSo/MB7XeH+MeRBIxz8+OWL5o0cRtJH1dqKvS9UIjaheQS1vqfBn2+phdSZv
	qAALx7PWeirG2cs3i9roykkr6IlHLxK31v5f66H0x7UG0qB82SxszcfdHyF+/6GPHYwHh8
	PpK2MwnrvJDM+s7zIFKe2+jArZOiaWE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-NE4qc6erMmah3GjoeKhcQQ-1; Wed,
 20 Nov 2024 23:35:16 -0500
X-MC-Unique: NE4qc6erMmah3GjoeKhcQQ-1
X-Mimecast-MFC-AGG-ID: NE4qc6erMmah3GjoeKhcQQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51C9B19560AE;
	Thu, 21 Nov 2024 04:35:13 +0000 (UTC)
Received: from localhost (unknown [10.72.113.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77E3B30000DF;
	Thu, 21 Nov 2024 04:35:10 +0000 (UTC)
Date: Thu, 21 Nov 2024 12:35:05 +0800
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
Message-ID: <Zz64efFyFstyDdN8@MiWiFi-R3L-srv>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-5-david@redhat.com>
 <ZzcYEQwLuLnGQM1y@MiWiFi-R3L-srv>
 <ca0dd4a7-e007-4092-8f46-446fba26c672@redhat.com>
 <Zz2u+2abswlwVcer@MiWiFi-R3L-srv>
 <120bc3d9-2993-47eb-a532-eb3a5f6c4116@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120bc3d9-2993-47eb-a532-eb3a5f6c4116@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 11/20/24 at 11:28am, David Hildenbrand wrote:
> On 20.11.24 10:42, Baoquan He wrote:
> > On 11/15/24 at 10:59am, David Hildenbrand wrote:
> > > On 15.11.24 10:44, Baoquan He wrote:
> > > > On 10/25/24 at 05:11pm, David Hildenbrand wrote:
> > > > > These defines are not related to /proc/kcore, move them to crash_dump.h
> > > > > instead. While at it, rename "struct vmcore" to "struct
> > > > > vmcore_mem_node", which is a more fitting name.
> > > > 
> > > > Agree it's inappropriate to put the defintions in kcore.h. However for
> > > > 'struct vmcore', it's only used in fs/proc/vmcore.c from my code
> > > > serching, do you think if we can put it in fs/proc/vmcore.c directly?
> > > > And 'struct vmcoredd_node' too.
> > > 
> > > See the next patches and how virtio-mem will make use of the feactored out
> > > functions. Not putting them as inline functions into a header will require
> > > exporting symbols just do add a vmcore memory node to the list, which I want
> > > to avoid -- overkill for these simple helpers.
> > 
> > I see. It makes sense to put them in crash_dump.h. Thanks for
> > explanation.
> > 
> 
> I'll add these details to the description.

Thanks.

> 
> > > 
> > > > 
> > > > And about the renaming, with my understanding each instance of struct
> > > > vmcore represents one memory region, isn't it a little confusing to be
> > > > called vmcore_mem_node? I understand you probablly want to unify the
> > > > vmcore and vmcoredd's naming. I have to admit I don't know vmcoredd well
> > > > and its naming, while most of people have been knowing vmcore representing
> > > > memory region very well.
> > > 
> > > I chose "vmcore_mem_node" because it is a memory range stored in a list.
> > > Note the symmetry with "vmcoredd_node"
> > 
> > I would say the justification of naming "vmcore_mem_node" is to keep
> > symmetry with "vmcoredd_node". If because it is a memory range, it really
> > should not be called vmcore_mem_node. As we know, memory node has
> > specific meaning in kernel, it's the memory range existing on a NUMA node.
> > 
> > And vmcoredd is not a widely used feature. At least in fedora/RHEL, we
> > leave it to customers themselves to use and handle, we don't support it.
> > And we add 'novmcoredd' to kdump kernel cmdline by default to disable it
> > in fedora/RHEL. So a rarely used feature should not be taken to decide
> > the naming of a mature and and widely used feature's name. My personal
> > opinion.
> 
> It's a memory range that gets added to a list. So it's a node in a list ...
> representing a memory range. :) I don't particularly care about the "node"
> part here.

Ah, I missed that about list node. There are list items, list entries
and list nodes, I didn't think of list node at tht time.

> 
> The old "struct vmcore" name is misleading: makes one believe it somehow
> represents "/proc/vmcore", but it really doesn't. (see below on function
> naming)

Yeah, agree. struct vmcore is a concept of the whole logical file.

> 
> > 
> > > 
> > > If there are strong feelings I can use a different name, but
> > 
> > Yes, I would suggest we better keep the old name or take a more
> > appropriate one if have to change.
> 
> In light of patch #5 and #6, really only something like "vmcore_mem_node"
> makes sense. Alternatively "vmcore_range" or "vmcore_mem_range".
> 
> Leaving it as "struct vmcore" would mean that we had to do in #5 and #6:
> 
> * vmcore_alloc_add_mem_node() -> vmcore_alloc_add()
> * vmcore_free_mem_nodes() -> vmcore_free()
> 
> Which would *really* be misleading, because we are not "freeing" the vmcore.
> 
> Would "vmcore_range" work for you? Then we could do:
> 
> * vmcore_alloc_add_mem_node() -> vmcore_alloc_add_range()
> * vmcore_free_mem_nodes() -> vmcore_free_ranges()

Yeah, vmcore_range is better, which won't cause misunderstanding.
Thanks.


