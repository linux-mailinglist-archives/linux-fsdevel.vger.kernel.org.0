Return-Path: <linux-fsdevel+bounces-68241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EB0C5795C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A893AAABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7439435471B;
	Thu, 13 Nov 2025 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUYwtred"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A9352947;
	Thu, 13 Nov 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038995; cv=none; b=tCle5LkeYMXnxg6eCyX/KC+aLbHneCU2y3gcL1bmyk2a0Lz+QjsersTl8/4mxVTBPmTtuV1Hmibjv/wGY0waxgSIUbK29EWbdiSzSnrwcclSRfXMwfdQXKilXZm+KpOlWWH9t3e3gPYoHezZXd5nzi8P6Qmr3Vs6PiHTTittUNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038995; c=relaxed/simple;
	bh=6qblfJeOiq/jvzJHNKwafEyuEcKGC5jZvfO8El4E4l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ia9CyOF5kLlXqqSJ8xfPmtDMW2ZCJEbNu1DyPvo/TG625m9vNFygpHrCNuTWI3oEWREHUIBAPs7bEJJY9AkB3F8EiRDcVIUkdalclUIJwi+C7k6wPsxZhZ0pCnmUcKLl3wcYSyLyR3gHV60R1HdwASWVFu0ppuz9w7CDRRws2vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUYwtred; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01751C116D0;
	Thu, 13 Nov 2025 13:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038994;
	bh=6qblfJeOiq/jvzJHNKwafEyuEcKGC5jZvfO8El4E4l0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JUYwtredoKLy+xBbpnjdemgnaHlmrbHQNNvcGckhCtE6K+OLxRiyz0B0kv+MVj2ca
	 8kKc1I07eu6vAUPatIK0Hno5pud3rUr7PTiyJwMtBO7zlYJ4MXx8lZT/bLKKjj4QJU
	 XNnvheRcAfGbgS1SRiLWJcXEeCX3ezpQ7IyCJAFVwOvt7QUQpaHLUo+nUFwBU7ZjS1
	 yzrlF44x/09ur7t00MHcwExdm9FoMVKikk4ACltgr5NO7OxpbMRJ5R8n7f0IsUkpVo
	 2jnrmbdywfkALewv+NiVCZ/SdCKBlXVdKFhYyIb/s5DK9S93gAAjzROTw49tnxDtYy
	 zILTLI/q1zH4g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:44 +0100
Subject: [PATCH RFC 24/42] ovl: port ovl_maybe_lookup_lowerdata() to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-24-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1069; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6qblfJeOiq/jvzJHNKwafEyuEcKGC5jZvfO8El4E4l0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnu8wiygYJZqUAnXXXnPx6L1XfevPTgWsryc8c/j6
 Kh7t3lTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSVsPIsENU8ouIpY/nUoUj
 55nWObi875NKSwuaKFe6Xirt+aGkCkaGc2/vTA69+HL+HwWJd32L5jSKHJ/ospX92b4z07b1LTe
 9ywEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index dbacf02423cb..49874525cf52 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -996,7 +996,6 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	const char *redirect = ovl_lowerdata_redirect(inode);
 	struct ovl_path datapath = {};
-	const struct cred *old_cred;
 	int err;
 
 	if (!redirect || ovl_dentry_lowerdata(dentry))
@@ -1014,9 +1013,8 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(dentry->d_sb)
+		err = ovl_lookup_data_layers(dentry, redirect, &datapath);
 	if (err)
 		goto out_err;
 

-- 
2.47.3


