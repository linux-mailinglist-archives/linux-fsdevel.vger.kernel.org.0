Return-Path: <linux-fsdevel+bounces-12133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E0E85B75E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B751C244E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9DB60DE7;
	Tue, 20 Feb 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eXKAvtsT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EC360DC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421264; cv=none; b=dTb7eehMe+N2iByzrgcJqfe0R+gtsUHQoic+K6utuHHPUcXuMxCchbYYMfFnejsUXAzHkBgS5tCVTcoq4BfWMY4tAFLJHXpkz0138otqI0jL3yUYz5wAaeVoeHrSGdH+8Qfl9DGuyRpgHiD98IfDDTlWLRiWNmYAWAywPMgV3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421264; c=relaxed/simple;
	bh=I+cErYdSLg0Qn/bGnm+p1n2X9JUNSmT0do5tne6EpyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFKtVyv1hF5y5gOdB/bOV1VDhF2lwckGK1fk8Yer4/0iZ15dCdIoWNwmApi2gfrKdL8z/bzNFVRpZiKgHaR4DCXFzJPTSCSWFhQUBMMXeh2q0KQ8aaOoaSbF76A7VrDXC7yLkKcZxoMreFVolvQ7E+rSIBni8oo5ORawC7diNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eXKAvtsT; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so499010766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 01:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708421261; x=1709026061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yos5PcM7VN/krEtPgbbzLqvu9MhyDgmtJVHiLz+77YI=;
        b=eXKAvtsTfT0cChu9u22g354APUtzVRduTiRJvxR9x6as1s4NS4n7/SpYnVEOv0dJPN
         jBcHeoP4LWqYxW0ecJzbVvQDKpz/8TeAviCbwXWioEFMS68aYPQSgl2LMWr5VDBfvIwl
         nlnI0UVLFLurmeaHEwCzM+cIfJ3+xZ8N/dipyOAGT16sI8bJui8feNcPteGdu4vuaBLi
         t6LYUp60aOXAElJET3Fr6z8dcrhA/cA52AAaUfT1PFWVhwiRwgNqg46tUUTcZmc9J8WD
         45OwqFAQrt5HhuLVzq+KSC4Kdmai0jkshPu9ZRtD0JCzobrv5XajmqjRr/2IIE8eT1zm
         LKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708421261; x=1709026061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yos5PcM7VN/krEtPgbbzLqvu9MhyDgmtJVHiLz+77YI=;
        b=EVJOshalpnEB8EgeCA77b/UnswpWv0BhvsqzMHSld9wWrLizqlxegyMI06MPNkHaZ2
         w1EuhCTDaOYG4xKO94Cwnz/9H5GyAj6Ko1i0KQSXOGQXtE5CzQqaVBqiPs5ByGk1NiZS
         fZimByksjMLLjOpmRj17HrNLXBCm538ySq+B/YxlFWWsvNZQwUCtE3jgty8YASN9nYpv
         V0z3ESANJNWr4qBenz7iDn3eo28Al3wQjCb1is66wDmAZvUPQIkwE/pmZUjlpS6KToaJ
         MpnEG+mpYWoHvmAckcmg+OXbDOZEJLyWZaWHSNhvWK0Xkzaie8NzBdm68hnZyxA9EGrN
         wZkA==
X-Forwarded-Encrypted: i=1; AJvYcCVjfL1IE1j/UDC6D9DnwNqGf7Fm9iUN937QZUKYPgf8Xobxtqys6dvt2z2AX3tIHz/Xw66fCt2G5sWLizFGAUHVtzAQ+h2x1FNt5RXLoQ==
X-Gm-Message-State: AOJu0YwNcXfVEwhQ7+dXXGaAk07SF6JDF/2ruS+MeGRGJtb7Z/DzH8Ik
	zWvoU3zOMwn7Xah8PdiDDwBeJ9UbAm1OJt2YGjzo/Eu8V3qvsTcYOotvJYIlcg==
X-Google-Smtp-Source: AGHT+IGUQRG8YW9LkcPuNFdTNNz7X5KvC++SADFb6lY6crmb2y8Eu/FZHEmtLzaGcgZ/g/7aBkRn0A==
X-Received: by 2002:a17:906:ac5:b0:a3e:ab9f:4129 with SMTP id z5-20020a1709060ac500b00a3eab9f4129mr2833910ejf.75.1708421260817;
        Tue, 20 Feb 2024 01:27:40 -0800 (PST)
Received: from google.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709063c5200b00a3d5d8ff745sm3800284ejg.144.2024.02.20.01.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:27:40 -0800 (PST)
Date: Tue, 20 Feb 2024 09:27:36 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH bpf-next 03/11] bpf: rename fs_kfunc_set_ids to
 lsm_kfunc_set_ids
Message-ID: <effc76c6df208ec8e13f08c49faeec51b61f05d1.1708377880.git.mattbobrowski@google.com>
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

fs_kfunc_set_ids is rather specific to a single kfunc at the
moment. Rename it to something a little more generic such that other
future kfuncs restricted to BPF LSM programs can reside in the same
set and make use of the same filter.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 12dbd9cef1fa..c45c8d42316c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1434,7 +1434,7 @@ static int __init bpf_key_sig_kfuncs_init(void)
 late_initcall(bpf_key_sig_kfuncs_init);
 #endif /* CONFIG_KEYS */
 
-/* filesystem kfuncs */
+/* A set of kfuncs that may only be called from BPF LSM programs. */
 __bpf_kfunc_start_defs();
 
 /**
@@ -1474,31 +1474,33 @@ __bpf_kfunc int bpf_get_file_xattr(struct file *file, const char *name__str,
 
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
+	 * lsm_kfunc_set_ids to be called from BPF LSM programs.
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
2.44.0.rc0.258.g7320e95886-goog

/M

