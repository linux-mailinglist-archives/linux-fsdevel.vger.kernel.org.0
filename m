Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7EC3B7855
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhF2TOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:14:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34860 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhF2TOx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:14:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7E4891F431AF
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        jack@suse.com, dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 05/15] inotify: Don't force FS_IN_IGNORED
Date:   Tue, 29 Jun 2021 15:10:25 -0400
Message-Id: <20210629191035.681913-6-krisman@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629191035.681913-1-krisman@collabora.com>
References: <20210629191035.681913-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to Amir:

"FS_IN_IGNORED is completely internal to inotify and there is no need
to set it in i_fsnotify_mask at all, so if we remove the bit from the
output of inotify_arg_to_mask() no functionality will change and we will
be able to overload the event bit for FS_ERROR."

This is done in preparation to overload FS_ERROR with the notification
mechanism in fanotify.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 98f61b31745a..4d17be6dd58d 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -89,10 +89,10 @@ static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
 	__u32 mask;
 
 	/*
-	 * Everything should accept their own ignored and should receive events
-	 * when the inode is unmounted.  All directories care about children.
+	 * Everything should receive events when the inode is unmounted.
+	 * All directories care about children.
 	 */
-	mask = (FS_IN_IGNORED | FS_UNMOUNT);
+	mask = (FS_UNMOUNT);
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_EVENT_ON_CHILD;
 
-- 
2.32.0

