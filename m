Return-Path: <linux-fsdevel+bounces-33601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C0A9BB75A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9B41F223AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7936C42AA9;
	Mon,  4 Nov 2024 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nk4Qqv6r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j27in6DG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nk4Qqv6r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j27in6DG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE4F79FD
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729887; cv=none; b=QHkb0uRjjO5unMRk5OUa7W4NkfLHW+3kVp0TuEkZk6juFrMc99kE+aWRU/C5n1xaiiyTI5Yuxgw/twTdzBBhxp17Z2hUGynAq7Y6UDfofCIMov4LKlDsR4JlUUipzx0t7s1XZ8lYpQ8rGRbBdaJO6OfgOo3QFLCFEClQIYmTC74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729887; c=relaxed/simple;
	bh=tdu0SABTGgzW90wpRU6A0HwQH9ZezzdXJz8MSOQUf+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mL03IzusMGgaOetZmMkyCWh3sc4n5+xz3xclSu0lkCU9RMTrJJSRSTTYWAKEbgKGKzXSzo3Skvdx0Nor8SR0mIDoYQB2jg7TLK/fiD40NDUZJ+ig+t8XHe5c2m8HiSzsW5jPkesdAOlqDTtKbndFUrdEX6yVHgGsJFDgPtR9EBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nk4Qqv6r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j27in6DG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nk4Qqv6r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j27in6DG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 435D61F7DD;
	Mon,  4 Nov 2024 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZBJzIDxc1UUe/ckdgFwT1rGy6uzgppkCtCXVgn+HK0c=;
	b=Nk4Qqv6r5SznYNVRyAC9pMZgrev+mMruv5sxc1KDSvFNvoG4BIdyVn7hTTLko30OhD+G/u
	MfvqKQI357MVkQ6YPei1KDxw+jSrqyqj0EW8XYTQZwj2QQL6TIVZnQlRFUFzmP1lkhs1Rn
	0kGi0SHEoIC+3s9/pI2PFr5Q5rhiWG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZBJzIDxc1UUe/ckdgFwT1rGy6uzgppkCtCXVgn+HK0c=;
	b=j27in6DGH7aJXULLMoe/PhoQXSvAm93+7Q9cmKZyL/Joonqpuk15C1OrMvX81mFg35FXSB
	fAuyzFopW0n4QYBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nk4Qqv6r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j27in6DG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730729884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZBJzIDxc1UUe/ckdgFwT1rGy6uzgppkCtCXVgn+HK0c=;
	b=Nk4Qqv6r5SznYNVRyAC9pMZgrev+mMruv5sxc1KDSvFNvoG4BIdyVn7hTTLko30OhD+G/u
	MfvqKQI357MVkQ6YPei1KDxw+jSrqyqj0EW8XYTQZwj2QQL6TIVZnQlRFUFzmP1lkhs1Rn
	0kGi0SHEoIC+3s9/pI2PFr5Q5rhiWG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730729884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZBJzIDxc1UUe/ckdgFwT1rGy6uzgppkCtCXVgn+HK0c=;
	b=j27in6DGH7aJXULLMoe/PhoQXSvAm93+7Q9cmKZyL/Joonqpuk15C1OrMvX81mFg35FXSB
	fAuyzFopW0n4QYBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF60513736;
	Mon,  4 Nov 2024 14:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dckTGZrXKGfGfAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 04 Nov 2024 14:18:02 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/9] initramfs: kunit tests and cleanups
Date: Tue,  5 Nov 2024 01:14:39 +1100
Message-ID: <20241104141750.16119-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 435D61F7DD
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This patchset adds basic kunit test coverage for initramfs unpacking
and cleans up some minor buffer handling issues / inefficiencies.

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
 init/initramfs_test.c     | 387 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/vsprintf.c            |   7 +
 8 files changed, 455 insertions(+), 32 deletions(-)
 create mode 100644 init/.kunitconfig
 create mode 100644 init/initramfs_internal.h
 create mode 100644 init/initramfs_test.c


