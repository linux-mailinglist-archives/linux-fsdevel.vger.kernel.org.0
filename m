Return-Path: <linux-fsdevel+bounces-35907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A68D9D9872
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 14:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F05164ED6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 13:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371A1D47DC;
	Tue, 26 Nov 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahHS9jmn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80821CEE96;
	Tue, 26 Nov 2024 13:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627345; cv=none; b=NRW3d1tVG360Xo1g7PeqfO6NiYLkKZGrfwzDg/Pk3dE3gMfVLltMTshooEbuvjRgLTSYWIK7l4+KTAnPXS1XPEO9wu4DKGv/CmPjsi381s+4jO5DvBJppLmvztBfvOJrkPn6aY0qscikth6TRRgo9Pa2z0uSmXg2xV8TpITUi9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627345; c=relaxed/simple;
	bh=RzAX0nZKTrlawErV82aO5uN+J0u44XEx+6Xw+tktJ1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iv5C7p+pcKId/7h0Gv/OksYK88DEHHmTe157nRPmmLkT2zWaUDaNOX0sksWB+DmUtS07uGFhdHsAmFjKPbAYu5eBdShy9ZvKLzcHI0+lPgw5TV7iKptWO5IrQS3U16l26rv4YN8yhEfPzEGW2YVzrzVwdFPgcTBe4XefoVKkKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahHS9jmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9E0C4CED0;
	Tue, 26 Nov 2024 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732627345;
	bh=RzAX0nZKTrlawErV82aO5uN+J0u44XEx+6Xw+tktJ1k=;
	h=From:To:Cc:Subject:Date:From;
	b=ahHS9jmnH1A4j+x4GPHupX7yE+t+oFAu0ynSPNXVLXC2VC3N1uyrrMZB5aQ+AGjCB
	 /oze64U31/jBXdES5S7lVyytWti0Q4i1RVSoQuH5EboHcENe90H/9GnC4Qgx0JJdb1
	 h8l+SIaQoWn0hZXo0s1EjoO3FCgOwz5g2swrY3NnnaB288XGaWSmLppwgGlT85KMDN
	 H8V5NL0fIWCxfEJYRKBaIsO4SuvC6csA90o9MEsdKcK3cBXqtME8GQTksziGHyYn/O
	 BrKvsNIMzm1sQPAMJqnDPTvuoo8/zv9B9IvAKPTF67Z1FHPJCqbWU5cvfKnLmnQJSv
	 TH8z63g0JBqwQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] cred: fold get_new_cred_many() into get_cred_many()
Date: Tue, 26 Nov 2024 14:22:16 +0100
Message-ID: <20241126-zaunpfahl-wovon-c3979b990a63@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1375; i=brauner@kernel.org; h=from:subject:message-id; bh=RzAX0nZKTrlawErV82aO5uN+J0u44XEx+6Xw+tktJ1k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7nu7sNEn8b3oqcCVTt99j93ivHbt0VxZde2lR+ND86 m0efvZZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMx3MHIsMj+Avd0TwfehQxf mxqcjx6LNHdccf79E7Fbjx+UsBXue8jI0KopH+7zy8dxk+6J+vtvYta+9J+mPPNIziuR1afF5v5 pYQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

There's no need for this to be a separate helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Putting this on top of kernel.cred. 
---
 include/linux/cred.h | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 360f5fd3854b..0c3c4b16b469 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -186,20 +186,6 @@ static inline const struct cred *revert_creds(const struct cred *revert_cred)
 	return override_cred;
 }
 
-/**
- * get_new_cred_many - Get references on a new set of credentials
- * @cred: The new credentials to reference
- * @nr: Number of references to acquire
- *
- * Get references on the specified set of new credentials.  The caller must
- * release all acquired references.
- */
-static inline struct cred *get_new_cred_many(struct cred *cred, int nr)
-{
-	atomic_long_add(nr, &cred->usage);
-	return cred;
-}
-
 /**
  * get_cred_many - Get references on a set of credentials
  * @cred: The credentials to reference
@@ -220,7 +206,8 @@ static inline const struct cred *get_cred_many(const struct cred *cred, int nr)
 	if (!cred)
 		return cred;
 	nonconst_cred->non_rcu = 0;
-	return get_new_cred_many(nonconst_cred, nr);
+	atomic_long_add(nr, &nonconst_cred->usage);
+	return cred;
 }
 
 /*
-- 
2.45.2


