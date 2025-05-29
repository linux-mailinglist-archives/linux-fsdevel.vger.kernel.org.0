Return-Path: <linux-fsdevel+bounces-50074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1E5AC7FEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D59117AE90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8663B21CC64;
	Thu, 29 May 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XlE63eOh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e6Q3Ric4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XlE63eOh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="e6Q3Ric4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D7F210FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530704; cv=none; b=r5sbbKm10LciidyTKkzK85HvabJs8gxdOzUv1QJ4g1aGf53+CKWrnYNkHISqTRbUh5tI+6ksxNavU6ODzgd+7XpCID2SvpftCLvV071e5SoWMYnMLEHYZNJOpiG6WUzHpHLPb3rLBPcsvY4LfwyUxSJT7tJdBOQQuea8zG+JS7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530704; c=relaxed/simple;
	bh=8Ov+hfXDEiDEZh2bCXD5sUeovZ4eKgfFUEFuwateAr0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VyuJADxbnfutSp82uuH/on7OXb4uAqNGqiEBkV5ae86uiWZXP91rFkzuUmk3tvu1dKK1KkXmBgVAfbngiS5epzifC3M22gkjdW+WENf69CuVhuSZwdE14jyQyy3WFV8fWjJeSFMb9Fe9g16pJohGn3AL11QVLYLnhUV/rKBxNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XlE63eOh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e6Q3Ric4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XlE63eOh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=e6Q3Ric4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BDE21FCE1;
	Thu, 29 May 2025 14:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748530699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=9S4RgyGqyIG1PMGn4Quoo0lCmgYZuNYny8tKWXVec+k=;
	b=XlE63eOh6fegw3/RLvZFlOyQySw/75e5ECG4HGZSl8SwaDYGlQn+8g2agThlH6PsnyRWeb
	JsA9k9O5AUJA1R68Vu8zh/Z9z92mmnI7qsIKrSOVm3B1yH0FhWrMPdz5ueJQW+E7IOhbXA
	2R64zLsYG1nyMaraptLxR4zEKMCORvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748530699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=9S4RgyGqyIG1PMGn4Quoo0lCmgYZuNYny8tKWXVec+k=;
	b=e6Q3Ric4prD7FWA3CYtmquWcqcvTQMTcXbe5EXmrfTb/Z/BII1uDCGh/6BpnaBhjB3sOcf
	uLCIGViZHuLU7vDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XlE63eOh;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=e6Q3Ric4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748530699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=9S4RgyGqyIG1PMGn4Quoo0lCmgYZuNYny8tKWXVec+k=;
	b=XlE63eOh6fegw3/RLvZFlOyQySw/75e5ECG4HGZSl8SwaDYGlQn+8g2agThlH6PsnyRWeb
	JsA9k9O5AUJA1R68Vu8zh/Z9z92mmnI7qsIKrSOVm3B1yH0FhWrMPdz5ueJQW+E7IOhbXA
	2R64zLsYG1nyMaraptLxR4zEKMCORvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748530699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=9S4RgyGqyIG1PMGn4Quoo0lCmgYZuNYny8tKWXVec+k=;
	b=e6Q3Ric4prD7FWA3CYtmquWcqcvTQMTcXbe5EXmrfTb/Z/BII1uDCGh/6BpnaBhjB3sOcf
	uLCIGViZHuLU7vDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 667AC136E0;
	Thu, 29 May 2025 14:58:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IVX+GAt2OGi+TQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 May 2025 14:58:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FEB5A09B5; Thu, 29 May 2025 16:58:04 +0200 (CEST)
Date: Thu, 29 May 2025 16:58:04 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for v6.16-rc1
Message-ID: <sfxqwp3nbyrg66yio3h3qco2ty4pwsbql6m7goid22ewkybuim@3jhjq5wfcoe3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7BDE21FCE1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.16-rc1

to get two fanotify cleanups and a support for watching namespace-owned
filesystems by namespace admins (most useful for being able to watch for
new mounts / unmounts happening within a user namespace).

Top of the tree is 58f5fbeb367f. The full shortlog is:

Amir Goldstein (2):
      fanotify: remove redundant permission checks
      fanotify: support watching filesystems and mounts inside userns

Jan Kara (1):
      fanotify: Drop use of flex array in fanotify_fh

The diffstat is

 fs/notify/fanotify/fanotify.c      |  3 ++-
 fs/notify/fanotify/fanotify.h      |  9 +++----
 fs/notify/fanotify/fanotify_user.c | 50 ++++++++++++++++++++++----------------
 include/linux/fanotify.h           |  5 ++--
 include/linux/fsnotify_backend.h   |  1 +
 5 files changed, 38 insertions(+), 30 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

