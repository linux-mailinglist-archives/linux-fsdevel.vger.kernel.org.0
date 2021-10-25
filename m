Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B7743A4F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Oct 2021 22:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhJYUuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Oct 2021 16:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233075AbhJYUuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Oct 2021 16:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635194857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LmjTvdLZfKSO97118jaqUqatvqISIHepsxfGh7l9v9g=;
        b=ea/1Ni7zmiPL7c1SIAhnvp8cMkGyOmDeT0ZE8EPKTJJ9r7Ew45t973AiWl+Hw1rRF8n7Bf
        pe0tAX696duPyAz2hk/gVIP0JqMLubxWSFtdgqTAldtffGui0yYeIdnDCWpxVWf0iIUv6R
        aCM/WxDqgdGDVFe4tQvDXvRo1xHQ3Kg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-m0-k7rSfOlu-PiZzgsOlyg-1; Mon, 25 Oct 2021 16:47:34 -0400
X-MC-Unique: m0-k7rSfOlu-PiZzgsOlyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1E5C8018AC;
        Mon, 25 Oct 2021 20:47:30 +0000 (UTC)
Received: from iangelak.redhat.com (unknown [10.22.32.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FB7A60BF1;
        Mon, 25 Oct 2021 20:47:26 +0000 (UTC)
From:   Ioannis Angelakopoulos <iangelak@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        linux-kernel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com,
        viro@zeniv.linux.org.uk, miklos@szeredi.hu, vgoyal@redhat.com
Cc:     Ioannis Angelakopoulos <iangelak@redhat.com>
Subject: [RFC PATCH 4/7] FUSE: Add the fuse_fsnotify_send_request to FUSE
Date:   Mon, 25 Oct 2021 16:46:31 -0400
Message-Id: <20211025204634.2517-5-iangelak@redhat.com>
In-Reply-To: <20211025204634.2517-1-iangelak@redhat.com>
References: <20211025204634.2517-1-iangelak@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function "fuse_fsnotify_send_request" is responsible for sending an
fsnotify FUSE request to the FUSE server (virtiofsd).

The request contains all the information that is stored within the
"fuse_notify_fsnotify_in" struct, i.e., the event mask for the inotify
watch, the action to be performed on the watch (create, modify or delete)
and the group identifier which is essentially the 64bit (fsnotify_group)
pointer that corresponds to one inotify instance created by a user space
process.

Since each group identifier is unique, the FUSE server can create an equal
number of inotify instances to the ones created by the user space
processes.

Signed-off-by: Ioannis Angelakopoulos <iangelak@redhat.com>
---
 fs/fuse/dev.c    | 37 +++++++++++++++++++++++++++++++++++++
 fs/fuse/fuse_i.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dde341a6388a..89eea8abac4b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1795,6 +1795,43 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	}
 }
 
+/* Send a request for a watch placement to the FUSE server */
+int fuse_fsnotify_send_request(struct inode *inode, uint32_t mask,
+			       uint32_t action, uint64_t group)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_notify_fsnotify_in inarg;
+	int err;
+	FUSE_ARGS(args);
+
+	/* The server does not support remote fsnotify events */
+	if (fm->fc->no_fsnotify)
+		return 0;
+
+	/*
+	 * Send the mask the action (remove, add, modify) and the
+	 * unique identifier that is the fsnotify group that is
+	 * interested in the watch to the FUSE server
+	 */
+	memset(&inarg, 0, sizeof(struct fuse_notify_fsnotify_in));
+	inarg.mask = mask;
+	inarg.action = action;
+	inarg.group = (uint64_t)group;
+
+	args.opcode = FUSE_FSNOTIFY;
+	args.nodeid = get_node_id(inode);
+	args.in_numargs = 1;
+	args.in_args[0].size = sizeof(struct fuse_notify_fsnotify_in);
+	args.in_args[0].value = &inarg;
+	args.out_numargs = 0;
+	args.force = true;
+
+	err = fuse_simple_request(fm, &args);
+
+	return err;
+}
+EXPORT_SYMBOL(fuse_fsnotify_send_request);
+
 /* Look up request on processing list by unique ID */
 static struct fuse_req *request_find(struct fuse_pqueue *fpq, u64 unique)
 {
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c3cebfb936d2..5c83c4535608 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1243,6 +1243,9 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu);
 int fuse_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 		 struct posix_acl *acl, int type);
 
+int fuse_fsnotify_send_request(struct inode *inode, uint32_t mask,
+			       uint32_t action, uint64_t group);
+
 /* readdir.c */
 int fuse_readdir(struct file *file, struct dir_context *ctx);
 
-- 
2.33.0

