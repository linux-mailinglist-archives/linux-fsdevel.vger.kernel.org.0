Return-Path: <linux-fsdevel+bounces-35695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F459D72EB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8235C165114
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102220CCC3;
	Sun, 24 Nov 2024 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7n8WfcE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCEF20CCD3;
	Sun, 24 Nov 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455898; cv=none; b=NeaUNTr6DLav9TSfZWhsDvE+nyUoU4v88KHWCYahSJTgk24PckCeB6Z0EpTUmdIw3YphnGVujC+ioAQ9Y9jKZuIvyIqQ2aD6pMLYNPkFIfSfD1M4jYJ7hlJoErRy8pyJBkDS4fn8cxb1G4Lzwitxw4R6r2m92+MRg4YuUvPqC+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455898; c=relaxed/simple;
	bh=5+SMh6j/iqEcYwZZXZLq5UqmpwtfuZKJ9FPoeFDoAT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQEkr62074sQ7i7Fr8Wku4RDYqVB4jz89GoRdvCTWFHc/O2EGRae8rlXoHyVNzR6E8Ebk27RImf2P5ePXKLIapLtYSsABtOv6x13tbxD2LnEqJc3Ac57yzt5sy/ujBzbsT93FQU3xQWypnCoLXp7OjPB3h+AMRKpKUHFDNmznLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7n8WfcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5D7C4CED3;
	Sun, 24 Nov 2024 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455897;
	bh=5+SMh6j/iqEcYwZZXZLq5UqmpwtfuZKJ9FPoeFDoAT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t7n8WfcEVsSUbyrlwM4NYZORIuUjkGwc0ZnYmIUiHWsnziAYlo35J0eVcWMgK+Fss
	 0qEenrhkbZSFxK9czauGfdsd9z47MPtHkOk3EMfhZtpA/9Xi2vpUbErNNU7PQgm2e8
	 Q16ddLemVGUXfNDpoilvm3CLho05RsAd1eofyLZKw7KmxNaecliqwn4QvcXydErGMc
	 aobq9qKT1FfMz4hecUWIKN+dmNT0ruH1DWyRBjUg8wyu02IWboh3TLOJrsGQFgA/jR
	 /+QgKW5vixym3F59JCsC3PUjssYmE3MNqUzMHyJonoEi/K7ZHLXFzBkPTbWy2Px3tG
	 9zH+uVfJ5N7KQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 20/26] cifs: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:06 +0100
Message-ID: <20241124-work-cred-v1-20-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=brauner@kernel.org; h=from:subject:message-id; bh=5+SMh6j/iqEcYwZZXZLq5UqmpwtfuZKJ9FPoeFDoAT0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76y44+7Dkj6a9QKSFSqt049LYzaIixzmKNktc70pRm LF6F0NQRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQEUhkZFtddZVgjaN3CpqHY 9mix8cbLzvlTFlrLzFE0qV50y1yzmeF/9MT9TgsSs4/0qZ9f9CSary+v2fhk1OMLIcx8B2PvWr7 kAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/client/cifsacl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 5718906369a96fc80bee6a472f93bac1159f1709..ba79aa2107cc9f5b5fa628e9b9998d04e78c8bc1 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -292,7 +292,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 		return -EINVAL;
 
 	rc = 0;
-	saved_cred = override_creds(get_new_cred(root_cred));
+	saved_cred = override_creds(root_cred);
 	sidkey = request_key(&cifs_idmap_key_type, desc, "");
 	if (IS_ERR(sidkey)) {
 		rc = -EINVAL;
@@ -327,7 +327,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 out_key_put:
 	key_put(sidkey);
 out_revert_creds:
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 	return rc;
 
 invalidate_key:
@@ -398,7 +398,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 	if (!sidstr)
 		return -ENOMEM;
 
-	saved_cred = override_creds(get_new_cred(root_cred));
+	saved_cred = override_creds(root_cred);
 	sidkey = request_key(&cifs_idmap_key_type, sidstr, "");
 	if (IS_ERR(sidkey)) {
 		cifs_dbg(FYI, "%s: Can't map SID %s to a %cid\n",
@@ -438,7 +438,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 out_key_put:
 	key_put(sidkey);
 out_revert_creds:
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 	kfree(sidstr);
 
 	/*

-- 
2.45.2


