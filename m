Return-Path: <linux-fsdevel+bounces-34277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866A9C4666
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC51F22C25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7311AC438;
	Mon, 11 Nov 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKWJXCuR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEDD1A2846
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 20:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355868; cv=none; b=DRWMhxnthIVwmBsX1S7xXFOVHl12kPMUYuMhE78rAnqUNWupG//V0INbyndqgLmbHzN9nT7IdYBsxkly1X3Q43qRY8/OSv7OMti9d0Listdpjfv/yC3J4otAtG77HN7pmr0vTyiqPl+RA1/VFnYKo+zhPUq4e2rzybreYsHoUhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355868; c=relaxed/simple;
	bh=Dn/lh5NlUBZx8e5lIes8Qg2m8Do57cckYNFE10X1Fzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CJWxRBR9dbprh8CWPvoBZqK1by9N8ZobYYWQTYmtaK98jbklm8l7wOIcqqZ00zqedzTMMMi+AX7VSURyDjJNa0xvmO91yavt9WOgsk1SrnS1TqHR97c/EXIcjMBtgwAN4S4d89lxqgwZi9zdoX4B3KMSbgwfY/Cw62FlqVWX5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKWJXCuR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso38147845e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 12:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731355864; x=1731960664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SpLlc5luV6Ez75ZXiZCXtRLFKtaXVz8Wy1KqPzHy/oU=;
        b=LKWJXCuRiAxkc/Akee+RpRJxYIbujiX40r78BlwPBWxyeq4eaHVBaoHBzKLVNXCD6e
         r/txpmMNFW1oMhff9C508dYc2WeMUpgd3W6GZ/9xZXF3PBI29KjF7aZjFPuJb6SUgZOU
         izPq5dtJ/zzjwos59YPDR8UDKLQoChIuTPgvyyBvtzBnJSUB+D++PW5rT5V7gsT9SuYN
         FHJhFDFTiLtr7+TCosubk2QrseRgfUS1qT4jsGxZkfdeeEZ6KFfQZ5pK3XKDN9d0lBTt
         6MlExabkJGG4DBnxkwbD1j8q8p5NlSAn8oiUW2Xh4WiZu1gvQni0HhUm1WI0nlmJWcDq
         hRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731355864; x=1731960664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpLlc5luV6Ez75ZXiZCXtRLFKtaXVz8Wy1KqPzHy/oU=;
        b=Lgy9pMmXgKDD9FygW3Y3YVwiGiViNCAwUgso2xi8mX0AN5ISvXDhNw2m/VqvAbQaa3
         9X3GvgP1YHpY8w3PQF3shhK+q0jxDRM/o/s5BVSi1hIr1ZN9fxGj54EiwPvmQdoN6T6m
         9dAjBIxcN2fGzOdsTydFJ4GFS+FE7NUlWD2a7MYngjaadgFTm6koE6PzIUv9zLp8pBKc
         n5Nf1/wLUg+okK+5MRrELBrtq4lEyqmKtXLgJZE6kLiPfCCljDR6nlL7hB8HsNsIBd2/
         cv2V1L7LViwAdGeLSJJNx8lZNUUZQioyCI9Yi2GXCgHHlH6ttSlSOz8ewl/cK15kWqn5
         osIA==
X-Forwarded-Encrypted: i=1; AJvYcCX0XlaZLJGX5XpgikTd8kZbpqdHim0ugPPmg3ttdPtg8zzvUgoallAN9Vmn75wsC1yI5umEVt8mQBcElP/d@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qjrMJk6nbSr1if7D5tPUe8Bu/LB716bkehAHi79ofBhlepEm
	E1HoZ+sUkFbwrlh/ztgfXvnEQdszZB2PQ9d47DKJRvlEajmD6EOS
X-Google-Smtp-Source: AGHT+IF1BnM7EQ6321I5LiYO3mEa7+TZfAoTJ4XwOLaO4nm8PgDwRAnbtxnxYmI3qSbQQL1FPOtkng==
X-Received: by 2002:a05:600c:1e18:b0:431:5d4f:73b9 with SMTP id 5b1f17b1804b1-432b751826fmr126391335e9.26.1731355864317;
        Mon, 11 Nov 2024 12:11:04 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5b7fsm220888925e9.4.2024.11.11.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:11:03 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fsnotify: fix sending inotify event with unexpected filename
Date: Mon, 11 Nov 2024 21:11:01 +0100
Message-Id: <20241111201101.177412-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---

Jan,

I tested this fix with the manual reproducer and it passes the LTS sanity tests.

Did not have time to write fanotify+inotify test yet.

Thanks,
Amir.

 fs/notify/fsnotify.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 82ae8254c068..316eec309299 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -333,12 +333,14 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
 	if (!inode_mark)
 		return 0;
 
-	if (mask & FS_EVENT_ON_CHILD) {
+	if (mask & FS_EVENTS_POSS_ON_CHILD) {
 		/*
 		 * Some events can be sent on both parent dir and child marks
 		 * (e.g. FS_ATTRIB).  If both parent dir and child are
 		 * watching, report the event once to parent dir with name (if
 		 * interested) and once to child without name (if interested).
+		 *
+		 * In any case, whether the parent is watching or not watching,
 		 * The child watcher is expecting an event without a file name
 		 * and without the FS_EVENT_ON_CHILD flag.
 		 */
-- 
2.34.1


