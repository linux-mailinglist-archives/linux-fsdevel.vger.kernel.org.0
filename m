Return-Path: <linux-fsdevel+bounces-12134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D2A85B764
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15010B232AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A382605A5;
	Tue, 20 Feb 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hVNiM5T3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DA5FDD3
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421278; cv=none; b=EzuqNQvVNVyrpHFc0MFGfBQoXlzH+Vp68jRVbDVDVMJmV/XaSBHLM+zeQ3I4sjr14tSSbmh7NjDFHlvBlz0cNpbpUCgoNrXuV1d8Cbt3A/42FKQ1I6U6eCTVH2YlkbnOj9vOqjbEgeLHBHb5SoiJYBgV4feXOTimynvw/IYUs4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421278; c=relaxed/simple;
	bh=OZioy8AfLsmSlw0w0r3twrLcp1c+FgadOLiPu1XclVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxZZ33MWjGWhOBMBsPNi2sv0sSX20GXSAapgU/lYVI2K9m3UgZ80zDHpgnDcRJtBGBfqNNQwXo3lr+RAXxj7Xp3K24xatn8f5AU1zrD4oilalP9OgUd6CjlB4UA7Ide4bR0xVLC2+VbL/MaNHX3HDZfLa503FeI3fqqg+vymaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hVNiM5T3; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so5354541a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421274; x=1709026074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXZ+DN3CcnefV4u4W5SMOCurbndJVv4wj08ijEsPqwU=;
        b=hVNiM5T3tLpYBBtr1KxqFFMwK/ZwjrMR9qQdzLR4N30JahneU+1pE/JmpVSKADItr7
         9bUksLderTjak8+ldH8OQfhWVct35aDklE1j2HgvHR4XsvBNA3EusxAmn/vjtQrE02Xt
         3j/bwzQBcY5skH07yrvBRKEveE5UnEpc1zX9laQSjeVZXz+iyGKjKRUv/KJJcIAPcZQj
         a30j3H3O3u3q8GQ/J2UNDphfZHw8bSSlWxYM+iVKEFdBdloEJjD6sk3Aa6ZLshmKG5xL
         m26jltMOkP39eqMGiyIZF4zpnBlFXNVprxWBgDwUGteHhS2w2ue0A69uvM4/igxW+dkP
         DHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421274; x=1709026074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXZ+DN3CcnefV4u4W5SMOCurbndJVv4wj08ijEsPqwU=;
        b=Vk7+lVO01Sms3DmFkyJymOFyJNx+mLGKMppV6aIRMv3NrmBVDzdN8Np7zZDMk2061f
         hEyjcmsr2jrmi/ZXc7OeKgjN/YusslEHOs2bztna9Oe3zrk9dDSqgzZnx8kTzgPjMuL5
         pymxVkamjCv7NqEf++8w8xlvwuvICwmpVdSN8A6z1ul4wnAMakGFIGYNsYT06cy3fL96
         WrZ2PvaLLmTsYR5XSid6Bf06Wa5jGBadxohbmfJ+RFh6fBU5yrw45FvgaCuDJmXDKi7r
         MvKbZwPHlsBqHz1HOZrGP0tJEW44yRGmMobuBg8GohnKMv65QycN+WbgCAw3l5PncdW6
         tdrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiGt+eIpm1eM80vMWZt8aoCiyeDu73+1lfEao8IbwYSx6wou6Aitxm6Z6+LX76Qp6WgvR4B9Ppi18qqJhiOPwj1TeKhpdG+JypIQvdEQ==
X-Gm-Message-State: AOJu0Yw0Pe5WTK4zGeQ8qME1Q02Co1VrHQJ7sAEXHPqZ0uNMRAHMuivX
	BtblKtmLQHszZ1hdIhvEbrYl0spKom+p7R/Ugcf7GYG86Lrc6cOYeFiO5evb1Q==
X-Google-Smtp-Source: AGHT+IHkFYDXFwT6cS1Y6ESD1QzbPdMU6iw9dKRUM8cEUuLz0d+G3e4wiXXNVR3TuLLPAbfiZ6GnYg==
X-Received: by 2002:a05:6402:40c4:b0:563:b7b4:a30e with SMTP id z4-20020a05640240c400b00563b7b4a30emr11299389edb.3.1708421274505;
        Tue, 20 Feb 2024 01:27:54 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id b2-20020aa7dc02000000b00564cb5a3c7esm338161edu.81.2024.02.20.01.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:54 -0800 (PST)
Date: Tue, 20 Feb 2024 09:27:50 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 04/11] bpf: add new acquire/release BPF kfuncs for
 mm_struct
Message-ID: <ac8e4dfb7c3438b488ca0478612e584800ee35de.1708377880.git.mattbobrowski@google.com>
References: <cover.1708377880.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708377880.git.mattbobrowski@google.com>

A BPF LSM program at times will introspect a mm_struct that is
associated with a task_struct. In order to perform this reliably, we
need introduce a new set of BPF kfuncs that have the ability to
acquire and release references on a mm_struct.

The following BPF kfuncs have been added in order to support this
capability:

struct mm_struct *bpf_task_mm_grab(struct task_struct *task);
void bpf_mm_drop(struct mm_struct *mm);

These newly added mm_struct based BPF kfuncs are simple wrappers
around the mmgrab() and mmdrop() in-kernel helpers. Both mmgrab() and
mmdrop() are used in favour of their somewhat similar counterparts
mmget() and mmput() as they're considered to be the more lightweight
variants in comparison i.e. they don't pin the associated address
space.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index c45c8d42316c..d1d29452dd0c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1472,10 +1472,53 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 	return __vfs_getxattr(dentry, dentry->d_inode, name__str, value, value_len);
 }
 
+/**
+ * bpf_task_mm_grab - get a reference on the mm_struct associated with the
+ * 		      supplied task_struct
+ * @task: task_struct of which the mm_struct is to be referenced
+ *
+ * Grab a reference on the mm_struct associated with the supplied *task*. This
+ * kfunc will return NULL for threads that do not possess a valid mm_struct, for
+ * example those that are flagged as PF_KTHREAD. A reference on a mm_struct
+ * pointer acquired by this kfunc must be released using bpf_mm_drop().
+ *
+ * This helper only pins the underlying mm_struct and not necessarily the
+ * address space that is associated with the referenced mm_struct that is
+ * returned from this kfunc. This kfunc internally calls mmgrab().
+ *
+ * Return: A referenced pointer to the mm_struct associated with the supplied
+ * 	   *task*, or NULL.
+ */
+__bpf_kfunc struct mm_struct *bpf_task_mm_grab(struct task_struct *task)
+{
+	struct mm_struct *mm;
+
+	task_lock(task);
+	mm = task->mm;
+	if (likely(mm))
+		mmgrab(mm);
+	task_unlock(task);
+
+	return mm;
+}
+
+/**
+ * bpf_mm_drop - put the reference on the supplied mm_struct
+ * @mm: mm_struct of which to put the reference on
+ *
+ * Put the reference on the supplied *mm*. This kfunc internally calls mmdrop().
+ */
+__bpf_kfunc void bpf_mm_drop(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_mm_grab, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_mm_drop, KF_RELEASE);
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

