Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA128282D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgJDCkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2D9C0613B0;
        Sat,  3 Oct 2020 19:39:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvx-00BUs4-NS; Sun, 04 Oct 2020 02:39:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 25/27] lift rcu_read_lock() into reverse_path_check()
Date:   Sun,  4 Oct 2020 03:39:27 +0100
Message-Id: <20201004023929.2740074-25-viro@ZenIV.linux.org.uk>
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
 fs/eventpoll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 78b8769b72dc..8a7ad752befd 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1257,7 +1257,6 @@ static int reverse_path_check_proc(struct file *file, int depth)
 		return -1;
 
 	/* CTL_DEL can remove links here, but that can't increase our count */
-	rcu_read_lock();
 	hlist_for_each_entry_rcu(epi, &file->f_ep_links, fllink) {
 		struct file *recepient = epi->ep->file;
 		if (WARN_ON(!is_file_epoll(recepient)))
@@ -1269,7 +1268,6 @@ static int reverse_path_check_proc(struct file *file, int depth)
 		if (error != 0)
 			break;
 	}
-	rcu_read_unlock();
 	return error;
 }
 
@@ -1291,7 +1289,9 @@ static int reverse_path_check(void)
 	/* let's call this for all tfiles */
 	list_for_each_entry(current_file, &tfile_check_list, f_tfile_llink) {
 		path_count_init();
+		rcu_read_lock();
 		error = reverse_path_check_proc(current_file, 0);
+		rcu_read_unlock();
 		if (error)
 			break;
 	}
-- 
2.11.0

