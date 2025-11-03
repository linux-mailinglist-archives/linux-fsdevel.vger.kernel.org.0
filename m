Return-Path: <linux-fsdevel+bounces-66743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C31C2B635
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C87C3A1709
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E230ACE7;
	Mon,  3 Nov 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUPKtFV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391F309EE4;
	Mon,  3 Nov 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169257; cv=none; b=Dn1/cUfz06idotqjdkYqDERUiIfMX3F58Rgjskx3bDKPN+UmgDyvFehVlYMJV4MLS1/CZZJukFkCSeGIlpRTyZ8kGl4iRUrIQn/HS9V0ytmqO+FcvdXFtkD9EnlwN444GD5S/TnCUJuui5/weussEauYQOzZuKbvoY2M8IWE+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169257; c=relaxed/simple;
	bh=Dmlif8BKtwQInPdLdn5bmZmsNB9JrY68RKP9X41cJow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTEa2ulo9HSbbr8hzkCPNeeBaINjqBS8cQZZk1EZUWNbXGsEvZUKAb7zh4gI9J2Lzmaz16SH1QUhIQc5t5PuNjzwZk6JztDnkGcbyyRH5jvjoops6zmjmp/DFt/CvPXumt2JMvEGzcuMOS7ZcbezOMOLPsqjxwphcdKbxnn9h8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUPKtFV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A7CC4CEE7;
	Mon,  3 Nov 2025 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169256;
	bh=Dmlif8BKtwQInPdLdn5bmZmsNB9JrY68RKP9X41cJow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZUPKtFV3jOi39pVhMoqR8e+UPRvD8cPvGK/TkNTy8vTll6Oouo05sQCrhw0nfZDPU
	 s/jAhMT0H65hYbdhOeiQsxtVsMu2oucHMQDOrDCEgqIFKjvOArwVTj8WgZCS6WFiCK
	 39I4k2MygY4lp/9bXa20yBCHpwDKravlvwx76sjTw87aegmCG+byCk1eMVdNGNiHqr
	 OHcnSv4HAzT9yLtfFWHoxlCZUMAqe8rUAmhrVmli9jWYvaKUerYjqdhL1D1nTKJ68V
	 vZ3TmrcA0bbjAy30X9+q9DMuC7dsyD5S/UzDlGW3QS4t7q0Ztr6NeHeOg0KpTkY4RS
	 fk/zNlNTamaDg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:58 +0100
Subject: [PATCH 10/16] nfs: use credential guards in nfs_local_call_read()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-10-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Dmlif8BKtwQInPdLdn5bmZmsNB9JrY68RKP9X41cJow=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGyvbex6eulmk5e9TU2E55ZKDuFyts3v7um+t3b6t
 Hr52vMKHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM594mR4WpZv4bwwY7YjsAH
 WcGLKz+8a2Bepp/NKm93q73nZ8Kxuwx/hZS+es9b9zIiqKb7TOm2x+5T+/mNXhjklOs8fJVioju
 DHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfs/localio.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 2c0455e91571..48bfe54b48a4 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -595,29 +595,26 @@ static void nfs_local_call_read(struct work_struct *work)
 	struct nfs_local_kiocb *iocb =
 		container_of(work, struct nfs_local_kiocb, work);
 	struct file *filp = iocb->kiocb.ki_filp;
-	const struct cred *save_cred;
 	ssize_t status;
 
-	save_cred = override_creds(filp->f_cred);
-
-	for (int i = 0; i < iocb->n_iters ; i++) {
-		if (iocb->iter_is_dio_aligned[i]) {
-			iocb->kiocb.ki_flags |= IOCB_DIRECT;
-			iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
-			iocb->aio_complete_work = nfs_local_read_aio_complete_work;
-		}
+	scoped_with_creds(filp->f_cred) {
+		for (int i = 0; i < iocb->n_iters ; i++) {
+			if (iocb->iter_is_dio_aligned[i]) {
+				iocb->kiocb.ki_flags |= IOCB_DIRECT;
+				iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+				iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+			}
 
-		iocb->kiocb.ki_pos = iocb->offset[i];
-		status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
-		if (status != -EIOCBQUEUED) {
-			nfs_local_pgio_done(iocb->hdr, status);
-			if (iocb->hdr->task.tk_status)
-				break;
+			iocb->kiocb.ki_pos = iocb->offset[i];
+			status = filp->f_op->read_iter(&iocb->kiocb, &iocb->iters[i]);
+			if (status != -EIOCBQUEUED) {
+				nfs_local_pgio_done(iocb->hdr, status);
+				if (iocb->hdr->task.tk_status)
+					break;
+			}
 		}
 	}
 
-	revert_creds(save_cred);
-
 	if (status != -EIOCBQUEUED) {
 		nfs_local_read_done(iocb, status);
 		nfs_local_pgio_release(iocb);

-- 
2.47.3


