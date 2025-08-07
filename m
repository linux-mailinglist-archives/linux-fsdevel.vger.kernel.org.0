Return-Path: <linux-fsdevel+bounces-56941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4EB1D072
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 03:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A65527A3BD9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 01:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98EC239594;
	Thu,  7 Aug 2025 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gF8WDCKl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA52A23185D
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531116; cv=none; b=CHTjgI+Dc2sd2kV6lxPUJBMi0maEtBqR8Fn72lB/FTtB0CSpUm0Rzbs8zZ0ddW9yt/ABKQXNUd6TXuS849GJ6hTBxR0AfB8fY8RKbgt0aEW+IqjG/aBb+vnrZlHBJXq2ZVd+Vtzm22i0jWbYMmwIRlCoELNjm93Wcl0CgBKNgaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531116; c=relaxed/simple;
	bh=6IaJ4oC3HjSKXEwPPmdg9sH4w864pWwsUqoUlC5zX5s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grY4owH3lXnMLTP7tS4eJgkWv7wwogmYSArG9ygeIYfAeG3x5sVJ5uFqUkNmxzW9V4BxHELvWhHT7L/9F/AHXXyTRUmnk1duLm/YbaK8GKqDBzlR4c89wGUAyE3JXSbLMVVLll3XvDQExl1xPJ7Rapm5SUuGWTj4v80Cg+l/P5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gF8WDCKl; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0784e3153so8855261cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531112; x=1755135912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k1U17r+PzRIJkOEWEh69D1nNoyfvJ+I2xTfX4gnP+M=;
        b=gF8WDCKl7lSirbpvxjc3A32RPgzd74XttEyW4Jsd9Z6qD9CFDGpLG0/QILyXXGq6vT
         VNiyCx4dGT1VKH/hnutlzijUDovc7kjUOthswMqgzUg1ye+DZ9jMuMRg7DCDA2CTqT36
         cqA1XAcrRYZQQP5shvw6qmosaZrxu3hSUJ61vheEB1frWbRQe6P1R1THj6RnxhCYd66A
         TXgv255p0lm0iYpnnkQFZawB3cQ7QI+W2N5gQdE0oZ0phIA4xiZYLXMr0rvTH9shEj83
         HIR5EtNMEaKq4fn5+hGPW0phYNTQd8bTCRTPCrSm4Y26aOQAFJYt0DjVae44Yr0gYQsg
         AgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531112; x=1755135912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5k1U17r+PzRIJkOEWEh69D1nNoyfvJ+I2xTfX4gnP+M=;
        b=aTUbAP5LD4TDtwBgCPMdrhaGcg+Ov1pOhuki6Fb8O7jUJfntznbee0NwoD7mKcGQRR
         w3W4epdGa65DtUwpQohetnluI9Bn3HaNpQykekBF/t9R3TH5kV7SCvUa5eYoUupE9z5j
         ktqw6hmS8LfRUoRtGhbHhdHrVM5sZYMeXg3v+CKrHDrhSFT6US6Qml8LCZ5zUTQscAB9
         +iSiixNPZMAdG+PzV6gdrMZqzy7yPb5p0k+GMcLIF5qTiCQBfYIu4vS0HVzVvNoi2/OD
         l0+5zXDMA7aW6r3teoNrZKeEWYzvNCoI8i6/CftSdeSXLv17embmZTgfaCZVKNTjf9EW
         CusQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbABQ/vcKWcMztj42gA+q1nOL1vbzdEaCgYqsd1pSFcprW3idK0Y/xxc0r0glVKCvnLXdJG4/8opC7PSOM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0EPlQofbb59sgzTKc7ZLEUnn5ergMDidqegp32W5P0xt4WCY
	JT5jKN+u7JC6JtqBXAqs5YUa/8oTR0VXvy9WyPyll9rkQLJFz0gBJHU5iwbrxaTPChk=
X-Gm-Gg: ASbGncty7ib9W8LB9k1Q6CotTk961yBQInPR8nBRvRwGt9BDgMHmzfCbDukKel+OfV/
	EOW6ef4Irr50OkUKjZiRGZh5XdfSygwfTI7eeVieonhoweYTD5pbuteWfqToTpl+1tTiVBnoksy
	Q4qiJOO9B2nFwydrdAvebJwvhJeUqS1DwAhRIxLgEKUesCIL2APShQiUje1jQap9OlJl2rKSlA/
	iwoonhWtJ0b8jSUguN9noU/2F4jwZZ0fz6Q4Q0YziRG+mxc//Tyxmm5DLq2e+TS9YpXjIZiPRHc
	JhjvvkQJ66cD+f2ZYqDPoGMgSFtTaD0l4eVVf3va++EtrLkwwiur4Z9hcmlnqGV2r35XaiR3glf
	j53hur8nlSJCDZEh8UzLMr/zR2kaQ8YZC7t/tfDcz721Bth5y4Zz4DgKQ8IWIlcWn9L6dWA8hGh
	mwZfAODngoudlPf2ymXupCSFo=
X-Google-Smtp-Source: AGHT+IFGhloL5+wAzqGLxdMTz2N8jTfQVk0LrudTV42eJiPSBl97ww3SO5T1gQQT1i9NRyGQ/H+ydQ==
X-Received: by 2002:a05:622a:10d:b0:4b0:7e72:9f05 with SMTP id d75a77b69052e-4b09157a420mr93793331cf.29.1754531112392;
        Wed, 06 Aug 2025 18:45:12 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:11 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	witu@nvidia.com
Subject: [PATCH v3 17/30] liveupdate: luo_files: luo_ioctl: Unregister all FDs on device close
Date: Thu,  7 Aug 2025 01:44:23 +0000
Message-ID: <20250807014442.3829950-18-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a file descriptor registered for preservation via the remains
globally registered with LUO until it is explicitly unregistered. This
creates a potential for resource leaks into the next kernel if the
userspace agent crashes or exits without proper cleanup before a live
update is fully initiated.

This patch ties the lifetime of FD preservation requests to the lifetime
of the open file descriptor for /dev/liveupdate, creating an implicit
"session".

When the /dev/liveupdate file descriptor is closed (either explicitly
via close() or implicitly on process exit/crash), the .release
handler, luo_release(), is now called. This handler invokes the new
function luo_unregister_all_files(), which iterates through all FDs
that were preserved through that session and unregisters them.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_files.c    | 19 +++++++++++++++++++
 kernel/liveupdate/luo_internal.h |  1 +
 kernel/liveupdate/luo_ioctl.c    |  1 +
 3 files changed, 21 insertions(+)

diff --git a/kernel/liveupdate/luo_files.c b/kernel/liveupdate/luo_files.c
index 33577c9e9a64..63f8b086b785 100644
--- a/kernel/liveupdate/luo_files.c
+++ b/kernel/liveupdate/luo_files.c
@@ -721,6 +721,25 @@ int luo_unregister_file(u64 token)
 	return ret;
 }
 
+/**
+ * luo_unregister_all_files - Unpreserve all currently registered files.
+ *
+ * Iterates through all file descriptors currently registered for preservation
+ * and unregisters them, freeing all associated resources. This is typically
+ * called when LUO agent exits.
+ */
+void luo_unregister_all_files(void)
+{
+	struct luo_file *luo_file;
+	unsigned long token;
+
+	luo_state_read_enter();
+	xa_for_each(&luo_files_xa_out, token, luo_file)
+		__luo_unregister_file(token);
+	luo_state_read_exit();
+	WARN_ON_ONCE(atomic64_read(&luo_files_count) != 0);
+}
+
 /**
  * luo_retrieve_file - Find a registered file instance by its token.
  * @token: The unique token of the file instance to retrieve.
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 5692196fd425..189e032d7738 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -37,5 +37,6 @@ void luo_do_subsystems_cancel_calls(void);
 int luo_retrieve_file(u64 token, struct file **filep);
 int luo_register_file(u64 token, int fd);
 int luo_unregister_file(u64 token);
+void luo_unregister_all_files(void);
 
 #endif /* _LINUX_LUO_INTERNAL_H */
diff --git a/kernel/liveupdate/luo_ioctl.c b/kernel/liveupdate/luo_ioctl.c
index 6f61569c94e8..7ca33d1c868f 100644
--- a/kernel/liveupdate/luo_ioctl.c
+++ b/kernel/liveupdate/luo_ioctl.c
@@ -137,6 +137,7 @@ static int luo_open(struct inode *inodep, struct file *filep)
 
 static int luo_release(struct inode *inodep, struct file *filep)
 {
+	luo_unregister_all_files();
 	atomic_set(&luo_device_in_use, 0);
 
 	return 0;
-- 
2.50.1.565.gc32cd1483b-goog


