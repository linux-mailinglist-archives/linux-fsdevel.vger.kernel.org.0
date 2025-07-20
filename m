Return-Path: <linux-fsdevel+bounces-55529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C209BB0B667
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 16:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8FA188D862
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Jul 2025 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DBD20F098;
	Sun, 20 Jul 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew6rKWTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293A0188735;
	Sun, 20 Jul 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753021454; cv=none; b=Dd5m9ua8F6vafivOXhoHZtMXeYvqjET59jLFSNhiI3m93hwnUNu2lOjXStThUiAoeA2o3/WVuNdu3IUboyzi3vr/xTgzjRYtBUvtMeAaf1tyiabdUHT7quX6jTGBCBGAHmamCuqECmvRR8Fw6MG6PotSUfiUgAdW31Vl7Eljf08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753021454; c=relaxed/simple;
	bh=EHultalvnxVTt2gZ7iVxZASBuH+6MP84eEkWFI6oBZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZaPjZnMcAIMIGiEKv3oWL8IeSaX423qJZLfDF/YFN5bh6amm9SmV2mgv2p4ZCIw6o8e/8sWwRKIrNyb+jORuqX4N0uwLWby1rxXDLkAfo+3RofozOAZYwNTm6Qi+AQN0igePw3XwwNNZINk80kLaE0//eAOk+yBrKVvcRmXniQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew6rKWTx; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a54700a463so1974233f8f.1;
        Sun, 20 Jul 2025 07:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753021451; x=1753626251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gv6vTifheshmLE8dIWrG2vH5RaZqGOCMW1sL1ss0wk=;
        b=Ew6rKWTxCLnzIKd+fD6RRjNwMJ5sQsWYFPgbfJGCM6l84zy2Wx+/VMCPKun4OOUT2w
         52I7ZDA1/EaX0x9silB6BI7XzJOxJx4yvppuiUqUqLCLxlLfF0KMfA2e7eA7YHpeaXOc
         clFCoRoXD9xFQbMJN4broYpazrmRKhUpOUPp+2axekrdDiocrSM4hcpdyujm/Su8m1mE
         +NMweA1k9bzwGkMHO4CxiIC/M7y0bRkmgBszcPihHzbiRwSJzAiCrjUxtYm9T8Q2Muev
         N0RAkWgTnUY/nOQpDrxtxStQiDr3Pn3L1vpgnJ4bc/9gtBm7eAEtwBn2canMDmWbkFRO
         EEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753021451; x=1753626251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gv6vTifheshmLE8dIWrG2vH5RaZqGOCMW1sL1ss0wk=;
        b=SxEMFd6TKdoh16VaqxpTBip46ifzJs30Y/uFFEm6dekmAef7USSq/3tmb8tbPm7hUG
         y7c7nAS8sE1K0w5EDuXxEIqWzgDY3yOV0zgW4sG4WU85P3luPo+w21xzgMGoNV3Xt+KF
         3DD/hCN2gZbBclZZiVpnT6bGB0jt0tpezvIWXUo3sO5wDBkKI213UQajM0ez9bbHnsQ9
         lzFtBkAynifSVEgkojqPmb/WBT9lly3qsaNFj4TgYoPkdLkN63K3sd3w8wipW9fRHc1p
         Tvsb7nFCz+NkMmNsJlRseYB220i0+pmXRS93V1cItteUj4VE0GGjRKME5c2UVP7omcH6
         VDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW90KmVUCrqnKlUH/bNBJfgguW3k9+TN6EMpfca+BeksWglRNiAc6tzDK+i/CRlO71/9WBZLGJ8ECc0ESA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKg+4mhYuFeJhk9WW7Ob4hJ7cLeAvo39yX4cONxD0a1SKzp/0b
	tYpK1ys04cz5UctFKj07HnueuM61kHN/K06JJoHf85q7bKJ0B2dKEViD
X-Gm-Gg: ASbGncvz3hTd92oLprjgmejgRdnu4nIOGN5EAV9qJ64CL8GJ9msPnGwI3jfrIdNxVHc
	VXxaDA1LpanvxuRlGKRtIy1w2xlwqNh1oOSGi5MlSN5UEMiumRGQFzdKNYSLnVaoo3A2HdtxfER
	php9+mu5flzp82VswYkSZDxLSsqyUb9zoy67t+I8AI0A+sTiymTysM7t8e8jsGQVHCoAANbOx2m
	qSj4jClZiGl04m3IWiC2QLvmBg6DKeQNJ3u1dGYQi3vPC2ffdE4JZ4qyb+K4PwYLPYsEy5Qj0V2
	Ft7aGlPEUQnpONvFjD0kpjLapQDZRKHGDjcW4JuQIJdIoZwfCDI0P6Eka7p4+aUlctVDnNZ0FNR
	G5fm6VeQIIrxC/VxhxWfMLMk+lWgyy4QQ4HCh0mFhHl92Ybo7
X-Google-Smtp-Source: AGHT+IGyNqpsVFqUws9mqRe6vDSRD2/W6raMHQHzfdrDjOMfgMEIWUgN6OOJ4Vi1UOOOJhfpTzqxxQ==
X-Received: by 2002:a5d:5d12:0:b0:3b7:58be:ff23 with SMTP id ffacd0b85a97d-3b758bf0034mr2342632f8f.13.1753021451127;
        Sun, 20 Jul 2025 07:24:11 -0700 (PDT)
Received: from localhost.localdomain ([78.210.47.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d7efsm7700113f8f.67.2025.07.20.07.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 07:24:10 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: mpatocka@redhat.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apokusinski01@gmail.com,
	syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: [PATCH] hpfs: add checks for ea addresses
Date: Sun, 20 Jul 2025 16:22:19 +0200
Message-Id: <20250720142218.145320-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addresses of the extended attributes are computed using the
fnode_ea() and next_ea() functions which refer to the fields residing in
a given fnode. There are no sanity checks for the returned values, so in
the case of corrupted data in the fnode, the ea addresses are invalid.

Fix the bug by adding ea_valid_addr() function which checks if a given
extended attribute resides within the range of the ea array of a given
fnode.

Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
Tested-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>

---
 fs/hpfs/anode.c   | 2 +-
 fs/hpfs/ea.c      | 6 +++---
 fs/hpfs/hpfs_fn.h | 5 +++++
 fs/hpfs/map.c     | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
index c14c9a035ee0..f347cdd94a5c 100644
--- a/fs/hpfs/anode.c
+++ b/fs/hpfs/anode.c
@@ -488,7 +488,7 @@ void hpfs_remove_fnode(struct super_block *s, fnode_secno fno)
 	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s, &fnode->btree);
 	else hpfs_remove_dtree(s, le32_to_cpu(fnode->u.external[0].disk_secno));
 	ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
 		if (ea_indirect(ea))
 			hpfs_ea_remove(s, ea_sec(ea), ea_in_anode(ea), ea_len(ea));
 	hpfs_ea_ext_remove(s, le32_to_cpu(fnode->ea_secno), fnode_in_anode(fnode), le32_to_cpu(fnode->ea_size_l));
diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
index 102ba18e561f..d7ada7f5a7ae 100644
--- a/fs/hpfs/ea.c
+++ b/fs/hpfs/ea.c
@@ -80,7 +80,7 @@ int hpfs_read_ea(struct super_block *s, struct fnode *fnode, char *key,
 	char ex[4 + 255 + 1 + 8];
 	struct extended_attribute *ea;
 	struct extended_attribute *ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	for (ea = fnode_ea(fnode); ea < ea_end  && ea_valid_addr(fnode, ea); ea = next_ea(ea))
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea))
 				goto indirect;
@@ -135,7 +135,7 @@ char *hpfs_get_ea(struct super_block *s, struct fnode *fnode, char *key, int *si
 	secno a;
 	struct extended_attribute *ea;
 	struct extended_attribute *ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea))
 				return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = ea_len(ea));
@@ -198,7 +198,7 @@ void hpfs_set_ea(struct inode *inode, struct fnode *fnode, const char *key,
 	unsigned char h[4];
 	struct extended_attribute *ea;
 	struct extended_attribute *ea_end = fnode_end_ea(fnode);
-	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
+	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
 		if (!strcmp(ea->name, key)) {
 			if (ea_indirect(ea)) {
 				if (ea_len(ea) == size)
diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
index 237c1c23e855..c65ce60d7d9a 100644
--- a/fs/hpfs/hpfs_fn.h
+++ b/fs/hpfs/hpfs_fn.h
@@ -152,6 +152,11 @@ static inline struct extended_attribute *next_ea(struct extended_attribute *ea)
 	return (struct extended_attribute *)((char *)ea + 5 + ea->namelen + ea_valuelen(ea));
 }
 
+static inline bool ea_valid_addr(struct fnode *fnode, struct extended_attribute *ea)
+{
+	return ((char *)ea >= (char *)&fnode->ea) && ((char *)ea < (char *)&fnode->ea + sizeof(fnode->ea));
+}
+
 static inline secno ea_sec(struct extended_attribute *ea)
 {
 	return le32_to_cpu(get_unaligned((__le32 *)((char *)ea + 9 + ea->namelen)));
diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
index ecd9fccd1663..0016dcbf1b1f 100644
--- a/fs/hpfs/map.c
+++ b/fs/hpfs/map.c
@@ -202,7 +202,7 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
 			}
 			ea = fnode_ea(fnode);
 			ea_end = fnode_end_ea(fnode);
-			while (ea != ea_end) {
+			while (ea != ea_end && ea_valid_addr(fnode, ea)) {
 				if (ea > ea_end) {
 					hpfs_error(s, "bad EA in fnode %08lx",
 						(unsigned long)ino);
-- 
2.25.1


