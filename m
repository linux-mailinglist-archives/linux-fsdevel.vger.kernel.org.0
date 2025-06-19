Return-Path: <linux-fsdevel+bounces-52270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A34CAE0F62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 00:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E92167A36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386D291894;
	Thu, 19 Jun 2025 22:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2jVOS9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B728FA8A;
	Thu, 19 Jun 2025 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370522; cv=none; b=ibIQjiqy9dyS3gSHRT9zIU38sYCSNHRp9dT0pp0gC00kTrLJgAW56mQfhGgRW2S/ssS2OnHzbABZ5Lxd3JMTXKNHjX4t3b9kF4iRkuAOPaeNbX4HyofNIEsfGD5j4TJx3FRnlhpql220/5/M2n8lX6ObxBFrER8dew3qLdsSRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370522; c=relaxed/simple;
	bh=BEJZRN76m+6IEQPpBHY905TwGMpPvyUC5d/zGM477GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6p+2VFdnOYm0MbOFrh1lC+pqUfQYaC9TK6UafOceFWCx8q3LiQiasyRMeMlEzTrXcw394kgAocItl0bfdhl2/1OX1R7gwTp6ANode58bIw1GH6JlqKUMFiHqpm3H9xYLBrTvRPpsQ+l45MESn9lOJRVaWJjX85k4dJqEV8ChBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2jVOS9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B992FC4CEEA;
	Thu, 19 Jun 2025 22:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370521;
	bh=BEJZRN76m+6IEQPpBHY905TwGMpPvyUC5d/zGM477GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O2jVOS9rsPu2QWKDqAZ9DxbYY0z+Q1V4k0o6rfpgaALR2sURs2kj5+dEgDCCQvA9k
	 P+c4lwC3Od9MJGqSSP35rC49R8MNkM3v8dH9qkhCBsDhkXdwRb1+PMldrbp0RbZKUM
	 UW3R7kO2jrvc1oCFrtdShybrPid1FFqUcz/0Srgmi5ACBwwpGL6hkF3SIdahQCH4F4
	 6WRxfvw4Ld6j4i/kUZ7kt4aLUep/oDTOBJC9iJF0+uyZZQ175yxnNHyiWMg2FPBXHx
	 1KOF543bUryz4TMLS1wL1tv5+XT0SeE5XJTWlnPYnDCyjRWGCWMzPAZmvBjW8DO9gB
	 NxndpHVMqZgUg==
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
Subject: [PATCH v2 bpf-next 3/5] bpf: Mark cgroup_subsys_state->cgroup RCU safe
Date: Thu, 19 Jun 2025 15:01:12 -0700
Message-ID: <20250619220114.3956120-4-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250619220114.3956120-1-song@kernel.org>
References: <20250619220114.3956120-1-song@kernel.org>
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


