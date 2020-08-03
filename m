Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7714423A7D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 15:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgHCNjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 09:39:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39763 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728335AbgHCNjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596461986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DZxLRDT3DbjNA1BkBmmaWmJP0JxdK6fFFyOL238OtQ=;
        b=hzK8ycTmtTXLURWS3hYBkLcDFxIADaKwoco/EjtsJ+7c6bqDqOm0WYg2xhEnflM1pjgZIw
        4qYZm5iSuZ8eJx3Y80ljkdD3ersgmdl88UZsSu7HYoa2iIke91Imj3C4b70f5USoKAAstT
        5VjNdX3JnTkHvbSQqGJIrR35ejml/X8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-7ZNbRZbaOveIyGV-6b-phg-1; Mon, 03 Aug 2020 09:39:40 -0400
X-MC-Unique: 7ZNbRZbaOveIyGV-6b-phg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 811C1803025;
        Mon,  3 Aug 2020 13:39:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE2D560FC2;
        Mon,  3 Aug 2020 13:38:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 17/18] vfs: allow fsinfo to fetch the current state of
 s_wb_err [ver #21]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Jeff Layton <jlayton@kernel.org>, dhowells@redhat.com,
        torvalds@linux-foundation.org, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io, jannh@google.com,
        darrick.wong@oracle.com, kzak@redhat.com, jlayton@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 03 Aug 2020 14:38:54 +0100
Message-ID: <159646193490.1784947.15753060107959291101.stgit@warthog.procyon.org.uk>
In-Reply-To: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
References: <159646178122.1784947.11705396571718464082.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

Add a new "error_state" struct to fsinfo, and teach the kernel to fill
that out from sb->s_wb_err. There are two fields:

wb_error_last: the most recently recorded errno for the filesystem

wb_error_cookie: this value will change vs. the previously fetched
                 value if a new error was recorded since it was last
		 checked. Callers should treat this as an opaque value
		 that can be compared to earlier fetched values.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                 |   11 +++++++++++
 include/uapi/linux/fsinfo.h |   13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index f230124ffdf5..ea9d9821d76b 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -274,6 +274,16 @@ static int fsinfo_generic_seq_read(struct path *path, struct fsinfo_context *ctx
 	return m.count + 1;
 }
 
+static int fsinfo_generic_error_state(struct path *path,
+				      struct fsinfo_context *ctx)
+{
+	struct fsinfo_error_state *es = ctx->buffer;
+
+	es->wb_error_cookie = errseq_scrape(&path->dentry->d_sb->s_wb_err);
+	es->wb_error_last = es->wb_error_cookie & MAX_ERRNO;
+	return sizeof(*es);
+}
+
 static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_VSTRUCT	(FSINFO_ATTR_STATFS,		fsinfo_generic_statfs),
 	FSINFO_VSTRUCT	(FSINFO_ATTR_IDS,		fsinfo_generic_ids),
@@ -286,6 +296,7 @@ static const struct fsinfo_attribute fsinfo_common_attributes[] = {
 	FSINFO_STRING	(FSINFO_ATTR_SOURCE,		fsinfo_generic_mount_source),
 	FSINFO_STRING	(FSINFO_ATTR_CONFIGURATION,	fsinfo_generic_seq_read),
 	FSINFO_STRING	(FSINFO_ATTR_FS_STATISTICS,	fsinfo_generic_seq_read),
+	FSINFO_VSTRUCT	(FSINFO_ATTR_ERROR_STATE,	fsinfo_generic_error_state),
 
 	FSINFO_LIST	(FSINFO_ATTR_FSINFO_ATTRIBUTES,	(void *)123UL),
 	FSINFO_VSTRUCT_N(FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO, (void *)123UL),
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index e40192d98648..dcd764771a7d 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -27,6 +27,7 @@
 #define FSINFO_ATTR_SOURCE		0x09	/* Superblock source/device name (string) */
 #define FSINFO_ATTR_CONFIGURATION	0x0a	/* Superblock configuration/options (string) */
 #define FSINFO_ATTR_FS_STATISTICS	0x0b	/* Superblock filesystem statistics (string) */
+#define FSINFO_ATTR_ERROR_STATE		0x0c	/* Superblock writeback error state */
 
 #define FSINFO_ATTR_FSINFO_ATTRIBUTE_INFO 0x100	/* Information about attr N (for path) */
 #define FSINFO_ATTR_FSINFO_ATTRIBUTES	0x101	/* List of supported attrs (for path) */
@@ -328,4 +329,16 @@ struct fsinfo_afs_server_address {
 
 #define FSINFO_ATTR_AFS_SERVER_ADDRESSES__STRUCT struct fsinfo_afs_server_address
 
+/*
+ * Information struct for fsinfo(FSINFO_ATTR_ERROR_STATE).
+ *
+ * Retrieve the error state for a filesystem.
+ */
+struct fsinfo_error_state {
+	__u32		wb_error_cookie;	/* writeback error cookie */
+	__u32		wb_error_last;		/* latest writeback error */
+};
+
+#define FSINFO_ATTR_ERROR_STATE__STRUCT struct fsinfo_error_state
+
 #endif /* _UAPI_LINUX_FSINFO_H */


