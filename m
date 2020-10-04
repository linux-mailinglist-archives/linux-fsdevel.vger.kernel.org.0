Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31A428283C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgJDCky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgJDCjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74DC0613A5;
        Sat,  3 Oct 2020 19:39:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvv-00BUqM-0O; Sun, 04 Oct 2020 02:39:31 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 10/27] clean reverse_path_check_proc() a bit
Date:   Sun,  4 Oct 2020 03:39:12 +0100
Message-Id: <20201004023929.2740074-10-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
References: <20201004023608.GM3421308@ZenIV.linux.org.uk>
 <20201004023929.2740074-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 0f540e91aa92..33af838046ea 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1317,23 +1317,15 @@ static int reverse_path_check_proc(struct file *file, int depth)
 	/* CTL_DEL can remove links here, but that can't increase our count */
 	rcu_read_lock();
 	list_for_each_entry_rcu(epi, &file->f_ep_links, fllink) {
-		struct file *child_file = epi->ep->file;
-		if (is_file_epoll(child_file)) {
-			if (list_empty(&child_file->f_ep_links)) {
-				if (path_count_inc(depth)) {
-					error = -1;
-					break;
-				}
-			} else {
-				error = reverse_path_check_proc(child_file,
-								depth + 1);
-			}
-			if (error != 0)
-				break;
-		} else {
-			printk(KERN_ERR "reverse_path_check_proc: "
-				"file is not an ep!\n");
-		}
+		struct file *recepient = epi->ep->file;
+		if (WARN_ON(!is_file_epoll(recepient)))
+			continue;
+		if (list_empty(&recepient->f_ep_links))
+			error = path_count_inc(depth);
+		else
+			error = reverse_path_check_proc(recepient, depth + 1);
+		if (error != 0)
+			break;
 	}
 	rcu_read_unlock();
 	return error;
-- 
2.11.0

