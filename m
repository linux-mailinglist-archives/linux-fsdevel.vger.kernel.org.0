Return-Path: <linux-fsdevel+bounces-52139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B20ADF9D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 01:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC613BDDB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 23:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345362F19BE;
	Wed, 18 Jun 2025 23:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ybjnhxgl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068628506B;
	Wed, 18 Jun 2025 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289886; cv=none; b=Hn8ZSmHT5UwWTbqEelzepwbtwdxfJFng9O4MfgHIwyiAG9BUn+JHcfy3P9UwzXZUQK8l08KdXg90UGBxKe3i/GEQtqvfr5RdIDn3DJi7pTgR5cbMqISas8rNbLKWkp1qvNeglM/EyE4uBRqclgxg3L4TJKYv48FevKtEZ0XbNUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289886; c=relaxed/simple;
	bh=BEJZRN76m+6IEQPpBHY905TwGMpPvyUC5d/zGM477GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBIw4DoArUQtRr2V50+2ptRd1inWNOiOQc6ubhP92X6eSsyDEmu4v4jc3b8ECC1O+Y1c+Wug3GDxNfGT2WVwGugttcAvp5+JIRn1awNGdv8whqXQkGw4KXNor1YcXTTbHmr8i060ToH8Vi7+qdqPR0cXBTjIi9xDPGkQwwFBtpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ybjnhxgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F88C4CEE7;
	Wed, 18 Jun 2025 23:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750289886;
	bh=BEJZRN76m+6IEQPpBHY905TwGMpPvyUC5d/zGM477GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ybjnhxgl6S4FzP8XrakM4Pq5QDHYuyAdLu/JGs8nDTFsHNTkE5DneuKuFow8jUFmH
	 Ho9TZtHZwyLS1bajq8tO0UM3/3iZJ1X+j7jHJhD/pP0x/QX+444aoffZCwt7+2/An+
	 a0OFx7mMQe/P81gzLkg0m/pez7LxATcFP+/MAuJLDUQ3yPylVtZePFwP0/EdVu13e1
	 HmYNspkagu26CrWYB+BL0ZDycuOIEko8NyisNepGPSsEsCXDRyLZRLou1igdIOb3GF
	 cj/MQR+R1IAdlHUNwohtIbQl9VZ8HWprxyQFf6gBChg1APZ7sEwBJ2tIwt++gdb3g5
	 TNc2dfmo/n1ZA==
From: Song Liu <song@kernel.org>
To: bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: kernel-team@meta.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	kpsingh@kernel.org,
	mattbobrowski@google.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	daan.j.demeyer@gmail.com,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next 3/4] bpf: Mark cgroup_subsys_state->cgroup RCU safe
Date: Wed, 18 Jun 2025 16:37:38 -0700
Message-ID: <20250618233739.189106-4-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618233739.189106-1-song@kernel.org>
References: <20250618233739.189106-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mark struct cgroup_subsys_state->cgroup as safe under RCU read lock. This
will enable accessing css->cgroup from a bpf css iterator.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..e2f53dc8766a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7058,6 +7058,10 @@ BTF_TYPE_SAFE_RCU(struct css_set) {
 	struct cgroup *dfl_cgrp;
 };
 
+BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
+	struct cgroup *cgroup;
+};
+
 /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
 BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
 	struct file __rcu *exe_file;
@@ -7108,6 +7112,7 @@ static bool type_is_rcu(struct bpf_verifier_env *env,
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU(struct task_struct));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU(struct cgroup));
 	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU(struct css_set));
+	BTF_TYPE_EMIT(BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state));
 
 	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_rcu");
 }
-- 
2.47.1


