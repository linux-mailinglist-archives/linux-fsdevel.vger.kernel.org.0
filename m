Return-Path: <linux-fsdevel+bounces-60065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCCFB413D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DECC560041
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE122D7DDC;
	Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cv4x9L67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499B2D5C6C
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875345; cv=none; b=se1KDc5afWZ0Fxd8WKgnkfvtjT59ZV7Hh8w33o50RwY3jZL2DQlq+DmdQCs8JDOI574cpaccoy6T5yr/6cUKl7b3gxWpNt5xDG2o2SN5rylzwAELR5mKofuGF2nATw5FjxjgCYcOJ1w+nPDgp9bhinANvL5QIFRe5KLn6CHTzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875345; c=relaxed/simple;
	bh=SPUmTmutmJ2p+X/l5yTtjapnEIZ2v127wFoTNMpz0SM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i42QvGn9ufplXsJ5jdSUrD6cf+4yQf3ePRirDxyWpeuCmJQRL3Twrl9GsNWsXIKk9wLzPUszMsOQdWwJvot9JA5TnDE+TJI2IZziiUAEovu5+GR69gMs+Gdk9HzpZ2r0N7SIE6ojLKSy89576GGCwfEs4sBKwMu59vYFhEgP+MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cv4x9L67; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mC0kycyJaj2dQHbey1bFHJn9E9E66NHFGgl/68njQWE=; b=cv4x9L67nkr+kiH1DFYbhO0ZKN
	/lz24lfzx/xANx/8sjpysPOwQJteTYwQAFrZ9QuyDI0YJDRRtunPXYcTWaco0xjFXB2QnhzUJ068S
	beZ1/A38MbtmD25nRzYPxBaiGe3Sp8tsiVFf5Ke81fc8QWU2tu0/72Tu3mzS2E5KrtAMzrcfrE8Hk
	hdrPDg3ALd4VJ6WhF+csOnlspZsQ06j9+xFzGYSmPmzJkPlEXS0qHtmDuAdQwF9qrjSp8uhwDDCd1
	TmGSTdZK0/Fwl+mcuS6Kzx3znItBeZDLKAAmOXVt8CwlU2xv/zBPZMOYTIYOLJYlllJcyBGmP43D/
	jJJBQsUg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX3-0000000Ap9R-3n0w;
	Wed, 03 Sep 2025 04:55:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 26/65] do_new_mount_fc(): use __free() to deal with dropping mnt on failure
Date: Wed,  3 Sep 2025 05:54:47 +0100
Message-ID: <20250903045537.2579614-26-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

do_add_mount() consumes vfsmount on success; just follow it with
conditional retain_and_null_ptr() on success and we can switch
to __free() for mnt and be done with that - unlock_mount() is
in the very end.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6251ee15f5f6..3551e51461a2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3696,7 +3696,7 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 {
 	struct pinned_mountpoint mp = {};
 	struct super_block *sb;
-	struct vfsmount *mnt = fc_mount(fc);
+	struct vfsmount *mnt __free(mntput) = fc_mount(fc);
 	int error;
 
 	if (IS_ERR(mnt))
@@ -3704,10 +3704,11 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 
 	sb = fc->root->d_sb;
 	error = security_sb_kern_mount(sb);
-	if (!error && mount_too_revealing(sb, &mnt_flags))
-		error = -EPERM;
 	if (unlikely(error))
-		goto out;
+		return error;
+
+	if (unlikely(mount_too_revealing(sb, &mnt_flags)))
+		return -EPERM;
 
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
@@ -3716,11 +3717,9 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 		error = do_add_mount(real_mount(mnt), mp.mp,
 				     mountpoint, mnt_flags);
 		if (!error)
-			mnt = NULL;	// consumed on success
+			retain_and_null_ptr(mnt); // consumed on success
 		unlock_mount(&mp);
 	}
-out:
-	mntput(mnt);
 	return error;
 }
 
-- 
2.47.2


