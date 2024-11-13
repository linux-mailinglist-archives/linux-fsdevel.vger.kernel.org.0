Return-Path: <linux-fsdevel+bounces-34578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782B9C6645
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9881F25113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D7422612;
	Wed, 13 Nov 2024 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HznpWHRx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7A25680;
	Wed, 13 Nov 2024 00:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459262; cv=none; b=Ki8v6goPlJINkUvpdpFTEWH/sgPTVA+WKSLsKIv96rRmMB0X+eC6iCi+UQUbnGnOZKfga1n2aAvQZSC0s7AQTEUooNPHiTlNHbbVOp7bx+8KQRZstrZ9Vx8CbHk7zMqDNL1AJnzkx8sPRU/Y9aZEl14nQkFJQkeGBx9i7nGElYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459262; c=relaxed/simple;
	bh=6wcgg1hEfQa6Nf8Cxbudvhg88dmxNzVd4PTSML8QbyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufSq/jdr5E1Yf2tYOpnBVoMgo2/xKUw8RB/x6VlQrEO75W0cqfQ9yrOV+KEZlXxQGRZZA7+w+//otPFu5Vy6tUDxvD4UjtwrC7uC18ZZtfktAtrotXJCA5eOV+rl7eIgWluypJ6cDgUtgR1zfDMmFjodSxeL3QNkm98u6AKtSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HznpWHRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B74CC4CECD;
	Wed, 13 Nov 2024 00:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731459262;
	bh=6wcgg1hEfQa6Nf8Cxbudvhg88dmxNzVd4PTSML8QbyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HznpWHRxmsCUyUgm3OeJYFQ4kW1C2psaD/P9cVx+RZ6U8//HtBt58/rtAezHGdtjz
	 lqYQsS9Qh+mSJSzymdQfUqoAacOMsV6YdxwPrFUHmcaeVOu3lC69PtPsDIaejMp2lZ
	 0ZFDTb7AWR+0VeCzIk8r9xwjQ8c6mkx6Ru66yI7oncQq78wMfbqSQ4DrZDXQbwdvHy
	 6hWBDHEJb2V5FeDbjRE10Vc9E2p7sRdgm4+AcvR24WMVqjfQyyWQ0IwvFOpTZv2Ogm
	 zPepZz3HKhaYL5vn1tSLI/5tIjlH4G2U0u3/EOZlteImuNd/OBt494N45W0jZpu6OG
	 u3R0T9A3OvA9w==
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
Subject: [PATCH v3 bpf-next 1/4] bpf: lsm: Remove hook to bpf_task_storage_free
Date: Tue, 12 Nov 2024 16:53:48 -0800
Message-ID: <20241113005351.2197340-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241113005351.2197340-1-song@kernel.org>
References: <20241113005351.2197340-1-song@kernel.org>
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


