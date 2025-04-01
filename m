Return-Path: <linux-fsdevel+bounces-45462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBCA78067
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 18:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC6F3B3241
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF3722157F;
	Tue,  1 Apr 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGGVc8cX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24EB20CCE6;
	Tue,  1 Apr 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524307; cv=none; b=W5mjbAkrlbQUmapsUCMvtKEBUXvFZkdxbh1eSguHoF8QfLRckLJMbsSmZCbRhGw8hVhyBZm0Dx+Kp3PRgzEtbfzIKdEGsTa934ve0CvcftkFl8mr8l1VyumkVDmZ1A0ifUOxazwz9j4fBJg9//n+qlkf4LuNHg/BhxdlRR5U6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524307; c=relaxed/simple;
	bh=a3U4OlqdGH0j5dNEyE12olnK1mGyFL4MqdrgZEhPSbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdkJGEnapEgH8A5H+JEreXP1alXSQ062Zpew31Iy7BT0o+EKG+8haTDlIYoFpk2PsTX2gag4JzArKuTQu84uhdZ2z4RH9ev3CygGXZooi4Af5E5Gp4XZl4m55c8ed8k+t8GGhpupR1yNYLEJRCHuVeA3aYbqg+aTZHZ9ZCKp4EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGGVc8cX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c0dfba946so2394963f8f.3;
        Tue, 01 Apr 2025 09:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743524303; x=1744129103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/43tgkG2SXuLz4gETyubISHLC/vhEqo7IBhTOXroYI=;
        b=HGGVc8cXpHClcuxb0MQOTt7c2m64705De2KrNZulnimn8At5qYOeyVoRPDQ6+zO126
         oIM3hx83Wibbz6GAmAEVclGGCy9OnP8VYZRQZPDRnsR0AJ6iVNywhguDI+7OAJ8My3I6
         TZCmNY2IjusqebgGxNkMlwrXL9KnUgDNlaFsMyx3UTFjxRyv888SXuafXHz4PrWThLkZ
         PcN57xizTJy84kZ+EIiYSSPs95ipANq1pil40tvvzQd82127Cg85b+ygsL3rKXJ2pll7
         5zCadukHLzsd59Vs2rhGb3JVagZVmqEjS2hAgZ7M8KlXrTqrOjB2tsYzvZ1tz421UkAo
         nX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743524303; x=1744129103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/43tgkG2SXuLz4gETyubISHLC/vhEqo7IBhTOXroYI=;
        b=kpYI4rFQZa+eSGK55xm45NuzLzVRMyiXYSV78CMmwbM5oWjS7D2Xs31ifkAjMWG+bk
         tHddKfP8yqmq89JlWvZsQEme8mZBr/okClmGY6TgXJJkKM0S5c2/bFu7yUU/oCGY7d4q
         FiZHxWUtoAQR8rL6OJVXV4kRHmptA9FOvL40pl+y0eoxQhb3nbQA0uAh2NwENfudbs0W
         aRXyS7qFjj6Ms/401L7qaaKK/WMjxZ0OBChcq38qx+0/NODRiBXRGHukW5JmM+EGeAyl
         B2CM0nY5eizRRoILsi44nTGqbtlo826hjV84bFWgUyHPunINPUWX0+khwpMukzfoljTa
         6UFA==
X-Forwarded-Encrypted: i=1; AJvYcCUJi5ujZt5O6QcGLOPB0ujZFsVAfyfNHvevHeYt86y80/pll2D1k6lXuculW7eDUS74eg+HVk44i6BX4+Y5@vger.kernel.org, AJvYcCXGt+HLdnBcP0bodudzjZfiaKq5wxFSCibFd0Hf+bF8oVVAkg3z6nLl5uOrVovqJkRLdPuA4juV/ODWy9PI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7xPJcq80Ll3UYn05p5z/HyN3d0zuI9vTgHnSWb2vLIryPN3K
	2HPg3tF9zbc0HYJHcgVTxo314p83tBKGrqsGjxVDWBcz7IK5lrzJILplSvyH
X-Gm-Gg: ASbGncvsuMVS+N95BDwRpjHGK+/IK0ypN8N4NP/7/KOL1AaMvit5zwucat2AhpwPEpB
	cSCkQAgA8JYmY+OtZsOqc0CdV77uL+h3z+42BenCz8GS0qb0VsMkmDqrxlDLKKyysllngps8zsL
	Rvxw8HSKcWAs+SrHL3zFRvMYmuLKk8c4WziKsoaS0GKMHrspIVAjaKM2OYyGGHpIe1al6Tdg8lQ
	sSdFghCbQSzIoG8CKsQfrNN/zJkcb1tsAAuQ9euFv1xWUXTZJsr0Jtvg3sIZ1RgV7tvPG95A4DZ
	pvPIIOq8wwI751hC6Ou+sCgVsttWDM25562zEdnIoQNCLGnBTLmgvTBT3FD2
X-Google-Smtp-Source: AGHT+IG45pqikqHfWcwyPHxI+T9XUXYot1p72gRtoNZAVYKJ7x0uwDZmxuOSe70AmTgFd1/RmNBFGg==
X-Received: by 2002:a5d:5f52:0:b0:391:253b:4046 with SMTP id ffacd0b85a97d-39c120de297mr11496160f8f.16.1743524302670;
        Tue, 01 Apr 2025 09:18:22 -0700 (PDT)
Received: from f.. (cst-prg-92-82.cust.vodafone.cz. [46.135.92.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66aeaasm14680601f8f.53.2025.04.01.09.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:18:21 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [MEH PATCH] fs: make generic_fillattr() tail-callable and utilize it in ext2/ext4
Date: Tue,  1 Apr 2025 18:18:13 +0200
Message-ID: <20250401161813.1121828-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unfortunately the other filesystems I checked make adjustments after
their own call to generic_fillattr() and consequently can't benefit.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

There are weird slowdowns on fstat, this is a byproduct of trying to
straighten out the fast path.

Not benchmarked, but I did confirm the compiler jmps out to the routine
instead of emitting a call which is the right thing to do here.

that said I'm not going to argue, but I like to see this out of the way.

there are nasty things which need to be addressed separately

 fs/ext2/inode.c    | 3 +--
 fs/ext4/inode.c    | 3 +--
 fs/stat.c          | 6 +++++-
 include/linux/fs.h | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 30f8201c155f..cf1f89922207 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1629,8 +1629,7 @@ int ext2_getattr(struct mnt_idmap *idmap, const struct path *path,
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
 
-	generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
-	return 0;
+	return generic_fillattr(&nop_mnt_idmap, request_mask, inode, stat);
 }
 
 int ext2_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 1dc09ed5d403..3edd6e60dd9b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5687,8 +5687,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 				  STATX_ATTR_NODUMP |
 				  STATX_ATTR_VERITY);
 
-	generic_fillattr(idmap, request_mask, inode, stat);
-	return 0;
+	return generic_fillattr(idmap, request_mask, inode, stat);
 }
 
 int ext4_file_getattr(struct mnt_idmap *idmap,
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..581a95376e70 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -78,8 +78,11 @@ EXPORT_SYMBOL(fill_mg_cmtime);
  * take care to map the inode according to @idmap before filling in the
  * uid and gid filds. On non-idmapped mounts or if permission checking is to be
  * performed on the raw inode simply pass @nop_mnt_idmap.
+ *
+ * The routine always succeeds. We make it return a value so that consumers can
+ * tail-call it.
  */
-void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
+int generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		      struct inode *inode, struct kstat *stat)
 {
 	vfsuid_t vfsuid = i_uid_into_vfsuid(idmap, inode);
@@ -110,6 +113,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 		stat->change_cookie = inode_query_iversion(inode);
 	}
 
+	return 0;
 }
 EXPORT_SYMBOL(generic_fillattr);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..754893d8d2a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3471,7 +3471,7 @@ extern int page_symlink(struct inode *inode, const char *symname, int len);
 extern const struct inode_operations page_symlink_inode_operations;
 extern void kfree_link(void *);
 void fill_mg_cmtime(struct kstat *stat, u32 request_mask, struct inode *inode);
-void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
+int generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-- 
2.43.0


