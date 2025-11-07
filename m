Return-Path: <linux-fsdevel+bounces-67492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B10C41BB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 22:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBD464F4433
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 21:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F57345750;
	Fri,  7 Nov 2025 21:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dkaNzuWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C1F34320C
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762549566; cv=none; b=pA0/eJ/hB7fWsnge0CjOBPkwLwmeqXKyX5vcPxW53km5KYubZ8KQ6h1mUYq59N5lfmlb9b6Wv3eVF3aQc9MDiCxDrNg8EkE+pnshZb0BATuRvn4lcc+GcAydRmPIVKX8W03v8bOrjXlXlyMgTM0vlGcXr0LVGx4Uh7yH3O8QzLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762549566; c=relaxed/simple;
	bh=gBYU5h2sGDvuxmfL4Z2QJsnaixb4prWMGY/kIMgQSKs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuDDL5b+iiLUCFpW6Tw2dLWjM999JECR5XjdIn2sBDcJN/pPh5+WJAoKebYvCvtApqa/BFSyrcC5qXkk0gFDXqCm6p2W/92e580DBIXt0I09+j6uBdjZvmPcWzea21hgM6VLzGWCy4cWeV9UOhva3i+u7ewiwhZpT4bxiID3iFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=dkaNzuWR; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e393c4a8aso1016009d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762549563; x=1763154363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kO0F0lPOuqRuP1r+X7yx5ua65c5v8nyw+1ERu/tsRgQ=;
        b=dkaNzuWRbi2KA9O7G1cE8o4AlQpH8KyXcDKyriGVvGSJCChqK3r/tMNiz3wfnpqhGC
         86RV5evUXkXBgigC22waRO3uHc1gZ5xqxfv4G4Mh8XUSJgcD5hGR0GHzwv9UmkbVJjcl
         SBsyLpnZHmm/gp6jFd6QeKgPnUKgYTKirT1kNyzt9nS4mEGnI+6szZgJl1Y/54dKl0gO
         Sb/GAoPWrcIx/p94TaUGnLVYf+D6DgcEe/Eim2rtzeyaJCoWUzBx2BJUrk2OAkmU15Qc
         6p42DZWzG5Ls6mcMhIFNqc7BwPJNOWci+dQZOIKPUDlbWN5TjTnwytGvJE1wBnvzou3U
         bsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762549563; x=1763154363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kO0F0lPOuqRuP1r+X7yx5ua65c5v8nyw+1ERu/tsRgQ=;
        b=LSjxKmL/tgvOtIeunstItJ/xqoJuozo1UibuQWoOn8EgIRGNxFQL7JLYlCSAfM+VJB
         AvF3sNM4skH/sgyO3as3RL3DZn8zYbRLkTfOktT/mODtLINTUwb9x/2Qsh5uweUt3HK3
         h2/3xv1VvZ9YfJ9mh60qt7TxN/X4uqwTsQ4GIe/DRoSitTRMp8ORjKdef6qb2kCsyiwY
         3jjm/uqZ5e0wPZte9ICKM/1tvcRoN+1ySllQo6UXWB5LrdVJDp+zRwLPrVxHkedDx184
         tsMuMKOCRgtOVauGRthyiBzdgjMEwGvbJa4Ew2TaX3zrFcjYPVPejsmDPg7EBGV1Ezk5
         500Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAfbDnFIGmzJdjNztKAzZIlfvZDGyJi5Yia6kXe3x557BNwIGL9//SYCdAYnmR2Y/IUsWB/PT96A6PVnb4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs6YfcN6U1CMD7ly+1CehkcrI371I/eZxMkdnL/GG/CcIlL8F9
	s+yMRIfGmzA4MS8BzWeOrzRRTyOa8OG+AWNjx2QQdRAIV+U91fXP4NmElatWCfdT9nA=
X-Gm-Gg: ASbGnctNA+xXfUCXYSBsodX6vSNGKnFaVK3aVZTahj7/i2BMnk/L3H2YaIyzywYvxA1
	2IO8QceL4MDEgv3J1e6avoywlH4KlaBrf1yUGEjzXHuFt88GVBnQrzBI0GJInIIyMVyMYLO/UT2
	FbqhLntaYFljLNbqfZCoHiz1sePz+NR/erb1bJrMMufSvmP4+x0AiU3QnWar6aa9/5ByeF2MQAF
	mt1WothX9JkoyJcMLxDikL6YNTczu3lstyHqiwquX0cJiWSkzzJwyqunU8aGWbkUw1KC43PTww9
	/VBSL4lgNNk4snQ5thaK+IT9qHZ1CSnN1lXJC31zWz9IFiGF+9+4u0YWp4yH66lp511brqv4hm3
	dlJqxqXpAq1bTtlAuixo57eAXJl4QaNtcoxs4dgBEjPeJPdV7lvFBwtgEO3tggv0VnWRWlfXF4u
	+Cok4I0MtaXmUrMtE63XE49PWW8+9cE65KnTFGieRcNPp8WQhIjUTR1am0I+cFg6k=
X-Google-Smtp-Source: AGHT+IGUrCGSnQ3TU6q4/qNhItgcbFdsWINOhF2gqc7ZvS0Ysq3WXcStnQvjg9cKvk8ErPoxGLBe8w==
X-Received: by 2002:a53:d005:0:b0:63e:10f1:28d9 with SMTP id 956f58d0204a3-640d45ce885mr343426d50.57.1762549563137;
        Fri, 07 Nov 2025 13:06:03 -0800 (PST)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d68754d3sm990817b3.26.2025.11.07.13.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 13:06:02 -0800 (PST)
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
	zhangguopeng@kylinos.cn,
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
Subject: [PATCH v5 16/22] liveupdate: luo_file: add private argument to store runtime state
Date: Fri,  7 Nov 2025 16:03:14 -0500
Message-ID: <20251107210526.257742-17-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251107210526.257742-1-pasha.tatashin@soleen.com>
References: <20251107210526.257742-1-pasha.tatashin@soleen.com>
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
index ce39b77c89c3..3f55447d18ab 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -29,6 +29,10 @@ struct file;
  *                    this to the file being operated on.
  * @serialized_data:  The opaque u64 handle, preserve/prepare/freeze may update
  *                    this field.
+ * @private_data:     Private data for the file used to hold runtime state that
+ *                    is not preserved. Set by the handler's .preserve()
+ *                    callback, and must be freed in the handlers's
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
index 7816c418a595..713069b96278 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -125,6 +125,10 @@ static LIST_HEAD(luo_file_handler_list);
  *                 This handle is passed back to the handler's .freeze(),
  *                 .retrieve(), and .finish() callbacks, allowing it to track
  *                 and update its serialized state across phases.
+ * @private_data:  Pointer to the private data for the file used to hold runtime
+ *                 state that is not preserved. Set by the handler's .preserve()
+ *                 callback, and must be freed in the handlers's .unpreserve()
+ *                 callback.
  * @retrieved:     A flag indicating whether a user/kernel in the new kernel has
  *                 successfully called retrieve() on this file. This prevents
  *                 multiple retrieval attempts.
@@ -151,6 +155,7 @@ struct luo_file {
 	struct liveupdate_file_handler *fh;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 	bool retrieved;
 	struct mutex mutex;
 	struct list_head list;
@@ -307,6 +312,7 @@ int luo_preserve_file(struct luo_session *session, u64 token, int fd)
 		goto exit_err;
 	} else {
 		luo_file->serialized_data = args.serialized_data;
+		luo_file->private_data = args.private_data;
 		list_add_tail(&luo_file->list, &session->files_list);
 		session->count++;
 	}
@@ -354,6 +360,7 @@ void luo_file_unpreserve_files(struct luo_session *session)
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 		luo_flb_file_unpreserve(luo_file->fh);
 
@@ -382,6 +389,7 @@ static int luo_file_freeze_one(struct luo_session *session,
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
@@ -403,6 +411,7 @@ static void luo_file_unfreeze_one(struct luo_session *session,
 		args.session = (struct liveupdate_session *)session;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
 	}
-- 
2.51.2.1041.gc1ab5b90ca-goog


