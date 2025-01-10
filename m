Return-Path: <linux-fsdevel+bounces-38879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E36A09646
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21D9188D8AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94692211A05;
	Fri, 10 Jan 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nXkOUhBM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE42063E3;
	Fri, 10 Jan 2025 15:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524033; cv=none; b=t7xGu0aq2asQAXtL18A91NpE2Ehnvau18INLDPK1q25EgnnTgzmCTS+tQ4ra3uYEKgLx1Te8+kdNY+e0w7ZWHDomceZoA5Eb07LrLPA57GIRc9wJA+Ga6VJWdPdtSIk6NjqiOcPh/gpJnkNCNX1nhJ55eUeo9qInk1byKrUtZqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524033; c=relaxed/simple;
	bh=YWN9WWmaVJy6ANwDwQC3AtUSHAXq+7OebIiASUtISLQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iceWxbGGj+Dm+8KILupQG+zx+vEhhoyTIf8JMzeFrKcOVnHPftwtkNOszJiCYaRRO+YiRu4MqcqqL9ZMtwxv9VOnu5ydmOwSNYfG+xhP09M28GQgqqWyZX5FmzqjGy4cejTTIChHwlBR3nrYjiqnFwmla2n58w+nevagFSLZ7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nXkOUhBM; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736524031; x=1768060031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vieCYRbHQr8ti5sbtbp4BprSH2wVytUDu3n2fMb58+U=;
  b=nXkOUhBMpp7htraXHBSQZcj0WVMZb4MtfpgQBM28Qyzez94rYBbxcJfG
   m0FdqvZEEt/0STfO/g4GmTaIRRmxp8m/ZC9rsVcxosGhqTDhGnaymCa8S
   dWJ7obKutASrlAM62Vx+BeNPDXi6hVWC6ao7aYrZD5ZS8Yl9ISKA5K+2J
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="709972795"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 15:47:07 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:8609]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.17:2525] with esmtp (Farcaster)
 id bb1cc44d-cda3-4cca-9ac4-269129b53c73; Fri, 10 Jan 2025 15:47:06 +0000 (UTC)
X-Farcaster-Flow-ID: bb1cc44d-cda3-4cca-9ac4-269129b53c73
Received: from EX19D020UWA004.ant.amazon.com (10.13.138.231) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 15:47:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWA004.ant.amazon.com (10.13.138.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 15:47:01 +0000
Received: from email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Fri, 10 Jan 2025 15:47:01 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1b-1323ce6b.us-east-1.amazon.com (Postfix) with ESMTPS id CCC1F405B0;
	Fri, 10 Jan 2025 15:46:59 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <willy@infradead.org>, <pbonzini@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <michael.day@amd.com>, <david@redhat.com>, <jthoughton@google.com>,
	<michael.roth@amd.com>, <ackerleytng@google.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>, <kalyazin@amazon.com>
Subject: [RFC PATCH 0/2] mm: filemap: add filemap_grab_folios
Date: Fri, 10 Jan 2025 15:46:57 +0000
Message-ID: <20250110154659.95464-1-kalyazin@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

Based on David's suggestion for speeding up guest_memfd memory
population [1] made at the guest_memfd upstream call on 5 Dec 2024 [2],
this adds `filemap_grab_folios` that grabs multiple folios at a time.

Motivation

When profiling guest_memfd population and comparing the results with
population of anonymous memory via UFFDIO_COPY, I observed that the
former was up to 20% slower, mainly due to adding newly allocated pages
to the pagecache.  As far as I can see, the two main contributors to it
are pagecache locking and tree traversals needed for every folio.  The
RFC attempts to partially mitigate those by adding multiple folios at a
time to the pagecache.

Testing

With the change applied, I was able to observe a 10.3% (708 to 635 ms)
speedup in a selftest that populated 3GiB guest_memfd and a 9.5% (990 to
904 ms) speedup when restoring a 3GiB guest_memfd VM snapshot using a
custom Firecracker version, both on Intel Ice Lake.

Limitations

While `filemap_grab_folios` handles THP/large folios internally and
deals with reclaim artifacts in the pagecache (shadows), for simplicity
reasons, the RFC does not support those as it demonstrates the
optimisation applied to guest_memfd, which only uses small folios and
does not support reclaim at the moment.

Implementation

I am aware of existing filemap APIs operating on folio batches, however
I was not able to find one for the use case in question.  I was also
thinking about making use of the `folio_batch` struct, but was not able
to convince myself that it was useful.  Instead, a plain array of folio
pointers is allocated on stack and passed down the callchain.  A bitmap
is used to keep track of indexes whose folios were already present in
the pagecache to prevent allocations.  This does not look very clean to
me and I am more than open to hearing about better approaches.

Not being an expert in xarray, I do not know an idiomatic way to advance
the index if `xas_next` is called directly after instantiation of the
state that was never walked, so I used a call to `xas_set`.

While the series focuses on optimising _adding_ folios to the pagecache,
I was also experimenting with batching of pagecache _querying_.
Specifically, I tried to make use of `filemap_get_folios` instead of
`filemap_get_entry`, but I could not observe any visible speedup.

The series is applied on top of [1] as the 1st patch implements
`filemap_grab_folios`, while the 2nd patch makes use of it in the
guest_memfd's write syscall as a first user.

Questions:
 - Does the approach look reasonable in general?
 - Can the API be kept specialised to the non-reclaim-supported case or
   does it need to be generic?
 - Would it be sensible to add a specialised small-folio-only version of
   `filemap_grab_folios` at the beginning and extend it to large folios
later on?
 - Are there better ways to implement batching or even achieve the
   optimisaton goal in another way?

[1]: https://lore.kernel.org/kvm/20241129123929.64790-1-kalyazin@amazon.com/T/
[2]: https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0

Thanks
Nikita

Nikita Kalyazin (2):
  mm: filemap: add filemap_grab_folios
  KVM: guest_memfd: use filemap_grab_folios in write

 include/linux/pagemap.h |  31 +++++
 mm/filemap.c            | 263 ++++++++++++++++++++++++++++++++++++++++
 virt/kvm/guest_memfd.c  | 176 ++++++++++++++++++++++-----
 3 files changed, 437 insertions(+), 33 deletions(-)


base-commit: 643cff38ebe84c39fbd5a0fc3ab053cd941b9f94
-- 
2.40.1


