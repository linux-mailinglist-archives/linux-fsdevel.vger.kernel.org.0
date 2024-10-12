Return-Path: <linux-fsdevel+bounces-31808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB14B99B69F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 20:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A121B2833CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 18:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08984FAD;
	Sat, 12 Oct 2024 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bF1A27KI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29082768FD
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Oct 2024 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728758577; cv=none; b=GUFkhQfMRsTjxBEGKZldj+F3KERaeB48FzQs5UAhYsydQyYNXgm8MFSPCA/roTJ6arszuE/9Yq0As6/fzI+rSHC8A7BjDGUbkZ/40w71zIZYik5OR6zsHEDdS2aZMDUZDZKzMLHzFReVHkqumgvCcOAlBaMG+e6tIF4vb+r/USU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728758577; c=relaxed/simple;
	bh=rNaAzK1QA47pnaAoe8F69BGleQCAHGxwvNQMvAl4/yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=burlGjDp/qsmu2b5ZswinrYVZpz0gYSA00cW/rjxkm6lt2UkqoUt3M4Pkq8o3hw4IhYwscjNib3krGAqtyz5wwYoz63gK6PXpGsnhnbRNr5Z2vdRvXED0c8zU6c4APLpZj0pMWDsFwpDyRk3KyWOofnqy08YhGHRuJ5yE4o0fVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bF1A27KI; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728758568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=op+lPm3NAWju6hQm59ucRMw5qO4FBhJZsP6B74qdwq8=;
	b=bF1A27KIRO2AJLZI5bJbs4KKT3HokW9iWIwtcPhptZOxSZMl9F4Qb5cGb9IUdcIjnyoMeE
	BWL14es5xZhBw1uS2fEW7BsA7aU9iXRp3g6jDtMlqw8prbJDrxI4OA1u6JCUAinhgvJAXZ
	ClfnsTEkrooGrX1FSRxtg2KtffjdCd0=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH] bcachefs: Fix sysfs warning in fstests generic/730,731
Date: Sat, 12 Oct 2024 14:42:39 -0400
Message-ID: <20241012184239.3785089-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

sysfs warns if we're removing a symlink from a directory that's no
longer in sysfs; this is triggered by fstests generic/730, which
simulates hot removal of a block device.

This patch is however not a correct fix, since checking
kobj->state_in_sysfs on a kobj owned by another subsystem is racy.

A better fix would be to add the appropriate check to
sysfs_remove_link() - and sysfs_create_link() as well.

But kobject_add_internal()/kobject_del() do not as of today have locking
that would support that.

Note that the block/holder.c code appears to be subject to this race as
well.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc:  Christoph Hellwig <hch@lst.de>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/bcachefs/super.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/bcachefs/super.c b/fs/bcachefs/super.c
index 843431e58cf5..f96355ecb296 100644
--- a/fs/bcachefs/super.c
+++ b/fs/bcachefs/super.c
@@ -184,6 +184,7 @@ static DEFINE_MUTEX(bch_fs_list_lock);
 
 DECLARE_WAIT_QUEUE_HEAD(bch2_read_only_wait);
 
+static void bch2_dev_unlink(struct bch_dev *);
 static void bch2_dev_free(struct bch_dev *);
 static int bch2_dev_alloc(struct bch_fs *, unsigned);
 static int bch2_dev_sysfs_online(struct bch_fs *, struct bch_dev *);
@@ -620,9 +621,7 @@ void __bch2_fs_stop(struct bch_fs *c)
 	up_write(&c->state_lock);
 
 	for_each_member_device(c, ca)
-		if (ca->kobj.state_in_sysfs &&
-		    ca->disk_sb.bdev)
-			sysfs_remove_link(bdev_kobj(ca->disk_sb.bdev), "bcachefs");
+		bch2_dev_unlink(ca);
 
 	if (c->kobj.state_in_sysfs)
 		kobject_del(&c->kobj);
@@ -1188,9 +1187,7 @@ static void bch2_dev_free(struct bch_dev *ca)
 {
 	cancel_work_sync(&ca->io_error_work);
 
-	if (ca->kobj.state_in_sysfs &&
-	    ca->disk_sb.bdev)
-		sysfs_remove_link(bdev_kobj(ca->disk_sb.bdev), "bcachefs");
+	bch2_dev_unlink(ca);
 
 	if (ca->kobj.state_in_sysfs)
 		kobject_del(&ca->kobj);
@@ -1227,10 +1224,7 @@ static void __bch2_dev_offline(struct bch_fs *c, struct bch_dev *ca)
 	percpu_ref_kill(&ca->io_ref);
 	wait_for_completion(&ca->io_ref_completion);
 
-	if (ca->kobj.state_in_sysfs) {
-		sysfs_remove_link(bdev_kobj(ca->disk_sb.bdev), "bcachefs");
-		sysfs_remove_link(&ca->kobj, "block");
-	}
+	bch2_dev_unlink(ca);
 
 	bch2_free_super(&ca->disk_sb);
 	bch2_dev_journal_exit(ca);
@@ -1252,6 +1246,26 @@ static void bch2_dev_io_ref_complete(struct percpu_ref *ref)
 	complete(&ca->io_ref_completion);
 }
 
+static void bch2_dev_unlink(struct bch_dev *ca)
+{
+	struct kobject *b;
+
+	/*
+	 * This is racy w.r.t. the underlying block device being hot-removed,
+	 * which removes it from sysfs.
+	 *
+	 * It'd be lovely if we had a way to handle this race, but the sysfs
+	 * code doesn't appear to provide a good method and block/holder.c is
+	 * susceptible as well:
+	 */
+	if (ca->kobj.state_in_sysfs &&
+	    ca->disk_sb.bdev &&
+	    (b = bdev_kobj(ca->disk_sb.bdev))->state_in_sysfs) {
+		sysfs_delete_link(b, &ca->kobj, "bcachefs");
+		sysfs_delete_link(&ca->kobj, b, "block");
+	}
+}
+
 static int bch2_dev_sysfs_online(struct bch_fs *c, struct bch_dev *ca)
 {
 	int ret;
-- 
2.45.2


