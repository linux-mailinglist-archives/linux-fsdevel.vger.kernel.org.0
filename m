Return-Path: <linux-fsdevel+bounces-68645-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5CC63421
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B81E35EF14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66214327783;
	Mon, 17 Nov 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUlvBCT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2932142E;
	Mon, 17 Nov 2025 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372029; cv=none; b=Q+Nh+z2d6ytvpLV+Vd74uroZ4LERxkC0JRrv0uXLUaA7g/Oby1ZLZQ4QMhOOpGt/JtmkpICDvQyMG1wnYpBGAuDYJm43IyONNfxMqxvpJg13oT83yRw/WQhfXgpPsxakyPxI3+4TxOrSRHW0x7KerL7O3M5UqM0ZK6a1qHOJrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372029; c=relaxed/simple;
	bh=2/saGFL7ouvzhnEvfVfzfuyasNQcj/fIc1HirgLoK8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLZE/SNx3q/YlrQETaN0G4hxdpJ8wP4ZAQQKv+FfJ+d89iSFmonMfT1iczOjtYsRWbcdMhZcBfx2vIX6HHbf04xer1fzFtxlAcNFUJP1+ebHVd+uBRW+8TqBhQx8MBchTUNnVP1ZCO8pq028ol6Gjip2VG1EJbDcAKw63k577Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUlvBCT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43641C19422;
	Mon, 17 Nov 2025 09:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372026;
	bh=2/saGFL7ouvzhnEvfVfzfuyasNQcj/fIc1HirgLoK8g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CUlvBCT9ERrdswS3KGwvZcTPUCi+ZSFhiySMBvhXpMHCQ6DUq5AEdG1h71iK6i/Ul
	 zDg7BRtSASoD/o1QecwBThMRsHzmU5BDc9kxcC3sseEgL2QkMCQuRsbtZ2ST+T82SN
	 kcQSfjCTRViuODn+GNc3JMSj2krlqyFTFgEr30OZGWqymHIzXqecIbVd6jaaTcyiQb
	 YULFn5rJtl3nF8Yb9rrPPvxcEbZjcifNyUwKNa5I5F/Vp41gVxuHh/PCeDdbB2YYFS
	 iQcYzZrnzgfC118PN+nCh08hMdl16nPUL2MyPgCOYMagpzT5w0GNj2zhfv55CqNZsc
	 bTGGVq0pBB6dw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:32 +0100
Subject: [PATCH v4 01/42] ovl: add override_creds cleanup guard extension
 for overlayfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-1-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2/saGFL7ouvzhnEvfVfzfuyasNQcj/fIc1HirgLoK8g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf5S9s+j0CXp5OY9aV0Kh47pZJqpHZBPnWXkL8KV6
 lzl7GrdUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGDmYwMa2fvmG7rYJ69vbJK
 13bFruxrO+s174r+lPkkzNCwJW59DsP/igX74/L9z4h29SrV2U2dFu1v/XlG6OETW5bo/3SNr93
 NBwA=
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


