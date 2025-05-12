Return-Path: <linux-fsdevel+bounces-48760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A076AB3DB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB89465AA0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C182125179C;
	Mon, 12 May 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bmKWAGW4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbdKPXsm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bmKWAGW4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbdKPXsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769AD24BBEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747067545; cv=none; b=VmNN6A8509JwTKOFUAwYQRiBHkfEHeFWmhCXl63gnHX86yh/y8Vm62oY6A+t50uhjx9/t9ZZkA0YznvoTlPhKx7be2Ppao6+0f69Ih/+u3K5Quz2uP8zcP0sgERZipB649bDU8hpva4Y5ub+lDJ9oXtddteSfED4Ni9yrxFsmJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747067545; c=relaxed/simple;
	bh=47hD1XxlLe93a/VMecstBqZgihiGC06T91Jl7bsPhPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hSpoQ+lQR4YgfvHTamT1A1LvPrqoYSs6wcbTQphV5nF7JUxgeENtyddxdprkGXj4ertKkWRBEoHpxuVNPKY9pEkqSA5MwQsDHDTr8cHwpdvG9N+fOL/b9fPg4TxD+tmLOnkBQ570JKPyhfe9eM1A/kyYCFRjxU/UnvJMFuH1IpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bmKWAGW4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbdKPXsm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bmKWAGW4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbdKPXsm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 627A921186;
	Mon, 12 May 2025 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747067540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HilVADWwYiAeFwr5iHKUo3TEeUyeoC7poIfK49F5MSk=;
	b=bmKWAGW4oZCPtLJbWmg3E1r9aLCr9GrfmxdcQ0OZr1tJsUBwqGyxNzhAf6DN/CYBzU0bhU
	uUEJK213A9vh36neQYx86qBt9cAIt63tYT876RzelaWi9Xk5MGnvNvwH0y9KwNYHrULT2j
	Bnh2X9qcncCoo1LvI72IdFLzrSaHGt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747067540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HilVADWwYiAeFwr5iHKUo3TEeUyeoC7poIfK49F5MSk=;
	b=AbdKPXsm+pdZVKW1wD0SWqgNYAYx++vMuhTmDbGl6lX+yvCexi6CzGP23FHU6k5zReonpg
	sbZfMQE0QCSRL3Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747067540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HilVADWwYiAeFwr5iHKUo3TEeUyeoC7poIfK49F5MSk=;
	b=bmKWAGW4oZCPtLJbWmg3E1r9aLCr9GrfmxdcQ0OZr1tJsUBwqGyxNzhAf6DN/CYBzU0bhU
	uUEJK213A9vh36neQYx86qBt9cAIt63tYT876RzelaWi9Xk5MGnvNvwH0y9KwNYHrULT2j
	Bnh2X9qcncCoo1LvI72IdFLzrSaHGt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747067540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HilVADWwYiAeFwr5iHKUo3TEeUyeoC7poIfK49F5MSk=;
	b=AbdKPXsm+pdZVKW1wD0SWqgNYAYx++vMuhTmDbGl6lX+yvCexi6CzGP23FHU6k5zReonpg
	sbZfMQE0QCSRL3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4609C1397F;
	Mon, 12 May 2025 16:32:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XwsVEZQiImguZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 May 2025 16:32:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CB903A0735; Mon, 12 May 2025 18:32:15 +0200 (CEST)
Date: Mon, 12 May 2025 18:32:15 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] UDF fix for 6.15-rc7
Message-ID: <6jk27t5taxgcylrgmh7hx646ztw47jc4ctwteiqh7xqmgj3dbj@hxeksvncb2mr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git udf_for_v6.15-rc7

to get a fix of a bug in UDF inode eviction leading to spewing pointless
error messages.

Top of the tree is 55dd5b4db3bf. The full shortlog is:

Jan Kara (1):
      udf: Make sure i_lenExtents is uptodate on inode eviction

The diffstat is

 fs/udf/truncate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

