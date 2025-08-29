Return-Path: <linux-fsdevel+bounces-59676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCEBB3C5AC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC435A257A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CC53148DD;
	Fri, 29 Aug 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw7QySqQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE61263C8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510803; cv=none; b=SSVF86wCnPOeaK3/pH0w3kKYGcb/8iGApcDa3xlQPEpsBV+Su37/RXNbxNAgGcW07bsqQ+gfmskYixMeOQqnQnbyq6AuXLnBHnea2graryJc1JfLcR8ryjzEmZz5SPozZ6eZ8uxn1/5C0LCM2gf7IQAvAUI1TQGdcqJ9gFQVIzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510803; c=relaxed/simple;
	bh=qzW2YvDlj4vQdYziiTKm9hOkWkGtw1S4c83RQ2Wo4pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kwX1VDt5szDfrXv9KLdvCVYCYSEJctDNLzSSTcZv6qi0ksFZ3tbjKjWGl6TZFQt7iszvcLqGXs4N/qujFQb0vMJElulP/4kyfjSeLU3+ekTkdiiO81ef1X3dpspOfaZKXY7+a+16bdUGxaCCSjCMxO7I8LROjlNs3dEOrvlw34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw7QySqQ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7723bf02181so261121b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510802; x=1757115602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDOVsGW/zxQGKiK09vhXrIhDtQw5LWrjTXPZUwXjB7M=;
        b=bw7QySqQcf6fALcNAs6W0OlVfOHXFwkRc+i37+dxC75YT2O1XjdAldBhEcTLslCpDY
         lW1uwRc3kESkJoPvw6jtn35q0lHT8vunUNgpPX6vpegNISHzOQe65ICPVF8IeMOPaOkU
         hzxWVxXDrOjQ3aHlNKAAjll7I5i0T1v8enoyHREkI0PpdnFO1h0hN8CiBT00K8Rob+A9
         JW4+PEHzzD4H2d0IU0oCZLNA+p8Qdfo45PwvqR0fGT1q3PfMvSIb6XHRVEQQ7alU7ncE
         DPq9XK7zJzM959dcxaC8ZcHme21O+DUYC2A7llq92fcRrkRxJ37R9L62gCdJVgjyc95V
         lujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510802; x=1757115602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDOVsGW/zxQGKiK09vhXrIhDtQw5LWrjTXPZUwXjB7M=;
        b=b4kJrLmMSNMBSE2/B4+D2CnU70c5n12JFv5Rqm/m+3ZY9zvMpCh+FK5pQ7WgXvG5HU
         hyonHoZfSwv3Q7xIIhEN8ZCJNQLjT819Zhh9NpCM1OFVtqOnIyI81RSkQLTcz5JH87ve
         taIkPPn7Y1k7fm1ESojSuaS/knI88IgFrena08Oixu6Ur89rhjSEv6jLHunWEX0tjcKD
         eXDNRGPqdY1aWEvYk/SiWNt8vD5/CbIo/88X2jezmw3TcC1Wug9SHjnLM9v4S0E1nJ7Y
         WpROhEYBp/juf6cC1G29SX2ngo4j7svhvcvKhVylqwMRnzw46efS1v/BtdmKfwE1knqq
         76PA==
X-Forwarded-Encrypted: i=1; AJvYcCWbQi4sa/g/XbfiqUu50FcG+WN7XRTSmnCK15urK1ELz7UDgerCGKf2587yZ744VmGE3c4CsgvSh9MaW6eX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5uXkngCIzbbCvaeQGvaoUGT0Y20J4JZm0M9e3+R41Vx+sFA9
	td57G4UeW7AWxYM3kK9k3l2j2rkZQ4RiOJXYdUt7a7gAWHdswjUjdAYZ
X-Gm-Gg: ASbGncuQo0sUAIZmYb/me18+Xad+yhPoCNW3sJZTdqHlZEnn7wyFe9CeODwRsAZ36LU
	157LgoWv5npm1K/2VHmNTi6+pjflxU8yUH6PGv4IGYOHDXoCIbUaC0xTi9lVCsuDsQhyGhN89Q+
	JvK7Wv1bM5EYdC0Adh94c6Qi0fYI13KeprBZWBCeD4iCAek0+8x0vB8SvOZIOSLmHNgmns+MVB2
	+1SXRmk9k/0WppF4grTcl+Hn/TULoy5UnQuctAk2t9OjfEM/F6nGeBVhkaOd1vVPINmBnRGmbAR
	8z3XdmlajbbGsjIxySOOvia8+bFVJU1kfDHPJcbBz8UCf8h+rNlqfyhmNypD4dqpzQuSDLjV7lR
	FnegNcMQXf80ZqA7dCQ==
X-Google-Smtp-Source: AGHT+IEbyQ6GiY2kX+wUqgiABadDR1yhCyF2V3uBRHeeHLqCYES9oeoO+QyBVv/mT87GxNG57KKBQA==
X-Received: by 2002:a17:902:d4cb:b0:249:3049:9748 with SMTP id d9443c01a7336-24944a98207mr4524235ad.35.1756510801830;
        Fri, 29 Aug 2025 16:40:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903704379sm36315105ad.29.2025.08.29.16.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:40:01 -0700 (PDT)
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
Subject: [PATCH v2 08/12] mm: refactor clearing dirty stats into helper function
Date: Fri, 29 Aug 2025 16:39:38 -0700
Message-ID: <20250829233942.3607248-9-joannelkoong@gmail.com>
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

Move logic for clearing dirty stats into a helper function
both folio_account_cleaned() and __folio_clear_dirty_for_io() invoke.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 mm/page-writeback.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 294339887e55..e0410cfbe480 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2701,6 +2701,14 @@ static void folio_account_dirtied(struct folio *folio,
 	}
 }
 
+static void __clear_dirty_for_io_stats(struct folio *folio,
+			struct bdi_writeback *wb, long nr_pages)
+{
+	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr_pages);
+	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr_pages);
+	wb_stat_mod(wb, WB_RECLAIMABLE, -nr_pages);
+}
+
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
@@ -2709,9 +2717,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
 {
 	long nr = folio_nr_pages(folio);
 
-	lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
-	zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
-	wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
+	__clear_dirty_for_io_stats(folio, wb, nr);
 	task_io_account_cancelled_write(nr * PAGE_SIZE);
 }
 
@@ -3005,14 +3011,9 @@ static bool __folio_clear_dirty_for_io(struct folio *folio, bool update_stats)
 		 */
 		wb = unlocked_inode_to_wb_begin(inode, &cookie);
 		if (folio_test_clear_dirty(folio)) {
-			if (update_stats) {
-				long nr = folio_nr_pages(folio);
-				lruvec_stat_mod_folio(folio, NR_FILE_DIRTY,
-						      -nr);
-				zone_stat_mod_folio(folio,
-						    NR_ZONE_WRITE_PENDING, -nr);
-				wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
-			}
+			if (update_stats)
+				__clear_dirty_for_io_stats(folio, wb,
+						folio_nr_pages(folio));
 			ret = true;
 		}
 		unlocked_inode_to_wb_end(inode, &cookie);
-- 
2.47.3


