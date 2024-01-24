Return-Path: <linux-fsdevel+bounces-8643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB3839EB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAAE1F255F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89BC123;
	Wed, 24 Jan 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEl8Q2rE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA6CBE56;
	Wed, 24 Jan 2024 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062910; cv=none; b=hILbWKFF1oWc/SgB7Mp6LEAkZgxGqlLy9ka/SuHrN9P0cKKnmsELO3FL51akIIxgSHoZWqKROgIr0HIigrwDhP/d4A+45vWa8/VjoC2HIL1seeI5xPMGUTrdDh2R6K0yzfFIkAPH41dPSd+c4jl7BPzezOuxqIYc+uMPNeoKd90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062910; c=relaxed/simple;
	bh=Oxk+NJiwjF8vQSuTEKx6ano9FQjhrtjbFdEBPk2+dKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZM9thTM0r0px1Db8356odzJNFWQ9BLG3n/c05Ah+FBJCRO/zHgKeGqSSLgupc2/J/ONOgN3GrXAkNBBOs1QCa/ubVImBykTsqGB/V0qdqmdrlL5S96s6gyz4+pnRgSS2vPCmbhbnJjaTQkLzsEetwNtzC7meg05dL/Oz9OP7RTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEl8Q2rE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F58C433F1;
	Wed, 24 Jan 2024 02:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062910;
	bh=Oxk+NJiwjF8vQSuTEKx6ano9FQjhrtjbFdEBPk2+dKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEl8Q2rEGzSKgC2BYAXdGIVVXk2melSxEQhmIZEt05sq/eWYN8UjrvClgPpYx46Y6
	 FI97O7DHxLpyi/UvrcVDXz7DNzfG/RgPvohI3qr1ooKvGjn9PcK5qgPEMtdi0tZEuJ
	 Rz3DFi765R8ogacqsvg5KBDZ7SPsaNM12dk+FA/Pj7GCJwF2QV+1TW9N+1PLitLIV+
	 7dw+ev94TrRisW+4urdgOTPn0ZD9p6VDoIwDAYJwinftp7oUqRTYs5pqztdVE1rrQJ
	 n8u1fupzeUm64njI6VPAjBI2A8JDoR3MsD3XiS232FBOj/lO3xduvtc0tNSCw/VMe/
	 2wk1lev/O+tnQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 05/30] bpf: add BPF token support to BPF_BTF_LOAD command
Date: Tue, 23 Jan 2024 18:21:02 -0800
Message-Id: <20240124022127.2379740-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept BPF token FD in BPF_BTF_LOAD command to allow BTF data loading
through delegated BPF token. BPF_F_TOKEN_FD flag has to be specified
when passing BPF token FD. Given BPF_BTF_LOAD command didn't have flags
field before, we also add btf_flags field.

BTF loading is a pretty straightforward operation, so as long as BPF
token is created with allow_cmds granting BPF_BTF_LOAD command, kernel
proceeds to parsing BTF data and creating BTF object.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/bpf/syscall.c           | 23 +++++++++++++++++++++--
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 62f8be885731..9745521f0aad 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1623,6 +1623,11 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_flags;
+		/* BPF token FD to use with BPF_BTF_LOAD operation.
+		 * If provided, btf_flags should have BPF_F_TOKEN_FD flag set.
+		 */
+		__s32		btf_token_fd;
 	};
 
 	struct {
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5144c046c52a..39b20436306f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4829,15 +4829,34 @@ static int bpf_obj_get_info_by_fd(const union bpf_attr *attr,
 	return err;
 }
 
-#define BPF_BTF_LOAD_LAST_FIELD btf_log_true_size
+#define BPF_BTF_LOAD_LAST_FIELD btf_token_fd
 
 static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
+	struct bpf_token *token = NULL;
+
 	if (CHECK_ATTR(BPF_BTF_LOAD))
 		return -EINVAL;
 
-	if (!bpf_capable())
+	if (attr->btf_flags & ~BPF_F_TOKEN_FD)
+		return -EINVAL;
+
+	if (attr->btf_flags & BPF_F_TOKEN_FD) {
+		token = bpf_token_get_from_fd(attr->btf_token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		if (!bpf_token_allow_cmd(token, BPF_BTF_LOAD)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	if (!bpf_token_capable(token, CAP_BPF)) {
+		bpf_token_put(token);
 		return -EPERM;
+	}
+
+	bpf_token_put(token);
 
 	return btf_new_fd(attr, uattr, uattr_size);
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 62f8be885731..9745521f0aad 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1623,6 +1623,11 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		btf_log_true_size;
+		__u32		btf_flags;
+		/* BPF token FD to use with BPF_BTF_LOAD operation.
+		 * If provided, btf_flags should have BPF_F_TOKEN_FD flag set.
+		 */
+		__s32		btf_token_fd;
 	};
 
 	struct {
-- 
2.34.1


