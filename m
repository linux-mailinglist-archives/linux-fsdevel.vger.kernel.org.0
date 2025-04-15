Return-Path: <linux-fsdevel+bounces-46450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8FCA898EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35B8176C22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F93428E5E3;
	Tue, 15 Apr 2025 09:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AMQCIOoS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LdBtyvZJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AMQCIOoS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LdBtyvZJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4D4289343
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710915; cv=none; b=ACvi8/XwKe6MSGLA66C07iVw/+a0ljELHSRidGNwDr5z3oE4zlREYRBBcs5Bd5DxejMFDW0JKn1wc2tOwA1QSB7k6HrJSwfHj+y6VRI3XAeivnCqMOWViQENakB5Gn2fQA6RjPGNV5ckqgMd+wA09C5eXWV2ppsRl1pzEifaeFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710915; c=relaxed/simple;
	bh=njD3ISegxNbymtHfRWIQTuEwW9RcypKapGddIPELcDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pvgm1NevusOH2nMem5yYqoBHjsSFEsHAw1MUbQlnfp34zJTScZ75zlQjNlat+9AJVgZy4al190cQ1MK8JWSfd6UxrxaXOZS1MK9ZX5pGVH8RCamS7nVsVDfPXzLwd9CF3w3scz0n948D+p5zmwBROM1+dS/tXdxajLFmqYIlI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AMQCIOoS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LdBtyvZJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AMQCIOoS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LdBtyvZJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D4DE1F387;
	Tue, 15 Apr 2025 09:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744710912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=qCFPGMja1AceTmlB/CFsu2BSzugnzzImFHyb/tYFjvs=;
	b=AMQCIOoSkSCJw4olcO9eZxYCgOqOkTmBTgwDbxggaSzZZelFxhiBwKOvpvz2pGhzP+XyCB
	7JZl/mL43b5jlcd/e00wGKRLMO1hGlRCuhSNVzG+nKU0P9sPxzKY9Xg2vvBJWV8K17VROM
	fU+BGc1gmal2j1PHYfNPgtAd97EOvvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744710912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=qCFPGMja1AceTmlB/CFsu2BSzugnzzImFHyb/tYFjvs=;
	b=LdBtyvZJ6atro4SxcLVyZOSAPuuM1kYggY+I9JUdRZn0sMGrgpCmrDCGiTo2edc7YXdRdE
	J3KAp54zhRq5mIBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AMQCIOoS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LdBtyvZJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744710912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=qCFPGMja1AceTmlB/CFsu2BSzugnzzImFHyb/tYFjvs=;
	b=AMQCIOoSkSCJw4olcO9eZxYCgOqOkTmBTgwDbxggaSzZZelFxhiBwKOvpvz2pGhzP+XyCB
	7JZl/mL43b5jlcd/e00wGKRLMO1hGlRCuhSNVzG+nKU0P9sPxzKY9Xg2vvBJWV8K17VROM
	fU+BGc1gmal2j1PHYfNPgtAd97EOvvY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744710912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=qCFPGMja1AceTmlB/CFsu2BSzugnzzImFHyb/tYFjvs=;
	b=LdBtyvZJ6atro4SxcLVyZOSAPuuM1kYggY+I9JUdRZn0sMGrgpCmrDCGiTo2edc7YXdRdE
	J3KAp54zhRq5mIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03E55139A1;
	Tue, 15 Apr 2025 09:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WbrtAAAt/mckYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Apr 2025 09:55:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B770CA0947; Tue, 15 Apr 2025 11:55:03 +0200 (CEST)
Date: Tue, 15 Apr 2025 11:55:03 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Isofs fix for file handle decoding
Message-ID: <6gy5exazfswgnjvssixrdn2mptbadyzaxydwdkwr6q2unmhe7t@cgdo6abwlfyb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 0D4DE1F387
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.15-rc3

to get a fix where isofs could be reading beyond end of passed file handle
if its type was incorrectly set.

Top of the tree is 0405d4b63d08. The full shortlog is:

Edward Adam Davis (1):
      isofs: Prevent the use of too small fid

The diffstat is

 fs/isofs/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

