Return-Path: <linux-fsdevel+bounces-36996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39CA9EBD8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 23:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9256216A136
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 22:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9632229156;
	Tue, 10 Dec 2024 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA4lYaoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1563B1EE7A2;
	Tue, 10 Dec 2024 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733868430; cv=none; b=R9PKUUzymPZxvNkz9qKeK/U7A59U695Ygi0stmOffWZJqtnzJxoclFOhnd2X1A9NxSi6vJYATdG/PJXq3UpEsbRr3qNwvR+ZrGg5uxOQpS5XSuczCST/83M+KT/y1l+vPcKJS4uUgwHWt5qAPAAslck7/R+lEKENr15NNMnTmm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733868430; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0T/AZF85o+suRaM5Mm/B/GZunhXol00FgOVQo9ZFaOkUzzx3Wnq1iPi7DVnPM05My+NQjGw2nEIGb5ZoPCRyxifB/8MnsAFiX/JE84tWWSvW2zJRjWxx/gLv76eKUrrtBxwpnPV5XgI/JTovnihTaog1E0059whCB51F5RWg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA4lYaoi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14E4C4CEE0;
	Tue, 10 Dec 2024 22:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733868429;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA4lYaoiOHoiWsUKL5TDYkbHiRgbrZoKvyRzZH98llm9HOpFy4VTbyIHTIwNF2GDc
	 zpN7KgQ41KxIKkvhlAVOYV8RTwQ0G3qynngijax+Ynxx8U0MEwYi7Wj5cehp8Bxrm7
	 7c1HWSj70KxE7KbHAE35jdC5kNQAH6tAQwZ0q8seDOLmve170fcX5PdmElTSCFXwjI
	 BoqKhsmGYla1wDkJrVH08kSBeXV7clnmwWjobaijKAYNGy9+4NP4vksMqu14ewgsOQ
	 PSZc0CHUkqAW8btiwkN3RdAYCbvCHUtKsGNAQtLKWcfarVKusSB4rdvrHzbzH6SYZy
	 TTMl59f6wyW9w==
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
	liamwisehart@meta.com,
	shankaran@meta.com,
	Song Liu <song@kernel.org>
Subject: [PATCH v3 bpf-next 3/6] bpf: lsm: Add two more sleepable hooks
Date: Tue, 10 Dec 2024 14:06:24 -0800
Message-ID: <20241210220627.2800362-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210220627.2800362-1-song@kernel.org>
References: <20241210220627.2800362-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bpf_lsm_inode_removexattr and bpf_lsm_inode_post_removexattr to list
sleepable_lsm_hooks. These two hooks are always called from sleepable
context.

Signed-off-by: Song Liu <song@kernel.org>
---
 kernel/bpf/bpf_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 967492b65185..0a59df1c550a 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -316,7 +316,9 @@ BTF_ID(func, bpf_lsm_inode_getxattr)
 BTF_ID(func, bpf_lsm_inode_mknod)
 BTF_ID(func, bpf_lsm_inode_need_killpriv)
 BTF_ID(func, bpf_lsm_inode_post_setxattr)
+BTF_ID(func, bpf_lsm_inode_post_removexattr)
 BTF_ID(func, bpf_lsm_inode_readlink)
+BTF_ID(func, bpf_lsm_inode_removexattr)
 BTF_ID(func, bpf_lsm_inode_rename)
 BTF_ID(func, bpf_lsm_inode_rmdir)
 BTF_ID(func, bpf_lsm_inode_setattr)
-- 
2.43.5


