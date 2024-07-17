Return-Path: <linux-fsdevel+bounces-23832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E660C933F3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7932846B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AF4181B89;
	Wed, 17 Jul 2024 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v3z3X5zX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6jm8PT9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v3z3X5zX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y6jm8PT9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3817FABC
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721228799; cv=none; b=rfmVz5Y1jfu4ExPbe2RF8R0SmvoY+Jw5JVH7W+nbAIMQcpGvgDsjzDp0QkgMNitiwp6fepXe38grTfr9hV4A6QxzJnb7h5C5oJKBTaK//a2lm4diCrsTi3eFTGTneF3BBE5yI169Nd6FHY9A49E7R/GhDs+BTo66nihDQp7hVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721228799; c=relaxed/simple;
	bh=9bhEBF47crWbzcwB/xC+YB0sTTgLSOb4CF/AhNHyQLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T6ORaTEt1s2hAkKvF6aKS+v+IYd2x7NZnoa6a7evmR2ubAx05z/7MkJmdYoKdaerqUGH66yGbG1KPiSijwpioLoPnpff0G4/4ZMemMluL42qpsIZknOgR/mmCGfEg1Bh5R3gDxM6XqOGr+7dwBePJJACHpKjLIxPy3d8Yq0ccBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v3z3X5zX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6jm8PT9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v3z3X5zX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y6jm8PT9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8119721A75;
	Wed, 17 Jul 2024 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721228796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=puouZ3lClwqYZ246KPUoqhsQLT1S1Em1Yv/TCPpNSns=;
	b=v3z3X5zXsUExoMkLzWTgZsEb4J+SAGpKXHnzULFZlmdg7J17wwAS+a/ql7gYQ23fSsyWHX
	WYIiIXBuZuVmJ6vtsCUWRXnkhZ5qIzSzd7Ts76fVdkAu+GuoW+v2HvvteVhQh/MY04LRmX
	FsVn7H4RLbFEnCH2Gq7v2JKS1Wr3xMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721228796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=puouZ3lClwqYZ246KPUoqhsQLT1S1Em1Yv/TCPpNSns=;
	b=Y6jm8PT92bg0ymx61+RO8extL5uc3C+U0mnNRGhyd47SqkN0JcqfX8lU7x7GNYOJuYK3cU
	RN0bx4N+RRhp8aCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v3z3X5zX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y6jm8PT9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721228796; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=puouZ3lClwqYZ246KPUoqhsQLT1S1Em1Yv/TCPpNSns=;
	b=v3z3X5zXsUExoMkLzWTgZsEb4J+SAGpKXHnzULFZlmdg7J17wwAS+a/ql7gYQ23fSsyWHX
	WYIiIXBuZuVmJ6vtsCUWRXnkhZ5qIzSzd7Ts76fVdkAu+GuoW+v2HvvteVhQh/MY04LRmX
	FsVn7H4RLbFEnCH2Gq7v2JKS1Wr3xMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721228796;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=puouZ3lClwqYZ246KPUoqhsQLT1S1Em1Yv/TCPpNSns=;
	b=Y6jm8PT92bg0ymx61+RO8extL5uc3C+U0mnNRGhyd47SqkN0JcqfX8lU7x7GNYOJuYK3cU
	RN0bx4N+RRhp8aCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77275136E5;
	Wed, 17 Jul 2024 15:06:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FxYPHfzdl2adFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 15:06:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 24C83A0987; Wed, 17 Jul 2024 17:06:36 +0200 (CEST)
Date: Wed, 17 Jul 2024 17:06:36 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify fix for 6.11-rc1
Message-ID: <20240717150636.salwxlk5v64tffzk@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 8119721A75
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.11-rc1

to get a fix of possible softlockups on directories with many dentries in
fsnotify code.

Top of the tree is 172e422ffea2. The full shortlog is:

Amir Goldstein (1):
      fsnotify: clear PARENT_WATCHED flags lazily

The diffstat is

 fs/notify/fsnotify.c             | 31 +++++++++++++++++++++----------
 fs/notify/fsnotify.h             |  2 +-
 fs/notify/mark.c                 | 32 +++++++++++++++++++++++++++++---
 include/linux/fsnotify_backend.h |  8 +++++---
 4 files changed, 56 insertions(+), 17 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

