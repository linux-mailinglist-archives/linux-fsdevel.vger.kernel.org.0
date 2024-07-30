Return-Path: <linux-fsdevel+bounces-24545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBA4940708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D944B22940
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1466193095;
	Tue, 30 Jul 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXdtT3jB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBF193062;
	Tue, 30 Jul 2024 05:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316499; cv=none; b=HLS7fhP72SfCKZ5O1WAZJW8DZp6MyZcaZbd5J2DpPacNi0+efYn9QLVeIlWCt2TiiwrJIQUuZj4ngGvB+9xMXJRHK1T5LK3NFGkMH4KTRKrviOJqSfn+xXXtDiqtvKiv07xyuMN+AcCR7E2bvvrc2BfF8fqRKkMEDy1sNv3uZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316499; c=relaxed/simple;
	bh=SnhFHM/V1L+UQ7+JeKgF4mqSQqH9RQKlsqpPUGFQLa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efnvS/J4JYEXyg69xu4McBRCot0SDj7fIJFw/khtVsG7trgGM9dbR/Cnp6Sc76yiPUZEkV/sV/KsvDDpDnHAajiel8urJwhp97IOQ1nAjBCKmhbW0LYLXd2OdRvIs6KsZGngMS1mtg6DKbPWkNn+eKKYztQy5yGSGjPacMjiqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXdtT3jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3928AC4AF0A;
	Tue, 30 Jul 2024 05:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316498;
	bh=SnhFHM/V1L+UQ7+JeKgF4mqSQqH9RQKlsqpPUGFQLa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXdtT3jBcOlEUi5Q4S+ztULmuC8Sz1CU64VVXQK+y2TrZY2r3jomXOfOtilGdF2Cs
	 Ktjpafs3f2/jh7c1Hq3HH2t1K8VdcxHocie7BX8gud0gvz3IOIB5ZE12S7xb3Z5JI9
	 lmm9A5Wtj4cCBMz5b2OgJO7Y388Oti84xO6jaFntzsp+2+SedqKXrNGyjEoJ1olJhA
	 7W6xB2Sd3HyjXsx0rT1uVhdCfnetiblMwuqqWVyZaQLyIdVgrNI7DmnqaplrsuGbQG
	 qtMSpQt2IOHOGQgWoUjQO5/eWIdJAP/khZgAEg/ZhKSuvbEpUbSkcWPlj3dkwuttaO
	 QBdSEIPhCSmSA==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 13/39] do_mq_notify(): switch to CLASS(fd, ...)
Date: Tue, 30 Jul 2024 01:15:59 -0400
Message-Id: <20240730051625.14349-13-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

semi-simple.  The only failure exit before fdget() is a return, the
only thing done after fdput() is transposable with it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 ipc/mqueue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 48640a362637..4f1dec518fae 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1317,7 +1317,6 @@ SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes, char __user *, u_msg_ptr,
 static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 {
 	int ret;
-	struct fd f;
 	struct sock *sock;
 	struct inode *inode;
 	struct mqueue_inode_info *info;
@@ -1370,8 +1369,8 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 		}
 	}
 
-	f = fdget(mqdes);
-	if (!fd_file(f)) {
+	CLASS(fd, f)(mqdes);
+	if (fd_empty(f)) {
 		ret = -EBADF;
 		goto out;
 	}
@@ -1379,7 +1378,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 	inode = file_inode(fd_file(f));
 	if (unlikely(fd_file(f)->f_op != &mqueue_file_operations)) {
 		ret = -EBADF;
-		goto out_fput;
+		goto out;
 	}
 	info = MQUEUE_I(inode);
 
@@ -1418,8 +1417,6 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
 		inode_set_atime_to_ts(inode, inode_set_ctime_current(inode));
 	}
 	spin_unlock(&info->lock);
-out_fput:
-	fdput(f);
 out:
 	if (sock)
 		netlink_detachskb(sock, nc);
-- 
2.39.2


