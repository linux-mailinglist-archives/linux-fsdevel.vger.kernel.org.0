Return-Path: <linux-fsdevel+bounces-35694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091169D72E7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC3D286445
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FF720C492;
	Sun, 24 Nov 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pggTkNIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0720C482;
	Sun, 24 Nov 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455895; cv=none; b=IqM2oIdDHxVUoRZaAxdu6AaG99ALRJIUcsOD4t4X8D10gujF2aXoQEfV4tOmFA/qomts53i+7nCbGc2mw5eLK/2S4/9CAAG6F1uQMUvR9WyuHCAz/gfHsh/iJTWohrO8graeUnjWPKQ6TygB1zTqXh/oPszSbbjZreVc6kyFYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455895; c=relaxed/simple;
	bh=q23Mrxa8m3O45VqVv+7XtSnKSkr//0A5jKfdwR6XXQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AM7sbbDEODualNP9WlzUqtxjIJeINTiu6NDtRtyH/IArGCGI2tw30Mt9syFK/AVvkcSPddoi5Lj2UQoMN794p5Wl4rt8Yj9KjW6h0j7ThMw42ONZeU/UDFMH8+dNIfPgqEBj+eux0qGPNBKV1xgLPxSWLMTgB/qCGirpC0b8XO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pggTkNIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8CBC4CED1;
	Sun, 24 Nov 2024 13:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455895;
	bh=q23Mrxa8m3O45VqVv+7XtSnKSkr//0A5jKfdwR6XXQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pggTkNIgRmmG2siJUXe+qD0PphLSMN/h7alejbf7XSCY5OV0qpQRbRogEDlTiUpc5
	 BfXb/6BD1LNX5zGy1bCjeuwP43azKn1dXxIXD1M74OjbGMfufzO95ercXVRApd9oJR
	 YFcDOJtb7IAaZrj5lM0KVtOEXV/BLibIeJKRY6P+LPqC6C6LEWZbg6C9GvktdHluIN
	 /wIf7w3ejo0ECamFFAahVAWIIDATPxMo+ros16sB8EWSWpd6VzPKh01Fsgfw/kJfgt
	 f/jq+4x0BjZylyWFwjVsJ6WMjgGfDkHuOe+jRMeYvDsXcOyXcRCtO+uqyMtdJQ9gGw
	 zd31N8itcvlgg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/26] cifs: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:05 +0100
Message-ID: <20241124-work-cred-v1-19-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=brauner@kernel.org; h=from:subject:message-id; bh=q23Mrxa8m3O45VqVv+7XtSnKSkr//0A5jKfdwR6XXQI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76y7wNW3L546rf3Dja/ZMZ/W4RI5T7NLCGn1GzwX3/ DJ+f0+no5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ2mxgZjn4znVFt+fCa4uVv y3c+qeSe6PxYW/iXWYsWX+6++kXnJzIybFR6lXu0Ju75Y6s97efVj01U2S/K3FTdKNG80IlvSes dBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/client/cifs_spnego.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index 6284d924fdb1e25e07af7e10b6286df97c0942dd..28f568b5fc2771b7a11d0e83d0ac1cb9baf20636 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -173,9 +173,9 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	}
 
 	cifs_dbg(FYI, "key description = %s\n", description);
-	saved_cred = override_creds(get_new_cred(spnego_cred));
+	saved_cred = override_creds(spnego_cred);
 	spnego_key = request_key(&cifs_spnego_key_type, description, "");
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 
 #ifdef CONFIG_CIFS_DEBUG2
 	if (cifsFYI && !IS_ERR(spnego_key)) {

-- 
2.45.2


