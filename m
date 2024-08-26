Return-Path: <linux-fsdevel+bounces-27090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FC895E910
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DBE5B21859
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6CD823C8;
	Mon, 26 Aug 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BbYOj/po";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ya1R84qI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ks0fxGgI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6/OTanlM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20717320C;
	Mon, 26 Aug 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654242; cv=none; b=BV1crSRJinDr7VwnGxsMktQgx498AQy0y9mLoRNzI/xO9bBBsh0Mpf+jEH4DosNjNXm0j8FrhH2AIbPPRhrkUonwC7bb9mS8vug9vDQL0RTneUy85hUJrH0HoJynJapCZhU/o692be75fB/rMmeCQRs2hoDYqcAjFIaaU0Sz5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654242; c=relaxed/simple;
	bh=pWe+zLd8bouok+C/3pYo9dtAB8ZYRkwE9UAJ3vJHbIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNfg1Cqoxnm3z5oQF34sDxtYMdd+bo5xpN/jTPmo4JWl/TXg0XZzdCl1cr0clmc9np+ThyKwWj0eiDlELufU4oaaA1GWYPWsiJlaSViJBVneQXsv4XoMyYIOxkzxPq9VARjqbuY/7S/5GMzy2Fd0JZZjgwZor1SB4eiFF95gLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BbYOj/po; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ya1R84qI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ks0fxGgI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6/OTanlM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E09B42199A;
	Mon, 26 Aug 2024 06:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eV8Y/2VLA2lSVqpyogE9r8ZLPHghATHJHnVNOyNUgXU=;
	b=BbYOj/pob4z9pxrPYh8Up3P3+T4ZY/v1pbnMiK6zdOEkEgmCmDoiyYUJXbQZjXffsE7pMw
	/GjXJKqwSWiMyCiDlMvm7F8p+hoQKVN2HrXxwLyVlA+RUvDaLP9lDHO6m/B6SL9+YrtmVs
	Diza7tmd9YobZg/oyt8BQqUzZ6B6mSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eV8Y/2VLA2lSVqpyogE9r8ZLPHghATHJHnVNOyNUgXU=;
	b=Ya1R84qI2Sdrbr+BpBuSmhvA+trVCBuAqXggQ9G/ej9Z0zLbpGRJB4cyHqHIiuGwkDO8J7
	dcy+HEuRN9VwxKCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ks0fxGgI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="6/OTanlM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eV8Y/2VLA2lSVqpyogE9r8ZLPHghATHJHnVNOyNUgXU=;
	b=ks0fxGgIKQPoLNpZmKUXmGWTWQb9rs4jJRQLvUCLZszn/hiv9XNQ77xoBzfYcRnDKMB681
	I5g72gTnIRlnSzrsb+S8liVTYm7cCFv+C1mkkDU6CgBW9I9oQy+pMx9bJHOQ47LGZhALHy
	zfjS7j1d0n96q2BMCOEzjWKp3ewIIJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654236;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eV8Y/2VLA2lSVqpyogE9r8ZLPHghATHJHnVNOyNUgXU=;
	b=6/OTanlM6aMDR/crNzVX2i5ONGM2qCvUl6jhpSUL3uy1s47zcOadiGE4hLUcOKBlROBY0j
	FNS6pa79DpJ4TUCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C55913724;
	Mon, 26 Aug 2024 06:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 402WDJoizGYbOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 06:37:14 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 0/7 v2 RFC] Make wake_up_{bit,var} less fragile
Date: Mon, 26 Aug 2024 16:30:57 +1000
Message-ID: <20240826063659.15327-1-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E09B42199A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

This is a second attempt to make wake_up_{bit,var} less fragile.
This version doesn't change those functions much, but instead
improves the documentation and provides some helpers which
both serve as patterns to follow and alternates so that use of the
fragile functions can be limited or eliminated.

The only change to either function is that wake_up_bit() is changed to
take an unsigned long * rather than a void *.  This necessitates the
first patch which changes the one place where something other then
unsigned long * is passed to wake_up bit - it is in block/.

The final patch modifies the same bit of code as a demonstration of one
of the new APIs that has been added.

Thanks,
NeilBrown


 [PATCH 1/7] block: change wait on bd_claiming to use a var_waitqueue,
 [PATCH 2/7] sched: change wake_up_bit() and related function to
 [PATCH 3/7] sched: Improve documentation for wake_up_bit/wait_on_bit
 [PATCH 4/7] sched: Document wait_var_event() family of functions and
 [PATCH 5/7] sched: Add test_and_clear_wake_up_bit() and
 [PATCH 6/7] sched: Add wait/wake interface for variable updated under
 [PATCH 7/7] Block: switch bd_prepare_to_claim to use

