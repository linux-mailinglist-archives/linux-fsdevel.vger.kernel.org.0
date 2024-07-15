Return-Path: <linux-fsdevel+bounces-23687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092EC931468
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7CD1F22531
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F9918C324;
	Mon, 15 Jul 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V/9XYsVM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XnfCTF2d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BZO0pfxs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7+l42eZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D9D4C66
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046983; cv=none; b=ZC63CjSTxV3A/Q7M4soMzsS4WVPoNV+DpihgYTT18GeFxJZdc+OHzK7U81+PsRVPzWDptynXETTETcvV/V9pZcXBnMC1Ce1TOM0NWVvKAZ2uEUR7qmX6ZUjl34Eo/M7Pu/b4MAM7XcX7RecD8yMXEEMDWa89z37Cn9nJL6l+C50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046983; c=relaxed/simple;
	bh=oIQwMRbNfKiI16jCc2Me9N+tnuA7CPjqLxiHdMykQZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IyrDRmoFunT7LutNQY0iV4+ztMoxjWUze3cnVgnYTy7GVVzYVXdMVNiaX+foiDnLgS0qVOZyw2xYJC8uuULVImgC2pNmljHpcnkepTRWmOjboCOZIuLF9lnufMgkTdejZeZYSaQDf6VU6gLWRAOqmhjgxqACY7FwB8GZdiBTgBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V/9XYsVM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XnfCTF2d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BZO0pfxs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7+l42eZB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92A9C1F818;
	Mon, 15 Jul 2024 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721046979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=plJbnYraLLYoceF+V7OIpaXNQeQdrFylzJZu7ZMbDmI=;
	b=V/9XYsVMLNvWqbioWw6pRDzgE2q4C576mYaB464rGqHLLkgkgksIvgxF92X1mWtataFB5C
	ok6qCQvCCTpLaEoetgW8SjtvRvbFKcGksTJFnBmcXrYHmOtalPe+e2OdbPWOcRn3oGqwj0
	GDoVyeYLysl5OGAzSFz6gQ8XRuRFTmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721046979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=plJbnYraLLYoceF+V7OIpaXNQeQdrFylzJZu7ZMbDmI=;
	b=XnfCTF2d8tetkNUH8q7zsxdr+yOuumiqXxLxbT7L14A/o3oaPik86yREr2op1Ke/a9K+8s
	h7QQalB1JJSpvJBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721046978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=plJbnYraLLYoceF+V7OIpaXNQeQdrFylzJZu7ZMbDmI=;
	b=BZO0pfxsWZKW4WHl0QtE1+DLU1kNnslk/K1z//3vUyrve4ibmYILVOa5dV/+0NRfwu3A58
	uAENUbBV/57fm4wjYJeiTIHq8FsAKG+WegSYhv98hcs5T2pUSkzpPqinpqydqAxuBkKOPF
	YqXwi6a15zPGmL+kKnwAbQ99SWtl1Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721046978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=plJbnYraLLYoceF+V7OIpaXNQeQdrFylzJZu7ZMbDmI=;
	b=7+l42eZBWGfKLBmg6AYrID4e0GVq+QDyQEk6KigPJPsYkj0jnNbMSAgrnZoI0jI5xfR8rW
	yHYU72h3YndwCIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 882D7137EB;
	Mon, 15 Jul 2024 12:36:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cEI4IcIXlWb7RQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jul 2024 12:36:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3DCABA0987; Mon, 15 Jul 2024 14:36:14 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jan Kara <jack@suse.cz>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Subject: [PATCH] fsnotify: Avoid data race between fsnotify_recalc_mask() and fsnotify_object_watched()
Date: Mon, 15 Jul 2024 14:36:10 +0200
Message-Id: <20240715123610.27095-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=jack@suse.cz; h=from:subject; bh=oIQwMRbNfKiI16jCc2Me9N+tnuA7CPjqLxiHdMykQZo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmlRemyvg+9zfc0Lvo9veFNqJS7T547AYXOax2+veF mc4Qdt6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZpUXpgAKCRCcnaoHP2RA2R6sB/ 4py9H8IAECtwKrtEZfEH6/LWKhsRN6MFG6BQyZr2E2A7s3sGfs9uFWySRN8UGKNWLZbHgfuv1e2EjL uGCgEvhPDu+kXcrkjkvlopJQifbtDq2iV6eA5TCchB6zmrpZRwPzfL7F9/iCD3fRMwSa/fb1fWEzf3 sKtYnWn1aBKVo0udVHexjYp/MkSlVAblJ2B/wSsYm8KSWOFqBdS4fx6BbHqSN/LKEHy7PsTjUnwxwm d3+sjGN7UjmzIyNAD6GFKd1sT+Hb3s3NX4Jo4yibA9tNf2hQd8Tfi3xeLShMKxvZ+Or5/37UL7w7Er wKoT/n6ZsSeAI343ytpIipv+5PPcDp
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 2.70
X-Spamd-Result: default: False [2.70 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[701037856c25b143f1ad];
	FREEMAIL_CC(0.00)[gmail.com,google.com,suse.cz,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: **

When __fsnotify_recalc_mask() recomputes the mask on the watched object,
the compiler can "optimize" the code to perform partial updates to the
mask (including zeroing it at the beginning). Thus places checking
the object mask without conn->lock such as fsnotify_object_watched()
could see invalid states of the mask. Make sure the mask update is
performed by one memory store using WRITE_ONCE().

Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/all/CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/mark.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

I plan to merge this fix through my tree.

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c3eefa70633c..74a8a8ed42ff 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -245,7 +245,11 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 		    !(mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
 			want_iref = true;
 	}
-	*fsnotify_conn_mask_p(conn) = new_mask;
+	/*
+	 * We use WRITE_ONCE() to prevent silly compiler optimizations from
+	 * confusing readers not holding conn->lock with partial updates.
+	 */
+	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
 
 	return fsnotify_update_iref(conn, want_iref);
 }
-- 
2.35.3


