Return-Path: <linux-fsdevel+bounces-25832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04F595102B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7981C22BC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8B1AC428;
	Tue, 13 Aug 2024 23:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw6YcfUq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6657716DEA9;
	Tue, 13 Aug 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590202; cv=none; b=gYd4xRPevg3f06p5jQpCDm7jxX9NruajQDDf/hizgOWVf4DM/h2QHIapSDuQ9vwcrl3eHRn/X5h89NSjVDsTv76o1flIbIg1+SLZ0xxaRhdU/P1jKd/NSBSvGTKHdHfdRK0dyvjLfGnRW0dz6S6y4Yevfx6cHQkd8v926WEdJMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590202; c=relaxed/simple;
	bh=OvYOUI0EkJHm+DNxy2OTlBdQWylE9HXqB/XZ282TLtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJ+4LxeuzF4juPL873aQz2k4xVwI5v7Rd7T3Z20FqCRzvow6epoepHD8Djj3DwSGDgtQLSqmkybfO33UNBpKtakm8yj9y3w5mjM1o79oqXGItKFG1lZGhtRiExlse2h+1Y2PBVktJGr3nN5hqrsU2R5a/azoBbjWXTwGscF835s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw6YcfUq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4528C32782;
	Tue, 13 Aug 2024 23:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590202;
	bh=OvYOUI0EkJHm+DNxy2OTlBdQWylE9HXqB/XZ282TLtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xw6YcfUq1VQGf3PqpAethNN5GBiC1WGeYeFa4PkEHUi0uC7c6E5MyltjEZLVbUhuq
	 HCAJps1qt3tEZMPLL96JoT4QrJTJ/Wd/9eSjivGMu9WW40jEkXLTFWa1cVO0Nd3VyJ
	 db+VEdJEZxa9WA11c3uH0JggJ4AADjAmKTYjTe+G7Mb69o4W/Wjd5/dglkG+CguSZ8
	 r7np6RQiFJJSwycg/6uJwXUO8MzRC5P90MnFmADR+NfNInSKnqNTlOABR/K+G6gXAp
	 5aP39yjNS9PlMswH/+M4nmVCHZxO5vG6+GS4FIG9g4v0Ja50qRJgJVR3g04M5AFGfe
	 mraHCZWIs5DHg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: viro@kernel.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH bpf-next 2/8] bpf: switch fdget_raw() uses to CLASS(fd_raw, ...)
Date: Tue, 13 Aug 2024 16:02:54 -0700
Message-ID: <20240813230300.915127-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813230300.915127-1-andrii@kernel.org>
References: <20240813230300.915127-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

Swith fdget_raw() use cases in bpf_inode_storage.c to CLASS(fd_raw).

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/bpf_inode_storage.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index 0a79aee6523d..29da6d3838f6 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -78,13 +78,12 @@ void bpf_inode_storage_free(struct inode *inode)
 static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 {
 	struct bpf_local_storage_data *sdata;
-	struct fd f = fdget_raw(*(int *)key);
+	CLASS(fd_raw, f)(*(int *)key);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
 	sdata = inode_storage_lookup(file_inode(fd_file(f)), map, true);
-	fdput(f);
 	return sdata ? sdata->data : NULL;
 }
 
@@ -92,19 +91,16 @@ static long bpf_fd_inode_storage_update_elem(struct bpf_map *map, void *key,
 					     void *value, u64 map_flags)
 {
 	struct bpf_local_storage_data *sdata;
-	struct fd f = fdget_raw(*(int *)key);
+	CLASS(fd_raw, f)(*(int *)key);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
-	if (!inode_storage_ptr(file_inode(fd_file(f)))) {
-		fdput(f);
+	if (!inode_storage_ptr(file_inode(fd_file(f))))
 		return -EBADF;
-	}
 
 	sdata = bpf_local_storage_update(file_inode(fd_file(f)),
 					 (struct bpf_local_storage_map *)map,
 					 value, map_flags, GFP_ATOMIC);
-	fdput(f);
 	return PTR_ERR_OR_ZERO(sdata);
 }
 
@@ -123,15 +119,11 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
 {
-	struct fd f = fdget_raw(*(int *)key);
-	int err;
+	CLASS(fd_raw, f)(*(int *)key);
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return -EBADF;
-
-	err = inode_storage_delete(file_inode(fd_file(f)), map);
-	fdput(f);
-	return err;
+	return inode_storage_delete(file_inode(fd_file(f)), map);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
-- 
2.43.5


