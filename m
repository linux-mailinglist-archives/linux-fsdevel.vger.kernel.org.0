Return-Path: <linux-fsdevel+bounces-68297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12EFC58DDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591B13BD7E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BBF35A127;
	Thu, 13 Nov 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhzDwm6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4374735A124;
	Thu, 13 Nov 2025 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051857; cv=none; b=m5XcIhjdD/jzX8xcdSerB6OtnZ7o5Y06R3JKIGMEPJLT6rq7qRaNASO2cmEeoeE4/V+A1d/+B3LnzrGwmmV5xFsjUAIlHp8UQp+cpoTt1M1dX+4dnHAe+Gsp5kBHFiQBwAKY+ksfQdWhJNhu/yuAJ+8CfQQIz126g+NrOVYKGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051857; c=relaxed/simple;
	bh=2b3rAoY/Uqkq2cYdzGQYI68zZPND/jhfiJgWPBtUR/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJq8OBwFnfEI8h4t5WbWgp9sJzxuDlGPUgUNwhXMftZKWWH6ZUtQoWRizTQ48bgrpDzSRgCpd+NsP8v3AWLnNHSgnJgMXXG8P7BoMEnUhv1WiaqVv4S7QmC81xnx9A7n+z/yqSz3o840h3d4aefTOa1d2MUYsWG6qOlXlHbQcD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhzDwm6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D80C4CEF1;
	Thu, 13 Nov 2025 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051857;
	bh=2b3rAoY/Uqkq2cYdzGQYI68zZPND/jhfiJgWPBtUR/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BhzDwm6ihaVxoGZxj27eAxmGm7rr3m0sHEtxOxC78A5UZjIvJ4qKaR2wX9SaligzW
	 ehneCiROR6L6ZNoHwD3HTD64k6gfUGXFNUX0ZE5QEHGBHYs4Lytgf/LyejJDueUIL6
	 paBCOJtcpRy53BPF3Z4RY16quUKvNPT+3og3teWtU7hWYEiqRWXfErGeXdDC/RpfpD
	 OB+3bWVgRj65HY6jMvGmP2SawDXnR7nWlgugGlmXNW+0xQXhTSw6BJgap2kHy0hto4
	 lBvKB+RcccgUjeoPpNgkUSEF+LsGXhUKhyfMGsfkTyB7bjkHqqkqS1aHTnA6wiygVd
	 tqzQfbkdBKpKw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:09 +0100
Subject: [PATCH v2 04/42] ovl: port ovl_set_link_redirect() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-4-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=832; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2b3rAoY/Uqkq2cYdzGQYI68zZPND/jhfiJgWPBtUR/o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbruDdAWF7KYezZ6NmeGw7bnmwxWzPth/Ka30nHSA
 9dThavudpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk/1RGhr0mbi7lDrrL+lay
 Xt3jLrPlzV6VCbGvVtk0LZ83v0FnBxMjw6yjj/3+yeU7HbQ78kOlYcLFX4/MHTrrujY83BGfNuO
 yADMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 93b81d4b6fb1..63f2b3d07f54 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -726,14 +726,8 @@ static int ovl_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 static int ovl_set_link_redirect(struct dentry *dentry)
 {
-	const struct cred *old_cred;
-	int err;
-
-	old_cred = ovl_override_creds(dentry->d_sb);
-	err = ovl_set_redirect(dentry, false);
-	ovl_revert_creds(old_cred);
-
-	return err;
+	with_ovl_creds(dentry->d_sb)
+		return ovl_set_redirect(dentry, false);
 }
 
 static int ovl_link(struct dentry *old, struct inode *newdir,

-- 
2.47.3


