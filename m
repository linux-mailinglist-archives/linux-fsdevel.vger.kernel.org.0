Return-Path: <linux-fsdevel+bounces-12136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2D785B76B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E62874F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9B60EF3;
	Tue, 20 Feb 2024 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KuFLbdM7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56235FDCC
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421291; cv=none; b=nPi1aN+lSZpN5BewTW46CRLlpevTFkIBbjwow7xwYabQmbRx6ByKQVqPatPBi5G0pVYsxSr5gGwZUywTZfS7TBVHrzMJTO0gH3blp6vPBQNPvX0FmK1ZMXzMNcjR9sNVEqM/7ZkTGsHtHvMGOsdL6hGUD7mMBRfKOO8fLEg2MEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421291; c=relaxed/simple;
	bh=m3Sucw8QzaWz8TlW7E5NBXxd2VvBAO6oCXEQxTpnqy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwFz0AYSYKqQ1btk4sSt2NP4bYAyd9vP4v65/vcpzzMAY1wJ2JaDIZq8/iRaURJrhOJtxu39hv9zrzulnZwHlRiKsud5OwuVHdAjavwNknKtexn9offwdJb6U15n3qBTJZHfjU1giZ9oqowxU7Fp4c+xbWv3dZ+z6bW8KqklK9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KuFLbdM7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3eafbcb1c5so183197866b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421288; x=1709026088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67zqLp2NujpZSzgMSsWNOorMz98+x6ajQiomKeMyjqI=;
        b=KuFLbdM7OB3YQcN2Zj8Z8NoEYHuwMpUlG2aQAHTVg5iTSOoN7FQcPwmrDUfbuL5oZ2
         PoaLtXL8LZ20pDPl6XaSWdefR1W9lr+KKxQ/k9D+wVP0QtpTkjYvj5SW2tqgJdJ0pH1b
         KK/RuHqXgUN+zUJB48A9fw/Se0NUhtHCyoFNXxGa2npNTP6e+X9AmWFGQfhZPDoMhz2H
         vqShghL+q1akr8i50eXlmzCYl3MUX6/E74VvXNdB2NEjuMdOKJIzw3Iw7QimbppMolUF
         ZAkrT8Jpy6H+bA3bD9fI71b0te4p2UtDNvdcgOoWpQiDasMIvGIQQQ0zVS4qx0+sh/X0
         NLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421288; x=1709026088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67zqLp2NujpZSzgMSsWNOorMz98+x6ajQiomKeMyjqI=;
        b=hanJOw+706DSRAZUfGkg2SgpqEDJigM/W7qCQRqP9HbjqSwbrvk2sKTjT3kho/ARGc
         Sld4/RRTqkIG+mu3tcWnvAT+pwvajhtUAyxh1EM0DJuIKEXLFHRfiXGNJGA91jOhntVz
         slJjOPYVNMDEomjzofl97xKX3RF7NtfATZ/34RjAj+H4pWmyAOf7HwdIkj6cs1+oAEQ2
         EupjjQw7wm5is8ia15hBR8Ivo9lS1ULdwfzta/CoqeU5H49EHvAhmMwYizgmb3ddsWkW
         wNXZtni4y68uKgFlLFoyU1vIXxZ1FGO13K5onUYTUwqcML6Y42MPKo2BfpL3TeTr12A+
         aEZg==
X-Forwarded-Encrypted: i=1; AJvYcCUEgAZyD6CxA7bWqSe12Ul/J7WYqJ15id66uTK3p9eiUQPm5NZFlDJQVeC8zhlXxLOPx3p7n5JR7FG6rCvDInJoEEcN+9CnH2Dnt2jVtQ==
X-Gm-Message-State: AOJu0Yyzi2/ZMG4/8SA7UpZRLUMjQMqK3El17l9wEOab4KF2X4xL8LEh
	RHH9yNzZt29mB98GqGZ5CLDXndRl0pWkxxXjHez7W/E4oGI5Vj60DSCZWVlznA==
X-Google-Smtp-Source: AGHT+IFq7qmlWCK24e4E6KTGZnpAt6adAuskCSHyttRxhx9iO9yWyKJ9cRUIq+6/bnV17X5RcOQRwQ==
X-Received: by 2002:a17:906:528d:b0:a3e:cab2:f776 with SMTP id c13-20020a170906528d00b00a3ecab2f776mr2895034ejm.15.1708421287989;
        Tue, 20 Feb 2024 01:28:07 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id vw15-20020a170907a70f00b00a3cf7711d40sm3789110ejc.131.2024.02.20.01.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:07 -0800 (PST)
Date: Tue, 20 Feb 2024 09:28:03 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 06/11] bpf: add new acquire/release based BPF kfuncs
 for exe_file
Message-ID: <d13d70433bbf079d69027c4efa533a829b492394.1708377880.git.mattbobrowski@google.com>
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

It's common for BPF LSM programs to perform the following struct walk
current->mm->exe_file and subsequently operate on fields of the
backing struct file. At times, some of these operations involve
passing a exe_file's field on to BPF helpers and such
i.e. bpf_d_path(&current->mm->exe_file->f_path). However, doing this
isn't necessarily always reliable as the backing struct file that
exe_file is pointing may be in the midst of being torn down and
handing anything contained within this file to BPF helpers and such
can lead to memory corruption issues [0].

To alleviate possibly operating on semi-torn down instances of
current->mm->exe_file we introduce a set of BPF kfuncs that will allow
BPF LSM program to reliably acquire a reference on a
current->mm->exe_file. The following new BPF kfuncs have been added:

struct file *bpf_get_task_exe_file(struct task_struct *task);
struct file *bpf_get_mm_exe_file(struct mm_struct *mm);
void bpf_put_file(struct file *f);

Internally, these new BPF kfuncs simply call the pre-existing
in-kernel functions get_task_exe_file(), get_mm_exe_file(), and fput()
accordingly. Note that we explicitly do not rely on the use of very
low-level in-kernel functions like get_file_rcu() and
get_file_active() to acquire a reference on current->mm->exe_file and
such. This is super subtle code and we probably want to avoid exposing
any such subtleties to BPF in the form of BPF kfuncs. Additionally,
the usage of a double pointer i.e. struct file **, isn't something
that the BPF verifier currently recognizes nor has any intention to
recognize for the foreseeable future.

[0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d1d29452dd0c..fbb252ad1d40 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1513,12 +1513,61 @@ __bpf_kfunc void bpf_mm_drop(struct mm_struct *mm)
 	mmdrop(mm);
 }
 
+/**
+ * bpf_get_task_exe_file - get a reference on a mm's exe_file for the supplied
+ * 			   task_struct
+ * @task: task_struct of which the mm's exe_file to get a reference on
+ *
+ * Get a reference on a mm's exe_file that is associated with the supplied
+ * *task*. A reference on a file pointer acquired using this kfunc must be
+ * released using bpf_put_file().
+ *
+ * Return: A referenced file pointer to the supplied *task* mm's exe_file, or
+ * NULL.
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
+ * Get a reference on the supplued *mm* exe_file. A reference on a file pointer
+ * acquired using this kfunc must be released using bpf_put_file().
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
+ * bpf_put_file - put the reference on the supplied file
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
2.44.0.rc0.258.g7320e95886-goog

/M

