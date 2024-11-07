Return-Path: <linux-fsdevel+bounces-33842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D459BFA9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 01:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E993B22407
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 00:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0680B23C9;
	Thu,  7 Nov 2024 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vOnUYBxs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hIssntRB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vOnUYBxs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hIssntRB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646BA7F9;
	Thu,  7 Nov 2024 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938859; cv=none; b=MR9ibnqCzvYTKyJFkpJESHMb8BcbLjeldIZHwiPm91eU5qvOS4yt7ItKahVCooVr2p0wUD0Z8GPnSLq4tGS5Xxb7tgyQRjiwz/v1CfQ4PaNmdaja53KZeO7ov2XorAHGyvED3sOZ4qE+X+nxZ+6oS+E6x6F+JxsbtP1cBB8t864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938859; c=relaxed/simple;
	bh=6+9+rOle1yuQCVAHVlrxMiL0JM8WjI6Jzo5bImukIns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOsTn0E67deWkEDw8C0LMRoScPStGfmjXopYgeLbZI5VqIOqnh9f61Y/wN3TK5cUTACQhs1khrmWxgajGRWV7/KI+dmHKUe4d2tr32BDP02PxaUNA83vXQJXmtRxALpGVh/yO8YKMe0nojePGaEF/kuRa+T9myNHl1IED0hVHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vOnUYBxs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hIssntRB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vOnUYBxs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hIssntRB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D36A1F392;
	Thu,  7 Nov 2024 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N4GiKwBTfTRExblGK/c6zX1qlyPUfsg3kHlOZ1kLrAI=;
	b=vOnUYBxsJovLbk34hRDUsBNwfkJD7iCdPV67OMnRJ7jIkIFEC/oASg8Ay+xiU2PKn7ERCA
	Ix4I7MHUbRBvWBmdWj9Yo2x7g7X9+W2LNI4HYm8XhoS8tJvU8eK+H9PpyUQezyrewvjncN
	9N9SyYfHy54O90AAARZOZdlmmLAQ/+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N4GiKwBTfTRExblGK/c6zX1qlyPUfsg3kHlOZ1kLrAI=;
	b=hIssntRBzn9cuL4kqaFd9tKyRbDwg/RM1g7Xuos0ZsHotmPSmHaR9TJLqM9IjZ9m04f3Sp
	cyf+2oi1oCeITmDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vOnUYBxs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hIssntRB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730938855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N4GiKwBTfTRExblGK/c6zX1qlyPUfsg3kHlOZ1kLrAI=;
	b=vOnUYBxsJovLbk34hRDUsBNwfkJD7iCdPV67OMnRJ7jIkIFEC/oASg8Ay+xiU2PKn7ERCA
	Ix4I7MHUbRBvWBmdWj9Yo2x7g7X9+W2LNI4HYm8XhoS8tJvU8eK+H9PpyUQezyrewvjncN
	9N9SyYfHy54O90AAARZOZdlmmLAQ/+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730938855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=N4GiKwBTfTRExblGK/c6zX1qlyPUfsg3kHlOZ1kLrAI=;
	b=hIssntRBzn9cuL4kqaFd9tKyRbDwg/RM1g7Xuos0ZsHotmPSmHaR9TJLqM9IjZ9m04f3Sp
	cyf+2oi1oCeITmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 840BE1394A;
	Thu,  7 Nov 2024 00:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xmDCDeUHLGfWYgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 07 Nov 2024 00:20:53 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/9] initramfs: kunit tests and cleanups
Date: Thu,  7 Nov 2024 11:17:18 +1100
Message-ID: <20241107002044.16477-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5D36A1F392
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This patchset adds basic kunit test coverage for initramfs unpacking
and cleans up some minor buffer handling issues / inefficiencies.

Changes since v2 (patch 2 only):
- fix !CONFIG_INITRAMFS_PRESERVE_MTIME kunit test checks
- add test MODULE_DESCRIPTION(), as suggested by Jeff Johnson
- add some missing headers, reported by kernel test robot

Changes since v1 (RFC):
- rebase atop v6.12-rc6 and filename field overrun fix from
  https://lore.kernel.org/r/20241030035509.20194-2-ddiss@suse.de
- add unit test coverage (new patches 1 and 2)
- add patch: fix hardlink hash leak without TRAILER
- rework patch: avoid static buffer for error message
  + drop unnecessary message propagation
- drop patch: cpio_buf reuse for built-in and bootloader initramfs
  + no good justification for the change

Feedback appreciated.

David Disseldorp (9):
      init: add initramfs_internal.h
      initramfs_test: kunit tests for initramfs unpacking
      vsprintf: add simple_strntoul
      initramfs: avoid memcpy for hex header fields
      initramfs: remove extra symlink path buffer
      initramfs: merge header_buf and name_buf
      initramfs: reuse name_len for dir mtime tracking
      initramfs: fix hardlink hash leak without TRAILER
      initramfs: avoid static buffer for error message

 include/linux/kstrtox.h   |   1 +
 init/.kunitconfig         |   3 +
 init/Kconfig              |   7 +
 init/Makefile             |   1 +
 init/initramfs.c          |  73 +++++----
 init/initramfs_internal.h |   8 +
 init/initramfs_test.c     | 403 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/vsprintf.c            |   7 +
 8 files changed, 471 insertions(+), 32 deletions(-)
 create mode 100644 init/.kunitconfig
 create mode 100644 init/initramfs_internal.h
 create mode 100644 init/initramfs_test.c

