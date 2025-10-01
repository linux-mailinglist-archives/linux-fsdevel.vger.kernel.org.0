Return-Path: <linux-fsdevel+bounces-63164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF9BB020D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 13:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3593B81C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7422C3248;
	Wed,  1 Oct 2025 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tW8Awx4s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kii+8dR6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O8Usp83r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HViyUilW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C952882D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317868; cv=none; b=OlbfdVZih3i/LbYwEOoF2dAsXuRzkSVdrfN2gtGOjcHr/X7LafVeHRXli8whxmgf25MYz/euU97dJTeYYUc0CLYEFapUOrubXpvSCdeU5vbpoYQOnTsyiZT4kk5YmA6x5IS5rCTDBDAtZQkijFZ0S7UuatvL4S08BBBvF+BtW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317868; c=relaxed/simple;
	bh=hHA1/dh5nFfYncltKPjUgJffRr0zr2Sitldvnn4QJfI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ODru8usD12mKe2fyKoEfdF0veqn6NbgCA7jz4AmkUkzNAER4axVifO0dvryZnBE4nGjGetL7wbW1lklk8Mc6HwGlzCEob09xsCNu3NfSwGaHb8RItUl0uQ5H5DPYdtsFIDxdRwf/R7KL/nbtW61HBzf793CUBWJSx7VF5l/aRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tW8Awx4s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kii+8dR6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O8Usp83r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HViyUilW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EE5C7219B2;
	Wed,  1 Oct 2025 11:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759317865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HU2ByFdeg24DLbRj3TUkGDGI4JO7BG2/SfVPSLyq8mk=;
	b=tW8Awx4sKgcWrKrX8BIYif6R1qU8QrMPHTu783yhWbgTwY4+RBFQEeNZ8J2gvFAoSH6E/n
	jvRJgH7D99DejR5TDWPZdh2b0boGVc1KnoHDSidKAr5a7MyOqhoMARTv4xoDNIkM8lPm21
	3lw2Aoh8UtybgPGl8L/ASPwKOPRtp3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759317865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HU2ByFdeg24DLbRj3TUkGDGI4JO7BG2/SfVPSLyq8mk=;
	b=Kii+8dR6v2Ee/LAZ8TuSYGoPAxNZWV9hbhD3aMRCZ+pEsXBbxKB1zR7vc0uJUpWu9b6ldc
	3pTepslpSTJYUVAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759317864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HU2ByFdeg24DLbRj3TUkGDGI4JO7BG2/SfVPSLyq8mk=;
	b=O8Usp83r+VzVaRAu8mOpLz9Io0baLTWt3UYs8PX9GEw1X6vEtNKVSKVSk7PLsHhNL0SOqj
	HCCOtRYbbYOmmqPSKopcUpoandrGmaAwlKfKDvbLMavwYxXgaKZX43JRjHjMet94TEl4NA
	qF9u8wtfDzNsYviuFZHCyY3g7pAo1hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759317864;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=HU2ByFdeg24DLbRj3TUkGDGI4JO7BG2/SfVPSLyq8mk=;
	b=HViyUilW8w6184b/PPJ+P12elW7AVIomCcH2jAEAGrWLux78utpGaaCPN2WZlnPmPr6O3V
	jEQwDrdyUmwGWLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE03A13A3F;
	Wed,  1 Oct 2025 11:24:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nNrjNWgP3WjTaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Oct 2025 11:24:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 75F10A0A2D; Wed,  1 Oct 2025 13:24:16 +0200 (CEST)
Date: Wed, 1 Oct 2025 13:24:16 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Fsnotify changes for 6.18-rc1
Message-ID: <j4byvkodakr7bqngrlz4tqvjxe4vzudrzjckqrheivtrd6tmqd@pale3juics2x>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v6.18-rc1

to get:
  * couple of small cleanups and fixes
  * implementation of fanotify watchdog that will report processes that
    fail to respond to fanotify permission events in given time

Top of the tree is b8cf8fda522d. The full shortlog is:

Anderson Nascimento (1):
      fanotify: Validate the return value of mnt_ns_from_dentry() before dereferencing

Miklos Szeredi (1):
      fanotify: add watchdog for permission events

Xichao Zhao (1):
      fsnotify: fix "rewriten"->"rewritten"

The diffstat is

 fs/notify/fanotify/fanotify.h        |   2 +
 fs/notify/fanotify/fanotify_user.c   | 105 +++++++++++++++++++++++++++++++++++
 fs/notify/inotify/inotify_fsnotify.c |   2 +-
 include/linux/fsnotify_backend.h     |   2 +
 4 files changed, 110 insertions(+), 1 deletion(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

