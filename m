Return-Path: <linux-fsdevel+bounces-30643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC77E98CBCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 06:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3A0B23BC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 04:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18511805E;
	Wed,  2 Oct 2024 04:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6MdfR+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C3B15D1;
	Wed,  2 Oct 2024 04:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841677; cv=none; b=ee9iB1c/d2By4Z/OK7b7L3LwU7i53Tdqfd0cvtYzyz8wwH6wokktt3kKTue/fa7W5UicVbq9cJZeYRAHMzTyN9iNVa5zAfiozwaiKJB65Q/pioIYmfy4OVf72HOwI52cvFutIw7vRnAgN1LEizXhB1l9eAc97w20jWDzMpvJVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841677; c=relaxed/simple;
	bh=OjJNayQyIsOxVaiwEevcOS/xZRvyvgv2MlGE6rZoHRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCK4v8i53BiXDQfMo03C42Y0+fDNBNemXsWmK7uDC2HO2rpdisYuYvhQwgmbDfhAekcTTwQTPkbAMLrswdnndI42eL9ogEQ7LwUkND4/u9ug8+QShY4bL7R4bQXgYBwO484LxEH1ptUm3uP9e1gD8GD+S31MAEb920w0tVhe66U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p6MdfR+L; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=RZtLvBtTcdvfSoyXcG5LTLDVsxK5mD1QMTXUY1VvVY0=; b=p6MdfR+LNPnRPI/OEyTwrpvMUq
	tsBnav1lqFiVSXudJ8Zq6EKC3QZLrdtheHJ+BzBZMFXIf3JZ2DwCp9CgwNlEl07aevt6ZHFM73/sq
	zrCWD9jWC2LSHyoGCiX1lCu0e+sgAS0/UHNwXjeFvN7sGaAlPmDEREPK/mIpYafLU6h09isyY58vm
	Z33AkjNKYlB4QrcxeamNvEPDZqJBnd7JHpnx0juN7a15Q5nJQvEQFZL2RByf9UB7pzdycS+da/suk
	nPxxcinkIAWJl2+t1ZDs9CmWkDahoJDxIWsSZrKUnYwUH11I2LuMonIYZ005MzY13WJYRVa1AY3Mu
	THXtD+Gw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1svqY5-00000004I8X-3Vr7;
	Wed, 02 Oct 2024 04:01:13 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/6] mm: Remove PageMappedToDisk
Date: Wed,  2 Oct 2024 05:01:05 +0100
Message-ID: <20241002040111.1023018-4-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002040111.1023018-1-willy@infradead.org>
References: <20241002040111.1023018-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers have now been converted to the folio APIs, so remove
the page API for this flag.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1b3a76710487..35d08c30d4a6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -554,7 +554,7 @@ FOLIO_FLAG(owner_2, FOLIO_HEAD_PAGE)
  */
 TESTPAGEFLAG(Writeback, writeback, PF_NO_TAIL)
 	TESTSCFLAG(Writeback, writeback, PF_NO_TAIL)
-PAGEFLAG(MappedToDisk, mappedtodisk, PF_NO_TAIL)
+FOLIO_FLAG(mappedtodisk, FOLIO_HEAD_PAGE)
 
 /* PG_readahead is only used for reads; PG_reclaim is only for writes */
 PAGEFLAG(Reclaim, reclaim, PF_NO_TAIL)
-- 
2.43.0


