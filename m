Return-Path: <linux-fsdevel+bounces-2528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217E97E6CDF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 16:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91609B20D07
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 15:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCA1E52D;
	Thu,  9 Nov 2023 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h+o57ad7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BC8D2EE
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 15:07:01 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EDE35A9;
	Thu,  9 Nov 2023 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Eb8MG9TBz4s7MRmJjfR+Bq5zgXzHMYOhLNojz4j8puU=; t=1699542421; x=1700752021; 
	b=h+o57ad7VbE6V682ZrJM0u1AUYYwmG8MchFwi4gU61IZ3YXuKF/dUGPTBikNAtfEnvdZgXKbdZB
	y7KClNzpRbxZ0StFxJwxUdb2u7Nq314og0M35JNQbgHwtWkZClX7+p73p3fdKpKAlzPFD5ja1/4v/
	+MPaOvrA1wwRn5Oac5LYw98K63kl6YRc7idaXTHtB4Kfepy+pfedzCUan0qb3CBRARbNh7V+syPxO
	JnARg9UXy8gRULkqWekMoOOC0nvTg9CEsa9UH5Lei1dwWVlQngE1YEziZL0483pwZK7aZfTZq4EI5
	Vl+OkJtnfclWJ2o0GWKuvJK4dbrPiNgJpEDw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r16cO-00000001pgv-0fKp;
	Thu, 09 Nov 2023 16:06:52 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolai Stange <nicstange@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] debugfs: only clean up d_fsdata for d_is_reg()
Date: Thu,  9 Nov 2023 16:06:40 +0100
Message-ID: <20231109160639.514a2568f1e7.I64fe5615568e87f9ae2d7fb2ac4e5fa96924cb50@changeid>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

debugfs_create_automount() can store a function pointer in
d_fsdata, and for directories it may be NULL. The commit
7c8d469877b1 ("debugfs: add support for more elaborate
->d_fsdata") ignored that, and while freeing NULL is just
fine, if an automount is ever removed we'd attempt to
kfree() the function pointer. This currently never happens
since the only user (tracing) will never remove the
automount dir.

Later patches changed the logic here again to store the
real fops, and store the allocation only after a debugfs
file reference is obtained via debugfs_file_get().

Remove debugfs_release_dentry() so we won't attempt to
do anything common with the different uses of d_fsdata,
and put the freeing of the allocated data where it's last
possibly used, in __debugfs_file_removed(), which is only
called for regular files.

Also check in debugfs_file_get() that it gets only called
on regular files, just to make things clearer.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c  |  3 +++
 fs/debugfs/inode.c | 14 +++++---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..1a20c7db8e11 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -84,6 +84,9 @@ int debugfs_file_get(struct dentry *dentry)
 	struct debugfs_fsdata *fsd;
 	void *d_fsd;
 
+	if (WARN_ON(!d_is_reg(dentry)))
+		return -EINVAL;
+
 	d_fsd = READ_ONCE(dentry->d_fsdata);
 	if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
 		fsd = d_fsd;
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 3f81f73c241a..3f00cd40c81d 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -235,14 +235,6 @@ static const struct super_operations debugfs_super_operations = {
 	.free_inode	= debugfs_free_inode,
 };
 
-static void debugfs_release_dentry(struct dentry *dentry)
-{
-	void *fsd = dentry->d_fsdata;
-
-	if (!((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT))
-		kfree(dentry->d_fsdata);
-}
-
 static struct vfsmount *debugfs_automount(struct path *path)
 {
 	debugfs_automount_t f;
@@ -252,7 +244,6 @@ static struct vfsmount *debugfs_automount(struct path *path)
 
 static const struct dentry_operations debugfs_dops = {
 	.d_delete = always_delete_dentry,
-	.d_release = debugfs_release_dentry,
 	.d_automount = debugfs_automount,
 };
 
@@ -734,6 +725,11 @@ static void __debugfs_file_removed(struct dentry *dentry)
 		return;
 	if (!refcount_dec_and_test(&fsd->active_users))
 		wait_for_completion(&fsd->active_users_drained);
+
+	/* this no longer matters */
+	dentry->d_fsdata = NULL;
+
+	kfree(fsd);
 }
 
 static void remove_one(struct dentry *victim)
-- 
2.41.0


