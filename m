Return-Path: <linux-fsdevel+bounces-70059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0DFC8FB40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9D5F4E86BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C572EC086;
	Thu, 27 Nov 2025 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="w/YoJXly";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uz+yc0mc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iHx7G7dd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHq8OEh8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D672D5408
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264647; cv=none; b=U/vriKKNSHhXXAmevB/Nu09oXP0RSz3z12P0DE+Ey17VSMmaoXoXkYAdJLBis29Tlgz/H+LF0AJwPLx9FxBbIoIEIWqEB4mI29/4tXHX0rKYO/iqD4V+rxmGOUztfrcH6/51UPkr4S+fanXRWtoAGSwnbZkegtr51/DdGpLgOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264647; c=relaxed/simple;
	bh=Qg8P0uHVJCMwi/lDF2G61okIXpH/uiFoAvGwkI0/MpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUKMI9tlFBTlBHMcodwFH7CKxY2tJQiioe5WHnUjETMLHtz7i8tkIo97ea2o5tjtm15Y5nXPEENWufgzvqHF3hxUsramML+9HQGyol8sAMuX1Htu18sAwHdd2uxUqxVlaGSqZMEEqDwO1wfkjpBVLBnteCviWcieCPT7fxvKxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=w/YoJXly; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uz+yc0mc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iHx7G7dd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHq8OEh8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D24525BCCE;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lBNYMHYaLpKXlMU4Qq3yNbOu49UJHKIidY4vJ586HkU=;
	b=w/YoJXlyWKV/x4kTcgybGcb5hO5UPhpd8rCa2uHTV4wQprapbgNVWuywYYjnW8wzBPRHua
	bXlgPwPvjhMWMu/ufXuyqqo0i0m6Q7wnYQEs3wb5le3vdQrdXU93erIWAk/Da7kQ6NsizF
	paKMyIg/VqiQg2Kp6c7NTlQg7C8ne+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lBNYMHYaLpKXlMU4Qq3yNbOu49UJHKIidY4vJ586HkU=;
	b=uz+yc0mc6C3qku4Ybq09Bp+3HFJopZVw5NQxHw/Wo2Y0V3OOB1VRG1dFnYb62aB0jiG27g
	6sXrz3Gh5wziNhDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iHx7G7dd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HHq8OEh8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lBNYMHYaLpKXlMU4Qq3yNbOu49UJHKIidY4vJ586HkU=;
	b=iHx7G7ddsh1MEzaUXMMxdYSc5dOpv+RbwvtISkAUG65SWlYeLs3f4yNhn3MhQLY+nBMksq
	pM8os6KVASgVGIQj5OhJcpj8F20r0Q20XH4gHvQYGfcSZlaL8iep3de/SyKhF2YMDEak5o
	bmgfH+m9LjmQm072GGCJOD1e2pDZA6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lBNYMHYaLpKXlMU4Qq3yNbOu49UJHKIidY4vJ586HkU=;
	b=HHq8OEh8AY1n+URi7WXOOzP1KNoJAoC7aK4zUCiR8sCHy9NMI2Gupk3qLgkDZZvTmVrOLD
	ekcQpmUq/jHTOvCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBCD13EA66;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hrOMLbGKKGl3PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 03FDBA0C92; Thu, 27 Nov 2025 18:30:24 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH RFC 0/13] fsnotify: Rework inode tracking
Date: Thu, 27 Nov 2025 18:30:07 +0100
Message-ID: <20251127170509.30139-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2245; i=jack@suse.cz; h=from:subject:message-id; bh=Qg8P0uHVJCMwi/lDF2G61okIXpH/uiFoAvGwkI0/MpA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqelGaFIBfndZdnVF8KN4TulFzNnggB2NcpV OIbWNMMfpKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKngAKCRCcnaoHP2RA 2RQSB/0Su/YRfcrhgjSIovYwn4Amv4RnnAtqiDTtKz5vKakZ5OKtifFWU45kd2fa1vxihT4QK0+ QjznZVUkuVUIEH1damrMolo2LhJDMmZaTWqh8ZOe4lpPofNwfUjTq9WajIEnrAodJoShJ+t/t+s AqrMzo7ujkYI5ep3kIayUoSVKeiDd+CJdtHeJH287nRiCjkoFlzVtoAFHSq02bXdBs69qbLX76x FVbZta1rDiEggvcJYTlQEiRbm8Hb5nd7QzSBycoTPtXadWMAvhgMAgywbTHSWSpQNQLQbDW0Ppu NBlR9dY5ZgqjF+2Nt+xAL/9zftxdwteP/lhtSZRr41aIJKmt
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D24525BCCE
X-Rspamd-Action: no action
X-Spam-Flag: NO

Hello!

This patch set reworks how fsnotify subsystem tracks inodes. So far we have
held inode references from notification marks (connectors of list of
notification marks to be more precise). This has three issues:

1) Placing a notification mark pins inode in memory. Since inodes are
relatively big objects, users could pin significant amount of kernel memory
by this. This then requires administrators to configure suitable limits on
maximum amount of notification marks each user can place which is cumbersome.

2) During filesystem unmount we have walk a list of all inodes for the
superblock to drop these inode references. This is either slow (when we do
it before evicting all other inodes) or opens nasty races (when fsnotify()
can run after dcache for the superblock has been evicted).

3) Since sb global inode list is a noticeable contention point we are trying
to transition its users to something else so that we can eventually get rid
of it.

In this patch set, fsnotify subsystem tracks notification marks attached to
inodes in a specialrhashtable indexed by inode identifier. This way we can stop
holding inode references and instead disconnect notification marks from the
inode on inode eviction (and reconnect them when inode gets loaded into memory
again). Credit for the original idea of this tracking actually goes to Dave
Chinner.

The patches are so far incomplete - I still need to implement proper handling
for filesystems where inode number isn't enough to identify the inode. isofs
is provided as a sample how such support will look like for these filesystems.

Also we need to decide what to do with evictable notification marks. With the
patches as is they are now never evicted. This makes sense because the main
reason behind evictable marks was to avoid pinning the inode. On the other
hand this *might* surprise some userspace - definitely it breaks couple of LTP
tests we have for evictable marks.

Overall the patches passed some basic testing with LTP so they shouldn't be
completely wrong but there could be bugs lurking so handle with care ;).
I'm sending the patches for comments to the approach and whether people find
this approach acceptable.

								Honza

