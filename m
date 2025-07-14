Return-Path: <linux-fsdevel+bounces-54795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E7BB035AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120CA18990BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046F91FBE8C;
	Mon, 14 Jul 2025 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="liD1F8B/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nTiOT5Q5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE01E1DE7
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 05:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752470794; cv=none; b=nyVr5EZNPtWZ387dYDnrkpsuT+NYMPYiWjjcAHPKbCVoyzbnBJVHtuxpCtXnFxTm2ZWUW5ponWqg65SwDmaOd1Bs/voH0puoo2bX2EiBm2sXyWclZi7WnfTfhbnAQtAUyk+CHcH0rIzxJHPwtwthXb72LoDceywKUSCPRj81QD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752470794; c=relaxed/simple;
	bh=cxxcEVePXkM+P/AGTPSk99xG2IEyKj6mwwdV5WF6+Co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6IIT/Kt1fdkbCKHKhQ14A0X9/tFzU4+vzoQA+I0u+Z3Dr6OYobYVb9Dkrbpy9e1kVw/hrRfJpIFuCs+AeMhTdhVy1A94S4538av2//akfKW16sxj/fIuuECzruXa14ZgBpF5/pVaJqo44BBK/N3sSkE76o25DohzwiL9DDk/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=liD1F8B/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nTiOT5Q5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5BE2211F8;
	Mon, 14 Jul 2025 05:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CO/+zAMk2bVRklZN0zPNXgnPov8Z0bMOXHC5hpkLxMs=;
	b=liD1F8B/igK8t8ND5F1ta4KcqZHoCE2t1F46WFCdme33FIIJsYaa3rx08XuIa5rDnKrgLE
	DhkJIyJFetR7Zlb1T8UOKONx97/Z2kOTVyLLpOxqaDIwidgJtSgKNtrYPAciTl2kE9O/bc
	d/fEOMWcruVJtN7yksujYI8PPlofrBI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nTiOT5Q5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752470782; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CO/+zAMk2bVRklZN0zPNXgnPov8Z0bMOXHC5hpkLxMs=;
	b=nTiOT5Q52pBn5r1v07hijiTDYkABOErC5slniCrTH2i6du27RrM1JV3SEdwBtBGaLwjLdP
	FQxd283IG/J7QZHh2jnFPGpKKZM89CJ9oZTb0sLdzqpvohIouyNWtfexxi6KlPMQAu9vOn
	nBPVvleLpltLzZsVWm/wIDWG5Hkx+9w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9405138A1;
	Mon, 14 Jul 2025 05:26:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3mB0HfyUdGhadQAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 14 Jul 2025 05:26:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH v5 0/6] btrfs: add remove_bdev() callback
Date: Mon, 14 Jul 2025 14:55:56 +0930
Message-ID: <cover.1752470276.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E5BE2211F8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[CHANGELOG]
v5:
- Split remove_bdev() from shutdown()
  Now remove_bdev() will have a return value to indicate if the fs can
  handle the removal of the device.
  And if not, a non-zero (normally minus) value is returned.

  In that case ->shutdown() will be called as usual.

  This allows us to avoid unnecessary operations that only make sense
  for shutdown case, like shrinking the cache.

  This also means no change to any of the existing filesystems.

- Implement ->shutdown() callback for btrfs
  Since ->shutdown() and ->remove_bdev() call backs are separate now,
  btrfs needs to implement both.

v4:
- Update the commit message of the first patch
  Remove the out-of-date comments about the old *_shutdown() names.

v3:
- Also rename the callback functions inside each fs to *_remove_bdev()
  To keep the consistency between the interface and implementation.

- Add extra handling if the to-be-removed device is already missing in
  btrfs
  I do not know if a device can be double-removed, but the handling
  inside btrfs is pretty simple, if the target device is already
  missing, nothing needs to be done and can exit immediately.

v2:
- Enhance and rename shutdown() callback
  Rename it to remove_bdev() and add a @bdev parameter.
  For the existing call backs in filesystems, keep their callback
  function names, now something like ".remove_bdev = ext4_shutdown,"
  will be a quick indicator of the behavior.

- Remove the @surprise parameter for the remove_bdev() parameter.
  The fs_bdev_mark_dead() is already trying to sync the fs if it's not
  a surprise removal.
  So there isn't much a filesystem can do with the @surprise parameter.

- Fix btrfs error handling when the devices are not opened
  There are several cases that the fs_devices is not opened, including:
  * sget_fc() failure
  * an existing super block is returned
  * a new super block is returned but btrfS_open_fs_devices() failed

  Handle the error properly so that fs_devices is not freed twice.

RFC->v1:
- Add a new remove_bdev() callback
  Thanks all the feedback from Christian, Christoph and Jan on this new
  name.

- Add a @surprise parameter to the remove_bdev() callback
  To keep it the same as the bdev_mark_dead().

- Hide the shutdown ioctl and remove_bdev callback behind experimental 
  With the shutdown ioctl, there are at least 2 test failures (g/388, g/508).

  G/388 is related to the error handling with COW fixup.
  G/508 looks like something related to log replay.

  And the remove_bdev() doesn't have any btrfs specific test case yet to
  check the auto-degraded behavior, nor the auto-degraded behavior is
  fully discussed.

  So hide both of them behind experimental features.

- Do not use btrfs_handle_fs_error() to avoid freeze/thaw behavior change
  btrfs_handle_fs_error() will flips the fs read-only, which will
  affect freeze/thaw behavior.
  And no other fs set the fs read-only when shutting down, so follow the
  other fs to have a more consistent behavior.

Qu Wenruo (6):
  fs: add a new remove_bdev() callback
  btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
  btrfs: reject file operations if in shutdown state
  btrfs: reject delalloc ranges if in shutdown state
  btrfs: implement shutdown ioctl
  btrfs: implement remove_bdev and shutdown super operation callbacks

 fs/btrfs/file.c            | 25 ++++++++++++++-
 fs/btrfs/fs.h              | 28 ++++++++++++++++
 fs/btrfs/inode.c           | 14 +++++++-
 fs/btrfs/ioctl.c           | 44 +++++++++++++++++++++++++
 fs/btrfs/messages.c        |  1 +
 fs/btrfs/reflink.c         |  3 ++
 fs/btrfs/super.c           | 66 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 ++
 fs/btrfs/volumes.h         |  5 +++
 fs/super.c                 | 11 +++++++
 include/linux/fs.h         |  9 ++++++
 include/uapi/linux/btrfs.h |  9 ++++++
 12 files changed, 215 insertions(+), 2 deletions(-)

-- 
2.50.0


