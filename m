Return-Path: <linux-fsdevel+bounces-66864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB93C2E61B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 00:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CCC4A34B503
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 23:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2242FE04E;
	Mon,  3 Nov 2025 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHsAeg1P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94005279DAE
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211364; cv=none; b=JnmdQeSU7E6FtCbOjSSIUa2uTUCD+bKCoRzSF94DiRy44kVSZvUpDpb5B6dVn4WV1GSnDH5ccKDfd3lIyLaNTzV5uDxRMNtS42jLXAowg0sDAxvpqJk4txiNt3oZzEMyRaQT+DTkWTVR2diP6+2pY2+f0ZIXoB77qQMMsGzxfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211364; c=relaxed/simple;
	bh=71Z+nFQ8WD3X7cBHSB5xsYEXzWiJJvRTnkDU3GDIF/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdsPmME/Me8wSZWp0ypTqXw8+qfWH+lKGUbV7r6+1UbDlxdtkdYxv3D7srlXBSxrFNAhPGBN3J1XSP1AkGAsyzAkYJcfTVDakWHpSwm7UoYURWMCpWMv1LwHXvUGdqtiNg9FJBa5EiCT5B1JC2prUEnDXXpuGQIOCdXiEerBCa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHsAeg1P; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-429c82bf86bso2432122f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 15:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762211361; x=1762816161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1Q1tLieQpcpuMwIkeXnAFgYmCnVQs4T7Pfl0eQn33c=;
        b=OHsAeg1Pqr4hO/2smhIWlflRR9lQ7fz6PCna37tUz7ufG0CXtmrbCnCx/gw1yvrKh4
         rLsylZJ1t9QHwvPRPFj7I2f7tDSgs136ONR7l9kKRdJQIxuSX7WzX2IjYFDcXLlSk3rz
         /fNXBaiORg0ph47+iAR/hrYqjvoeThTrPWypxoC1sKavjJwfPqpXcknzgYFsr/x5IN65
         m3t4vUK8LBjTDRPEKidZCM9DA+bisScqJe63/D4F6oW8ZOZ3LB+Vrvg7x143r4w51tUR
         4g26APygxCsQuAVCz5F9GC0sWsg04Qm2H+UINMHg/o9d38p8YaylIW7F1veZr9JSzNZ/
         S4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762211361; x=1762816161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1Q1tLieQpcpuMwIkeXnAFgYmCnVQs4T7Pfl0eQn33c=;
        b=F1QyEffxbP+JIX/ujSa48dMPWYvEGKpB1WhSARylWQBxXIvW65CdOY+I/UIlhvUoTQ
         KRK4+yLXz2hae7zBJ/ofBhnLAoZOtMCLmIpEvyIpnu2q+O3GhguDRltdeo+hNb8HtYm0
         LeSNL6bVccdLxtLYDKDKzgTQhg5uWXILHlzWaCx41aDV4Rau856LFpj1thZcwb8FQlOu
         tH7iRvRlB/01/M780Q+Q+u3HvgIemRj1Zh5rm4++N8/P0Samy5eDTNkQwrpo42koRybL
         7rhQOaxTti7PqZS4VZW4t3fe4/RmJqNSPEjRRuKHMqhQ0csNuFHfgxrKtkF+HjO2x6lz
         FkzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt+quk/C6eNNfuNaIVAeOFp1JSzstE13M6GiVFXq6ZNedS12iPMjn4llzNYtcrH6B4NJV7IEyk0vM3GOi+@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJZ6sJ3TE3S377NEDU9fjLXlM5FcZPHgO9RRRnGZijLuEtIKH
	5pdKFFvpi2+cd4WOz3LK/lDLBQztf6cnEmwfEgeBYk7OpWlUD/X3nYqv
X-Gm-Gg: ASbGncu4o6alz8o6lnczqidcWF/yzrdvfiRkaxM1jT6jZ2bqhdJ7Ni3xpcAmUMUH7CR
	vVQzJyyTToW3GDAzOMWzKdP+ARQyy2IZgyq5riAq+MJ5qP/WhJ4QaUIOLAav17s1FgzqnhhWv87
	ZYXWOb5QWfH1jcokgYKR+T1ifXmz20pRJhEeaSySnJT7KkvcLIbNOnnLf4s9+3yIWfsVtWL7REt
	qQNliLq/ns7fbnydkIvtcROlSpKdqyMZJewVadUVF5Hb8xFvuWM1ECuh5QDLJOn6mrrmy++iLWG
	S2XztyUxFyK7OoGYrekCN1RboRcbpA4Eikr61kL42Q5e/kOYwUVk7cw6sBFk04Kg2Scpik2oeRS
	/qcyNyP9/YQswJTTyYdZSqsca0qsEPuvMW7AFLrHY8rF3FeanQDPQDVc/Mi50khLoW9PYPNpgJb
	piXJE65qoE8XLvN2DiY+AWzPakP2mV6PQc4XnW7Yi0XgmIHwT+KZWeJLpa+pM=
X-Google-Smtp-Source: AGHT+IEaEv1N6ajpfURp5K++JWjwDFC+FBT/tHpzug1ZX5HikVcj1HkwnZqbRmlJ6GwomLFTRQLpxA==
X-Received: by 2002:a5d:64e9:0:b0:429:cf86:1247 with SMTP id ffacd0b85a97d-429cf861389mr5676038f8f.57.1762211360842;
        Mon, 03 Nov 2025 15:09:20 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dbf53e86sm1338586f8f.0.2025.11.03.15.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:09:19 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] fs: push list presence check into inode_io_list_del()
Date: Tue,  4 Nov 2025 00:09:11 +0100
Message-ID: <20251103230911.516866-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency with sb routines.

ext4 is the only consumer outside of evict(). Damage-controlling it is
outside of the scope of this cleanup.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v3:
- address feedback by Jan: take care of ext4

if you don't like the specific comment added below I would appreciate if
you adjusted it yourself.

this patch replaces this guy: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.19.inode&id=7ba2ca3d17bb69276de7c97587b1e1f3d989f389

the other patch in the previous series remains unchanged

 fs/ext4/inode.c   | 3 +--
 fs/fs-writeback.c | 7 +++++++
 fs/inode.c        | 4 +---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b864e9645f85..bf978ece70b3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -202,8 +202,7 @@ void ext4_evict_inode(struct inode *inode)
 	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
 	 * we still need to remove the inode from the writeback lists.
 	 */
-	if (!list_empty_careful(&inode->i_io_list))
-		inode_io_list_del(inode);
+	inode_io_list_del(inode);
 
 	/*
 	 * Protect us against freezing - iput() caller didn't have to have any
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index f784d8b09b04..e2eed66aabf8 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1349,6 +1349,13 @@ void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
 
+	/*
+	 * FIXME: ext4 can call here from ext4_evict_inode() after evict() already
+	 * unlinked the inode.
+	 */
+	if (list_empty_careful(&inode->i_io_list))
+		return;
+
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
diff --git a/fs/inode.c b/fs/inode.c
index 0f3a56ea8f48..263da76ed4fc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -815,9 +815,7 @@ static void evict(struct inode *inode)
 	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
 	BUG_ON(!list_empty(&inode->i_lru));
 
-	if (!list_empty(&inode->i_io_list))
-		inode_io_list_del(inode);
-
+	inode_io_list_del(inode);
 	inode_sb_list_del(inode);
 
 	spin_lock(&inode->i_lock);
-- 
2.34.1


