Return-Path: <linux-fsdevel+bounces-26491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DFE95A20D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 17:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4257C1F2185E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCA61BAEE4;
	Wed, 21 Aug 2024 15:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz87APxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B458C1BAED5
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255286; cv=none; b=ukCdxwKGVHBdfdhOfLstmK25K3oYHQX72D+Yopu3XX3l9kfwcqLKwj4ORVkvXaPrp1LRk8cLgiipMAPLEPu7ZAZGCKuhyo+NxGwsGbk0ZbVEqgjBR3HcuJon2hectV0FR6CEsJTpomGAhnLu2/0X7I/2qyblgLhNbPxVrCv7PiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255286; c=relaxed/simple;
	bh=/MxpcQxK7vm+zOfGllmfyxOEpsgsb6y/adQKarv93bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qYvvlF2Tk8yX0PxMqu+pUlKg4VgzQISFNpmX/sR4rtX4aVO0mgVdaOs2Q2ut8mbp2kzohDP7xZejoWRnRlBWjaUBhbrHQv9YPp/u5draX1gnoB4RVQ+++xY9guB5Qro/epIuMzYIn+khY4Jm51z/jJNwmwQkt8mfrUiLNSv4cCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mz87APxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62016C4AF0E;
	Wed, 21 Aug 2024 15:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724255286;
	bh=/MxpcQxK7vm+zOfGllmfyxOEpsgsb6y/adQKarv93bU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mz87APxuZ73OhhWgRRaI2ugaB3kxEvqXD5VIwb3ItdQ4aic5gWMVaJ1d290L+BhzO
	 WCzzZypz+Q4hTp/3PgYvhGYUvaD6+jLGN9FGmMQC1roDw0CpBY/mtrxuhGsgNXPg/k
	 kc4Sz3ByTe7ohtX5qE8AChqzUSFA8Q8xfR1nkRFRgS80uLGlnwTlWfCWn8PF5mbXEN
	 UCTPvTqhwefBNCLAc9N7ljglM1eJ0hFQ2RBGLHkggGdyonniW3U48nv1iuM1gQTDHt
	 8HFvUhrPoOc84KWHDSSTOHNlagj0rQOs/XlfDSJ/toCGRUgeqFEUql1v/E5IGMdOEG
	 BWWMLf/gQIwOw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 21 Aug 2024 17:47:36 +0200
Subject: [PATCH RFC v2 6/6] inode: make i_state a u32
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-work-i_state-v2-6-67244769f102@kernel.org>
References: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
In-Reply-To: <20240821-work-i_state-v2-0-67244769f102@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=677; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/MxpcQxK7vm+zOfGllmfyxOEpsgsb6y/adQKarv93bU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQd41HVXlcj1R66MzFYT+S19ydvlUuiUq/qT3jcfyJ33
 2aK5K9dHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5LcPIsIVt5RPmp6yfeXaf
 a2S8IbtLaPaTnG0NhyW2rTjnut61byHDL6bEGSJ7RNS3MJS/5fi7mn1djtDiq7Jfq3rO8jvFmEx
 NZAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we use the wait var event mechanism make i_state a u32 and free
up 4 bytes. This means we currently have two 4 byte holes in struct
inode which we can pack.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8525f8bfd7b9..a673173b6896 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -681,7 +681,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	unsigned long		i_state;
+	u32			i_state;
 	struct rw_semaphore	i_rwsem;
 
 	unsigned long		dirtied_when;	/* jiffies of first dirtying */

-- 
2.43.0


