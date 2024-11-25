Return-Path: <linux-fsdevel+bounces-35810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6599D8785
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C119168AB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE321BD01E;
	Mon, 25 Nov 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSD8Rbki"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E7F1AE863;
	Mon, 25 Nov 2024 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543851; cv=none; b=uaTHfnDqO4O/yoMt73uFUeMNE5+zGC2C/FsHdhfsssQNPn3nZxD8DhoPT/wEEV5JS2pOpPEOqtAPqbxJaS0WdZf6t6AeGR2SXvr0stT++Gs0XND2WFTr99T0PNo6ohjADqzkxhRdYTkzej1vAieZACSpnptLQlTyvtRH1iUeVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543851; c=relaxed/simple;
	bh=Rvk44iZBpENZz5Rsbf1pzREJ1lmJXbhsL9AmhwrlzhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PV7z+JfOymq+3hv2VY5ie5pD5tD2WtJ6mtiXInGtazSXlpMxcu8FP+NV3+V4kvZHEeMV3szbqeEFCskDPkKEF0oqCzdS8LtqAx3Wn4xZlMh6+r32X8lLsR8lN2TM1UzlJB+D/PDHG3GZvLsUf16Ia5glWCREHuocoo+nZDlLMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSD8Rbki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46328C4CECE;
	Mon, 25 Nov 2024 14:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543851;
	bh=Rvk44iZBpENZz5Rsbf1pzREJ1lmJXbhsL9AmhwrlzhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nSD8RbkigLl5JW7QhY+CMPUAsZn83xm3zgUJeVigDUcpTKYXL+hsXxtN4CLjj04E3
	 49LTmjAIhjXGojv5u4Ud+jSTbvcD+s738e4IrIgx/h6JmP4SlBdMSuVdqTM89mx4fS
	 WxRKwODRfSw+s/KmkV0CjX3ScUEb4Cs8BLmj236WB7FU7qOSYcQ+lHIp3GkDsSN/wV
	 wyBY678rFAxs3GCXsjSFPoaCwYmtuTildqDMWNFBCFGMrQCDe+Y72AvVUOxnCHlxB6
	 VtNpaG3t9Nzabf5snuD+FQZ+6h3YVkfPnB6RCUkpnVdKJyLVMtq7+8UHPT7E3MMXo2
	 kwyQioNf+SW0w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:09 +0100
Subject: [PATCH v2 13/29] nfs/localio: avoid pointless cred reference count
 bumps
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-13-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1525; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Rvk44iZBpENZz5Rsbf1pzREJ1lmJXbhsL9AmhwrlzhQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHreffHXt+jT3fZw+SVx+ilx17+kZ3748SfaSHJ+3
 fL4xKdZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5ZcTwv8Dle9W73bnnNqcm
 805vvsn7TKH6mtnHhIo07v1thyNcihn+R/uaScTdenzmn/ky99CK4+0S15nyShsY5wu5910OEbn
 CBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

filp->f_cred already holds a reference count that is stable during the
operation.

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


