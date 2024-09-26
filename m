Return-Path: <linux-fsdevel+bounces-30192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 265589877D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 18:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0ECBB26AA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 16:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF6158853;
	Thu, 26 Sep 2024 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZGEAve7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD63F9D5;
	Thu, 26 Sep 2024 16:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369517; cv=none; b=E7j+DP57aLVqGFbvLBpLF1HgVYV6aqpby5MuHXfOUy53FnMizqMkep/7se0CMOOX4abgZyR6/naZAYsur5+2HypVx1MOGyPIqm/hcnZRKytjdLUB7TzcQ17lCd5Je/S4PmU6Dw50+2kWXghSTVSqvmX0yrpaus3B5IHgwUhuFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369517; c=relaxed/simple;
	bh=9HRubwZA7xbhSYQLlr7ZvwaGS8W52H06SAgT4qsM/bI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofEVpkSTUUzi6DiHnflg5//Mmtj5fiEzwh0j+JJNSPJl1hWTUKAHTGec7LF2eIfY4OAah9I+ogeqe7owADeP8eOHjNAl2A19vmBYwzeCvwKN2LpZDAQRDhjwjTmNy1G64V3Sg80Yq7cltx6pLv9mBAJFdf5idKf+j/gEDbxc62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZGEAve7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4234C4CEC5;
	Thu, 26 Sep 2024 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727369517;
	bh=9HRubwZA7xbhSYQLlr7ZvwaGS8W52H06SAgT4qsM/bI=;
	h=From:To:Cc:Subject:Date:From;
	b=dZGEAve7YNt0itfVk78PxYuE7P8V6E2mKDDRSnw/PDYRm4itKNT+2N0HEQaI0kYnU
	 S1JAC6PfSVD+dsogpF2/xzAvMRHNhddxEAkAycgymYeJKRrhVgu+8BxlZYGa3pxMfJ
	 WdL0PoKKrlmEnSBCBcXQNYz6/0/emjqbn8HhPKSYAHFP+MQ+eFvvmhYtJZOfvqQf7A
	 7Y58n6uxxXfYd5T31RSBtXyoGVlocViInEJejhR5T3zaYP4Smp4BglOwFwBJEXZ2HM
	 fxZJQsAz54ooMQ0zo037/ySmE/czSDR/Llw1gPGfIUHtZoGwCmzBonkztaQKudnCsZ
	 BS27buHYaX6nA==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] pidfs: check for valid pid namespace
Date: Thu, 26 Sep 2024 18:51:46 +0200
Message-ID: <20240926-klebt-altgedienten-0415ad4d273c@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=brauner@kernel.org; h=from:subject:message-id; bh=9HRubwZA7xbhSYQLlr7ZvwaGS8W52H06SAgT4qsM/bI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9nahqccREy/L9bk/fuPnFNu0uUS2BVszaMy99mGbUo Xs6wCauo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJCNxj+x2S6XX8dx/794m3B UPbt27enuidYZu86sKYkrXppm0iwLsP/tBXbeRbmPHj07tbLF1zcqivWunzONdoqaMKkusz4MWM yKwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

When we access a no-current task's pid namespace we need check that the
task hasn't been reaped in the meantime and it's pid namespace isn't
accessible anymore.

The user namespace is fine because it is only released when the last
reference to struct task_struct is put and exit_creds() is called.

Fixes: 5b08bd408534 ("pidfs: allow retrieval of namespace file descriptors")
CC: stable@vger.kernel.org # v6.11
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7ffdc88dfb52..80675b6bf884 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -120,6 +120,7 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
 	struct pid *pid = pidfd_pid(file);
 	struct ns_common *ns_common = NULL;
+	struct pid_namespace *pid_ns;
 
 	if (arg)
 		return -EINVAL;
@@ -202,7 +203,9 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PIDFD_GET_PID_NAMESPACE:
 		if (IS_ENABLED(CONFIG_PID_NS)) {
 			rcu_read_lock();
-			ns_common = to_ns_common( get_pid_ns(task_active_pid_ns(task)));
+			pid_ns = task_active_pid_ns(task);
+			if (pid_ns)
+				ns_common = to_ns_common(get_pid_ns(pid_ns));
 			rcu_read_unlock();
 		}
 		break;
-- 
2.45.2


