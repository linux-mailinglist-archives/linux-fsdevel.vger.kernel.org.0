Return-Path: <linux-fsdevel+bounces-34400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097009C5086
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25122822EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B974C20C31B;
	Tue, 12 Nov 2024 08:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxxdiwZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617D79C4;
	Tue, 12 Nov 2024 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399987; cv=none; b=ZJ7Ess4sfNZO+XEcYYRNhmqxZD4Cq3eiP8woKaEnPgFaoUUPeG6wsyXVjSG65UxrrGrOpNrC8WZoU/dw3zsMz/6yJinYcXBp+Ooiw1h23HMF9F2EJucynQyDhKRD2IeOuaBe88UyBmjqwsBGM0VuuJhvzCx8s3bFWodJJELxZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399987; c=relaxed/simple;
	bh=6wcgg1hEfQa6Nf8Cxbudvhg88dmxNzVd4PTSML8QbyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEEat5nPFn7GDdd7ltxPR1R5ydJImJ0Tpk5oqocvBHiE8YkVV9eD4Nqm0GhfYG61J0jW+VTTplfj3LaqbyWSYLd3zT8iXhdrlQGDMpwViMZ2hYWx5lsWi1oPCX2mArK4dFlVdBs6hl6pxdqE3LBZt95uR0qs7bcxeCMZdHfjbTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxxdiwZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEFEC4CECD;
	Tue, 12 Nov 2024 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731399986;
	bh=6wcgg1hEfQa6Nf8Cxbudvhg88dmxNzVd4PTSML8QbyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxxdiwZ84rBFnZJhsmTsjlyzGMqioZUjKB9lcCR6fUMtLlEhwcvhg9dzmGf+5/6q3
	 SOWR2qY++JLe3q274y1KIaUZevOfCGuOWjj5olTs3Z3Z5/TdZJk6Z4Y8ntfaWqxDVI
	 ZU6M/4Wk2omO2zKSIehbGRunvsz08odris3gPzU09bzpaqeyFU+QNR9Xbg08U1/V/M
	 p3UJMGNBg96ohHpjy7N1v1Bb3eMHvR03YMejsZNXjfNaEeQGkkekcP4iqVu0j1e5mT
	 IobDkCXjgKYDJTv0cG6DXAlQ0Q3CUU9tWmGxvnzZuhEROIHgsMbcgFVcTk79l5OhBo
	 lgG3BAXTk3cFw==
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
Subject: [PATCH bpf-next 1/4] bpf: lsm: Remove hook to bpf_task_storage_free
Date: Tue, 12 Nov 2024 00:25:55 -0800
Message-ID: <20241112082600.298035-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112082600.298035-1-song@kernel.org>
References: <20241112082600.298035-1-song@kernel.org>
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


