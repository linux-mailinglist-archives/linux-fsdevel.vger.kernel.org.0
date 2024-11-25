Return-Path: <linux-fsdevel+bounces-35812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBD99D8787
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF0E286A96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1901C07FA;
	Mon, 25 Nov 2024 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik1/m3fc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A8C1C07C3;
	Mon, 25 Nov 2024 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543856; cv=none; b=GrhnTvY63z0ogM4gsHRbUhL7AR/jYSx1cEz/st8wLkpjJKabYHLxmEKYX45iqplEmBG7aFgw31I6jFmqF770D9Z98DWax3dStp2PGY+LsTNWKphwPGMcNnJDVuWtzg9mscaLCf1IjJBcFsxvnGQHMm8NZX3rZ6BPj3XZJdneg7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543856; c=relaxed/simple;
	bh=uashmBaEdR6fdQIQMHMq1Z3iv/S7f/OPHqwJBo/qsYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLlpmtQQlhQb43wlXVzSQ4Pp7mT/qdPxBmyumnCa/O1WxB3Ssu3+X4ang7TG+x997xV7JbSZFjX88I/hoA6JfPafJiWN3dfQli+YkfDGgAS3Ddnm/ADzfXYRUvKMlw0s925duYQXavKslBoMe8sqibaOqIG9tvcBqYdssY4RhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik1/m3fc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1777C4CECF;
	Mon, 25 Nov 2024 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543855;
	bh=uashmBaEdR6fdQIQMHMq1Z3iv/S7f/OPHqwJBo/qsYM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ik1/m3fc0xDCrDnuQVw29giCxgchwS4hCosOTnKiEAFcQAaMgpLoUPUGLmQiBhEMm
	 tirRD52gohiFx2D1wS2A+kGs05Rx8JaR10drLDsgh/c2M30rpP8PA5c5+WHGOV2fyy
	 VrcVAJZXM6Lg6n2l14qzddz4zw8ZTjxrFdQd5j/eLiHsnqKVa3Hl7B8d3OnB425v0A
	 0bkY1s8UsD21wSZK2eOw/QatOqNQo4SRXJsI/tIQWPcmG49fO/91Dh+MleKEVMKF9V
	 zAawf1ifJx4X+uWdVfqWVzLnhAau9EJkBWdCHJE47wOYXlkzZI/W51RXi2nF9lSNt1
	 LsuSfB5RZXAUg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:11 +0100
Subject: [PATCH v2 15/29] nfs/nfs4recover: avoid pointless cred reference
 count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-15-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=749; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uashmBaEdR6fdQIQMHMq1Z3iv/S7f/OPHqwJBo/qsYM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHq+snzOVtuvmr1FlO83o+cZ3qiqOJ3wvN3/m4R22
 HewLXnbUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEZTxkZdro5qazQy7vuEPuS
 Q/g6r1jE28xNpdLBG80fSfJEB3acYPhfqnDLdorv54cGtRqx3cpmgf/u/vui//LwL6uY1Qo7j6c
 xAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The code already got rid of the extra reference count from the old
version of override_creds().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfsd/nfs4recover.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 2834091cc988b1403aa2908f69e336f2fe4e0922..5b1d36b26f93450bb14d1d922feeeb6c35399fd5 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -81,8 +81,7 @@ nfs4_save_creds(const struct cred **original_creds)
 
 	new->fsuid = GLOBAL_ROOT_UID;
 	new->fsgid = GLOBAL_ROOT_GID;
-	*original_creds = override_creds(get_new_cred(new));
-	put_cred(new);
+	*original_creds = override_creds(new);
 	return 0;
 }
 

-- 
2.45.2


