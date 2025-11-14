Return-Path: <linux-fsdevel+bounces-68549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 380CDC5F86A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 23:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B63935D0FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 22:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36749305958;
	Fri, 14 Nov 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDCMjZSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5C224D6;
	Fri, 14 Nov 2025 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160332; cv=none; b=IuUMuUe9wxLQdvj/5s6kzZRAtGJ/27MEYc2uvTQupTkTo94YXnaMFxoLjR5Zz+tlk57ZGrBzyL00lqDPrvjl18ZX1h0QhCr3rcPYKVYUhJYU1Tmjm55vlOxUJ25fqqyhZ4ljXVI03NEW4lh7lTBymnADgDUhrmqcf6SqIFtkpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160332; c=relaxed/simple;
	bh=dyFWzTva0KoeI0S+AEWyVmrx6PoflTe3eM10GlaAFVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCWM+D2gbDhU1BdB+JEXJgm7WPsOMMDaxOgMIDUiTprvplniePUgdKQhUxG/jtFhFGlQsUPbwG0Vsuj5S3pIuhmgDBxOjhOiDjpt90C+84eECQ/iAigiA0FCKqwNw1Yo/wOyKkKlPtiBKYNUZylfdkywyYwMx3biRMJFHp/jIHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDCMjZSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F6DC4CEF1;
	Fri, 14 Nov 2025 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763160332;
	bh=dyFWzTva0KoeI0S+AEWyVmrx6PoflTe3eM10GlaAFVw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BDCMjZSBR/GXGlgEqu9AUl4zxKa38u2g8Gd9W6c+qfR6tnRf70xTczZZ5LALpzqy5
	 mjOsFg/NeJhbVd73wbSaziMh5UDClRZUsngm+Op1zwhiW+Rlg6bZQ07cnbAyEOISR2
	 T+m5RZKk6YAbv1kYVVLKgFMXq54/y5HCxk68xsSkds4A3Pga0ah0ztGQmwrMbXPFT9
	 DD0wVBw4k68fM4wWKJiMBwy9sHqcozruCs44QZJWbu07ut27T3hdrWWAKwtFrcR/Mh
	 udv/xrDqzrZprTq97tqatVgSAeBPYE8gzr6ZybeN/3C0uSVJ1WJtD2wYLbrleVpo4j
	 0CHcc8j0IUi2A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 23:45:22 +0100
Subject: [PATCH 1/5] ovl: add copy up credential guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-copyup-v1-1-ea3fb15cf427@kernel.org>
References: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dyFWzTva0KoeI0S+AEWyVmrx6PoflTe3eM10GlaAFVw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKb+Qo0+hID/gvcbKhTGTOvAuTY6fM/mN5dFuk63+d6
 94OvjP5O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACai+I/hf9a/Xx/mLfS6+fNe
 ffXXqFuWYtzCahWrb1rmP23fUMb+9wPDP3N5iRp1P9cTskIl6z/p6pW1W6Ywczg9ffXwUSmLwop
 j7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a credential guard for copy up. This will allows us to waste struct
struct ovl_cu_creds and simplify the code.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index bb0231fc61fc..cc77498fa8ca 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -755,6 +755,33 @@ static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
 	}
 }
 
+static const struct cred *ovl_prepare_copy_up_creds(struct dentry *dentry)
+{
+	struct cred *copy_up_cred = NULL;
+	int err;
+
+	err = security_inode_copy_up(dentry, &copy_up_cred);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	if (!copy_up_cred)
+		return NULL;
+
+	return override_creds(copy_up_cred);
+}
+
+static void ovl_revert_copy_up_creds(const struct cred *orig_cred)
+{
+	const struct cred *copy_up_cred;
+
+	copy_up_cred = revert_creds(orig_cred);
+	put_cred(copy_up_cred);
+}
+
+DEFINE_CLASS(copy_up_creds, const struct cred *,
+	     if (!IS_ERR_OR_NULL(_T)) ovl_revert_copy_up_creds(_T),
+	     ovl_prepare_copy_up_creds(dentry), struct dentry *dentry)
+
 /*
  * Copyup using workdir to prepare temp file.  Used when copying up directories,
  * special files or when upper fs doesn't support O_TMPFILE.

-- 
2.47.3


