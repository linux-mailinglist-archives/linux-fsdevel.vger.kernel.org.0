Return-Path: <linux-fsdevel+bounces-68240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4702BC578F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCA1A3554E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6B4354711;
	Thu, 13 Nov 2025 13:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1lyG5Ua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E035292A;
	Thu, 13 Nov 2025 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038993; cv=none; b=YAyyUsX/+OxHjk8WvXoADbskoqenfvwuo5PAxgj44MYYusuokAw4Smb8UUho3Pki6RG2AW5gCZ1E3tw4+GbY5QVENMarLyzHwiMoQSmvDqELHxT+zRrueo3PxqZO8c9nhlHAmTehDrh8tV6brZ9NkHcTqcz2qUFNgi5O+DZd5Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038993; c=relaxed/simple;
	bh=fT+cLwEFymk1JP3awBjka+ewiD86yQCBT7T9eud5ZoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etRZrci+UKicqGTppt36Th+u1R3By3ECjjjVusz3RlWUoWfJaaFyYFlHTSa5iC/DI69yjCoj9J86NvQDmxg8wPzF7A7WZKNS2WnjOqQj5sOgHdSuw98buZHBDDJJaogi0Tiarxf5zaB5zNtIOOJhbUVR1sjVKbXzc5G19FDKoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1lyG5Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301FDC19422;
	Thu, 13 Nov 2025 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038992;
	bh=fT+cLwEFymk1JP3awBjka+ewiD86yQCBT7T9eud5ZoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N1lyG5UaqT5k34+BTnVfs2cy1iE2Hl23O4HKWF128rSsJ9Ph4osObZ+cs5/hltm8p
	 qFhhfQoRbH9AtI3DcfFvb3GYAlJk9nVHWGYQAjgVRtN9sOLgWQO42B3hACMhUuNSpL
	 bteRMSn68PVC639L3iP3AVE5f2lsGhNkDX7ny8+Z2W9E5Jfo50aW4UKeelO2jUjpcu
	 I5s3brXcETZ6J9BmR5hFcOG73DWtsK829Ptjyq5lEJLmk+OeAs/F40JzshMmfcl6d1
	 KG/xkoXS91cyOVLKMVQZbCMlH3SegeFl+Pb8osk68utZRkA2G4W53uyqP31+oPoxYI
	 +csGzD5SK1U5w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:43 +0100
Subject: [PATCH RFC 23/42] ovl: port ovl_maybe_validate_verity() to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-23-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=882; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fT+cLwEFymk1JP3awBjka+ewiD86yQCBT7T9eud5ZoQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvMp+smfDVX6i/jDIk7UvaPFXxl0ns5KmT/iIj6i
 /l0R4t2lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATCRGiJFhWcjLO8231sjdPNx1
 fp9abJT7ZO+Ogj5PQWnnNQnflZ2WMfwPLZp+u7eAJ7PxQP1i9dwJsx/eLmfKYlxiFxF5wHrSRk8
 GAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e93bcc5727bc..dbacf02423cb 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -979,15 +979,10 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 		return err;
 
 	if (!ovl_test_flag(OVL_VERIFIED_DIGEST, inode)) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(dentry->d_sb);
-
-		err = ovl_validate_verity(ofs, &metapath, &datapath);
+		with_ovl_creds(dentry->d_sb)
+			err = ovl_validate_verity(ofs, &metapath, &datapath);
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
-
-		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);

-- 
2.47.3


