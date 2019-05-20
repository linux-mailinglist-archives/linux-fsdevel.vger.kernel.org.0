Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3437A23994
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbfETONJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:13:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47696 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388999AbfETONI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LrRxOMZmE8GgLPtKwiB8KhN/4UmD5iot032ZZXNIRpk=; b=o8Sn6gYyrU4euMQTz3gWOJA8nz
        AXYkTN0tOmdkxsV9UJa5k3wCFX7RR618+Q6E5v4wkVJK4V4IYeRo/f9zlWzSsxm3cVKaP1WQp2k40
        akaPdMwreanbtUyV2SZRYQND79c7buRJ15t4opDoTH5LIP8zSrxSYrt9cs+ak0ND+PwO1H/YAKpit
        ndJW3nScfJvHo3azw3mo9amWCQA0Bcnn3sRJTvzPo3dHUzooFHAzMuAMaaIW5Tcq+xDv6qrmlD7ZW
        RjItGh/SvuzAG+Yo6vL80N3lhzm0OL8XjbSSRxVH3tx4AbRW3Tgjysh2m4XxjzmeKu0o2zZ0D2x2C
        pbHZEECQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:43102 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2G-00039q-Ea; Mon, 20 May 2019 15:13:04 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2F-0000LH-Jc; Mon, 20 May 2019 15:13:03 +0100
In-Reply-To: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
References: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] fs/adfs: factor out filename comparison
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hSj2F-0000LH-Jc@rmk-PC.armlinux.org.uk>
Date:   Mon, 20 May 2019 15:13:03 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have essentially the same code in adfs_compare() as adfs_match(), so
arrange to use a common implementation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 68 +++++++++++++++++++++++------------------------------------
 1 file changed, 26 insertions(+), 42 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index e18eff854e1a..bebe2ab86aae 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -100,37 +100,39 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	return ret;
 }
 
-static int
-adfs_match(const struct qstr *name, struct object_info *obj)
+static int __adfs_compare(const unsigned char *qstr, u32 qlen,
+			  const char *str, u32 len)
 {
-	int i;
+	u32 i;
 
-	if (name->len != obj->name_len)
-		return 0;
+	if (qlen != len)
+		return 1;
 
-	for (i = 0; i < name->len; i++) {
-		char c1, c2;
+	for (i = 0; i < qlen; i++) {
+		unsigned char qc, c;
 
-		c1 = name->name[i];
-		c2 = obj->name[i];
+		qc = qstr[i];
+		c = str[i];
 
-		if (c1 >= 'A' && c1 <= 'Z')
-			c1 += 'a' - 'A';
-		if (c2 >= 'A' && c2 <= 'Z')
-			c2 += 'a' - 'A';
+		if (qc >= 'A' && qc <= 'Z')
+			qc += 'a' - 'A';
+		if (c >= 'A' && c <= 'Z')
+			c += 'a' - 'A';
 
-		if (c1 != c2)
-			return 0;
+		if (qc != c)
+			return 1;
 	}
-	return 1;
+	return 0;
 }
 
-static int
-adfs_dir_lookup_byname(struct inode *inode, const struct qstr *name, struct object_info *obj)
+static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
+				  struct object_info *obj)
 {
 	struct super_block *sb = inode->i_sb;
 	const struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
+	const unsigned char *name;
 	struct adfs_dir dir;
+	u32 name_len;
 	int ret;
 
 	ret = ops->read(sb, inode->i_ino, inode->i_size, &dir);
@@ -153,8 +155,10 @@ adfs_dir_lookup_byname(struct inode *inode, const struct qstr *name, struct obje
 		goto unlock_out;
 
 	ret = -ENOENT;
+	name = qstr->name;
+	name_len = qstr->len;
 	while (ops->getnext(&dir, obj) == 0) {
-		if (adfs_match(name, obj)) {
+		if (!__adfs_compare(name, name_len, obj->name, obj->name_len)) {
 			ret = 0;
 			break;
 		}
@@ -212,30 +216,10 @@ adfs_hash(const struct dentry *parent, struct qstr *qstr)
  * Compare two names, taking note of the name length
  * requirements of the underlying filesystem.
  */
-static int
-adfs_compare(const struct dentry *dentry,
-		unsigned int len, const char *str, const struct qstr *name)
+static int adfs_compare(const struct dentry *dentry, unsigned int len,
+			const char *str, const struct qstr *qstr)
 {
-	int i;
-
-	if (len != name->len)
-		return 1;
-
-	for (i = 0; i < name->len; i++) {
-		char a, b;
-
-		a = str[i];
-		b = name->name[i];
-
-		if (a >= 'A' && a <= 'Z')
-			a += 'a' - 'A';
-		if (b >= 'A' && b <= 'Z')
-			b += 'a' - 'A';
-
-		if (a != b)
-			return 1;
-	}
-	return 0;
+	return __adfs_compare(qstr->name, qstr->len, str, len);
 }
 
 const struct dentry_operations adfs_dentry_operations = {
-- 
2.7.4

