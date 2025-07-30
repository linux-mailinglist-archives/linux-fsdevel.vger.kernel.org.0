Return-Path: <linux-fsdevel+bounces-56357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE48B166E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 21:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BC66253F5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 19:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031832E49A0;
	Wed, 30 Jul 2025 19:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuFnaYBS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE4A2E2EE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903526; cv=none; b=QkBKIf2lYvAGrQnLWiMNnWL0HioucnHudZVOEBN7E6I7qz+mfaQMnHUG0XvnqFOku61Be4haZnei9nrxuJ2boM9iPmVMRlPFGseJ1FNbzmizzaFdj5+cBjq+qDQLoiF3WNtQPFljuGTHx6So4pgn258iBOb6Qf4/ZZXbeGHEuPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903526; c=relaxed/simple;
	bh=oiDgcYvrvT3546D/e9Vrs7slw1MEQeieAZNTId0DvKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ic6yaUPVFddTrkn+iwqrhv6JaLpKWXM+RzCBemyT8DQk9pASCtS8TcMBD1wwQwahBi6Nyda7VTlboWxCa+K3REZjGXgWSYo9oQJ3L07drgJCoBqKtr/aSXAHTTtYuOrUySINHo5a1OwzRysELVnGJSy0P/OEoHqg7HZmdtCDc6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuFnaYBS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WN+Bsu6yDWhJfBeAZ05eJQtu7vjCbJLVMgwwvykiSxw=;
	b=QuFnaYBSWwB7T/6gDUkWbd8F0g3tzBN30OnoVwQfWvsf4N+acms8GsYZj9h8TiU8aBj46p
	NTbMTn+rzQJt2zPE0k05dg221d7SJ0L+rQyeE84G1Z7PRmdvNEDnuCEgM5P0OfV+69Wz2V
	+M9i5EcbWWja5FOMolX1Ej8VtzmVDTk=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-uHI6oDfBMeuvP1OdORb3QA-1; Wed, 30 Jul 2025 15:25:21 -0400
X-MC-Unique: uHI6oDfBMeuvP1OdORb3QA-1
X-Mimecast-MFC-AGG-ID: uHI6oDfBMeuvP1OdORb3QA_1753903520
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-88126408512so17236239f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 12:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903520; x=1754508320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WN+Bsu6yDWhJfBeAZ05eJQtu7vjCbJLVMgwwvykiSxw=;
        b=siYr0moh24dWQdSJEcqVHtz2JvkPa6QnGejewyJ1I29zxMS7UuOkGIYg5GuSwbtbMj
         POvTWXsn9941SSMe6HYgLXrgujPKb6yyTQVmZDYSWsbFnSW5ejBguiid3QWkHiZ0cOBN
         lBmRgLRHM3nZooFLwkA8b8vzCcb5QNqshOyy5DUECW3Q5rIWNGD09ro2WFT/PgIXN3ZC
         6XrAgloyL3Nrp4pJYch4EGTatQ37HBHrXMt2ZrTh3kryXvqoyX6h4+IKzEOhic1Gln0L
         1bDdb9OgKDaP/njVgHztWChFCsS7ssnHSQjTadcfefnIwF2SH5Dn2aHOi7j8HDG9wI4Y
         wo0Q==
X-Gm-Message-State: AOJu0Yw/9D87YTrdDsnzvhmKyQ4JgKlaPMAyWfDSnav22nXaEw0wMXLv
	mM4qpv5pfogzadb1xXr6RM+/2IhDEIgwFLVUCwysf24OCM2DmSsvjy7vwa1NgKnSN/Tc1sM8q9v
	FhP0sIptic7WGMJ0NNTw6Q+HqVQredk8rtBRDqZElO74cREbiDwTLTACIaKOsxgCZfv4=
X-Gm-Gg: ASbGncv0MWC5UycE/yvgekOZ7h15upUMM0OyjzlgiUX4TEJs8mmtfHiAuxq7lulyHs2
	RlQPdzj0IxlnQnUkuSrRtJGX/TQGt5a6QVGLE0elP3X4nRAjXcSvc60rTUoLJl8zXGO7qLgimSZ
	VOhUcRt1waSwDtT9CazanHTycWTpsb0Gmlc+4GCQ0CUjLBvXPTxq+K1IfgFawcKPpEmYnIMwr/z
	FbROjMwj/3LTeGNIoon0G+k74LCTs3AbyuiqtVZZH877joERZ1qxG0vmNaH0CabcUML26ghlZYT
	OFRBA2DQcb4I0vX+Ag3CZb6wBtagvbK5vMgUNKU/7w2m
X-Received: by 2002:a05:6602:14d3:b0:864:a228:92b4 with SMTP id ca18e2360f4ac-8813784e7bbmr822130039f.7.1753903519997;
        Wed, 30 Jul 2025 12:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZYPSSDTAvY/+0VmiQLnw0juAojPkb1HQxRSFH8oVfqkYBIsihewSMn+/6GqJT1s5ZvDE0RA==
X-Received: by 2002:a05:6602:14d3:b0:864:a228:92b4 with SMTP id ca18e2360f4ac-8813784e7bbmr822125239f.7.1753903519576;
        Wed, 30 Jul 2025 12:25:19 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:19 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	dhowells@redhat.com,
	sandeen@redhat.com
Subject: [PATCH V2 3/4] 9p: create a v9fs_context structure to hold parsed options
Date: Wed, 30 Jul 2025 14:18:54 -0500
Message-ID: <20250730192511.2161333-4-sandeen@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250730192511.2161333-1-sandeen@redhat.com>
References: <20250730192511.2161333-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch creates a new v9fs_context structure which includes
v9fs_session_info as well as p9_client, p9_fd_opts, and p9_rdma_opts
to hold all parsed options. The new structure will be used in the next
commit to pass all parsed options to the appropriate transports.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/9p/cache.c              |  1 +
 fs/9p/v9fs.h               | 49 ---------------------
 include/net/9p/client.h    | 88 ++++++++++++++++++++++++++++++++++++++
 include/net/9p/transport.h | 32 --------------
 4 files changed, 89 insertions(+), 81 deletions(-)

diff --git a/fs/9p/cache.c b/fs/9p/cache.c
index 12c0ae29f185..1def4dec1dcc 100644
--- a/fs/9p/cache.c
+++ b/fs/9p/cache.c
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <net/9p/9p.h>
+#include <net/9p/client.h>
 
 #include "v9fs.h"
 #include "cache.h"
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index f28bc763847a..4b8834daec8d 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -81,55 +81,6 @@ enum p9_cache_bits {
 	CACHE_FSCACHE       = 0b10000000,
 };
 
-/**
- * struct v9fs_session_info - per-instance session information
- * @flags: session options of type &p9_session_flags
- * @nodev: set to 1 to disable device mapping
- * @debug: debug level
- * @afid: authentication handle
- * @cache: cache mode of type &p9_cache_bits
- * @cachetag: the tag of the cache associated with this session
- * @fscache: session cookie associated with FS-Cache
- * @uname: string user name to mount hierarchy as
- * @aname: mount specifier for remote hierarchy
- * @maxdata: maximum data to be sent/recvd per protocol message
- * @dfltuid: default numeric userid to mount hierarchy as
- * @dfltgid: default numeric groupid to mount hierarchy as
- * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
- * @clnt: reference to 9P network client instantiated for this session
- * @slist: reference to list of registered 9p sessions
- *
- * This structure holds state for each session instance established during
- * a sys_mount() .
- *
- * Bugs: there seems to be a lot of state which could be condensed and/or
- * removed.
- */
-
-struct v9fs_session_info {
-	/* options */
-	unsigned int flags;
-	unsigned char nodev;
-	unsigned short debug;
-	unsigned int afid;
-	unsigned int cache;
-#ifdef CONFIG_9P_FSCACHE
-	char *cachetag;
-	struct fscache_volume *fscache;
-#endif
-
-	char *uname;		/* user name to mount as */
-	char *aname;		/* name of remote hierarchy being mounted */
-	unsigned int maxdata;	/* max data for client interface */
-	kuid_t dfltuid;		/* default uid/muid for legacy support */
-	kgid_t dfltgid;		/* default gid for legacy support */
-	kuid_t uid;		/* if ACCESS_SINGLE, the uid that has access */
-	struct p9_client *clnt;	/* 9p client */
-	struct list_head slist; /* list of sessions registered with v9fs */
-	struct rw_semaphore rename_sem;
-	long session_lock_timeout; /* retry interval for blocking locks */
-};
-
 /* cache_validity flags */
 #define V9FS_INO_INVALID_ATTR 0x01
 
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 2d46f8017bd5..33b8d9a79fa7 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -132,6 +132,94 @@ struct p9_client {
 	char name[__NEW_UTS_LEN + 1];
 };
 
+/**
+ * struct p9_fd_opts - per-transport options for fd transport
+ * @rfd: file descriptor for reading (trans=fd)
+ * @wfd: file descriptor for writing (trans=fd)
+ * @port: port to connect to (trans=tcp)
+ * @privport: port is privileged
+ */
+
+struct p9_fd_opts {
+	int rfd;
+	int wfd;
+	u16 port;
+	bool privport;
+};
+
+/**
+ * struct p9_rdma_opts - Collection of mount options for rdma transport
+ * @port: port of connection
+ * @privport: Whether a privileged port may be used
+ * @sq_depth: The requested depth of the SQ. This really doesn't need
+ * to be any deeper than the number of threads used in the client
+ * @rq_depth: The depth of the RQ. Should be greater than or equal to SQ depth
+ * @timeout: Time to wait in msecs for CM events
+ */
+struct p9_rdma_opts {
+	short port;
+	bool privport;
+	int sq_depth;
+	int rq_depth;
+	long timeout;
+};
+
+/**
+ * struct v9fs_session_info - per-instance session information
+ * @flags: session options of type &p9_session_flags
+ * @nodev: set to 1 to disable device mapping
+ * @debug: debug level
+ * @afid: authentication handle
+ * @cache: cache mode of type &p9_cache_bits
+ * @cachetag: the tag of the cache associated with this session
+ * @fscache: session cookie associated with FS-Cache
+ * @uname: string user name to mount hierarchy as
+ * @aname: mount specifier for remote hierarchy
+ * @maxdata: maximum data to be sent/recvd per protocol message
+ * @dfltuid: default numeric userid to mount hierarchy as
+ * @dfltgid: default numeric groupid to mount hierarchy as
+ * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
+ * @clnt: reference to 9P network client instantiated for this session
+ * @slist: reference to list of registered 9p sessions
+ *
+ * This structure holds state for each session instance established during
+ * a sys_mount() .
+ *
+ * Bugs: there seems to be a lot of state which could be condensed and/or
+ * removed.
+ */
+struct v9fs_session_info {
+	/* options */
+	unsigned int flags;
+	unsigned char nodev;
+	unsigned short debug;
+	unsigned int afid;
+	unsigned int cache;
+#ifdef CONFIG_9P_FSCACHE
+	char *cachetag;
+	struct fscache_volume *fscache;
+#endif
+
+	char *uname;		/* user name to mount as */
+	char *aname;		/* name of remote hierarchy being mounted */
+	unsigned int maxdata;	/* max data for client interface */
+	kuid_t dfltuid;		/* default uid/muid for legacy support */
+	kgid_t dfltgid;		/* default gid for legacy support */
+	kuid_t uid;		/* if ACCESS_SINGLE, the uid that has access */
+	struct p9_client *clnt;	/* 9p client */
+	struct list_head slist; /* list of sessions registered with v9fs */
+	struct rw_semaphore rename_sem;
+	long session_lock_timeout; /* retry interval for blocking locks */
+};
+
+/* Used by mount API to store parsed mount options */
+struct v9fs_context {
+	struct p9_client	client_opts;
+	struct p9_fd_opts	fd_opts;
+	struct p9_rdma_opts	rdma_opts;
+	struct v9fs_session_info v9ses;
+};
+
 /**
  * struct p9_fid - file system entity handle
  * @clnt: back pointer to instantiating &p9_client
diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
index 88702953b1ef..ebbb4b50ee20 100644
--- a/include/net/9p/transport.h
+++ b/include/net/9p/transport.h
@@ -21,38 +21,6 @@
 #define P9_RDMA_RQ_DEPTH	32
 #define P9_RDMA_TIMEOUT		30000		/* 30 seconds */
 
-/**
- * struct p9_fd_opts - per-transport options for fd transport
- * @rfd: file descriptor for reading (trans=fd)
- * @wfd: file descriptor for writing (trans=fd)
- * @port: port to connect to (trans=tcp)
- * @privport: port is privileged
- */
-
-struct p9_fd_opts {
-	int rfd;
-	int wfd;
-	u16 port;
-	bool privport;
-};
-
-/**
- * struct p9_rdma_opts - Collection of mount options for rdma transport
- * @port: port of connection
- * @privport: Whether a privileged port may be used
- * @sq_depth: The requested depth of the SQ. This really doesn't need
- * to be any deeper than the number of threads used in the client
- * @rq_depth: The depth of the RQ. Should be greater than or equal to SQ depth
- * @timeout: Time to wait in msecs for CM events
- */
-struct p9_rdma_opts {
-	short port;
-	bool privport;
-	int sq_depth;
-	int rq_depth;
-	long timeout;
-};
-
 /**
  * struct p9_trans_module - transport module interface
  * @list: used to maintain a list of currently available transports
-- 
2.50.0


