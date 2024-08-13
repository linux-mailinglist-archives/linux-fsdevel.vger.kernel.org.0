Return-Path: <linux-fsdevel+bounces-25836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A004951042
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89ABB1C22B6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16EE1AE875;
	Tue, 13 Aug 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbyI7etw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F21AE869;
	Tue, 13 Aug 2024 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590215; cv=none; b=sZeAOB6iRoX/AF0jG0ixZ1Jsg+8MalgveLk3v5eOgZ9dv+yiGBBfIq4+sOmYD2w4WIu8oNqsdXRNnEMUOZYyhpDNr+xNwjfHBlyILbJBgXcPlOoXRT65W4nFAhsm05dQ1+mrWcPaGCpJ1ijOXcuA+hCBNq+mhyXakzzJWIYBUVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590215; c=relaxed/simple;
	bh=yN88ZLKxTwYXK058BiNyVx5tkQ8DX5UbNvpbwGdvGJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bk4ZdkasowMNo+FAdzV+ZXBO8qaZZTjdjabWXunleYgJnjFcVEQUTIFi8hk17nQEQUCuc7CSL0je2A4zMv2shSxBMsdlLOqp9qP0m/5U8CedJ4SZCPbwj4BOqa7PeXtGDBza2smZdbKtIYt1yz+diOu31Lb8d1PLczfJL2zKP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbyI7etw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BCCC4AF0C;
	Tue, 13 Aug 2024 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590215;
	bh=yN88ZLKxTwYXK058BiNyVx5tkQ8DX5UbNvpbwGdvGJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IbyI7etwWMJWAh7hFr22d14bE+ZLJ/j6jLonWZWodCBYZ456B5YAx0n78UWrK03gF
	 l/ux7gxqlPoltYNLUtIWBEv2hyTjzPqnxpMOzUmM+xfAy/zjZRyGMtxieXO2zdRvxd
	 HD7t1UeQov4DtwHytbS8ZREVE9OMpNP4nsCkOBkxwZm4HDdAuKrhBaHfSQzUmE1WKA
	 6hw72BrwAPh7z7jyXfnLP6EqWCpDUKeErA7qQ8whr+ZKs7nlLxPlVVkP0kPsgNODn0
	 TUWQT1TnfmabSBVjEKWEgVROyoVoB6wByWEXusRREePadqpc+B/3NmLb7dL2BHTS+X
	 ULjxV8L61o7dA==
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
Subject: [PATCH bpf-next 6/8] bpf: more trivial fdget() conversions
Date: Tue, 13 Aug 2024 16:02:58 -0700
Message-ID: <20240813230300.915127-7-andrii@kernel.org>
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

All failure exits prior to fdget() leave the scope, all matching fdput()
are immediately followed by leaving the scope.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d75e4e68801e..65dcd92d0b2c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4901,33 +4901,25 @@ static int bpf_link_get_info_by_fd(struct file *file,
 static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 				  union bpf_attr __user *uattr)
 {
-	int ufd = attr->info.bpf_fd;
-	struct fd f;
-	int err;
-
 	if (CHECK_ATTR(BPF_OBJ_GET_INFO_BY_FD))
 		return -EINVAL;
 
-	f = fdget(ufd);
-	if (!fd_file(f))
+	CLASS(fd, f)(attr->info.bpf_fd);
+	if (fd_empty(f))
 		return -EBADFD;
 
 	if (fd_file(f)->f_op == &bpf_prog_fops)
-		err = bpf_prog_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
+		return bpf_prog_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
 					      uattr);
 	else if (fd_file(f)->f_op == &bpf_map_fops)
-		err = bpf_map_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
+		return bpf_map_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr,
 					     uattr);
 	else if (fd_file(f)->f_op == &btf_fops)
-		err = bpf_btf_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr, uattr);
+		return bpf_btf_get_info_by_fd(fd_file(f), fd_file(f)->private_data, attr, uattr);
 	else if (fd_file(f)->f_op == &bpf_link_fops || fd_file(f)->f_op == &bpf_link_fops_poll)
-		err = bpf_link_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
+		return bpf_link_get_info_by_fd(fd_file(f), fd_file(f)->private_data,
 					      attr, uattr);
-	else
-		err = -EINVAL;
-
-	fdput(f);
-	return err;
+	return -EINVAL;
 }
 
 #define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
-- 
2.43.5


