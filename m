Return-Path: <linux-fsdevel+bounces-12138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A10885B76E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553231F26C7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFABF5FEE8;
	Tue, 20 Feb 2024 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1noG1LsA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959285F47D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421310; cv=none; b=cgBV0t4n1/0TkYvpn25fyhwmV6kQJ8dMcNWF/l76iQCcDSVgDYhFbDrq6r+rqJ4CtUGcuHrWDeSI6CYyYcudvZ07ugdZ1I0AK7bV/jOGhqyCBTHLV9i05eOdXtZt9oV9XYgXDEGjjIl+dXE3tCAhsZPt+TEZuzpvzML1jWiLSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421310; c=relaxed/simple;
	bh=EhRdG8Bffj4HR/2Z9RI+Xs1DgKmtukN31L0orRuOgMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQnjGzpzmlJrcY2m+leC1+REP3P/SO0xaQWqVBo3gmjSHhgOlPCmjH1Nc1ordR9oMZ3NaaP26vJ6tUeu6iCCcBVX18TfaeSiRXv2hwytpV9UDg1sDLWNbrNHw72pfXewto7LXFia0IWL7WSiXmiwL7dAHiAmvss7uoK7PmRkmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1noG1LsA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so7162383a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421307; x=1709026107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNhsno5HhiSi6Kp2q/Iucw8xWVpCBEX2HNzCiTZBy3o=;
        b=1noG1LsA+TZSfMTt51IPdqAzLW4use5siGY7tO8jp1nc3mCXHDN39aQ5H8X7Qfiztb
         wBV5ZJ8rrk+o04D77w5XPeB2NyPJfKQF34a5ewm/CUcwAPpAN9nn8aRN8jMSJXLFNUBs
         NU4LpMyJLnQK7kw1LvaTD1L8KgoKfUfeVNwfH9p9TGwThQiSwQZF20peCW4gl2yLYfNP
         o8eUNGSjgo5LMhE+0qX2sfAWxVoSM9va6Sxi7p0SBjt5UD7g2Lam7mtiLzZzoLxHgSN0
         Rju54j/NrTHQoNUd6hHDv/I7neNN0qaYxeFf8eQAYZ8VVqdHg7QyQX/WBW5HY/xKwtSK
         ZJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421307; x=1709026107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNhsno5HhiSi6Kp2q/Iucw8xWVpCBEX2HNzCiTZBy3o=;
        b=BFhzlWqeAdMuypAM6feoH0AlxghdWyc+qd3ZuENa5JMBZ/25Z+81i9Px3ob39OBQuM
         ywlU8X7htnP8OmDJJTIElzKsrZ/1JbeKIGtnaceEGhVBi2ICffg0Eg5rOba5zYA9ixh0
         2t7KkaNg7wt7zHwD+q5s3sLlXp6UaSS8uFLyKA4VspHvLCOQZun3MUxlRbcm2/t5ZJ9n
         7MLskElnMSbgjkcoQ2nimpFESia9M0Hr6WHuWEaKuU0ApDsJzBN35/Y5OqB9tMg6144l
         p4Ff/1/TPJ7CMl7MmHhFyxY2SX3VvZzl934HHyBwgNTLIxpMNFyMRCPzxKuctbcs0Y07
         OrEw==
X-Forwarded-Encrypted: i=1; AJvYcCUAfbtpJmx+2gZqPJXJwklo/wzI/rxBhTvqsim79gzJ8vF8F/bhty7XAcOlVDA55p+U1yuWAuItw3tqFqK3TnPRXTO4pLznETH9/AzhoA==
X-Gm-Message-State: AOJu0YwyFxgCAJkUu+78vCq466sxdrNnaPmXZ7S/+SEF1gCHUvG+M6i5
	AEoOLwZUPaeQ0/AsYS/P8EDN7n8wu0BZwOfbMMW8Gx98tJ8C0Do674uY1AoHEQ==
X-Google-Smtp-Source: AGHT+IG8xJfeMBOIFOzJE04kz5nK7k/hdFcuo9pPdlEXe65Ue0XcRKNWu/hcJDmHHreDuWqSzOqkHg==
X-Received: by 2002:aa7:d892:0:b0:564:50c7:20d with SMTP id u18-20020aa7d892000000b0056450c7020dmr4066362edq.34.1708421306801;
        Tue, 20 Feb 2024 01:28:26 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id cf28-20020a0564020b9c00b00564761ca19fsm1784597edb.29.2024.02.20.01.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:26 -0800 (PST)
Date: Tue, 20 Feb 2024 09:28:22 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 08/11] bpf: add acquire/release based BPF kfuncs for
 fs_struct's paths
Message-ID: <33108b72903162baa8eb39e047e6a9f50a890a2b.1708377880.git.mattbobrowski@google.com>
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

Add the ability to obtain a reference on a common set of path's that
are associated with a task_struct's fs_struct. Both fs_struct's root
and pwd paths are commonly operated on in BPF LSM programs and at
times handed off to BPF helpers and such. There needs to be a
mechanism that supports BPF LSM programs to obtain stable handle to
such in-kernel structures.

We provide that mechanism through the introduction of the following
new BPF kfuncs:

struct path *bpf_get_task_fs_root(struct task_struct *task);
struct path *bpf_get_task_fs_pwd(struct task_struct *task);
void bpf_put_path(struct path *path);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index fbb252ad1d40..2bb7766337ca 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -10,6 +10,7 @@
 #include <linux/bpf_perf_event.h>
 #include <linux/btf.h>
 #include <linux/filter.h>
+#include <linux/fs_struct.h>
 #include <linux/uaccess.h>
 #include <linux/ctype.h>
 #include <linux/kprobes.h>
@@ -1557,6 +1558,83 @@ __bpf_kfunc void bpf_put_file(struct file *f)
 	fput(f);
 }
 
+/**
+ * bpf_get_task_fs_root - get a reference on the fs_struct's root for the
+ * 			  supplied task_struct
+ * @task: task_struct of which the fs_struct's root path to get a reference on
+ *
+ * Get a reference on the root path associated with the supplied *task*. The
+ * referenced path retruned from this kfunc must be released using
+ * bpf_put_path().
+ *
+ * Return: A referenced path pointer to the fs_struct's root of the supplied
+ * *task*, or NULL.
+ */
+__bpf_kfunc struct path *bpf_get_task_fs_root(struct task_struct *task)
+{
+	struct path *root;
+	struct fs_struct *fs;
+
+	task_lock(task);
+	fs = task->fs;
+	if (unlikely(fs)) {
+		task_unlock(task);
+		return NULL;
+	}
+
+	spin_lock(&fs->lock);
+	root = &fs->root;
+	path_get(root);
+	spin_unlock(&fs->lock);
+	task_unlock(task);
+
+	return root;
+}
+
+/**
+ * bpf_get_task_fs_pwd - get a reference on the fs_struct's pwd for the supplied
+ * 			 task_struct
+ * @task: task_struct of which the fs_struct's pwd path to get a reference on
+ *
+ * Get a reference on the pwd path associated with the supplied *task*. A
+ * referenced path returned from this kfunc must be released using
+ * bpf_put_path().
+ *
+ * Return: A referenced path pointer to the fs_struct's pwd of the supplied
+ * *task*, or NULL.
+ */
+__bpf_kfunc struct path *bpf_get_task_fs_pwd(struct task_struct *task)
+{
+	struct path *pwd;
+	struct fs_struct *fs;
+
+	task_lock(task);
+	fs = task->fs;
+	if (unlikely(fs)) {
+		task_unlock(task);
+		return NULL;
+	}
+
+	spin_lock(&fs->lock);
+	pwd = &fs->pwd;
+	path_get(pwd);
+	spin_unlock(&fs->lock);
+	task_unlock(task);
+
+	return pwd;
+}
+
+/**
+ * bpf_put_path - put the reference on the supplied path
+ * @path: path of which to put a reference on
+ *
+ * Put a reference on the supplied *path*.
+  */
+__bpf_kfunc void bpf_put_path(struct path *path)
+{
+	path_put(path);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
@@ -1568,6 +1646,11 @@ BTF_ID_FLAGS(func, bpf_get_task_exe_file,
 BTF_ID_FLAGS(func, bpf_get_mm_exe_file,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_file, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_get_task_fs_root,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_get_task_fs_pwd,
+	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_put_path, KF_RELEASE | KF_SLEEPABLE)
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

