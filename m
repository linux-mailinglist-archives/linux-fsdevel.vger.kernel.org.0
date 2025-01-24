Return-Path: <linux-fsdevel+bounces-40079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A93AAA1BD7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 21:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDA33AE588
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 20:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83E22541E;
	Fri, 24 Jan 2025 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEnYJTY2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5F225A49;
	Fri, 24 Jan 2025 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750589; cv=none; b=kUaHyKrtxbgiqQ8IDOXi90b1s03iXSQyyHciWo37hXtIBG5Eh10i21zJAteTc2h+YsgYLECA9eIUVX/xoS71wI62aB/GaTia4FDSB4K1Dr9xk4/GMaj2Mq96oszWcWV0Z4OHztSGZUP1HeSiz0dMqrIDFTCQESiJlSO9GEGywl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750589; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlIl1K4oJ3WQMCvsc6b4GUa1cxuW8hDtSNlADzti5oWolTDC389d7Rs8oE7G6ueUv817TkNwasljkmICAv9Ly+GHiIdNs9v8AHySGlsa2CLitOmxbFEXoFI+5f7P9H56lh2sMADzdpqnEQdYYSrm31pOrNElt1+BSudMcUEANv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEnYJTY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B31C4CED2;
	Fri, 24 Jan 2025 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737750588;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEnYJTY2clXld9EpjoKayFF+hHrzUsBWLFBucFXWgYm+FWYbbmGs2tM5ZVipaTWR4
	 kVVfb6rYyH6efUkyoZEDEpoVRwRfddPjEVgnMHYznNsIcSFXeCI4JwWMl+6riYe+dZ
	 ScxehlgTQKBwn7auX8om26y9poY7PuJcK0mBuyU/WwAB710q2E+gCXAKbmvipwP9Ci
	 CvDONuw9/g+Nr5TUbYjHdWQa7DSaobxv9Oye8hE5aTjLzpINvVTE5G7x3ey6tY6Qxx
	 TPvxgdpHQLX3S5XD6HbL0gW2Q3AQcwk0KIiAfD8DXGvdf7h+JkuHbmxRlgKEL5f+mJ
	 oR9vzWgIsy3QA==
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
Subject: [PATCH v10 bpf-next 3/7] bpf: lsm: Add two more sleepable hooks
Date: Fri, 24 Jan 2025 12:29:07 -0800
Message-ID: <20250124202911.3264715-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250124202911.3264715-1-song@kernel.org>
References: <20250124202911.3264715-1-song@kernel.org>
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


