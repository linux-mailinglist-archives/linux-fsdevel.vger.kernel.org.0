Return-Path: <linux-fsdevel+bounces-60077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23719B413E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D26017B3A1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80D72D73B0;
	Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XhtXs63R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C42D63EC
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875347; cv=none; b=MM0qKnbQqaJkDm5rkf/KVthAr0vo5rPYpa3WjS2fXFtlFBZufQdrDsMy5pX/ATTiZLvcULvY0nNSoM4p72JLSNcLrTILuU/u6xdMKu9exmKYpOMWRtic+ffGfx98K+aMsviRVyiWjSvXSspxLGjQjSgolSKvw3h3NHL0EHIBfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875347; c=relaxed/simple;
	bh=bB75f6CELA9F/1ma6i/IaTRTijY+iPczM+YYX47xl9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTM9oJafGjmXm+4j3xc04um2HvlvPM/oRfHw5RfE1ZTKu9XROcbpaXj2V68a15BhlcqDzsZKFwUp47tqcvF2W3qcT9DmJRPHrNEIsU6OzpuNDOTCEcT/0kb/hDdZZGj3XnVeItyl90XWu02RJ2qs7e2zfWYsRzgNVsexPCMp4Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XhtXs63R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UVrSijWbzKNku4iBTyLd6bCYA6cje074/ftvw93ifBI=; b=XhtXs63R9qnPmJI3cytuQBkn+a
	rKPLXrF2ezQWQjaVxgcCe9caTENNfcX5qQVIAHKA3A6W/sujiW+Ib2WEi4HLt/TcqS8fZcSxxvK0m
	Dn+EKZwMZb1LwfjtHv4Yt1O+QpQwWxRjNZtwaXrExr1a4R7IPZtABobZDgWZjmVlY/q0UlOkhmlcA
	ePuy2s6rRkL1LJli3x4XlkwtJW1DvNyd+Wu5UNfauMHhkxU/PbyTSxsNmiHAxX6QoH6WQ2ho3Dk8V
	vrHYzlojYqDvrvZltwvhLxYTZeHmmGVkylrZDincxxeCNrGaQGuuzlM7/Jd8VZNhDhZ5cAjZYzdzj
	EOQMm8zA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX3-0000000Ap9e-46yw;
	Wed, 03 Sep 2025 04:55:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 26/63] do_new_mount_rc(): use __free() to deal with dropping mnt on failure
Date: Wed,  3 Sep 2025 05:54:48 +0100
Message-ID: <20250903045537.2579614-27-viro@zeniv.linux.org.uk>
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


