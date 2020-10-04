Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFDC8282842
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgJDCky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgJDCjc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:32 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0AAC061787;
        Sat,  3 Oct 2020 19:39:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvu-00BUqE-QM; Sun, 04 Oct 2020 02:39:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 09/27] reverse_path_check_proc(): don't bother with cookies
Date:   Sun,  4 Oct 2020 03:39:11 +0100
Message-Id: <20201004023929.2740074-9-viro@ZenIV.linux.org.uk>
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

We know there's no loops by the time we call it; the
only thing we care about is too deep reverse paths.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/eventpoll.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3e6f1f97f246..0f540e91aa92 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1311,7 +1311,7 @@ static int reverse_path_check_proc(struct file *file, int depth)
 	int error = 0;
 	struct epitem *epi;
 
-	if (!ep_push_nested(file)) /* limits recursion */
+	if (depth > EP_MAX_NESTS) /* too deep nesting */
 		return -1;
 
 	/* CTL_DEL can remove links here, but that can't increase our count */
@@ -1336,7 +1336,6 @@ static int reverse_path_check_proc(struct file *file, int depth)
 		}
 	}
 	rcu_read_unlock();
-	nesting--; /* pop */
 	return error;
 }
 
-- 
2.11.0

