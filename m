Return-Path: <linux-fsdevel+bounces-68218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9FFC578F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC9D3AEBFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3788B35295E;
	Thu, 13 Nov 2025 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An/U45Fy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF04352958;
	Thu, 13 Nov 2025 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038953; cv=none; b=tjfp/geI4/OGIGS13WPUqnCzW5tUtRDnFPLlArqSOKGdNiEe1YDMQITNGKkmjCefxMeCUaPkKFXPhhQG0fFSAl7tMAwe2ET798dvuW0xan4vkZu/9M0Q03unymRmHlaz0zGZX7BcbkDlr7/a+bSyg9/sh1bLFEZgrTtcxr0E8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038953; c=relaxed/simple;
	bh=zSASKcddf9CQaFnn2hf/tv6j/LhojRKTPaPL/pRNonA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iYf3znZuZ5z3KbTjZrUvDQcAc6yWxUiZHcb6vbudluM6P4JuUXjp4nxBG5KjKXh6p8M/srdYd9v6TWLaTZazokubl40ntzaJs//9x8ditr36yDonvy65rDHw9hroOrzb9g3mRB0OKRwW3FKQalu0PMYWDlgBKrZzun29syOuMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An/U45Fy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0E2C4CEF1;
	Thu, 13 Nov 2025 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038952;
	bh=zSASKcddf9CQaFnn2hf/tv6j/LhojRKTPaPL/pRNonA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=An/U45FyUAkVcMU/6yPzR18ZoLerJ9MtxHRUrMPA2WjBmqHHf8NszDdhLAJ/NFlti
	 dEkLdXc9r7KiLlr8w7C/+H+ohtSyKFH3eaTytd7DXdnc48J8mksNcQiJUyghrzi+qY
	 AHqsw6esWV8xlkr90Fr3b8wECsRoHLta6VyFVE6+S7DEH6a4cx6Ep7HY0XoWdGDs5P
	 hxT+UnzUiQMvq90sWRdAf5PsxD5DsIgev/MozJxrPRZRNwQFou1PfyDx1VLkrYzQeQ
	 0IBNGTcukC86pzwpgGjgPkplqGXUtrUov1PMsUeNlN4vYJbN7GSlQY2ZN9OBKf3A5A
	 7R/zX9cywaeFw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:21 +0100
Subject: [PATCH RFC 01/42] ovl: add override_creds cleanup guard extension
 for overlayfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-1-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zSASKcddf9CQaFnn2hf/tv6j/LhojRKTPaPL/pRNonA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnu0j31P4Su/5zMPvygLLL95+kit0zwv49NsXewrH
 F2mLO2Y0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRLe6MDCu4fkcc/LF5neOn
 9j6Hu39Ep+5Z6zHNMzfj8bpT23jsRIMY/gcovErK6Dz7eWv/qvTlPFoitgYOwaEikQxH4+bd1g5
 UZwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Overlayfs plucks the relevant creds from the superblock. Extend the
override_creds cleanup class I added to override_creds_ovl which uses
the ovl_override_creds() function as initialization helper. Add
with_ovl_creds() based on this new class.

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


