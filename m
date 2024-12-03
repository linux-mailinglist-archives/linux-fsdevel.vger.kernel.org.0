Return-Path: <linux-fsdevel+bounces-36335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C99E1CC7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241AA164F1A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889381EBA11;
	Tue,  3 Dec 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kgNAq0N9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vbLqwz/6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kgNAq0N9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vbLqwz/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FE1E885E
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733230189; cv=none; b=Imq5apzAZYiZ/wJMoCUcIYE4XFc5c6M5qMwEko/HTCJ4oajsgYqmO6y4bfD1Qy1C6Q3C4XgExE0h7m0ga164e9TAt6jOZGE6/7z0vD3zr3nytNTgNgsf48LooUE+z/DcABqEOXJDgIHyQujm6wUO7SW897Qevjrh2S+fe1YMUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733230189; c=relaxed/simple;
	bh=XUl4ew44DMJ3RRyuNx2YG3+hqdnctOdVmGlT1WPZFeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iRTQVG17ltmrBXnuwR7u1Ib3sZs2qfPoSVMdqrtINrIrQECWXDypvBMEZuhZtrkC4oMbFrtsGZxjGyfgvnScYCkIybzan/mlqrPg1rU8TCUBa8albs3YErPCJ7/47JjfWAKUeiAX1mxx1anlX+ciabcMlZDdOciDOREFXhAkKc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kgNAq0N9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vbLqwz/6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kgNAq0N9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vbLqwz/6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 104C81F445;
	Tue,  3 Dec 2024 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733230186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TVBCZTziYp7csOzTLR0t4ikEm7hzue2P3ko17e+EXYw=;
	b=kgNAq0N9yO+VEoSjnaJO9KnFSf6PxaMUeaTmcqWd+BOsY4V920BlT4ScSULCya9LrE3NlT
	cQ5qsgyuMYDbONKmwe8d3pVl/qrRqFbEcHJ41Vod4gB0rZGKMj80bbioJiYmGt0x3LSHdp
	OM/uL4ox/QqvGiZbCZiQAQQhqrWkoI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733230186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TVBCZTziYp7csOzTLR0t4ikEm7hzue2P3ko17e+EXYw=;
	b=vbLqwz/6FVdQ6onK/7sPn3xGB5n9DoENHA5sDLPt1iMJhe7AyWLMphhzRLB70fN7Q3mDm+
	arb/lSz6/gs1jEAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kgNAq0N9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="vbLqwz/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733230186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TVBCZTziYp7csOzTLR0t4ikEm7hzue2P3ko17e+EXYw=;
	b=kgNAq0N9yO+VEoSjnaJO9KnFSf6PxaMUeaTmcqWd+BOsY4V920BlT4ScSULCya9LrE3NlT
	cQ5qsgyuMYDbONKmwe8d3pVl/qrRqFbEcHJ41Vod4gB0rZGKMj80bbioJiYmGt0x3LSHdp
	OM/uL4ox/QqvGiZbCZiQAQQhqrWkoI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733230186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=TVBCZTziYp7csOzTLR0t4ikEm7hzue2P3ko17e+EXYw=;
	b=vbLqwz/6FVdQ6onK/7sPn3xGB5n9DoENHA5sDLPt1iMJhe7AyWLMphhzRLB70fN7Q3mDm+
	arb/lSz6/gs1jEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03FC6139C2;
	Tue,  3 Dec 2024 12:49:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mfzwAGr+Tme/EgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Dec 2024 12:49:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A41A8A07D1; Tue,  3 Dec 2024 13:49:41 +0100 (CET)
Date: Tue, 3 Dec 2024 13:49:41 +0100
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Quota and udf fixes for 6.13-rc2
Message-ID: <20241203124941.nstt3sjl7ohygkrb@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 104C81F445
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fs_for_v6.13-rc2

to get two small UDF fixes for better handling of corrupted filesystem and
a quota fix to fix handling of filesystem freezing.

Top of the tree is 6756af923e06. The full shortlog is:

Jan Kara (2):
      udf: Skip parent dir link count update if corrupted
      udf: Verify inode link counts before performing rename

Ojaswin Mujoo (1):
      quota: flush quota_release_work upon quota writeback

The diffstat is

 fs/quota/dquot.c |  2 ++
 fs/udf/namei.c   | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

