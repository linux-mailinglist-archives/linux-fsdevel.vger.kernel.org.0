Return-Path: <linux-fsdevel+bounces-53033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63986AE9301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2833BE2B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248A32D29D7;
	Wed, 25 Jun 2025 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kgM9nji1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kgM9nji1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3E2F1FE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895651; cv=none; b=EuxY3x9PNAlnuxgYGVCjg0FJl8d5OSV5Ol/Npq6W57kqZjImRFwpWZjzxzzERRywHzY6bzoLcH5tOhJ70/O+0/qFJEQAa/AbgBdGan6Xy5McqyS6V8FZTeF9vcFe2kXHnG043TBNjIIPtF70SY1Bs2yl4I/nKQ4YV+f6sR8HTkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895651; c=relaxed/simple;
	bh=VCrpUYCoycFD2IqYhMtvSxMe1oUK3HmPbMkCD4sByqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jd473LAMONqYHLi7IUZIxGdUhn2KgRrCz1WkU4pT3Yw+qa2BUbUmTK2L9WvTdovEmjBkiQ1qGkpnQXgpePCN5ivY1m3f89GpQpUnep6rz0w1L/63UocS133SKLgsZPJCCGI92J3UJrgWNdXe9Qlnhe51O6MPI1bcFb3L1PPoCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kgM9nji1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kgM9nji1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72686211A3;
	Wed, 25 Jun 2025 23:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750895647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MQ6DGK8Uht8gajfKhOcpeZr5rZw8fbUwoX4f/6+J9nc=;
	b=kgM9nji1w6l/eOdZMZejFSmUDS3NCaoWSXVJLzUqMlMe318BINp6lYaQP+H/wT9Qz8OxOd
	oPJbf7Hm8iMdKAXdpVWVjafn5Gcg8cT+eKAxE3pHJl2BbBHtJu6ecRrgCxnESU7Tc8jrJe
	pBUJvvboSUqcHXg8saYYK2dmCnpReGU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750895647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MQ6DGK8Uht8gajfKhOcpeZr5rZw8fbUwoX4f/6+J9nc=;
	b=kgM9nji1w6l/eOdZMZejFSmUDS3NCaoWSXVJLzUqMlMe318BINp6lYaQP+H/wT9Qz8OxOd
	oPJbf7Hm8iMdKAXdpVWVjafn5Gcg8cT+eKAxE3pHJl2BbBHtJu6ecRrgCxnESU7Tc8jrJe
	pBUJvvboSUqcHXg8saYYK2dmCnpReGU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B074F13301;
	Wed, 25 Jun 2025 23:54:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qNEgHB2MXGjQMAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 25 Jun 2025 23:54:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH 0/6] btrfs: add remove_bdev() callback
Date: Thu, 26 Jun 2025 09:23:41 +0930
Message-ID: <cover.1750895337.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

[CHANGELOG]
RFC->v1:

- Add a new remove_bdev() callback
  Thanks all the feedback from Christian, Christoph and Jan on this new
  name.

- Add a @surprise parameter to the remove_bdev() callback
  To keep it the same as the bdev_mark_dead().

- Hide the shutdown ioctl and remove_bdev callback behind experimental 
  With the shutdown ioctl, there are 3 test failures (g/050, g/388,
  g/508).

  G/050 may require a test case update.
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

The series is based on the fs_holder_ops patchset here:
https://lore.kernel.org/linux-btrfs/cover.1750724841.git.wqu@suse.com/

The full series including the btrfs' support of fs_holder_ops can be
found here:
https://github.com/adam900710/linux/tree/shutdown

Patch 1 is introducing the new remove_bdev() super operation callback,
with not only the extra @bdev parameter, but also a @surprise flag to
follow bdev_mark_dead().

Patch 2~5 implement the shutdown ioctl so that btrfs can benefit from
the existing shutdown test group.
Although it's still only enabled for experimental builds, as there are
still some minor failures needs to be addressed

Patch 6 implements the remove_bdev() callback, so that btrfs can either
shutdown the fs or continue degraded.
It's still an experimental feature, as we still need more disccussion
on the user expectation and possible extra user configurable behaviors.

Qu Wenruo (6):
  fs: add a new remove_bdev() super operations callback
  btrfs: introduce a new fs state, EMERGENCY_SHUTDOWN
  btrfs: reject file operations if in shutdown state
  btrfs: reject delalloc ranges if the fs is shutdown
  btrfs: implement shutdown ioctl
  btrfs: implement remove_bdev super operation callback

 fs/btrfs/file.c            | 25 ++++++++++++++++-
 fs/btrfs/fs.h              | 28 +++++++++++++++++++
 fs/btrfs/inode.c           | 14 +++++++++-
 fs/btrfs/ioctl.c           | 43 +++++++++++++++++++++++++++++
 fs/btrfs/messages.c        |  1 +
 fs/btrfs/reflink.c         |  3 +++
 fs/btrfs/super.c           | 55 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c         |  2 ++
 fs/btrfs/volumes.h         |  5 ++++
 fs/super.c                 |  4 ++-
 include/linux/fs.h         | 18 +++++++++++++
 include/uapi/linux/btrfs.h |  9 +++++++
 12 files changed, 204 insertions(+), 3 deletions(-)

-- 
2.49.0


