Return-Path: <linux-fsdevel+bounces-59554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC8BB3AE13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E80C988524
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890B2F1FE5;
	Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aNbM55wK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B196F2C1596
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=UOt1ePs3IseaW+pv5eTDJmgl3mBx1wWlmJnjYo2/pOJok36WwrzSwMg79L+yj9dw/RLcQS2WfozYvszmHAHb/IY28fRnEbcsav17zaxeJbVfrkNUSlH7qKPMEffGqm4KDnLMi0aCL0z+WdEeVG/Ob7SpqRcdvA9uI/2CraJ8nx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=bB75f6CELA9F/1ma6i/IaTRTijY+iPczM+YYX47xl9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ey65pejWPg42Ls+uQy5ZO4IlLl27YbXy/JmRsl0C/9a533ljAfbtVbe66ZB3lkQR8VuHCTHgF0StCp6QvAOxJGAD0L6ON6XgClycpxlfhmTV1O2usbnicFjCrFqUqvIJU2TGa7X0LjfRQyjMzfLQrDRpPwHhM68DCEM6XRYsm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aNbM55wK; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UVrSijWbzKNku4iBTyLd6bCYA6cje074/ftvw93ifBI=; b=aNbM55wKXwuGl80TrkyfTDbiIH
	abEzu7n0KGUILeajnvhEaGCBA62sM8+H2QLcgpp9B47hTkLZLpNRegRjeBmcLlaIROPVPY3fJIVyf
	JFEk3WZlr9TjHh+0EfNHFN+93eTaRvRBQa1W4WDH7cGm3rPKeCmyqjWS8qa45KI1Lgb0iB5h8Q86K
	FJCjKky8ykgPtfXBn1hfOG39RHFVPsH7Rooe+2d4Ug4t3QOtCuu3lCkiCFbvwJokVINozjF7Tduhk
	chhADSi2rjef6snVv8ve08eHXAV2e7sv028aQ22sOyxpMVYznbyNaU4vslTXaChOMkWgeajAopMp+
	cltl2Knw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliz-0000000F24f-3d8g;
	Thu, 28 Aug 2025 23:08:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 26/63] do_new_mount_rc(): use __free() to deal with dropping mnt on failure
Date: Fri, 29 Aug 2025 00:07:29 +0100
Message-ID: <20250828230806.3582485-26-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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


