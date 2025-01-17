Return-Path: <linux-fsdevel+bounces-39555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDAEA158E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 22:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4E8188CC43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1F31AB51B;
	Fri, 17 Jan 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBnDzaCl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CAB1A0711
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 21:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148625; cv=none; b=M6BaUgLQWb2nWqZq7LHVgzSoVT+Mb8XVbKxTIPK/zSoaze82QjuhcTsHl3vPMznfeYViwvRBfXtfHz9RRdtxDSQbScHgnESxbjzdGR+ddO1rIGG0y8DbvfVd0F/a2QQps+LQElDi51tUovHtDfMYuP+bC9VDJE4aLVsDG2S1xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148625; c=relaxed/simple;
	bh=CwBmFP/YMO6KqmY3VctOWXN30/ZzmGRzxM1I81yc9Po=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=oI+YGAcJuVE1/k1c9yViu8ypA3eKJF/69T31mCdG0g5+3Ijtg3UDqexVz6Pshp2y/hTy9VtrJOeDTmyrVZ/jgVZyG1JG7u3OwmaCMCfki/F3yqfyrU0GRk/OvJBNZgpYftC3QBEKwZhxnCGAmZCtXgGUWGPrI3OxmOv7Eo9aqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBnDzaCl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737148622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Ua0SGNyvuT1kxIzy+RNpyrvAiXO1J40KcJJ7nVEy62M=;
	b=FBnDzaCly7/qcepkXR+paditHrNO/rwuawypZ9hLfwGF8i0pRRvkRTTM7KltRMHOs//YfT
	VLOFV2wP9/CfoFAbMI+33JxUlapshQT75ztExAN7OtpObzEboDrUd89DP0THL/FOhHsiAh
	hGIfsMRCkijUhRLZvDyinFLRrtuu+No=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-qpBZ4n8tNsygLAgiGWDXSw-1; Fri,
 17 Jan 2025 16:16:59 -0500
X-MC-Unique: qpBZ4n8tNsygLAgiGWDXSw-1
X-Mimecast-MFC-AGG-ID: qpBZ4n8tNsygLAgiGWDXSw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49CCA195608A;
	Fri, 17 Jan 2025 21:16:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E786719560BF;
	Fri, 17 Jan 2025 21:16:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: lsf-pc@lists.linux-foundation.org,
    John Hubbard <jhubbard@nvidia.com>,
    Matthew Wilcox <willy@infradead.org>
cc: dhowells@redhat.com, brauner@kernel.org,
    Herbert Xu <herbert@gondor.apana.org.au>,
    linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
    linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Improving iov_iter - and replacing scatterlists
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <886958.1737148612.1@warthog.procyon.org.uk>
Date: Fri, 17 Jan 2025 21:16:52 +0000
Message-ID: <886959.1737148612@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi,

I'd like to propose a discussion of two things: firstly, how might we improve
iov_iter and, secondly, would it be possible to replace scatterlists.

[*] First: Improvements to iov_iter.

I'm trying to get rid of ITER_XARRAY; xarrays are too unstable (in the sense
that their contents can shift under you).

I'm trying to replace that with ITER_FOLIOQ instead.  This is a segmented list
of folios - so it can only hold folios, but has infinite capacity.  How easy
would it be to extend this to be able to handle some other types of page, such
as anon pages or stuff that's been spliced out of network receive buffers?

Would it make sense to be able to have a chain of disparate types of object?
Say a couple of kmalloc'd buffers, followed by a number of folios, followed by
another kmalloc'd buffer and mark them such we know which ones can be DMA'd
and which ones must be copied.

Currently, the core iteration functions in linux/iov_iter.h each handle a
specific type of iterable.  I wonder how much performance difference it would
make to have each item in a list have its own type.  Now, I know, "try it and
see" is a valid suggestion here.

Rumour has it that John Hubbard may be working along similar lines, possibly
just in the area of bio_vecs and ITER_BVEC.


[*] Second: Can we replace the uses of scatterlist with iov_iter and reduce
the number of iterator classes we have?

One reason I'd like to do this is we have iov_iter at user end of the I/O
stack, and it percolates down to various depths.  For network filesystems, for
example, the socket API takes iov_iters, so we want to plumb iov_iters all the
way down if we can - and have the filesystem know at little as possible about
folios and pages if we can manage it.

However, one thing that particularly stands out for me is that network
filesystems often want to use the crypto API - and that means allocating and
constructing a scatterlist to talk to the crypto API.  Having spent some time
looking at crypto API, in most places iteration functions are used that mean
that changing to use an iov_iter might not be so hard.

That said, one thing that is made use of occasionally with scatterlists is the
ability to chain something on the front.  That's significantly harder to do
with iov_iter.

That that said, one reason it's hard to modify the list attached to an
iterator is that we allow iterators to be rewound, using state stored in the
list to go backwards.  I wonder if it might be possible to get rid of
iov_iter_revert() and use iterator copying instead.

David


