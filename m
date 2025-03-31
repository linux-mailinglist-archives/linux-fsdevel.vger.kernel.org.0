Return-Path: <linux-fsdevel+bounces-45350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800FA767A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1943A9BCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B48211A15;
	Mon, 31 Mar 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0HvSXz7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubplYIP/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0HvSXz7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ubplYIP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471F63234
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Mar 2025 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430762; cv=none; b=RPy0mlAE40DbnVNsAmn83HiUUZGg8eBfJX1SdDA6utBtuuBSoEOijErxlxejiN3ON240NReXOTEJEAfRZtOUgVmkeqonctwatmQikrnTtmFPWHlONQsa6iU9dhmOqzzlzJhyBmkJnigEhIyV0GbtI5880v3TAOnZ9s+HPoxsURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430762; c=relaxed/simple;
	bh=k0TDY1ZQdyTe+8KzMniQ0qimMoe9GSg/UWYNVMGdq9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=azY0c8yur+O0+FiTTTshpKV4ABjMLuZye4TSQsW51XLg0z+U/RrvXY7KMmZ1dvotCBWs8ov8cohDdOBuOLxLru0elhl9XOSMSybfhzNCoIo7tZ7gSXuco9GF14iPfhsTrh7/iRuh0u+xwqkzKrdT9403Fp5CyyLQhSPmJ1QRWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0HvSXz7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubplYIP/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0HvSXz7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ubplYIP/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F176211C6;
	Mon, 31 Mar 2025 14:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743430759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SEgex3dSVWCI8cpNg8uiIkrN/iIq3bM7AWwNTU7EIq0=;
	b=0HvSXz7pX8A/2yrpBmAMXmOf9ZGY26fIIL5gr5ZntuF8m+JlirY1vinnxKQKDyaJM2Fukx
	lwusoPCebGCH3EP5ABFdAF2REGhhfGG6mak9bSn3NTEPjuXLKxWAmyrgMEjEJfgydUDT//
	3ra0En0l68HpakVDooDdLxY8yYjDjKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743430759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SEgex3dSVWCI8cpNg8uiIkrN/iIq3bM7AWwNTU7EIq0=;
	b=ubplYIP/VVwQIqdZjATByVfkgZVJYFwlFXCiC+l3n/NMg1PQrAla6mH3zycFrLAbAs5oui
	5gxDLBPyZUKj+PBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0HvSXz7p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="ubplYIP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743430759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SEgex3dSVWCI8cpNg8uiIkrN/iIq3bM7AWwNTU7EIq0=;
	b=0HvSXz7pX8A/2yrpBmAMXmOf9ZGY26fIIL5gr5ZntuF8m+JlirY1vinnxKQKDyaJM2Fukx
	lwusoPCebGCH3EP5ABFdAF2REGhhfGG6mak9bSn3NTEPjuXLKxWAmyrgMEjEJfgydUDT//
	3ra0En0l68HpakVDooDdLxY8yYjDjKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743430759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=SEgex3dSVWCI8cpNg8uiIkrN/iIq3bM7AWwNTU7EIq0=;
	b=ubplYIP/VVwQIqdZjATByVfkgZVJYFwlFXCiC+l3n/NMg1PQrAla6mH3zycFrLAbAs5oui
	5gxDLBPyZUKj+PBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33E17139A1;
	Mon, 31 Mar 2025 14:19:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oYqjDGek6mcKNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Mar 2025 14:19:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 823BFA08CF; Mon, 31 Mar 2025 16:19:14 +0200 (CEST)
Date: Mon, 31 Mar 2025 16:19:14 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] ext2, udf, and isofs fixes and improvements for 6.15-rc1
Message-ID: <dsr7ciqsadlveg2lf3zivliyqrmicj3l7crjtvao5hsakpzpbj@pjtvahqcdyln>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 3F176211C6
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.15-rc1

to get:
* conversion of ext2 to the new mount API
* small folio conversion work for ext2
* a fix of an unexpected return value in udf in inode_getblk()
* a fix of handling of corrupted directory in isofs

Top of the tree is 6afdc60ec30b. The full shortlog is:

Eric Sandeen (2):
      ext2: convert to the new mount API
      ext2: create ext2_msg_fc for use during parsing

Jan Kara (2):
      ext2: Make ext2_params_spec static
      udf: Fix inode_getblk() return value

Matthew Wilcox (Oracle) (1):
      ext2: Remove reference to bh->b_page

Qasim Ijaz (1):
      isofs: fix KMSAN uninit-value bug in do_isofs_readdir()

The diffstat is

 fs/ext2/ext2.h  |   1 +
 fs/ext2/super.c | 595 +++++++++++++++++++++++++++++++-------------------------
 fs/isofs/dir.c  |   3 +-
 fs/udf/inode.c  |   1 +
 4 files changed, 337 insertions(+), 263 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

