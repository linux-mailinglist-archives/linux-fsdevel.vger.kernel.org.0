Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504C02D8874
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 18:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407683AbgLLQwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 11:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406053AbgLLQv6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:51:58 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC67C061794
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:18 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id g20so5508921plo.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Dec 2020 08:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sj4dbiovnGr54xIL9U5s6SlD51u/w+iAlhDwtYg8FCA=;
        b=XdXT5Krilx/VzAUqbz0eIs0QqP956iAcogJMiY0ybLxfyQeHZKpZwzIkPtS2Os//QM
         qCC5LlBB4UY/m8ayEvmRluD0vQe41fU2SllSCp3mtP173nrxEatkc0WnjRVeojbzAiW9
         85SkLUSEYT+GueTiOBPOazt3Lfc8HoRXAcIquEER+qBm+mTU0SCuidfXfgR8+wp7v8My
         eGXo8jtwne07i2eKNNQZ24/1KRbCraki7ty2Uk3FN8RWFdbom9A7emJetfKUWzDe9/7B
         4WxED0dwfvWu/4Kb59c8W5osrbc8qfPvOD7F6lkZXYwhgUqZB04K9yF4CQpmFEwSJxWv
         BNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sj4dbiovnGr54xIL9U5s6SlD51u/w+iAlhDwtYg8FCA=;
        b=gvzF4m+eK6TMWcZGn+A74FU3fD7BHP/7A+k8i6Rzit8ZonEFRMIL6PA+IL3JdH0yaM
         LqNxo288FgvuKCW6t+Y+TJxKWF3pNudR53pBIZqFDPFQflQqB9H8snlf54wIcIMMRx55
         evnTD1Z516yslnri/B1NgBD6xh4/MnAUBqk+7WiMqcg/hzKzvhvHS2CaSqkXQVbFfRB1
         a693/DqPYFczfCJamwU3own2o4nHFdV+fIxfoh1KTXu3YdsstOBqr9BexfQB7LwSn7WN
         9Tw41kNG9gDGf9Pk/mRkAKX+7WqPxTIkKdiDnP6XYgkA+sIY5lUm1iH0dQxdYo22fVVJ
         W2/g==
X-Gm-Message-State: AOAM531CGDRooQ8j0mI51y+VnlabIwRnBCZopOWg6vi7CQ43GPB24Qob
        5bGNogA8AekO1U6TGgQ4RvSVQoJfEYX+Vg==
X-Google-Smtp-Source: ABdhPJzRGbpwnjTZBThsdFy1NV7Dz41RTMAu5K+gu5WbJGMGoE0YZcijxCWto/LeBfbmGj1ipniqFw==
X-Received: by 2002:a17:902:ac93:b029:db:c725:e321 with SMTP id h19-20020a170902ac93b02900dbc725e321mr15786186plr.41.1607791877960;
        Sat, 12 Dec 2020 08:51:17 -0800 (PST)
Received: from p1.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s17sm14855352pge.37.2020.12.12.08.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 08:51:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/5] fs: honor LOOKUP_NONBLOCK for the last part of file open
Date:   Sat, 12 Dec 2020 09:51:04 -0700
Message-Id: <20201212165105.902688-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201212165105.902688-1-axboe@kernel.dk>
References: <20201212165105.902688-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We handle it for the path resolution itself, but we should also factor
it in for open_last_lookups() and tmpfile open.

We don't allow RESOLVE_NONBLOCK with O_TRUNC, so that case we can safely
ignore.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/namei.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 07a1aa874f65..1f976a213eef 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3127,6 +3127,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	struct dentry *dir = nd->path.dentry;
 	int open_flag = op->open_flag;
 	bool got_write = false;
+	bool nonblock = nd->flags & LOOKUP_NONBLOCK;
 	unsigned seq;
 	struct inode *inode;
 	struct dentry *dentry;
@@ -3164,17 +3165,38 @@ static const char *open_last_lookups(struct nameidata *nd,
 	}
 
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
-		got_write = !mnt_want_write(nd->path.mnt);
+		if (nonblock) {
+			got_write = !mnt_want_write_trylock(nd->path.mnt);
+			if (!got_write)
+				return ERR_PTR(-EAGAIN);
+		} else {
+			got_write = !mnt_want_write(nd->path.mnt);
+		}
 		/*
 		 * do _not_ fail yet - we might not need that or fail with
 		 * a different error; let lookup_open() decide; we'll be
 		 * dropping this one anyway.
 		 */
 	}
-	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
-	else
-		inode_lock_shared(dir->d_inode);
+	if (open_flag & O_CREAT) {
+		if (nonblock) {
+			if (!inode_trylock(dir->d_inode)) {
+				dentry = ERR_PTR(-EAGAIN);
+				goto drop_write;
+			}
+		} else {
+			inode_lock(dir->d_inode);
+		}
+	} else {
+		if (nonblock) {
+			if (!inode_trylock_shared(dir->d_inode)) {
+				dentry = ERR_PTR(-EAGAIN);
+				goto drop_write;
+			}
+		} else {
+			inode_lock_shared(dir->d_inode);
+		}
+	}
 	dentry = lookup_open(nd, file, op, got_write);
 	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
 		fsnotify_create(dir->d_inode, dentry);
@@ -3183,6 +3205,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 	else
 		inode_unlock_shared(dir->d_inode);
 
+drop_write:
 	if (got_write)
 		mnt_drop_write(nd->path.mnt);
 
@@ -3242,6 +3265,7 @@ static int do_open(struct nameidata *nd,
 		open_flag &= ~O_TRUNC;
 		acc_mode = 0;
 	} else if (d_is_reg(nd->path.dentry) && open_flag & O_TRUNC) {
+		WARN_ON_ONCE(nd->flags & LOOKUP_NONBLOCK);
 		error = mnt_want_write(nd->path.mnt);
 		if (error)
 			return error;
@@ -3311,7 +3335,10 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
 	if (unlikely(error))
 		return error;
-	error = mnt_want_write(path.mnt);
+	if (flags & LOOKUP_NONBLOCK)
+		error = mnt_want_write_trylock(path.mnt);
+	else
+		error = mnt_want_write(path.mnt);
 	if (unlikely(error))
 		goto out;
 	child = vfs_tmpfile(path.dentry, op->mode, op->open_flag);
-- 
2.29.2

