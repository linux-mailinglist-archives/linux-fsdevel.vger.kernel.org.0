Return-Path: <linux-fsdevel+bounces-60387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68478B46430
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C417C347
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B742ED149;
	Fri,  5 Sep 2025 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="vPP5AtSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADE287501
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102529; cv=none; b=py/S1T3v1YGRZ/GHB+N1QPGuvQpO/MYt0kY0hBLmIke1L8kL7VUwyTBfHn5oHp2rSnZRuQnJtCkmaI7DTweJYz6TxDtZQZwGpr0koHViJwmiG4hkEGocCpusAHy6pvZsUuaAaPCvLaQ3JmJTc9RbEQu7Lum4TY5hxrRWP/E9ip4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102529; c=relaxed/simple;
	bh=AQDf0G2hlIxaD6boy9r/pyXZ2pCCgvJx49+Hg1nhIBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZ/F+LgjCxEZFInQgkx93aFc8z8PnC94LvAXXtOnz7BCYQxdXnObiWn0Qeo/ciLmdnd+g+PQkrZen8YCtScTmKc8zHL+KA0p8DRZ5OOseQ0E2QBLHtLVf9qe186746QadSvjdxvaaRO1umItldRF0Wn2mdNpxeNJUY9nRS2yNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=vPP5AtSx; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6045eb3848eso134210d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102526; x=1757707326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZWAztCbt6DWw6s0wfVFas7uU2qxg6FRZ8XTW+e1ax4=;
        b=vPP5AtSxQNvWPFjSdko0oA+CbW8F/AKwU77toYy7u8C+k6nVzVMkKa571gmDVPJnKi
         XFSioKrdVU0AVfo7NUTaUH8aGt1TMTmSQUsTau/5NpySsk0OpwiXXe5cSoLL/iqQ18hC
         ZOIiiiJDOYvbFWJVlrJmxkoeqCvaKiTsTuZVQLvdJ9W54cfuIHFlme+ufs2oqDeatPqC
         DIACpKd4Mu7P77mSPDY4yGSJiciruif6LbOR8g6JqlyVWs/TjLtQWevmXI/lqN9AZJYl
         wNlQmMo0CtVFd0n5k+uovoZZG/lFb/qvWdm8XmZK0Ily6tGmzHkQM8sv7bZ+HB3WDERM
         nqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102526; x=1757707326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZWAztCbt6DWw6s0wfVFas7uU2qxg6FRZ8XTW+e1ax4=;
        b=TYVXkF35oGqDxfFo3KXgYVvOBJliLzzXLLV0xy7eZg71+roPSHyNQVIw4vYwqNlhfg
         9zCui+bQygKcZt3Lyb4/pvHL5H18WwtYWsl7dZJz9C7Ku7zz049FYqUH7fveg40ljc6n
         RJQVJHLSZMl4RD6QUCOyFrxcZql0R5hP6clpo9jhijWbUNX376Fq64HvYc5j56gBQPS1
         6YP4EUWSmBRfBcn09YgEAutMwzd4g58UhcOT+p8HEP/sflVRXbfvGZ0pi9iuTVmmqfqa
         X+dBiWmbgKdhuGsXg4X3/3LpV9+T2ucwMF+nrv0o3DDM652qgnsp8AYS+9iaO/vaDSbi
         riHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWISdSIkMlt40J3P+z6CP7+f5cvwyCJU9LYOHCEqPSgCNYxWFGG9yEczq1kYN3w1cdht6OExsFgIAJ3h7jG@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYzIbS2YGn2lX5x5xIk9xWaJm5tfltQv9ercTmU29emqawWZ3
	P3trViawZiqQ6JJz4xtVLDVS7WoWVRSI2gF3F5r0bC8kOgDPd9pWWi9loBoQEkaGvK4=
X-Gm-Gg: ASbGncuC1yqXgY46wwBIwtGqQSU8Y0kXKjEhllTXZKYAmaVDEsWmGvzzwb7J+aDBIQv
	c53vWGfZMyogp0GX86PLlGsPz5e42aEwRzwiMkfV7HL5RD00eOrNepnlinAFt0+GonWPvxgVR/h
	8yBJD0PDhesvjYgfCDsCbsc1cxdwCOw+L0RkTAkfxuqByCakSdxMtwzF3nTUBxAO0rsFuaX3lF/
	OPiKNHuufpZzchY+4PjoP2HLuRlQHrfHV7ttWTM9lL8yu3cMkL9MEkQexVzAeCc/NpeoiFK26oV
	fKoe3BmNmr81CUlHcP+3sFunR8VoWkyGzY19usjA5o5F81B42iXjzWqctMuB9LL6BFyTbwCYjBA
	5ZC3RGInoVbPwO1NgNiEg2r2wgD8pvJ/oW3P37yJD05gfXd9hV+Y=
X-Google-Smtp-Source: AGHT+IHgg4bgN4Qeib5foLfM+IiiTN1YWyq8RiMVU8s36uIxUOH9ET0GKVXtpXdaf5ICeJal2L/TzA==
X-Received: by 2002:a05:690e:14c9:b0:5f3:319c:fec4 with SMTP id 956f58d0204a3-6102277dfe5mr242222d50.9.1757102526360;
        Fri, 05 Sep 2025 13:02:06 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:02:05 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 13/20] ceph: add comments to metadata structures in msgr.h
Date: Fri,  5 Sep 2025 13:01:01 -0700
Message-ID: <20250905200108.151563-14-slava@dubeyko.com>
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

This patch adds comments for struct ceph_entity_name,
struct ceph_entity_addr, struct ceph_entity_inst,
struct ceph_msg_connect, struct ceph_msg_connect_reply,
struct ceph_msg_header_old, struct ceph_msg_header,
struct ceph_msg_header2, struct ceph_msg_footer_old,
struct ceph_msg_footer in /include/linux/ceph/msgr.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/msgr.h | 162 +++++++++++++++++++++++++++++++-------
 1 file changed, 132 insertions(+), 30 deletions(-)

diff --git a/include/linux/ceph/msgr.h b/include/linux/ceph/msgr.h
index 3989dcb94d3d..69b0a50f1453 100644
--- a/include/linux/ceph/msgr.h
+++ b/include/linux/ceph/msgr.h
@@ -60,11 +60,17 @@ static inline __s32 ceph_seq_cmp(__u32 a, __u32 b)
 
 
 /*
+ * Entity name metadata: Logical identifier for a Ceph process participating
+ * in the cluster network. Combines entity type (monitor, OSD, MDS, client)
+ * with a unique number to create globally unique process identifiers.
+ *
  * entity_name -- logical name for a process participating in the
  * network, e.g. 'mds0' or 'osd3'.
  */
 struct ceph_entity_name {
+	/* Entity type (monitor, OSD, MDS, client, etc.) */
 	__u8 type;      /* CEPH_ENTITY_TYPE_* */
+	/* Unique number within the entity type */
 	__le64 num;
 } __attribute__ ((packed));
 
@@ -79,11 +85,16 @@ struct ceph_entity_name {
 extern const char *ceph_entity_type_name(int type);
 
 /*
- * entity_addr -- network address
+ * Entity address metadata: Network address information for a Ceph entity.
+ * Contains address type, process nonce for disambiguation, and the actual
+ * network socket address for establishing connections.
  */
 struct ceph_entity_addr {
+	/* Address type identifier */
 	__le32 type;  /* CEPH_ENTITY_ADDR_TYPE_* */
-	__le32 nonce;  /* unique id for process (e.g. pid) */
+	/* Unique process identifier (typically PID) */
+	__le32 nonce;
+	/* Socket address (IPv4/IPv6) */
 	struct sockaddr_storage in_addr;
 } __attribute__ ((packed));
 
@@ -94,8 +105,15 @@ static inline bool ceph_addr_equal_no_type(const struct ceph_entity_addr *lhs,
 	       lhs->nonce == rhs->nonce;
 }
 
+/*
+ * Entity instance metadata: Complete identification of a Ceph entity
+ * combining logical name with network address. Uniquely identifies
+ * a specific process instance in the cluster.
+ */
 struct ceph_entity_inst {
+	/* Logical entity name (type + number) */
 	struct ceph_entity_name name;
+	/* Network address for this entity */
 	struct ceph_entity_addr addr;
 } __attribute__ ((packed));
 
@@ -122,26 +140,48 @@ struct ceph_entity_inst {
 #define CEPH_MSGR_TAG_CHALLENGE_AUTHORIZER 16  /* cephx v2 doing server challenge */
 
 /*
- * connection negotiation
+ * Connection negotiation request metadata: Initial message sent to establish
+ * a connection with another Ceph entity. Contains feature negotiation,
+ * authentication details, and connection sequencing information.
  */
 struct ceph_msg_connect {
-	__le64 features;     /* supported feature bits */
+	/* Feature flags supported by this client */
+	__le64 features;
+	/* Entity type of the connecting host */
 	__le32 host_type;    /* CEPH_ENTITY_TYPE_* */
-	__le32 global_seq;   /* count connections initiated by this host */
+	/* Global connection sequence (across all sessions) */
+	__le32 global_seq;
+	/* Connection sequence within current session */
 	__le32 connect_seq;  /* count connections initiated in this session */
+	/* Wire protocol version */
 	__le32 protocol_version;
+	/* Authentication protocol identifier */
 	__le32 authorizer_protocol;
+	/* Length of authentication data */
 	__le32 authorizer_len;
+	/* Connection flags (lossy, etc.) */
 	__u8  flags;         /* CEPH_MSG_CONNECT_* */
 } __attribute__ ((packed));
 
+/*
+ * Connection negotiation reply metadata: Response to connection request
+ * indicating whether connection was accepted, feature set negotiated,
+ * and any authentication challenges or requirements.
+ */
 struct ceph_msg_connect_reply {
+	/* Reply tag (ready, retry, error, etc.) */
 	__u8 tag;
-	__le64 features;     /* feature bits for this session */
+	/* Feature flags enabled for this session */
+	__le64 features;
+	/* Server's global sequence number */
 	__le32 global_seq;
+	/* Server's connection sequence number */
 	__le32 connect_seq;
+	/* Negotiated protocol version */
 	__le32 protocol_version;
+	/* Length of authorization challenge data */
 	__le32 authorizer_len;
+	/* Connection reply flags */
 	__u8 flags;
 } __attribute__ ((packed));
 
@@ -149,60 +189,111 @@ struct ceph_msg_connect_reply {
 
 
 /*
- * message header
+ * Legacy message header metadata: Original wire format for message headers
+ * in older Ceph versions. Contains complete routing information, payload
+ * lengths, and both source and original source for message forwarding.
  */
 struct ceph_msg_header_old {
-	__le64 seq;       /* message seq# for this session */
-	__le64 tid;       /* transaction id */
-	__le16 type;      /* message type */
-	__le16 priority;  /* priority.  higher value == higher priority */
-	__le16 version;   /* version of message encoding */
-
+	/* Message sequence number for this session */
+	__le64 seq;
+	/* Transaction identifier for request/reply correlation */
+	__le64 tid;
+	/* Message type identifier */
+	__le16 type;
+	/* Message priority (higher value = higher priority) */
+	__le16 priority;
+	/* Version of message encoding/format */
+	__le16 version;
+
+	/* Payload section lengths */
+	/* Length of front payload section */
 	__le32 front_len; /* bytes in main payload */
+	/* Length of middle payload section */
 	__le32 middle_len;/* bytes in middle payload */
+	/* Length of data payload section */
 	__le32 data_len;  /* bytes of data payload */
+	/* Data offset (sender: full offset, receiver: page-masked) */
 	__le16 data_off;  /* sender: include full offset;
 			     receiver: mask against ~PAGE_MASK */
 
+	/* Message routing information */
+	/* Current source and original source entities */
 	struct ceph_entity_inst src, orig_src;
+	/* Reserved field */
 	__le32 reserved;
-	__le32 crc;       /* header crc32c */
+	/* Header CRC32c checksum */
+	__le32 crc;
 } __attribute__ ((packed));
 
+/*
+ * Standard message header metadata: Current wire format for message headers.
+ * Streamlined compared to legacy format, containing essential routing and
+ * payload information with compatibility version support.
+ */
 struct ceph_msg_header {
-	__le64 seq;       /* message seq# for this session */
-	__le64 tid;       /* transaction id */
-	__le16 type;      /* message type */
-	__le16 priority;  /* priority.  higher value == higher priority */
-	__le16 version;   /* version of message encoding */
-
+	/* Message sequence number for this session */
+	__le64 seq;
+	/* Transaction identifier for request/reply correlation */
+	__le64 tid;
+	/* Message type identifier */
+	__le16 type;
+	/* Message priority (higher value = higher priority) */
+	__le16 priority;
+	/* Version of message encoding/format */
+	__le16 version;
+
+	/* Payload section lengths */
+	/* Length of front payload section */
 	__le32 front_len; /* bytes in main payload */
+	/* Length of middle payload section */
 	__le32 middle_len;/* bytes in middle payload */
+	/* Length of data payload section */
 	__le32 data_len;  /* bytes of data payload */
+	/* Data offset (sender: full offset, receiver: page-masked) */
 	__le16 data_off;  /* sender: include full offset;
 			     receiver: mask against ~PAGE_MASK */
 
+	/* Message source entity name */
 	struct ceph_entity_name src;
+	/* Compatibility version for backward compatibility */
 	__le16 compat_version;
+	/* Reserved field */
 	__le16 reserved;
-	__le32 crc;       /* header crc32c */
+	/* Header CRC32c checksum */
+	__le32 crc;
 } __attribute__ ((packed));
 
+/*
+ * Messenger v2 header metadata: Enhanced message header for messenger v2
+ * protocol with improved padding support, acknowledgment sequencing, and
+ * extended compatibility information.
+ */
 struct ceph_msg_header2 {
-	__le64 seq;       /* message seq# for this session */
-	__le64 tid;       /* transaction id */
-	__le16 type;      /* message type */
-	__le16 priority;  /* priority.  higher value == higher priority */
-	__le16 version;   /* version of message encoding */
-
+	/* Message sequence number for this session */
+	__le64 seq;
+	/* Transaction identifier for request/reply correlation */
+	__le64 tid;
+	/* Message type identifier */
+	__le16 type;
+	/* Message priority (higher value = higher priority) */
+	__le16 priority;
+	/* Version of message encoding/format */
+	__le16 version;
+
+	/* Data padding and alignment */
+	/* Length of pre-padding before data payload */
 	__le32 data_pre_padding_len;
+	/* Data offset (sender: full offset, receiver: page-masked) */
 	__le16 data_off;  /* sender: include full offset;
 			     receiver: mask against ~PAGE_MASK */
 
+	/* Acknowledgment sequence number */
 	__le64 ack_seq;
+	/* Message flags */
 	__u8 flags;
-	/* oldest code we think can decode this.  unknown if zero. */
+	/* Oldest code version that can decode this message.  unknown if zero. */
 	__le16 compat_version;
+	/* Reserved field */
 	__le16 reserved;
 } __attribute__ ((packed));
 
@@ -212,17 +303,28 @@ struct ceph_msg_header2 {
 #define CEPH_MSG_PRIO_HIGHEST 255
 
 /*
- * follows data payload
+ * Legacy message footer metadata: Integrity validation for older message format.
+ * Contains CRC checksums for each payload section to detect transmission errors
+ * and corruption. Used with legacy message headers for backward compatibility.
  */
 struct ceph_msg_footer_old {
+	/* CRC32c checksums for payload integrity validation */
 	__le32 front_crc, middle_crc, data_crc;
+	/* Message completion and validation flags */
 	__u8 flags;
 } __attribute__ ((packed));
 
+/*
+ * Standard message footer metadata: Enhanced integrity validation with digital
+ * signatures. Includes CRC checksums for each payload section plus optional
+ * cryptographic signature for message authenticity and non-repudiation.
+ */
 struct ceph_msg_footer {
+	/* CRC32c checksums for payload integrity validation */
 	__le32 front_crc, middle_crc, data_crc;
-	// sig holds the 64 bits of the digital signature for the message PLR
+	/* 64-bit digital signature for message authenticity (PLR) */
 	__le64  sig;
+	/* Message completion and validation flags */
 	__u8 flags;
 } __attribute__ ((packed));
 
-- 
2.51.0


