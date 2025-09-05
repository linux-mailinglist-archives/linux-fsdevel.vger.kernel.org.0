Return-Path: <linux-fsdevel+bounces-60375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CD3B46418
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 22:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03FB3BE501
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 20:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FCA2882CC;
	Fri,  5 Sep 2025 20:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Qy+OWVIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3C26FD84
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102511; cv=none; b=h+zMt68lSgHnGPSMiI9P7C+ZbZuCF8/MqVgrhCbrA3cHABus3fheDAzEScL+Xr6MzX+CrDb304Esf/eLNUcoN/Gmndfdrk8+Tys56ICVyugJesz128mVQMtt2iTF3tOqq9lKVuecEygNF3EupeRkI/oLewlE2nPnuGA1np8/aWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102511; c=relaxed/simple;
	bh=LE0hjn75pwkoSLK/gXcBFPygWlgP0KS6nDIZFrN26ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cHMd1sF+DoxEFD5OWfUA+PYW7LdGDS/hyYJwkbyBcxmRo1E9DzcGOtC8yUXuU6YUUfR7cZuzIE0Iyd36xmXZz/vRwSlxazXINV4quPXFLGfdXMnA0L+p2IYS8B6uqTVCoahoU3FV7s9OkynLyqlsfRMrkTnYmrwC4lEzUd31nFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Qy+OWVIK; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d603b60cbso24257177b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Sep 2025 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757102508; x=1757707308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmhDgPf9hf8qVBXfA+JdBAxZi0irYx7iP9xEt0yP5wg=;
        b=Qy+OWVIKk+ZDCwaTfsit2kpc7pqV7Sio/iqIHAlOdV1ZBOpKDTfM5CPkDOfpIz/XwM
         WguCMf+atfpVIQ04UDPoY4kLCkMceKlmX1YB/jnj2RGU1ShzJFFcwI5yMDYj2Iapsf/5
         h7yoaMyjFRjAV/zsGGyMX/bJ7L8MU8kpYKB7Lw0rl1vC4EjRIj9FRsCw3bUixwEK0qKx
         7zSmQsHP44v8lXNs64GEcLKviLWCb8HlyxLaV1nFH40lATI9TYaclUByWGuTpXIH/BDc
         Avb4FifcUnUqTQYdpKrQmKbLFvsqdTQEQAlUahl5s0Okqp8bxAl8at0NSmbxkc1VqrKx
         fflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757102508; x=1757707308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmhDgPf9hf8qVBXfA+JdBAxZi0irYx7iP9xEt0yP5wg=;
        b=hs31J+Bog6FU+HBfYy40Yt39555xmOxAmDl9cYb6sl/x9Tb44hRqI9Mr8qViELEu6y
         I0rd3PpeHnhlaGK3+eFrmqQzogNBpxykpMBmkCXaT+CtUt8GrfGy/PBkdDuIDcbsnld7
         2zG5VF68FDG4i/BErLBKPn2Hr0jmJNVTe5lQsIpTaBOl8G+2qKv18BvxFv0yqBzl6FsB
         jVfPwxG4ES+p8HAhXHJGH+jvQgzuJfX5FfbClu0XvzMbuP1SUdkWJwKjnxklPIjHK8zJ
         WaALmBj4OO0b5tOFXrvAS5b08djWj75o2yE3VYt+MKsy1YdTTpx4yDZfx/+IyeS8R5uj
         8fPw==
X-Forwarded-Encrypted: i=1; AJvYcCUQg8PidaI4wdPR8rMDNrCB1kQRhoMMqsp5w4LOBYMA93j1bgF8jpxymkYpy9KyRRFJV0FDqS4Mw1uA/KL3@vger.kernel.org
X-Gm-Message-State: AOJu0YxybNZ61wQ913vFeZp9nPNmyMk1Ui4ae2bYrcVjHpI/qHiXVW9z
	EvjjnqbAo9S3FX8MQnAe4aRKLn5MSnGkJAxaOAI2Z2WvfHTYQhwMONog+y6OLMIwaBo=
X-Gm-Gg: ASbGncuwdI0wOVjiHXyvXPhuG/JTbfnZLGLaq0YwgpVC/4nwMcJOYKzaw7WkhEv/EfP
	AvXY6QZ60vIAYZTYvv/TEs24ggdgoXI1LJki+oNhuN5IXCbAdiIidJ0IYYBZwOp0IhYbRSqEwRg
	+gfMf2z0cMro1ANxIJZ5k9K2o20WC0YGAtgCN/duzdRyWsN1ptzkoSArtVM5HccfvEKU57PvT7H
	lQiZoLGtaMIi0zyIa/YbMLxUayvLCavbPvNK3lUBuDVmnbrtxB00ZZDGKiLnIyWPVaD/LC39V0r
	AdpIdGYHStpG3wSBzy7RijHHvHlhJZCsSvC28HBusVDiCo4zOThJIy1SbudAkag7CJlqmrReGwd
	SZfPna+/xZPdTtTMFYz3vxeUbbnQdna2c/WigziliBj4ts36xOoA=
X-Google-Smtp-Source: AGHT+IGAwTm0FG/DKA6TRJONfYNC13SH8h5I2cPGvFB4DWOxuKN72Wg0DYF4XZay3nDWcMyLjrNZeA==
X-Received: by 2002:a05:690c:650c:b0:71b:f500:70c0 with SMTP id 00721157ae682-727f368e6e8mr1187267b3.6.1757102506889;
        Fri, 05 Sep 2025 13:01:46 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:2479:21e9:a32d:d3ee])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a834c9adsm32360857b3.28.2025.09.05.13.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 13:01:46 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH 01/20] ceph: add comments to metadata structures in auth.h
Date: Fri,  5 Sep 2025 13:00:49 -0700
Message-ID: <20250905200108.151563-2-slava@dubeyko.com>
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

This patch adds comments for struct ceph_authorizer,
struct ceph_auth_handshake, struct ceph_auth_client_ops,
struct ceph_auth_client in /include/linux/ceph/auth.h.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 include/linux/ceph/auth.h | 59 ++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/include/linux/ceph/auth.h b/include/linux/ceph/auth.h
index 6b138fa97db8..339399cbabe9 100644
--- a/include/linux/ceph/auth.h
+++ b/include/linux/ceph/auth.h
@@ -15,22 +15,40 @@
 struct ceph_auth_client;
 struct ceph_msg;
 
+/*
+ * Abstract authorizer handle used for authentication with Ceph services.
+ * Each authentication protocol provides its own implementation.
+ */
 struct ceph_authorizer {
+	/* Protocol-specific cleanup function */
 	void (*destroy)(struct ceph_authorizer *);
 };
 
+/*
+ * Authentication handshake state for communicating with a specific service.
+ * Contains authorizer data and cryptographic functions for message security.
+ */
 struct ceph_auth_handshake {
+	/* The authorizer token for this service connection */
 	struct ceph_authorizer *authorizer;
+	/* Serialized authorizer data sent to the service */
 	void *authorizer_buf;
 	size_t authorizer_buf_len;
+	/* Buffer for receiving authorizer reply from service */
 	void *authorizer_reply_buf;
 	size_t authorizer_reply_buf_len;
+	/* Sign outgoing messages using session keys */
 	int (*sign_message)(struct ceph_auth_handshake *auth,
 			    struct ceph_msg *msg);
+	/* Verify signatures on incoming messages */
 	int (*check_message_signature)(struct ceph_auth_handshake *auth,
 				       struct ceph_msg *msg);
 };
 
+/*
+ * Protocol-specific operations for authentication with Ceph monitors.
+ * Each authentication method (cephx, etc.) implements these callbacks.
+ */
 struct ceph_auth_client_ops {
 	/*
 	 * true if we are authenticated and can connect to
@@ -87,20 +105,35 @@ struct ceph_auth_client_ops {
 				       struct ceph_msg *msg);
 };
 
+/*
+ * Main authentication client state for communicating with Ceph monitors.
+ * Manages protocol negotiation, credentials, and service authorization.
+ */
 struct ceph_auth_client {
-	u32 protocol;           /* CEPH_AUTH_* */
-	void *private;          /* for use by protocol implementation */
-	const struct ceph_auth_client_ops *ops;  /* null iff protocol==0 */
-
-	bool negotiating;       /* true if negotiating protocol */
-	const char *name;       /* entity name */
-	u64 global_id;          /* our unique id in system */
-	const struct ceph_crypto_key *key;     /* our secret key */
-	unsigned want_keys;     /* which services we want */
-
-	int preferred_mode;	/* CEPH_CON_MODE_* */
-	int fallback_mode;	/* ditto */
-
+	/* Authentication protocol in use (CEPH_AUTH_*) */
+	u32 protocol;
+	/* Protocol-specific private data */
+	void *private;
+	/* Protocol operations vtable (null if protocol==0) */
+	const struct ceph_auth_client_ops *ops;
+
+	/* true if currently negotiating authentication protocol */
+	bool negotiating;
+	/* Ceph entity name (e.g., "client.admin") */
+	const char *name;
+	/* Unique identifier assigned by monitor */
+	u64 global_id;
+	/* Secret key for authentication */
+	const struct ceph_crypto_key *key;
+	/* Bitmask of services we want tickets for */
+	unsigned want_keys;
+
+	/* Preferred connection security mode */
+	int preferred_mode;
+	/* Fallback connection security mode */
+	int fallback_mode;
+
+	/* Protects concurrent access to auth state */
 	struct mutex mutex;
 };
 
-- 
2.51.0


