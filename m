Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3284751713C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 16:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiEBOJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 10:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236744AbiEBOJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 10:09:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECAEE03F;
        Mon,  2 May 2022 07:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6120AB8115F;
        Mon,  2 May 2022 14:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7230AC385AC;
        Mon,  2 May 2022 14:06:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eWJc49DY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651500379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+7+HGir1Cy6uU4bq/QSK6Sa0K4vOQe5UFQEDdB+7RMI=;
        b=eWJc49DY3MlUFo3eogAJqMeRkRrRIoCzUvKiQAh5btUyGLkMzSvCJcS5QPFb2l8HKapJrg
        nQE7N4FjRz4A5porfk0mUwLD5XcKSjb9z3rFmNGVwvS3vfTMF8Lfpu6EGhjL6xXtTqxOuQ
        UuocIv+v31Sgk/OWwIhfVawGtbu61Z8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 160ad175 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 2 May 2022 14:06:18 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] sysctl: read() must consume poll events, not poll()
Date:   Mon,  2 May 2022 16:06:01 +0200
Message-Id: <20220502140602.130373-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Events that poll() responds to are supposed to be consumed when the file
is read(), not by the poll() itself. By putting it on the poll() itself,
it makes it impossible to poll() on a epoll file descriptor, since the
event gets consumed too early. Jann wrote a PoC, available in the link
below.

Reported-by: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/lkml/CAG48ez1F0P7Wnp=PGhiUej=u=8CSF6gpD9J=Oxxg0buFRqV1tA@mail.gmail.com/
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/proc/proc_sysctl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 7d9cfc730bd4..1aa145794207 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -622,6 +622,14 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 
 static ssize_t proc_sys_read(struct kiocb *iocb, struct iov_iter *iter)
 {
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct ctl_table_header *head = grab_header(inode);
+	struct ctl_table *table = PROC_I(inode)->sysctl_entry;
+
+	if (!IS_ERR(head) && table->poll)
+		iocb->ki_filp->private_data = proc_sys_poll_event(table->poll);
+	sysctl_head_finish(head);
+
 	return proc_sys_call_handler(iocb, iter, 0);
 }
 
@@ -668,10 +676,8 @@ static __poll_t proc_sys_poll(struct file *filp, poll_table *wait)
 	event = (unsigned long)filp->private_data;
 	poll_wait(filp, &table->poll->wait, wait);
 
-	if (event != atomic_read(&table->poll->event)) {
-		filp->private_data = proc_sys_poll_event(table->poll);
+	if (event != atomic_read(&table->poll->event))
 		ret = EPOLLIN | EPOLLRDNORM | EPOLLERR | EPOLLPRI;
-	}
 
 out:
 	sysctl_head_finish(head);
-- 
2.35.1

