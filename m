Return-Path: <linux-fsdevel+bounces-52485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635C2AE35E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 08:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E251B3AFF91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2301F3FC8;
	Mon, 23 Jun 2025 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZz55gwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C7136348;
	Mon, 23 Jun 2025 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660759; cv=none; b=BlIRf85Ajx8Xobs3oV267NmWIoHNRNQx+wCvX8RKWynlt6esuQvmOiKXtxfIDrpSyl1tf3SvsSKfM3zS1Qm5TTr82I6eAw1E2ljJS8TbY8NQVq2whpsLKA/bVpCPg6lY3IWxnhBl4LDTI7mx2MLtCWZKD6xlNfoAyo+h+MtRQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660759; c=relaxed/simple;
	bh=BEJZRN76m+6IEQPpBHY905TwGMpPvyUC5d/zGM477GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzJDY8pPYLiCCB1FVWgLBTDeJlfuvm3h6Aeae6yPoC4J5/1oMQIEHTC0ZOkmKWOUwdbLQnlLEYgKzpgRVOqvDw8XJtoKWRL97ErPqUxs15RjRyS38dVf45lJY/5DYM+ZxbcFIdQRzYRTrJr4MMGLhhNktG7TaMKptWd3poXluPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZz55gwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A365C4CEED;
	Mon, 23 Jun 2025 06:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750660759;
	bh=BEJZRN76m+6IEQPpBHY905TwGMpPvyUC5d/zGM477GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZz55gwQzhVAj9SiiLd1VjSX7RNKyvtfYkU8MNYyvTwkhQsl9Zu2UUHLcEx6uwrPs
	 oSzGbLs029uaMehBdlNIcdIk99yuaBggfGLyV/sbmK9GLlZsLEr5cciGMtjTVzbbFL
	 aqNLqo9al9spafz0YP4rz43XOmIGOCGdIrz7osdIRVzABc1ikFeP5fAVS+fus2cI7P
	 HJiX28zTPzWCPeqdtLWJII+MNwNMIsr/9LoLhPSqZIy7NN43P2Nh6VSsKM5e9Fv76j
	 FU1Vh0ypxsiyWe7HjfLNhj2CZmHhJJG7dyUgBN6ogo7deT6rxAunV9NmMMWC3SL9bG
	 +qGxrsPoRAyHQ==
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
Subject: [PATCH v3 bpf-next 3/4] bpf: Mark cgroup_subsys_state->cgroup RCU safe
Date: Sun, 22 Jun 2025 23:38:53 -0700
Message-ID: <20250623063854.1896364-4-song@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250623063854.1896364-1-song@kernel.org>
References: <20250623063854.1896364-1-song@kernel.org>
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


