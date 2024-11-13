Return-Path: <linux-fsdevel+bounces-34671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C99C77EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D541F2259C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B54F1632CD;
	Wed, 13 Nov 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qAl5ejyu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M5NS/0oG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N/eDXw0E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oW8QbpvA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C660C70808;
	Wed, 13 Nov 2024 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513346; cv=none; b=DLbEQTu5XgRbTprW/GZ56y1bd34Pr5sNduXRUnJvzK6drAsyAJFyIbuyjtwUZmf0EZ8e/AwifRu84U+mzc1gQvXyxjXLZ+fPpVYIK4qXrQaPtcS3jOrYV+3fDi28Rj28e+98M+SXG4e97sUzHi3WdwwevU3i0DsxOWcgBVw+DBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513346; c=relaxed/simple;
	bh=CGMyoOAvEErySPj4VWQSp/6OVN5thh33PQr0BHdBy8E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=noZ09J9Ei+hlAnj2XsTX6qC63kefGEe1/uCHIwzM/98s2NGA7kXQJMZWGSOcAfSx13vkPUgsTMB2yUySsvDpZ1/oWsCOdRC1Zhcg7EDmIrBuMrDcloAvsk/jF8laYVYfV8AUzjl0i3Js1X6ew8bxfMncjah+bnDw696AjX3XqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qAl5ejyu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M5NS/0oG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N/eDXw0E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oW8QbpvA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2CC621169;
	Wed, 13 Nov 2024 15:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731513343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H4uNsiraV5oEnPbF6WIwff62D/EdVjIhGlKG/5iSKHk=;
	b=qAl5ejyuc+Z8SVfrg8D+Yrlo0CGiv28zkxxiEDwBce17JkSwW9mTethKfxxIgIsat2RaBk
	gmg0gGcyuuZyBafyiR5ZuNWviXhXuRqfjX3jwxC7SfVc9UBOEndZvQFHGU/bqa6Dq+NXsK
	l50vdjb87VQH99t7/dR15Q8hxHndek4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731513343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H4uNsiraV5oEnPbF6WIwff62D/EdVjIhGlKG/5iSKHk=;
	b=M5NS/0oGn7CdB9kaGy03lRXHyCTybas6nZtjyet7CxR3bH0iuz389FCH45oQ7YTtgF7GCS
	HCPAFnR1SqCtSCBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="N/eDXw0E";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oW8QbpvA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731513342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H4uNsiraV5oEnPbF6WIwff62D/EdVjIhGlKG/5iSKHk=;
	b=N/eDXw0Eo6AHbXDr1AotQg8Dq6E8dFyGYCRxQ+m9WKqwKGexTsNAmQ3m1ipa4R6/FK3Bem
	KWVVJE05S6ksSPJOPkIXWBY9uXFZxlOjKzaKLUDuCZ5zxuZv88DbMC533xZTTkjKiVY1H2
	IQW8bPnQKYnz2DDTRNhnQbQt6vbHMNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731513342;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H4uNsiraV5oEnPbF6WIwff62D/EdVjIhGlKG/5iSKHk=;
	b=oW8QbpvAb6BPNIi31n0dBDuw+DhrF+8k3Igjg4O3FlQ1+WyB7ghxwLRgMLba6tJtBKMahH
	OYmLt1w7NzD/EgAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD1213A6E;
	Wed, 13 Nov 2024 15:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ISsKf7LNGcgJwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 15:55:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 655D3A08D0; Wed, 13 Nov 2024 16:55:38 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	stable@vger.kernel.org
Subject: [PATCH v2] fsnotify: fix sending inotify event with unexpected filename
Date: Wed, 13 Nov 2024 16:55:25 +0100
Message-Id: <20241113155525.22856-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3544; i=jack@suse.cz; h=from:subject; bh=CGMyoOAvEErySPj4VWQSp/6OVN5thh33PQr0BHdBy8E=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNJNTj83fPLefFX/sSKb7qYMz+lzvX+FCl54mvjFN/1XnV3a v70BnYzGLAyMHAyyYoosqyMval+bZ9S1NVRDBmYQKxPIFAYuTgGYSHIo+19BRbcG0YYpyYLG+xztfz iqW/Brl/4zEz3moqMlnJ4y4VEjy+Ubz6atTAjRNDBlmyR3db+IbjpznIZE/bmT4rXu6W/cfBPE3wYe u32Llz+ghHe3T7FAiIFvRHvYt60TM138pDMPq+Z3/320iafE2eJt590jUh9TFq5Oqg5v1XpYELsmea F7VtUTC1PFv8lCdiJXDa5mVb+sTskI1jP50VtiZPrLTtElZMoD6WSJI5NeXjuxIkR/l+9JxTBF/YTz uzaqV17kvvNWpJApKX329OgPLCfFbDRWHdg1lbuO3zbXgq3zinSf5vFz3U1e245e/ahxZHkhsz3zpP /BRkuf9Xx3+Pz/JY+Jw4boFXcB
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2CC621169
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,szeredi.hu,vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

We got a report that adding a fanotify filsystem watch prevents tail -f
from receiving events.

Reproducer:

1. Create 3 windows / login sessions. Become root in each session.
2. Choose a mounted filesystem that is pretty quiet; I picked /boot.
3. In the first window, run: fsnotifywait -S -m /boot
4. In the second window, run: echo data >> /boot/foo
5. In the third window, run: tail -f /boot/foo
6. Go back to the second window and run: echo more data >> /boot/foo
7. Observe that the tail command doesn't show the new data.
8. In the first window, hit control-C to interrupt fsnotifywait.
9. In the second window, run: echo still more data >> /boot/foo
10. Observe that the tail command in the third window has now printed
the missing data.

When stracing tail, we observed that when fanotify filesystem mark is
set, tail does get the inotify event, but the event is receieved with
the filename:

read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\20\0\0\0foo\0\0\0\0\0\0\0\0\0\0\0\0\0",
50) = 32

This is unexpected, because tail is watching the file itself and not its
parent and is inconsistent with the inotify event received by tail when
fanotify filesystem mark is not set:

read(4, "\1\0\0\0\2\0\0\0\0\0\0\0\0\0\0\0", 50) = 16

The inteference between different fsnotify groups was caused by the fact
that the mark on the sb requires the filename, so the filename is passed
to fsnotify().  Later on, fsnotify_handle_event() tries to take care of
not passing the filename to groups (such as inotify) that are interested
in the filename only when the parent is watching.

But the logic was incorrect for the case that no group is watching the
parent, some groups are watching the sb and some watching the inode.

Reported-by: Miklos Szeredi <miklos@szeredi.hu>
Fixes: 7372e79c9eb9 ("fanotify: fix logic of reporting name info with watched parent")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

This is what I plan to merge into my tree.

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 82ae8254c068..f976949d2634 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -333,16 +333,19 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 	if (!inode_mark)
 		return 0;
 
-	if (mask & FS_EVENT_ON_CHILD) {
-		/*
-		 * Some events can be sent on both parent dir and child marks
-		 * (e.g. FS_ATTRIB).  If both parent dir and child are
-		 * watching, report the event once to parent dir with name (if
-		 * interested) and once to child without name (if interested).
-		 * The child watcher is expecting an event without a file name
-		 * and without the FS_EVENT_ON_CHILD flag.
-		 */
-		mask &= ~FS_EVENT_ON_CHILD;
+	/*
+	 * Some events can be sent on both parent dir and child marks (e.g.
+	 * FS_ATTRIB).  If both parent dir and child are watching, report the
+	 * event once to parent dir with name (if interested) and once to child
+	 * without name (if interested).
+	 *
+	 * In any case regardless whether the parent is watching or not, the
+	 * child watcher is expecting an event without the FS_EVENT_ON_CHILD
+	 * flag. The file name is expected if and only if this is a directory
+	 * event.
+	 */
+	mask &= ~FS_EVENT_ON_CHILD;
+	if (!(mask & ALL_FSNOTIFY_DIRENT_EVENTS)) {
 		dir = NULL;
 		name = NULL;
 	}
-- 
2.35.3


