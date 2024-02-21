Return-Path: <linux-fsdevel+bounces-12383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E4F85EAC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443A2285CD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1B614A09C;
	Wed, 21 Feb 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScFEMz6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBFF12B176;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550707; cv=none; b=nvK7NW0t3P35Ozc+byRM6qG0k1I5fm0Mx+SAORJbtZu31DwFeafs+K0A3k5hf3825pWO0QKtLMuwGqP/EU+sLopTb7FncyGKPcSdNUDhdB/KC5KKA1ygK7Wf7lh0Wx3uSQFPFzS8NuybOHRChlGlcFB38LLSSMIJsjJglr1BZC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550707; c=relaxed/simple;
	bh=CJx4jVGIRqQ1qdmTj2y9zLMKH38BdGpPQGSp5yBCQqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RsSjfPSZE4aHzTEE1oVRx7CuTu3dE7UH05dTc66Nh9j45hHpH8G3mnn3MC0dnM1hDJnxQhgR0IsJcCDjD2vVyAGXoUZK/zbVpptTfPypISd4uoVcayc5zsIu8xRSJ+DdI4QGc2wUWoEPgYrZktaZD8ZaX122lO8gwihHQJ1NUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScFEMz6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB04AC32795;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=CJx4jVGIRqQ1qdmTj2y9zLMKH38BdGpPQGSp5yBCQqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ScFEMz6FlokZomeuAvsLqnXQTflRHEh6BIQBe96Ib9pULn8Wj4+DpC7Xfs8aTexs7
	 qTiVdQUGtX+RU3zggTNkWmIrVpcMUO6N+cwr43fGo9nWV/a5PLS4ItLlRmU9FbrqIB
	 5Fqw36ofvD0sLbq9fFeIkUSaRu2bFetOjiQk+SpXaVH/bo3+jCjulvqWK0vKRULblx
	 2LRZiCwub+3/tki2vXE72U2ySzZt7yQa0Fh+FnnVf6+9pIJpgArXMkOTlvYnR1Yx2p
	 pMyEmo3Yf/KuwhCrM2ulibMDJ6mZDj1XgQCNFQHu4B3b7bRKxg/Rx4wNmsitGS/MvI
	 AzKnC3SypEVcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7938C48BEB;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:46 -0600
Subject: [PATCH v2 15/25] security: call evm fscaps hooks from generic
 security hooks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-15-3039364623bd@kernel.org>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
In-Reply-To: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Seth Forshee <sforshee@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, 
 Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 selinux@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=CJx4jVGIRqQ1qdmTj2y9zLMKH38BdGpPQGSp5yBCQqY=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1molI6sVtDD31t+ZdHf1WoPke?=
 =?utf-8?q?0imykwNoYOzlcEa_MLxxYsqJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqJQAKCRBTA5mu5fQxyUmKB/_sG1SON2b9GiN9agwuQ8lNxw2IHmhmbxgz33?=
 =?utf-8?q?hhQ2tViUIItDAJSIkNy5i0HyqiJgPzP/w1VR+NSBYZ3_rze6gn/V7wNsI6T4BHcLg?=
 =?utf-8?q?Xfr/PP7enV45rcBxOGWDoeBgrvhVY2RIIRwv0+5nKw+ZUUoxMJyIXsguH_AQe19vJ?=
 =?utf-8?q?zujrIFbKdZ5VySsugJ5uN9keqsl3z8Qth5BpJ4cml1+ab/U3rPxAwFa/t2OH6DxBK?=
 =?utf-8?q?RvYF0c_GVb+YvhlZ+LDNcy1vbiuUqcuEeEatxNwdefLfn1dBPKNGW6/nY86XhjMB6?=
 =?utf-8?q?6KBqJqPp/VEC20A/hPcB?= ne6Sf/61X39xbpD+uZnRFwaVm9Ag8L
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 security/security.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/security/security.c b/security/security.c
index 0d210da9862c..f515d8430318 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2365,9 +2365,14 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
 int security_inode_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
 			      const struct vfs_caps *caps, int flags)
 {
+	int ret;
+
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps, flags);
+	ret = call_int_hook(inode_set_fscaps, 0, idmap, dentry, caps, flags);
+	if (ret)
+		return ret;
+	return evm_inode_set_fscaps(idmap, dentry, caps, flags);
 }
 
 /**
@@ -2387,6 +2392,7 @@ void security_inode_post_set_fscaps(struct mnt_idmap *idmap,
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return;
 	call_void_hook(inode_post_set_fscaps, idmap, dentry, caps, flags);
+	evm_inode_post_set_fscaps(idmap, dentry, caps, flags);
 }
 
 /**
@@ -2415,9 +2421,14 @@ int security_inode_get_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
  */
 int security_inode_remove_fscaps(struct mnt_idmap *idmap, struct dentry *dentry)
 {
+	int ret;
+
 	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
 		return 0;
-	return call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
+	ret = call_int_hook(inode_remove_fscaps, 0, idmap, dentry);
+	if (ret)
+		return ret;
+	return evm_inode_remove_fscaps(dentry);
 }
 
 /**

-- 
2.43.0


