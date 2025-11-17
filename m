Return-Path: <linux-fsdevel+bounces-68665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A23C6349A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70D564F0AB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0CC32D434;
	Mon, 17 Nov 2025 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krIaqUSq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055F232D0F9;
	Mon, 17 Nov 2025 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372065; cv=none; b=brdFrEYNEWS/3P26w3jLu3uATZqYzFWcbLW9TArdO6rffPJxCDZMCZ92Njgg1sdC1/nY3oJE/Sdln3BDcWWOPPKCdAg4GsKKis2n/hsTd9yZZurMPbzcruT4XmFenQPyI5zh+41oUmK2PsMWXr19rApaHmmjGbmwk6nrQzSk/ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372065; c=relaxed/simple;
	bh=zjyw0/rgGCcNg2hOnV2dZIPmB08RELaA6DQ8h6k7QFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTSQJEdDz08JQnHH+IOeQPT2M8uG2g09AHOcQFkDUOsoEBK7O7d53KywgDRNzvWhFpCXtCBRWnMNkHa+GLqgAvwLpAdASRpk77fPd/iNWOYWV/dg1Y7uWeSROakFPNu17yJfOBkW5Yx6bqNtjmTZ8uILGAFQg1zlDozSrN/lZ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krIaqUSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A5BC4AF09;
	Mon, 17 Nov 2025 09:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372064;
	bh=zjyw0/rgGCcNg2hOnV2dZIPmB08RELaA6DQ8h6k7QFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=krIaqUSqC0CckG6tNORcbON4b8b0NwtycmhsbJvyqRSdCKRNWgw+78Q+MLOfFBCRe
	 cR/BYT3nHBFXe0xpUXTmrzk/nrZ+u5M0PdLnEYs8jkZwHBTrkOF7PmX/LFDsw7dcGJ
	 U2F0d1WfByAZQdkeNog+qNxlBntaPT4vDFN+isV5dj9u5vQEka6JvARjwqOkS7zZA/
	 ltBsa7xNzf/pbrKjOwarTX7wojOHBpqhL90rrBmB1KfRjCPM3dzYl/y1oQCxobtH6b
	 ZNx5k4SrAYPchDHyS0WUlu1AxTaGqn6YN+Z4/HSUhbFIjUE7HeynJqa+esqfXRZMDd
	 90iYVz80SBGBw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:53 +0100
Subject: [PATCH v4 22/42] ovl: port ovl_maybe_validate_verity() to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-22-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zjyw0/rgGCcNg2hOnV2dZIPmB08RELaA6DQ8h6k7QFA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf46V857cZpuTP2Cjf1luxe+2itur9A7ae1Rc5H8l
 siWxNS0jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm89WD4H+2SnHY7snBLnJ/4
 Y2FxPpFPwRMmbpp489Wh2a9CFcXE9BkZ/rc92VZosWvdrD6+gDL+L0XKNYzSTypm39BNNc7S/eH
 PCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

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
+		with_ovl_creds(dentry->d_sb)
 			err = ovl_validate_verity(ofs, &metapath, &datapath);
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
-
-		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);

-- 
2.47.3


