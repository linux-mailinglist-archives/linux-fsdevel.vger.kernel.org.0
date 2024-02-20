Return-Path: <linux-fsdevel+bounces-12140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1E85B77F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831731F27D6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D053657B0;
	Tue, 20 Feb 2024 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SEGU1oF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECE60DD4
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421322; cv=none; b=lENyWV8SXgDp2k8Ah6dD1vy8aU1J7cIAY8G+kYYHm0nrvMXB6VIQdDEI8xzWyyXYx9z3h30gVytGCyJg/mDrEKfkOnO1T094RlnNdXFd7GPgKqWPYw7IntXTX9bbHGNEO1K1YPr57aRlAnH0tsKgEEYP0JGRr9jK97qRYv272j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421322; c=relaxed/simple;
	bh=B0wfWCclmrTNKw8t5WQOMXI4ZoGVKDEJu3DZO62q57k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxwBTaaofP5t/uElmItNIfubYsdcv47hx9Tw2pnAVfV6fPmhNB93gKsLx7Dy4YYJdWrb7u8OS35DiuVOjj8rN1wa7cyt1SSpnEwiKrjudCFbNhaznLgdl3b6uTAa7aTaYGBzSUi9/imxozknUeXLyL3mzLhPil7p4W+x7v4uaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SEGU1oF3; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so2922569a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421319; x=1709026119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oxaMZcDKEkY7wflrO9M/nsmbkLRY7k3BJEAicWcKejI=;
        b=SEGU1oF3rDdvPqD8mC7dU+hhSA1dRtXkroqVxYfXB7cI0p2TwyUYNn1S8kMCTZD3ve
         GN4xhojgIKrvnwvsx+XN05TIE02ttDzOSFE1jJp22tivUlTjCMn2e8ToMPTVtVlRse2d
         vRcVl2oYGvB1eERdRykxURxNdpzKSoHmWEIcTwTl4Rjh5iifKL/AaLlnIU6txnfVNdx/
         pcKa0LAtP+sGB9EKnHDsF7LbZKjx87z7wODlK5ohMOAkg3E9TnW9Dvx0Jj2so0f62xcL
         G548vK4lGil9EeUb0CZBHS9DzgoNqhGKV0vDh0uaR0z6+H1xxv3nKYDQCNTiGfDxhw6z
         HroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421319; x=1709026119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxaMZcDKEkY7wflrO9M/nsmbkLRY7k3BJEAicWcKejI=;
        b=fYyQgIRfyYbG44NGfw1aS0pU13uDsuW9OPzFzjl+QNb8SzLD9/08pQBqmSCwGnjRfU
         Sec6bi1GrASsdONI14B4xaZyQwF19aS5xjbwIERuDvdMN4tPZsJgrL+CH2T/w81qVaRr
         op3aKDqLSBtDVTeuWmXLk2h+2212eIy5nD1TS0vfmUeiNHIE22qwNgQtKcYQxv0yWhiF
         ho0LCZtvTXeBnPNFWZK9nD7ftk5h0rz7lHnjLAzwZ40nOQO5DlWoCig//wvCg20DNxYk
         gS3m4sO09wipYKBMqtjuzhJla9FkdjDViUooOsF/RS3yztXPuk8iA4uU3WJh4AJm1+FU
         8k+A==
X-Forwarded-Encrypted: i=1; AJvYcCUrxJesTIS3P+g/5Igff+ve2tvIKqfK+l3FKYFL6S38meQn2kZUY//kASqFd65rOVjN1UdKYdk/Yx+OcsBP2QfjL9tfeGy14w7SuA/+Lw==
X-Gm-Message-State: AOJu0YxPR9YJBQI6Pi0CA6tRRRAnsoHKFnlIeSI/sEZBobQu3sPhYkmG
	NO29FV6fDggTgt5q/Gnp9oQABIHr1Gw0XkO0tCiHOtPt9pF+TIeKLXOkM6DdIA==
X-Google-Smtp-Source: AGHT+IHOBu+/5v68Q4wEQvOl52ps73P98rLT4hw71J9hPjcmK9E4xRz5ROknH+/Xu0kNrWHfG8P7aA==
X-Received: by 2002:aa7:d997:0:b0:564:71d1:6cbd with SMTP id u23-20020aa7d997000000b0056471d16cbdmr3536021eds.14.1708421319547;
        Tue, 20 Feb 2024 01:28:39 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id h10-20020a0564020e0a00b005641bab8db3sm3286601edh.86.2024.02.20.01.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:28:39 -0800 (PST)
Date: Tue, 20 Feb 2024 09:28:35 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 10/11] bpf: add trusted d_path() based BPF kfunc
 bpf_path_d_path()
Message-ID: <46200bbaa6eae2131abed97f1a51991207eeb071.1708377880.git.mattbobrowski@google.com>
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

The legacy bpf_d_path() helper didn't operate on trusted pointer
arguments, therefore under certain circumstances was susceptible to
memory corruption issues [0]. This new d_path() based BPF kfunc
bpf_path_d_path() makes use of trusted pointer arguments and therefore
is subject to the BPF verifier constraints associated with
KF_TRUSTED_ARGS semantics. Making use of such trusted pointer
semantics will allow d_path() to be called safely from the contexts of
a BPF program.

For now, we restrict bpf_path_d_path() to BPF LSM program types, but
this may be relaxed in the future.

[0]
https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bb7766337ca..57a7b4aae8d5 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1635,6 +1635,36 @@ __bpf_kfunc void bpf_put_path(struct path *path)
 	path_put(path);
 }
 
+/**
+ * bpf_path_d_path - resolve the pathname for a given path
+ * @path: path to resolve the pathname for
+ * @buf: buffer to return the resolved path value in
+ * @buflen: length of the supplied buffer
+ *
+ * Resolve the pathname for the supplied trusted *path* in *buf*. This kfunc is
+ * the trusted/safer variant of the legacy bpf_d_path() helper.
+ *
+ * Return: A strictly positive integer corresponding to the length of the string
+ * representing the resolved pathname, including the NUL termination
+ * character. On error, a negative integer is returned.
+ */
+__bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, int buflen)
+{
+	int len;
+	char *ret;
+
+	if (buflen <= 0)
+		return -EINVAL;
+
+	ret = d_path(path, buf, buflen);
+	if (IS_ERR(ret))
+		return PTR_ERR(ret);
+
+	len = buf + buflen - ret;
+	memmove(buf, ret, len);
+	return len;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(lsm_kfunc_set_ids)
@@ -1651,6 +1681,7 @@ BTF_ID_FLAGS(func, bpf_get_task_fs_root,
 BTF_ID_FLAGS(func, bpf_get_task_fs_pwd,
 	     KF_ACQUIRE | KF_TRUSTED_ARGS | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_put_path, KF_RELEASE | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_path_d_path, KF_TRUSTED_ARGS | KF_SLEEPABLE)
 BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
 static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.44.0.rc0.258.g7320e95886-goog

/M

