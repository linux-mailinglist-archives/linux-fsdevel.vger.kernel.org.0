Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1751A346C45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 23:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhCWWUz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 18:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20160 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233973AbhCWWS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:18:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616537937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2W0exWLSGTJpS0Yt/E/f+oAPv1dd37g2MQqu0AUVZ4=;
        b=I9pYhRHoUqyjWJHQAnchENsw1eJZ47uKd16r0P53PRNO87F+qAv36X/kDPVQn2DtBV3kSi
        YUT44uQI9cQI3NXX9of5Zcq0HYrKr1rTM8KHaRMH0+0Fq8qK1ylw+xrkxYKdAM7ASmUN4y
        APaBOEFuB7I6qmv2ONoeGJtoi9mE7k0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-Tx7uHqxIOJSkquA2xzGMSg-1; Tue, 23 Mar 2021 18:18:55 -0400
X-MC-Unique: Tx7uHqxIOJSkquA2xzGMSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82CC1107ACCA;
        Tue, 23 Mar 2021 22:18:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-58.rdu2.redhat.com [10.10.112.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AFC81007606;
        Tue, 23 Mar 2021 22:18:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 07/28] netfs,
 mm: Move PG_fscache helper funcs to linux/netfs.h
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Mar 2021 22:18:49 +0000
Message-ID: <161653792959.2770958.5386546945273988117.stgit@warthog.procyon.org.uk>
In-Reply-To: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
References: <161653784755.2770958.11820491619308713741.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the PG_fscache related helper funcs (such as SetPageFsCache()) to
linux/netfs.h rather than linux/fscache.h as the intention is to move to a
model where they're used by the network filesystem and the helper library,
but not by fscache/cachefiles itself.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-cachefs@redhat.com
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: ceph-devel@vger.kernel.org
cc: v9fs-developer@lists.sourceforge.net
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/161340392347.1303470.18065131603507621762.stgit@warthog.procyon.org.uk/ # v3
Link: https://lore.kernel.org/r/161539534516.286939.6265142985563005000.stgit@warthog.procyon.org.uk/ # v4
---

 include/linux/fscache.h |   11 +----------
 include/linux/netfs.h   |   29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/netfs.h

diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index a1c928fe98e7..1f8dc72369ee 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 #include <linux/list_bl.h>
+#include <linux/netfs.h>
 
 #if defined(CONFIG_FSCACHE) || defined(CONFIG_FSCACHE_MODULE)
 #define fscache_available() (1)
@@ -29,16 +30,6 @@
 #endif
 
 
-/*
- * overload PG_private_2 to give us PG_fscache - this is used to indicate that
- * a page is currently backed by a local disk cache
- */
-#define PageFsCache(page)		PagePrivate2((page))
-#define SetPageFsCache(page)		SetPagePrivate2((page))
-#define ClearPageFsCache(page)		ClearPagePrivate2((page))
-#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
-#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
-
 /* pattern used to fill dead space in an index entry */
 #define FSCACHE_INDEX_DEADFILL_PATTERN 0x79
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
new file mode 100644
index 000000000000..cc1102040488
--- /dev/null
+++ b/include/linux/netfs.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Network filesystem support services.
+ *
+ * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ *
+ * See:
+ *
+ *	Documentation/filesystems/netfs_library.rst
+ *
+ * for a description of the network filesystem interface declared here.
+ */
+
+#ifndef _LINUX_NETFS_H
+#define _LINUX_NETFS_H
+
+#include <linux/pagemap.h>
+
+/*
+ * Overload PG_private_2 to give us PG_fscache - this is used to indicate that
+ * a page is currently backed by a local disk cache
+ */
+#define PageFsCache(page)		PagePrivate2((page))
+#define SetPageFsCache(page)		SetPagePrivate2((page))
+#define ClearPageFsCache(page)		ClearPagePrivate2((page))
+#define TestSetPageFsCache(page)	TestSetPagePrivate2((page))
+#define TestClearPageFsCache(page)	TestClearPagePrivate2((page))
+
+#endif /* _LINUX_NETFS_H */


