Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3582AA41
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfEZOe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52699 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfEZOe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so13651726wmm.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AmJBE1GVvMnMLwgdN+6ymr8xEnSOeAjosMZf5FRVOTM=;
        b=YNfU7SZxTEhSzZaDHTLUEUF69qeHFxaizrKxhpLy2Bo4LbocVcRH/ilq33J2I9x1Ax
         H3no3WwxI+GkfKppcQAW4VrElRoH9eeGCCigRSJ0OIt51R/U50YbRbatosDPUXEdFIAJ
         yPi4iUWzujkJ21J1hn7or142pykQmmmP/a+v3hZPXO27aJMBQvf7FQbizableCVcCXR9
         EcPgSX6ra6rI3LrOc0M4TkEXH+S9jefCocpamIiEyXOcQZuG9OLN44IFZjn6nqUQ9R6W
         iWp6558XPCecRXuXylIXot5vZ2vsBaOLrcapNJdES7y82sPJunmx+t3TEq4VjK+tW5cS
         Yr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AmJBE1GVvMnMLwgdN+6ymr8xEnSOeAjosMZf5FRVOTM=;
        b=bbB/wma3KJNGULxQE/AclPLPzVsNxz4UHxq8fZSvxbQaajG+Cszz93wNnD2kHCczY0
         /sn4svB1YoXuEnX8yxbvelv9Erzn+kjIwMLjBvZID8+P62PEDRUP87KNZgIL8hzM8Nwp
         XetpxLNLGAptLrA2TTSneNNj0iRH3g9POgT+srIzd9UvOj1XX2KULFeqfoZhllX2cF/G
         nWrSNMKcacHkAkkb+jo8Yau81Q+0Is33tprbVV5kh3WbKhrOe/E2b49OsJOq0xkiS8CY
         s7iDKcQpwCuUTek2G+e9HFCF/J3FC2MaZOIeUpbZgHumcY2cItzVWjTHn33bRK0dutZP
         f/kw==
X-Gm-Message-State: APjAAAUUyNUKC7BhMOYrRrEP/xc4+k5+vsPpY0BXE1Yebiynhps0RH+H
        XpOOSMHolrmZsx/ZMNmCplY=
X-Google-Smtp-Source: APXvYqyhADuMqt0Yb7mkz8FiH87TwTB95OOxUlekx25CzgDbpPIhxjuHyOjBsrORbS3U8+heJGhRfQ==
X-Received: by 2002:a7b:c4d2:: with SMTP id g18mr23825807wmk.78.1558881264989;
        Sun, 26 May 2019 07:34:24 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:24 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 02/10] btrfs: call fsnotify_rmdir() hook
Date:   Sun, 26 May 2019 17:34:03 +0300
Message-Id: <20190526143411.11244-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6dafa857bbb9..2cfd1bfb3871 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2930,8 +2930,10 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	inode_lock(inode);
 	err = btrfs_delete_subvolume(dir, dentry);
 	inode_unlock(inode);
-	if (!err)
+	if (!err) {
+		fsnotify_rmdir(dir, dentry);
 		d_delete(dentry);
+	}
 
 out_dput:
 	dput(dentry);
-- 
2.17.1

