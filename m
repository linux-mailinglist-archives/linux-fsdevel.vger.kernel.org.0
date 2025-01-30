Return-Path: <linux-fsdevel+bounces-40445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B4AA236CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79C416733D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3961F2C31;
	Thu, 30 Jan 2025 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIm9KZ0m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D431F190A;
	Thu, 30 Jan 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272987; cv=none; b=SM+5VuAe0dSlC+gbu0Z4QXJbWa5hNIrj8Ro+6GzrHeLdRs5R7XHLnYWEHKKLQuPurnt4Jcjs9wjD6IqVHtSDtuOg1soxP060hq1m0UzK1mUiWFT+MLI6A1Xqlp9BcL6E662p+kRdUJxRhmVf79oqRYCWDma1vEzV7lOpdqUugHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272987; c=relaxed/simple;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGsdVNo8zCcp42aFOdxzqPScueUx6f1aw+ur5/DWJrt8AVPklOgvcVcJ306+Z7+Y6nlnYWUefl7nhxGOt+2+Neds3LDh8JJABwaOW7rie/f/V08wFxHl2UAIGJwuf1XA+Ku3gRoFKuMmoZg+OyzFfMkeNkt5wwOUFmz1gQGWDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIm9KZ0m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B077FC4CED2;
	Thu, 30 Jan 2025 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738272986;
	bh=wFf35YVFFsrsYjOIPa/lLhJz+32cyCFyYbyRWYcEsrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIm9KZ0m8UE4IJf2B7Cs+zTZVseuBIWdMW27MqJqfOIJK2TuT5Hex7l15kQehrJll
	 FQuYkHFAErWMdh8dYYL+YexPEmITQzxb0ntqJ8Otjsiib3sU1g2x0ouFaigAho8Bb/
	 WSy3VHXUZKGXS/XcQbjVTBy5bp+oRt7Ni+gby6Qq1sj+91TuUMf4+oz8cWU8MqfdF4
	 wbN4VeE3nfPD83b5Diop9JVozsEtd6QRnYw0vPQ6DYU3rsOzraw2++ZU+k7QNkClt5
	 oxOSRmwWEAtT7hxWrWj8qgq9hkHuelxZxZfCnuG2lBZZUTm+ArgB3lh0JuDSPLwBdN
	 3Ry2NLvevHPRg==
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
Subject: [PATCH v12 bpf-next 3/5] bpf: lsm: Add two more sleepable hooks
Date: Thu, 30 Jan 2025 13:35:47 -0800
Message-ID: <20250130213549.3353349-4-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250130213549.3353349-1-song@kernel.org>
References: <20250130213549.3353349-1-song@kernel.org>
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


