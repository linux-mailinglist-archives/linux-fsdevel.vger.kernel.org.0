Return-Path: <linux-fsdevel+bounces-19781-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D69448C9C1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4DC1F2271E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304E5535CE;
	Mon, 20 May 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N2uJWFXI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D8HOPDJP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N2uJWFXI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D8HOPDJP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB8468E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716204878; cv=none; b=C+ze8zAKlQ9y5Qkn5s9OLiOskwM1UM7+2mBp3/VtdzXxV4Mr6s4u3zd7Gw2hGlH3R/NXMnHyRtWV8WkXSpvimUG6m5kXBvGkLsztOk0GJXTt3LEpENqdiQA2GXwnofZ+dyu4Qqkhv+Ob6eNCEEm1gfltNkqHpt2LCmvrMxqsfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716204878; c=relaxed/simple;
	bh=HU9TqxO7BFqfmTPxWvzSVnKjDqbqFcHwyZ6N5kXXslw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YBTkPeb9i7Oj7tiahYdtDSSbLNaw2LQ+0kYqpbwZLPjf9EEfA30HCKXp/H69SPYZgwAw+5chFo1zZS9nwrgO1tWTv3l37B39w5pWhj3nu86hUiEL3Yte5ywitqF5hxGP3Jt/h1Wd9FK+93EtDm9JE743PJhAA/ZbsWeQHvePBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N2uJWFXI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D8HOPDJP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N2uJWFXI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D8HOPDJP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21B2021F6B;
	Mon, 20 May 2024 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716204869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ZO800y7trylKMlLQA3CCho/tm3q0KH+Te9WvrLzIBeI=;
	b=N2uJWFXInHjLuWsNAwLearvKlQYqqdgAvJlYPSfiMkInyJEXS6A/Ie7mS1QFB7vxrULcyn
	64y4Zo2oU4O4Hc8Rtbbt1EZ3oGoxEDCjQy3vk3/OblNQnnsdm7OGQyoyPAtM5I5ZRpEXxb
	yuTyMn3NAby5qPBhfkkmXQ0ux79+Q8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716204869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ZO800y7trylKMlLQA3CCho/tm3q0KH+Te9WvrLzIBeI=;
	b=D8HOPDJPuDQeQplCtv+LSCqTkcDf46mrTFcPvh6SQcZKr6YlEhYa8Pcg0FXxS3MXcW8omd
	PVxVLxBRhUpPFABQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716204869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ZO800y7trylKMlLQA3CCho/tm3q0KH+Te9WvrLzIBeI=;
	b=N2uJWFXInHjLuWsNAwLearvKlQYqqdgAvJlYPSfiMkInyJEXS6A/Ie7mS1QFB7vxrULcyn
	64y4Zo2oU4O4Hc8Rtbbt1EZ3oGoxEDCjQy3vk3/OblNQnnsdm7OGQyoyPAtM5I5ZRpEXxb
	yuTyMn3NAby5qPBhfkkmXQ0ux79+Q8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716204869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=ZO800y7trylKMlLQA3CCho/tm3q0KH+Te9WvrLzIBeI=;
	b=D8HOPDJPuDQeQplCtv+LSCqTkcDf46mrTFcPvh6SQcZKr6YlEhYa8Pcg0FXxS3MXcW8omd
	PVxVLxBRhUpPFABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17C6F13A6B;
	Mon, 20 May 2024 11:34:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pT/OBUU1S2a7EgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 May 2024 11:34:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6E17A08D8; Mon, 20 May 2024 13:34:28 +0200 (CEST)
Date: Mon, 20 May 2024 13:34:28 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] isofs, udf, quota, ext2, reiserfs changes for 6.10-rc1
Message-ID: <20240520113428.ckwzn5kh75mmjxo3@quack3>
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.10-rc1

to get:
  * convertion of isofs to the new mount API
  * cleanup of isofs Makefile
  * udf conversion to folios
  * some other small udf cleanups and fixes
  * ext2 cleanups
  * removal of reiserfs .writepage method
  * update reiserfs README file

Top of the tree is 1dd719a95979. The full shortlog is:

Andy Shevchenko (1):
      isofs: Use *-y instead of *-objs in Makefile

Chao Yu (1):
      quota: fix to propagate error of mark_dquot_dirty() to caller

Colin Ian King (1):
      udf: Remove second semicolon

Eric Sandeen (1):
      isofs: convert isofs to use the new mount API

Jan Kara (1):
      reiserfs: Trim some README bits

Justin Stitt (1):
      udf: replace deprecated strncpy/strcpy with strscpy

Kefeng Wang (1):
      fs: quota: use group allocation of per-cpu counters API

Matthew Wilcox (Oracle) (10):
      reiserfs: Convert to writepages
      udf: Convert udf_symlink_filler() to use a folio
      udf: Convert udf_write_begin() to use a folio
      udf: Convert udf_expand_file_adinicb() to use a folio
      udf: Convert udf_adinicb_readpage() to udf_adinicb_read_folio()
      udf: Convert udf_symlink_getattr() to use a folio
      udf: Convert udf_page_mkwrite() to use a folio
      udf: Use a folio in udf_write_end()
      ext2: Remove call to folio_set_error()
      isofs: Remove calls to set/clear the error flag

Ritesh Harjani (IBM) (2):
      ext2: set FMODE_CAN_ODIRECT instead of a dummy direct_IO method
      ext2: Remove LEGACY_DIRECT_IO dependency

Roman Smirnov (1):
      udf: udftime: prevent overflow in udf_disk_stamp_to_time()

The diffstat is

 fs/ext2/Kconfig     |   1 -
 fs/ext2/dir.c       |   1 -
 fs/ext2/file.c      |   8 +-
 fs/ext2/inode.c     |   2 -
 fs/isofs/Makefile   |   7 +-
 fs/isofs/compress.c |   4 -
 fs/isofs/inode.c    | 473 ++++++++++++++++++++++++++--------------------------
 fs/quota/dquot.c    |  33 ++--
 fs/reiserfs/README  |  16 +-
 fs/reiserfs/inode.c |  16 +-
 fs/udf/file.c       |  20 +--
 fs/udf/inode.c      |  65 ++++----
 fs/udf/super.c      |   8 +-
 fs/udf/symlink.c    |  34 ++--
 fs/udf/udftime.c    |  11 +-
 15 files changed, 346 insertions(+), 353 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

