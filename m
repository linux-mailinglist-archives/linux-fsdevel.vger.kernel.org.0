Return-Path: <linux-fsdevel+bounces-12372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E431D85EA7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 22:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1CC284ED6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 21:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D41353E1;
	Wed, 21 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC2BZrnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD851292FF;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550706; cv=none; b=E3HFdt8o9s0cxvn/tY9H5AjLk0foBJB39WHHBnVIkgItBL4aMFO4gxsC0v7gOF0XUJrQp0Fq9fSxX6VWjBzPPlxYaP3QEwRfYsO6JJvL/llPPTQyw+tu1/jNHGX33ZDYAKrcMOPDJuAozHwjuD/Fncl4PQxI6ZZKQmDey3jJn+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550706; c=relaxed/simple;
	bh=lEHQXdLzM8XZmLEljh/ycw/4aa43YTvfIWETR64S7L4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mq6PcSOuxWw2NQO20b2/ULW/n/9jdn0BsA82pLQdmuYptzVcDf8RMeBfOK65tR3jUeHL1SRHHCaLIfIj8WZ9IH7zFRL7Fv7qBhnMFdwzo3lLXXhOj6SsXIYdnffy1ZxsjXfCSeKowAxC6Hb8LPjbbGcDjAyVJYWzj+ookU6xsZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC2BZrnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 662C0C32784;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708550706;
	bh=lEHQXdLzM8XZmLEljh/ycw/4aa43YTvfIWETR64S7L4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UC2BZrnh4lZXsjpnjx7aANMXeCVkZvoQtXOjOZOT8xxnq7bJsb0arNGCdzXPhB79M
	 CRZgleKWNdeC+ZerEGDq2Q9NZr4JJau/CRBGKV0m/lNO/MgnJPlkC236U8Q1VUvwcE
	 gekbp89+TKBF2TDd5vAbzCjWkLtYJE9MTac2VPDPKxvptO0t/JWF6u9r3k/XUCz/zU
	 y9barmElKlj5vGlpuHAjm00yLb/7UoUvR3J0vRzDdrfJgiIw1WSmfltoAdvPvep33w
	 BV2cIqgqZD2xLGRoYHm1KMpuySNQNViUrDL/TlyKPSYs655oBmI+NgnQJSxLLPR5/1
	 65LN77kcX4EuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D3BC54793;
	Wed, 21 Feb 2024 21:25:06 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 21 Feb 2024 15:24:41 -0600
Subject: [PATCH v2 10/25] xattr: use is_fscaps_xattr()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-idmap-fscap-refactor-v2-10-3039364623bd@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=597; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=lEHQXdLzM8XZmLEljh/ycw/4aa43YTvfIWETR64S7L4=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBl1mohq2XZVoBy8FgqIjMltMFNu?=
 =?utf-8?q?zAWaj/Pn1Cc2fiJ_PO+HZrOJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZdZqIQAKCRBTA5mu5fQxyQ77B/_9KzJ+i0X5eDYLpwTJQmYMCRqYN6k0Iuk1pw?=
 =?utf-8?q?bpwXjF9ph8I+iLw/R/XYDD3yf025kbMHTCQC+Z0TYiw_Wh64DvoVlVS+FkNp+7sCJ?=
 =?utf-8?q?ETr3Lmx3gEs2vJNh+zIRRm9awNuEhnAezPVeOC9vXAOEB4vxQMJwWjjNG_apBxkgO?=
 =?utf-8?q?4CvmpusSXAZOJhK6Uo5XqCiEgjcl0DXRtnMbTph6y2KmqFVanvM1qba2HEXNFpL87?=
 =?utf-8?q?fAwpST_UDykJ5pSN8a964iteXDvWw/PLqFS33BKI9sLHcykFsgV4nTYUWM+hpTJJV?=
 =?utf-8?q?1rOFRiE2YRaSB35mPMvF?= 52ifUub/2VOnPAqvb376YvVerDPSZW
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 09d927603433..06290e4ebc03 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -310,7 +310,7 @@ vfs_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const void  *orig_value = value;
 	int error;
 
-	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
+	if (size && is_fscaps_xattr(name)) {
 		error = cap_convert_nscap(idmap, dentry, &value, size);
 		if (error < 0)
 			return error;

-- 
2.43.0


