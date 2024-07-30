Return-Path: <linux-fsdevel+bounces-24561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03719940759
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20142812C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E277D19DF94;
	Tue, 30 Jul 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7fiDf8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBD919D8BA;
	Tue, 30 Jul 2024 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316514; cv=none; b=GSSPtQ08lAuMgufpRbR4jaXgAbpDcngzB5t/Z6UxPMAi/tqZaks4j++16n9EOMUL6CrkKBZ4hD9CK2eUuCU8jgSGG97slUDGPjABV7qfq9LM5JV0bOEJtWReUpVhV8focup5UqjubtXv5pdll5NesjGD/BzmSlHmmK/gqxvLe6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316514; c=relaxed/simple;
	bh=uiUF9HEX5eCVsiP9+hLBCcD/JkzF29pvDqW2oCvBNhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1rCj2b46xlTWYXDN9eHzkymkBZXYSkFFEEv1L9ppUscdRn8eltlaPAEQ3O1x3WCqZggJOpRZCcBGfeBoOkBK7mSULWwijlUoLyjiN+GlBzn6kiwsVi035XVa/BYC0h8MkIYYJ70LY0FhAL427Zzyp1BZoLY4VSMWPvzvWEinHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7fiDf8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591ABC4AF0A;
	Tue, 30 Jul 2024 05:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316514;
	bh=uiUF9HEX5eCVsiP9+hLBCcD/JkzF29pvDqW2oCvBNhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7fiDf8rqips6xmBjYbjy9tKV7JsHte2D8eO3tu3kTxTIE5u7iQBhfCXcgWXJ0CAh
	 MPpwh2yUkt4mR7jRbZptscH2szDwLNhKf2xieia88QKz+XaUtn7e6d7y+Wu7ode2K1
	 ZlmVM5Aih4ffmR+mKpK2t/5nUCaTTHhl3iUKsQ6b182iBO9+yZ/9S8avayFtpBxVyR
	 W4VGZ13Bn7rYyom1tfe2SdElQw5mr16hUB06QIzUoKWRsAX4wk7ncCBEs+7FpGaq9X
	 lvSjZQq+UKa3IivUNyw6Rdmgkk0m8WsP6qhMJWRQ8w3NyPcYBVCynd/G0AJ4yWXH4O
	 XB8O20bI5VTcw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 29/39] convert media_request_get_by_fd()
Date: Tue, 30 Jul 2024 01:16:15 -0400
Message-Id: <20240730051625.14349-29-viro@kernel.org>
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

the only thing done after fdput() (in failure cases) is a printk; safely
transposable with fdput()...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/media/mc/mc-request.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index e064914c476e..df39c8c11e9a 100644
--- a/drivers/media/mc/mc-request.c
+++ b/drivers/media/mc/mc-request.c
@@ -246,22 +246,21 @@ static const struct file_operations request_fops = {
 struct media_request *
 media_request_get_by_fd(struct media_device *mdev, int request_fd)
 {
-	struct fd f;
 	struct media_request *req;
 
 	if (!mdev || !mdev->ops ||
 	    !mdev->ops->req_validate || !mdev->ops->req_queue)
 		return ERR_PTR(-EBADR);
 
-	f = fdget(request_fd);
-	if (!fd_file(f))
-		goto err_no_req_fd;
+	CLASS(fd, f)(request_fd);
+	if (fd_empty(f))
+		goto err;
 
 	if (fd_file(f)->f_op != &request_fops)
-		goto err_fput;
+		goto err;
 	req = fd_file(f)->private_data;
 	if (req->mdev != mdev)
-		goto err_fput;
+		goto err;
 
 	/*
 	 * Note: as long as someone has an open filehandle of the request,
@@ -272,14 +271,9 @@ media_request_get_by_fd(struct media_device *mdev, int request_fd)
 	 * before media_request_get() is called.
 	 */
 	media_request_get(req);
-	fdput(f);
-
 	return req;
 
-err_fput:
-	fdput(f);
-
-err_no_req_fd:
+err:
 	dev_dbg(mdev->dev, "cannot find request_fd %d\n", request_fd);
 	return ERR_PTR(-EINVAL);
 }
-- 
2.39.2


