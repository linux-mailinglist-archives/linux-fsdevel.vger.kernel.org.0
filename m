Return-Path: <linux-fsdevel+bounces-56346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA9AB1635B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 17:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8CC3A901C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 15:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E962DC349;
	Wed, 30 Jul 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1WyrF2JC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hotsDX9u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1WyrF2JC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hotsDX9u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD02DC323
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 15:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888130; cv=none; b=j99Zmf95RaOtm9LiyXzH31B7Yee8yU6o9IrvvaCZkIrxcVR3TOUZ0WLPoKFeplqK54fZYqL/mEuW7E+OT68s7PoZdNyHRQ1Dqt1Tlhk1ASXEweWDrvODTRpU0ggJ+ErGjOZ7+sb59tnWWlyueOVNKw3epZlX5cMsM8HdNvizgeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888130; c=relaxed/simple;
	bh=+SSoOsTfsYWZSq6cZ0wzjuPbI8glhbvc7m9HYZbTTIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N9PuWrlJaoIBx8RjeMVvnubRXXGB7gk6o6fslV1+bgzlPnGkkNFbyIHNaa2DiJrJ8vNVAAUIZDFn5VhemgAOHxaLmH2oDZi7k2ryNVhX1L2SEUTkUVNkeUA90Lm93nfoyY8SaY+HnAGyQXFEmtveORbH8DFYkMix6mgU4YrdK+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1WyrF2JC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hotsDX9u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1WyrF2JC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hotsDX9u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95C56218F6;
	Wed, 30 Jul 2025 15:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753888126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=34HCFjt6PbilsOREkuu08n2TYZ8+CCDC3GavRv98GG4=;
	b=1WyrF2JCpKey4cqUWAIZMRdzR28iBEaquHK4wAXflG/UoMA5TVn8LblZ05LwuwUtBSAilc
	A6hfvsGFklqOsXFd5A9CiC+Vd/pmYzhnpf+QtQQmgXem8p8BVhML5+UKPgZdMofoCJu62U
	iYbeL5T/CnqfTZxnW1Mt/rvDFnERDN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753888126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=34HCFjt6PbilsOREkuu08n2TYZ8+CCDC3GavRv98GG4=;
	b=hotsDX9u+qZkJJ9XMlm2dqucnDxF5ODRsK4zzsO667MWJ7cQj3wI6HTrQwIf7avUAIBP99
	63hqpvY4ZtOyA0Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753888126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=34HCFjt6PbilsOREkuu08n2TYZ8+CCDC3GavRv98GG4=;
	b=1WyrF2JCpKey4cqUWAIZMRdzR28iBEaquHK4wAXflG/UoMA5TVn8LblZ05LwuwUtBSAilc
	A6hfvsGFklqOsXFd5A9CiC+Vd/pmYzhnpf+QtQQmgXem8p8BVhML5+UKPgZdMofoCJu62U
	iYbeL5T/CnqfTZxnW1Mt/rvDFnERDN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753888126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=34HCFjt6PbilsOREkuu08n2TYZ8+CCDC3GavRv98GG4=;
	b=hotsDX9u+qZkJJ9XMlm2dqucnDxF5ODRsK4zzsO667MWJ7cQj3wI6HTrQwIf7avUAIBP99
	63hqpvY4ZtOyA0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87BAD13942;
	Wed, 30 Jul 2025 15:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UOIbIX41imi9WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 30 Jul 2025 15:08:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3FA34A094F; Wed, 30 Jul 2025 17:08:42 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:08:42 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fsnotify changes for
Message-ID: <cuham6fzykm3oqiribmsu7fllvyzdanyqhqel3hf4z2jl4klpi@toj7mqyg3qbe>
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
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.17-rc1

to get a couple of small improvements for fsnotify subsystem. The most
interesting is probably Amir's change modifying the meaning of fsnotify
fmode bits (and I spell it out specifically because I know you care about
those).  There's no change for the common cases of no fsnotify watches or
no permission event watches. But when there are permission watches (either
for open or for pre-content events) but no FAN_ACCESS_PERM watch (which
nobody uses in practice) we are now able optimize away unnecessary cache
loads from the read path.

Top of the tree is 0d4c4d4ea443. The full shortlog is:

Amir Goldstein (3):
      fanotify: sanitize handle_type values when reporting fid
      fsnotify: merge file_set_fsnotify_mode_from_watchers() with open perm hook
      fsnotify: optimize FMODE_NONOTIFY_PERM for the common cases

Brahmajit Das (1):
      samples: fix building fs-monitor on musl systems

The diffstat is

 fs/file_table.c               |  2 +-
 fs/notify/fanotify/fanotify.c |  8 +++-
 fs/notify/fsnotify.c          | 87 ++++++++++++++++++++++++++-----------------
 fs/open.c                     |  6 +--
 include/linux/fs.h            | 12 +++---
 include/linux/fsnotify.h      | 35 +++--------------
 samples/fanotify/fs-monitor.c |  7 ++++
 7 files changed, 82 insertions(+), 75 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

