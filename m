Return-Path: <linux-fsdevel+bounces-13691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7137872FE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD141C217DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 07:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645075CDD1;
	Wed,  6 Mar 2024 07:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaMSQed7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD9D5C907
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710821; cv=none; b=GiBZxKKM43ZItveUsazS79MW+/IOxwdedJHAD+kA302IqlCNUBvf8ORaSHKq3FDBQyzaRprMR1MpAlmYPPa7bsXUniubn3JPn8Xe/Fs9AXznU9VtHgoht977aAJxIyEz0+0M9bs+Sp5d8BJX8DAp1RW2JBzZD+eQsWT3OXxJ07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710821; c=relaxed/simple;
	bh=U4vPSgjo1MPCWnJXUOvvXXEqOMay8Ii8QfHFiSKW29s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skYbofTassFeIJuvopEHGfOZTf/yMvjOJJR0KMmDGARDnCSyJuuzSjmBU5p3DZogJ8JSWWO2zMsUWP+hDMxfDukrJLdMEyAY+gynG/H/S6oJ4w/XVr+tIWO83AY/jxvdHd4iTI1p+7e9ECsDgyLI3+8g4m/A4a/cJhO/Cd6TTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaMSQed7; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a0b1936400so3005474eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 23:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710819; x=1710315619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm//KmoxbXbcsWPglbMLVIS1Px1eJWCW4kUeYbyxn5U=;
        b=TaMSQed7tiLHZyrBlIazF8lhqDqw49F7ifTFDbVNEv7+Seqsw/i0yFKBj0myqTnc9O
         I7vs9Q4PNyj4sLMqG1ZeZWS+dZhSGR8oDH6M3wMgdbI9zQ3ggkdgAFvIJrUg6qq6dZVR
         v1nqyLj4sEYgxx3xnim0snw07/0g3C9sZ5b5CPmmplNk/Ow/SqBVnMxe3l+kyf25a34v
         TQGPMumOXFtyOeicxzevF75amXdAItCLLPK57xqFjnSH4n0DhX12gPRGlvmY2/tXBLXA
         bumuhKqVEd7/B+g3um+mD5TmK+u22jqbIq9oaP7sAUzdoTXMt8PyRBrRqS5pJ1o9HmPF
         3LBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710819; x=1710315619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm//KmoxbXbcsWPglbMLVIS1Px1eJWCW4kUeYbyxn5U=;
        b=fviaJnCubS9bO4S9lhC4V0ROPNhI/VnLv8Fb90EpmYkjMUWaItB4ebdb8R7HD9vUKZ
         vWzyZmU3gIyDshkJU3N+qaccy7emEdMsgb6o0jHDbX7jl8ZS7zaP0fqarqnig/4RXkEl
         mXFowoW8n/VPioOj+N83zlf4BMks6Q/D4D/tnkveSKtvrQSK+Uph3+onuqxOftwZ2dkP
         0YOWSdWdppt4AD3NE8ohIaVvxjkl6VJetQPtPXyd+w578SGo7fW7Xr3U5j1nHA8NFw74
         ZGuTQoWSe2V5Osd1m2h6Oi3M+zMF121DaD7t2jm8npRbJWAy1UnaIDIOrSpb9FqY37z1
         eLAg==
X-Forwarded-Encrypted: i=1; AJvYcCWhaHanbCFvoKIvsf10jfyUySVeMG9C6y9+xSg2iwprtuvSjX+IT0YYy5X85DTdRQiwwyNkeEOx7SGvpvJZQoegG0j/iW+zQvJWb6C2og==
X-Gm-Message-State: AOJu0Yys+yJwB/1Xb6uxkTInFqN7b5dLa2Qr/7rKkk+8LPsBB7yJYWSm
	JpgjDe3yDzT6W8bGjfuwSkJt1oexBamsm/DWxbGrmBO0g57pipdhsWcNEakW/w==
X-Google-Smtp-Source: AGHT+IHmnIO9igbiizDOpzZIlfa7wqIYlpixrrFhSdvfq8QmXqsdRfEMPj7zalWSN0v34SoSWoRlvg==
X-Received: by 2002:a4a:354d:0:b0:5a0:ea46:ffe9 with SMTP id w13-20020a4a354d000000b005a0ea46ffe9mr3948384oog.7.1709710818904;
        Tue, 05 Mar 2024 23:40:18 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d6e12000000b006e4cd29aecbsm749390otr.47.2024.03.05.23.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:40:18 -0800 (PST)
Date: Wed, 6 Mar 2024 07:40:12 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 6/9] bpf: add acquire/release based BPF kfuncs
 for fs_struct's paths
Message-ID: <458617e6f11863ecf8b3f83710a6606977c4c9cd.1709675979.git.mattbobrowski@google.com>
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

Add the ability to obtain a reference on the root and pwd paths which
are nested within the fs_struct associated with a supplied
task_struct. Both fs_struct's root and pwd are commonly operated on in
BPF LSM program types and at times are further handed off to BPF
helpers and such. There needs to be a mechanism that supports BPF LSM
program types the ability to obtain stable handles to such paths in
order to avoid possible memory corruption bugs [0].

We provide this mechanism through the introduction of the following
new KF_ACQUIRE/KF_RELEASE BPF kfuncs:

struct path *bpf_get_task_fs_root(struct task_struct *task);
struct path *bpf_get_task_fs_pwd(struct task_struct *task);
void bpf_put_path(struct path *path);

Note that bpf_get_task_fs_root() and bpf_get_task_fs_pwd() are
effectively open-coded variants of the in-kernel helpers get_fs_root()
and get_fs_pwd(). We don't lean on these in-kernel helpers directly
within the newly introduced BPF kfuncs as leaning on them would be
rather awkward as we're wanting to return referenced path pointers
directly BPF LSM program types.

[0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 83 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 539c58db74d7..84fd87ead20c 100644
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
@@ -1569,6 +1570,83 @@ __bpf_kfunc void bpf_put_file(struct file *f)
 	fput(f);
 }
 
+/**
+ * bpf_get_task_fs_root - get a reference on the fs_struct's root path for the
+ * 			  supplied task_struct
+ * @Task: task_struct of which the fs_struct's root path to get a reference on
+ *
+ * Get a reference on the root path nested within the fs_struct of the
+ * associated *task*. The referenced path retruned from this kfunc must be
+ * released using bpf_put_path().
+ *
+ * Return: A referenced path pointer to the root path nested within the
+ * fs_struct of the supplied *task*, or NULL.
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
+ * bpf_get_task_fs_pwd - get a reference on the fs_struct's pwd path for the
+ * 			 supplied task_struct
+ * @task: task_struct of which the fs_struct's pwd path to get a reference on
+ *
+ * Get a reference on the pwd path nested within the fs_struct of the associated
+ * *task*. The referenced path retruned from this kfunc must be released using
+ * bpf_put_path().
+ *
+ * Return: A referenced path pointer to the root path nested within the
+ * fs_struct of the supplied *task*, or NULL.
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
+ * bpf_put_path - put a reference on the supplied path
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
@@ -1580,6 +1658,11 @@ BTF_ID_FLAGS(func, bpf_get_task_exe_file,
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
2.44.0.278.ge034bb2e1d-goog

/M

