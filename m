Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7882010E49
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEAUzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 May 2019 16:55:45 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40948 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAUzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 May 2019 16:55:45 -0400
Received: by mail-yw1-f66.google.com with SMTP id t79so24553ywc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2019 13:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aAYZCbi0VoSmmJV447FzNll6sGqvQaQ9x6mMPmHmAI4=;
        b=X+fxKdNubUSEWdz6YamleAbHQ6uLnohL159H15RTgJJJ2xfWmnYhTfTjjA/eCrQS35
         zGS7308JRWp1SHHJ8qaZdCBMHx51dzzZETcNos4rbFbngmqZJ1j0DMJvwQ/LEWyuN8Ba
         zVzq4h1x5CAd0aLYMMxPBBaQ5x98wo/uByJPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aAYZCbi0VoSmmJV447FzNll6sGqvQaQ9x6mMPmHmAI4=;
        b=NA4G1XIMdpPvy09KwQQTk1/0iNKP8hDhbjW1jZXMnoOAVl4BkTzAi2XLM+a+VopQ57
         YatMOYp5CSzKCKUdBYjqJB+yk9LJnxNs86hKSj6ZllgG0ofRt7jmoHy7ycxzcw+giAET
         vFpN/pWrXmoOuXKT6Mcq4ZxObVxecV32jzUvpF8nBE/Z0RRcqS3W/iXstC0eeagKS4iW
         xMsMnVHx/9uoEwTN+CWW39O4g7MAVSFfOOWehfGoaAnnK5nv7Lg8YeeV3Zm+Lc89gSsN
         dErzy1MU13xoyFbg76A9ACQe+0tPRxzVCbDiIPlfHHCBkSqrCKDiicgGtXT/+OTivSy2
         C60A==
X-Gm-Message-State: APjAAAWTnlSthFAZEzsPK+PhHmpNkQ/ixwJTob7nxXamEpGgIep/cDYY
        H4Uq/HI/CEH6/580x3bM3Zv/qQ==
X-Google-Smtp-Source: APXvYqy2PMhVL/u5NrVzSus4wnXFIbyY6IcxLKfwkdsm7GFCR48GA++vrN0jwomc5NoLzOEX2LA4Qg==
X-Received: by 2002:a81:59c2:: with SMTP id n185mr1043756ywb.21.1556744144365;
        Wed, 01 May 2019 13:55:44 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id w189sm9488181ywe.42.2019.05.01.13.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:55:43 -0700 (PDT)
Date:   Wed, 1 May 2019 16:55:41 -0400
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Steve French <smfrench@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] network fs notification
Message-ID: <20190501205541.GC30899@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a really really trivial first iteration, but I think it's enough to
try out CIFS notification support.  Doesn't deal with mark deletion, but
that's best effort anyway: fsnotify() will filter out unneeded events.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/notify/fanotify/fanotify_user.c |    6 +++++-
 fs/notify/inotify/inotify_user.c   |    2 ++
 include/linux/fs.h                 |    1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1041,9 +1041,13 @@ static int do_fanotify_mark(int fanotify
 		else if (mark_type == FAN_MARK_FILESYSTEM)
 			ret = fanotify_add_sb_mark(group, mnt->mnt_sb, mask,
 						   flags, fsid);
-		else
+		else {
 			ret = fanotify_add_inode_mark(group, inode, mask,
 						      flags, fsid);
+
+			if (!ret && inode->i_op->notify_update)
+				inode->i_op->notify_update(inode);
+		}
 		break;
 	case FAN_MARK_REMOVE:
 		if (mark_type == FAN_MARK_MOUNT)
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -754,6 +754,8 @@ SYSCALL_DEFINE3(inotify_add_watch, int,
 
 	/* create/update an inode mark */
 	ret = inotify_update_watch(group, inode, mask);
+	if (!ret && inode->i_op->notify_update)
+		inode->i_op->notify_update(inode);
 	path_put(&path);
 fput_and_out:
 	fdput(f);
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1852,6 +1852,7 @@ struct inode_operations {
 			   umode_t create_mode);
 	int (*tmpfile) (struct inode *, struct dentry *, umode_t);
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
+	void (*notify_update)(struct inode *inode);
 } ____cacheline_aligned;
 
 static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
