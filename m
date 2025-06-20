Return-Path: <linux-fsdevel+bounces-52297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB120AE135C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 07:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CECB1792A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC0421FF28;
	Fri, 20 Jun 2025 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L4Xw3BpB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L4Xw3BpB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502C21ABC2
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750398493; cv=none; b=fXcBJGqV9f9kaBOB3FfZRuo+19ycMrt15hmts/CE+WJBE5JRA6ZWv1fwlt+wLuKCT6rE7jTTT6vwJez9HYdW36JP4qQunS6+eKg1LfwTFVyeuVJT8XXS3Naz9sBVG0cnZ8LhCg/p2u06vBtbmwxQ19d9MAt7yqAaXKAYSghWSuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750398493; c=relaxed/simple;
	bh=7wKLKtFSYqajcXunez9xN7Fz+p3+MCMbOKKL0+Z+R60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWcs8Gcv1O98pvm4x9phV7jzN8IyXRq4WoesS6DzapsTil8Itq8erFWO2Gqb/k2tXba7oqMZc3Gcin9Xgr0mSJf/lgbgywpIW2l9hgP12j5qG6I6VdUGo9ybDyDQHQl+s2l69Pl0lSGkZSGbl177IXG5QfgSsEfURF0jVzGjLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L4Xw3BpB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L4Xw3BpB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3CDB121211;
	Fri, 20 Jun 2025 05:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gL7f2lHr2tQfsAFI680yVqiEP4o8iBfd45IdXIoFPM=;
	b=L4Xw3BpBlYS+bcyzDFcD5LROuI7A09QJnovQDCqKVlFLYCEm4WoWskPJZGN0tWxaIG9Q4A
	oV5x6HaaV4WFdcubZFY/IuLMGq0LjMyu3EGGUxGd2uw5E9UYFkSk9bRRtlteuuVkfu9g/3
	tfMBzL1tuYEAtuKV74ma40yViJchY8s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750398482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gL7f2lHr2tQfsAFI680yVqiEP4o8iBfd45IdXIoFPM=;
	b=L4Xw3BpBlYS+bcyzDFcD5LROuI7A09QJnovQDCqKVlFLYCEm4WoWskPJZGN0tWxaIG9Q4A
	oV5x6HaaV4WFdcubZFY/IuLMGq0LjMyu3EGGUxGd2uw5E9UYFkSk9bRRtlteuuVkfu9g/3
	tfMBzL1tuYEAtuKV74ma40yViJchY8s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F67A13318;
	Fri, 20 Jun 2025 05:48:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QPyKEBD2VGi2NAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 20 Jun 2025 05:48:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH RFC 6/6] btrfs: implement shutdown_bdev super operation callback
Date: Fri, 20 Jun 2025 15:17:29 +0930
Message-ID: <9ee35786df0864cfd6fa368d25c7d09f27116869.1750397889.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750397889.git.wqu@suse.com>
References: <cover.1750397889.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

For this callback, btrfs will:

- Go degraded if the fs can still maintain RW operations

- Shutdown if the fs can not maintain RW operations

I know the shutdown can be a little overkilled, if one has a RAID1
metadata and RAID0 data, in that case one can still read data with 50%
rate to got some good data.

But it can also be as bad as the only device went missing for a single
device btrfs.

So here we go safe other than sorry when handling missing device.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 34 ++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 ++
 fs/btrfs/volumes.h |  5 +++++
 3 files changed, 41 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 82ce0625b2f0..f82f9be41321 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2397,6 +2397,39 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	return 0;
 }
 
+static void btrfs_shutdown_bdev(struct super_block *sb, struct block_device *bdev)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_device *device;
+	struct btrfs_dev_lookup_args lookup_args = { .devt = bdev->bd_dev };
+
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	device = btrfs_find_device(fs_info->fs_devices, &lookup_args);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	if (!device) {
+		btrfs_warn(fs_info, "unable to find btrfs device for block device '%pg'",
+			   bdev);
+		return;
+	}
+	set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+	device->fs_devices->missing_devices++;
+	if (test_and_clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
+		list_del_init(&device->dev_alloc_list);
+		device->fs_devices->rw_devices--;
+	}
+	if (!btrfs_check_rw_degradable(fs_info, device)) {
+		btrfs_warn_in_rcu(fs_info,
+	"btrfs device id %llu path %s has gone missing, can not maintain read-write",
+				  device->devid, btrfs_dev_name(device));
+		btrfs_shutdown(fs_info);
+		return;
+	}
+	btrfs_warn_in_rcu(fs_info,
+	"btrfs device id %llu path %s has gone missing, continue degraded",
+			  device->devid, btrfs_dev_name(device));
+	btrfs_set_opt(fs_info->mount_opt, DEGRADED);
+}
+
 static const struct super_operations btrfs_super_ops = {
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
@@ -2412,6 +2445,7 @@ static const struct super_operations btrfs_super_ops = {
 	.unfreeze_fs	= btrfs_unfreeze,
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
+	.shutdown_bdev	= btrfs_shutdown_bdev,
 };
 
 static const struct file_operations btrfs_ctl_fops = {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 541d17ca5dcf..5639df71ef91 100644
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
index afa71d315c46..2c5e3ebc5a2b 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -652,6 +652,11 @@ struct btrfs_dev_lookup_args {
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
2.49.0


