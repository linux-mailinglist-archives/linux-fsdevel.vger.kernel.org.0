Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DD01CC571
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgEIXqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728756AbgEIXqG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:06 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06513C05BD10;
        Sat,  9 May 2020 16:46:03 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAM-004iRS-Ih; Sat, 09 May 2020 23:45:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH 05/20] tomoyo_write_control(): get rid of pointless access_ok()
Date:   Sun, 10 May 2020 00:45:42 +0100
Message-Id: <20200509234557.1124086-5-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

address is passed only to get_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/tomoyo/common.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index 1b467381986f..f93f8acd05f7 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2662,8 +2662,6 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 	if (!head->write)
 		return -EINVAL;
-	if (!access_ok(buffer, buffer_len))
-		return -EFAULT;
 	if (mutex_lock_interruptible(&head->io_sem))
 		return -EINTR;
 	head->read_user_buf_avail = 0;
-- 
2.11.0

