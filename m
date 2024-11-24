Return-Path: <linux-fsdevel+bounces-35693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9A19D765C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EDFBC62DB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3320C00D;
	Sun, 24 Nov 2024 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkHhzrKU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9346520C037;
	Sun, 24 Nov 2024 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455893; cv=none; b=JsSf4a3gPiIn8ASgKV5KyV5Q9UK7XTNZxWr5obw3YNNrn+WoY0mVvpaQKqLnq9kwCGbMvpTMOl0iKGt1/YZdZYbBMX4R6H6MXinsAB+Jwagkt2vH66VgTNvET18D1JEMXz1I49kvtrTLSa2R8z7Z1FHevhdFdSGIAl/21JrsSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455893; c=relaxed/simple;
	bh=s1Ei5CtoYtfc2mSSk/8oqFVlzTKUdNU5RjswLDXHRtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No7nxydZ8mMtvxhMQFMRy7OQUV7eQ/z/zypzm/oxn4/Ql9uBeGHAaVcZiBK3P1nzpPn1JdMw6UHP4JVMTEeVMkmWPvLrGJNZMdK3EoVv4XQRoAtgqlLIFI9+W+iag/jjlQCECd5prbl9day/2/oKJkpoCUiSR1IDqFLMa1s0WII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkHhzrKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B40C4CED1;
	Sun, 24 Nov 2024 13:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455893;
	bh=s1Ei5CtoYtfc2mSSk/8oqFVlzTKUdNU5RjswLDXHRtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkHhzrKUWYq14MedTZ0n7UJz4nVWhzqwnZQklrhRA786NEaDv9eI+ykKGfzaH7cN7
	 Wc2cZ5VaU1R64rLuuRwRngYHTHIYJr43k7C8/IjqwyEh+0Ncs+KCqmmebHfpZzXPkk
	 KazyV4gBAAQQau9tCx9TW/5iwdOU+Fa6tZa5e/hovenvKL8gqtjolrFsjIBXtiSfar
	 GOmvMD4TnU3qlYD07KWiZX3prhiyugzQR88pAsBVdr/y/eXgRdRQX40vzowY/UdRxy
	 tn1slnidBKZwce5WQM1WcYWud9zeYG02oYTzVypUkPirLcOHFeFEaS5vURKSTaRhUM
	 TES1MEz4a0g2A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/26] ovl: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:04 +0100
Message-ID: <20241124-work-cred-v1-18-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=brauner@kernel.org; h=from:subject:message-id; bh=s1Ei5CtoYtfc2mSSk/8oqFVlzTKUdNU5RjswLDXHRtM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7685/t6Z98vydF9Zdn6lyMWNK+Iwbx390VORkB22r7 Jd5Oi+6v6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiC1kZ/hl6Rfc2GK3dV/F8 +YVna/5cMrn30tVVifXyCgczOa3T79Yw/LOxC9lzp007ZNnvvX6yUsxf0rZ2nWyN73niF/p/9jo JXk4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 439bd9a5ceecc4d2f4dc5dfda7cea14c3d9411ba..39f08531abc7e99c32e709a46988939f072a9abe 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -741,17 +741,15 @@ static int ovl_prep_cu_creds(struct dentry *dentry, struct ovl_cu_creds *cc)
 		return err;
 
 	if (cc->new)
-		cc->old = override_creds(get_new_cred(cc->new));
+		cc->old = override_creds(cc->new);
 
 	return 0;
 }
 
 static void ovl_revert_cu_creds(struct ovl_cu_creds *cc)
 {
-	if (cc->new) {
+	if (cc->new)
 		put_cred(revert_creds(cc->old));
-		put_cred(cc->new);
-	}
 }
 
 /*

-- 
2.45.2


