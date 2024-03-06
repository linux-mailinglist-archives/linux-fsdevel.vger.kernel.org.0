Return-Path: <linux-fsdevel+bounces-13689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FFC872FE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D90B25EB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 07:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E3A5CDDC;
	Wed,  6 Mar 2024 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kNsxmjIx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236EF5CDC6
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710807; cv=none; b=jkkeNIz2lj4xA+4QIoQxk8+IWtGXmvx9igyrUeCXz5qcU8rcNcF9DNr6JYmAEOzsjeWIfTbjLGQ5PigNoJemI2BYMV1cI/ZocpP+647cIi+NQ/BGmjVuLOpqglMq8t42TU4zVsGpd6Cp4irfhKmhNz/zT+qZZgjLOMwrJo/76rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710807; c=relaxed/simple;
	bh=jq60zMaSYvap6aAng0em1/G5L7a9DGNMvLjFXCU8hFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP3WmNt75GYBy0F4wGQ3u5HSBkkWtmdpueTaZ8fyIwLGpQWARaza/Mc3aD0oEzF2ytRGorg/LFwSbs6/lDymSgBiVB7e/U89FB+iiSep8mU8VGwn9DNZpkR1PZdhelt+C3Q5bCHqHasJRYVigY0ht1NGAR0bAX7g1SL/qHLLvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kNsxmjIx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso94223266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 23:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710804; x=1710315604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl6HqlXoH1hydmZl0rJB+QoZZFFcJVSr7o6LR8kaTiY=;
        b=kNsxmjIxX2ZkCluWMUeh/p9pPheAYrBy1i9LubydwTvMQosDHOmNhVOnRer0wqDO3x
         BlFxIz1rCJgYH4xehHGrALP824oiuQVVnwFE4ySQQVCX6EaVP0a3XScdn2WGZUHpJJWj
         zx4DxBcNxVY7SQKh0PhHJPGKcgVpNbDioc1XWOTX45aS30T+dB1D1uhZZffXxdNSc3vn
         FnGyNQUNqfl2ft8K9oRkDjrxbWlphISNsM20kRHnAtgVTQTEgZ6ytjxOYb/Q5hMUk7OA
         Acvx0ZyhMvUH4E5fBkb4UCnglB9Tc774xUKPIFVkCgxkYnW/qag41LPr8mGrEqlGMZdk
         tPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710804; x=1710315604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wl6HqlXoH1hydmZl0rJB+QoZZFFcJVSr7o6LR8kaTiY=;
        b=UK9IaKe2/r6KtVSPOwQ6bS05LU30bCzCpDslnGd8F17+ONT5jqZwLUS251ARE2r3xn
         SUmUoGx1f8wEVDytGmoLB1RUUblgGR5CIfnLdZLRZ5nfXzPHCEL451+BFzZ3fCtraFWQ
         MlI1LGEXMtjTvDsblIN17nwDl+PNXepEREKeYDVS0gk3s/9ZuP+0RBOnpI4x1K3GmU4I
         R+xjFlghrizxZ90gUG0rkV7Onu3y5WZA7U2eglv7HHUCCO5pjFIT5YkSh4znaoXvAcVc
         OMvgyQE5oaJPvrLXzA2BhBPXhD73s9doso/kjnAHSACSwF8gIMs3K/piAwiu2WLeKFZx
         A/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkif5a+m9SB+n8IdHLBa5K8/2EmdhOytR6yp4X5vFZi8xDdbWTLJVFS+zrGELy8WwVJhcNSkCizjerCLI79w+9AgOJcUoei3zQfjPt0w==
X-Gm-Message-State: AOJu0YzQL70FoncF/16IfzQ6Py8vTayR7xmdBaNUxRi+sPBWcDNIz/IW
	6CQ4vincVTsh4Q6q22iySmZt3IMtvZvIAxxNu3uX3Jnw9alhn6VDQFO60u4lMw==
X-Google-Smtp-Source: AGHT+IE7EqIFnAfKo/zl9xpP/NOjjZB5tY1XzeNM14K5O13PxAr4oa3MO7A59bxR5uAUg0vqJWfa8g==
X-Received: by 2002:a17:906:b85a:b0:a43:fd2c:663b with SMTP id ga26-20020a170906b85a00b00a43fd2c663bmr4938275ejb.33.1709710804538;
        Tue, 05 Mar 2024 23:40:04 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id gq13-20020a170906e24d00b00a45621ded4bsm2851865ejb.146.2024.03.05.23.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:40:04 -0800 (PST)
Date: Wed, 6 Mar 2024 07:40:00 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 4/9] bpf: add new acquire/release based BPF
 kfuncs for exe_file
Message-ID: <6a5d425e52eb4d8f7539e841494eac36688ab0da.1709675979.git.mattbobrowski@google.com>
References: <cover.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709675979.git.mattbobrowski@google.com>

It is rather common for BPF LSM program types to perform the struct
walk current->mm->exe_file and subsequently operate on fields of the
backing file. At times, some of these operations involve passing a
exe_file's field on to BPF helpers and such
i.e. bpf_d_path(&current->mm->exe_file->f_path). However, doing so
isn't necessarily always reliable as the backing file that exe_file is
pointing to may be in the midst of being torn down and handing
anything contained within this file to BPF helpers and such can lead
to memory corruption issues [0].

To alleviate possibly operating on semi-torn down instances of
current->mm->exe_file we introduce a set of BPF kfuncs that posses
KF_ACQUIRE/KF_RELEASE based semantics. Such BPF kfuncs will allow BPF
LSM program types to reliably get/put a reference on a
current->mm->exe_file.

The following new BPF kfuncs have been added:

struct file *bpf_get_task_exe_file(struct task_struct *task);
struct file *bpf_get_mm_exe_file(struct mm_struct *mm);
void bpf_put_file(struct file *f);

Internally, these new BPF kfuncs simply call the preexisting in-kernel
functions get_task_exe_file(), get_mm_exe_file(), and fput()
accordingly. From a technical standpoint, there's absolutely no need
to re-implement such helpers just for BPF as they're currently scoped
to BPF LSM program types.

Note that we explicitly do not explicitly rely on the use of very low
level in-kernel functions like get_file_rcu() and get_file_active() to
acquire a reference on current->mm->exe_file and such. This is super
subtle code and we probably want to avoid exposing any such subtleties
to BPF in the form of BPF kfuncs. Additionally, the usage of a double
pointer i.e. struct file **, isn't something that the BPF verifier
currently recognizes nor has any intention to recognize for the
foreseeable future.

[0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 56 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 801808b6efb0..539c58db74d7 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1518,12 +1518,68 @@ __bpf_kfunc void bpf_mm_drop(struct mm_struct *mm)
 	mmdrop(mm);
 }
 
+/**
+ * bpf_get_task_exe_file - get a reference on the exe_file associated with the
+ * 	       		   mm_struct that is nested within the supplied
+ * 	       		   task_struct
+ * @task: task_struct of which the nested mm_struct's exe_file is to be
+ * referenced
+ *
+ * Get a reference on the exe_file that is associated with the mm_struct nested
+ * within the supplied *task*. A reference on a file pointer acquired by this
+ * kfunc must be released using bpf_put_file(). Internally, this kfunc leans on
+ * get_task_exe_file(), such that calling bpf_get_task_exe_file() would be
+ * analogous to calling get_task_exe_file() outside of BPF program context.
+ *
+ * Return: A referenced pointer to the exe_file associated with the mm_struct
+ * nested in the supplied *task*, or NULL.
+ */
+__bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
+{
+	return get_task_exe_file(task);
+}
+
+/**
+ * bpf_get_mm_exe_file - get a reference on the exe_file for the supplied
+ * 			 mm_struct.
+ * @mm: mm_struct of which the exe_file to get a reference on
+ *
+ * Get a reference on the exe_file associated with the supplied *mm*. A
+ * reference on a file pointer acquired by this kfunc must be released using
+ * bpf_put_file(). Internally, this kfunc leans on get_mm_exe_file(), such that
+ * calling bpf_get_mm_exe_file() would be analogous to calling get_mm_exe_file()
+ * outside of BPF program context.
+ *
+ * Return: A referenced file pointer to the exe_file for the supplied *mm*, or
+ * NULL.
+ */
+__bpf_kfunc struct file *bpf_get_mm_exe_file(struct mm_struct *mm)
+{
+	return get_mm_exe_file(mm);
+}
+
+/**
+ * bpf_put_file - put a reference on the supplied file
+ * @f: file of which to put a reference on
+ *
+ * Put a reference on the supplied *f*.
+ */
+__bpf_kfunc void bpf_put_file(struct file *f)
+{
+	fput(f);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_task_mm_grab, KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL);
 BTF_ID_FLAGS(func, bpf_mm_drop, KF_RELEASE);
+BTF_ID_FLAGS(func, bpf_get_task_exe_file,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_mm_exe_file,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.278.ge034bb2e1d-goog

/M

