Return-Path: <linux-fsdevel+bounces-35465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A469D507C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 17:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9E91F23ADF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5C6189B9F;
	Thu, 21 Nov 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xuFRdP7M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3SvR/pjb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xuFRdP7M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3SvR/pjb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1216743ACB
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732205312; cv=none; b=oNypnb2DSHLsypnX00TwKu9wPazKBSB9569do5LZgzM34EGtCj6kOU+yw0NL4/ndiru1sGZDcBTA5lr4mvfT+AaLMSqLLz7fbMHqiizrOKC32IuxtltUeniJ0ItxhXuK56RqRsotxuXwTPkykUS6Ou2VjSZqAXjphAH7gIWIA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732205312; c=relaxed/simple;
	bh=cm0cqvd4Qc9b42FEDfxlIhR38Xr3NEldMd15gwyrEoU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eta+wFhmYtY6EsrZUUtwnXqYUKALj+MSplE6Qhi0ERvof4YzKneHtVsKYFnS3VnF+fZZmFH8mbQRt1xmhSRlapvZlQUEQYvFlWButBE/gnI5grHWchkhftd6agMKcGAUehvI9jVsPZ0p3tYQekzB2rwfJnaOVsA6//2ZIGLTBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xuFRdP7M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3SvR/pjb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xuFRdP7M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3SvR/pjb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45A1821A16;
	Thu, 21 Nov 2024 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732205309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xsnq779NoEtleqqbbttXLFohuj1Lf47F7UqlOqVY+HE=;
	b=xuFRdP7M7liuqp5gkpeeDqL65sjCoAD0IrALSf3reLZyWq9gtoEwvYjkHGAZDjgPd54lhh
	QpfbM+1UKhBa5S+0kycZ7V4XW4m8WERbcSi44iA0JncMYT2sxhkixAobmrBYGN5zrAxSGi
	4AZgSVp0EJ8hcoEdotypL2eq57/YDQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732205309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xsnq779NoEtleqqbbttXLFohuj1Lf47F7UqlOqVY+HE=;
	b=3SvR/pjbi2BZcXj5gr7oo6kfywixZ4v6P9f2FJ9eepjAvTI5z9cvlilKUt1XmAcddkeLAc
	/rOGZPjD9FwN9rDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732205309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xsnq779NoEtleqqbbttXLFohuj1Lf47F7UqlOqVY+HE=;
	b=xuFRdP7M7liuqp5gkpeeDqL65sjCoAD0IrALSf3reLZyWq9gtoEwvYjkHGAZDjgPd54lhh
	QpfbM+1UKhBa5S+0kycZ7V4XW4m8WERbcSi44iA0JncMYT2sxhkixAobmrBYGN5zrAxSGi
	4AZgSVp0EJ8hcoEdotypL2eq57/YDQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732205309;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=xsnq779NoEtleqqbbttXLFohuj1Lf47F7UqlOqVY+HE=;
	b=3SvR/pjbi2BZcXj5gr7oo6kfywixZ4v6P9f2FJ9eepjAvTI5z9cvlilKUt1XmAcddkeLAc
	/rOGZPjD9FwN9rDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 371A713927;
	Thu, 21 Nov 2024 16:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id csEwDf1aP2dfWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 16:08:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E26C7A08A2; Thu, 21 Nov 2024 17:08:28 +0100 (CET)
Date: Thu, 21 Nov 2024 17:08:28 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for 6.13-rc1
Message-ID: <20241121160828.xlapwqicwo745kpa@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.982];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.13-rc1

to get a couple of smaller random fsnotify fixes. The HSM patches were not
ready in time so they'll have to wait another cycle.

Top of the tree is 21d1b618b6b9. The full shortlog is:

Amir Goldstein (2):
      fanotify: allow reporting errors on failure to open fd
      fsnotify: fix sending inotify event with unexpected filename

Jann Horn (1):
      fsnotify: Fix ordering of iput() and watched_objects decrement

Song Liu (1):
      fsnotify, lsm: Decouple fsnotify from lsm

The diffstat is

 fs/notify/fanotify/Kconfig         |  1 -
 fs/notify/fanotify/fanotify_user.c | 85 +++++++++++++++++++++-----------------
 fs/notify/fsnotify.c               | 23 ++++++-----
 fs/notify/mark.c                   | 12 ++++--
 fs/open.c                          |  4 ++
 include/linux/fanotify.h           |  1 +
 include/uapi/linux/fanotify.h      |  1 +
 security/security.c                |  9 +---
 8 files changed, 77 insertions(+), 59 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

