Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37FD2AA48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfEZOei (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32969 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfEZOeh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id d9so14337948wrx.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SN8ahLojqtIPGUNfBsu4qwtWNoSRD5SZyFTxKj5UnT4=;
        b=PlttP5sHsoKui7TNA1aZo0IRUcL2kbRFDgAEAKHBZDqLLGp1FfMvn+/L0vRW9mdaHz
         C7euDn+sREBA3i7VcigUlyF8xEK/vgGkuK2w/AWJLCSbDA9y8LMNrIxWGci5eRR0Gfza
         sIvxAgVsD1lYdCMzCuuB46qY+zOZLCEvc9lfQ1i9fuu0Sm+SdBTamUyjCKbwayLJcMhG
         ScxWpcWYTaNmS7IlS2VkFV4f/Q0z0Tpm2ti8EhFz0FOyOgDlBAYuook3zxJpwBgqGZ56
         EEna0NC8d3rwZwFfD74Dgwku6KtFl40ArqvpCiIeV4HPykVclu36p3RtxP+UiVLGTFWS
         Nyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SN8ahLojqtIPGUNfBsu4qwtWNoSRD5SZyFTxKj5UnT4=;
        b=hxT/GS6Lx4R5MyWQv7jGgj8Gs+xz5Arvp77oQJvN6jOQ7Y63RXw1fx6HOQAC4KZtgK
         Xdte1PM9skfA/j8QFZT+uvTmMkYFzAKNDPIfOSZOSlZJWJiQwI+VySGhT8uuCWzAWGWw
         A65ZFpPfV2vH3T9+hpVvfcH+Yy65SI1IXfER8l98yT7TrNh6CLUOgALEhkMItz46IC9D
         68xmLeE2i0KDqmRp34cVoOiIu3V9KzELQ03x9Ez25NDCIt5amGGtx7Yy1inm1efN2rks
         t3yMsb/IieAMd+h81HLK041vU9p+t9urhvkqrp5Mei85AKKwux5RKQUfdc7oWu/eVx2l
         iTUg==
X-Gm-Message-State: APjAAAXQ08b693v8ahGjrt4B/ih2pKvKKrq1RfWWCmrZK24hSpirXFjY
        d5Uhy2fiViFj9O8yQCs48ww=
X-Google-Smtp-Source: APXvYqzOANvqBIosEWEJJXPhNxAMlF2gzcDQHuE23RQRnAahXoFlknn9YSrEPEdM+aDy4f/kxAkByQ==
X-Received: by 2002:adf:d84e:: with SMTP id k14mr5445417wrl.76.1558881276140;
        Sun, 26 May 2019 07:34:36 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:35 -0700 (PDT)
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
Subject: [PATCH v3 08/10] configfs: call fsnotify_rmdir() hook
Date:   Sun, 26 May 2019 17:34:09 +0300
Message-Id: <20190526143411.11244-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events on unregister
of group/subsystem after the fsnotify_nameremove() hook is removed
from d_delete().

The rest of the d_delete() calls from this filesystem are either
called recursively from within debugfs_unregister_{group,subsystem},
called from a vfs function that already has delete hooks or are
called from shutdown/cleanup code.

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/configfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 5e7932d668ab..ba17881a8d84 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -27,6 +27,7 @@
 #undef DEBUG
 
 #include <linux/fs.h>
+#include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -1804,6 +1805,7 @@ void configfs_unregister_group(struct config_group *group)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
+	fsnotify_rmdir(d_inode(parent), dentry);
 	d_delete(dentry);
 	inode_unlock(d_inode(parent));
 
@@ -1932,6 +1934,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
+	fsnotify_rmdir(d_inode(root), dentry);
 	inode_unlock(d_inode(dentry));
 
 	d_delete(dentry);
-- 
2.17.1

