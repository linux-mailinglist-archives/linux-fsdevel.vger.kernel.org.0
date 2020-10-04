Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59254282825
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgJDCkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgJDCji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472BC0613B1;
        Sat,  3 Oct 2020 19:39:35 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvx-00BUsC-T1; Sun, 04 Oct 2020 02:39:33 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 26/27] epoll: massage the check list insertion
Date:   Sun,  4 Oct 2020 03:39:28 +0100
Message-Id: <20201004023929.2740074-26-viro@ZenIV.linux.org.uk>
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

in the "non-epoll target" cases do it in ep_insert() rather than
in do_epoll_ctl(), so that we do it only with some epitem is already
guaranteed to exist.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 8a7ad752befd..eea269670168 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1375,6 +1375,10 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	spin_lock(&tfile->f_lock);
 	hlist_add_head_rcu(&epi->fllink, &tfile->f_ep_links);
 	spin_unlock(&tfile->f_lock);
+	if (full_check && !tep) {
+		get_file(tfile);
+		list_add(&tfile->f_tfile_llink, &tfile_check_list);
+	}
 
 	/*
 	 * Add the current item to the RB tree. All RB tree operations are
@@ -2013,10 +2017,6 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 				error = -ELOOP;
 				if (ep_loop_check(ep, tep) != 0)
 					goto error_tgt_fput;
-			} else {
-				get_file(tf.file);
-				list_add(&tf.file->f_tfile_llink,
-							&tfile_check_list);
 			}
 			error = epoll_mutex_lock(&ep->mtx, 0, nonblock);
 			if (error)
-- 
2.11.0

