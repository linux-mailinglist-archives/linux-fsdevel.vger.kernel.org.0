Return-Path: <linux-fsdevel+bounces-19556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF8E8C6E73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 00:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D721C2259C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 22:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4615B573;
	Wed, 15 May 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TehATqvI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JmR7OA9a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TehATqvI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JmR7OA9a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41925757
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 22:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715811061; cv=none; b=E0/Kg+rE5QZn2hytu8iYG1Q+siTs8erfrPyt9Xhae+KlxqXt9uEfhiDjfkh2oXYbaAuOgl1OEPYrXqXx2um5EfS6F7Smxvw8NFUj1AQWr4NEICpzJaNJiAEI+WrIeFPvJNG+2fsO+9nhl9VdxQ6UvvEK89HJiY/eAdJqimjize4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715811061; c=relaxed/simple;
	bh=fcP5YSd2uUWtKHsfBqfdeEgfY1I70otPezVDdWPwNP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ttila6tUCzmnrlmLs8PTdwu1LvsEUpHd16tfGT/P/s4cppzTBtJyx/ZkYgOKxhmAiw1FakpplkkdXWktxdnK+PpnpJMHBQIj5ccpx8lJpsetOjCP03NvRxxOYTxn4g7MIjq88Le3fq8in5reDJGYJBeQiM8QjZkZcx1Y7eacIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TehATqvI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JmR7OA9a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TehATqvI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JmR7OA9a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 325E7340A8;
	Wed, 15 May 2024 22:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715811057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UbNozqNMmhpbat3rHDj+SFwxeoFjIiOhDT9lmvodkQc=;
	b=TehATqvIUOhdiTQGr18reOa1F5vdROLC74YAavgH2GqXV/m5GHjkQdjrCKZrsE5/pzjL7+
	z34QD4m3KDhQFhGeG6Zt6w4TZ6oCB7VMtNdtzHXqdV2yCs6Aq1xgYNTbIuVzClX0IY6yrT
	7xugv/LTmb/GWBKtu8gSconwCDwx2ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715811057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UbNozqNMmhpbat3rHDj+SFwxeoFjIiOhDT9lmvodkQc=;
	b=JmR7OA9aKzawaSpVkHV2MDCC5VYkbHIFQXBTDH3whnVEPdUDAwjR+Ozxiu0sVDW6+ahxW2
	1DZF8Y6my3L/7gCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715811057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UbNozqNMmhpbat3rHDj+SFwxeoFjIiOhDT9lmvodkQc=;
	b=TehATqvIUOhdiTQGr18reOa1F5vdROLC74YAavgH2GqXV/m5GHjkQdjrCKZrsE5/pzjL7+
	z34QD4m3KDhQFhGeG6Zt6w4TZ6oCB7VMtNdtzHXqdV2yCs6Aq1xgYNTbIuVzClX0IY6yrT
	7xugv/LTmb/GWBKtu8gSconwCDwx2ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715811057;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UbNozqNMmhpbat3rHDj+SFwxeoFjIiOhDT9lmvodkQc=;
	b=JmR7OA9aKzawaSpVkHV2MDCC5VYkbHIFQXBTDH3whnVEPdUDAwjR+Ozxiu0sVDW6+ahxW2
	1DZF8Y6my3L/7gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D50F91372E;
	Wed, 15 May 2024 22:10:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qEexM/AyRWYRFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 May 2024 22:10:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7F594A08B5; Thu, 16 May 2024 00:10:49 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Hugh Dickins <hughd@google.com>,
	<linux-mm@kvack.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Date: Thu, 16 May 2024 00:10:44 +0200
Message-Id: <20240515221044.590-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2126; i=jack@suse.cz; h=from:subject; bh=nepuCvwX/Y1NrHhBKEWye0lsb804dUMaCn8jkYTf/Fg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmRTLb53IJKE3UGywIDzAg6YE2qe3Zgf+FnQxwBGoI uBuyXCKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZkUy2wAKCRCcnaoHP2RA2ROKCA DfwZwvwPVs+UdJm114a1v6s5fidRjLSRujhkuHfKEi7L9qLsz/fQrm1SVs64WQMtQ9P3sCHmpRRbAQ NCxBS/KDayvQMk9+dcT8TmQlkRFUl+cmYE76zutnqrWGlknEArpeitP1opG6GFByqcEm4iRUE1vx3t XlL25ZIwKyujeQ4BPNf7Ur3EiFZQNPMQtYajjDSoZMXWslPeIll++hqEL7YZOTJrJiImJ2cEhqLCtP E4pb51s/HMHz6OncsJftfBT32pMtvS09L7SnGoFP/L6bZpViWEYjJ1SmOsbwgq+2CaYc0fgm35WhhG eIMlz0qsbjvH4MBtiDfRG/zylhqS2s
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]

From: Mikulas Patocka <mpatocka@redhat.com>

I have a program that sets up a periodic timer with 10ms interval. When
the program attempts to call fallocate(2) on tmpfs, it goes into an
infinite loop. fallocate(2) takes longer than 10ms, so it gets
interrupted by a signal and it returns EINTR. On EINTR, the fallocate
call is restarted, going into the same loop again.

Let's change the signal_pending() check in shmem_fallocate() loop to
fatal_signal_pending(). This solves the problem of shmem_fallocate()
constantly restarting. Since most other filesystem's fallocate methods
don't react to signals, it is unlikely userspace really relies on timely
delivery of non-fatal signals while fallocate is running. Also the
comment before the signal check:

/*
 * Good, the fallocate(2) manpage permits EINTR: we may have
 * been interrupted because we are using up too much memory.
 */

indicates that the check was mainly added for OOM situations in which
case the process will be sent a fatal signal so this change preserves
the behavior in OOM situations.

[JK: Update changelog and comment based on upstream discussion]

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/shmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1f84a41aeb85..9c148f9723f4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3167,10 +3167,13 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		struct folio *folio;
 
 		/*
-		 * Good, the fallocate(2) manpage permits EINTR: we may have
-		 * been interrupted because we are using up too much memory.
+		 * Check for fatal signal so that we abort early in OOM
+		 * situations. We don't want to abort in case of non-fatal
+		 * signals as large fallocate can take noticeable time and
+		 * e.g. periodic timers may result in fallocate constantly
+		 * restarting.
 		 */
-		if (signal_pending(current))
+		if (fatal_signal_pending(current))
 			error = -EINTR;
 		else if (shmem_falloc.nr_unswapped > shmem_falloc.nr_falloced)
 			error = -ENOMEM;
-- 
2.35.3


