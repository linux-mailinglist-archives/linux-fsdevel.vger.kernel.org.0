Return-Path: <linux-fsdevel+bounces-23834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E085933F62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958D61C23060
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7757180A92;
	Wed, 17 Jul 2024 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PqQ4MZNL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iri6JgaM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dfw0YLxv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pUyywNUA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578221E495
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229400; cv=none; b=ieiqb63AI3/TLglt0EsfpI1av2NOjwJYjxqDSclHToKoQLoPXWqzwa0nnug4qowHtf3953MYBoaIRavp8d/RHYvntehDhX/swsQ987ocl6qMXs4JAuyJjGCcyI4cE/eNrTt1LNq6rRnQ5NAVut6gh/pOfRN4AwDnnsPL/Vc5v0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229400; c=relaxed/simple;
	bh=sqZagmtAdMHnCl8OIT+3AmDP06Ww0AKFNVh1iUH/mQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BwcmXY08/c8Y69eAvFUgTnODYcIkAs5WXOlw3DQoraP5qsfv+TyMXpw4YbOR2k4k/oGJSfulZ216JWroVaY9cXfCRCgya7oPzcnmzqc+gtYMWJKhGtb54kpnmDy5pZ/nVdNS9Z+aauvC8y0nzlPdNbYr2R3c33ZIZhadPTkTyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PqQ4MZNL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iri6JgaM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dfw0YLxv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pUyywNUA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 434BB1FB8C;
	Wed, 17 Jul 2024 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721229396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ty50j/m6OEsCE5snucyvRaWjLEpGx1Q3xCThNJCLFcU=;
	b=PqQ4MZNLBzaov5Q99JlUgjCs/Ndu5FAZ3149pkt+WpPyKu+rj01zCnSRvyR6Cz64goMcPi
	uU3huQTbhFPz/IpJEQKu11TMTb/aW/mZWbptTc5Rt3RiyozYOxCMldvysGSeKrTLqibvXd
	SNWbXGCT/Oz8okqvRI56JKBYc4k0EvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721229396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ty50j/m6OEsCE5snucyvRaWjLEpGx1Q3xCThNJCLFcU=;
	b=iri6JgaM43ZAvOlJ27d5tyHBu5N2arVJQM7lYzDZIcGTYO/UHXoFve0CSdFgdyTa2boCrv
	VzwW7ScawUBD34Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dfw0YLxv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pUyywNUA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721229395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ty50j/m6OEsCE5snucyvRaWjLEpGx1Q3xCThNJCLFcU=;
	b=dfw0YLxvCIq6PNALVaNUsCWk24cjIDeG4K/LfvlKrmvGsuAoGq/a5XWWGz/Zw08Cba1RRH
	Qo4NLM8QTSfI2W+dGlAEvsvJveSuQmu9Y4/UtRY17YBeFkzS+AwMrGhi9rrw0OvYdUvzGw
	FV9YFZ/0NIsBzRtPlW5+9yTUylt3/vM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721229395;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Ty50j/m6OEsCE5snucyvRaWjLEpGx1Q3xCThNJCLFcU=;
	b=pUyywNUAqwQJ6fVTale52AX9c+y57+kr8gGjwLtYwVbqlOZTS9ZA3Zy+KNfWy3xfBFeCS8
	YZEhpjBGwfRqujDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ADDC136E5;
	Wed, 17 Jul 2024 15:16:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZSUoClPgl2asFwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 15:16:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0E41A0987; Wed, 17 Jul 2024 17:16:34 +0200 (CEST)
Date: Wed, 17 Jul 2024 17:16:34 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] udf, ext2, isofs fixes and cleanups
Message-ID: <20240717151634.yc5wzy5oel7oue6h@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 434BB1FB8C
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spamd-Bar: /

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.11-rc1

to get:
  * A few UDF cleanups and fixes for handling corrupted filesystems
  * ext2 fix for handling of corrupted filesystem
  * isofs module description
  * jbd2 module description - I've mistakenly pulled this fix into my
    tree when pulling the isofs one and noticed that only a few days
    ago when Ted merged it into his tree as well. At that point I figured
    out that rebasing the tree to drop the patch would be actually
    counter-productive. I'm sorry for the complication.

Top of the tree is 322a6aff0393. The full shortlog is:

Jan Kara (7):
      udf: Drop pointless IS_IMMUTABLE and IS_APPEND check
      udf: Fix lock ordering in udf_evict_inode()
      udf: Fix bogus checksum computation in udf_rename()
      udf: Avoid using corrupted block bitmap buffer
      udf: Drop load_block_bitmap() wrapper
      udf: Avoid excessive partition lengths
      ext2: Verify bitmap and itable block numbers before using them

Jeff Johnson (2):
      jbd2: add missing MODULE_DESCRIPTION()
      isofs: add missing MODULE_DESCRIPTION()

Roman Smirnov (1):
      udf: prevent integer overflow in udf_bitmap_free_blocks()

The diffstat is

 fs/ext2/balloc.c  | 11 +++++++--
 fs/isofs/inode.c  |  1 +
 fs/jbd2/journal.c |  1 +
 fs/udf/balloc.c   | 74 ++++++++++++++++++++++---------------------------------
 fs/udf/file.c     |  2 ++
 fs/udf/inode.c    | 13 +++-------
 fs/udf/namei.c    |  2 --
 fs/udf/super.c    | 18 +++++++++++++-
 8 files changed, 63 insertions(+), 59 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

