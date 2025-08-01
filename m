Return-Path: <linux-fsdevel+bounces-56491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C98B17A9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD315546884
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE11C148;
	Fri,  1 Aug 2025 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpSZqEo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BBA8836
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008071; cv=none; b=USQMIwu1I6MJ90rtdfVWyJYAgSaw4keNErKox4J9f4VzH+OZ1bP864zRzri5ojaj5zIjpZjTWkyct/nbq1/Viy3mq2YbfbygPYpTLUaCRBx5mPr8kR9ZxCElU9/cVhtDCHjyP9IeTex7tlXsVySsSpjcpV6a1ltiCa2MQPqPuJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008071; c=relaxed/simple;
	bh=HC3usTS2S+/PkaI3JY632Hgytz8r+JxDOq5yIkXGNAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYWIvSmwE8s/5oMYrFlg9yInWB13pXZe8h0CS3dIwaHhHhvW6Ocd384my2FxLLGstWCODze7Q3Z8UqQnWnus6MkGu3kCDRyoZYZr1x7fJW39rV6yxm/ovhs4cLLkB22Mv6od3AKgVfYQN3zk/9rOh2W7KGR2lzS5AKjPEDThL9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpSZqEo2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2403ca0313aso8905265ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008070; x=1754612870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYAnpVPSM3LLyQtjDYj5TRGoiDVKef8f89fRro6Pb9o=;
        b=CpSZqEo2Q4yMQr2a4kPN1UBBsWoGUHnXt6Qa13ZHY2wvfNAUWQXov8zWMbpTnYFpC7
         1QfazxYGozIzQK4uYv5nfmPvAsIJ3E3+VBE+w5pG09guihF23h81vF6xI9PilpewFYsd
         JvbtVdTp9fs30G/MrKDnqsqhrJ+1CCYxdq2oPF/8TeSrJ+8RgwdoL5ic+yMiw9tYRaNo
         vds7XQSCLcP21bJsuX817E/e/zAVQ9ldjXHdmQRS0Bb5LFClg71WOkCIQ+wifOeqbjqk
         tZXjnH8uyMRVG3ZcJu5QIXYgCp/X12GvcOe+C+hjFj5IoWkzN5nwYF1vws1iLf4tx5Ir
         2w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008070; x=1754612870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYAnpVPSM3LLyQtjDYj5TRGoiDVKef8f89fRro6Pb9o=;
        b=S4GtuogXMSb/59kRUdttqbbbaQ/F4VE51TJLnsbIU5yo1mnIda20zPJBh/DEnxIbKa
         YfwwQbOBjVCUYxv4g1whnGG1k0R0O6lzZpuQ3sSxoGh/P+qJ6u622mohQeAULetF3jU0
         4p1MT+6pDk1IDx9Y883xrTy9XBXMaKyaH6FCdN+LQbVlshpIgO4dsT4S3V8hTHfU8TzS
         MCEgoJsNlYzMrxiM2Bw+iJgVpyXyvTCPfTM+2SNEFkI25myVG/Sn+B7FBcxr9Fos05fH
         6IsQCezz8PCsYA6lejLBeu/9nOgmJo3DkMKXIbSkuehsWr9SLfaU/5FjVrpoFE65ltFV
         cr+A==
X-Forwarded-Encrypted: i=1; AJvYcCUFWNIGxkYG72Q9lFYvraUMHz5AJkfyzIgvACa9+9Xw03vD5L4+K6IpevdmHkP28uHYchn3zX/sYbHOpjxF@vger.kernel.org
X-Gm-Message-State: AOJu0YzRGAEPXbPs0J5q5sReguKOdtt42wI186Gfmma2w3Al1MP9IVi9
	c68HOAXYpRzIsyOP7Q88QN/53fnHHVJtXA1MsRC7g2A/q2/Xg22sJk7X
X-Gm-Gg: ASbGncsrYb06ng7Pfho6BFBZHZHFwy9LfHYrFtxYjMkE7bxJzVG6Vccj/EOs2LHVUab
	REZ7VJHfvP+SCEzKneBsIrh3IA8Fzvu6eJYoH0ptnf58wmze/SuoIxARqHfOThmOmrAqAjaBREt
	nuyQ34VHjJsAbcQ9IU4UJuifa9+9NXe/K9c0bJSQIFH6Gf54gx+xb4h/4sdNiss3UxONxUXufk2
	m/ebRGdrcFFWFH5ZLXT7k8qTxDcT3YP/n7HNveZXlGXmFASwt3hRG8MCnAG9ha8o2ZAOlaqzXaM
	xPKTtCtRzFDBtnnatpNfbpxBuzHKBHRmh+P30DkIDH7byJxUotnoqLBSCvwfvg2L06GjUMQuwQj
	kFCfExV4Sk/hs29Xn
X-Google-Smtp-Source: AGHT+IHkgrfXMOK7E9hIh8oKAzasFFpQtlF6FHk/9SufKadLPTcGomsVFWYRnOkmWX9ISV04zDo81g==
X-Received: by 2002:a17:902:d492:b0:240:99d8:84 with SMTP id d9443c01a7336-2422a6d83f8mr8597165ad.52.1754008069628;
        Thu, 31 Jul 2025 17:27:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e81dsm28321855ad.46.2025.07.31.17.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:49 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 06/10] mm: add __folio_clear_dirty_for_io() helper
Date: Thu, 31 Jul 2025 17:21:27 -0700
Message-ID: <20250801002131.255068-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801002131.255068-1-joannelkoong@gmail.com>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __folio_clear_dirty_for_io() which takes in an arg for whether the
folio and wb stats should be updated as part of the call or not.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/page-writeback.c | 47 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a3805988f3ad..77a46bf8052f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2927,21 +2927,7 @@ void __folio_cancel_dirty(struct folio *folio)
 }
 EXPORT_SYMBOL(__folio_cancel_dirty);
 
-/*
- * Clear a folio's dirty flag, while caring for dirty memory accounting.
- * Returns true if the folio was previously dirty.
- *
- * This is for preparing to put the folio under writeout.  We leave
- * the folio tagged as dirty in the xarray so that a concurrent
- * write-for-sync can discover it via a PAGECACHE_TAG_DIRTY walk.
- * The ->writepage implementation will run either folio_start_writeback()
- * or folio_mark_dirty(), at which stage we bring the folio's dirty flag
- * and xarray dirty tag back into sync.
- *
- * This incoherency between the folio's dirty flag and xarray tag is
- * unfortunate, but it only exists while the folio is locked.
- */
-bool folio_clear_dirty_for_io(struct folio *folio)
+static bool __folio_clear_dirty_for_io(struct folio *folio, bool update_stats)
 {
 	struct address_space *mapping = folio_mapping(folio);
 	bool ret = false;
@@ -2990,10 +2976,14 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 		 */
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		if (folio_test_clear_dirty(folio)) {
-			long nr = folio_nr_pages(folio);
-			lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
-			zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-			wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
+			if (update_stats) {
+				long nr = folio_nr_pages(folio);
+				lruvec_stat_mod_folio(folio, NR_FILE_DIRTY,
+						      -nr);
+				zone_stat_mod_folio(folio,
+						    NR_ZONE_WRITE_PENDING, -nr);
+				wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
+			}
 			ret = true;
 		}
 		unlocked_inode_to_wb_end(inode, &cookie);
@@ -3001,6 +2991,25 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 	}
 	return folio_test_clear_dirty(folio);
 }
+
+/*
+ * Clear a folio's dirty flag, while caring for dirty memory accounting.
+ * Returns true if the folio was previously dirty.
+ *
+ * This is for preparing to put the folio under writeout.  We leave
+ * the folio tagged as dirty in the xarray so that a concurrent
+ * write-for-sync can discover it via a PAGECACHE_TAG_DIRTY walk.
+ * The ->writepage implementation will run either folio_start_writeback()
+ * or folio_mark_dirty(), at which stage we bring the folio's dirty flag
+ * and xarray dirty tag back into sync.
+ *
+ * This incoherency between the folio's dirty flag and xarray tag is
+ * unfortunate, but it only exists while the folio is locked.
+ */
+bool folio_clear_dirty_for_io(struct folio *folio)
+{
+	return __folio_clear_dirty_for_io(folio, true);
+}
 EXPORT_SYMBOL(folio_clear_dirty_for_io);
 
 static void wb_inode_writeback_start(struct bdi_writeback *wb)
-- 
2.47.3


