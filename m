Return-Path: <linux-fsdevel+bounces-59675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1070B3C5AD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF9E1B271A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A183148D4;
	Fri, 29 Aug 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyQuDydQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04792276025
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510802; cv=none; b=QvVHHhMZWOusbb99BSeNTHvy3Ckh6HrO/pLUPZoo1+SeSbEhthAzvP7KfzjOx/HC2D5pFzpjW9auVcBqx0jBG/EruxCcUTX8w1OK8ahGvgbj2udwY8t7Q7dWHmjZKRugmijyJG+oBdRPFWx4lRLpHdyO13VtuII1XIu9OO544S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510802; c=relaxed/simple;
	bh=M+T9m9Xx6RguMSC9d4nO5fUh1mUGJZwlhU2LeBuHIyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/3+0/YxfqivS400ikJFi+j7G7t9z51Vh915y3dQ7rvuNKLzLW7vVA1VYp5bVrUm3QXZPd9RE7eVNm//h1YGoOfnst6UmqOAx9+l8f4ko3yrCm+2e3lr9etgFF8orT2kSBpweV2GQGV8sS58m16J10JvCvTOnTREexuTTnq9pFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyQuDydQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b47174c3b3fso1608372a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510800; x=1757115600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9vAhGhcxjZCMU6jC7jJyh6R279hjjEZXVSFRANuKps=;
        b=ZyQuDydQNRiF4UuhifdNyY3LLmeFe6QaD8pa6+aLe2+cscEnBzUOTsPcFkIKP1haXq
         viBq/QOT9qu0HPZzx+Poaa2WaFsXwzASdNa11iJT6HXcWk4bYoikvabtz0HyqbMRV+tM
         4jJPTcw6c1SBbzXT7oFhxiTgcYnZgjwdM199DY05xjfF1GIsR4r+aqwJsNxlVwBQ3COc
         6UyTYUFSPPbGXsGlwSiQ7Pw73fATQxEZPzLucEuQyTkPDxPoD8e+VCUDqt4sEpuDkZmK
         QFrYTIAmI1xBUWciP5cwOlnh9zi7BYmp0RItEPOwTO/olI9o9LcbhESBlnSKEBmgZpRE
         J3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510800; x=1757115600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9vAhGhcxjZCMU6jC7jJyh6R279hjjEZXVSFRANuKps=;
        b=Jf7sS8Ue1pbDXQcKpEHapV7iBXSiWZ5N9CjTsA0SZLuXZN9EL46dWAaOFXeUBOgVgy
         T2hXdSWh9KvM30IRVNYbkjUzLfP9vM/uy0+f2VX098htZbK+8s+8HJq+2jze+/rQdodT
         g6jOvUqbvlAUYmLYX1PPpZIX/klrJzP7p3mqD51VU/aivWbU+e+/jSoZRTwCo8uZELBG
         DTZNnad5fl/obv58V6Ht+Fz1gbgVrM8jlQAXvWwye6CtiRi8kgXEUHDAnRi+c+1rDBMh
         oHiKmDksxH/tsa1lMceEW4Dfit9vDAEm7rROlryyyJdcFXfTiMbVfwNWiYUGGD/niZs6
         QuSg==
X-Forwarded-Encrypted: i=1; AJvYcCUDx4cOPOUAZj1VHN7TcSo1XmbaYzeL0JV4W+MJymsc9lLtcvZxr4ke0SFLmRWN1vUVQZviNbCKfpJtLDxM@vger.kernel.org
X-Gm-Message-State: AOJu0YxGPBAmJBdlQBXZl/6LSJx95Mr+dR+ARWd/lW6W+NcrcjSd6CbO
	hoy03SnFBOmgrHdkWqw4TEcC4vh/xyC1XF4DZdDO1aAj356wxB4x6bNvy6QVSw==
X-Gm-Gg: ASbGncv/YV2WsdB/Q5YSkuFkv+R0rrxsToEpjti4YsA8k0udho34JPdtstz7qkZKt0d
	V729ypE2j3Nk8PtmCMKACeGAhCK9+IoYMX3Fl8+INfiB8ehWARN7MpUkNe0FfO1MhWaTqgouTc+
	vlARq71SX0l8/JpjOUncEEPIRBbqDYN3PPfOdDjJt7AK+zXthQuYcWVDUlG2Dp4vPljP70VPRUl
	IYpN1r4QNAK0dTMSivSkv59lIWHk3Qr2iZXFTibjhokN51Jwqqe2/cUbtF+OhoUQMDFvS/A5HUc
	d7XOBaRHG0RBp83B3Mo7Y6VBAbprVqwZn/aNnjFLCq6shBJLx3BuHxLCfGKFO3m8JFbpLg7lrux
	6Mx42a3FcmtzEBnGM
X-Google-Smtp-Source: AGHT+IEj/qyquMZPhyxSDVLuBQwQxGQRpU8+69U/AvXMLMihrA3dNO0NerLtNZnudHsS9cVY7sCdjA==
X-Received: by 2002:a17:903:1d2:b0:249:3ba3:643b with SMTP id d9443c01a7336-24944b1e215mr4872465ad.36.1756510800311;
        Fri, 29 Aug 2025 16:40:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705b9dsm36117175ad.7.2025.08.29.16.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:40:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 07/12] mm: add no_stats_accounting bitfield to wbc
Date: Fri, 29 Aug 2025 16:39:37 -0700
Message-ID: <20250829233942.3607248-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829233942.3607248-1-joannelkoong@gmail.com>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a no_stats_accounting bitfield to wbc that callers can set. Hook
this up to __folio_clear_dirty_for_io() when preparing writeback.

This is so that for filesystems that implement granular dirty writeback
for its large folios, the stats reflect only the dirty pages that are
written back instead of all the pages in the folio, which helps enforce
more accurate / less conservative dirty page balancing.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/writeback.h | 7 +++++++
 mm/page-writeback.c       | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 0df11d00cce2..f63a52b56dff 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -71,6 +71,13 @@ struct writeback_control {
 	 */
 	unsigned no_cgroup_owner:1;
 
+	/*
+	 * Do not do any stats accounting. The caller will do this themselves.
+	 * This is useful for filesystems that implement granular dirty
+	 * writeback for its large folios.
+	 */
+	unsigned no_stats_accounting:1;
+
 	/* internal fields used by the ->writepages implementation: */
 	struct folio_batch fbatch;
 	pgoff_t index;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fe39137f01d6..294339887e55 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2402,6 +2402,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
+static bool __folio_clear_dirty_for_io(struct folio *folio, bool update_stats);
 static bool folio_prepare_writeback(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio)
 {
@@ -2428,7 +2429,7 @@ static bool folio_prepare_writeback(struct address_space *mapping,
 	}
 	BUG_ON(folio_test_writeback(folio));
 
-	if (!folio_clear_dirty_for_io(folio))
+	if (!__folio_clear_dirty_for_io(folio, !wbc->no_stats_accounting))
 		return false;
 
 	return true;
-- 
2.47.3


