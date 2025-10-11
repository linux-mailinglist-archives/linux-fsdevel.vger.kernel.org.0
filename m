Return-Path: <linux-fsdevel+bounces-63836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E960EBCF163
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 09:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6357C540C4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 07:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23CB2367D6;
	Sat, 11 Oct 2025 07:45:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49241.qiye.163.com (mail-m49241.qiye.163.com [45.254.49.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D9A226CF1;
	Sat, 11 Oct 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760168709; cv=none; b=B8TK4ZrjYSP8L4JGTnfy+pVcFAyW/+LqFd4MLikLYfQaTXLMEjMJJYN+m8os/ZDyR3Sv+c9FLpLEyhHghPP245lHmtCXih7KnCPaz6T2WaFg9RSRNtfK6zU1x0+A03vbRgoKuDbax+iMEs7r1I5zKQsQGYM0rD4VY9O1lHEAYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760168709; c=relaxed/simple;
	bh=MXdE6JOzMN5JkLnUvLBmCT9zoevSFjlHubOknPy4r+A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O5rKBwaxnsfj4kE/DEp0Awj1gm7Mb78g2Z+O7f3M3xFM8ZhLewPpEBx6D2RK3qhIMdp5ZwCGQ4yqD/kj6V3y7rN09k/q7bNEyXYGCGcvvm6S+HEkaYGbTvN3SOeJTvVRgq06lDMTaMxnBg1NdTpByi+aByGyLMzolNr4lzJCuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.254.49.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 115ecd9cf;
	Sat, 11 Oct 2025 15:29:36 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>,
	stable@vger.kernel.org
Subject: [PATCH] pidfs: fix ERR_PTR dereference in pidfd_info()
Date: Sat, 11 Oct 2025 15:29:27 +0800
Message-Id: <20251011072927.342302-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99d22cd2840229kunmfe16db3ed1d0a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGExNVhhDShkYQ0pCSUtLH1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

pidfd_pid() may return an ERR_PTR() when the file does not refer to a
valid pidfs file. Currently pidfd_info() calls pid_in_current_pidns()
directly on the returned value, which risks dereferencing an ERR_PTR.

Fix it by explicitly checking IS_ERR(pid) and returning PTR_ERR(pid)
before further use.

Fixes: 7477d7dce48a ("pidfs: allow to retrieve exit information")
Cc: stable@vger.kernel.org
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 fs/pidfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 0ef5b47d796a..16670648bb09 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -314,6 +314,9 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
 		return -EFAULT;
 
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
+
 	/*
 	 * Restrict information retrieval to tasks within the caller's pid
 	 * namespace hierarchy.
-- 
2.20.1


