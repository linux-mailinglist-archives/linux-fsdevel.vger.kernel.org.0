Return-Path: <linux-fsdevel+bounces-43036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D314A4D378
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D119172EE6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 06:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C761F4736;
	Tue,  4 Mar 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J9cWlg4R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g3X49eNW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J9cWlg4R";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g3X49eNW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846CF1F4264
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068637; cv=none; b=qUrUe5yusGz/vUMdj0UlaNTYw5rTTyoDN8kAEEp7h8v2OM8KJvf6H22NnkCGWjhEhqQNyylfaAZCdFBJu31ji4KoTqk3YTpvHt9/gF124qqp8BtTRZx56xzNKJfDxiCZGQjP6idhZSmwbPfcYj7aHdh2QV4F78JxK1sK6pCzf2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068637; c=relaxed/simple;
	bh=Mgnj6zoySRRTNBvbbcDsKMXo6rUpyU19Ldpk5kWAMEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FP8xUtj0oI9VC0VQJy8I2Shs20XGhuWTdIeTEmBOTPz/zI1SuVPNoArjI5/Fz09GGSdNc5dxdodE4zufSLkaQWMMQlU/UNvOfCqQcBgvHW9CJPazzkMcfwvY9mahW9llQfoc61nx836aGgYotCYjMWGZC33Gt/PbBqrYosDgucU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J9cWlg4R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g3X49eNW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J9cWlg4R; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g3X49eNW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1CA61F387;
	Tue,  4 Mar 2025 06:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3q5x5TDW1HvVLc3RQPkh4FAtkYaiqyWLpBE41UXQ+aQ=;
	b=J9cWlg4RFdmAhZN+eLMXJlhxe5/aiWit3/Q9NDgceNMUIK7wVzP96UEFPaYFk1KEj2fCv1
	nkxLLN9fFowiGDhvQgo+O+hGy/Nwj0zMWtzT6SuddRPVxDZaWyqWuednwAtZlaKjtocXV8
	4r1wvM0wtYXRYS10BRKeDZCARskpsLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3q5x5TDW1HvVLc3RQPkh4FAtkYaiqyWLpBE41UXQ+aQ=;
	b=g3X49eNW1Y3dKDzo39fNOyipVeF42hjDm2VS4IMXbGKsWU9xgL5fpPiBxL1j0D1hUJbePL
	Xc2J3ZUO/mbIGvAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741068633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3q5x5TDW1HvVLc3RQPkh4FAtkYaiqyWLpBE41UXQ+aQ=;
	b=J9cWlg4RFdmAhZN+eLMXJlhxe5/aiWit3/Q9NDgceNMUIK7wVzP96UEFPaYFk1KEj2fCv1
	nkxLLN9fFowiGDhvQgo+O+hGy/Nwj0zMWtzT6SuddRPVxDZaWyqWuednwAtZlaKjtocXV8
	4r1wvM0wtYXRYS10BRKeDZCARskpsLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741068633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3q5x5TDW1HvVLc3RQPkh4FAtkYaiqyWLpBE41UXQ+aQ=;
	b=g3X49eNW1Y3dKDzo39fNOyipVeF42hjDm2VS4IMXbGKsWU9xgL5fpPiBxL1j0D1hUJbePL
	Xc2J3ZUO/mbIGvAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEF661393C;
	Tue,  4 Mar 2025 06:10:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B83/JFeZxmfADQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 04 Mar 2025 06:10:31 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 0/8] initramfs: kunit tests and cleanups
Date: Tue,  4 Mar 2025 16:57:43 +1100
Message-ID: <20250304061020.9815-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.985];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This patchset adds basic kunit test coverage for initramfs unpacking
and cleans up some minor buffer handling issues / inefficiencies.

Changes since v3:
- Drop shared unpack buffer changes
  + rework into initramfs: allocate heap buffers together (patch 5/8)
  + extra review complexity wasn't worth the tiny boot-time heap saving
- move hardlink hash leak repro into first initramfs_test patch
- add note regarding kunit section=.data -> section=.init.text warning

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

David Disseldorp (8):
      init: add initramfs_internal.h
      initramfs_test: kunit tests for initramfs unpacking
      vsprintf: add simple_strntoul
      initramfs: avoid memcpy for hex header fields
      initramfs: allocate heap buffers together
      initramfs: reuse name_len for dir mtime tracking
      initramfs: fix hardlink hash leak without TRAILER
      initramfs: avoid static buffer for error message

 include/linux/kstrtox.h   |   1 +
 init/.kunitconfig         |   3 +
 init/Kconfig              |   7 +
 init/Makefile             |   1 +
 init/initramfs.c          |  66 ++++----
 init/initramfs_internal.h |   8 +
 init/initramfs_test.c     | 407 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/vsprintf.c            |   7 +
 8 files changed, 472 insertions(+), 28 deletions(-)
 create mode 100644 init/.kunitconfig
 create mode 100644 init/initramfs_internal.h
 create mode 100644 init/initramfs_test.c

