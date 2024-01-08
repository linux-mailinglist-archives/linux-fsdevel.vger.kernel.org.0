Return-Path: <linux-fsdevel+bounces-7567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E54EF8278B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 20:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CED81F23C37
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 19:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06E54BD6;
	Mon,  8 Jan 2024 19:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vy+cdG2P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kCGcH/aI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vy+cdG2P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kCGcH/aI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB753811
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E642A1FD13;
	Mon,  8 Jan 2024 19:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704743358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OjroM4OHh+8JRSfvmPdfowL2fhdsrdr8/n26E8Z0AdI=;
	b=Vy+cdG2PnVGxyADuR6HR453dZmZdBLZCoLRD15Jf0TtnSqTOeBfT+DriLeZ/R8+tBJcZtE
	WT7XT+whfvquC6dRtal/zU8LsgomMzL4nXAXTNRriBpUiIv6W+axaqa4/V4gSgzX1UEj5T
	HqPgYAYio7aM1CuATj87GRo2DY/V0bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704743358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OjroM4OHh+8JRSfvmPdfowL2fhdsrdr8/n26E8Z0AdI=;
	b=kCGcH/aIUFniXa53cDBm2HCSTmdudxaDNLbxYDgRiEhpHutDZnLJVop9HHg9qgaeh7E14K
	d52N0T6SJJVatICw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704743358; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OjroM4OHh+8JRSfvmPdfowL2fhdsrdr8/n26E8Z0AdI=;
	b=Vy+cdG2PnVGxyADuR6HR453dZmZdBLZCoLRD15Jf0TtnSqTOeBfT+DriLeZ/R8+tBJcZtE
	WT7XT+whfvquC6dRtal/zU8LsgomMzL4nXAXTNRriBpUiIv6W+axaqa4/V4gSgzX1UEj5T
	HqPgYAYio7aM1CuATj87GRo2DY/V0bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704743358;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=OjroM4OHh+8JRSfvmPdfowL2fhdsrdr8/n26E8Z0AdI=;
	b=kCGcH/aIUFniXa53cDBm2HCSTmdudxaDNLbxYDgRiEhpHutDZnLJVop9HHg9qgaeh7E14K
	d52N0T6SJJVatICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DA2F13686;
	Mon,  8 Jan 2024 19:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DA3aBb5RnGXVJgAAD6G6ig
	(envelope-from <krisman@suse.de>); Mon, 08 Jan 2024 19:49:18 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] unicode updates
Date: Mon, 08 Jan 2024 16:49:15 -0300
Message-ID: <87y1czr4g4.fsf@mailhost.krisman.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[27.18%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git tags/unicode-next-6.8

for you to fetch changes up to b837a816b36fae45f27d75d9bdeb1b5b9d16a53c:

  MAINTAINERS: update unicode maintainer e-mail address (2024-01-08 16:43:06 -0300)

----------------------------------------------------------------
unicode updates

Other than the update to MAINTAINERS, this PR has only a fix to stop
ecryptfs from inadvertently mounting case-insensitive filesystems that
it cannot handle, which would otherwise caused post-mount failures.  It
has been on linux-next for the past month and a half.

As a side note, the optimization to the case-insensitive comparison code
that you suggested, and the negative dentry support are still on the
list, and were postponed to the next release.

----------------------------------------------------------------
Gabriel Krisman Bertazi (2):
      ecryptfs: Reject casefold directory inodes
      MAINTAINERS: update unicode maintainer e-mail address

 MAINTAINERS         | 2 +-
 fs/ecryptfs/inode.c | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
Gabriel Krisman Bertazi

