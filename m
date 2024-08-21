Return-Path: <linux-fsdevel+bounces-26540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC14895A556
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0ED1C21CC3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA2716F8FE;
	Wed, 21 Aug 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ac7hRec5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5989816F0C4
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268898; cv=none; b=i93BGwgzKJ8UDmmJS9uGP7VSb2KdXqcJzPkickGAZ6cJ7P4/y5JRV7iFSEYBJmsw/N2KMznyF1A1oLAGJCexzLVgTzNgYLl83ckvidvxd0RkgVrjCkPwHTscvv5VY2UJprlTtAg7586klVgv2EXUtuURe6lGzDHduIfjQNRM/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268898; c=relaxed/simple;
	bh=lNKt4V56oMxsNnutL9lyEWm2N44IF0aMSbqrr9OfdK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAP0XD7GlntPUesc8oij3T9sk3OYWxV4jFAOvfhwA4rUGhucciZxeW5gKSCXMkoouMjpAWvMJtoL/VS1CpiFAecCjy28It1VnTyUpy1fW3T5s/I6UTX5d39eBNLotdOfYvOMw+SQRuC3wOPLi4mn2WcdqQ7Wc4gR07dCEsjbc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ac7hRec5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=53G7OQRwRv/Iqta75K6HOo9hAeq2ZQbXgYcT30n+x1I=; b=ac7hRec5l1qkplqKAShlhlL3eQ
	Cjdh/PvoshoWa7liYUNyRh3yG2ZO/0zkkQuCF44wBDMsc7ywxUQvm3oefETB0EkATv0KOj+vwpA2F
	2FsO6Ll3fAy6V2wZCSgWKggEUtd96EkKur+9ISSFgjlzifLniEIyjx7mAxvKGsStQzW5vXQdUCkoF
	xAF5xG0Hyn4jjU4B+HWx9MKPuGiKV8JDGPMqtRUz/CgvZMHikKm/q3S2a/o+29xRSpflvKZxWvAtM
	vf6GccwSogOh3RtqSKEjuWOkkIM4Oe51iRNcLpd49Z/Fv/u5hUdwRvLJR8dVr/VWpALKz07rV6NtQ
	X2q7K+/A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6V-00000009cqn-1Y31;
	Wed, 21 Aug 2024 19:34:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 07/10] mm: Remove PageOwnerPriv1
Date: Wed, 21 Aug 2024 20:34:40 +0100
Message-ID: <20240821193445.2294269-8-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821193445.2294269-1-willy@infradead.org>
References: <20240821193445.2294269-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While there are many aliases for this flag, nobody actually uses the
*PageOwnerPriv1() nor folio_*_owner_priv_1() accessors.  Remove them.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index f1358f86a673..5112049cc102 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -539,8 +539,6 @@ FOLIO_FLAG(swapbacked, FOLIO_HEAD_PAGE)
  */
 PAGEFLAG(Private, private, PF_ANY)
 PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
-PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
-	TESTCLEARFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
 
 /*
  * Only test-and-set exist for PG_writeback.  The unconditional operators are
-- 
2.43.0


