Return-Path: <linux-fsdevel+bounces-36687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A29E7E3C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 05:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C761887179
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2024 04:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E9B7DA9F;
	Sat,  7 Dec 2024 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="cIQJPrMw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m60100.netease.com (mail-m60100.netease.com [210.79.60.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAEC4594A;
	Sat,  7 Dec 2024 04:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733546564; cv=none; b=Eb9Zd4Wq+7iF/m6x7GwS8AfnjZRLJ/jw6Br1JNqZxVKiAdZXTnRuouLo32ggPOCEfKuzb/pwZd37yssc+H0vLX98+/zvZNF27fllEPAAdvt8SEMicIJKrR5rkiD8wA0ZSBvcE45TqfXuOR40rh4i5d58pp67mvPI6vjliiQip/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733546564; c=relaxed/simple;
	bh=HMdtTUtzSIja3JEp9rNY5FRMru0ceZs02c4Mf8/k/rc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W4RFZlC45T0p2FgtbVLD4IireHdwFiszKLArf3E2KP0+/GLSa9oTAOp+K0GtFjZuWgD28lj32y+GkAxUzBXAiDszHG/8xMzCOinqnvKXpACC7VOcaUvaW7HAQ7SXQ1Y2jpck5PHOLueM32DPRQuhtpGS67OD6Db2zJw4kWOBnKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=cIQJPrMw; arc=none smtp.client-ip=210.79.60.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f744e4c;
	Sat, 7 Dec 2024 10:20:09 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: dhowells@redhat.com
Cc: jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,
	jianhao.xu@seu.edu.cn,
	zilin@seu.edu.cn
Subject: [PATCH] fs/netfs: Remove redundant use of smp_rmb()
Date: Sat,  7 Dec 2024 02:19:52 +0000
Message-Id: <20241207021952.2978530-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0xNVkhJTh9JShgfTk5JSVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a939eead27803a1kunm4f744e4c
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDo6DBw5GjIqDUkcQzdJEDw9
	CkoKFA9VSlVKTEhITkhDS0pLTUhIVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKSktKNwY+
DKIM-Signature:a=rsa-sha256;
	b=cIQJPrMwojB2L3Zlqa1Mi/B2gGf58Z9rR7yrdTWOHJceIPBZ7z9u3aHvHCu4GBjT4YjySglaiFNOPCzI+99LeQRFfw/TqoV2/7VVkjQHwyoLUTtiVSmSDMWN6IKLwE5VXxKO6NgIeGw9zKO1kxK1gfKZyysImfoaF3sJ59CgrOo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=EQzIrNnIyG5tXCGdHLpf6HtjgxuDF7I3HH2v48y6u2Y=;
	h=date:mime-version:subject:message-id:from;

The function netfs_unbuffered_write_iter_locked() in
fs/netfs/direct_write.c contains an unnecessary smp_rmb() call after
wait_on_bit(). Since wait_on_bit() already incorporates a memory barrier
that ensures the flag update is visible before the function returns, the
smp_rmb() provides no additional benefit and incurs unnecessary overhead.

This patch removes the redundant barrier to simplify and optimize the code.

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 fs/netfs/direct_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 88f2adfab75e..173e8b5e6a93 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -104,7 +104,6 @@ ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *
 		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
 		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
 			    TASK_UNINTERRUPTIBLE);
-		smp_rmb(); /* Read error/transferred after RIP flag */
 		ret = wreq->error;
 		if (ret == 0) {
 			ret = wreq->transferred;
-- 
2.34.1


