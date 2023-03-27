Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B3A6CACF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjC0SXO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC0SXJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:23:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D42840CB;
        Mon, 27 Mar 2023 11:23:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D8AAB818BC;
        Mon, 27 Mar 2023 18:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862A2C433D2;
        Mon, 27 Mar 2023 18:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679941384;
        bh=TNJCOio1Rm6H8bH6XbJFRUE6Yg7Pb43dg5K5QcL0diU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=b0HvNd+kZXtHoSvHRENpxlIo2kjAYayuM/+3si5bBEC36OZkhZUW2/inUkkkFVCxs
         H07NhvpfLfKGc4cK58iwpJj/IkdfExLaojRh922UIhw/6VN+sxg0Y/az7zEbam6lW4
         C3ZA+WOAw/D7ZwSX/tpE0FM6Pr/neMD5TmPPrJBQcFpBasTxHFPbwj1TLJWzRjM5CD
         18RaqYriL3gw6QgWHnR63hFEajKTgQPSjPMN9VkAoVKxKIC2FEhJicVJEflplJX1oK
         b75bdavBWF5hoESSnaZSyGpiO1HwUA7JOqVc5EB9KtHK9CfVcx2sqkmDdgWTYGcxA+
         2D0pX/PGRvruQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 27 Mar 2023 20:22:53 +0200
Subject: [PATCH 3/3] fanotify: use pidfd_prepare()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-pidfd-file-api-v1-3-5c0e9a3158e4@kernel.org>
References: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
In-Reply-To: <20230327-pidfd-file-api-v1-0-5c0e9a3158e4@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=2293; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TNJCOio1Rm6H8bH6XbJFRUE6Yg7Pb43dg5K5QcL0diU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQo3mf857bx57Q5Hq8DfDZp8R1W+Ny4gD9sBmt0cor7Odb7
 e2pcO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS1sbwP71L+INEhnNUpHZSoX5yt8
 N754og1n8iJyqVxP+WKL9kYvinsvVwyoNzyVNUrhxat39l0d4fXPs/xas2l+SGsc890PGAHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We generally try to avoid installing a file descriptor into the caller's
file descriptor table just to close it again via close_fd() in case an
error occurs. Instead we reserve a file descriptor but don't install it
into the caller's file descriptor table yet. If we fail for other,
unrelated reasons we can just close the reserved file descriptor and if
we make it past all meaningful error paths we just install it. Fanotify
gets this right already for one fd type but not for pidfds.

Use the new pidfd_prepare() helper to reserve a pidfd and a pidfd file
and switch to the more common fd allocation and installation pattern.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8f430bfad487..22fb1cf7e1fc 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -663,7 +663,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	struct fanotify_info *info = fanotify_event_info(event);
 	unsigned int info_mode = FAN_GROUP_FLAG(group, FANOTIFY_INFO_MODES);
 	unsigned int pidfd_mode = info_mode & FAN_REPORT_PIDFD;
-	struct file *f = NULL;
+	struct file *f = NULL, *pidfd_file = NULL;
 	int ret, pidfd = FAN_NOPIDFD, fd = FAN_NOFD;
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
@@ -718,7 +718,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		    !pid_has_task(event->pid, PIDTYPE_TGID)) {
 			pidfd = FAN_NOPIDFD;
 		} else {
-			pidfd = pidfd_create(event->pid, 0);
+			pidfd = pidfd_prepare(event->pid, 0, &pidfd_file);
 			if (pidfd < 0)
 				pidfd = FAN_EPIDFD;
 		}
@@ -751,6 +751,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (f)
 		fd_install(fd, f);
 
+	if (pidfd_file)
+		fd_install(pidfd, pidfd_file);
+
 	return metadata.event_len;
 
 out_close_fd:
@@ -759,8 +762,10 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 		fput(f);
 	}
 
-	if (pidfd >= 0)
-		close_fd(pidfd);
+	if (pidfd >= 0) {
+		put_unused_fd(pidfd);
+		fput(pidfd_file);
+	}
 
 	return ret;
 }

-- 
2.34.1

