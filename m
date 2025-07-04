Return-Path: <linux-fsdevel+bounces-53870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133B6AF84FC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 02:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759C516D32E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 00:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B37261E;
	Fri,  4 Jul 2025 00:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sXCj2E7t";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sXCj2E7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2106273F9
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751589810; cv=none; b=PMwhAq0wTE7ZjIQh+OrqwWX1HlAGSY2sx75cqdWGR9rHjBasYJnRR/2y7KcFVzAjbpIPYtRRByF5+BsRcErCLT/hkSJ2ZJqFsfOmXEjWAljkiRdhrMiPaN/UB9sLu+zxhAQo30l7OblYSL2EHGPrxX0gncP4RvFAm7PWk/K5Bn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751589810; c=relaxed/simple;
	bh=ViHPWzYswbGMuSRagoT9bF1Je6ZQrtrmbLm9huHSnX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQmQFCtRNj7CPTPv9GfcY7xnL+ppUxDOmhAzdUvoZn2rU2c4sDJjvu0OXEQfTSnOtjmEMuFWPyvmtSCOJNf8kl5x1uwMzEKFF15j8GcZAHeYHASO9dH97T5CoPVYy8Abdrm+S+IAkMkd5av+9lcg/fhAejrXm6T9cUUikMFuBc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sXCj2E7t; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sXCj2E7t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF3A61F456;
	Fri,  4 Jul 2025 00:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751589787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0u8QW1/aTJwgdV+hLfuZ1X98ttxonIqDMvhf/uLKnOs=;
	b=sXCj2E7tgonaOCt72XUW++nBRA3RCQhe9evfP5NOrqPpgcmSFT5oPvz/Zol4UXfVajlORp
	aNepkxY3MQYFzAjsMhf4+nxvcFgqVyoBuijQ27Y7XkGOLoznQBoxecw/tDKZqSEUTJ4q0C
	rftHGdh4I1xo6GTCFUY5KFvar4cBzOg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751589787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0u8QW1/aTJwgdV+hLfuZ1X98ttxonIqDMvhf/uLKnOs=;
	b=sXCj2E7tgonaOCt72XUW++nBRA3RCQhe9evfP5NOrqPpgcmSFT5oPvz/Zol4UXfVajlORp
	aNepkxY3MQYFzAjsMhf4+nxvcFgqVyoBuijQ27Y7XkGOLoznQBoxecw/tDKZqSEUTJ4q0C
	rftHGdh4I1xo6GTCFUY5KFvar4cBzOg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E3A213757;
	Fri,  4 Jul 2025 00:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uMFcOJkjZ2hMEwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 04 Jul 2025 00:43:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v4 6/6] btrfs: implement remove_bdev super operation callback
Date: Fri,  4 Jul 2025 10:12:34 +0930
Message-ID: <cade58c3eff4e8dbbec42748115637c97a44f130.1751589725.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751589725.git.wqu@suse.com>
References: <cover.1751589725.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

For this callback, btrfs will:

- Go degraded if the fs can still maintain RW operations
  And of course mark the target device as missing.

- Shutdown if the fs can not maintain RW operations

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
  exercises the shutdown branch.

- Not yet determined what's the expected behavior
  Although the current auto-degrade behavior is no worse than the old
  behavior, it may not always be what the end users want.

  Before there is a concrete interface, better hide the new feature
  from end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 ++
 fs/btrfs/volumes.h |  5 ++++
 3 files changed, 64 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 727d5c1d1bf1..dd6e8a50ac39 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2421,6 +2421,60 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	return 0;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static void btrfs_remove_bdev(struct super_block *sb, struct block_device *bdev)
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
+		btrfs_warn(fs_info, "unable to find btrfs device for block device '%pg'",
+			   bdev);
+		return;
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
+		return;
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
+		btrfs_force_shutdown(fs_info);
+		return;
+	}
+	btrfs_warn(fs_info,
+		   "btrfs device id %llu has gone missing, continue as degraded",
+		   device->devid);
+	btrfs_set_opt(fs_info->mount_opt, DEGRADED);
+}
+#endif
+
 static const struct super_operations btrfs_super_ops = {
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
@@ -2436,6 +2490,9 @@ static const struct super_operations btrfs_super_ops = {
 	.unfreeze_fs	= btrfs_unfreeze,
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	.remove_bdev	= btrfs_remove_bdev,
+#endif
 };
 
 static const struct file_operations btrfs_ctl_fops = {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2098129743e7..340a1bb0c844 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6792,6 +6792,8 @@ static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
 				  const struct btrfs_device *device)
 {
+	if (args->devt)
+		return device->devt == args->devt;
 	if (args->missing) {
 		if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
 		    !device->bdev)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6acb154ccf87..71e570f8337d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -663,6 +663,11 @@ struct btrfs_dev_lookup_args {
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


