Return-Path: <linux-fsdevel+bounces-43058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27ECFA4D8E7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B5097A97DB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590F1EA7CE;
	Tue,  4 Mar 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrIEAcWY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E91FDE2F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081281; cv=none; b=TcEgKj+LmUwiIOyJbGERaVeCbC8/4OBxse1oSXh0e1HL4AJYusxi6ra8Jvyr7dkYXiuEL+7cwuWtPAR7Xx/h6hghg2i8Co26CjbEhfw09kW1OZ399DOrd0tM/HCMQm8YIMUqT10fUWs4oDqO5oB03KlgHfM8xV2odx+acmGELFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081281; c=relaxed/simple;
	bh=xZdRWqml/Qk46PZe4c1qABRXAGdLWAu0Z0kdDnaX9os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IluzzXfqbVfpG4Wg69EuOHipg049mnCNhmS9zi9hwgAVLhQhOK1GctMSn1BiJHjfaJ8xe9TBHF8n1AlBcBHbdeySUU5JyqxahHAOcqwmZbr+A+fZRUf6VieycpsT0IusiZMpjY3f/B4LA25M6J230+ofLpIajQOVGqsOcx5ENxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrIEAcWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6020C4CEE5;
	Tue,  4 Mar 2025 09:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081281;
	bh=xZdRWqml/Qk46PZe4c1qABRXAGdLWAu0Z0kdDnaX9os=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VrIEAcWYOBWYlR16Dri/AA/vitIb15tBncCYFewPqJQ6+q2gazwve2byB/1/xsQXT
	 Bu5mMHBZndfDQjOMptO5sZKou+DkA8IPmMJcQh/mqR00Mp941Vxt9rJN1vsM9YBT9n
	 vRL6nfZbh3foA04+AYiADKt1PCOcimCX+gEIvtgL7JFYQVTQCDfMEKOTuwfScraYeS
	 jKuAHqMWEEfrvtlAta/5Rssfyowvc26cLGKkl/J6X/bnBgyuC+RetUtwcMjryWR4gF
	 JITPh4MHrjyd38gR3qGWh9EclOW1YI96KOUv5u19vNsrCCaBmvIqaIjsPeXedeB2lK
	 utax5GL6gJY8A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:02 +0100
Subject: [PATCH v2 02/15] pidfd: rely on automatic cleanup in
 __pidfd_prepare()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-2-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xZdRWqml/Qk46PZe4c1qABRXAGdLWAu0Z0kdDnaX9os=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7Vr5Yk7jGwC5wWZRE5n1X+eMHvelcLvV3SXNs761
 15/9MadvR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT4Y5k+Cvgel3uksfRGOtl
 Dl+M9k2+cH3DTwH1lLuXdj1c6320+vQthn9mj9mV3QQilC8z2cnOrHfknCTl8mZrm76/nJFp8ga
 POZwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on scope-based cleanup for the allocated file descriptor.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/fork.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..6230f5256bc5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2032,25 +2032,23 @@ static inline void rcu_copy_process(struct task_struct *p)
  */
 static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	int pidfd;
 	struct file *pidfd_file;
 
-	pidfd = get_unused_fd_flags(O_CLOEXEC);
+	CLASS(get_unused_fd, pidfd)(O_CLOEXEC);
 	if (pidfd < 0)
 		return pidfd;
 
 	pidfd_file = pidfs_alloc_file(pid, flags | O_RDWR);
-	if (IS_ERR(pidfd_file)) {
-		put_unused_fd(pidfd);
+	if (IS_ERR(pidfd_file))
 		return PTR_ERR(pidfd_file);
-	}
+
 	/*
 	 * anon_inode_getfile() ignores everything outside of the
 	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
 	 */
 	pidfd_file->f_flags |= (flags & PIDFD_THREAD);
 	*ret = pidfd_file;
-	return pidfd;
+	return take_fd(pidfd);
 }
 
 /**

-- 
2.47.2


