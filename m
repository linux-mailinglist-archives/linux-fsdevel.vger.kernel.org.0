Return-Path: <linux-fsdevel+bounces-57198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B87D5B1F863
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACD554E14F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CC01F4C89;
	Sun, 10 Aug 2025 04:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUl2HFwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D511F03DE;
	Sun, 10 Aug 2025 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754801302; cv=none; b=LNCWj7LOWsKndFB0DuajX1O6cHEH4zXMn5RDZMPTQAXrqIBNfeoUQQXvzpinKqVJWN0lSNjiiVar+t0gBrt6cpPhdyoIiFfx2zpjwAxdUsHIPMvcUtLoX64Co6nNqxPgrF0wSYKv5w+edV+CpNKsxaywNOo1VTlUeWjQkXvnu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754801302; c=relaxed/simple;
	bh=jKaQoD/0uZFAoKwRDDwPtcqfLkEUzW7KbgTPmaYObs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzjJ2tpifXuEr5FKX0mw+Ttcbmqq4TzEntaOIbjPYrGSLrC1oGQ0reDSfYMnyP+lchbLvbScdaapKALXTBcyL+Q5AqV73wTUiTS/KuSByyEDOrGLfnLWp4Q1Sulws9A94G2iHW4aVF1Bt7jwybjvTHMfG+nw39CojAAHUDJQecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUl2HFwX; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b421b70f986so2412924a12.1;
        Sat, 09 Aug 2025 21:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754801300; x=1755406100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUxuiidVAG6WD5n/vYEciBFeyJ2xEqyPcRFxaktImJQ=;
        b=CUl2HFwX4Ugj7OwqANDUvQyaAZIZkXC24G88dtiwRBLO3u1xVi1cvb6CNrqKcpiQ8e
         q4Gl+BiUsPVO2Uy1LFK8hG8gug8/aOHohoZ6pwNsnyG1B7Epjy6nIc8n8Eo067v/wzys
         L5sQ5kjl/Gmvzrd77J4EoS1UBRT/5ulQsHGQy3Y6tXSVwD5/gGi8d/hmNptigzGf+2Bb
         EaNjAzgFw2CkAmLnhJBjYhd9h+i/XPaSGWbHCMdreejvwHSpsSFMsfYjpSbJzmjhAcu6
         Hlq08Zbg8sGjH8tXojz1sAYeq7RDYILF26U1eDzALk9/4mxMGI16UwH8GifHN3Tjrvvs
         rkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754801300; x=1755406100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUxuiidVAG6WD5n/vYEciBFeyJ2xEqyPcRFxaktImJQ=;
        b=gavMQUHrQKeaVfOWqgZ4RpdVAtSaGx6/bbH5D4CayD6dupupZLeVLGqi7v5BEP8Us6
         piSmTH43Rtc5AMSXQ3qvFggyDjiPBS0c5lfGJuEFHlfWaPh7YX6NXP4zFkcJH5U2A1Rw
         EIQZkyY/Gd6lZbGeZHuvLqYsvM06NVVI6/0/z60/DsfbBsfjytju0LJu03A83/dX7EKG
         rIup+Ek+ksfhwku1hgjlglNyKXE9yooY66vb3IcZBHzJxML6her53UNbFFXOhfrPZ83L
         Qlmh9HrZ+BMJ2V/EhVdPsoS1dun+N/IYlpMUQ1Tun0I3xRNcJzFIMzxbkzB1b83cKyc7
         h+Qg==
X-Forwarded-Encrypted: i=1; AJvYcCW85zV+ocvanfTpoBiN45y3ym/icbIKm5/uT1hRst+iEnE+bJUPBeV9nNOWl5w9vuB5qvsD6/NIIssaK72r@vger.kernel.org, AJvYcCXJlhJowSCs9xyMEFeh0ILM64TaQAWczvpcev7o8YXvUri8VvKYVyS3h2XwlYXNbJLRKPLyDWm8pxx3YJAv@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpljFd38Opx4qSTHE0t5nc3VXZkHo+/Sa1z6CmCHRMwYyw4ES
	hOFxN66MQHuSDaqP90SzNCts/ijbQ4zlmMG12vAf9qTpFANoP6BzLYQltBMlw7Bh
X-Gm-Gg: ASbGncu7IawGQReZwtM/f1QWkOXO5h8H/vOG/TDjLipLp7BZVywDJMzRIK+fNsI1L2j
	rbg3uo1iQqmCraW04SAuZMbsi4WprpDQAGK9NmYI1LZuJslH8t7pccx+3E2qP0ApeL6zJjWembE
	06a+bX2pyCjolL+kbQFG341EqhmwLeCd0JH5y/1WEV/AzZ4DzLoFi1Ma255gPD2IqU2taSmhgO8
	R+P8dY4pM0R09DowIA4o4Tura0yI5pvDfuG+ikRQBhAMkUY4GURU0Adh12n3OSSPsooVDRvqsvA
	S4aXBru1URxG8y4qzEhBFS8q0ehk+tis/fNRZvX4VBEr7Goqvym5r0nfpmrY29tRB2+XApaN2CK
	rWpe9RC7J/nNF6T9NzjozExGX31EoBdwvSqY31NAEIcoz6A==
X-Google-Smtp-Source: AGHT+IFcSi8oD8lofATKiO7FDlwHynV8TwFnSb8cJQbts2bmt5GSt1Z/Udfwoa/l2lAJ+0a+EYVXZA==
X-Received: by 2002:a17:902:e892:b0:234:8ef1:aa7b with SMTP id d9443c01a7336-242c20073d3mr127126905ad.20.1754801299794;
        Sat, 09 Aug 2025 21:48:19 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f53sm244113645ad.113.2025.08.09.21.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 21:48:19 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH 4/4] iomap: don't abandon the whole thing with iomap_folio_state
Date: Sun, 10 Aug 2025 12:48:06 +0800
Message-ID: <20250810044806.3433783-5-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250810044806.3433783-1-alexjlzheng@tencent.com>
References: <20250810044806.3433783-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/iomap/buffered-io.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 1b92a0f15bc1..10701923d968 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -873,6 +873,25 @@ static int iomap_write_begin(struct iomap_iter *iter,
 	return status;
 }
 
+static int iomap_trim_tail_partial(struct inode *inode, loff_t pos,
+		size_t copied, struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	unsigned block_size, last_blk, last_blk_bytes;
+
+	if (!ifs || !copied)
+		return 0;
+
+	block_size = 1 << inode->i_blkbits;
+	last_blk = offset_in_folio(folio, pos + copied - 1) >> inode->i_blkbits;
+	last_blk_bytes = (pos + copied) % block_size;
+
+	if (!ifs_block_is_uptodate(ifs, last_blk))
+		copied -= min(copied, last_blk_bytes);
+
+	return copied;
+}
+
 static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 		size_t copied, struct folio *folio)
 {
@@ -886,12 +905,15 @@ static int __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	 * read_folio might come in and destroy our partial write.
 	 *
 	 * Do the simplest thing and just treat any short write to a
-	 * non-uptodate page as a zero-length write, and force the caller to
-	 * redo the whole thing.
+	 * non-uptodate block as a zero-length write, and force the caller to
+	 * redo the things begin from the block.
 	 */
-	if (unlikely(copied < len && !folio_test_uptodate(folio)))
-		return 0;
-	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
+	if (unlikely(copied < len && !folio_test_uptodate(folio))) {
+		copied = iomap_trim_tail_partial(inode, pos, copied, folio);
+		if (!copied)
+			return 0;
+	}
+	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), copied);
 	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
 	filemap_dirty_folio(inode->i_mapping, folio);
 	return copied;
-- 
2.49.0


