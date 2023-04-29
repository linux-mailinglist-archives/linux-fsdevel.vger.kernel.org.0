Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A096F2342
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 07:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjD2Fuo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 01:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjD2Fun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:50:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743A644AA;
        Fri, 28 Apr 2023 22:50:14 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63d32d21f95so149493b3a.1;
        Fri, 28 Apr 2023 22:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682747403; x=1685339403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LdvdU1sI6y4PoQgd2qWlZ9rU1baY4qp4XGI260HAaYU=;
        b=bzw6/Rd8ExBPd+0Q7sYx+r9M4pKpU2SpCZYL3XyqPuPc/EZXjcRioWQnhYF4RWlBs5
         MGxJIQ3iwAqQ5uWHd4U2x+BRrsy3/cGZLJxohBDR+qPLCdcFGTzoLTQNFHwDi42exvyL
         PsnszVRaJdYvZsKeNPNrh25SG3+TH68zcfFah0WiP9cU1C5C/Wk2l0KllVj1jz7XoOol
         XPPPDtrPdk3OXQIOOkfoErWOduyvD6Gx1r0bCtzJO8ao5RVFn0dOwKCHFkYvGIzayJqI
         IyPfj5Lu2iI5rj7jBb5o1kgnZtMQUTqK6MqlKtXU7FFX0BRt7WjWGkjop8EVxQwt/G3S
         HVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682747403; x=1685339403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdvdU1sI6y4PoQgd2qWlZ9rU1baY4qp4XGI260HAaYU=;
        b=GEPOGm4qSTUczA0NvxdmOo+mGch03tq3tAPot2Y01+JNWaxGfxBEcuqA0umCE+8Rzc
         dagte1N+H8xIviF4MgP786tPxugBzcR3iAIrwfAduzcYCoOFBdnm6vz+105E5AUYh9q3
         MMWgrn8bLz3V94OsN5l0DxV1aV/yaFcYsL+dCJzRaZWR+f0MYdmSWVne1elmWJil47Js
         xaSgwzJurRfPDJjXrGP+yMt/FNItCn3KHK8p25g8+HJZ0daHx1WRPCpRk8kQBvA9B5Y+
         WO3XrX+4Kgmocd/wM+K5dIc6FCHr3ksvrszkJVQQbafJjaR9FLxzOGLJrDHyfhdo2hYk
         W9Ig==
X-Gm-Message-State: AC+VfDyax1CmZtDD/dgzYwFa6SaVXNC/T42hfpezsNZuI/N5YMvDpl7z
        cMAi4p0m7S2/nFGB1laT734=
X-Google-Smtp-Source: ACHHUZ7tUCb5wEN9LP6hgHABe3vF4QRzUFYdV0W7fmbyw6PGXMrBuw/E74vlc0vNyXaZdDc4775h9g==
X-Received: by 2002:a05:6a00:1acb:b0:63f:21e:cad8 with SMTP id f11-20020a056a001acb00b0063f021ecad8mr9899843pfv.3.1682747403446;
        Fri, 28 Apr 2023 22:50:03 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id 20-20020a630514000000b005142206430fsm14126045pgf.36.2023.04.28.22.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 22:50:03 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org, tycho@tycho.pizza,
        aloktiagi@gmail.com
Subject: [RFC v5 1/2] epoll: Implement eventpoll_replace_file()
Date:   Sat, 29 Apr 2023 05:49:54 +0000
Message-Id: <20230429054955.1957024-1-aloktiagi@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a mechanism to replace a file linked in the epoll interface with a new
file.

eventpoll_replace() finds all instances of the file to be replaced and replaces
them with the new file and the interested events.

Signed-off-by: aloktiagi <aloktiagi@gmail.com>
---
Changes in v5:
  - address review comments and move the call to replace old file in each
    subsystem (epoll, io_uring, etc.) outside the fdtable helpers like
    replace_fd().

Changes in v4:
  - address review comment to remove the redundant eventpoll_replace() function.
  - removed an extra empty line introduced in include/linux/file.h

Changes in v3:
  - address review comment and iterate over the file table while holding the
    spin_lock(&files->file_lock).
  - address review comment and call filp_close() outside the
    spin_lock(&files->file_lock).
---
 fs/eventpoll.c            | 65 +++++++++++++++++++++++++++++++++++++++
 include/linux/eventpoll.h |  8 +++++
 2 files changed, 73 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 64659b110973..be9d192b223d 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -935,6 +935,71 @@ void eventpoll_release_file(struct file *file)
 	mutex_unlock(&epmutex);
 }
 
+static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
+			struct file *tfile, int fd, int full_check);
+
+/*
+ * This is called from eventpoll_replace() to replace a linked file in the epoll
+ * interface with a new file received from another process. This is useful in
+ * cases where a process is trying to install a new file for an existing one
+ * that is linked in the epoll interface
+ */
+int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd)
+{
+	int fd;
+	int error = 0;
+	struct eventpoll *ep;
+	struct epitem *epi;
+	struct hlist_node *next;
+	struct epoll_event event;
+	struct hlist_head *to_remove = toreplace->f_ep;
+
+	if (!file_can_poll(file))
+		return 0;
+
+	mutex_lock(&epmutex);
+	if (unlikely(!toreplace->f_ep)) {
+		mutex_unlock(&epmutex);
+		return 0;
+	}
+
+	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
+		ep = epi->ep;
+		mutex_lock(&ep->mtx);
+		fd = epi->ffd.fd;
+		if (fd != tfd) {
+			mutex_unlock(&ep->mtx);
+			continue;
+		}
+		event = epi->event;
+		error = ep_insert(ep, &event, file, fd, 1);
+		mutex_unlock(&ep->mtx);
+		if (error != 0) {
+			break;
+		}
+	}
+	/*
+	 * In case of an error remove all instances of the new file in the epoll
+	 * interface. If no error, remove all instances of the original file.
+	 */
+	if (error != 0)
+		to_remove = file->f_ep;
+
+	hlist_for_each_entry_safe(epi, next, to_remove, fllink) {
+		ep = epi->ep;
+		mutex_lock(&ep->mtx);
+		fd = epi->ffd.fd;
+		if (fd != tfd) {
+			mutex_unlock(&ep->mtx);
+			continue;
+		}
+		ep_remove(ep, epi);
+		mutex_unlock(&ep->mtx);
+	}
+	mutex_unlock(&epmutex);
+	return error;
+}
+
 static int ep_alloc(struct eventpoll **pep)
 {
 	int error;
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 3337745d81bd..2a6c8f52f272 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -25,6 +25,14 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
+/*
+ * This is called from fs/file.c:do_replace() to replace a linked file in the
+ * epoll interface with a new file received from another process. This is useful
+ * in cases where a process is trying to install a new file for an existing one
+ * that is linked in the epoll interface
+ */
+int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
-- 
2.34.1

