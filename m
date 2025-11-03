Return-Path: <linux-fsdevel+bounces-66744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3F0C2B6CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1639A4F5B0E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1AE30B513;
	Mon,  3 Nov 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0ftDU25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934930AD12;
	Mon,  3 Nov 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169260; cv=none; b=FatQ5fVFCQRkZG79TV6+/hB5ast+aLMuuomA5ymeCqgICAKOgr1qy94KCpB+ezXVveoiMxkiCNFFMVLYz9OVkreSX61Kp0guP9j27UpCPzJOUoSgpFCyutMj/4q/pvRXLo/Ltf5pFG95y/vUeL9DMEFFuyqBsujz0ZgwVjAMz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169260; c=relaxed/simple;
	bh=S5SWhHP1AKnpAS9cvNavzXbz6fN+yKJB66DWhHiIX8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZX2p5FcJYbUR1Ner0Jd1QllklBOmZKi/fsPUYva5g5D1x5GQHYUfS8vKgEU8bZb4mIn3vsvnZ82TPDnnWCJcIPiSUnvq8+yb2v5b5LWw/ykzKA0vWVwDueeiYMf2WiVwpRuRf9soPyP2VjefFpp0u27b3ygjezwO+Obyw06d4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0ftDU25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48643C4CEFD;
	Mon,  3 Nov 2025 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169260;
	bh=S5SWhHP1AKnpAS9cvNavzXbz6fN+yKJB66DWhHiIX8U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O0ftDU2583umsexJKbRZVn9zJiuCwK3OrzAB25iAlfQ7R7sQ3Wg+ni4/AJfDhnhjG
	 4sDpwHzKXBwubFvBfYWQMXDlKurxb2ZgEJ79NWi4SCcFCXm+zWmu2LuA8Tqx7G/IOY
	 7sPCsPHcSWjteCW4PWnclWDwdP9tGopfXU8zy72JJ8O9aN2A/pSkwH2dtX13myu8Hh
	 IhxXoJ8ywUtbTTYpubuBigy2vviCiWcKk65gjwbfPw/ciGpKjVC3DO8s5l4z0fblkX
	 5KOX/B1Zv8juI/9V1O/vLt3bfgwjTw+pxFJ4697kdWV1JOXmUS4OCoxuuX1ZVlQ9w6
	 vskR40Jqe+pRw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:59 +0100
Subject: [PATCH 11/16] nfs: use credential guards in nfs_local_call_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-11-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=brauner@kernel.org;
 h=from:subject:message-id; bh=S5SWhHP1AKnpAS9cvNavzXbz6fN+yKJB66DWhHiIX8U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGy/fqQ6cGfSIttn8vfUa1PqJGbNeRPqc9AtXFnob
 Umq+DPljlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkEpTIyfDkp9167567kgjTx
 sybv0n+tLPm0yiJlToyM+hQ/j+9WwowM17SSNCR0XDy0jbrcLXwm+AmtYerabNC6nH3apOAdm/w
 4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfs/localio.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 48bfe54b48a4..0c89a9d1e089 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -781,18 +781,11 @@ static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
 	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
 }
 
-static void nfs_local_call_write(struct work_struct *work)
+static ssize_t do_nfs_local_call_write(struct nfs_local_kiocb *iocb,
+				       struct file *filp)
 {
-	struct nfs_local_kiocb *iocb =
-		container_of(work, struct nfs_local_kiocb, work);
-	struct file *filp = iocb->kiocb.ki_filp;
-	unsigned long old_flags = current->flags;
-	const struct cred *save_cred;
 	ssize_t status;
 
-	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	save_cred = override_creds(filp->f_cred);
-
 	file_start_write(filp);
 	for (int i = 0; i < iocb->n_iters ; i++) {
 		if (iocb->iter_is_dio_aligned[i]) {
@@ -837,7 +830,22 @@ static void nfs_local_call_write(struct work_struct *work)
 	}
 	file_end_write(filp);
 
-	revert_creds(save_cred);
+	return status;
+}
+
+static void nfs_local_call_write(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+	struct file *filp = iocb->kiocb.ki_filp;
+	unsigned long old_flags = current->flags;
+	ssize_t status;
+
+	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+
+	scoped_with_creds(filp->f_cred)
+		status = do_nfs_local_call_write(iocb, filp);
+
 	current->flags = old_flags;
 
 	if (status != -EIOCBQUEUED) {

-- 
2.47.3


