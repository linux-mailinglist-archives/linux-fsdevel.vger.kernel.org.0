Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6F70EE4A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbjEXGmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbjEXGlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:41:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C471BDF;
        Tue, 23 May 2023 23:40:01 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64f1f133c37so153648b3a.0;
        Tue, 23 May 2023 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684910375; x=1687502375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKZBbPudpvUkgWMZGXvYBMCsV1NnL+LHrqZrmMQwp+k=;
        b=qFwJam6ymZ2So0z7pUCJIcNO7RqyV5oEwMbn3sNG6/jY2LsQ5nSzIxE8/fUWi/E4Jp
         cI1aJOteipJUyyJtvumqDoo5gNmblc1JrYGHz1HKS1s4DqMqyJNAGMuxVQlLiBP8fHTO
         2uJiL4F4s/vJnBGSHjmNgLyDhqdkNEMg94bYRUeAmq5XR7EbwuOIbVRfc08B7HE9OWcC
         HwQwfl5YCm0KMIy4XBhLyXiVLHZceB/fJp4hr4Nsg8qVu6UF0RWY2Bb1vA5dTlsFsFZ9
         270ym0TStv+S+6szxGf9Dls0WBaPu9q25R2wKyUiFaNfTbs/UanBVlpdIAGimmuOXsFU
         QOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910375; x=1687502375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKZBbPudpvUkgWMZGXvYBMCsV1NnL+LHrqZrmMQwp+k=;
        b=kPWdtEU9Zm7uEJyG153oncPcL0J+kMbnR8GgHprJawW6c1quvXyHCak+OAMS/mfS+C
         8sisOBwHQE1mbxmMpI3SdRo3HyXd/J2th0FO/SzdVVQNhmJ6XJpC56KQT45XngwY28bZ
         aWAOGTHtJaTUrGAwC6sSt3C3iR/br9lYomQrMQ6IIGfh0O1jqPu5HIEwhYUvhjURFE9A
         yl4r+CAbxj9G+qgXqWHkguxN5nSA2efNNKMa9Dhpq6/qGpVW7POek57qsE3kkPG6bcDp
         hdpqXuhEQeOLfS+yERMEIk/7NhLDKMIgaDAck7lB9FPmTipWpmLQkA0IWs5Rkb+NdPYt
         eZNw==
X-Gm-Message-State: AC+VfDwyuxtPeKuAPWRX75VtgNmKgYyaIDiKgGoEh0oPplz+HkgEftvE
        tnAGlN+AFUq1R/THd4njBEE=
X-Google-Smtp-Source: ACHHUZ7P4tBXrcOKPGsb4kx//V3l7wiu0ME9lSkm4dwC9/ns0IvMPPOwr3RiVESDDBCEE8Vm1E0zeQ==
X-Received: by 2002:a05:6a20:549b:b0:10c:b420:bf88 with SMTP id i27-20020a056a20549b00b0010cb420bf88mr1807949pzk.6.1684910375093;
        Tue, 23 May 2023 23:39:35 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b006437c0edf9csm6972703pfo.16.2023.05.23.23.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:39:34 -0700 (PDT)
From:   aloktiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, brauner@kernel.org,
        David.Laight@ACULAB.COM, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org, tycho@tycho.pizza,
        aloktiagi@gmail.com
Subject: [RFC v7 1/2] epoll: Implement eventpoll_replace_file()
Date:   Wed, 24 May 2023 06:39:32 +0000
Message-Id: <20230524063933.2339105-1-aloktiagi@gmail.com>
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
Changes in v7:
  - address review comments on incorrect use of spin_lock.
  - cleanup comments and simplify them.

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
 fs/eventpoll.c            | 75 +++++++++++++++++++++++++++++++++++++++
 include/linux/eventpoll.h |  2 ++
 2 files changed, 77 insertions(+)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 980483455cc0..60c14b549918 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -973,6 +973,81 @@ void eventpoll_release_file(struct file *file)
 	spin_unlock(&file->f_lock);
 }
 
+static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
+			struct file *tfile, int fd, int full_check);
+
+/*
+ * Replace a linked file in the epoll interface with a new file
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
+	hlist_for_each_entry_safe(epi, next, toreplace->f_ep, fllink) {
+		fd = epi->ffd.fd;
+		event = epi->event;
+		if (fd != tfd) {
+			spin_unlock(&toreplace->f_lock);
+			goto install;
+		}
+		ep = epi->ep;
+		ep_get(ep);
+		spin_unlock(&toreplace->f_lock);
+
+		mutex_lock(&ep->mtx);
+		error = ep_insert(ep, &event, file, fd, 1);
+		mutex_unlock(&ep->mtx);
+		if (error != 0)
+			goto error;
+		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
+install:
+		spin_lock(&toreplace->f_lock);
+	}
+	spin_unlock(&toreplace->f_lock);
+error:
+	/*
+	 * In case of an error remove all instances of the new file in the epoll
+	 * interface. If no error, remove all instances of the original file.
+	 */
+	if (error != 0)
+		to_remove = file;
+
+remove:
+	spin_lock(&to_remove->f_lock);
+	if (to_remove->f_ep && to_remove->f_ep->first) {
+		epi = hlist_entry(to_remove->f_ep->first, struct epitem, fllink);
+		fd = epi->ffd.fd;
+		if (fd != tfd) {
+			spin_unlock(&to_remove->f_lock);
+			goto remove;
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
+		goto remove;
+	}
+	spin_unlock(&to_remove->f_lock);
+	return error;
+}
+
 static int ep_alloc(struct eventpoll **pep)
 {
 	int error;
diff --git a/include/linux/eventpoll.h b/include/linux/eventpoll.h
index 3337745d81bd..f8d52c45a37a 100644
--- a/include/linux/eventpoll.h
+++ b/include/linux/eventpoll.h
@@ -25,6 +25,8 @@ struct file *get_epoll_tfile_raw_ptr(struct file *file, int tfd, unsigned long t
 /* Used to release the epoll bits inside the "struct file" */
 void eventpoll_release_file(struct file *file);
 
+int eventpoll_replace_file(struct file *toreplace, struct file *file, int tfd);
+
 /*
  * This is called from inside fs/file_table.c:__fput() to unlink files
  * from the eventpoll interface. We need to have this facility to cleanup
-- 
2.34.1

