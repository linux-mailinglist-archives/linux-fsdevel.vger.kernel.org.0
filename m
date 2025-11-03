Return-Path: <linux-fsdevel+bounces-66811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE18C2C967
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452E21885B53
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED443314B8;
	Mon,  3 Nov 2025 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm5ipfPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38AE3148D7;
	Mon,  3 Nov 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181889; cv=none; b=B1UzWren+EAiWO3Cb+wvv2jNgPicMp6pPtA/G7YEK+AT2fp9dFSA8dp+7U14dNm3Ze+EF6N9DnLZsa7M8BpfKsWglT45xzEEaz5MHzxL2zi0anlc9S8/9AVUH9ets3pOESKstzJGtrWVwHfUdnp8znQJlFqtBuo/fbYQQHntS4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181889; c=relaxed/simple;
	bh=EP4X5ZOadtmMtGSodwXabbolR1oPbrjawwY7HhpdVyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lyY6+iowc9Z06/JIhs3nC1dGfk30W5Cim4I2i4gWf+6nX3AFAJ+lABZvOHx5n9ZIo1WwLliJ549NpXgG/BI3qUjzUmzNXqm+THRVpLsAwFP+iz7Y+zlnIpfljRKPJYBFlwuGvgrLaPnHVgu3OcJaCTKxL+JWvVDjiQS6SrA9Ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm5ipfPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39356C16AAE;
	Mon,  3 Nov 2025 14:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181889;
	bh=EP4X5ZOadtmMtGSodwXabbolR1oPbrjawwY7HhpdVyM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Rm5ipfPkZ5jOLNVd7v3x/bd/uiTsZuAeEfY3O1BbacTQ3mrXb++tbKrh3zNkQe1Ot
	 yLbfg3VXH7/HRMXuoqg57AWBiQTRY9r5VeQ5gVNQQUkMLGSX5zRwQcjqniDDbXM7Zi
	 8uT77iMIEoOWEH2GArUKwPp5sI23+tagAEh5Q0Lw0Dag8PY3NqLmB+JosSWOcqhodr
	 B/wzXIKtPZehf9KpsBMWEs7LrD0EONuhAA3cZtASk35iQvDjzdbQtru8V7jzgPlGVV
	 fPwok5yQBon3DDQgONY6xml7axr8vbcBYWidVXaQXSTbO1KVVpalPYw9wa4CSxPgRu
	 50yJso83WxuvQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:32 +0100
Subject: [PATCH 06/12] coredump: pass struct linux_binfmt as const
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-6-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=965; i=brauner@kernel.org;
 h=from:subject:message-id; bh=EP4X5ZOadtmMtGSodwXabbolR1oPbrjawwY7HhpdVyM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHpZkJ72rDJgX35OmNX/XUm22Z4y+3M884MOOq7sk
 lJ70zS9o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLJfxj+cJivjbN0+el3Ut7y
 1Hm51Wklp410S6P/bdLanhsWeCmch5HhlmLgXuNTbcff8Pf9OpA89d0T/U65s1PUpc/yZ349Jqn
 BDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We don't actually modify it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 4fce2a2f279c..590360ba0a28 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1036,7 +1036,7 @@ static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
 
 static bool coredump_write(struct core_name *cn,
 			  struct coredump_params *cprm,
-			  struct linux_binfmt *binfmt)
+			  const struct linux_binfmt *binfmt)
 {
 
 	if (dump_interrupted())
@@ -1093,7 +1093,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct core_state core_state;
 	struct core_name cn;
 	struct mm_struct *mm = current->mm;
-	struct linux_binfmt *binfmt = mm->binfmt;
+	const struct linux_binfmt *binfmt = mm->binfmt;
 	const struct cred *old_cred;
 	int argc = 0;
 	struct coredump_params cprm = {

-- 
2.47.3


