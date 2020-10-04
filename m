Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC4728283E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 04:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgJDCkz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Oct 2020 22:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgJDCjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Oct 2020 22:39:31 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1D4C0613D0;
        Sat,  3 Oct 2020 19:39:31 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOtvu-00BUpm-0z; Sun, 04 Oct 2020 02:39:30 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: [RFC PATCH 05/27] untangling ep_call_nested(): take pushing cookie into a helper
Date:   Sun,  4 Oct 2020 03:39:07 +0100
Message-Id: <20201004023929.2740074-5-viro@ZenIV.linux.org.uk>
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
 fs/eventpoll.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 43aecae0935c..bd2cc78c47c8 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -424,6 +424,21 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
+static bool ep_push_nested(void *cookie)
+{
+	int i;
+
+	if (nesting > EP_MAX_NESTS) /* too deep nesting */
+		return false;
+
+	for (i = 0; i < nesting; i++) {
+		if (cookies[i] == cookie) /* loop detected */
+			return false;
+	}
+	cookies[nesting++] = cookie;
+	return true;
+}
+
 /**
  * ep_call_nested - Perform a bound (possibly) nested call, by checking
  *                  that the recursion limit is not exceeded, and that
@@ -440,17 +455,10 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 static int ep_call_nested(int (*nproc)(void *, void *, int), void *priv,
 			  void *cookie)
 {
-	int error, i;
+	int error;
 
-	if (nesting > EP_MAX_NESTS) /* too deep nesting */
+	if (!ep_push_nested(cookie))
 		return -1;
-
-	for (i = 0; i < nesting; i++) {
-		if (cookies[i] == cookie) /* loop detected */
-			return -1;
-	}
-	cookies[nesting++] = cookie;
-
 	/* Call the nested function */
 	error = (*nproc)(priv, cookie, nesting - 1);
 	nesting--;
-- 
2.11.0

