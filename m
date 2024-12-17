Return-Path: <linux-fsdevel+bounces-37606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164009F43E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 07:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6DB188DF0A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB375188014;
	Tue, 17 Dec 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl7yLao3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0A718453F;
	Tue, 17 Dec 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417532; cv=none; b=PgIqoRAGDMyNejoj5D57smOXmRRPOvo98ra3+FvMlQ9nLobr2X928rOdD5/ophpwa5PltlpaSp6LYmBwrzbjOYWYyuGCQwRav3MqfZcrlAzZHVcAYraXdMkAWd7Qxoq/z2KSKWguv2MRqOtICDdyZdJasC4JgUHeMQQ1JO69bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417532; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuEjt1x7riWXmGftmFcVR59OETgjVL30I1S1me3ekOrQSoC84SIaAxmNWcKCzjyRjIOxs4e7ucBQgorD9ieOLJtOfHuo2poBzCqlzOGJkq37sSy6OJ7HKtV3HkYsnyuxlII+WFiVMCXF/wEhse0oHVI7EdyxxbWZra25B9fjmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl7yLao3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC4BCC4CED3;
	Tue, 17 Dec 2024 06:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734417531;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cl7yLao3GfteqTdEyDwUWjMgtEec4bWw632duXx0uL947a6CrxYmc/oVvMWWYaYPx
	 dovPqJV9YD8cAIHGoWp/Z3HYy+HlYC4fzU3iJ3J+SDBOGd22ulvCUyumg+zU/lEm79
	 XsdN2CLdHRiaHOljc8cd2tWDE3Up3Jp7yLFX2tUqiANoqqBXIINswowkNMuY6XWWL2
	 mPjaeozR+rLy4VMtECNR1SwA8hNLHIL4yyX8lfqnjE1x5gNfH0H0ebIhiLNbrRSwGE
	 u2ivBcJ67Ui9OhJckVHCzO+KDJsISzH89HGn3wQjAJsz4jX7PdOIN6T4NVfG6Y9qZK
	 d1ixnpfkAwKDw==
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
Subject: [PATCH v4 bpf-next 3/6] bpf: lsm: Add two more sleepable hooks
Date: Mon, 16 Dec 2024 22:38:18 -0800
Message-ID: <20241217063821.482857-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217063821.482857-1-song@kernel.org>
References: <20241217063821.482857-1-song@kernel.org>
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


