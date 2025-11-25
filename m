Return-Path: <linux-fsdevel+bounces-69819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2563C8618D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CAC5351F15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B230331205;
	Tue, 25 Nov 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RZN45G2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F16C33032D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089975; cv=none; b=g5jJdmxp8traP1i393evcHvUuf6VrBBYCDr+EnarZWTL/I9xO/G20a8vblg2HWCYLfOhvmIo74CwR3ZSene17XH0WoPfjySHLJPoexPNKTBJRzrFzucnG5nB4883iuN683Ez26DKhro7bMh+bjPsmKF9zke7olluBhZERQ4SaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089975; c=relaxed/simple;
	bh=Cgp78p6MJr5ikWgAbD441bmUNWaMvB9QxQCFESAbYw0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/BLN67zJl9LeW61X/3J8lFI7GrUKR2A4/SmNJoV7cSSVfNoaiIkn2HY4kFCTfysd0M7RL5sJfPjB/XAUbqv3vXfV6rJaqmaYtiCqwQzp3ZNpFQWh3IogC5Ph8g14xYxRGUXmipTislG+rKRXAAeUpOORtcE+llri4mfIQbAdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RZN45G2w; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-786943affbaso41182687b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089972; x=1764694772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yx9quZG9gLF2dl0IKuMBsHxvDi//DiVhoRUqED9zxDI=;
        b=RZN45G2wbDuSV0HRp6JijJQd/3rGnFubrD45DMPC3tre2NkFVEESsBIeAFhFooL0MT
         o1ZVVNXOb47qOMZc+Exxpti8Ougo1j3zr1hgKEMP5fE/+ToSFLciJxk2z4OWuc1jt09B
         oZ4VDa7J1t71IiDxa7oDEVPLN+geY+ViV5IL49YQGlJ9FUVIATdKexbFn75GUSHK9Ct/
         91UGUM0Zqq3g7HG1TkhX1AuR8kiMwudG1DND+Au5tYlddVZYpkJdxdyZMG+uo0530UxL
         BBkekJaVLAr7A5jsJzkB/KoJ9JkBShDkuxmJOSW90kXWPO5h+g6Vu1+Ezmzeexclc8Zc
         CNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089972; x=1764694772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yx9quZG9gLF2dl0IKuMBsHxvDi//DiVhoRUqED9zxDI=;
        b=Erwdlara5gr3IHvCEEL8cIvsR3a9RqRqGxLc8+XI2UxUyPlOEvHAWpaSfuwX5KBd/x
         xT/mvoI7SKD3ChWU9/7HpUWi445D5tfIqBdUvSPDbwz4l5gizwnEnLGjblwMnQyuueKL
         SMm5vXaCLoXB5gswBV4usdhYAOlCBT7/qxtdE1fYp8BRhn1H4qjDIkKElPqYrpaJuTV0
         jRtw2goSJviUywvgI39ctV/3745N7Dia0EiPsHBA5O3jZIV54thF5DoqRbLazJ/aB+wI
         pKP6DFC1Z4jZXZ1+sQs4KpBAHxZAJR8noIOJ886RTqt4YNNXaBvg7tdFyqZbczm1hoFo
         Rgjg==
X-Forwarded-Encrypted: i=1; AJvYcCW/s6hdAHzgDoBIjeJjtQ/ZO9EyH6LMF9k//mEzYXF4OjIEQLzYLgNYyjNBbJ3sj0zkxQY/gcFOL0vsMttl@vger.kernel.org
X-Gm-Message-State: AOJu0YztWiqI62qb8T8t439310bxUQx9WXhp3zmXrBR1CpdZj/kfJW0I
	1jwu6NImeCJcQ2L2d4d9ks2L6g5ny4WUq4mMfCN/X2OiCdeY6VgnOpuvg2eZPtO/2b4=
X-Gm-Gg: ASbGnct/Ch82BqUELetgceW6ztd3vzJEgTLCEF1PB5BW/cfNkowUqGnSKRnAUTcvfGV
	euPLBElS7ZSfpMLE1mBYkmSwYOsXiAZO0kpoQMIH9VkgZiHC5/iLzYPQ1EgKvJPrnytmXf8EsoJ
	9ILAvi9OGi7BWHA++gxLUngap2PwujeQ5MhM9mCxehSOIdgQsdyPjxKrZThlBAuBCjA5xQtAeLc
	4nrCTND9dqJPY2MuWL2xYAztfkgdd6fbLD1sbJRVOMifZmjVwrcRZ9aAOa3Gsnuo5NeVn2d2ee/
	HfAluGbIoRSjfEekhG5VBcvMtGpNLxpwbVYQM0UHSn3uDWTNfoxlue90OnlgcMZlfNoVOv8hZf3
	f5TwSFvxLUq+NSd7X80cASwm+BYJJvxVH6lZLUBL5VVgQ6KN28tsF5n13bjsorLjOWrUfSapmEg
	yGGoQV9/r7PjFvP8X0NdGoTS+O6UZSYeICSzBpeG95WBsQDWWfUXq4nmjiOk5Itzt9
X-Google-Smtp-Source: AGHT+IEW6KgCKYwZ7XEqOpbUcHlowFzPqPsBiqMYeBlVaw8DURiXeYQOxuH5IPmz+1TT/Eb1rS/paQ==
X-Received: by 2002:a05:690c:338f:b0:788:737:4830 with SMTP id 00721157ae682-78ab6fce723mr28091657b3.66.1764089972519;
        Tue, 25 Nov 2025 08:59:32 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:32 -0800 (PST)
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
Subject: [PATCH v8 13/18] liveupdate: luo_file: add private argument to store runtime state
Date: Tue, 25 Nov 2025 11:58:43 -0500
Message-ID: <20251125165850.3389713-14-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

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

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/liveupdate.h   | 5 +++++
 kernel/liveupdate/luo_file.c | 9 +++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 122ad8f16ff9..a7f6ee5b6771 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -27,6 +27,10 @@ struct file;
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
@@ -36,6 +40,7 @@ struct liveupdate_file_op_args {
 	bool retrieved;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 };
 
 /**
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index e9727cb1275a..ddff87917b21 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -129,6 +129,10 @@ static LIST_HEAD(luo_file_handler_list);
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
@@ -155,6 +159,7 @@ struct luo_file {
 	struct liveupdate_file_handler *fh;
 	struct file *file;
 	u64 serialized_data;
+	void *private_data;
 	bool retrieved;
 	struct mutex mutex;
 	struct list_head list;
@@ -298,6 +303,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 		goto err_kfree;
 
 	luo_file->serialized_data = args.serialized_data;
+	luo_file->private_data = args.private_data;
 	list_add_tail(&luo_file->list, &file_set->files_list);
 	file_set->count++;
 
@@ -344,6 +350,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 
 		list_del(&luo_file->list);
@@ -370,6 +377,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
@@ -390,6 +398,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
 	}
-- 
2.52.0.460.gd25c4c69ec-goog


