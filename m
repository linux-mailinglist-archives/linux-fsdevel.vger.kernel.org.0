Return-Path: <linux-fsdevel+bounces-69495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEECC7D900
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7973C4E17BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DE52E266C;
	Sat, 22 Nov 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Oxq+Bbp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1112DFA2F
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850266; cv=none; b=mEjpX6oxLdJZeeAsBUZ4AuUPoR4yclxSVeNAejZAbUZG4HOoUuE+b0O1w6LX3RZ59KG9IezoD+PjgxMaNbe1bFxTg6xpzLfiHg8GmXrnFtcI7/AsoxdnCilWpppt9WmIwddWlPpD+kBrv8d3lP5emd/bXoCPUznT7cJX/7kntHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850266; c=relaxed/simple;
	bh=0xJF18qOKcU5eAzQ6HxIuG25uSo6cc+l5rprPtdnC7I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCfYkfmjo7GfVQclIEi4GZUpTUGOPNFiqZHrl6ARK4aeeM2iyW2usY7cXFqVLGchovvceQXsJuMH/Z4QLB+PvSC4AZFxAbky74/QXFbE2SFUqYhs5m/aLLiScHItykDew7tdRbNC0vFidTlLJtjygLb/Tm3xoIxEBflu+XMxxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Oxq+Bbp9; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78a7af9ff1dso30358077b3.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850262; x=1764455062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ff4h/Y+aeCaryuraEaQmIoWWBfglnwQ79bUWNkRIqMI=;
        b=Oxq+Bbp9KtTJ0U0fh7o05c45t48ymLL7K4Aetlz6ihYvYy652IqvuRL73imA8k/TfN
         yLmCsAbYBWd5fCVcrO4M5ed9fnVw99pJS59eIqUP+6BgCZ8qN6OMikeUr6m1k6iggx75
         zdWFSKQRUpWLO549NmoT0F0Tl/e/uvsiYMHADNtrArpb1qWmFQNRNAR1u/v88X1ULU1C
         yYbwrSF1kyq43xuq1EdFW2S29v/xXjkucAYYujW7nYPWu3RcvysIRrs6G+BCdv4l0iob
         XKet7YlHmvQI2jJtOFgZFYfkJqTSPwW0SvAOBkdbZhv4/lLGlNPur8yaZXTVFk0x/zkn
         QbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850262; x=1764455062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ff4h/Y+aeCaryuraEaQmIoWWBfglnwQ79bUWNkRIqMI=;
        b=CPDYHdSMvLYAJEkisrt4Kd7NU2vrB+opwVe4osyt/IpLGCaSwc9WXHd85ypfSOs/C0
         Yu0LdiaMTlX6c5lbokhnM51spZ+kf+EMfSdwe7lV7Pt0GwIvbM1Et6TdprpsIDQzuBkK
         bi1xPX0CxIiSgVpL+faim1E8nPQy8y+zVEqDdAvlcEzlRQ3ixPp3VU8CTH54I8VtuSuT
         T1OlOkvY3i9Iru7dI6ECIEmOFzDZCpO0Zk3XmknO2Yu0oGH/QPfWG9DPVx3kxCZDe75+
         0eVMdI6GB3E7N+/2yZEiwKXXknZSn0POugKGOXhVlcMu/fB1GDAruVVqeNXYM7Bz1Btp
         5uLA==
X-Forwarded-Encrypted: i=1; AJvYcCXx100hTIs6QrkaNpSa2A30uvEvM6mqeJtlCJQz7cUeG84uVhJJ6fduI5YBX6crcrpDuSgSI3v6xtBph16N@vger.kernel.org
X-Gm-Message-State: AOJu0YyoEImxoDyQseNCj/m+/4FaTHKepQcePbBhWkXYnt1IERUXeh7l
	WGVUMsQoaII1YNzM9Dj7yPSDjF1Ftkv+1YDyVSsaE2Vtcaj0bzoYGxw1hv6mtGl+kBQ=
X-Gm-Gg: ASbGncsOndBkk6bqIEyOH9yEoa3YdNih324sh/W0kD8sh+FZsUJVw9U7WeCQzrI+2vr
	+frmplNZOUF8VD/NCVpvoZYSio4HouFspQPJvO5bythISbKNG5rpFFKisSo0urXVcNEhBdy4wSF
	lXt2Lm6IBM/qApT7onrm06l43jF8LNQmUBs84VIIuOmVxAEKMbvc3+GMbHSSLXVahBbZe8og9sT
	Q+/KpgvqkJkUwY3wJ7hrwABUQ+lS+sm0Epn9VIW3dl90S8Hii+bcitVMAnHp7nV1LwgytDyvCi6
	AdP8yhReTgpilWUCmMIhmmPMyFhLfnZOw6OiiIqHg72AFDDnvziwEx4WIbJNBTCM2Pg3S5ph93u
	aNI3M4xvK/UQqfzSFwI/VQ/YA+vVUBpstv432XoGdfu8sLgOBCgn8WsiwDndbnTlcJit0iPSv1D
	doJorCOpPNy/oAGloZ7FoQwficibDKIxV06GD5ei79tWqXbeQJibavmQJfq2THXDjdnkwqNkCnw
	Asw7EY=
X-Google-Smtp-Source: AGHT+IEh/qsJ9xlDDV/YCr14e57USKSEfNEr00YTzpdoNrXFY7RlW6SCMXKos9LFs3pSvdRKqhUulg==
X-Received: by 2002:a05:690c:6282:b0:789:24a4:59dc with SMTP id 00721157ae682-78a8b54896emr60698047b3.70.1763850262632;
        Sat, 22 Nov 2025 14:24:22 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:22 -0800 (PST)
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
Subject: [PATCH v7 13/22] liveupdate: luo_file: add private argument to store runtime state
Date: Sat, 22 Nov 2025 17:23:40 -0500
Message-ID: <20251122222351.1059049-14-pasha.tatashin@soleen.com>
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
index f10d6c37328c..b235d1b562ad 100644
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
@@ -300,6 +305,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 		goto err_kfree;
 
 	luo_file->serialized_data = args.serialized_data;
+	luo_file->private_data = args.private_data;
 	list_add_tail(&luo_file->list, &file_set->files_list);
 	file_set->count++;
 
@@ -346,6 +352,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 		luo_file->fh->ops->unpreserve(&args);
 
 		list_del(&luo_file->list);
@@ -372,6 +379,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		err = luo_file->fh->ops->freeze(&args);
 		if (!err)
@@ -392,6 +400,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 		args.handler = luo_file->fh;
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
+		args.private_data = luo_file->private_data;
 
 		luo_file->fh->ops->unfreeze(&args);
 	}
-- 
2.52.0.rc2.455.g230fcf2819-goog


