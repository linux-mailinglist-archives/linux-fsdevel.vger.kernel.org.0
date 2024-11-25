Return-Path: <linux-fsdevel+bounces-35817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF3A9D8790
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57E328814B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBB21CEAC3;
	Mon, 25 Nov 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNxYxKuL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2B1CDFCC;
	Mon, 25 Nov 2024 14:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543867; cv=none; b=CdoCMRHfU/Slv/cIfT0ZTBY4JFwr+Ijvx4ScqbbuWpckLoHsA4LKbgVUOzKS4XJR+OOfhB2nnOlbt42zKAYZTtuWKRQI5HMYlKyw6Zlmn7ihn4pr71CLrZk5qVbpTTVqRCviHTc6VRT5KfCq/jyl2Fwri+I4vcFg0XvPVoXaz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543867; c=relaxed/simple;
	bh=5c05Vem2w/kHFkWDmORyO4wP3SkXwO6vKNBNGdV0nuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTnH62eo6Pm1rRCykGMrEcpMqQNc0H5pIGGe+TAeLT8+FZza+PRLnygK8n8w5+FQRxRXRuTSLyYzHZYRym9BFIkH+OszHVrM2vj+sy2uHMp8pYTKsFYN5zExFwL5bXPCsVv03A8/LaQf6nOC1TFjLxerhJNLunsO+RkfOv4raRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNxYxKuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2947FC4CED3;
	Mon, 25 Nov 2024 14:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543867;
	bh=5c05Vem2w/kHFkWDmORyO4wP3SkXwO6vKNBNGdV0nuA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GNxYxKuL7ibSdoay8KjP+oZETaHOr1lxKW+Q1t+BoNvQdRD2ZNazV4PQ+iNqLqpxY
	 /HlOWvZYrw4O61IH6I0n2u2eRIjo4HTTsV8nPrTw9runpNj/3W0bBeRqjSQ/kyFanc
	 +/NowrXwBSr2Lg1kaMHYQjOmCwYDhlfIfhywI8yXdz0x1Smou4QbL5p6TmjqeEo9vc
	 XW94KRZmS5NAvp77RnvW3kRkMjxLKXOKKJL7NBG7+YZiJAIF8TTdLjA2jhWdGzXOC+
	 gL37bKUXe/QZ6xOtjrMtcSqWW9yOIwIX33JxRS+LJziV//uxoOZ4sELE8b//+iOPTP
	 DZSTDDQcalETA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:16 +0100
Subject: [PATCH v2 20/29] cifs: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-20-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5c05Vem2w/kHFkWDmORyO4wP3SkXwO6vKNBNGdV0nuA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHoFfcmXf3+ON/5dvOn7zGtv0//NvFHNeC+msM234
 tTBCxrrOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbizM3IsLbquJFN1+oEm+Xf
 dKuFNz1cd+LIaY8TzY8rvWpSNH58bWf4zWZjIrpi07NL80JVDrJVfJ/1zO6x5cMFx1a/3nGueFr
 JBlYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

During module init root_cred will be allocated with its own reference
which is only destroyed during module exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/client/cifsacl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 4cb3547f4934143c69a4dac3b9f957d75ae20e0b..1d294d53f662479c0323d5f5a645478c6f590062 100644
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


