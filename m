Return-Path: <linux-fsdevel+bounces-68586-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAEC60D65
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 00:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7573BE258
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 23:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E4271476;
	Sat, 15 Nov 2025 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="C3iCx/rG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD730C366
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249692; cv=none; b=faEOpB6awmrLeA+r5IqH2WkINajh34fn36ea10zLlGbWShsgNjhNNJTdnXtlQDXFL2QXkE2lJ6FlaowRIyfL65wN0/MJFQCtiXPeK2vAnF+0KTJmBmvddqedkOOrHnucMDp7tIZjhmckzkJUFworNuwX1FxZM5HhoOiyI6LB97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249692; c=relaxed/simple;
	bh=xccKVGMJ06tz/lkKn64u87jb4PRZGDO1HSTw7IKUbOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/E8l2an9m6QakL9gU3KcR693ysqbAQMNbpAQjkEnfPuoMY0XuBdQdKRILInV1r9iSNEDTNfvQJo9g5EMKzIIvqq9RqPrYKPNn2FyUdQrm2ZqI9erdU181USqwCD4JGdBzu5xGCq8h77J+VS9X2GRoNWxF5cyqn/Fh9HnWtH6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=C3iCx/rG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d71bcab6fso28794097b3.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 15:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763249689; x=1763854489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyQXl7tWXRV/YETkSwjN2Plb4i1qeg0xlo6fhXkHNVA=;
        b=C3iCx/rGV582hC4pEfJpW/VhjJ52sbI6jrHAV/ts15eo/ss0O/5uY9h42uFZ+GvVtS
         mUzRTu2/FHfMi7gspOsL2/p7doxgbIZkmGFRm3i6U09Vf6Y7ChbtNVa9OiStJCc3pRHc
         9DNU8tZX6OKA+ksAFGUBmaGYgl4W6wvoGEPj9VEB/9TWiCqUU+FkOzroBO1tdLT8sMXe
         Nr1NTwePJ6L8QbueNIVx73is9waW/AM4duOUe+l1L+NFfPShFwjPE+4jIc8Av2hlkRHd
         B6wrOHskrO+V/KCuaqtRqLHT3BqA9RmwxXdLNYXU5WjeFh3njfIKdH2Bv4Q/754yf0Mf
         Mr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763249689; x=1763854489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VyQXl7tWXRV/YETkSwjN2Plb4i1qeg0xlo6fhXkHNVA=;
        b=Nv0uXtlAdeb9sckyCqq348/fiXf1iMBY7hCrloimnVxyPLf2rdvRa84/4epDrK5G97
         Z9q27GGph34jfJztIH9/sIDtFW6J4p58YQt+HSqwWEGdYYJsvx+Lw9TwRRAeOTfGWWUA
         nAruck5WXpNkkBqmKVt99H/Nugx2Mn9t7qKAJ0poUkMw2E7TWnyFzNsbXJGYdnElzEg6
         BtwkahHO0v46UiMcqntwThLWw4PU6RjKlS8QJ/FKX2iZGCovoMmvqt+U1ufngUPdS0DS
         +Toatova4mS061rGtLc7sSN86IVBuIRZtEl4ug7P99joy+oCvEQWmth2pYaKdZeUuz2W
         CiNA==
X-Forwarded-Encrypted: i=1; AJvYcCWchNPFIJ/XaD2gIEsANFzAXCaqVDq3azrz163VudSYQKXmTxRTIOQ9zhLYUoiKwyXS29uxitm8ciwtieUs@vger.kernel.org
X-Gm-Message-State: AOJu0YzD04mK0ThSgjF2PCTSDE+nxI2H2AFMwxYThxm6lBz725p1G0LP
	6SPupataFyLoacSuBrDPR6WCDE9zjmrvapi0YGHDjXsFgE82q2foIw7GxUeukNuPN80=
X-Gm-Gg: ASbGncsAaKIgv6Ee5SKVCt5Tppo5i+NMMSK1jlho6uxtZbsto5yi838uGiWu7S7zrdm
	rW8ehtpPLSmxxqYhFFPaPKjvk5JAeU2SSOROJbkGzA6HHUDHuaGGm74kr80kTR3MiQ0yWSAbMXR
	oXHs+hoGrAiSwnbEeEiXEcsD/RlNrvHVt/+eV0l3s68auL3SECGGmHMBuQnY87w9ZHMexkozndJ
	98bMOwQzyWIfGGK9YcGMRY4OyZOXOBRtd3jHrhraa9n3ECh0OJ35IwhqGsEp23v5BxF+svb7Fy0
	pMjxDoBPa1XBVs77Ed26wvxfoKZ4y8fvckhrQN8Z/sTXvjPyxnxGtSIEeSb+ndhDzS/hX69SnOt
	TL3sBeM/77BLsmy3kLr/WUFRlB0YBKOtcOAnTI/MQZu26xTGisgZwOhOJYhSS4dkxePdFwRkzpP
	VA+a5iCNRoviUbCQwYTuqS92AbQqO02LcFlJgJcuESTQbClpkeophQrZAriTmUKCBWCZMo
X-Google-Smtp-Source: AGHT+IEy3rWCZZa0SeOLBQxT1yFnRWPZjFkRUtPU+kVtuy5howb5ZMUGXRB8KQbRbOWcLX2jr1XF1w==
X-Received: by 2002:a05:690c:a003:b0:788:161c:722e with SMTP id 00721157ae682-78929e81770mr63042867b3.26.1763249689113;
        Sat, 15 Nov 2025 15:34:49 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882218774esm28462007b3.57.2025.11.15.15.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 15:34:48 -0800 (PST)
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
Subject: [PATCH v6 14/20] liveupdate: luo_file: add private argument to store runtime state
Date: Sat, 15 Nov 2025 18:34:00 -0500
Message-ID: <20251115233409.768044-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251115233409.768044-1-pasha.tatashin@soleen.com>
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <pratyush@kernel.org>

Currently file handlers only get the serialized_data field to store
their state. This field has a pointer to the serialized state of the
file, and it becomes a part of LUO file's serialized state.

File handlers can also need some runtime state to track information that
shouldn't make it in the serialized data.

One such example is a vmalloc pointer. While kho_preserve_vmalloc()
preserves the memory backing a vmalloc allocation, it does not store the
original vmap pointer, since that has no use being passed to the next
kernel. The pointer is needed to free the memory in case the file is
unpreserved.

Provide a private field in struct luo_file and pass it to all the
callbacks. The field's can be set by preserve, and must be freed by
unpreserve.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/liveupdate.h   | 5 +++++
 kernel/liveupdate/luo_file.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 36a831ae3ead..defc69a1985d 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -29,6 +29,10 @@ struct file;
  *                    this to the file being operated on.
  * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
  *                    this field.
+ * @private_data:     Private data for the file used to hold runtime state that
+ *                    is not preserved. Set by the handler's .preserve()
+ *                    callback, and must be freed in the handler's
+ *                    .unpreserve() callback.
  *
  * This structure bundles all parameters for the file operation callbacks.
  * The 'data' and 'file' fields are used for both input and output.
@@ -39,6 +43,7 @@ struct liveupdate_file_op_args {
 	bool retrieved;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 };
 
 /**
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 3d3bd84cb281..df337c9c4f21 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -126,6 +126,10 @@ static LIST_HEAD(luo_file_handler_list);
  *                 This handle is passed back to the handler's .freeze(),
  *                 .retrieve(), and .finish() callbacks, allowing it to track
  *                 and update its serialized state across phases.
+ * @private_data:  Pointer to the private data for the file used to hold runtime
+ *                 state that is not preserved. Set by the handler's .preserve()
+ *                 callback, and must be freed in the handler's .unpreserve()
+ *                 callback.
  * @retrieved:     A flag indicating whether a user/kernel in the new kernel has
  *                 successfully called retrieve() on this file. This prevents
  *                 multiple retrieval attempts.
@@ -152,6 +156,7 @@ struct luo_file {
 	struct liveupdate_file_handler *fh;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 	bool retrieved;
 	struct mutex mutex;
 	struct list_head list;
@@ -309,6 +314,7 @@ int luo_preserve_file(struct luo_session *session, u64 token, int fd)
 		goto exit_err;
 	} else {
 		luo_file->serialized_data = args.serialized_data;
+		luo_file->private_data = args.private_data;
 		list_add_tail(&luo_file->list, &session->files_list);
 		session->count++;
 	}
@@ -356,6 +362,7 @@ void luo_file_unpreserve_files(struct luo_session *session)
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
 
@@ -384,6 +391,7 @@ static int luo_file_freeze_one(struct luo_session *session,
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
@@ -405,6 +413,7 @@ static void luo_file_unfreeze_one(struct luo_session *session,
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
 	}
-- 
2.52.0.rc1.455.g30608eb744-goog


