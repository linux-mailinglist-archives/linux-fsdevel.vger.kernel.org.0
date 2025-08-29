Return-Path: <linux-fsdevel+bounces-59674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3850B3C5AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEDA3BD693
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FD3148C0;
	Fri, 29 Aug 2025 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEI+ub6H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CF263C8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510801; cv=none; b=QU1du0XYj5Ssq2ZPaIwa1zWSqWlMgiHCQalR7X3dO0EE5Q3lYgiYO9HLRJOLVEKXLCc2HZEYeRtIbYsXrAIKCEP8i3lSTNEXtiNAlO0AfMMBxSwl4IZKhqAqFvAWHXtDbZ3Yf0cPIN9wt9ldKraJww/2CaLtjJ8bR6wQEa7yzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510801; c=relaxed/simple;
	bh=KVg8QQfD5mw4d16Kum5Xjrj5SGvh26x1O/GaFfpm6KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jjikq0ppbZllyiNhyZJub4GLKp2A8upkSt3rA7IuT0P3pjievzGP/KA+eDAES33Y6JP4IY9jEHfdys/2qj13GEwr6qUF4d5H3398D4yBF1Il+5q5Z7COEFSxg1eKLZUKhb8jgKA3rukcxxqu4XWlhZX55CvxkqWgwJJrwUnJTM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEI+ub6H; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445827be70so29198275ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510799; x=1757115599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujf8I+1Zg/6WW7rH/KitWZGTR+3mmN+VDaryGANFrlk=;
        b=QEI+ub6HRkOfJoJSHSiyCsB9u/1kM5JGJyojoZI3Wb3y/RyOzVeZNTK+OpOOqhBlyq
         xuAkpwogSvqnAzx2wdQmHmJMw2SODEUfrdVr4ftM03fhbyMX/qkmJlc+ZAory9HcfwJd
         hDEhCXNn7MS1CHdT43ipf6J05gy9ElsYnN6x++4653X6waLRsDyZwJ5DcVoqSjrCvWNK
         EVc9ogryS9FRKqI3EqqATEnN2daeXqiLBwPg6D/FWFeQW/Lkxfu69je8AjN3P6SBiAWb
         boIx+hM1xdmMBFzaZyoPPfQDj9X9qoJtKkAVkEl29BXY7tK8guAvQHW2JwVx8VtUcBUp
         1Wjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510799; x=1757115599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujf8I+1Zg/6WW7rH/KitWZGTR+3mmN+VDaryGANFrlk=;
        b=Uv1Ai/jwEYM/X3Yv4Z/Jet3p0Bda+meUpCyoQtvb6XR8e5mgKGj3i+iSdACN/RxEf+
         v/yC3EAzNwuEIo2m6/VOVx/eWepwFDO5Au/3EP3s4TWMu1flgYlXRTs2ywrlUubY2GS2
         7vYa5lWnM5wrz5mcO+DceFtYaV2Wp0T+/UpRwK3xouw6vE/sheJUv4V/fTi2tkCQXBcL
         XyV3njGAqh3KTRbekF4ifnlwxmvm6C3yvxdAvB99eS21fEet5z18LNzFoUMEtSzzfSH6
         jBk3NBJQhYSaqFpWr8HVvxXqQKFpIHBxXe46UfgVD0Qm7XjOZVrpWyYYrZ4kDXMSDeLs
         6c2A==
X-Forwarded-Encrypted: i=1; AJvYcCUTVFTyoK9FbaYGJLoYC9uIp2uw7CWE/3aAyzT6hDM3CISskAb4knTHVne8OqgxMU834RLuWLkuS7biDCuo@vger.kernel.org
X-Gm-Message-State: AOJu0YxqjEcdAWwooDc9W1KekExuczsjXSFO496UXF/cDUch7Tgg9I/f
	WC6xYVlEv5S7bfsOprBFo39xlKoTpGKDshAdCGz6yX4VnHjS1ChY39AM
X-Gm-Gg: ASbGncudg6Lb+Ff3FH2MOfio50Gj9o1Br5LqmXCTxX9Y+hZmGDdz3oVucBC8fPIQT1F
	NSrxwdGq7ogtXD4zvRTD6j/mQnwyPTYNkSAfJDyDIv5aHTuUwQX3cnADp/zUC5MjHGU1qzzvvlU
	0/3GXap8+oRXKPz2a461fH4eZW8HYK4xfwJI7m2D4KnrBQrWx6nF72g8qRkt38DfRbAq+omfJ4C
	jiILQaVr62h/mBJEbETh+lTWn17+/DtLqcKUMk0Nny3JIpJO2PkdHw5Rpu4Rxd9A5R1GYHdABqb
	3hVU5hBdaMFL5cMQP52Rhs0N/K+mN7fzyvPsI/s28oUuQfrpNTmnd62sYMOh0CQmQ7aEJQ/Ixlp
	i8vJ1j8XiDKhZBS2ZRrDfzHibuLrf
X-Google-Smtp-Source: AGHT+IHLyQUjattwHzqsh8kLDnVYrldB1MVPcLD9W60hYF1Xca21tPEVk8iJYUsBmSi3Y19+Todp9g==
X-Received: by 2002:a17:902:d4c9:b0:248:9964:3796 with SMTP id d9443c01a7336-24944b3c411mr4052135ad.43.1756510798887;
        Fri, 29 Aug 2025 16:39:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906596416sm35109285ad.118.2025.08.29.16.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:39:58 -0700 (PDT)
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
Subject: [PATCH v2 06/12] mm: add __folio_clear_dirty_for_io() helper
Date: Fri, 29 Aug 2025 16:39:36 -0700
Message-ID: <20250829233942.3607248-7-joannelkoong@gmail.com>
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

Add __folio_clear_dirty_for_io() which takes in an arg for whether the
folio and wb stats should be updated as part of the call or not.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/page-writeback.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 1f862ab3c68d..fe39137f01d6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2955,7 +2955,7 @@ EXPORT_SYMBOL(__folio_cancel_dirty);
  * This incoherency between the folio's dirty flag and xarray tag is
  * unfortunate, but it only exists while the folio is locked.
  */
-bool folio_clear_dirty_for_io(struct folio *folio)
+static bool __folio_clear_dirty_for_io(struct folio *folio, bool update_stats)
 {
 	struct address_space *mapping = folio_mapping(folio);
 	bool ret = false;
@@ -3004,10 +3004,14 @@ bool folio_clear_dirty_for_io(struct folio *folio)
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
@@ -3015,6 +3019,11 @@ bool folio_clear_dirty_for_io(struct folio *folio)
 	}
 	return folio_test_clear_dirty(folio);
 }
+
+bool folio_clear_dirty_for_io(struct folio *folio)
+{
+	return __folio_clear_dirty_for_io(folio, true);
+}
 EXPORT_SYMBOL(folio_clear_dirty_for_io);
 
 static void wb_inode_writeback_start(struct bdi_writeback *wb)
-- 
2.47.3


