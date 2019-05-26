Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446112AA45
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfEZOea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42955 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfEZOea (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so14324551wrb.9
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jw5lLYOweNfaAlPlTvVvHs8+qncIbF7yamB+GXS6r7E=;
        b=ohnY3LdAzmMrpHZR+IaADbjfJDnD6bFzA/znX5vtjMScmSxeIJzv6pozOKNZOzcaoO
         qOIWOAKPg4IIcZ/6b/nBfNeiCgQ7PRdGZeObVOBEakQeSaQSdgBhPxs6Pck3KRCOkNeh
         q4eJR4Q/OT/nzYvGq/l14qSu333GuVgNLgX6UmUJpgRp7spYyuBZif1Y6lkwGo2XFX3x
         tzUuKjSb1luQU6BlxIuZKT0gJIpLtKuILaR4nNdxhgavy+vbVN+TDWJLLZDHrSuDraa5
         PNRWd1qUxe0C1Hc1WDAP+pp9wUhTU8d7AV61jPerfMJ2s4kR+zekydnQwVzajWcYE0yL
         G0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jw5lLYOweNfaAlPlTvVvHs8+qncIbF7yamB+GXS6r7E=;
        b=o4m17LpZ1RI5HdMpDJ0vHvmFfuxm3mIajr5LmnBdGaPr+WoaftyMH/BO8r/UjsA1cM
         9bWnOJbZFOsCuo6s43ATM+sprbX88OqAxTBkstsaJUmQtxzuUTOrCdZZ/koT8tH8fmfg
         43BrHIZvKtK5Rrsg+aA4ozt9bJxrf7Dj2Kwsf98iQzwvp34V3kASLf/uJJmvu95pGhyL
         UpBcoKHzRv3lgXC7RZEyPrdiuYgRcFLbVNU7yTs9jGw3KUQcAHruTNyDpK5YveBImlLZ
         0Q9pfDO8bcX9x1vbkrFAmDMpFQV/iTJs76oEIt2b+x40rjeTPRhbMTFsTISHSEB0eaK6
         ji9Q==
X-Gm-Message-State: APjAAAXmntuwrJKNVchcFUCZD8Aryjpl8nV0pCCAOJxHtexePTKu43LS
        ium/BwFEKTvcL7tgp+hAvGM=
X-Google-Smtp-Source: APXvYqyYWB/dtC7NaqQlMggVvAmFRftyr011GtTwbJx291UBUtkqVtg8rQFyBWy0KalDQ0uhLen28w==
X-Received: by 2002:a5d:4a92:: with SMTP id o18mr14976853wrq.80.1558881268974;
        Sun, 26 May 2019 07:34:28 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:28 -0700 (PDT)
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
Subject: [PATCH v3 04/10] tracefs: call fsnotify_{unlink,rmdir}() hooks
Date:   Sun, 26 May 2019 17:34:05 +0300
Message-Id: <20190526143411.11244-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/tracefs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7098c49f3693..497a8682b5b9 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -509,9 +509,12 @@ static int __tracefs_remove(struct dentry *dentry, struct dentry *parent)
 			switch (dentry->d_inode->i_mode & S_IFMT) {
 			case S_IFDIR:
 				ret = simple_rmdir(parent->d_inode, dentry);
+				if (!ret)
+					fsnotify_rmdir(parent->d_inode, dentry);
 				break;
 			default:
 				simple_unlink(parent->d_inode, dentry);
+				fsnotify_unlink(parent->d_inode, dentry);
 				break;
 			}
 			if (!ret)
-- 
2.17.1

