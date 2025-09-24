Return-Path: <linux-fsdevel+bounces-62549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07391B990AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3400B4A8219
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 09:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083EF2D592A;
	Wed, 24 Sep 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u/e7wKxd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0310D28136C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705006; cv=none; b=Pt3xMOAxuIRawcViBT51yp1kEWQ0EpdMwsw0Odu6JMmYXsdUbN68RgxRKjuwgyViuXnBbraoPIkvJoNMCBn0Upp1jQCfDSYxjdFwklZFqlIVwL2AeZ0rIx1NvbMEVyJP/jjV4xa6DsorJBEJBisDHamOno1lAyNiavmSt+739Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705006; c=relaxed/simple;
	bh=bUFcv1AI2vMBrEDYmFsq2eLXZavPp5G/VZ4b+d6AKYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5x1ZryYWh0Sgw4PQwqSoItd1bB17TRnlzkhByHUsm0veOsYePNWw0BGmhavOAHVHeHREl/+9ZldJoWjke7Hj98INfn39HstG9ecBlucNwXovoYR+S5KerQmI1bUok4rKZN2bklI0XzSMkzDmoTY4hTrenKZGXDPckG0IJFduYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u/e7wKxd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=QLVI3b5hHVluV+B01LkKdLym1ToUzJEtzIeookSK1RM=; b=u/e7wKxdpUME6ehbK4qcS2TCR8
	BPN99CngTeCjuyf+8gnd5Ldvv2mhgV0UviAZkNvf9VWRveVY9RH5Vtpj2NFnc8fFkqfNnsyDNBG7v
	ruvH/bs1Rx0QKVy7fX3Ped2AQur4e5abskq0PIlmOqHwrdhhD8fr1Giocm4GZLb5GhNRlcF2hZHsL
	Qw+i7EEeEVeqZ3xax5Sy+qO1zNXyobAdDUFABMfNDDdb/Y7Qn3qJTtA/op+kU2FYkivXWPlEfWSeF
	7Nf/G7QfT7AJa9PcyTLEwFrxgrkV6SF/6hqVrlT9IfweJ9Y9rQ0Khj3afJh60gwc0OVCWGAje0MpT
	fWiNCP1g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LVj-0000000CXGX-09qQ;
	Wed, 24 Sep 2025 09:10:03 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>
Subject: [RFC PATCH 1/2] Add in_reclaim()
Date: Wed, 24 Sep 2025 10:09:56 +0100
Message-ID: <20250924091000.2987157-2-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924091000.2987157-1-willy@infradead.org>
References: <20250924091000.2987157-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is more meaningful than checking PF_MEMALLOC.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/sched/mm.h | 11 +++++++++++
 mm/page_alloc.c          | 10 +++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2201da0afecc..a9825ea7c331 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -468,6 +468,17 @@ static inline void memalloc_pin_restore(unsigned int flags)
 	memalloc_flags_restore(flags);
 }
 
+/**
+ * in_reclaim - Is the current task doing reclaim?
+ *
+ * This is true if the current task is kswapd or if we've entered
+ * direct reclaim.
+ */
+static inline bool in_reclaim(void)
+{
+	return current->flags & PF_MEMALLOC;
+}
+
 #ifdef CONFIG_MEMCG
 DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 /**
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1d037f97c5f..d27265df56b5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4220,7 +4220,7 @@ static bool __need_reclaim(gfp_t gfp_mask)
 		return false;
 
 	/* this guy won't enter reclaim */
-	if (current->flags & PF_MEMALLOC)
+	if (in_reclaim())
 		return false;
 
 	if (gfp_mask & __GFP_NOLOCKDEP)
@@ -4455,10 +4455,10 @@ static inline int __gfp_pfmemalloc_flags(gfp_t gfp_mask)
 		return 0;
 	if (gfp_mask & __GFP_MEMALLOC)
 		return ALLOC_NO_WATERMARKS;
-	if (in_serving_softirq() && (current->flags & PF_MEMALLOC))
+	if (in_serving_softirq() && in_reclaim())
 		return ALLOC_NO_WATERMARKS;
 	if (!in_interrupt()) {
-		if (current->flags & PF_MEMALLOC)
+		if (in_reclaim())
 			return ALLOC_NO_WATERMARKS;
 		else if (oom_reserves_allowed(current))
 			return ALLOC_OOM;
@@ -4627,7 +4627,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		 * because we cannot reclaim anything and only can loop waiting
 		 * for somebody to do a work for us.
 		 */
-		WARN_ON_ONCE(current->flags & PF_MEMALLOC);
+		WARN_ON_ONCE(in_reclaim());
 	}
 
 restart:
@@ -4774,7 +4774,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 		goto nopage;
 
 	/* Avoid recursion of direct reclaim */
-	if (current->flags & PF_MEMALLOC)
+	if (in_reclaim())
 		goto nopage;
 
 	/* Try direct reclaim and then allocating */
-- 
2.47.2


