Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE927EEA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgI3QMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 12:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725800AbgI3QMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 12:12:37 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601482356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7KkJqRrSkB1gl6+3x2IwQEGRxET0aPXXUe4LBKhzI2k=;
        b=MlmmKMr8EXls74PkuFlsfc81LHSmbXzBCqVn/mML/XvG9scsYnc0k7pLWj6jhLeP5AiSv1
        wElTQWYt9txl9AYVwto628ja5us+YHoa0Swc6EuVS6s8eua8JASnDKDmWb8JmHke06b1vr
        Bq1d4qpSELBfnd4roGhZNApHXX535mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-YwcWIiCMP7KcDBBy25Lvgg-1; Wed, 30 Sep 2020 12:12:34 -0400
X-MC-Unique: YwcWIiCMP7KcDBBy25Lvgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 181301891E84;
        Wed, 30 Sep 2020 16:12:33 +0000 (UTC)
Received: from x2.localnet (ovpn-117-41.rdu2.redhat.com [10.10.117.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E2DF1C4;
        Wed, 30 Sep 2020 16:12:27 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Eric Paris <eparis@redhat.com>
Subject: [PATCH 1/3] fanotify: Ensure consistent variable type for response
Date:   Wed, 30 Sep 2020 12:12:24 -0400
Message-ID: <12617626.uLZWGnKmhe@x2>
Organization: Red Hat
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The user space API for the response variable is __u32. This patch makes
sure that the whole path through the kernel uses __u32 so that there is
no sign extension or truncation of the user space response.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 fs/notify/fanotify/fanotify.h      | 2 +-
 fs/notify/fanotify/fanotify_user.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 8ce7ccfc4b0d..c397993830ac 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -165,7 +165,7 @@ FANOTIFY_PE(struct fanotify_event *event)
 struct fanotify_perm_event {
 	struct fanotify_event fae;
 	struct path path;
-	unsigned short response;	/* userspace answer to the event */
+	__u32 response;			/* userspace answer to the event */
 	unsigned short state;		/* state of the event */
 	int fd;		/* fd we passed to userspace for this event */
 };
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 63b5dffdca9e..c8da9ea1e76e 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -157,7 +157,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
  */
 static void finish_permission_event(struct fsnotify_group *group,
 				    struct fanotify_perm_event *event,
-				    unsigned int response)
+				    __u32 response)
 				    __releases(&group->notification_lock)
 {
 	bool destroy = false;
@@ -178,7 +178,7 @@ static int process_access_response(struct fsnotify_group *group,
 {
 	struct fanotify_perm_event *event;
 	int fd = response_struct->fd;
-	int response = response_struct->response;
+	__u32 response = response_struct->response;
 
 	pr_debug("%s: group=%p fd=%d response=%d\n", __func__, group,
 		 fd, response);
-- 
2.26.2




