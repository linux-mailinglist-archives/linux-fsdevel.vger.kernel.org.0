Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61622282841
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgJDCky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgJDCjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02299C0613E9;
        Sat,  3 Oct 2020 19:39:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvu-00BUq6-GG; Sun, 04 Oct 2020 02:39:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 08/27] reverse_path_check_proc(): sane arguments
Date:   Sun,  4 Oct 2020 03:39:10 +0100
Message-Id: <20201004023929.2740074-8-viro@ZenIV.linux.org.uk>
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

no need to force its calling conventions to match the callback for
late unlamented ep_call_nested()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8c3b02755a50..3e6f1f97f246 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1306,20 +1306,18 @@ static void path_count_init(void)
 		path_count[i] = 0;
 }
 
-static int reverse_path_check_proc(void *priv, void *cookie, int depth)
+static int reverse_path_check_proc(struct file *file, int depth)
 {
 	int error = 0;
-	struct file *file = priv;
-	struct file *child_file;
 	struct epitem *epi;
 
-	if (!ep_push_nested(cookie)) /* limits recursion */
+	if (!ep_push_nested(file)) /* limits recursion */
 		return -1;
 
 	/* CTL_DEL can remove links here, but that can't increase our count */
 	rcu_read_lock();
 	list_for_each_entry_rcu(epi, &file->f_ep_links, fllink) {
-		child_file = epi->ep->file;
+		struct file *child_file = epi->ep->file;
 		if (is_file_epoll(child_file)) {
 			if (list_empty(&child_file->f_ep_links)) {
 				if (path_count_inc(depth)) {
@@ -1327,7 +1325,7 @@ static int reverse_path_check_proc(void *priv, void *cookie, int depth)
 					break;
 				}
 			} else {
-				error = reverse_path_check_proc(child_file, child_file,
+				error = reverse_path_check_proc(child_file,
 								depth + 1);
 			}
 			if (error != 0)
@@ -1360,7 +1358,7 @@ static int reverse_path_check(void)
 	/* let's call this for all tfiles */
 	list_for_each_entry(current_file, &tfile_check_list, f_tfile_llink) {
 		path_count_init();
-		error = reverse_path_check_proc(current_file, current_file, 0);
+		error = reverse_path_check_proc(current_file, 0);
 		if (error)
 			break;
 	}
-- 
2.11.0

