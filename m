Return-Path: <linux-fsdevel+bounces-60384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2741B4642A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B081899455
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C492D0C80;
	Fri,  5 Sep 2025 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="UlBlj4dV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A688F2C0F69
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102525; cv=none; b=gOwqJ+8gEglrLvrJBiW27R2U82DZp+ugGwuOQ6rLlY35yLxdO3/WSk3HpKjoNRZBym7sJ/mDNqLA/t5mLnAR2mGGAD3oqxneVO4ngIFdjhwvMa216EbTHaJJCc97SX2UJILtr9o+ZqH3qQL8CLZDeUMFaPYv48IhSr/Z/kxYGFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102525; c=relaxed/simple;
	bh=cSsBre+m/kDFhSh/IIm1zESyPOPtymju059T0MtabLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwsDO1L9NOknuYS6D8aKR0XUXkB1DsqQtxthLueAzLiAEhzORQKKe/i6C42KiTFJjQ3HDd1259Q5pKVGuuveGu4lQEeLIx9QI9NXD1qT0XQP6Szn4x1g9R8o4s5F8okXjAjlkKweFU080smrjp28OAkKPpMeE2QhnKXADPKdRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=UlBlj4dV; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-72267c05050so24164607b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102522; x=1757707322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J0dFhk5zZrpV3pqMp9qLWoZUz237R9ABGiPVxqf7mQ=;
        b=UlBlj4dVIXhwyFIVmT9ot79ilVr222cbFAsnl0ouzS3Hk3VOLsvfvjFMNWbNEsf53m
         VKiKNd0GAiddBLh6ZpFRhfnt4Q63rXmZr5MlapzVPW9MX8hakLYDNVKTaujYq/JjyKif
         h38sEl96jlliH+NGrimhBw5zYkgVPS4S2yDurPT08mY+bya2bSnHl8zkzbnlabS4me4t
         pEPJK+8Ir0FEhQHGVH6ipwLjv+U+tUX9VkintxYKJ0+tOsG6BQl7UJqvf2irj8OhfNjt
         6PQxcpQPCabiZ2g5SxPgstqBbUsgMSoGR/rQI//0QZOkAmrkWD9zfVKfly7Rauj15ZBI
         jS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102522; x=1757707322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J0dFhk5zZrpV3pqMp9qLWoZUz237R9ABGiPVxqf7mQ=;
        b=VDXyb9qxwSORWGQs15F/oJWJzBbUyDNAC7AhWnPiSngDNGzkUcHqAyCZz2srN7D4I9
         8X5L/4t2Rupkk66BLa9dyhIZ0BXohMY9fWQJNuFkGRw8FSj59ZuQinZvr6GI5dTkcVp1
         A9B9CTyLZyxqhqk46R0RzDjDZm6+BAYLsg/Qu09K6fmfDQGYpaOC7wlZXmferEXMtKHs
         fRc5RPqUYi5QKqXlehKGxGeOCj+2SiHbCJ7TLuSdZ0DKe0korkclYi4q3gw+WaLXcqsv
         URWYHq/t2O1mA4PWWyQ63zJuauiyS7TxhQtZLTRTLrE3AP2m/Zifw+4Jy5Tv1ufeZTYW
         /70g==
X-Forwarded-Encrypted: i=1; AJvYcCUaO01KqDNMcCQcbhlPihywTfE/oakMXJMhnfasL1x9s+1rhcxouWegQbqRLeJOdMV+t6Rr0YJgrBBUuwJl@vger.kernel.org
X-Gm-Message-State: AOJu0YzfZPp6qwZlfsEX8d6jOos/yrRvk3L2IToX/A/moMlH8PncdDm9
	bsZt/wXUYBPueMkjUoBuXWS/LJSgvjJN3Tbl97kMipCzTlX0OYnAd5A8eJvuA55guS4=
X-Gm-Gg: ASbGncv15zM4rumha1t9dTr5kilctser5L7p5JAkEY1XBV+/s8YaI6Iq87K0Gr/MpP1
	Fs9aDbBuGlYeLE5VDkihrqt1T/1XWHx+0nh2nYw2RUNuAJ/kBAmr445xf0oFxuwbRHFoK3ENRvr
	K9pvDJQXxqD7RDQK9ve6N/dt3nAHndDIBH9IsAqafmCV3Yb+lGGa6lnCrPi6CgvkXg36WuelqCu
	8KvS8ipBfB0Ljg9Hlzw76Kwq2AgjPIdlft/LdzLEVyxeXz/HCh/L4I9eIcKBp1Wljq+nUlYBq/Z
	2jvNpfouLNX1+Kl81n45ePu9/QSSfym47gwyH2ibbzuLOIrmUi20vN9IR3wbJSs84kL3pDlI9U6
	e5Lmz1c0BM8bKqE/+sbTVSZwWiSZ2/w4333auKBOp
X-Google-Smtp-Source: AGHT+IHysModyxPKBcd7X5YviBU7K6I+6ppiuex7b81VI9VbpC+Be+XLFJ0teRRTfXqsey5SiRzEOQ==
X-Received: by 2002:a05:690c:6607:b0:724:3a98:701b with SMTP id 00721157ae682-727f368bc52mr1257547b3.21.1757102521539;
        Fri, 05 Sep 2025 13:02:01 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:00 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 10/20] ceph: add comments to metadata structures in messenger.h
Date: Fri,  5 Sep 2025 13:00:58 -0700
Message-ID: <20250905200108.151563-11-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905200108.151563-1-slava@dubeyko.com>
References: <20250905200108.151563-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

We have a lot of declarations and not enough good
comments on it.

Claude AI generated comments for CephFS metadata structure
declarations in include/linux/ceph/*.h. These comments
have been reviewed, checked, and corrected.

This patch adds comments for struct ceph_connection_operations,
struct ceph_messenger, enum ceph_msg_data_type,
struct ceph_bio_iter, struct ceph_bvec_iter, struct ceph_msg_data,
struct ceph_msg_data_cursor, struct ceph_msg,
struct ceph_connection_v1_info, struct ceph_frame_desc,
struct ceph_gcm_nonce, struct ceph_connection_v2_info,
struct ceph_connection in /include/linux/ceph/messenger.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/messenger.h | 449 ++++++++++++++++++++++++---------
 1 file changed, 332 insertions(+), 117 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 1717cc57cdac..d0573b228d4e 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -20,53 +20,70 @@ struct ceph_connection;
 struct ceph_msg_data_cursor;
 
 /*
- * Ceph defines these callbacks for handling connection events.
+ * Connection operations metadata: Callback interface for handling network
+ * connection events and message processing. Allows different Ceph subsystems
+ * (monitors, OSDs, MDS) to customize connection behavior.
  */
 struct ceph_connection_operations {
+	/* Connection reference management */
 	struct ceph_connection *(*get)(struct ceph_connection *);
 	void (*put)(struct ceph_connection *);
 
-	/* handle an incoming message. */
+	/* Handle incoming message dispatch to appropriate handler */
 	void (*dispatch) (struct ceph_connection *con, struct ceph_msg *m);
 
-	/* authorize an outgoing connection */
+	/* Authentication and authorization callbacks */
+	/* Get authorizer for outgoing connection */
 	struct ceph_auth_handshake *(*get_authorizer) (
 				struct ceph_connection *con,
 			       int *proto, int force_new);
+	/* Handle authentication challenge */
 	int (*add_authorizer_challenge)(struct ceph_connection *con,
 					void *challenge_buf,
 					int challenge_buf_len);
+	/* Verify authorizer reply */
 	int (*verify_authorizer_reply) (struct ceph_connection *con);
+	/* Invalidate current authorizer */
 	int (*invalidate_authorizer)(struct ceph_connection *con);
 
-	/* there was some error on the socket (disconnect, whatever) */
+	/* Network error handling */
+	/* Socket error occurred (disconnect, etc.) */
 	void (*fault) (struct ceph_connection *con);
 
+	/* Peer reset connection, potential message loss */
 	/* a remote host as terminated a message exchange session, and messages
 	 * we sent (or they tried to send us) may be lost. */
 	void (*peer_reset) (struct ceph_connection *con);
 
+	/* Message allocation and processing */
+	/* Allocate message for incoming data */
 	struct ceph_msg * (*alloc_msg) (struct ceph_connection *con,
 					struct ceph_msg_header *hdr,
 					int *skip);
 
+	/* Re-encode message for retransmission */
 	void (*reencode_message) (struct ceph_msg *msg);
 
+	/* Message signing and verification */
 	int (*sign_message) (struct ceph_msg *msg);
 	int (*check_message_signature) (struct ceph_msg *msg);
 
-	/* msgr2 authentication exchange */
+	/* Messenger v2 authentication exchange */
+	/* Get initial authentication request */
 	int (*get_auth_request)(struct ceph_connection *con,
 				void *buf, int *buf_len,
 				void **authorizer, int *authorizer_len);
+	/* Handle multi-round authentication */
 	int (*handle_auth_reply_more)(struct ceph_connection *con,
 				      void *reply, int reply_len,
 				      void *buf, int *buf_len,
 				      void **authorizer, int *authorizer_len);
+	/* Authentication completed successfully */
 	int (*handle_auth_done)(struct ceph_connection *con,
 				u64 global_id, void *reply, int reply_len,
 				u8 *session_key, int *session_key_len,
 				u8 *con_secret, int *con_secret_len);
+	/* Authentication failed with unsupported method */
 	int (*handle_auth_bad_method)(struct ceph_connection *con,
 				      int used_proto, int result,
 				      const int *allowed_protos, int proto_cnt,
@@ -100,21 +117,37 @@ struct ceph_connection_operations {
 /* use format string %s%lld */
 #define ENTITY_NAME(n) ceph_entity_type_name((n).type), le64_to_cpu((n).num)
 
+/*
+ * Ceph messenger metadata: Core messaging infrastructure that manages network
+ * connections and message routing. Handles connection multiplexing, sequencing,
+ * and provides the foundation for all Ceph network communication.
+ */
 struct ceph_messenger {
-	struct ceph_entity_inst inst;    /* my name+address */
+	/* Messenger identity (entity name + network address) */
+	struct ceph_entity_inst inst;
+	/* Encoded network address for this messenger */
 	struct ceph_entity_addr my_enc_addr;
 
+	/* Shutdown coordination */
 	atomic_t stopping;
+	/* Network namespace for socket operations */
 	possible_net_t net;
 
 	/*
+	 * Global connection sequence number for race disambiguation:
 	 * the global_seq counts connections i (attempt to) initiate
 	 * in order to disambiguate certain connect race conditions.
 	 */
 	u32 global_seq;
+	/* Protects global_seq updates */
 	spinlock_t global_seq_lock;
 };
 
+/*
+ * Message data container types: Defines different ways message payload data
+ * can be stored and transmitted. Supports various kernel memory management
+ * patterns for efficient zero-copy I/O operations.
+ */
 enum ceph_msg_data_type {
 	CEPH_MSG_DATA_NONE,	/* message contains no data payload */
 	CEPH_MSG_DATA_PAGES,	/* data source/destination is a page array */
@@ -128,8 +161,15 @@ enum ceph_msg_data_type {
 
 #ifdef CONFIG_BLOCK
 
+/*
+ * Bio iterator metadata: Tracks position within a chain of bio structures
+ * for efficient traversal during network I/O operations. Maintains current
+ * bio and position within that bio's vector array.
+ */
 struct ceph_bio_iter {
+	/* Current bio in the chain */
 	struct bio *bio;
+	/* Current position within the bio */
 	struct bvec_iter iter;
 };
 
@@ -172,8 +212,15 @@ struct ceph_bio_iter {
 
 #endif /* CONFIG_BLOCK */
 
+/*
+ * Bio vector iterator metadata: Tracks position within an array of bio_vec
+ * structures for efficient memory region traversal during network operations.
+ * Provides unified interface for vectored I/O.
+ */
 struct ceph_bvec_iter {
+	/* Array of bio vectors */
 	struct bio_vec *bvecs;
+	/* Current position within the array */
 	struct bvec_iter iter;
 };
 
@@ -208,84 +255,151 @@ struct ceph_bvec_iter {
 	(it)->iter.bi_size = (n);					      \
 } while (0)
 
+/*
+ * Message data container metadata: Flexible container for message payload data
+ * using different storage methods. Supports various kernel memory management
+ * patterns for efficient zero-copy network operations.
+ */
 struct ceph_msg_data {
+	/* Type of data container */
 	enum ceph_msg_data_type		type;
+	/* Type-specific data container */
 	union {
 #ifdef CONFIG_BLOCK
+		/* Block I/O bio container */
 		struct {
+			/* Bio chain position and iterator */
 			struct ceph_bio_iter	bio_pos;
+			/* Total data length in bio chain */
 			u32			bio_length;
 		};
 #endif /* CONFIG_BLOCK */
+		/* Bio vector array container */
 		struct ceph_bvec_iter	bvec_pos;
+		/* Page array container */
 		struct {
+			/* Array of page pointers */
 			struct page	**pages;
-			size_t		length;		/* total # bytes */
-			unsigned int	alignment;	/* first page */
+			/* Total data length in bytes */
+			size_t		length;
+			/* Alignment offset in first page */
+			unsigned int	alignment;
+			/* Whether we own and must free the pages */
 			bool		own_pages;
 		};
+		/* Pagelist container */
 		struct ceph_pagelist	*pagelist;
+		/* Generic iterator container */
 		struct iov_iter		iter;
 	};
 };
 
+/*
+ * Message data cursor metadata: Tracks progress through message data during
+ * network transmission or reception. Maintains position across multiple data
+ * items and handles different container types efficiently.
+ */
 struct ceph_msg_data_cursor {
-	size_t			total_resid;	/* across all data items */
-
-	struct ceph_msg_data	*data;		/* current data item */
-	size_t			resid;		/* bytes not yet consumed */
-	int			sr_resid;	/* residual sparse_read len */
-	bool			need_crc;	/* crc update needed */
+	/* Total bytes remaining across all data items */
+	size_t			total_resid;
+
+	/* Current data item being processed */
+	struct ceph_msg_data	*data;
+	/* Bytes remaining in current data item */
+	size_t			resid;
+	/* Residual sparse read length */
+	int			sr_resid;
+	/* Whether CRC calculation is needed */
+	bool			need_crc;
+	/* Type-specific position tracking */
 	union {
 #ifdef CONFIG_BLOCK
+		/* Bio iterator for block I/O */
 		struct ceph_bio_iter	bio_iter;
 #endif /* CONFIG_BLOCK */
+		/* Bio vector iterator */
 		struct bvec_iter	bvec_iter;
-		struct {				/* pages */
-			unsigned int	page_offset;	/* offset in page */
-			unsigned short	page_index;	/* index in array */
-			unsigned short	page_count;	/* pages in array */
+		/* Page array position tracking */
+		struct {
+			/* Byte offset within current page */
+			unsigned int	page_offset;
+			/* Current page index in array */
+			unsigned short	page_index;
+			/* Total pages in array */
+			unsigned short	page_count;
 		};
-		struct {				/* pagelist */
-			struct page	*page;		/* page from list */
-			size_t		offset;		/* bytes from list */
+		/* Pagelist position tracking */
+		struct {
+			/* Current page from pagelist */
+			struct page	*page;
+			/* Byte offset from start of pagelist */
+			size_t		offset;
 		};
+		/* Iterator position tracking */
 		struct {
+			/* Current iov_iter state */
 			struct iov_iter		iov_iter;
+			/* Length of last operation */
 			unsigned int		lastlen;
 		};
 	};
 };
 
 /*
+ * Ceph network message metadata: Complete network message structure containing
+ * header, payload data, and transmission state. Supports various data container
+ * types for efficient zero-copy operations and handles message lifecycle.
+ *
  * a single message.  it contains a header (src, dest, message type, etc.),
  * footer (crc values, mainly), a "front" message body, and possibly a
  * data payload (stored in some number of pages).
  */
 struct ceph_msg {
-	struct ceph_msg_header hdr;	/* header */
+	/* Message header with routing and type information */
+	struct ceph_msg_header hdr;
+	/* Message footer with CRC and other metadata */
 	union {
-		struct ceph_msg_footer footer;		/* footer */
-		struct ceph_msg_footer_old old_footer;	/* old format footer */
+		/* Current footer format */
+		struct ceph_msg_footer footer;
+		/* Legacy footer format for compatibility */
+		struct ceph_msg_footer_old old_footer;
 	};
-	struct kvec front;              /* unaligned blobs of message */
+	/* Front payload (small, inline message data) */
+	struct kvec front;
+	/* Middle payload (optional, variable-length) */
 	struct ceph_buffer *middle;
 
+	/* Data payload information */
+	/* Total length of all data items */
 	size_t				data_length;
+	/* Array of data containers */
 	struct ceph_msg_data		*data;
+	/* Current number of data items */
 	int				num_data_items;
+	/* Maximum data items allocated */
 	int				max_data_items;
+	/* Current position for data processing */
 	struct ceph_msg_data_cursor	cursor;
 
+	/* Connection and list management */
+	/* Connection this message belongs to */
 	struct ceph_connection *con;
-	struct list_head list_head;	/* links for connection lists */
+	/* Linkage for connection message queues */
+	struct list_head list_head;
 
+	/* Message lifecycle and state */
+	/* Reference counting for safe cleanup */
 	struct kref kref;
+	/* More messages follow this one */
 	bool more_to_follow;
+	/* Message needs output sequence number */
 	bool needs_out_seq;
+	/* Total bytes expected for sparse read */
 	u64 sparse_read_total;
+	/* Allocated length of front buffer */
 	int front_alloc_len;
 
+	/* Memory pool this message came from */
 	struct ceph_msgpool *pool;
 };
 
@@ -321,45 +435,75 @@ struct ceph_msg {
 #define BASE_DELAY_INTERVAL	(HZ / 4)
 #define MAX_DELAY_INTERVAL	(15 * HZ)
 
+/*
+ * Messenger v1 connection info metadata: Protocol-specific state for messenger
+ * version 1 connections. Handles legacy wire protocol, authentication handshake,
+ * and connection negotiation with older Ceph versions.
+ */
 struct ceph_connection_v1_info {
-	struct kvec out_kvec[8],         /* sending header/footer data */
-		*out_kvec_cur;
-	int out_kvec_left;   /* kvec's left in out_kvec */
-	int out_skip;        /* skip this many bytes */
-	int out_kvec_bytes;  /* total bytes left */
-	bool out_more;       /* there is more data after the kvecs */
+	/* Output vector management for sending */
+	/* Array of vectors for header/footer data */
+	struct kvec out_kvec[8], *out_kvec_cur;
+	/* Number of kvecs remaining to send */
+	int out_kvec_left;
+	/* Bytes to skip in current operation */
+	int out_skip;
+	/* Total bytes left in kvec array */
+	int out_kvec_bytes;
+	/* More data follows the kvecs */
+	bool out_more;
+	/* Current message send complete */
 	bool out_msg_done;
 
+	/* Authentication state */
+	/* Current authentication handshake */
 	struct ceph_auth_handshake *auth;
+	/* Need to retry authentication */
 	int auth_retry;       /* true if we need a newer authorizer */
 
-	/* connection negotiation temps */
+	/* Connection negotiation temporary storage */
+	/* Received protocol banner */
 	u8 in_banner[CEPH_BANNER_MAX_LEN];
+	/* Peer's actual network address */
 	struct ceph_entity_addr actual_peer_addr;
+	/* Address peer should use for us */
 	struct ceph_entity_addr peer_addr_for_me;
+	/* Our outgoing connection message */
 	struct ceph_msg_connect out_connect;
+	/* Peer's connection reply */
 	struct ceph_msg_connect_reply in_reply;
 
+	/* Input stream position tracking */
 	int in_base_pos;     /* bytes read */
 
-	/* sparse reads */
+	/* Sparse read support */
+	/* Current receive vector for sparse data */
 	struct kvec in_sr_kvec; /* current location to receive into */
+	/* Length of current sparse extent */
 	u64 in_sr_len;		/* amount of data in this extent */
 
-	/* message in temps */
-	u8 in_tag;           /* protocol control byte */
+	/* Incoming message temporary storage */
+	/* Protocol control byte */
+	u8 in_tag;
+	/* Incoming message header */
 	struct ceph_msg_header in_hdr;
-	__le64 in_temp_ack;  /* for reading an ack */
+	/* Temporary acknowledgment storage */
+	__le64 in_temp_ack;
 
-	/* message out temps */
+	/* Outgoing message temporary storage */
+	/* Outgoing message header */
 	struct ceph_msg_header out_hdr;
-	__le64 out_temp_ack;  /* for writing an ack */
-	struct ceph_timespec out_temp_keepalive2;  /* for writing keepalive2
-						      stamp */
+	/* Temporary acknowledgment for sending */
+	__le64 out_temp_ack;
+	/* Keepalive timestamp */
+	struct ceph_timespec out_temp_keepalive2;
 
+	/* Connection sequence tracking */
+	/* Our connection attempt sequence */
 	u32 connect_seq;      /* identify the most recent connection
 				 attempt for this session */
-	u32 peer_global_seq;  /* peer's global seq for this connection */
+	/* Peer's global sequence for this connection */
+	u32 peer_global_seq;
 };
 
 #define CEPH_CRC_LEN			4
@@ -379,88 +523,126 @@ struct ceph_connection_v1_info {
 
 #define CEPH_FRAME_MAX_SEGMENT_COUNT	4
 
+/*
+ * Frame descriptor metadata: Describes the structure of a messenger v2 frame
+ * including segment count, lengths, and alignment requirements. Used for
+ * efficient frame parsing and construction.
+ */
 struct ceph_frame_desc {
-	int fd_tag;  /* FRAME_TAG_* */
+	/* Frame type tag identifier */
+	int fd_tag;
+	/* Number of segments in this frame */
 	int fd_seg_cnt;
-	int fd_lens[CEPH_FRAME_MAX_SEGMENT_COUNT];  /* logical */
+	/* Logical length of each segment */
+	int fd_lens[CEPH_FRAME_MAX_SEGMENT_COUNT];
+	/* Alignment requirements for each segment */
 	int fd_aligns[CEPH_FRAME_MAX_SEGMENT_COUNT];
 };
 
+/*
+ * GCM nonce metadata: Nonce structure for AES-GCM encryption in messenger v2.
+ * Combines a fixed portion with an incrementing counter for cryptographic
+ * uniqueness across encrypted frames.
+ */
 struct ceph_gcm_nonce {
+	/* Fixed portion of the nonce */
 	__le32 fixed;
+	/* Incrementing counter portion */
 	__le64 counter __packed;
 };
 
+/*
+ * Ceph connection version 2 protocol state
+ *
+ * Contains all state information specific to the Ceph messenger v2 protocol.
+ * Version 2 adds significant security enhancements including on-wire encryption,
+ * authentication signatures, and secure session establishment over v1.
+ */
 struct ceph_connection_v2_info {
-	struct iov_iter in_iter;
-	struct kvec in_kvecs[5];  /* recvmsg */
-	struct bio_vec in_bvec;  /* recvmsg (in_cursor) */
-	int in_kvec_cnt;
-	int in_state;  /* IN_S_* */
-
-	struct iov_iter out_iter;
-	struct kvec out_kvecs[8];  /* sendmsg */
-	struct bio_vec out_bvec;  /* sendpage (out_cursor, out_zero),
-				     sendmsg (out_enc_pages) */
-	int out_kvec_cnt;
-	int out_state;  /* OUT_S_* */
-
-	int out_zero;  /* # of zero bytes to send */
-	bool out_iter_sendpage;  /* use sendpage if possible */
-
-	struct ceph_frame_desc in_desc;
-	struct ceph_msg_data_cursor in_cursor;
-	struct ceph_msg_data_cursor out_cursor;
-
-	struct crypto_shash *hmac_tfm;  /* post-auth signature */
-	struct crypto_aead *gcm_tfm;  /* on-wire encryption */
-	struct aead_request *gcm_req;
-	struct crypto_wait gcm_wait;
-	struct ceph_gcm_nonce in_gcm_nonce;
-	struct ceph_gcm_nonce out_gcm_nonce;
-
-	struct page **in_enc_pages;
-	int in_enc_page_cnt;
-	int in_enc_resid;
-	int in_enc_i;
-	struct page **out_enc_pages;
-	int out_enc_page_cnt;
-	int out_enc_resid;
-	int out_enc_i;
-
-	int con_mode;  /* CEPH_CON_MODE_* */
-
-	void *conn_bufs[16];
-	int conn_buf_cnt;
-	int data_len_remain;
-
-	struct kvec in_sign_kvecs[8];
-	struct kvec out_sign_kvecs[8];
-	int in_sign_kvec_cnt;
-	int out_sign_kvec_cnt;
-
-	u64 client_cookie;
-	u64 server_cookie;
-	u64 global_seq;
-	u64 connect_seq;
-	u64 peer_global_seq;
-
-	u8 in_buf[CEPH_PREAMBLE_SECURE_LEN];
-	u8 out_buf[CEPH_PREAMBLE_SECURE_LEN];
+	/* Incoming message processing state */
+	struct iov_iter in_iter;                /* iterator for incoming data */
+	struct kvec in_kvecs[5];                /* scatter-gather vectors for recvmsg */
+	struct bio_vec in_bvec;                 /* bio vector for cursor-based receives */
+	int in_kvec_cnt;                        /* number of active input kvecs */
+	int in_state;                           /* current input state (IN_S_*) */
+
+	/* Outgoing message processing state */
+	struct iov_iter out_iter;               /* iterator for outgoing data */
+	struct kvec out_kvecs[8];               /* scatter-gather vectors for sendmsg */
+	struct bio_vec out_bvec;                /* bio vector for cursor/zero sends */
+	int out_kvec_cnt;                       /* number of active output kvecs */
+	int out_state;                          /* current output state (OUT_S_*) */
+
+	int out_zero;                           /* number of zero bytes to send */
+	bool out_iter_sendpage;                 /* use sendpage optimization when possible */
+
+	/* Message data handling */
+	struct ceph_frame_desc in_desc;         /* incoming frame descriptor */
+	struct ceph_msg_data_cursor in_cursor;  /* cursor for incoming message data */
+	struct ceph_msg_data_cursor out_cursor; /* cursor for outgoing message data */
+
+	/* Cryptographic subsystem for v2 security features */
+	struct crypto_shash *hmac_tfm;          /* HMAC transform for post-auth signatures */
+	struct crypto_aead *gcm_tfm;            /* AES-GCM transform for wire encryption */
+	struct aead_request *gcm_req;           /* GCM request structure */
+	struct crypto_wait gcm_wait;            /* wait queue for crypto operations */
+	struct ceph_gcm_nonce in_gcm_nonce;     /* GCM nonce for incoming data */
+	struct ceph_gcm_nonce out_gcm_nonce;    /* GCM nonce for outgoing data */
+
+	/* Encrypted data page management */
+	struct page **in_enc_pages;             /* pages for incoming encrypted data */
+	int in_enc_page_cnt;                    /* number of incoming encrypted pages */
+	int in_enc_resid;                       /* remaining bytes in incoming encryption */
+	int in_enc_i;                           /* current incoming encryption page index */
+	struct page **out_enc_pages;            /* pages for outgoing encrypted data */
+	int out_enc_page_cnt;                   /* number of outgoing encrypted pages */
+	int out_enc_resid;                      /* remaining bytes in outgoing encryption */
+	int out_enc_i;                          /* current outgoing encryption page index */
+
+	int con_mode;                           /* connection mode (CEPH_CON_MODE_*) */
+
+	/* Connection buffer management */
+	void *conn_bufs[16];                    /* connection-specific buffers */
+	int conn_buf_cnt;                       /* number of active connection buffers */
+	int data_len_remain;                    /* remaining data length to process */
+
+	/* Signature generation vectors */
+	struct kvec in_sign_kvecs[8];           /* vectors for incoming signature calculation */
+	struct kvec out_sign_kvecs[8];          /* vectors for outgoing signature calculation */
+	int in_sign_kvec_cnt;                   /* number of incoming signature vectors */
+	int out_sign_kvec_cnt;                  /* number of outgoing signature vectors */
+
+	/* Session and sequence management */
+	u64 client_cookie;                      /* client session cookie */
+	u64 server_cookie;                      /* server session cookie */
+	u64 global_seq;                         /* global sequence number */
+	u64 connect_seq;                        /* connection sequence number */
+	u64 peer_global_seq;                    /* peer's global sequence number */
+
+	/* Protocol buffers */
+	u8 in_buf[CEPH_PREAMBLE_SECURE_LEN];    /* buffer for incoming preambles */
+	u8 out_buf[CEPH_PREAMBLE_SECURE_LEN];   /* buffer for outgoing preambles */
+
+	/* Frame epilogue for integrity checking */
 	struct {
-		u8 late_status;  /* FRAME_LATE_STATUS_* */
+		u8 late_status;                 /* late frame status (FRAME_LATE_STATUS_*) */
 		union {
 			struct {
-				u32 front_crc;
-				u32 middle_crc;
-				u32 data_crc;
+				u32 front_crc;  /* CRC of front portion */
+				u32 middle_crc; /* CRC of middle portion */
+				u32 data_crc;   /* CRC of data portion */
 			} __packed;
-			u8 pad[CEPH_GCM_BLOCK_LEN - 1];
+			u8 pad[CEPH_GCM_BLOCK_LEN - 1]; /* padding for GCM alignment */
 		};
 	} out_epil;
 };
 
 /*
+ * Ceph network connection metadata: Represents a single network connection
+ * to another Ceph entity (monitor, OSD, MDS). Manages message queuing,
+ * sequencing, authentication, and connection state to ensure reliable,
+ * ordered message delivery even across network interruptions.
+ *
  * A single connection with another host.
  *
  * We maintain a queue of outgoing messages, and some session state to
@@ -468,46 +650,79 @@ struct ceph_connection_v2_info {
  * messages in the case of a TCP disconnect.
  */
 struct ceph_connection {
+	/* Private data for connection owner (mon_client, osd_client, etc.) */
 	void *private;
 
+	/* Callback operations for connection events */
 	const struct ceph_connection_operations *ops;
 
+	/* Parent messenger instance */
 	struct ceph_messenger *msgr;
 
-	int state;  /* CEPH_CON_S_* */
+	/* Connection state management */
+	/* Current protocol state */
+	int state;
+	/* Atomic socket state */
 	atomic_t sock_state;
+	/* Network socket */
 	struct socket *sock;
 
-	unsigned long flags;  /* CEPH_CON_F_* */
-	const char *error_msg;  /* error message, if any */
-
-	struct ceph_entity_name peer_name; /* peer name */
-	struct ceph_entity_addr peer_addr; /* peer address */
+	/* Connection flags and error state */
+	unsigned long flags;
+	/* Human-readable error message */
+	const char *error_msg;
+
+	/* Peer identification */
+	/* Peer entity name (type + ID) */
+	struct ceph_entity_name peer_name;
+	/* Peer network address */
+	struct ceph_entity_addr peer_addr;
+	/* Feature flags supported by peer */
 	u64 peer_features;
 
+	/* Connection serialization */
 	struct mutex mutex;
 
-	/* out queue */
+	/* Message queue management */
+	/* Queue of messages waiting to be sent */
 	struct list_head out_queue;
-	struct list_head out_sent;   /* sending or sent but unacked */
-	u64 out_seq;		     /* last message queued for send */
+	/* Messages sent but not yet acknowledged */
+	struct list_head out_sent;
+	/* Last message sequence number queued */
+	u64 out_seq;
 
-	u64 in_seq, in_seq_acked;  /* last message received, acked */
+	/* Sequence number tracking for reliable delivery */
+	/* Last message received, last message acknowledged */
+	u64 in_seq, in_seq_acked;
 
+	/* Current message processing */
+	/* Message currently being received */
 	struct ceph_msg *in_msg;
+	/* Message currently being sent */
 	struct ceph_msg *out_msg;        /* sending message (== tail of
 					    out_sent) */
 
+	/* I/O processing support */
+	/* Temporary page for small I/O operations */
 	struct page *bounce_page;
-	u32 in_front_crc, in_middle_crc, in_data_crc;  /* calculated crc */
+	/* CRC values for incoming message verification */
+	u32 in_front_crc, in_middle_crc, in_data_crc;
 
-	struct timespec64 last_keepalive_ack; /* keepalive2 ack stamp */
+	/* Keepalive and connection health */
+	/* Timestamp of last keepalive acknowledgment */
+	struct timespec64 last_keepalive_ack;
 
-	struct delayed_work work;	    /* send|recv work */
+	/* Work queue processing */
+	/* Delayed work for send/receive operations */
+	struct delayed_work work;
+	/* Current exponential backoff delay */
 	unsigned long       delay;          /* current delay interval */
 
+	/* Protocol version-specific information */
 	union {
+		/* Messenger v1 protocol state */
 		struct ceph_connection_v1_info v1;
+		/* Messenger v2 protocol state */
 		struct ceph_connection_v2_info v2;
 	};
 };
-- 
2.51.0


