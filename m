Return-Path: <linux-fsdevel+bounces-51495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E2DAD7401
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C58B7A9C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B3624DCFC;
	Thu, 12 Jun 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b2DvTBwd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2186B248881;
	Thu, 12 Jun 2025 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738900; cv=none; b=Dgd/RR0Relx9t86PKtSL+GOUthtt3j4yd3+LSsh4wNCX3edL4M+HAnkRSxu1TKXuTgP0kYJu8RqhwmqFttIJZWm3ioVkVA4OgRmfJo6+dldMQlsRQYQbIaqAjal8A+PigwFoR1YCMDVdHDiALrKv0Z693PocI6WCrHypKrTM5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738900; c=relaxed/simple;
	bh=W27rAXQBgmSJgNvbkagprMUfgcjSNiWdesCH1RWMGSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCs20hptTavh07dGL4EUQli7bANqre1TYlZDKQippZ/DwN5Fd7MgXCCf9IrlYHdBPXQNC8J62EeOCNn0o9zvP01fhvqN+vRVyHelav2lQSqcMf/hjrmbL1KFkpdLGhR7tFCaSvj3q1a7mibvqENIUFUOv/Apd/Inj3WqnlkdXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b2DvTBwd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=vaww2O2RMJGbClpfrNfPXLRtpeJrGqIgymueWQJvJBA=; b=b2DvTBwd6D1KpFhyWpRU3klDd0
	UVNNzy++VS0njSCmhhdu/V75gUGpY3hEXgIkHdpB+d35AX1ekbtdN0LXsGerAyOReJJJlP4Q3Z/Nz
	GeWfx7uV+zID5lmnjpCEDijFUFl0CC8J4uU9fYU3yhSReur4y9ewMWfuvWb/kwIXOJ1ZIO1q94eTm
	K1Hu/Qe//aNqHl0rc1qS8NulSU06udUbHLfeB7pKUhVoYE6aJutoaYPZMVGrQEAL1KPNyjjUIiXaa
	YbSSUrIkWExvmk+UisPYRggYvL+Ixo5qvUvTqbb4cIvmQ4+Wwgk+HfFhvPhiRkRVbxORsdO8k5rOU
	tLJrP9uw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj0y-0000000Bwww-0Rd9;
	Thu, 12 Jun 2025 14:34:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Ira Weiny <ira.weiny@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] Remove zero_user()
Date: Thu, 12 Jun 2025 15:34:36 +0100
Message-ID: <20250612143443.2848197-1-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The zero_user() API is almost unused these days.  Finish the job of
removing it.

Matthew Wilcox (Oracle) (5):
  bio: Use memzero_page() in bio_truncate()
  null_blk: Use memzero_page()
  direct-io: Use memzero_page()
  ceph: Convert ceph_zero_partial_page() to use a folio
  mm: Remove zero_user()

 block/bio.c                   |  4 ++--
 drivers/block/null_blk/main.c |  2 +-
 fs/ceph/file.c                | 21 ++++++++++-----------
 fs/direct-io.c                |  2 +-
 include/linux/highmem.h       |  6 ------
 5 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.47.2


