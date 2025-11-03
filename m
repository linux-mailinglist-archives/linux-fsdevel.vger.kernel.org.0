Return-Path: <linux-fsdevel+bounces-66742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9ABC2B63F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5CB18967F0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D54F309F09;
	Mon,  3 Nov 2025 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6WkkxGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F56A309EE1;
	Mon,  3 Nov 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169254; cv=none; b=pgtnadJtNGd5a1GxIRocqpoUzWmw1UpoDYQFXotdOxnulGGv0WK3N2YvpObhTK7+YjIGKZd9x+JYpCBwqNa31UbgVLUOTEWaL9FO3/N0/YNu8m7qWuhuGqRZBb5WSufhdn8DXryg+R6PoVcoBa8Rh/m0ovJY1VezZONh58Pi4b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169254; c=relaxed/simple;
	bh=rKQ/y4Od9YwZy6lC+CZIwz4HC5HTRvkb8TpxPddq1Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mo7KmbCQar3y+VnvZrBt2pwSb7nQEY6CiG2X4m0pzpsrVEhXULAnYO5DxsoLOIyFoXF8S5vGMwu6/d+vYbVefbNVOkmPLTiRXh+eXwW4thLA+dTnmNf7afTmKF4HAi5Et8jmNtztwsRE5c2pz+2hvzEaSZAzgzMBlwhx+9WgWts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6WkkxGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB8FC4CEF8;
	Mon,  3 Nov 2025 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169253;
	bh=rKQ/y4Od9YwZy6lC+CZIwz4HC5HTRvkb8TpxPddq1Vk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U6WkkxGTZLtlnNdBQazDAtsgeorAhuV5hDik2pKTcqsbl3AaR8l1x/LcjhuAqzZmM
	 FnUljnz4oNoibMK6CNcTsI4Cmk8GCZDxmUgQLJpGu6LNbAdK3eBHjjmQmzO+eiozl6
	 LSrtXCRVfTPH0uCruRfXoi/ShDZVsvqVitWm7iob2y3dvUuZXBE+KFlybomgbT1jZl
	 FiQr9dcZVjF6Q77JMbh+SdH48QAgj635490LAFLfFWZTbB3E61HjQO2q6btJFVZXXv
	 JEtz2qOaA5A7hFtdB/OapYZMe47sQxmIQQAfCj0yV1hphNgVui5vZ4o+rXxARtLPvx
	 xGUBJ68dEzFyA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:57 +0100
Subject: [PATCH 09/16] erofs: use credential guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-9-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rKQ/y4Od9YwZy6lC+CZIwz4HC5HTRvkb8TpxPddq1Vk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGwvdjrU7i51dLfjOt7O6IIJCSndv3gerc31srrjL
 W3fKHK3o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLK+YwMJzeedL6l15ZWc+Rc
 huX+xWsVps0+7X4xPfcr3+sHt++GCTAyfPgWIblbax3XPz3/q2cNb1f6+T3fwW7ZOHnP15KSP9x
 rGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/erofs/fileio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index b7b3432a9882..d27938435b2f 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -47,7 +47,6 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
-	const struct cred *old_cred;
 	struct iov_iter iter;
 	int ret;
 
@@ -61,9 +60,8 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 		rq->iocb.ki_flags = IOCB_DIRECT;
 	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
 		      rq->bio.bi_iter.bi_size);
-	old_cred = override_creds(rq->iocb.ki_filp->f_cred);
-	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
-	revert_creds(old_cred);
+	scoped_with_creds(rq->iocb.ki_filp->f_cred)
+		ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
 	if (ret != -EIOCBQUEUED)
 		erofs_fileio_ki_complete(&rq->iocb, ret);
 }

-- 
2.47.3


