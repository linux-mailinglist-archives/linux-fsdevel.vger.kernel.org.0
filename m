Return-Path: <linux-fsdevel+bounces-40772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0693EA2755F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914E0162FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF0211A16;
	Tue,  4 Feb 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR+RdYnj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0A213E94;
	Tue,  4 Feb 2025 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738681442; cv=none; b=iZHyYxkAsMCxPd7oiC8QMwHV0g0VVxLexysat8xkSmg+ysHLEKkX9vBYBXTC+GSmPNpr/O7+anNcedGHusIGTp1l8C5NJdTKgS3FJxtvuAjk/jST5XlyJe+w9uxozJhMV6/IM5JzhQocC765dDNmAeyQ6aJdKmtAzF37cM3dv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738681442; c=relaxed/simple;
	bh=rjcA3VzBxn2A2yxzRm4Zfgq6CG6XVYbT9cdyQzhcIYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=l2vEhIBmQboSV+S5COkaWz2u6oc242ZbY6gYJomS+PWMHnTskUGzotfz65f2N0UMJa2zfaCwV4uJQHVgpcXa6hjSPn0RwJK4GLHIhk3xGYwRy5aPgyqvcaHozgMrDTEPUlv7tJvz0cL+kbOFPzYtYQ2wZRxMNqTmGqEVdSOjQZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR+RdYnj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C70C4CEDF;
	Tue,  4 Feb 2025 15:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738681442;
	bh=rjcA3VzBxn2A2yxzRm4Zfgq6CG6XVYbT9cdyQzhcIYQ=;
	h=From:Date:Subject:To:Cc:From;
	b=FR+RdYnjy/ltFMjXMJHCDJCOfq3c8ETV6OJNjT7LDo5MlnYa6sKzgJfzY4s1BZln5
	 cGKGRekRBkkFPaRbnal6Hp/mgypPieieNvuTK8ArTMj0XnYru8YiOWdqojmVTR0ztF
	 IXXQ9MY3haU0fD53yHd2/57s4/59JPOf+inSGDpdeuA7vZizbrR/hWfs2mZGd7cP7w
	 VAEGIWqKYAWWg3oSQHoez8oOkav5mERkbRCgKDWcpJ2vtf3A6LXulDqylNZC4PlCEv
	 /Kk0KuT1ZN7jhMspTywKiWHEkEnAkbp7mjhAK5FlXPQyPXGHt9d36m4kuAbqSs3rd1
	 ONOSU1x9LhlFg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 04 Feb 2025 10:04:00 -0500
Subject: [PATCH] fuse: don't set file->private_data in
 fuse_conn_waiting_read
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-fuse-fixes-v1-1-c1e1bed8cdb7@kernel.org>
X-B4-Tracking: v=1; b=H4sIAF8somcC/x2LQQqAIBAAvyJ7TlgtQfpKdChbay8WLkUg/j3pO
 MxMAaHMJDCqApkeFj5TA9MpCMeSdtK8NQaL1qHFQcdbSEd+STT23tuALpjVQBuuTL9o/TTX+gE
 84tBpXAAAAA==
X-Change-ID: 20250204-fuse-fixes-03882c05c1b1
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=rjcA3VzBxn2A2yxzRm4Zfgq6CG6XVYbT9cdyQzhcIYQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnoixhWUZV6Cz9D5JV/ljsh4Lsu/OWMf2MAWtf1
 GmdZNn8JvyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ6IsYQAKCRAADmhBGVaC
 FdM+EADRNeVwLQA993ZSTfROon65oIS8IZjDSy/ODQf1yxBRsV1gegn6i44z9NdMwZxhXFgndKV
 3B/QLGF9A8lBO2I07+J/BJruks4lnf0T07UlofT5Iu+q5DrorQvthkZq9H3RYgR0mAGMNBsh5W8
 wOot13gpKY1cylbDCvLaP+AW1PK2XQEsMVhcD5x1W6KsudFnxiJt341r240VQx84wZWG6BNuQ2s
 ZysMgLy+GOj7zYgY7q0hUUSsMKnbcxeT+7Y+uHeqeKxLNpIN1/7lKplMlGcM5OFbaqGsZcZleMB
 S4yBIy/1TzyzKHpAavvFehywCVU32MAPTvLnvZQxjCdAiv2jHOs9Tb1sXN4TAP1WJrxUBjPQvjN
 cM1tcvvPg/uX3ArJ4U0rs/EkBMxqhfyqCfaKZ3NOkWApJNU6DQX4g1i5JzSkKPXp+P+gLpj+j0T
 UPAjn/dlLGRkQK/foTH9O7YnHmP7b06LK37fT650GHxCWkj6m4KOwTj6z4JUaLRBgI/YFVLhJbz
 nKFXqyH2yT2k8obOH28PpcKHFfFEBLpIaTjcCwswqRP76Z6eBBPEHz8EWxs22QJbbQFCHB8JFcM
 9sjAi7xQK7WgNKGyjuo8XlQzyZWQfwr1UrToAvVWtfMTpoXxAzWqCmLu2nwVDQkGwR8nBq86O8o
 Msv9L1hhK3Kf2ZA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I see no reason to set the private_data on the file to this value. Just
grab the result of the atomic_read() and output it without setting
private_data.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/control.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..17ef07cf0c38e44bd7eadb3450bd53a8acc5e885 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -49,18 +49,17 @@ static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
 {
 	char tmp[32];
 	size_t size;
+	int value;
 
 	if (!*ppos) {
-		long value;
 		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
 		if (!fc)
 			return 0;
 
 		value = atomic_read(&fc->num_waiting);
-		file->private_data = (void *)value;
 		fuse_conn_put(fc);
 	}
-	size = sprintf(tmp, "%ld\n", (long)file->private_data);
+	size = sprintf(tmp, "%d\n", value);
 	return simple_read_from_buffer(buf, len, ppos, tmp, size);
 }
 

---
base-commit: 9afd7336f3acbe5678cca3b3bc5baefb51ce9564
change-id: 20250204-fuse-fixes-03882c05c1b1

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


