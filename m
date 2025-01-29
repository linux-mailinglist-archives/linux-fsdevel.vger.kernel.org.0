Return-Path: <linux-fsdevel+bounces-40339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36144A22556
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 22:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6671886D12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 21:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBF91E47C5;
	Wed, 29 Jan 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbhB8yB5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A897081B;
	Wed, 29 Jan 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738184428; cv=none; b=LlNaQi7flsOEeodjSbo2rNGFdmf8XC+o6LNm+vmXGoouF3qiPLK5D5eHohb82NrDoe/nsYkBXUQ64trOlVp2jwO6kbTYSk97/Gy6CBJ24rkkqZMP1kHmxUcSvFcKTYasd6knvkrMSsE8t9Cn+X+dXMv803h5qx78ltRGU6uKlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738184428; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrCh7q8jYRCzVa2s9Iplx4OkaLyik0DLGxwGSlSoRvhzs8iNLKIkQXBZxmwlesamwP2YZp5e2LkV3x7V/5+OYNvEyD0HnSYDKc1wTjRz9yltFhs6CUmNGzAmRPD7j2BDhBJZxgkwV2Q2ZGjnjbTHXJI3eyTBbd3vOuu5ideCi3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbhB8yB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5553BC4CED1;
	Wed, 29 Jan 2025 21:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738184428;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbhB8yB5N5QN6p6T7WcJuHUmiPFwHdeGpUx4y2DvTRQQ0ux4K517mj2d4mn1i1Uc3
	 sY+pjMifLSBeMIqX2qNMHuUTr1/qFqorj/zAwC5Zq2Ev0qPHP6jZJiUjv+lYp8fd44
	 sOudcoNi71Mc8NA8vvtsMos4QpFQSNQm958XVpZUcvtkOCON+3RrTYiFg9qCllYIWo
	 06fw6k1tL+sp4mtes1suYd02vk5P+ytDP+BEpLEcyAmxEFfQJbVnlQMyJ+LzuLUul7
	 mTcMwGB6cpFRMqt5EpYHxAzwMwyCGfzNonc0MNXvtlH74blGXUHs4rgrHYuBdINbNf
	 2CKIziAz8j/Yw==
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
Subject: [PATCH v11 bpf-next 3/7] bpf: lsm: Add two more sleepable hooks
Date: Wed, 29 Jan 2025 12:59:53 -0800
Message-ID: <20250129205957.2457655-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250129205957.2457655-1-song@kernel.org>
References: <20250129205957.2457655-1-song@kernel.org>
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


