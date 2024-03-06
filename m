Return-Path: <linux-fsdevel+bounces-13686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D527872FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE2C0B24423
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 07:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AE95CDC3;
	Wed,  6 Mar 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYX5Z56s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635355C8F9
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710770; cv=none; b=NcNEaA6qA7qJfCXgRF9AWovzmNdABPTUHKAtJ8mhrMVDpukRcxjNaV1jM4W7QHNLcxJInZvnC9umn4UPjMR2lO9p6ZSxqaRH6nRjrDJvLoZ8mD84grcIchZtBbIWsznOhF4b9c0A73biVzJUq7O1Jd+n73eEWkMRZn356IYolvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710770; c=relaxed/simple;
	bh=T9wyGNUK/a5+R+4NnNzOvivl3qko5cvFamHSS6BHobU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoSA460n8B7d8k6YBWqSnPwcx7aOaAXljzRtFCsxRfbb55O3wKGb3o+WMgyrmpPFHtIQ8WrdSxlsBWzs4cK1UuUVHdPxc9ekKAbMw9M2oM16jfLFQn5sT6uGoEXDaEcHosbwbO6cgylnn5pgS+p/D+9IHjWuAqZvL4jRJ9X0WVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYX5Z56s; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so1083138166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 23:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710767; x=1710315567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKGhvub9+e8WLvaTITikZYN5QDAVXk4MiuBB9Y8ZHfM=;
        b=IYX5Z56sfNrUJZr1SUPtzFsaooQEAajkLF8knX6XCC7O3AyNfVORM4+v0GqpY57v34
         b5K8M5hjbpKFB2Os9joZJnV5EQgeX8T9nNU7WHFCxZx1Jnq0Gy1v+8V6WWIQaNvklrIy
         7O9JceoMuctbxkhzkkJ5PzRhd54YOIDR8aMz9QmLMOOPm9o/YbbbQXNsxdUbt6UCu4lO
         tZGVafEa/BA9pgPLOKjprlqc2zAjkX685oEWZeOSiwn2kE3kTrNZdQbYXUxrjhFVYZib
         tOG58K0xG2OO870EVgtYdeujJHcyscV5HMvHdRiw2KvOYBzMDX4YOdmLBqKEHBfMX1p2
         OxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710767; x=1710315567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKGhvub9+e8WLvaTITikZYN5QDAVXk4MiuBB9Y8ZHfM=;
        b=bLRtCwyM2KgyAvEydZv9X4hJDe4Cd0Ziijem/YSMtZJYmfua9zMOF+TRJxixvYjPro
         1pcW6BQWbE0mvOb6bL9w/iJ4YhWBbUBg0+Q9laK8Z778U4ARzvb7xH+8WocBA+cY2GZD
         S1StFfDSM1lJPLDgicrL452dIuHAZIondDON7mDOAVBR3oWtXwhjg6Ha6cnZyVQIiYVv
         jCG2nNUtg+2AFZc39EhZGEUNjBNm0CmM8zNbAWDf+p0s3sHv5/jvAKS6F+2zA1FYCcFI
         cGXzXZYfK14NWxyLhb69pIItcYZPYEgExA+v2MGYbWTmkzfEfifxrHX8UXRrzQCwB7he
         TmsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJKhnfDuB4ujkv4fSivQ3kusM5Hx6XB2QG+JZ63JlNVc/XTSYW/UEjznwO/wZgaWg19CNWHldEtRBARXH6D3pmwNX90BuIxki5a8hjKw==
X-Gm-Message-State: AOJu0Yyn7ri23IrXDDpbZ3Cd0tkBV+hZJat0iimM0zz/uodJWDVqVPPf
	qp6U95kHRqGtUNZcSYMXJnPPcwv6I2bf6k6AS9OGDvmHQ2Qlb/RjN2P/C/pS6Q==
X-Google-Smtp-Source: AGHT+IFucscsSNmNlMP+XPI0+EFS5ODgbdCNT788DnByzIdHvN/V1lhu7I+wjq6DDchyuikxQvNcYg==
X-Received: by 2002:a17:906:4888:b0:a45:b1cf:42f6 with SMTP id v8-20020a170906488800b00a45b1cf42f6mr1523135ejq.9.1709710766566;
        Tue, 05 Mar 2024 23:39:26 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id wk16-20020a170907055000b00a4532d289edsm3429198ejb.116.2024.03.05.23.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:39:26 -0800 (PST)
Date: Wed, 6 Mar 2024 07:39:22 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 1/9] bpf: rename fs_kfunc_set_ids to
 lsm_kfunc_set_ids
Message-ID: <18b6eeea5fa3db45a7a3faba0066b5635e998585.1709675979.git.mattbobrowski@google.com>
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

fs_kfunc_set_ids is rather specific to a single BPF kfunc at the
moment. Rename it to something a little more generic such that other
future BPF kfuncs that are also restricted to BPF LSM program types
can reside in the same btf_kfunc_id_set and make use of the same
btf_kfunc_filter_t.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 241ddf5e3895..f639663ac339 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1435,7 +1435,7 @@ static int __init bpf_key_sig_kfuncs_init(void)
 late_initcall(bpf_key_sig_kfuncs_init);
 #endif /* CONFIG_KEYS */
 
-/* filesystem kfuncs */
+/* A set of kfuncs that may only be called from BPF LSM program types. */
 __bpf_kfunc_start_defs();
 
 /**
@@ -1475,31 +1475,33 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 
 __bpf_kfunc_end_defs();
 
-BTF_KFUNCS_START(fs_kfunc_set_ids)
+BTF_KFUNCS_START(lsm_kfunc_set_ids)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
-BTF_KFUNCS_END(fs_kfunc_set_ids)
+BTF_KFUNCS_END(lsm_kfunc_set_ids)
 
-static int bpf_get_file_xattr_filter(const struct bpf_prog *prog, u32 kfunc_id)
+static int bpf_lsm_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
-	if (!btf_id_set8_contains(&fs_kfunc_set_ids, kfunc_id))
+	if (!btf_id_set8_contains(&lsm_kfunc_set_ids, kfunc_id))
 		return 0;
 
-	/* Only allow to attach from LSM hooks, to avoid recursion */
+	/* To avoid recursion, only permit kfuncs included within
+	 * lsm_kfunc_set_ids to be called from BPF LSM program types.
+	 */
 	return prog->type != BPF_PROG_TYPE_LSM ? -EACCES : 0;
 }
 
-static const struct btf_kfunc_id_set bpf_fs_kfunc_set = {
+static const struct btf_kfunc_id_set bpf_lsm_kfunc_set = {
 	.owner = THIS_MODULE,
-	.set = &fs_kfunc_set_ids,
-	.filter = bpf_get_file_xattr_filter,
+	.set = &lsm_kfunc_set_ids,
+	.filter = bpf_lsm_kfunc_filter,
 };
 
-static int __init bpf_fs_kfuncs_init(void)
+static int __init bpf_lsm_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_fs_kfunc_set);
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM, &bpf_lsm_kfunc_set);
 }
 
-late_initcall(bpf_fs_kfuncs_init);
+late_initcall(bpf_lsm_kfuncs_init);
 
 static const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-- 
2.44.0.278.ge034bb2e1d-goog

/M

