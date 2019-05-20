Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B155323995
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390494AbfETONQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:13:16 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47704 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390464AbfETONP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l+WHOw8gvmqMpQAX/si7VKoIeMV+5zvIMKfdjv73j28=; b=C/FzPlWcaHKLQZIiEwCQTSC3jC
        DYesKnkfCQPuY2Iv6RZNC/BqKEuX8862rimsPCL+39bVOd3EVZuctCzbyaxrRoMCbyZTPdvpY1GIk
        HDwalKZPI0jpMMO1LXnlyCVEjy1+ZtnQ7+6QFijaT++mLQCsjQRjYYRpFTuGXNZP/O0FYP7yk16cu
        7ciWR+iFnXPkNS4OhgJQxVonclRBtbXyPEzyRErw3If/fzqDR4Voa+bHPmucZ4bpW198TYCE+DlkY
        JQqYEoDMw34iCuSvPdDBhV+TRDejmGjrdhSyoFa1ZBo9M7k5wEZ3ppMf7plwy8irIsNF4RKtTzU6D
        1w0PzIsA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33160 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2L-0003A6-Q9; Mon, 20 May 2019 15:13:09 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2K-0000LP-Nh; Mon, 20 May 2019 15:13:08 +0100
In-Reply-To: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
References: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/7] fs/adfs: factor out filename case lowering
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hSj2K-0000LP-Nh@rmk-PC.armlinux.org.uk>
Date:   Mon, 20 May 2019 15:13:08 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out the filename case lowering of directory names when comparing
or hashing filenames.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index bebe2ab86aae..be4b4f950500 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -100,6 +100,13 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	return ret;
 }
 
+static unsigned char adfs_tolower(unsigned char c)
+{
+	if (c >= 'A' && c <= 'Z')
+		c += 'a' - 'A';
+	return c;
+}
+
 static int __adfs_compare(const unsigned char *qstr, u32 qlen,
 			  const char *str, u32 len)
 {
@@ -108,20 +115,10 @@ static int __adfs_compare(const unsigned char *qstr, u32 qlen,
 	if (qlen != len)
 		return 1;
 
-	for (i = 0; i < qlen; i++) {
-		unsigned char qc, c;
-
-		qc = qstr[i];
-		c = str[i];
-
-		if (qc >= 'A' && qc <= 'Z')
-			qc += 'a' - 'A';
-		if (c >= 'A' && c <= 'Z')
-			c += 'a' - 'A';
-
-		if (qc != c)
+	for (i = 0; i < qlen; i++)
+		if (adfs_tolower(qstr[i]) != adfs_tolower(str[i]))
 			return 1;
-	}
+
 	return 0;
 }
 
@@ -198,15 +195,8 @@ adfs_hash(const struct dentry *parent, struct qstr *qstr)
 	qstr->len = i = name_len;
 	name = qstr->name;
 	hash = init_name_hash(parent);
-	while (i--) {
-		char c;
-
-		c = *name++;
-		if (c >= 'A' && c <= 'Z')
-			c += 'a' - 'A';
-
-		hash = partial_name_hash(c, hash);
-	}
+	while (i--)
+		hash = partial_name_hash(adfs_tolower(*name++), hash);
 	qstr->hash = end_name_hash(hash);
 
 	return 0;
-- 
2.7.4

