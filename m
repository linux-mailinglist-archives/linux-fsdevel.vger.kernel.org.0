Return-Path: <linux-fsdevel+bounces-68686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB032C63505
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 773BC4ED503
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DB332E732;
	Mon, 17 Nov 2025 09:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx0pwLsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6310328262;
	Mon, 17 Nov 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372103; cv=none; b=S3Aat5vIaUPqDuK/NhqSH4UkLwbHAeS6WtZJbT9+Cdbb8nYgDzmdwN557Jxl5/7Leg8qcjP3VMp546cBQPvlfBRJ/vxJoVIaA2iF+TvNHWZjWl8b7Wg1u31qdGg5GcgjW7qU3LdGd5uOVl7KB2PhjOMn2xHja0vA/3MR+tn/k6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372103; c=relaxed/simple;
	bh=3W2xaox7ZQmSA3WTzNdCIyUnMAmppZGRFqZBNRORYSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dIDlgYqZNAHzAImebvTtn8myi30tT9SbVm+PyZ/q9jipSlPlKcW/8vb7bxxwsYw/QBNHeqWQcWVN5zL3LYS+ak+85PUoJAdYfiZLpi5vn0xJ12O2MDZlIvX8UbalvE7LZmrCboxF5XCLKYxYUE7yzf1q+fuOLM3P4J+wCa/EwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx0pwLsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6DFC4CEFB;
	Mon, 17 Nov 2025 09:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372103;
	bh=3W2xaox7ZQmSA3WTzNdCIyUnMAmppZGRFqZBNRORYSM=;
	h=From:Subject:Date:To:Cc:From;
	b=rx0pwLsM1bkxx1oiaSFrLUtzAcx8GDBkpEyzpeDKRNnh8bJa3SWDnU1+ejpI2Zxma
	 6JBQAN2JK/GanwywUNRTsSmej28tSK+BzMEtMAO9PEmRkMUrK+vWbxLOt4w2k+3TFP
	 2zhFcWNwoqu+vJWsESYQYpBbeKfCIX8S2XQGAO2Us2y+Es/BORCWUN5MjzbmTgnXM+
	 BAEGkvqOGFRha4ZHhQknqCFj4xti3VNLLW+o5cmsIiY/S6D5LwIf+TbTVGCh4zwhXm
	 vjGCw7Zbx3FaUyESBLMx+D7ZiWPcdFbTdusB0zo05af1U2dd+snje9JdIbTSx+vbiv
	 CLxcM7quMHAbQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/6] ovl: convert creation credential override to cred
 guard
Date: Mon, 17 Nov 2025 10:34:37 +0100
Message-Id: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC3sGmkC/43OQQ6DIBCF4asY1h0CqKnpqvdoXCAMSjTSDC1tY
 7x7wfQAXf5v8eVtLCJ5jOxSbYww+ejDmkOdKmYmvY4I3uZmSqhWStnAK9AMIS1gCC2MT00W7oR
 3TQhtraTAMzbSdSwLeXf+fei3PvegI8JAejVTMUvy4vHs8eLxw+M/rxCTj49An+NfkgX670qSI
 KBxRirRaadre52RVlx4oJH1+75/AZ5f3pb6AAAA
X-Change-ID: 20251114-work-ovl-cred-guard-prepare-53210e7e41f8
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3W2xaox7ZQmSA3WTzNdCIyUnMAmppZGRFqZBNRORYSM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvXF92LLdh9Wk4vnXH7Uz7PoniD8UaGu9X50td7jj9
 56QbJ3OjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl45zAyPFzCur9b58mPuZM3
 2xtqXDvCHMQasMe3Mvq5+W8xY+dSfYY/fBnG6t8/N1XrNc7VeVCq5/ZK9oPu7+m/3KKZN6sdFK3
 kAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

This is on top of the overlayfs cleanup guard work I already sent out.
This cleans up the creation specific credential override.

The current code to override credentials for creation operations is
pretty difficult to understand as we override the credentials twice:

(1) override with the mounter's credentials
(2) copy the mounts credentials and override the fs{g,u}id with the inode {u,g}id

And then we elide the revert_creds() because it would be an idempotent
revert. That elision doesn't buy us anything anymore though because it's
all reference count less anyway.

The fact that this is done in a function and that the revert is
happening in the original override makes this a lot to grasp.

By introducing a cleanup guard for the creation case we can make this a
lot easier to understand and extremely visually prevalent:

with_ovl_creds(dentry->d_sb) {
	scoped_class(prepare_creds_ovl, cred, dentry, inode, mode) {
		if (IS_ERR(cred))
			return PTR_ERR(cred);

		ovl_path_upper(dentry->d_parent, &realparentpath);

		/* more stuff you want to do */
}

I think this is a big improvement over what we have now.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Rename the creation credential guard to avoid theoretical confusion
  with the removal of the ovl_revert_creds() function.
- Link to v1: https://patch.msgid.link/20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org

---
Christian Brauner (6):
      ovl: add ovl_override_creator_creds cred guard
      ovl: port ovl_create_tmpfile() to new ovl_override_creator_creds cleanup guard
      ovl: reflow ovl_create_or_link()
      ovl: mark ovl_setup_cred_for_create() as unused temporarily
      ovl: port ovl_create_or_link() to new ovl_override_creator_creds cleanup guard
      ovl: drop ovl_setup_cred_for_create()

 fs/overlayfs/dir.c | 147 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 78 insertions(+), 69 deletions(-)
---
base-commit: fc64e774b2606549fe236fbf93fa6287c93dbdaa
change-id: 20251114-work-ovl-cred-guard-prepare-53210e7e41f8


