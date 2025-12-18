Return-Path: <linux-fsdevel+bounces-71599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C94FCCA0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5133630562ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6B8277C9E;
	Thu, 18 Dec 2025 02:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9Xhm5lH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E032B274B51;
	Thu, 18 Dec 2025 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023502; cv=none; b=tzrHpgaeq2Z5hbjUbnI6x/3sj1wEGuMwYb5uZZFU63O1d43dv+Qof9AwJ7CXxG55o19bbkTwVQl0hEmy9G5rrLivspAsgVmkh4jsO7/tO8GktrezO/93NkW62+1rtX0xic3pfMXjQ9yQMFBVTuZAtU3MaRfI5Ymq/xzIWnthGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023502; c=relaxed/simple;
	bh=W1weteJ/phxCCzm89n++8sHlDEH7aAUjJrZaTqb/55A=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ar0a/eTaEcqP8A8p8zRmvkIpKPrTUbH+Ig28tHStiR+QoKqQI0ahfYO2ZcJrbdNV7j2oLKyCn/hZumvCMiK5PFBxBZQxc2/FVt0xp48P/4Foj87IkEOpELBTo5jHdU+ipLvzyQjLcIGPfoulVPNjnx59pEXSVn7gs8af1RzWAxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9Xhm5lH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BF1C4CEF5;
	Thu, 18 Dec 2025 02:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023501;
	bh=W1weteJ/phxCCzm89n++8sHlDEH7aAUjJrZaTqb/55A=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=H9Xhm5lHd1OQ72jT1/xi5mOBiamflqjTw4rsgQLwoER7WF2r5Yu9+kdiM5xWMckzS
	 HBVuRN9d19/8319q7ovnPrOM/lZFtNt0LXT2NmcWsikVTRJyPktpMKhbMuK8HLSl5y
	 kN0zFKBpZ2H4VUelNTe9Uw1yGBmlV9sEUmUD5VsFr/0NUfH/qZ6YjHlnNV/OqQ098C
	 KvE2n2tIs+sZ7EMAsiCwu15dszPc8hqTDLYHiVYTvaa/SY4jKjj7Nh/bh+FcgF6MEn
	 Vdr7TGdgVANnxU3je20INx93mImCDXoZ9jrxz4Jq6YsgCNfDLJcn6Z1zoadjhUd/8H
	 YDWM2Smd5hfAQ==
Date: Wed, 17 Dec 2025 18:05:01 -0800
Subject: [PATCH 3/4] ext4: convert ext4_root to a kset
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org
Message-ID: <176602332570.688213.9854057917443661154.stgit@frogsfrogsfrogs>
In-Reply-To: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In the next patch, we'll enhance ext4 to send uevents when significant
filesystem mount events occur (remounting, shutdown, unmount, etc.)
However, kobject_uevent_env requires that the filesystem's kobject be a
member of a kset.  Therefore, change ext4_root to ext4_kset and migrate
the two users of it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/ext4/sysfs.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)


diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 0018e09b867ec3..e6a14585244308 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -564,7 +564,7 @@ void ext4_notify_error_sysfs(struct ext4_sb_info *sbi)
 	sysfs_notify(&sbi->s_kobj, NULL, "errors_count");
 }
 
-static struct kobject *ext4_root;
+static struct kset *ext4_kset;
 
 static struct kobject *ext4_feat;
 
@@ -574,7 +574,8 @@ int ext4_register_sysfs(struct super_block *sb)
 	int err;
 
 	init_completion(&sbi->s_kobj_unregister);
-	err = kobject_init_and_add(&sbi->s_kobj, &ext4_sb_ktype, ext4_root,
+	sbi->s_kobj.kset = ext4_kset;
+	err = kobject_init_and_add(&sbi->s_kobj, &ext4_sb_ktype, NULL,
 				   "%s", sb->s_id);
 	if (err) {
 		kobject_put(&sbi->s_kobj);
@@ -615,8 +616,8 @@ int __init ext4_init_sysfs(void)
 {
 	int ret;
 
-	ext4_root = kobject_create_and_add("ext4", fs_kobj);
-	if (!ext4_root)
+	ext4_kset = kset_create_and_add("ext4", NULL, fs_kobj);
+	if (!ext4_kset)
 		return -ENOMEM;
 
 	ext4_feat = kzalloc(sizeof(*ext4_feat), GFP_KERNEL);
@@ -625,8 +626,9 @@ int __init ext4_init_sysfs(void)
 		goto root_err;
 	}
 
+	ext4_feat->kset = ext4_kset;
 	ret = kobject_init_and_add(ext4_feat, &ext4_feat_ktype,
-				   ext4_root, "features");
+				   NULL, "features");
 	if (ret)
 		goto feat_err;
 
@@ -637,8 +639,8 @@ int __init ext4_init_sysfs(void)
 	kobject_put(ext4_feat);
 	ext4_feat = NULL;
 root_err:
-	kobject_put(ext4_root);
-	ext4_root = NULL;
+	kset_unregister(ext4_kset);
+	ext4_kset = NULL;
 	return ret;
 }
 
@@ -646,8 +648,8 @@ void ext4_exit_sysfs(void)
 {
 	kobject_put(ext4_feat);
 	ext4_feat = NULL;
-	kobject_put(ext4_root);
-	ext4_root = NULL;
+	kset_unregister(ext4_kset);
+	ext4_kset = NULL;
 	remove_proc_entry(proc_dirname, NULL);
 	ext4_proc_root = NULL;
 }


