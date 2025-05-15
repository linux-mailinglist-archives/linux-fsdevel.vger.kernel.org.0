Return-Path: <linux-fsdevel+bounces-49186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F81DAB9037
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 21:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8291C3BA313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 19:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD729B237;
	Thu, 15 May 2025 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDDDRaMU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0452222BB;
	Thu, 15 May 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338692; cv=none; b=gDXRpsg8E6niA1HupyqlYH53JBwoXwrrKp0m8+oQ0MJJubWOUwpnovUe1ioaYuCCInEj8yL0bQqGBbotyk6rINrJ6zmKcj0xTF2eYxA3ITpmzpkiW15KRaYnmgAj3cAo6fRXaLR8wldhTI5YcfnRiXYDVzwlOPnyD8s/wLEDG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338692; c=relaxed/simple;
	bh=fHMjDeJmJ9nXOWXrWtLaHieGF8ALXhliFHKEUfosLYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uMyBEJjctIW6t9HLx5TQAPx1L4BL8pXqQN7SWU1YdlGAkTghUrTkCRmF62Z3H9C/DqIUQU88Z5mU0C9F2dJNIS+YdAVUKlhe6R3Jp36bdHXs4/8nSLHvgs3nC9RYgEL/95aPv/WbUi8uGr1r3wQvbwtjiE7JfAL8AU6UtNcCcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDDDRaMU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30e7e46cb47so192721a91.1;
        Thu, 15 May 2025 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747338689; x=1747943489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA2n6Pn/ECi7g6w3Zzsd0yFMxlUcNgfe/XCIO2sLTwk=;
        b=iDDDRaMUQDzoOzS5JuwHwdb6mIWKg9P0Mp2pBfaNbs8x3Jr+/oHDWfqe9NdKYHjLHD
         B+yqs24sntg4SLTncW28ofPEzRmPHOi/KIiihDbUGRlnldG3TTfxL3RojJVVB/rD4TSp
         jAuLz2ddo17ETyqgsG3NEp8wIZ1kqbPQSw2PezpGSLWvIQnC9WrTh0+HJ+dkFr2fDaX4
         F3iNY4c0VS4/BsP0fq3KNuuWVYWlVey6KoxfVDqan4H15CgLqtl2oMgLlfInf2yZWSXH
         w3x4PsNbh91qnPAIuNdbHo0JjtChvxeVAxRTOn+9zdZjWePDqFegHJv8tZaZMX1U2Fdg
         sp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747338689; x=1747943489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rA2n6Pn/ECi7g6w3Zzsd0yFMxlUcNgfe/XCIO2sLTwk=;
        b=STnZgQ/+WptJIgJKpEO/b36O0VRSryp2qtEjWR3NapXDqZLAYjeLjmanlx1ZO+65M7
         qfH+NXTzLCNElpAYcKudZLlT+m2lo9FCKlY2H80/vUT1I56qTh5pnNgMvkrzwMKz3NIc
         Tm5u701zEooVtCY7DriGgn3KPLEHnFTMGK0d7Zwfd3PLGtvk2C36TuUgoVUZil/EY1VB
         aqZ8KxHDXN5i6KTEI+MsDPz0Ml+eNbSsYQV12csMXYW35QQpxGrZXtFoHgP8YnbBZ/EU
         viWgssMXVSa8PFl6bYstb8NN5MPBSqZuQPectEj0AIOrb579496vOaormk/SEhI26x0M
         vqkA==
X-Forwarded-Encrypted: i=1; AJvYcCUasXIJkd58sr9ejFkKn5zNXJnandinGR+7zfBzWSS9PQ1C+giYhfaH713MjhEOalgmiNSufV+zZ6SFd2LZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XZyOeCJUH8u7N2C9juNQawaYPGJLyq1sb6mxxoew0tqXZC/K
	VUkzMJ7MxbfLrTijiiVJXApgFLHBJzFxw5NFpsbkEFwD3UW3HsP/pHkb1XnHTg==
X-Gm-Gg: ASbGncu630xSfNAbGrzP8YQq0EEagpe1wbzmlVVgwGZYApeiwM7svxm4uZRvrwlyBzk
	1alk/CmC4tBqrrsVeu2++fetGM2UFubiJBBPXFZqU+grsYWyJ/fiPrVxrCgTOzZFmOiEwupXgoD
	crj6E7EUTURo4HRHf6dzS/hR8PF22BXM4hxIserdkFTuga9XlhW9n9Lr8mRpAfBRKrNNtqzPR8S
	vJKxzHmiGJ2sMScge3XkZUDDO3RcyijmyJVFVcQ5HH7jgMDs+KNHX58wqpRqR1xpGpae6awrlLh
	4kbz0/154nKn2R7E2xmdRdKhXH3Z5kwVwIh2WrPOCoHCM0Y=
X-Google-Smtp-Source: AGHT+IF50kq2l9eeXZ/V88sa5vPkzCytTqKxLWFsA77kM5010RJNFXv0BEp2FQGirj6yp8/7QiGxkg==
X-Received: by 2002:a17:90b:5545:b0:304:ec28:4437 with SMTP id 98e67ed59e1d1-30e7d5a847cmr683742a91.22.1747338689145;
        Thu, 15 May 2025 12:51:29 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a9893sm280463a12.72.2025.05.15.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:51:28 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v5 6/7] ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
Date: Fri, 16 May 2025 01:20:54 +0530
Message-ID: <5e45d7ed24499024b9079436ba6698dae5298e29.1747337952.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747337952.git.ritesh.list@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last couple of patches added the needed support for multi-fsblock atomic
writes using bigalloc. This patch ensures that filesystem advertizes the
needed atomic write unit min and max values for enabling multi-fsblock
atomic write support with bigalloc.

Acked-by: Darrick J. Wong <djwong@kernel.org>
Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 181934499624..c6fdb8950535 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4441,13 +4441,16 @@ static int ext4_handle_clustersize(struct super_block *sb)
 
 /*
  * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
+ * With non-bigalloc filesystem awu will be based upon filesystem blocksize
+ * & bdev awu units.
+ * With bigalloc it will be based upon bigalloc cluster size & bdev awu units.
  * @sb: super block
- * TODO: Later add support for bigalloc
  */
 static void ext4_atomic_write_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct block_device *bdev = sb->s_bdev;
+	unsigned int clustersize = EXT4_CLUSTER_SIZE(sb);
 
 	if (!bdev_can_atomic_write(bdev))
 		return;
@@ -4457,7 +4460,7 @@ static void ext4_atomic_write_init(struct super_block *sb)
 
 	sbi->s_awu_min = max(sb->s_blocksize,
 			      bdev_atomic_write_unit_min_bytes(bdev));
-	sbi->s_awu_max = min(sb->s_blocksize,
+	sbi->s_awu_max = min(clustersize,
 			      bdev_atomic_write_unit_max_bytes(bdev));
 	if (sbi->s_awu_min && sbi->s_awu_max &&
 	    sbi->s_awu_min <= sbi->s_awu_max) {
-- 
2.49.0


