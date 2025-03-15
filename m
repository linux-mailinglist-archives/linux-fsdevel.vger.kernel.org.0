Return-Path: <linux-fsdevel+bounces-44115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C091BA62A80
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 10:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C4C17B9C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D901F4E38;
	Sat, 15 Mar 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mzlbx5B1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3dxlJOl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mzlbx5B1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F3dxlJOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5C72E3388
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Mar 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742032340; cv=none; b=Dtn5EzyJlIVQRmmDGj6s9r2K+MoJNF7P2eGVT+NUVPKQlLj0XyLhFDlaMBc7PF0QUSEynqqX9at/gqvAMapmgXfw90xspsSuluvYNAcUEKE4nnHGbw6rPbENHbc6WEWctpfZrXJaRbrCeHJEvn2BsQ+9NjgPbQFByCtSgd2gyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742032340; c=relaxed/simple;
	bh=sAbq3egKjXjF4vsZBAbrILgR+e5oMyj/citJg8QjxzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ql7PsWlPB1THyDnSdalPXEzZFMp2MW7kkOXMmNFoXG+/Tm5nklcZ6n0EeafgXvqrNrxsfurFO82ttisHhBTkvxnHVWdsOYQ9TeHskr6p7ik32WLoZ5JRxAuOe5Uxm7G4laOhGOCCr7sJ8Fblosi4JbKg0CjXH+OGz1P+d+JTIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mzlbx5B1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F3dxlJOl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mzlbx5B1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F3dxlJOl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C69721163;
	Sat, 15 Mar 2025 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742032337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=4fi9rOk6SFzXgr4oSxL5lxgWRiHmEx8/nmYlO+KBak4=;
	b=mzlbx5B1hRlI2VHZ7KhdKbUR+hhZTR9LBaAcW8FZqpT4szScE6rNxHkRk4kHj9bpjswpjV
	QX1qESKQrFghcCMlIZH9j874kWuLlOI78yXhmrIKQFoqQlLbbpxfJefPNipi/7HYSxuB2g
	w7FtkBXnsBpE9SNbkyxt+mITCZoobXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742032337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=4fi9rOk6SFzXgr4oSxL5lxgWRiHmEx8/nmYlO+KBak4=;
	b=F3dxlJOlc1e1oecJYm8V2Huv7+Pw1UlTaphnku+JWhjGQSYyh9YFy41uwHa/qH7q5FCeA3
	h8ttYZphPP/RM1CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742032337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=4fi9rOk6SFzXgr4oSxL5lxgWRiHmEx8/nmYlO+KBak4=;
	b=mzlbx5B1hRlI2VHZ7KhdKbUR+hhZTR9LBaAcW8FZqpT4szScE6rNxHkRk4kHj9bpjswpjV
	QX1qESKQrFghcCMlIZH9j874kWuLlOI78yXhmrIKQFoqQlLbbpxfJefPNipi/7HYSxuB2g
	w7FtkBXnsBpE9SNbkyxt+mITCZoobXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742032337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=4fi9rOk6SFzXgr4oSxL5lxgWRiHmEx8/nmYlO+KBak4=;
	b=F3dxlJOlc1e1oecJYm8V2Huv7+Pw1UlTaphnku+JWhjGQSYyh9YFy41uwHa/qH7q5FCeA3
	h8ttYZphPP/RM1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE77139B0;
	Sat, 15 Mar 2025 09:52:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DTc+B9FN1Wd5WQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 15 Mar 2025 09:52:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEAA9A09A8; Sat, 15 Mar 2025 10:52:16 +0100 (CET)
Date: Sat, 15 Mar 2025 10:52:16 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: [GIT PULL] fsnotify: Revert HSM events on page fault
Message-ID: <jk4xlwczp2ydzxbib4fi5lfdlclebpexgy7ilds37dptjpmpmh@f2ctckma34ke>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.14-rc7

Syzbot has found out that fsnotify HSM events generated on page fault can
be generated while we already hold freeze protection for the filesystem
(when you do buffered write from a buffer which is mmapped file on the same
filesystem) which violates expectations for HSM events and could lead to
deadlocks of HSM clients with filesystem freezing. Since it's quite late in
the cycle we've decided to revert changes implementing HSM events on page
fault for now and instead just generate one event for the whole range on
mmap(2) so that HSM client can fetch the data at that moment.

Top of the tree is 252256e416de. The full shortlog is:

Amir Goldstein (6):
      fsnotify: add pre-content hooks on mmap()
      Revert "ext4: add pre-content fsnotify hook for DAX faults"
      Revert "xfs: add pre-content fsnotify hook for DAX faults"
      Revert "fsnotify: generate pre-content permission event on page fault"
      Revert "mm: don't allow huge faults for files with pre content watches"
      Revert "fanotify: disable readahead if we have pre-content watches"

The diffstat is

 fs/ext4/file.c           |  3 --
 fs/xfs/xfs_file.c        | 13 --------
 include/linux/fsnotify.h | 21 ++++++++++++
 include/linux/mm.h       |  1 -
 mm/filemap.c             | 86 ------------------------------------------------
 mm/memory.c              | 19 -----------
 mm/nommu.c               |  7 ----
 mm/readahead.c           | 14 --------
 mm/util.c                |  3 ++
 9 files changed, 24 insertions(+), 143 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

