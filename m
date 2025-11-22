Return-Path: <linux-fsdevel+bounces-69502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A647EC7D972
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1FB6934654F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28DE2EA732;
	Sat, 22 Nov 2025 22:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="YKXiKg4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E112E92D6
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850280; cv=none; b=GP30XqST0qb6f6CTEc/OT9fHOLVe2ekRSNSwbt0lInecNRmqgNVTSou3Qmg680UY6YlXwndwkBBs59WONommame4cyyJTS96fOa7CKwTiVySF8Ut1DP0XrummXTfLnMz3Yqbfe3flbML0rWVtk6ug5JZlz1gw97ILB6np4gbbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850280; c=relaxed/simple;
	bh=QEEvS+jdUJeKKxkBIFzT0YN5eKSWf6n6Ab4j5opHktU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyuF2ios1d/Kj9IKZSE3SnObu/S93mwWsWPfKpeI4BBtoW6sDLy0EV9amGg+n5BiBFeGrWbVDfvNnzZ70SJhBROjKBsQYdNgdmIirHW3Aehy3aFY5oK2HaCD8Yj4aMi6IlyBvjLjmTIRNyfEfjfcoXJI19bobfG9p8jScFcnCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=YKXiKg4U; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-787d5555274so32132317b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850276; x=1764455076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62PEQYDhS44k4KirgxolX0bFfpu4NqLUXaq5TcT1ZZY=;
        b=YKXiKg4U+JHb2CGm1foeaVy/7iaXEaQwHDTDnKkGEaTFvvkXRfA7DwY1A8YF/FxA60
         ZkgnR/TlESb1Nv5KdilQY0dRhuSQt1gf83oISgxFTQDjYh839JmKrztQEdiWEC51V3Kw
         E2nzjU2b7JpcJsk2/jkRsIj6HOXRgX2dcQ7i9gRQey9KVl1zV5dYykwOJdpB3IK84Vfg
         hTYXJrYksy4iFBWEcHloUKZmtNQDOdooFd+Gohjnh8cuoDaOB07xdi5Ymrc+SwUfcH14
         iXv3U4rQMu6bQkBMuhRGowr2f3uCVvwbu76pkzaqIBFe17X47NtCyv7V+c+HFtmtdjfA
         zdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850276; x=1764455076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62PEQYDhS44k4KirgxolX0bFfpu4NqLUXaq5TcT1ZZY=;
        b=j3ZG2Z9gBYiCi6RIghGWcqOHxvsBA9nrTcR6KEe2sGcfVIUWqObrCuid7EjaXtdgaU
         Fx2hYEpYXYYTFllbuMD89o0jfNFHQKdr2mGb6QdoJEnkadZo9Ydd5lSqwPcCR6SXPLHk
         xeSVsZHqEH5V3DhYq19IFZV87qkbPPAbOtThwfM7DqE4XPoTu5SfI2HjhnJSIJ+5/jCA
         pMmOfCWrzHcK/BqaLj/78qWHZv5kMCdjFOo1apsZxq+t7OdaNaQXRco+17TfGyNeo5zj
         sHbBUqbw7IQffFe/9y/J+2lcUNSHyRWw0gGtixiCY2ojOswriWtJuu5NKrGaMOtEI5yn
         0h7g==
X-Forwarded-Encrypted: i=1; AJvYcCWuUAA0FffJYMihAFh59/5rBlMlMyfm1WXGOIV5df6mLcYLLHNywbt8wRBolRPJ+s5Kekwubf+TclK/ZPqB@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDwmaQHV4Bdjc89/pJQo0H/vJqmnndhzrlEe8s+Iam/4lz1Zy
	2fkgMbjKLe6H84OM3O0whgkzoPGSU/9J3LfLxR4257N4Oz/zW5yyOHqPvKkKvKG5QFY=
X-Gm-Gg: ASbGnctLa6qd2dlU6yeBl3b7HVxqwLyvRoVnl18TJdeRpu3XMoHOXtt/05MC2NuYf2K
	ZRFJJIbSZECtt6wT0fz+YmZpGNto6u7OZNOKp8cMJYAbAVehXVWRxg0jPY3jY5zgWMpsELX8C2w
	YLnrlPRxYUm6sYU27vS0nQ9XzReZ5L68XYouJcEdbhRnB1o9B3Rq29KZzrrTboqHJ4Kbe0KGpxM
	gR8YgEpwB/ai6osOvMequ+eD8ZyvfxXesCMmU/VCXJhCF77HlO24Z00XQC4nhbyDFs7hAP7zcFY
	UmxcjzZSX1g0lcXz22aTNvkjIbyZFceKKJVquIPNG2U4IepL3JzHYs5QHb9gznjRgg2yEewbNs9
	T5LLCTfDR+n72cK4QSbLBaCelQvQwTZM1c3bYatgUCnmuf3xZ+0YqaAmq0y3UQv9qzpFO1ckT6J
	eIAtHWeiSn3C/cp54msfFkJaUk00jUpX94yJMlKbVVkVMS+mTl2Rj3wK6mZrKr1YpdT3Y9R2bjx
	VPU0xM=
X-Google-Smtp-Source: AGHT+IHkNZ1O05/wx0JB3pi70sYZwOs5GclCpL45vuZfhM2JjOjXMdM7CjvQ81K6Kvb3Obn+lJkkcQ==
X-Received: by 2002:a05:690c:3690:b0:788:182e:b29e with SMTP id 00721157ae682-78a8b47de80mr61772657b3.7.1763850276575;
        Sat, 22 Nov 2025 14:24:36 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:36 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v7 20/22] liveupdate: luo_file: Add internal APIs for file preservation
Date: Sat, 22 Nov 2025 17:23:47 -0500
Message-ID: <20251122222351.1059049-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The core liveupdate mechanism allows userspace to preserve file
descriptors. However, kernel subsystems often manage struct file
objects directly and need to participate in the preservation process
programmatically without relying solely on userspace interaction.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h       | 23 +++++++++++
 kernel/liveupdate/luo_file.c     | 71 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h | 16 +++++++
 3 files changed, 110 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index a7f6ee5b6771..c9503d2cda7b 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -15,11 +15,13 @@
 #include <uapi/linux/liveupdate.h>
 
 struct liveupdate_file_handler;
+struct liveupdate_session;
 struct file;
 
 /**
  * struct liveupdate_file_op_args - Arguments for file operation callbacks.
  * @handler:          The file handler being called.
+ * @session:          The session this file belongs to.
  * @retrieved:        The retrieve status for the 'can_finish / finish'
  *                    operation.
  * @file:             The file object. For retrieve: [OUT] The callback sets
@@ -37,6 +39,7 @@ struct file;
  */
 struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
+	struct liveupdate_session *session;
 	bool retrieved;
 	struct file *file;
 	u64 serialized_data;
@@ -112,6 +115,14 @@ int liveupdate_reboot(void);
 int liveupdate_register_file_handler(struct liveupdate_file_handler *fh);
 int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh);
 
+/* kernel can internally retrieve files */
+int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
+				 struct file **filep);
+
+/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
+int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+				  struct file *file, u64 *tokenp);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline bool liveupdate_enabled(void)
@@ -134,5 +145,17 @@ static inline int liveupdate_unregister_file_handler(struct liveupdate_file_hand
 	return -EOPNOTSUPP;
 }
 
+static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
+					       u64 token, struct file **filep)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+						struct file *file, u64 *tokenp)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index b235d1b562ad..670649932de4 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -299,6 +299,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	mutex_init(&luo_file->mutex);
 
 	args.handler = fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = file;
 	err = fh->ops->preserve(&args);
 	if (err)
@@ -350,6 +351,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 					   struct luo_file, list);
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -377,6 +379,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -398,6 +401,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -581,6 +585,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	}
 
 	args.handler = luo_file->fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.serialized_data = luo_file->serialized_data;
 	err = luo_file->fh->ops->retrieve(&args);
 	if (!err) {
@@ -606,6 +611,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.retrieved = luo_file->retrieved;
@@ -623,6 +629,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 	guard(mutex)(&luo_file->mutex);
 
 	args.handler = luo_file->fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
 	args.retrieved = luo_file->retrieved;
@@ -889,3 +896,67 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 
 	return 0;
 }
+
+/**
+ * liveupdate_get_token_outgoing - Get the token for a preserved file.
+ * @s:      The outgoing liveupdate session.
+ * @file:   The file object to search for.
+ * @tokenp: Output parameter for the found token.
+ *
+ * Searches the list of preserved files in an outgoing session for a matching
+ * file object. If found, the corresponding user-provided token is returned.
+ *
+ * This function is intended for in-kernel callers that need to correlate a
+ * file with its liveupdate token.
+ *
+ * Context: Can be called from any context that can acquire the session mutex.
+ * Return: 0 on success, -ENOENT if the file is not preserved in this session.
+ */
+int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+				  struct file *file, u64 *tokenp)
+{
+	struct luo_file_set *file_set = luo_file_set_from_session(s);
+	struct luo_file *luo_file;
+	int err = -ENOENT;
+
+	list_for_each_entry(luo_file, &file_set->files_list, list) {
+		if (luo_file->file == file) {
+			if (tokenp)
+				*tokenp = luo_file->token;
+			err = 0;
+			break;
+		}
+	}
+
+	return err;
+}
+
+/**
+ * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
+ * @s:      The incoming liveupdate session (restored from the previous kernel).
+ * @token:  The unique token identifying the file to retrieve.
+ * @filep:  On success, this will be populated with a pointer to the retrieved
+ *          'struct file'.
+ *
+ * Provides a kernel-internal API for other subsystems to retrieve their
+ * preserved files after a live update. This function is a simple wrapper
+ * around luo_retrieve_file(), allowing callers to find a file by its token.
+ *
+ * The operation is idempotent; subsequent calls for the same token will return
+ * a pointer to the same 'struct file' object.
+ *
+ * The caller receives a new reference to the file and must call fput() when it
+ * is no longer needed. The file's lifetime is managed by LUO and any userspace
+ * file descriptors. If the caller needs to hold a reference to the file beyond
+ * the immediate scope, it must call get_file() itself.
+ *
+ * Context: Can be called from any context in the new kernel that has a handle
+ *          to a restored session.
+ * Return: 0 on success. Returns -ENOENT if no file with the matching token is
+ *         found, or any other negative errno on failure.
+ */
+int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
+				 struct file **filep)
+{
+	return luo_retrieve_file(luo_file_set_from_session(s), token, filep);
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index c8973b543d1d..734469464664 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -84,6 +84,22 @@ struct luo_session {
 	struct mutex mutex;
 };
 
+static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
+{
+	struct luo_session *session;
+
+	session = container_of(file_set, struct luo_session, file_set);
+
+	return (struct liveupdate_session *)session;
+}
+
+static inline struct luo_file_set *luo_file_set_from_session(struct liveupdate_session *s)
+{
+	struct luo_session *session = (struct luo_session *)s;
+
+	return &session->file_set;
+}
+
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
 int __init luo_session_setup_outgoing(void *fdt);
-- 
2.52.0.rc2.455.g230fcf2819-goog


