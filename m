Return-Path: <linux-fsdevel+bounces-35688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605C49D72D8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E1C284160
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E2120ADD2;
	Sun, 24 Nov 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJqmTmSW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0820A5C4;
	Sun, 24 Nov 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455883; cv=none; b=RLiTbVr+vcU7ptT3To08fWmfObu2DD0xj6sYeZdKtpQ+VdYUotK7QDfgNNHAQlmwRH+/rVVKoodxcYZX0iyGl9Ga3kP3xx3gHD4yllAPYEMy/DN/kS1l9cKjy4obcOp5UuIpu0TRX3cLhJCU5dAwXnguHmo93DauG6N3uPNHFik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455883; c=relaxed/simple;
	bh=QzKXOaGTqarytwObmAB0KM5UViuc2HdStxVkwRWPnLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhxrV5Qztum/dXFgDGS8wwWJ/yV+vQs7HZFNdRQI96B5UrVqHRaWD8LyeSk6orFwcGEhK0pGrLS/ZmUhYNmR5eAcB0acc8Gj3Tkk07A9OG3LVuTLblNiHVLr77gEi7+lQsDV8FNi+p5X73UCotR4FIMcQewYQc0G4BJIAVv0qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJqmTmSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E6BC4CECC;
	Sun, 24 Nov 2024 13:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455883;
	bh=QzKXOaGTqarytwObmAB0KM5UViuc2HdStxVkwRWPnLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJqmTmSW7/AOqaKttw23UXMUZBmV281OmhEwoB7uLb/zPDrpNs0xqpsC1owkQoaBi
	 8ks/k/27Sp/xy9RLZBbN3Q2B3tA4QCTrLXqru4kmGuyIe/2zISFpDMHeOC6sAKu8x9
	 GIq+lCmDtcnqIOsDfQ1xLtkOYoEYb588yvobvhlirsPl8Lq/d3wfNzpdUGRTzEVkXK
	 SYRBDMbQ5oAv/iVUR5vRLlCh3zrlmplxU+ft9KWUK0WtinVQ/bfTIbyynZBpilawtQ
	 aKpF7nRLUzfpOyHd9MXLbuxRvd8348H2MFf+NkAxcdPeRSfpdk20M67h69K9udISxT
	 kMOYdgUK4GEGQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 13/26] nfs/localio: avoid pointless cred reference count bumps
Date: Sun, 24 Nov 2024 14:43:59 +0100
Message-ID: <20241124-work-cred-v1-13-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1486; i=brauner@kernel.org; h=from:subject:message-id; bh=QzKXOaGTqarytwObmAB0KM5UViuc2HdStxVkwRWPnLw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7685lUryd1ttdt4Xv/NHztdu2HDnP4DDzn9LyN6u+R JQmWN3s6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI/o8M/ytfhm+3FlSZmKQz MUd95aqGE0vK/zFe+Pi5TuvxQTP7+sMM/3OVUoLnxKr9s45azGHnaBzXJZIXX3ZENDbqDtfqC0G 3uQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfs/localio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index cb0ba4a810324cc9a4913767ce5a9b4f52c416ac..8f0ce82a677e1589092a30240d6e60a289d64a58 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -371,7 +371,7 @@ static void nfs_local_call_read(struct work_struct *work)
 	struct iov_iter iter;
 	ssize_t status;
 
-	save_cred = override_creds(get_new_cred(filp->f_cred));
+	save_cred = override_creds(filp->f_cred);
 
 	nfs_local_iter_init(&iter, iocb, READ);
 
@@ -381,7 +381,7 @@ static void nfs_local_call_read(struct work_struct *work)
 	nfs_local_read_done(iocb, status);
 	nfs_local_pgio_release(iocb);
 
-	put_cred(revert_creds(save_cred));
+	revert_creds(save_cred);
 }
 
 static int
@@ -541,7 +541,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	ssize_t status;
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
-	save_cred = override_creds(get_new_cred(filp->f_cred));
+	save_cred = override_creds(filp->f_cred);
 
 	nfs_local_iter_init(&iter, iocb, WRITE);
 
@@ -554,7 +554,7 @@ static void nfs_local_call_write(struct work_struct *work)
 	nfs_local_vfs_getattr(iocb);
 	nfs_local_pgio_release(iocb);
 
-	put_cred(revert_creds(save_cred));
+	revert_creds(save_cred);
 	current->flags = old_flags;
 }
 

-- 
2.45.2


