Return-Path: <linux-fsdevel+bounces-45136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA9BA73436
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 15:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E92917C520
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30811217727;
	Thu, 27 Mar 2025 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="XvuiNMPn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471D2216399;
	Thu, 27 Mar 2025 14:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743085050; cv=none; b=K0QdiujSi8aUqdiaLTAQawkS/Nh20eVWYuXUODXC/zojDa3nB5l0gwmcnKUvWELYCdEOwKnMs+Dz8vOYTZsOOwuWxhg8OUvneT7dETFd4pj2HGhJMBJE7ctqzjLJNXN50c8bK8el+ByiCrSVff/MhitW/vYn7Q52EcXKVi1SkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743085050; c=relaxed/simple;
	bh=yxoa31pGOxJ2FohF6xJlYSCyW0JGAGDAJTDpStaj7Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyVHBhaGOIkKWkwt1esb0oUTI3uaRq0FFmd+t6xDarphz+z2TT0C20KwmQJmYe9MBHc8Mj6Q9ST2FajnpkncdsQ/2HzZJVNRjzGTVdLmzKYMloLYYgmk/mFXojnJzYfwhoqN9bWVNllpnA/Zwebvu9njYw5fvZDfrmwimQi4lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=XvuiNMPn; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1743085048;
	bh=yxoa31pGOxJ2FohF6xJlYSCyW0JGAGDAJTDpStaj7Ds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=XvuiNMPnkRkL6jE7B5vEs8Jp0ypn4qVIKbrwq+U/W7hbCMcUwHdEGAyK2ongJeVmp
	 58Cfv4Ui7BD+rRdKniCP4uMnPAmXPKXplQwsTP/q9yA/8or6RTROp5VG/gyxewVL1f
	 CaNWH1v8fEe6NX2uwU5cVlA8CoXAArJUDJCECn18=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 882421C0015;
	Thu, 27 Mar 2025 10:17:27 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mcgrof@kernel.org,
	jack@suse.cz,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [RFC PATCH 3/4] fs/super.c: introduce reverse superblock iterator and use it in emergency remount
Date: Thu, 27 Mar 2025 10:06:12 -0400
Message-ID: <20250327140613.25178-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally proposed by Amir as an extract from the android kernel:

https://lore.kernel.org/linux-fsdevel/CAA2m6vfatWKS1CQFpaRbii2AXiZFvQUjVvYhGxWTSpz+2rxDyg@mail.gmail.com/

Since suspend/resume requires a reverse iterator, I'm dusting it off.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 fs/super.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 5a7db4a556e3..76785509d906 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -887,28 +887,38 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
+#define ITERATE_SUPERS(f, rev)					\
+	struct super_block *sb, *p = NULL;			\
+								\
+	spin_lock(&sb_lock);					\
+								\
+	list_for_each_entry##rev(sb, &super_blocks, s_list) {	\
+		if (super_flags(sb, SB_DYING))			\
+			continue;				\
+		sb->s_count++;					\
+		spin_unlock(&sb_lock);				\
+								\
+		f(sb);						\
+								\
+		spin_lock(&sb_lock);				\
+		if (p)						\
+			__put_super(p);				\
+		p = sb;						\
+	}							\
+	if (p)							\
+		__put_super(p);					\
+	spin_unlock(&sb_lock);
+
 static void __iterate_supers(void (*f)(struct super_block *))
 {
-	struct super_block *sb, *p = NULL;
-
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (super_flags(sb, SB_DYING))
-			continue;
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-
-		f(sb);
+	ITERATE_SUPERS(f,)
+}
 
-		spin_lock(&sb_lock);
-		if (p)
-			__put_super(p);
-		p = sb;
-	}
-	if (p)
-		__put_super(p);
-	spin_unlock(&sb_lock);
+static void __iterate_supers_rev(void (*f)(struct super_block *))
+{
+	ITERATE_SUPERS(f, _reverse)
 }
+
 /**
  *	iterate_supers - call function for all active superblocks
  *	@f: function to call
@@ -1132,7 +1142,7 @@ static void do_emergency_remount_callback(struct super_block *sb)
 
 static void do_emergency_remount(struct work_struct *work)
 {
-	__iterate_supers(do_emergency_remount_callback);
+	__iterate_supers_rev(do_emergency_remount_callback);
 	kfree(work);
 	printk("Emergency Remount complete\n");
 }
-- 
2.43.0


