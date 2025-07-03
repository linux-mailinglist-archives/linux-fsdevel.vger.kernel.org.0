Return-Path: <linux-fsdevel+bounces-53856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA313AF8465
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5EE1C87323
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 23:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F972DCF53;
	Thu,  3 Jul 2025 23:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nDvJlnaL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nDvJlnaL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499F71C07C3
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586177; cv=none; b=rMVXxKW1U0ldqbhE4pY9HxGalw2U+L5UqwxAi3NXnsXFpUz9EU4lzshUA8wiQLceXoQ7taA1fX8kUZv1KXbmQesIQ/m1WukWT9UbVNrOTGrWnGrJGGgOLI+wDzCAstI1fZXjiquZv5Ptp8BQSpbGOLdXK8gK2lyDNKAcg97Rxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586177; c=relaxed/simple;
	bh=ViHPWzYswbGMuSRagoT9bF1Je6ZQrtrmbLm9huHSnX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdyE7CMgPAjehzoEf75NRN7daUz6UJONjyxdktLv0KyQ+9C6Sq6DoM5gx2/OT+JOg+2cnX1WM9punlWFwR1XfESSsRHHN+9ukBoJGMwyWEhSWSanmPUm6vln2Vjp5csg69K6Kt9RYD9SDw7wjC0zJ/tSBjlCxEPSVBcumhHrfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nDvJlnaL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nDvJlnaL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71ED61F454;
	Thu,  3 Jul 2025 23:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0u8QW1/aTJwgdV+hLfuZ1X98ttxonIqDMvhf/uLKnOs=;
	b=nDvJlnaLSVaXP9NzPW+qnV07gtn6om7Wohn5ECHsLBa5ChrE60CSByxlS2225dKhgKfBSk
	ZvtEBTTOk1zZ1KVnyB3e7H2HThPClMEuJbPwR2i5Hn1h2uL0SqPSQrZCjbNEjV8D0ENntd
	Pw1IN6ggTsdUurnNMzKv4sZu5g3Z21s=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0u8QW1/aTJwgdV+hLfuZ1X98ttxonIqDMvhf/uLKnOs=;
	b=nDvJlnaLSVaXP9NzPW+qnV07gtn6om7Wohn5ECHsLBa5ChrE60CSByxlS2225dKhgKfBSk
	ZvtEBTTOk1zZ1KVnyB3e7H2HThPClMEuJbPwR2i5Hn1h2uL0SqPSQrZCjbNEjV8D0ENntd
	Pw1IN6ggTsdUurnNMzKv4sZu5g3Z21s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3D3613721;
	Thu,  3 Jul 2025 23:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6M1UHXsVZ2j7AQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 03 Jul 2025 23:42:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v3 6/6] btrfs: implement remove_bdev super operation callback
Date: Fri,  4 Jul 2025 09:12:19 +0930
Message-ID: <2c4d3871bbd21cd5904c8627374355b158195bf1.1751577459.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751577459.git.wqu@suse.com>
References: <cover.1751577459.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
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


