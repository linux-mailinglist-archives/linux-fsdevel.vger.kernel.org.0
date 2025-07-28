Return-Path: <linux-fsdevel+bounces-56131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF89B13A15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 13:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37DF173D1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72BB25D53B;
	Mon, 28 Jul 2025 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VUoTQR5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B59EC4;
	Mon, 28 Jul 2025 11:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753703735; cv=none; b=j1jKXGG0PVx9QaCcB/lRBbdn8PaRA+cKb8ugGOeTotLQ0gkjLwNFUv2rpCW/G00h84iN7NPKiaYdz8mNT6KcRlEyZEDHF22rZlXPekdbSz0upd+rRsmgQuW8Lpzia+HjNf2cdci4W5RUPv9ed7oJkyCZyxTCoL9X3La58TXTXfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753703735; c=relaxed/simple;
	bh=fcbwt3G52MNMFEwRUpp6XzY8fadc4uM0f7svg+Tc4m0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=M22XmbD6fw3kxfERak065WscZzTGIJLARBcKn5DSLB/YxORC1BVX5nWqV22CQoalWP0cDdSCUvfi8h9oA5QGhA1RZSQFxuLOgQOgzVLnxNIai9FpDXdyR1iKKYwq6+jteIz0PkhwvSZYF6+ch1HUk5umpD9lZzI9DIYFrmdAU2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VUoTQR5R; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753703426; bh=u+wviN/hLzceW2iD5s9fB1HpIjf+7vyOm5QzlyTZVcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VUoTQR5RrIa/uEDgKCl/aNOfQCfKfOHCF/JU1uERxf7bdQLsCR5X7R4b5uLH6Guna
	 gYAinB1Vemcr//pQJKIpmX3VTMXp8iL/PPwElfnQj0K2nL5EGOctGJNDFQDhGxw5as
	 vMq4cvknkrl3mEgvKDkxcMvC97kJyEzNYRnzxklY=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 94699896; Mon, 28 Jul 2025 19:37:06 +0800
X-QQ-mid: xmsmtpt1753702626t5x85pive
Message-ID: <tencent_E34B081B4A25E3BA9DBBB733019E4E1BD408@qq.com>
X-QQ-XMAILINFO: MdKyu+guYNCkFDxrwLRKyiNvIRw+VQ+MwHsKdohCAw3OeJzhatMqQYcb4RdcDj
	 iIEggLLoxAzaxjOETm6snsoFmaTxHlsNftErvAX4CGzKM8jWngyEFmH8xR4aSHr1ZhTNmCYhixcv
	 f4nvdbAN7e4w8NmmG7h0R2VFP0j1lCqQEOapi8FA3g3GbmHyWEKi6D9NYOEhZaXSh0CXcKNnrEck
	 kW6j2qO8D8RpkOZiL0K9rq4yZ7PKqvrfinEl1zsCIedD3Jdi+NEBdFFq2WrFzr4lqzdEd1pbSA93
	 vknROccbh1UlJ/grTSo1f+nl5/YEP2RDJ+f/y3TuQ/dS/SBEXyNi6w9CiNaMz2E/LHmNznNlRLdb
	 aocU5ax7yHh7onm0WW2MbowMW2p4AdKOXaltS6HTktgzYCbLygHXnIPHsjoDnwIGu6oSNEPyKbJJ
	 fZ6rY/tjUzmpTOwRR7X+0QnOLE5jCHEQpqpwfjYJpC5kBtytgWjGdwEwmP+PywbtafhjzW9eQqyP
	 5KwFwOpOHbxqF/LKp2NfKEog54Qk9ORZGuf3ZPLag6rEDIG793b76zUYfbvonM0YOXQod10F/v25
	 WfCFg9xSli8xX1l9Hk+Xu3g5nt3eCpJBmYM4A5RYzfEUE9mJ86BuNiTwYVYD+8glqWll/os6fRjb
	 lR1OP66Wy+hCXZof9cOwdYb/hwtA/aOcHBjMfvd9BaEC1JwDeT1DYhe40cFjhT4ReKBkihHqyIEr
	 BVpGO05LG+l7FCq8XRNsBXFL5pBf6EWK+XRPsQMXrCe0lEvoDFLJH8mA/WbzCItRMttFz0mAQu9r
	 BZobdeDCyU0oLufXHAfQECQbgobbjMRnTtJw2y/MJNmdPEEFF//Y7hEox4kTmJqJ1yBHa/FMAZEJ
	 25npiA7QXRzihMnxH9UCGKS5nrdiMx+t+nyM4QrV9cMsk+Av858O/oFCu0JPmMhbQzdDP8Mwi+Vq
	 w+grHw2/a1mZVxtv+XdNyV0icj+Ugb/hBoNO0Hj9lLhaNpdbLw9A==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com
Cc: hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32 entry
Date: Mon, 28 Jul 2025 19:37:02 +0800
X-OQ-MSGID: <20250728113701.2185548-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6887321b.a00a0220.b12ec.0096.GAE@google.com>
References: <6887321b.a00a0220.b12ec.0096.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The writer and reader access FAT32 entry without any lock, so the data
obtained by the reader is incomplete.

Add spin lock to solve the race condition that occurs when accessing
FAT32 entry.

FAT16 entry has the same issue and is handled together.

Reported-by: syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d3c29ed63db6ddf8406e
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/fat/fatent.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index a7061c2ad8e4..0e64875e932c 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -19,6 +19,8 @@ struct fatent_operations {
 };
 
 static DEFINE_SPINLOCK(fat12_entry_lock);
+static DEFINE_SPINLOCK(fat16_entry_lock);
+static DEFINE_SPINLOCK(fat32_entry_lock);
 
 static void fat12_ent_blocknr(struct super_block *sb, int entry,
 			      int *offset, sector_t *blocknr)
@@ -137,8 +139,13 @@ static int fat12_ent_get(struct fat_entry *fatent)
 
 static int fat16_ent_get(struct fat_entry *fatent)
 {
-	int next = le16_to_cpu(*fatent->u.ent16_p);
+	int next;
+
+	spin_lock(&fat16_entry_lock);
+	next = le16_to_cpu(*fatent->u.ent16_p);
 	WARN_ON((unsigned long)fatent->u.ent16_p & (2 - 1));
+	spin_unlock(&fat16_entry_lock);
+
 	if (next >= BAD_FAT16)
 		next = FAT_ENT_EOF;
 	return next;
@@ -146,8 +153,13 @@ static int fat16_ent_get(struct fat_entry *fatent)
 
 static int fat32_ent_get(struct fat_entry *fatent)
 {
-	int next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
+	int next;
+
+	spin_lock(&fat32_entry_lock);
+	next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
 	WARN_ON((unsigned long)fatent->u.ent32_p & (4 - 1));
+	spin_unlock(&fat32_entry_lock);
+
 	if (next >= BAD_FAT32)
 		next = FAT_ENT_EOF;
 	return next;
@@ -180,15 +192,21 @@ static void fat16_ent_put(struct fat_entry *fatent, int new)
 	if (new == FAT_ENT_EOF)
 		new = EOF_FAT16;
 
+	spin_lock(&fat16_entry_lock);
 	*fatent->u.ent16_p = cpu_to_le16(new);
+	spin_unlock(&fat16_entry_lock);
+
 	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
 }
 
 static void fat32_ent_put(struct fat_entry *fatent, int new)
 {
 	WARN_ON(new & 0xf0000000);
+	spin_lock(&fat32_entry_lock);
 	new |= le32_to_cpu(*fatent->u.ent32_p) & ~0x0fffffff;
 	*fatent->u.ent32_p = cpu_to_le32(new);
+	spin_unlock(&fat32_entry_lock);
+
 	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
 }
 
-- 
2.43.0


