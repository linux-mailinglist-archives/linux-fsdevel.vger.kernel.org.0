Return-Path: <linux-fsdevel+bounces-52662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33842AE59D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DC5173603
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6932C223DFA;
	Tue, 24 Jun 2025 02:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7sFtYTb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD182063F0;
	Tue, 24 Jun 2025 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731782; cv=none; b=eEhH5eHzkYf4/6WdC2UMH9G+M1SfpXhVDdr8ZNvlG2PUmqmy7E23vfYsGy/RnZ/iIiAf4cURHOodhM7VPhrRRoY3MrlKUBMJ46LEeOA/z5JRcNJvjko058AFVE90aAkebYMo8mxYOOW6AB0KIkX39WD9GJz0knzOiVz/kTUQ46Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731782; c=relaxed/simple;
	bh=bgI5aM7q9s1dDFn8N9JMw8Zt74AcFrVNaXjWC9Ilv6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAkMxLTwtCTiHHProfZpdNz/87zzl/WjYEsczLfbVvYf5DjIaMO+SrYmgf5uTAss2PSYqX986SrEzhxwNe1MSZre+pgUKzC0duqxmApanWJFFX1S/VxOwK41jE5BSaT5uY+6wCAma7taw6zoJroczrnB1Gmvh472Ryrn2qwIshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7sFtYTb; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b1fd59851baso3236853a12.0;
        Mon, 23 Jun 2025 19:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731780; x=1751336580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IETc+Vke7pqtXY+tQ/orHCelym8kNJNTtoeGrsW0BVA=;
        b=W7sFtYTb+wQ3Lz8PlLIOYH3WH1GUyP7wtScAfg0/ONa99ne72K8f/HpBvkXt5tPfeb
         SBek59wQs55KqYuPp8ODEv7ilazpJYNTcBmS8IDQsRuSkTyH6uQ8JATsqxA8hnxCu8xE
         cqM17oLLWwogWcJkCXPl1jBODkm3dme1GeSIOvcxrsiTNTB/XnDtUkf4Nd3S8QVPQcoH
         2DYKjr7ybeV7ZEvTY/koMJDS/2oDFbg1ThUuOT2Z7QgmRKj8p+JHSrdhjvOZoez1yGus
         qsPf3nKaH8G+5VQj7WgOUdel3xX1q+XW2NoNdEoZxOoO1CpUltfxOdgIbNSUVBfkXi9j
         DxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731780; x=1751336580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IETc+Vke7pqtXY+tQ/orHCelym8kNJNTtoeGrsW0BVA=;
        b=Ua1IEQMQ+8f9O8rol5ogyIWvRR2tPgDDv6MrO3BLCT452GS6fGMmQLZopHCcLoPMyq
         mCA2RDaTTJE7+Zlw8KIjpL0QEtZoTyY9s7gXFRITs58tkguMiwq5q1n7DEu8Lpn4wgri
         LNkbrRpsjMIiUR8RbdGyrVEbB/cCwOjVmaOAuRMJQst+aK2RPKWLWvHlw+vzL1iXTCQN
         b6Ac//bZvTUgSa8ERHCKMeR/JbBg8Z7C43fZCFFUm3vjwY46mg2xTmll1DrzHopP6JRK
         aKuZCshRSVvVggir/vHuld5DcCylzNPHjxPc1SNzWEMzr3S6TjCYywj7RgBRebdJdtrl
         w4QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUibdDGayQGNvnwr5qdrjeeO/mX0Rto0AHNsTjlgFTM9aCDdJZWoEUhUXA5RhHE9aSYk86sbKSOWmYWdA==@vger.kernel.org, AJvYcCWx4qNtcF3GWtEB34yzhJ4O1LRT3+AKBFtF1kU29oEYmsEbA/BAL3kFuXzF8U827AknV3ZFr9qutO6v@vger.kernel.org, AJvYcCXVVbgeFgdC6/UXFe9sR4DrWwvzPFAe/Zvtk2NK1Ljpu8Rt8f0RmSrBd5iWCkTolirADQ+iYD+J9DEJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOqMUUBXgmZ3qLC/ezp43AXDYkfhWADuMi5W2+OsixzjZzOzQ/
	L7v3h9HTNdNB2HMyms7rplmNmsvqJ3UH5QcbG+KDDT1MRrynkW2LLmGUXc7DaA==
X-Gm-Gg: ASbGncuWmCA4ept2F2jW5CXclkivT4X3rFUU1gsU0KBERcVrCjlJnJ43i/fFl9aPw7h
	/AfEiysX+4IjJKLrCh5TwevhuGx7K5txi3Qd5vt2SkOjckv5CfUzU4uDd4oj9VQNxDHxC+6ODzp
	WExvQb3v042ezti642/v0bjWfu3/Wi9at8Rjq7dE+V/AY93Kkeyi5mWHHPJ9VEh1vBBVCqshSFh
	pGE4KOLN/P5vBzlPDXwM+C8FhNDzZQprnjhdvtrZvMR3udo9r8vfRDzMztUF6cnor1u7nSsXxWj
	RQwoMyLV8W1TGEsHv/1/n+eiLBLlt7ZYDVt90Ue5dA1xo2ikWb/In93E
X-Google-Smtp-Source: AGHT+IHCkHeapeuEFLZu6oqm8JyA0jqOksNmIyW1sEaDYbkw3ivQkjlPo7L+ZEOJ4SyNnTu71NSVSg==
X-Received: by 2002:a17:90b:2c85:b0:312:639:a062 with SMTP id 98e67ed59e1d1-3159d8c8ec2mr27173741a91.16.1750731780525;
        Mon, 23 Jun 2025 19:23:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71d49sm9368112a91.5.2025.06.23.19.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 02/16] iomap: cleanup the pending writeback tracking in iomap_writepage_map_blocks
Date: Mon, 23 Jun 2025 19:21:21 -0700
Message-ID: <20250624022135.832899-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't care about the count of outstanding ioends, just if there is one.
Replace the count variable passed to iomap_writepage_map_blocks with a
boolean to make that more clear.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
[hch: rename the variable, update the commit message]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 71ad17bf827f..11a55da26a6f 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1758,7 +1758,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 
 static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 		struct folio *folio, u64 pos, u64 end_pos, unsigned dirty_len,
-		unsigned *count)
+		bool *wb_pending)
 {
 	int error;
 
@@ -1786,7 +1786,7 @@ static int iomap_writepage_map_blocks(struct iomap_writepage_ctx *wpc,
 			error = iomap_add_to_ioend(wpc, folio, pos, end_pos,
 					map_len);
 			if (!error)
-				(*count)++;
+				*wb_pending = true;
 			break;
 		}
 		dirty_len -= map_len;
@@ -1873,7 +1873,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	u64 pos = folio_pos(folio);
 	u64 end_pos = pos + folio_size(folio);
 	u64 end_aligned = 0;
-	unsigned count = 0;
+	bool wb_pending = false;
 	int error = 0;
 	u32 rlen;
 
@@ -1917,13 +1917,13 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	end_aligned = round_up(end_pos, i_blocksize(inode));
 	while ((rlen = iomap_find_dirty_range(folio, &pos, end_aligned))) {
 		error = iomap_writepage_map_blocks(wpc, folio, pos, end_pos,
-				rlen, &count);
+				rlen, &wb_pending);
 		if (error)
 			break;
 		pos += rlen;
 	}
 
-	if (count)
+	if (wb_pending)
 		wpc->nr_folios++;
 
 	/*
@@ -1945,7 +1945,7 @@ static int iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
 			folio_end_writeback(folio);
 	} else {
-		if (!count)
+		if (!wb_pending)
 			folio_end_writeback(folio);
 	}
 	mapping_set_error(inode->i_mapping, error);
-- 
2.47.1


