Return-Path: <linux-fsdevel+bounces-54801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6723B035BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA6C189ACE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919BD2153E7;
	Mon, 14 Jul 2025 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Te2xiKL3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Te2xiKL3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444EC1FCF7C
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470817; cv=none; b=aaLpNxz1E1/kftaDnd8pNjypklRZQROqXwXCgp36s6/eRW1mWNNI2T3RodZNF1KLpoRAPuHzV6vV8olVMRRPzBNMYwAQ/gvJEfOwEBu0ajnTVjx8q/cWGMFLxd4ThCwk2xXTFzhSBfvLiX9jgXpYfI0wX0+1TAROh4rNiW6aCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470817; c=relaxed/simple;
	bh=E40unYsQEphDx2QOGiY39PECJdHwICqE9NqgU3882hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVZmNnxPywQSfnUrrzqfTd8JE/QmwnKPsJ7D43zjuzi9ZlwjCje6Vv7vSKPVXNww0l/fMBURFNYRgr5ZMd+/wcmfm/GOBWUdl3cC/0UvsTUQY8uagkBDTPEqAHsFLGNxbgAyw3cvgxcmraBNnKcUmANeEyInB6ygsM2ERdHMjk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Te2xiKL3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Te2xiKL3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 478251F390;
	Mon, 14 Jul 2025 05:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4u1JhpSr9iXaXUGE7NJF1c10K3+rW9i50b80wP1akTQ=;
	b=Te2xiKL32h/RkGzQvPMGVQ6ebnlfogVm09UB8Qj+KjNd3t1i3qiafviXBYgX+++gSTOE75
	g4+AhIJKCaDrjDsyc20IG1+mp5HH86fsxM0YAqi22jy43CQazLhK+s7Sq1naVhtoMIE8no
	LKsLmOViS7en3HG1dwQlpJNvJeC6XJA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Te2xiKL3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4u1JhpSr9iXaXUGE7NJF1c10K3+rW9i50b80wP1akTQ=;
	b=Te2xiKL32h/RkGzQvPMGVQ6ebnlfogVm09UB8Qj+KjNd3t1i3qiafviXBYgX+++gSTOE75
	g4+AhIJKCaDrjDsyc20IG1+mp5HH86fsxM0YAqi22jy43CQazLhK+s7Sq1naVhtoMIE8no
	LKsLmOViS7en3HG1dwQlpJNvJeC6XJA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CFF6138A1;
	Mon, 14 Jul 2025 05:26:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8NsrAwyVdGhadQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 14 Jul 2025 05:26:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v5 6/6] btrfs: implement remove_bdev and shutdown super operation callbacks
Date: Mon, 14 Jul 2025 14:56:02 +0930
Message-ID: <85faf081c038c5c4a501529b5ed52deea69c58ce.1752470276.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752470276.git.wqu@suse.com>
References: <cover.1752470276.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 478251F390
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

For the ->remove_bdev() callback, btrfs will:

- Mark the target device as missing

- Go degraded if the fs can afford it

- Return error other wise
  Thus falls back to the shutdown callback

For the ->shutdown callback, btrfs will:

- Set the SHUTDOWN flag
  Which will reject all new incoming operations, and make all writeback
  to fail.

  The behavior is the same as the NOLOGFLUSH behavior.

To support the lookup from bdev to a btrfs_device,
btrfs_dev_lookup_args is enhanced to have a new @devt member.
If set, we should be able to use that @devt member to uniquely locating a
btrfs device.

I know the shutdown can be a little overkilled, if one has a RAID1
metadata and RAID0 data, in that case one can still read data with 50%
chance to got some good data.

But a filesystem returning -EIO for half of the time is not really
considered usable.
Further it can also be as bad as the only device went missing for a single
device btrfs.

So here we go safe other than sorry when handling missing device.

And the remove_bdev callback will be hidden behind experimental features
for now, the reasons are:

- There are not enough btrfs specific bdev removal test cases
  The existing test cases are all removing the only device, thus only
  exercises the ->shutdown() behavior.

- Not yet determined what's the expected behavior
  Although the current auto-degrade behavior is no worse than the old
  behavior, it may not always be what the end users want.

  Before there is a concrete interface, better hide the new feature
  from end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 ++
 fs/btrfs/volumes.h |  5 ++++
 3 files changed, 73 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 466d0450269c..79f6ad1d44de 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2413,6 +2413,68 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	return 0;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_remove_bdev(struct super_block *sb, struct block_device *bdev)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_device *device;
+	struct btrfs_dev_lookup_args lookup_args = { .devt = bdev->bd_dev };
+	bool can_rw;
+
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	device = btrfs_find_device(fs_info->fs_devices, &lookup_args);
+	if (!device) {
+		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+		/* Device not found, should not affect the running fs, just give a warning. */
+		btrfs_warn(fs_info, "unable to find btrfs device for block device '%pg'",
+			   bdev);
+		return 0;
+	}
+	/*
+	 * The to-be-removed device is already missing?
+	 *
+	 * That's weird but no special handling needed and can exit right now.
+	 */
+	if (unlikely(test_and_set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))) {
+		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+		btrfs_warn(fs_info, "btrfs device id %llu is already missing",
+			   device->devid);
+		return 0;
+	}
+
+	device->fs_devices->missing_devices++;
+	if (test_and_clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
+		list_del_init(&device->dev_alloc_list);
+		WARN_ON(device->fs_devices->rw_devices < 1);
+		device->fs_devices->rw_devices--;
+	}
+	can_rw = btrfs_check_rw_degradable(fs_info, device);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	/*
+	 * Now device is considered missing, btrfs_device_name() won't give a
+	 * meaningful result anymore, so only output the devid.
+	 */
+	if (!can_rw) {
+		btrfs_crit(fs_info,
+		"btrfs device id %llu has gone missing, can not maintain read-write",
+			   device->devid);
+		return -EIO;
+	}
+	btrfs_warn(fs_info,
+		   "btrfs device id %llu has gone missing, continue as degraded",
+		   device->devid);
+	btrfs_set_opt(fs_info->mount_opt, DEGRADED);
+	return 0;
+}
+
+static void btrfs_shutdown(struct super_block *sb)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+
+	btrfs_force_shutdown(fs_info);
+}
+#endif
+
 static const struct super_operations btrfs_super_ops = {
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
@@ -2428,6 +2490,10 @@ static const struct super_operations btrfs_super_ops = {
 	.unfreeze_fs	= btrfs_unfreeze,
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	.remove_bdev	= btrfs_remove_bdev,
+	.shutdown	= btrfs_shutdown,
+#endif
 };
 
 static const struct file_operations btrfs_ctl_fops = {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa7a929a0461..89a82b2a5a7a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6802,6 +6802,8 @@ static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
 				  const struct btrfs_device *device)
 {
+	if (args->devt)
+		return device->devt == args->devt;
 	if (args->missing) {
 		if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
 		    !device->bdev)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index a56e873a3029..78003c9b8abd 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -662,6 +662,11 @@ struct btrfs_dev_lookup_args {
 	u64 devid;
 	u8 *uuid;
 	u8 *fsid;
+	/*
+	 * If devt is specified, all other members will be ignored as it is
+	 * enough to uniquely locate a device.
+	 */
+	dev_t devt;
 	bool missing;
 };
 
-- 
2.50.0


