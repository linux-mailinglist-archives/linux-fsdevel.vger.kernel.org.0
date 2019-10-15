Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE2D7760
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfJONZY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 09:25:24 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:47848 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfJONZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:25:24 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKMpE-00037l-4J; Tue, 15 Oct 2019 14:25:20 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKMpD-0005gg-GA; Tue, 15 Oct 2019 14:25:19 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fsnotify: move declaration of fsnotify_mark_connector_cachep to fsnotify.h
Date:   Tue, 15 Oct 2019 14:25:18 +0100
Message-Id: <20191015132518.21819-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move fsnotify_mark_connector_cachep to fsnotify.h to properly
share it with the user in mark.c and avoid the following warning
from sparse:

fs/notify/mark.c:82:19: warning: symbol 'fsnotify_mark_connector_cachep' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/notify/fsnotify.c | 2 --
 fs/notify/fsnotify.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 2ecef6155fc0..3e77b728a22b 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -381,8 +381,6 @@ int fsnotify(struct inode *to_tell, __u32 mask, const void *data, int data_is,
 }
 EXPORT_SYMBOL_GPL(fsnotify);
 
-extern struct kmem_cache *fsnotify_mark_connector_cachep;
-
 static __init int fsnotify_init(void)
 {
 	int ret;
diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index f3462828a0e2..ff2063ec6b0f 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -65,4 +65,6 @@ extern void __fsnotify_update_child_dentry_flags(struct inode *inode);
 extern struct fsnotify_event_holder *fsnotify_alloc_event_holder(void);
 extern void fsnotify_destroy_event_holder(struct fsnotify_event_holder *holder);
 
+extern struct kmem_cache *fsnotify_mark_connector_cachep;
+
 #endif	/* __FS_NOTIFY_FSNOTIFY_H_ */
-- 
2.23.0

