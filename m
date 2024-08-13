Return-Path: <linux-fsdevel+bounces-25835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB4C95103F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 01:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FE7B26531
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2975F1AE053;
	Tue, 13 Aug 2024 23:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyB1B18L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F751AE028;
	Tue, 13 Aug 2024 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590212; cv=none; b=LJ/W0T/hkuisGpSovOxc4MKzOL5YJi6SfmmGzWNSWXUFtMtpGb3aJWe7BJ32Q5fuewQLEBiocnx6f5BuQxp8l85uXQ7OJWjUJRNiFjE4yt44KdfDQiqdGQ1fFELuN2pqab+sgRGyF1qi/LsRboBMpS9N67mnbyI3Cfn5aBdQQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590212; c=relaxed/simple;
	bh=am5kTclD7AJXZVGsQ0PGbf5T11FIztiaz+emT18uAGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQONhC6SgaC8We3S7dIaSrMbRmbGArSz3PzdwZCWZUg4TWtn5KwhlQOsdWiTGpsYYQQVaCdmAHxgWl2RmXzpVWs4gXq/q5TCpjtXYiDUjOW3bUIQ4rHKM0obuy/ConJio9DGkkoBPxUjPLpyhsOhlSgBFzzekVMJtJ6SH4UQSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyB1B18L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C42C4AF14;
	Tue, 13 Aug 2024 23:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723590211;
	bh=am5kTclD7AJXZVGsQ0PGbf5T11FIztiaz+emT18uAGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyB1B18LbPBOOigSO78+NUKnIKtWpQ1GRElDFoZLYvtmASFBKX6B5vuBB8V3+ibcn
	 KFNmqu2/MkSnxsSleTMeNKfPfKsBWY25G90UihbGCVd4wJWIZMXoG+cqDbIAplGmPs
	 2pyfcdZ7AOncDIM0lYqocDI40IIsea5whVdyzZzZ3/oj9Hls+7hqivc8JP1We6Y3hA
	 UHEiK/A4lk981str4tspV6aOHWZamjwGHQwRDMDZgTRC123UnvvlEUVeDcT+5xnu6z
	 De29pg5Ohjg2ChK6szvEQXkEJiyejjCHTzUSNApqMPPjLqWsPpoBr4d+8EGQhh+8DG
	 bnDUOE8ZsAKgQ==
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
Subject: [PATCH bpf-next 5/8] bpf: trivial conversions for fdget()
Date: Tue, 13 Aug 2024 16:02:57 -0700
Message-ID: <20240813230300.915127-6-andrii@kernel.org>
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

fdget() is the first thing done in scope, all matching fdput() are
immediately followed by leaving the scope.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/btf.c     | 11 +++--------
 kernel/bpf/syscall.c | 10 +++-------
 kernel/bpf/token.c   |  9 +++------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e34f58abc7e2..c4506d788c85 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7676,21 +7676,16 @@ int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 struct btf *btf_get_by_fd(int fd)
 {
 	struct btf *btf;
-	struct fd f;
+	CLASS(fd, f)(fd);
 
-	f = fdget(fd);
-
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
 
-	if (fd_file(f)->f_op != &btf_fops) {
-		fdput(f);
+	if (fd_file(f)->f_op != &btf_fops)
 		return ERR_PTR(-EINVAL);
-	}
 
 	btf = fd_file(f)->private_data;
 	refcount_inc(&btf->refcnt);
-	fdput(f);
 
 	return btf;
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index ab0d94f41c48..d75e4e68801e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3187,20 +3187,16 @@ int bpf_link_new_fd(struct bpf_link *link)
 
 struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 {
-	struct fd f = fdget(ufd);
+	CLASS(fd, f)(ufd);
 	struct bpf_link *link;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
-	if (fd_file(f)->f_op != &bpf_link_fops && fd_file(f)->f_op != &bpf_link_fops_poll) {
-		fdput(f);
+	if (fd_file(f)->f_op != &bpf_link_fops && fd_file(f)->f_op != &bpf_link_fops_poll)
 		return ERR_PTR(-EINVAL);
-	}
 
 	link = fd_file(f)->private_data;
 	bpf_link_inc(link);
-	fdput(f);
-
 	return link;
 }
 EXPORT_SYMBOL(bpf_link_get_from_fd);
diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
index 9a1d356e79ed..9b92cb886d49 100644
--- a/kernel/bpf/token.c
+++ b/kernel/bpf/token.c
@@ -232,19 +232,16 @@ int bpf_token_create(union bpf_attr *attr)
 
 struct bpf_token *bpf_token_get_from_fd(u32 ufd)
 {
-	struct fd f = fdget(ufd);
+	CLASS(fd, f)(ufd);
 	struct bpf_token *token;
 
-	if (!fd_file(f))
+	if (fd_empty(f))
 		return ERR_PTR(-EBADF);
-	if (fd_file(f)->f_op != &bpf_token_fops) {
-		fdput(f);
+	if (fd_file(f)->f_op != &bpf_token_fops)
 		return ERR_PTR(-EINVAL);
-	}
 
 	token = fd_file(f)->private_data;
 	bpf_token_inc(token);
-	fdput(f);
 
 	return token;
 }
-- 
2.43.5


