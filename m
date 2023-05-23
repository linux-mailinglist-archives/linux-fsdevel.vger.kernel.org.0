Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A4470D468
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 08:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjEWG6K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 02:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjEWG6H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 02:58:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2B0118;
        Mon, 22 May 2023 23:58:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae4e6825e1so5141555ad.1;
        Mon, 22 May 2023 23:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684825085; x=1687417085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM5XT34cBgfv2Ij0f5DaXFjWbPMhSNcnbAxzrFczaLA=;
        b=enz8Xedziz0f/8RAVBRgSmFDM6ymyjmhV+LSl/7T1SBesmct1vlTDkARGIloJKq1iB
         v6DidmujpipnUbDrB4/zlqlodRuy+vgpQvzhdJ3PgKDP8opkpONgkOakfFgYxbwBiA4H
         rOfZGeRQAQHyhnH0P6n+dJQtuLibTWJ6G7JzTynJPOqHNPKAhcZMD01+Mw+GH4dMwloC
         8U3T265n73yaujLpSRx9cMoQ1EK6MqEUf/apKSY3VUIPT+GwhjtK9SUnstDacjXvxaFG
         kGQFidS0X01bEvVfkpWfJbVIdW2SAnpSQcgV4T2kVT9HKg3qwwdh+1UZk24Zyr3PgWpc
         XWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684825085; x=1687417085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZM5XT34cBgfv2Ij0f5DaXFjWbPMhSNcnbAxzrFczaLA=;
        b=BXteiSBw2tlAnO2MVN71Y8PZGBkdHHpTBI/PEU8wM4I9JUHwNOTmVSImN4jODhuymg
         K1Ul5FrhKtN+u7ps9EodRQcRnHGzGsMCe21BnvuT7Q8WJUlweaQ7o8/oaexMGFcyWcj2
         JVry6Zu3RmNrrhRINWUh3t9Q4nehlfczP2T/A8l8i5zZsOrtM6rZJKVXuoNIsa8oZd21
         EtaSM8Vd8zz78I3dQTgvH6We5+vBg0Y7VdnICSnlY3A6Ps4XVyGsjlNZW0V7CqaMxjzm
         etIvgxofsvhP+NLCSme3/NacaNHFUegeNwGde289h9PMPB+q7KBWwle8Y2z4kvSNgawa
         1dnQ==
X-Gm-Message-State: AC+VfDwHElQKXZrJ1qkYFMzyDN2OMrPdqbXjaofPU9bm9C4zJaBzmmYg
        pXptHzSPEvGFV7B1/A81EqU=
X-Google-Smtp-Source: ACHHUZ4hoYHbCLeAYftgyfacucJMQaWwahMLBSH7Gx8CpNbTlKgOxp9CsTTNrEsv5eqMP9vKMttLsg==
X-Received: by 2002:a17:902:daca:b0:1ad:eada:598b with SMTP id q10-20020a170902daca00b001adeada598bmr14938496plx.3.1684825085543;
        Mon, 22 May 2023 23:58:05 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090282c600b001ac912cac1asm5945593plz.175.2023.05.22.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 23:58:05 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org, tycho@tycho.pizza,
        aloktiagi@gmail.com
Subject: [RFC v6 1/2] epoll: Implement eventpoll_replace_file()
Date:   Tue, 23 May 2023 06:58:01 +0000
Message-Id: <20230523065802.2253926-1-aloktiagi@gmail.com>
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
Changes in v6:
  - incorporate latest changes that get rid of the global epmutex lock.

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
 fs/eventpoll.c            | 76 +++++++++++++++++++++++++++++++++++++++
 include/linux/eventpoll.h |  8 +++++
 2 files changed, 84 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 980483455cc0..9c7bffa8401b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -973,6 +973,82 @@ void eventpoll_release_file(struct file *file)
 	spin_unlock(&file->f_lock);
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
+	struct file *to_remove = toreplace;
+	struct epoll_event event;
+	struct hlist_node *next;
+	struct eventpoll *ep;
+	struct epitem *epi;
+	int error = 0;
+	bool dispose;
+	int fd;
+
+	if (!file_can_poll(file))
+		return 0;
+
+	spin_lock(&toreplace->f_lock);
+	if (unlikely(!toreplace->f_ep)) {
+		spin_unlock(&toreplace->f_lock);
+		return 0;
+	}
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
+	spin_unlock(&toreplace->f_lock);
+	/*
+	 * In case of an error remove all instances of the new file in the epoll
+	 * interface. If no error, remove all instances of the original file.
+	 */
+	if (error != 0)
+		to_remove = file;
+
+again:
+	spin_lock(&to_remove->f_lock);
+	if (to_remove->f_ep && to_remove->f_ep->first) {
+		epi = hlist_entry(to_remove->f_ep->first, struct epitem, fllink);
+		fd = epi->ffd.fd;
+		if (fd != tfd) {
+			spin_unlock(&to_remove->f_lock);
+			goto again;
+		}
+		epi->dying = true;
+		spin_unlock(&to_remove->f_lock);
+
+		ep = epi->ep;
+		mutex_lock(&ep->mtx);
+		dispose = __ep_remove(ep, epi, true);
+		mutex_unlock(&ep->mtx);
+
+		if (dispose)
+			ep_free(ep);
+		goto again;
+	}
+	spin_unlock(&to_remove->f_lock);
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

