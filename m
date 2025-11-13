Return-Path: <linux-fsdevel+bounces-68247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9998C57968
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5201E3B97DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BED350A18;
	Thu, 13 Nov 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFuaT7DU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB535293B;
	Thu, 13 Nov 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039005; cv=none; b=jzMxPdvZEX4TFJnDTNzx/e6tYTQYZp00iuGnUofdt1krmj0eiuMuBGP3S8UKBAzCg5UdoRLHQB2/guFGwfYFry80Y+OVonn5VgK7VmzbxGePazEaXuk6UTBhA20iIuYvqvaD7gPK9dibsX/XfWjddbUdb2tOx2UYyvxqKB0bl2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039005; c=relaxed/simple;
	bh=ocHWTlOICTb8Z8Ub+gbv30rvYo205HCmin2dzeq1a7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISZ7mn/I4rJWmFCXxslPUq9ehIX+dkrTFBbPe7ce+U9X6/yQvjzlhsV1oIGShJcyrtXDCgfg6i0EEe7fU6f+5YJkcWuGQ50EXiZ8PeSJU9aIs+muqZevoVVTOwqiL0KE7E0ZLapifHkG18p7426n0hpzkt0DzLhCaCnXEgUX75c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFuaT7DU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0358C4CEFB;
	Thu, 13 Nov 2025 13:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039005;
	bh=ocHWTlOICTb8Z8Ub+gbv30rvYo205HCmin2dzeq1a7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nFuaT7DUGLDQCOuihQB8Iks0QS6Db7x2gw8PhFOVKfnWpZaRyZchDT905OXtDtDvS
	 BHA30wNBiO/4PoZSOHr6gjWaMUKwE9StnYpe5q+83RF332Z6N7s/dOFtxOqJEy3iFo
	 T0+g8Lw2oMhq8xjv14PsREbsIRjzcnsZ7Z4+XCbxDEiYi9A7PMk0y53YrcoQMS9sZn
	 DxWdvTEHKRmpjLmXQwSFqIARlbhH/TTfata8ZBshR4CwvVjBm5JFFcOzUtjxarH4eQ
	 IuD2ZDCiIWeUCLxxU7VCEDfvZipE89QJYGfuLjDLyLgH+e5ea2JeOC9NgShJPDZHL7
	 NEgcWaXZq/E7A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:50 +0100
Subject: [PATCH RFC 30/42] ovl: port ovl_nlink_end() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-30-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=756; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ocHWTlOICTb8Z8Ub+gbv30rvYo205HCmin2dzeq1a7E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnuypvn/b7u4CO+iP8lFT5n8M0J8i+e8/G+4yV6za
 cuzmO6wjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImo+TD8z2X3KOH1s2OwrVqn
 Zpq+/q+Ur/mhNIfM06qRIVnC1jZMDH9ld/sF/DB+H9JcsdzJrfz1238OCrPmG3SwsOsrzK57W8s
 HAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/util.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 2280980cb3c3..e2f2e0d17f0b 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1211,11 +1211,8 @@ void ovl_nlink_end(struct dentry *dentry)
 	ovl_drop_write(dentry);
 
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(dentry->d_sb);
-		ovl_cleanup_index(dentry);
-		ovl_revert_creds(old_cred);
+		with_ovl_creds(dentry->d_sb)
+			ovl_cleanup_index(dentry);
 	}
 
 	ovl_inode_unlock(inode);

-- 
2.47.3


