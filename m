Return-Path: <linux-fsdevel+bounces-30452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EFB98B7CF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CAB282FCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEC119D09F;
	Tue,  1 Oct 2024 09:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="QGRjrPut"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3D19B3C1;
	Tue,  1 Oct 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773296; cv=none; b=DokVmJ3Dgwl9Kd3eHKD1hUjCl8hHmW5Z4NRbfXtEpp1lU7IlcGpXUW7oGApC6Nd4kca5jMeKiXMKen5ahVRX+0i32YkHH+eSyGGTvFhJrV5YJGV5FuSWstmcez1G4fPRpI+EHKRvByTVieUseXOgh+L3x7+oe1bzsh2dtGbbJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773296; c=relaxed/simple;
	bh=Hwgi/y5Dk7t34WtuR23fuoxzTvfdQf0eldBit/gselk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApVcoguMa76VicFewAh1R+tPcY2jn3Go8b8RWVOhhWisNtqRJivJ1tGorW3T5NXirc6E8z+eHZsWcMbTYpBowaq71L0qmocb4EqKLQs2Ha+2PWvUCsahImXeZ0sUeVaXbYsPVvdahN7pwxlqbOSTyeT3N0NM4/5Q7SIebPlWAxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=QGRjrPut; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id DC6F421BD;
	Tue,  1 Oct 2024 08:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1727772834;
	bh=8qucmwn+c7J8uqN629Lesahfgqjtj3mJT43MI9cKjFs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QGRjrPutmJx4gKxcYgWdJ5oT9s4pIinErKE1CcDGyp2+IqNvGDmUZZJjzg45uR7Tl
	 D0t9hevzWxazyjYT12t0/piMxj5RSaox4Fk0un4v2HkOeWkhJKBvbMQx7KRRHFnOT+
	 wMr473R1RQjU+TR4bcqXJv/RR90mhtxEWpLhaPuc=
Received: from ntfs3vm.paragon-software.com (192.168.211.162) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Oct 2024 12:01:28 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6/6] fs/ntfs3: Format output messages like others fs in kernel
Date: Tue, 1 Oct 2024 12:01:04 +0300
Message-ID: <20241001090104.15313-7-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001090104.15313-1-almaz.alexandrovich@paragon-software.com>
References: <20241001090104.15313-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 128d49512f5d..6a0f6b0a3ab2 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -90,7 +90,7 @@ void ntfs_printk(const struct super_block *sb, const char *fmt, ...)
 	level = printk_get_level(fmt);
 	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
-	printk("%c%cntfs3: %s: %pV\n", KERN_SOH_ASCII, level, sb->s_id, &vaf);
+	printk("%c%cntfs3(%s): %pV\n", KERN_SOH_ASCII, level, sb->s_id, &vaf);
 
 	va_end(args);
 }
@@ -124,10 +124,15 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 		struct dentry *de = d_find_alias(inode);
 
 		if (de) {
+			int len;
 			spin_lock(&de->d_lock);
-			snprintf(name, sizeof(s_name_buf), " \"%s\"",
-				 de->d_name.name);
+			len = snprintf(name, sizeof(s_name_buf), " \"%s\"",
+				       de->d_name.name);
 			spin_unlock(&de->d_lock);
+			if (len <= 0)
+				name[0] = 0;
+			else if (len >= sizeof(s_name_buf))
+				name[sizeof(s_name_buf) - 1] = 0;
 		} else {
 			name[0] = 0;
 		}
@@ -140,7 +145,7 @@ void ntfs_inode_printk(struct inode *inode, const char *fmt, ...)
 	vaf.fmt = printk_skip_level(fmt);
 	vaf.va = &args;
 
-	printk("%c%cntfs3: %s: ino=%lx,%s %pV\n", KERN_SOH_ASCII, level,
+	printk("%c%cntfs3(%s): ino=%lx,%s %pV\n", KERN_SOH_ASCII, level,
 	       sb->s_id, inode->i_ino, name ? name : "", &vaf);
 
 	va_end(args);
-- 
2.34.1


