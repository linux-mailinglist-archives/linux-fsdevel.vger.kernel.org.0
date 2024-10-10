Return-Path: <linux-fsdevel+bounces-31597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E41A998B77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F9128EC33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944F21CCB4B;
	Thu, 10 Oct 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="iuF2wfRk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7181CC8B7
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 15:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574028; cv=none; b=jAWWXMmeUHtVcyen1bt2JaCfhj+E0bmaZRgCLzTRMAVhhJg1aooZqM8KjoYWzwqMNUMTpZvfaXhqEsW/gcU6icxP//lGdp//HD6PQ3Al5ZgeQykPjO83d5A0oH9+xzt/9U0tV4Jhicj2QyIroRiC9dBo7V4Dgz0qp9TAWgi5Uhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574028; c=relaxed/simple;
	bh=ryBbVbP+eCu4Chmt9r8z0TKeMs0QNaJcFFaozpvWy6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mv1KQvYuZjwqNsjqbTzG/Rwqq5jdrGWSkbnNqh5CLGL/FKpNTGroIUMqcevvRZOeWEcM0xMMwd5/H0kbu8AYercfE9DpQkZnkTO3fD5758rEkhQG40lGI23yyV8rM46mvtIzikNRa9QIz1pQpJssGdvV07bZyczZCZGxsu+ZH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=iuF2wfRk; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPYX663BxzdR;
	Thu, 10 Oct 2024 17:27:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728574022;
	bh=jlq3WMYYb2u2o19lJZDW1kPWSutQrpjLQmd69+bE43M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iuF2wfRkyeYu6EKOgXoVeneuFDbtn7vCOr2DUIxmztTnlwdAzw1qYYx6TCHkhhtz+
	 w9V83sXxnKBunWfaL236qRsZeF/csBdfEfSmDTUftqaxv75fPASoJuDE0xQ8t6ngI3
	 VdJSKx/UT5Bx/W3xeGPkpGItyd2t00BFLDjKYrkw=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPYX61YlJzB9y;
	Thu, 10 Oct 2024 17:27:02 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: [RFC PATCH v1 6/7] smack: Fix inode numbers in logs
Date: Thu, 10 Oct 2024 17:26:46 +0200
Message-ID: <20241010152649.849254-6-mic@digikod.net>
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use the new inode_get_ino() helper to log the user space's view of
inode's numbers instead of the private kernel values.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/smack/smack_lsm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 370fd594da12..0be7e442e70f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -199,8 +199,8 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
-		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
-			inode->i_sb->s_id, inode->i_ino, current->comm);
+		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
+			inode->i_sb->s_id, inode_get_ino(inode), current->comm);
 
 	if (rc <= 0)
 		return rc;
@@ -212,9 +212,9 @@ static int smk_bu_inode(struct inode *inode, int mode, int rc)
 
 	smk_bu_mode(mode, acc);
 
-	pr_info("Smack %s: (%s %s %s) inode=(%s %ld) %s\n", smk_bu_mess[rc],
+	pr_info("Smack %s: (%s %s %s) inode=(%s %llu) %s\n", smk_bu_mess[rc],
 		tsp->smk_task->smk_known, isp->smk_inode->smk_known, acc,
-		inode->i_sb->s_id, inode->i_ino, current->comm);
+		inode->i_sb->s_id, inode_get_ino(inode), current->comm);
 	return 0;
 }
 #else
@@ -231,8 +231,8 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
-		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
-			inode->i_sb->s_id, inode->i_ino, current->comm);
+		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
+			inode->i_sb->s_id, inode_get_ino(inode), current->comm);
 
 	if (rc <= 0)
 		return rc;
@@ -240,9 +240,9 @@ static int smk_bu_file(struct file *file, int mode, int rc)
 		rc = 0;
 
 	smk_bu_mode(mode, acc);
-	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
+	pr_info("Smack %s: (%s %s %s) file=(%s %llu %pD) %s\n", smk_bu_mess[rc],
 		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
-		inode->i_sb->s_id, inode->i_ino, file,
+		inode->i_sb->s_id, inode_get_ino(inode), file,
 		current->comm);
 	return 0;
 }
@@ -261,8 +261,8 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 	char acc[SMK_NUM_ACCESS_TYPE + 1];
 
 	if (isp->smk_flags & SMK_INODE_IMPURE)
-		pr_info("Smack Unconfined Corruption: inode=(%s %ld) %s\n",
-			inode->i_sb->s_id, inode->i_ino, current->comm);
+		pr_info("Smack Unconfined Corruption: inode=(%s %llu) %s\n",
+			inode->i_sb->s_id, inode_get_ino(inode), current->comm);
 
 	if (rc <= 0)
 		return rc;
@@ -270,9 +270,9 @@ static int smk_bu_credfile(const struct cred *cred, struct file *file,
 		rc = 0;
 
 	smk_bu_mode(mode, acc);
-	pr_info("Smack %s: (%s %s %s) file=(%s %ld %pD) %s\n", smk_bu_mess[rc],
+	pr_info("Smack %s: (%s %s %s) file=(%s %llu %pD) %s\n", smk_bu_mess[rc],
 		sskp->smk_known, smk_of_inode(inode)->smk_known, acc,
-		inode->i_sb->s_id, inode->i_ino, file,
+		inode->i_sb->s_id, inode_get_ino(inode), file,
 		current->comm);
 	return 0;
 }
-- 
2.46.1


