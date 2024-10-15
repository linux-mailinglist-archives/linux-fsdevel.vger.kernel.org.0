Return-Path: <linux-fsdevel+bounces-31981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7559C99ED87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B0CB22057
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E053B14F117;
	Tue, 15 Oct 2024 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MZzxgNt8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kCPo6sBG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MZzxgNt8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kCPo6sBG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B511FC7DF
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999030; cv=none; b=keJVJ9Nf8gSW3SssxxoZ3+JuuCMXUQ3rXB9TOfm8PeeFjVZUznhdAtoJ6lbaqX20HT0SM2xGNj8i7GsX9C3mPi5iYBd++KfrQw/vTiUdQLh//SsRZKK8em//+f6bMxStAVB8cpkXQUYfUvvULG55ulzOqrZyUirc7VdsQqznNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999030; c=relaxed/simple;
	bh=3HDuk5nD1LPGUaxPmlieckSuiWJJj1FyphGhwCZcO9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFuK3gCJ9lzOzlvtzZ/LrTrYigrRRojkvsooTNiS6Q7/006DFKSx6bIeh17Ld1r9n4MAAXLZxm7//0YswgoFXqufQv1RNTWa+Ho/PGImPCICAjXh0byGN0PPPs41fpU7pPRpzEl39C59FpDUjAtOUjXkFyW/5TK8RWmmcA3KMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MZzxgNt8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kCPo6sBG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MZzxgNt8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kCPo6sBG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F3B621D8E;
	Tue, 15 Oct 2024 13:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YyvOCjcmNl1vDuZvFXU8jyeuNLgLY7+ySjke5hlwQzA=;
	b=MZzxgNt898VnY6KJ8vay1NW2RJwiTru42YKwUpzEI68/DCYNrmKS4paSsYn98etPxXOt0S
	VkGbg3nzpqdIzpK3HtXw3gSUb7CQdR0scQsm5H4Dgl5j/KPyKDX1wdh7L5bX3Sg+wmEaqG
	fcrkQLKy6/dWBtIeIKPh4EaexjNBgKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YyvOCjcmNl1vDuZvFXU8jyeuNLgLY7+ySjke5hlwQzA=;
	b=kCPo6sBG6QwSo9LPZsR3qJvVX/pjYqDmQBjID4rl87weND1R587yxrF4Ai9X5jM2nOJ9GM
	uyN1ftDUjieEt9DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728999026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YyvOCjcmNl1vDuZvFXU8jyeuNLgLY7+ySjke5hlwQzA=;
	b=MZzxgNt898VnY6KJ8vay1NW2RJwiTru42YKwUpzEI68/DCYNrmKS4paSsYn98etPxXOt0S
	VkGbg3nzpqdIzpK3HtXw3gSUb7CQdR0scQsm5H4Dgl5j/KPyKDX1wdh7L5bX3Sg+wmEaqG
	fcrkQLKy6/dWBtIeIKPh4EaexjNBgKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728999026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YyvOCjcmNl1vDuZvFXU8jyeuNLgLY7+ySjke5hlwQzA=;
	b=kCPo6sBG6QwSo9LPZsR3qJvVX/pjYqDmQBjID4rl87weND1R587yxrF4Ai9X5jM2nOJ9GM
	uyN1ftDUjieEt9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC8E913A42;
	Tue, 15 Oct 2024 13:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JjmWJ3BuDmcvcgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 15 Oct 2024 13:30:24 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [RFC PATCH 0/6] initramfs: reduce buffer footprint
Date: Tue, 15 Oct 2024 13:11:57 +0000
Message-ID: <20241015133016.23468-1-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

There are a number of stack, heap and data-segment buffers which are
unnecessary for initramfs unpacking. This patchset attempts to remove
them by:
- parsing cpio hex strings in place, instead of copying them for
  nul-termination. (Patches 1 & 2).
- reusing a single heap buffer for cpio header, file and symlink paths,
  instead of three separate buffers. (Patches 3 & 4).
- reusing the heap-allocated cpio buffer across both builtin and
  bootloader-provided unpack attempts. (Patch 5).
- reusing the heap-allocated cpio buffer for error messages on
  FSM-exit, instead of a data-segment buffer. (Patch 6).

I've flagged this as an RFC as I'd like to improve the commit messages
and also provide more thorough testing, likely via kunit / kselftest
integration.

Feedback appreciated.

David Disseldorp (6):
      vsprintf: add simple_strntoul
      initramfs: avoid memcpy for hex header fields
      initramfs: remove extra symlink path buffer
      initramfs: merge header_buf and name_buf
      initramfs: reuse buf for built-in and bootloader initramfs
      initramfs: avoid static buffer for error message

 include/linux/kstrtox.h |  1 +
 init/initramfs.c        | 50 +++++++++++++++++++++--------------------
 lib/vsprintf.c          |  7 ++++++
 3 files changed, 34 insertions(+), 24 deletions(-)


