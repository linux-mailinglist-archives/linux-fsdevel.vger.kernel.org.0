Return-Path: <linux-fsdevel+bounces-34408-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0229C5101
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8A1B2BD69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8EB2123D2;
	Tue, 12 Nov 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uf3Medp1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A963120DD7A;
	Tue, 12 Nov 2024 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400639; cv=none; b=XHwu2dzv7B9qDE1d56EPJtjXhhIunNGB7Zyslp+0ZqVzFSO5y6U3zSoST3CzibHZs5vqdoWjbn24Q6B3LpequsdM6xuRgq4/sMyVY43eeWufLW18dCKErmbIPHwR9wtgN3+/H3RqxdWiY/PCQvXqltx10kkyxSMto3DODNfRHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400639; c=relaxed/simple;
	bh=6wcgg1hEfQa6Nf8Cxbudvhg88dmxNzVd4PTSML8QbyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQ6nTweDskfu7HKrQlpGIRu8DehHX6Tq0l9/gkYOp4SrHqr14ppSmTEPEyMAqzhVZdrqkE3q8I/LlyhvxMi9OkDOeI666iTHp9kffaGHTsEuBg9y7pyxLLat8i33njLuyQBzd9B1NUvVV+t8evYtGNQ8M5grCcZ0FBs6Rw1xeBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uf3Medp1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1101EC4CECD;
	Tue, 12 Nov 2024 08:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731400639;
	bh=6wcgg1hEfQa6Nf8Cxbudvhg88dmxNzVd4PTSML8QbyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uf3Medp105oKnGZpm6rnmxstKO78CWk2ZKLegEr9vLaHO0PDGQxCeRYwUiZrqDBXf
	 lJV6Cg5P6XzLJRznm3PbJTHxSo45OoTe6+6++eVdUgcukF+UAMBzMCg50+GX8M7lRE
	 lSEfcuMVyvKdT1veT6NE7r4GB5Q/FfWmGb14bWU5v62FNA3rAvabHc5RcGSTJDXITe
	 boOK+FdIDVfYtulDSh9ztfW16LTguU/4RM1lG5Vb978Un+BfLsDNv+qY9Jz9CGONU4
	 hfEUA13G4cfo1vPME2skNCJ1Oz9CmV1KX00EjDUs8KiFLT7TfF7kI4nWSGqsd8HIgx
	 twHq2I49jzWAA==
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
	repnop@google.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	mic@digikod.net,
	gnoack@google.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v2 bpf-next 1/4] bpf: lsm: Remove hook to bpf_task_storage_free
Date: Tue, 12 Nov 2024 00:36:57 -0800
Message-ID: <20241112083700.356299-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112083700.356299-1-song@kernel.org>
References: <20241112083700.356299-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

free_task() already calls bpf_task_storage_free(). It is not necessary
to call bpf_task_storage_free() again on security_task_free(). Remove
the hook to bpf_task_storage_free.

Signed-off-by: Song Liu <song@kernel.org>
---
 security/bpf/hooks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 3663aec7bcbd..db759025abe1 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -13,7 +13,6 @@ static struct security_hook_list bpf_lsm_hooks[] __ro_after_init = {
 	#include <linux/lsm_hook_defs.h>
 	#undef LSM_HOOK
 	LSM_HOOK_INIT(inode_free_security, bpf_inode_storage_free),
-	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
 };
 
 static const struct lsm_id bpf_lsmid = {
-- 
2.43.5


