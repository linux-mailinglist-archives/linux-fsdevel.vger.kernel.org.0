Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D75722AA44
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfEZOed (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51101 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbfEZOed (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id f204so13645305wme.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PWquflfDaJrkdOvqQTXIMVF7HKc8rtuLphpMKMGCCts=;
        b=BH158KnqPuo9arNUGWUmIcF3bRk+4czFP//d0D9Ir692syv96+bd5kQQs175XMcVZw
         Wva2upPOJJwRQJvQ4mo01topiu5GzPrkzSGuC1hsS/IdNKsiSvRhwLmngsMsFtK6AJ5r
         aY7El3xleULQAYmQlawlBNn85uWuM5Jx5NdMiGf+BXtFaxftpIWG67vsZdPFgBnq8i+s
         4oB8wawWzWe/+PGnKqKiFe3QDGICUs7mpE1MD9NTEP71rklRu1yO0CdssZUo+N26lU1H
         c3esG60+Rgv5Y/8HacrbWe+3IyhOeJe6uhyD7hOl52eONZBi9cyCEmynWonDzo2LYjFh
         cjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PWquflfDaJrkdOvqQTXIMVF7HKc8rtuLphpMKMGCCts=;
        b=uKD6bpsmFBjZovWn6YLLnmCozKrm/uO3rY1cF269XCQIVm9Tfm+w74JgVPE2YAi8kg
         RgLxLYEaUlKE4WJFKD7/3FchWjtMa+k0IvRlvttN0+QRKpBHXsaZWm+fPwJD9LHM7wq6
         IXs/gFkXQW6pIMhpQglajKeHFsfujgg41R+gBxs0pLxizkQKoGZVD7iO0MsUwnP72XNa
         4NWue5+dktrXLcNS05ehEAVru7C4Rb+YuQkaUq3n5k5OBYWiXXYsKn0opRhaZwkvFykg
         GCDNnkXPO/+zLENWrD8hiIwEzoEFHHJuXe1Bslj//yzzc6SQaj3vradQtjas7McTrfCL
         e/4w==
X-Gm-Message-State: APjAAAXukzYMWvKdpreFXLZU14/JwsZ2w8QOSdaW+oWFf6Bu4HWCgO21
        7zqr+96jSG2DsvuGzpIfpac=
X-Google-Smtp-Source: APXvYqwqNQADKTCdRBBhXgBHFx161ftZCSh2CCoYHTelytaOHsOf7zbuU9AOUKfbvvWhRQLfNlFRMw==
X-Received: by 2002:a1c:6586:: with SMTP id z128mr6492667wmb.67.1558881270915;
        Sun, 26 May 2019 07:34:30 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:30 -0700 (PDT)
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
Subject: [PATCH v3 05/10] devpts: call fsnotify_unlink() hook
Date:   Sun, 26 May 2019 17:34:06 +0300
Message-Id: <20190526143411.11244-6-amir73il@gmail.com>
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
---
 fs/devpts/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 553a3f3300ae..1d7844809f01 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -624,6 +624,7 @@ void devpts_pty_kill(struct dentry *dentry)
 
 	dentry->d_fsdata = NULL;
 	drop_nlink(dentry->d_inode);
+	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
 	d_delete(dentry);
 	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
 }
-- 
2.17.1

