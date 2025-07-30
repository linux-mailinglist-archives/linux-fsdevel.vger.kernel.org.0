Return-Path: <linux-fsdevel+bounces-56356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D4AB166E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A060E62538A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 19:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B392E2EFD;
	Wed, 30 Jul 2025 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSr/DZ/X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A11E5B99
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903524; cv=none; b=l55fRdwXDxdDVZrHKwlkZB9j7okndNaahKVG+EhlF+Tc6pqWe4ghdio7Sk+25qNLfrwN54dMwLIzm1fOlCUmeHkjZFoND/NJIEIOOMTICQchmiz2phttuh1BNSZ6AvAP/wPz+UuHxsGaJRuFWzPbrUcaQ8xouMUu3st+67QJN5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903524; c=relaxed/simple;
	bh=sN4ToRO/TAtEry+j6kPvuahk3sHm+KtIB9JP1RHY5dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TW3WTGKbFogwubCZWA0yClxQ/Azsu/fHn15oFDy8c0eDBw7cKVczH7f3zPh0jvoljF6AAPq/IVSme7cHZWyGOuRTTeQcfDv/5q7RBPLPq15PRpSqtkXJTCZzd3ioi5dG5bZLsRSiXo4ZEFxJ+yGyKvRVinnwMawlv8aOgwZXVdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YSr/DZ/X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753903521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dddgV3m+UDepdnv1fS5DHQKgKnaNLuu+lwozlkmeSI0=;
	b=YSr/DZ/XApVM3qSnHVggrjGzi0EUOsgmYP7RpB38LWuOgK3mLruTKH9Ji/F4kJf5RvWqSp
	5bYDd4F13eWm/Ixb9fq4zF2TIsdve9lWr9ZHGS2weeaTz9kt6ys41a7hNSgGiXb0UDZaNu
	27VxtwTN+UH6bih/HQxS4vxpY/jt96Y=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-sBVu_4CeN9isbKfhDXaTBA-1; Wed, 30 Jul 2025 15:25:20 -0400
X-MC-Unique: sBVu_4CeN9isbKfhDXaTBA-1
X-Mimecast-MFC-AGG-ID: sBVu_4CeN9isbKfhDXaTBA_1753903519
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-87b89891d5dso21182339f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 12:25:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903519; x=1754508319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dddgV3m+UDepdnv1fS5DHQKgKnaNLuu+lwozlkmeSI0=;
        b=YMhzRDwDtS2AuuIp2GfXQvZqunJ83tRIuDHHfZtJr6RTIjCk4wYVyP2iEPhg9ZtA12
         Jc7om3Iri3vEIbOG0QgwqLUhgT6VXNY3Dle3XHb2J9Om+GzpWqpdOQZrgycJdPbpQRAI
         0xJbFw4XnMMWFHInbMmBI97q5Swgfphccp4eZwQqUcfAj6/dfoncg04n3i2T6mZi7Aga
         RRkilB6cSRvD+KyyXNdjf3WMdMOpJM6/obrXXbgUA+9ksvdlQZj3i6K/jeyRwrz6r3oy
         7+kfIQqkWbVLPn6vzVOlV8o44925fzFazrGsQEQxOejaQqw7u5r+ZnoykW0qkbfbqaut
         HZnA==
X-Gm-Message-State: AOJu0Yxvx3Vjm2X1Plwy+QW0XOd6u/51VKwlLaVqJIGAAm40CNU0/w7g
	+iIP83tPhUZAu1EqSawhoYP8oSq+fJEjmKwEnMmQ0cCay36PY+cNqhZLuGW79gd8APGtf6/PE+6
	43RkEDBTY3c0VEc/s5W5lAUNG4lf1AF9cc9Z3NPsoDPXakBseU6/mOiiRsb7lMAnp+9E=
X-Gm-Gg: ASbGncuYGmSyBDeHPPUUS3YQDqHIRIyq8qS9XHtZ8DgTpHDm4Ap5LpZjW2TIIZXea1/
	/T2jGIJZ0kcalyhlAu7V+l8ofxxIKQFihuADktwSBhh7f1dKpUGjly48wY7+LIh2y9u3l98nNGC
	xto2gpfHNVQBDtUrPNlY4Ji7y8kxlWvPJ07cvGhe/BmDbNKHtMHMLUQFWi6AmZhX5PAzicEV4A0
	oy0AVGhk8PN63KIvxiuyAfKd7uTwXTwcDrHr6DPS4YWdXfNPIOP8wDKrSG2aJTgk36nPkkVM2Di
	PpjJrmerUkTZOSnbTzAmVo+3vgBSHHEorvGmukRm+HmB
X-Received: by 2002:a05:6602:2dc2:b0:87c:4609:d10a with SMTP id ca18e2360f4ac-88137c64e5emr832939339f.9.1753903518645;
        Wed, 30 Jul 2025 12:25:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2EmN1zocAou4yHWVsA7mE9VKQl50MyU2Nxp4wt0HkZYlbJonqpM3EFK12/dg+xMJ4JZ9IuQ==
X-Received: by 2002:a05:6602:2dc2:b0:87c:4609:d10a with SMTP id ca18e2360f4ac-88137c64e5emr832935339f.9.1753903518275;
        Wed, 30 Jul 2025 12:25:18 -0700 (PDT)
Received: from big24.sandeen.net ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-880f7a29956sm284856039f.25.2025.07.30.12.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:25:17 -0700 (PDT)
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
Subject: [PATCH V2 2/4] net/9p: move structures and macros to header files
Date: Wed, 30 Jul 2025 14:18:53 -0500
Message-ID: <20250730192511.2161333-3-sandeen@redhat.com>
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

With the new mount API all option parsing will need to happen
in fs/v9fs.c, so move necessary data structures and macros to
header files to facilitate this. Rename some to reflect
the transport they are used for (rdma, fd, etc), for clarity.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 include/net/9p/client.h    |  6 ++++++
 include/net/9p/transport.h | 39 ++++++++++++++++++++++++++++++++++++++
 net/9p/client.c            |  6 ------
 net/9p/trans_fd.c          | 20 ++-----------------
 net/9p/trans_rdma.c        | 25 ++----------------------
 5 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 4f785098c67a..2d46f8017bd5 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -16,6 +16,12 @@
 /* Number of requests per row */
 #define P9_ROW_MAXTAG 255
 
+/* DEFAULT MSIZE = 32 pages worth of payload + P9_HDRSZ +
+ * room for write (16 extra) or read (11 extra) operands.
+ */
+
+#define DEFAULT_MSIZE ((128 * 1024) + P9_IOHDRSZ)
+
 /** enum p9_proto_versions - 9P protocol versions
  * @p9_proto_legacy: 9P Legacy mode, pre-9P2000.u
  * @p9_proto_2000u: 9P2000.u extension
diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
index 766ec07c9599..88702953b1ef 100644
--- a/include/net/9p/transport.h
+++ b/include/net/9p/transport.h
@@ -14,6 +14,45 @@
 #define P9_DEF_MIN_RESVPORT	(665U)
 #define P9_DEF_MAX_RESVPORT	(1023U)
 
+#define P9_FD_PORT 564
+
+#define P9_RDMA_PORT		5640
+#define P9_RDMA_SQ_DEPTH	32
+#define P9_RDMA_RQ_DEPTH	32
+#define P9_RDMA_TIMEOUT		30000		/* 30 seconds */
+
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
 /**
  * struct p9_trans_module - transport module interface
  * @list: used to maintain a list of currently available transports
diff --git a/net/9p/client.c b/net/9p/client.c
index 5c1ca57ccd28..5e3230b1bfab 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -29,12 +29,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/9p.h>
 
-/* DEFAULT MSIZE = 32 pages worth of payload + P9_HDRSZ +
- * room for write (16 extra) or read (11 extra) operands.
- */
-
-#define DEFAULT_MSIZE ((128 * 1024) + P9_IOHDRSZ)
-
 /* Client Option Parsing (code inspired by NFS code)
  *  - a little lazy - parse all client options
  */
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 339ec4e54778..9ef4f2e0db3c 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -31,28 +31,12 @@
 
 #include <linux/syscalls.h> /* killme */
 
-#define P9_PORT 564
 #define MAX_SOCK_BUF (1024*1024)
 #define MAXPOLLWADDR	2
 
 static struct p9_trans_module p9_tcp_trans;
 static struct p9_trans_module p9_fd_trans;
 
-/**
- * struct p9_fd_opts - per-transport options
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
 /*
   * Option Parsing (code inspired by NFS code)
   *  - a little lazy - parse all fd-transport options
@@ -749,7 +733,7 @@ static int p9_fd_cancelled(struct p9_client *client, struct p9_req_t *req)
 static int p9_fd_show_options(struct seq_file *m, struct p9_client *clnt)
 {
 	if (clnt->trans_mod == &p9_tcp_trans) {
-		if (clnt->trans_opts.tcp.port != P9_PORT)
+		if (clnt->trans_opts.tcp.port != P9_FD_PORT)
 			seq_printf(m, ",port=%u", clnt->trans_opts.tcp.port);
 	} else if (clnt->trans_mod == &p9_fd_trans) {
 		if (clnt->trans_opts.fd.rfd != ~0)
@@ -775,7 +759,7 @@ static int parse_opts(char *params, struct p9_fd_opts *opts)
 	int option;
 	char *options, *tmp_options;
 
-	opts->port = P9_PORT;
+	opts->port = P9_FD_PORT;
 	opts->rfd = ~0;
 	opts->wfd = ~0;
 	opts->privport = false;
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index b84748baf9cb..46ee37061faf 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -32,14 +32,10 @@
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
 
-#define P9_PORT			5640
-#define P9_RDMA_SQ_DEPTH	32
-#define P9_RDMA_RQ_DEPTH	32
 #define P9_RDMA_SEND_SGE	4
 #define P9_RDMA_RECV_SGE	4
 #define P9_RDMA_IRD		0
 #define P9_RDMA_ORD		0
-#define P9_RDMA_TIMEOUT		30000		/* 30 seconds */
 #define P9_RDMA_MAXSIZE		(1024*1024)	/* 1MB */
 
 /**
@@ -110,23 +106,6 @@ struct p9_rdma_context {
 	};
 };
 
-/**
- * struct p9_rdma_opts - Collection of mount options
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
 /*
  * Option Parsing (code inspired by NFS code)
  */
@@ -151,7 +130,7 @@ static int p9_rdma_show_options(struct seq_file *m, struct p9_client *clnt)
 {
 	struct p9_trans_rdma *rdma = clnt->trans;
 
-	if (rdma->port != P9_PORT)
+	if (rdma->port != P9_RDMA_PORT)
 		seq_printf(m, ",port=%u", rdma->port);
 	if (rdma->sq_depth != P9_RDMA_SQ_DEPTH)
 		seq_printf(m, ",sq=%u", rdma->sq_depth);
@@ -178,7 +157,7 @@ static int parse_opts(char *params, struct p9_rdma_opts *opts)
 	int option;
 	char *options, *tmp_options;
 
-	opts->port = P9_PORT;
+	opts->port = P9_RDMA_PORT;
 	opts->sq_depth = P9_RDMA_SQ_DEPTH;
 	opts->rq_depth = P9_RDMA_RQ_DEPTH;
 	opts->timeout = P9_RDMA_TIMEOUT;
-- 
2.50.0


