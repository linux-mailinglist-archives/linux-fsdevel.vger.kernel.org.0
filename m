Return-Path: <linux-fsdevel+bounces-68357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C63C5A28A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EE3D4E8965
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825132549A;
	Thu, 13 Nov 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKCK+qkH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC02F5A05;
	Thu, 13 Nov 2025 21:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069532; cv=none; b=DkAWYB+w5i49dMor+fUXVXA8qsP6N8NgPWc8kojNyIFfWKnTA+lCexGunAdHs26fojF6CJWLnS5z4mKGvbB8dWDQFM0h0ug949stbmG+5c7wVnvAYbBfpVu4LuJpNMXgdfTAEhqTuj6bKIM1dAU6pVmi1Q1Gpg9p+M0lGUgLVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069532; c=relaxed/simple;
	bh=2/saGFL7ouvzhnEvfVfzfuyasNQcj/fIc1HirgLoK8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ic4bJsgPXm0T4tq4Cm5o/Qi/OTfUmOe+lmvTeHCQf3y7mzB7qcpP5Rj68k6zczRvvyvpTSvwDn1cAyT2U9tCQtJv3waweiEE1Bud5x4MzlGsnyeHOKoS37vxIJLL9iHUMTVRRZA+MQ2tWOsUdYLUrwV1NIwSETFKgb3rvSR4SjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKCK+qkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C30C4CEF7;
	Thu, 13 Nov 2025 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069531;
	bh=2/saGFL7ouvzhnEvfVfzfuyasNQcj/fIc1HirgLoK8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FKCK+qkH1/i6nLLMwx/pTGx4bPaKhmJBzyUoGlL4S4mPbCaIm9ze0Qm6C+WDwAtPU
	 4WIvcpBjFW37HqXwu4MugBT0jx/mf6j7nWYWDu/suIdxDrxr5p2SaFgvr+DXhVCTpa
	 hVW40w97tOhxUcZ2rkdc7ohxHw1/giM+02jEYbFUH5M2BsLJ8WeRUGGYBJcvnd+DLa
	 W7C4kZe1+M5P/KhY/WHIVPGHmVG/yHQ3I8zFm0+MjX6rC2039NpIObTG5x4EM6MXX4
	 tQlBeGMfDb3qvJqf8Ys0GWwrzKy6os1DjqhhqYeiWfAiph4Kl00Bu4PCwDJv948Uk4
	 +Xl2KzlM47u3w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:44 +0100
Subject: [PATCH v3 01/42] ovl: add override_creds cleanup guard extension
 for overlayfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-1-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2/saGFL7ouvzhnEvfVfzfuyasNQcj/fIc1HirgLoK8g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVtq9FxLvrOZFTl8FUuc9+Uzqwwya7HdgtE7u9RK
 vb6v6mho5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJXPRgZLqx14DELWLX5zIGf
 hX94eRbtly499Uc185hHUufEB8l31jD8FVe0+ZxmfeQLy7aOIxKp9tl+a1RsFE71zG6vi65ja8p
 lAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Overlayfs plucks the relevant creds from the superblock. Extend the
override_creds cleanup class I added to override_creds_ovl which uses
the ovl_override_creds() function as initialization helper. Add
with_ovl_creds() based on this new class.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/overlayfs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c8fd5951fc5e..eeace590ba57 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -439,6 +439,11 @@ struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
 void ovl_revert_creds(const struct cred *old_cred);
 
+EXTEND_CLASS(override_creds, _ovl, ovl_override_creds(sb), struct super_block *sb)
+
+#define with_ovl_creds(sb) \
+	scoped_class(override_creds_ovl, __UNIQUE_ID(label), sb)
+
 static inline const struct cred *ovl_creds(struct super_block *sb)
 {
 	return OVL_FS(sb)->creator_cred;

-- 
2.47.3


