Return-Path: <linux-fsdevel+bounces-21236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13AF9007F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25381C2372D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7E19922E;
	Fri,  7 Jun 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYbYX05r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72954660
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772157; cv=none; b=OCcLUukHPlWtfLcr+UE65smigGJCSW78u6Gn+pSUDaXCR//KqSOKBNkDMVj74/eOF8R2lupxqSkT9vwAashMgyBEDpn9XICNkegH0zLP72Zk7/JWqj+HFE9bsKnWeGj9luCk2aTFYc24xl4kH5CHLv0dV+g2h73pExdMOzr4Wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772157; c=relaxed/simple;
	bh=SQAhfliB9A4fi4EiiOt7HGCAdbfU54EMw+aMNpy4EF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VawGgGRnLzBPLxOrHuoxY6r9QfiRfh0fhB/pe1T0dNGTnOIEv9IBz5YWX0M/eI5JMeKe15m05ax9JnYsvWTz1SICkeGJ8wr++KXI2xZ1dhV/6n0FW+MrtaYpfRzylFe8Mk533Oe8ASjWEP72lvMl7IBQObQMIbOKWHrgmvTX/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYbYX05r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB11CC2BBFC;
	Fri,  7 Jun 2024 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772156;
	bh=SQAhfliB9A4fi4EiiOt7HGCAdbfU54EMw+aMNpy4EF4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EYbYX05rLGzBk0f+9Qz6fvMqJJfP18RuyTl7yMbpW1cWxuruRxYEpNT7sgEt7aDFb
	 CdMcjoH7mlgAGEfezzxhoBPrW0Kqg77jYwNPHxJb8FCGUQ5g5B5oO4w1Zyy5NaOimb
	 /sDvUqHtPuX2L7K6dbrSraFp5Hw9sOwKy0WkSbXMXn6QAGZ8yy2/QuKdZk8CTsMnfw
	 VCbkyYuGCD0D3NqL4tmGvyqWhl8Q7+diflsBFHlWFFr33tuSdOGFdvZfAs4Tprq1fP
	 01GDuDZWlTCV+jIOqABv+W0yldcVRxjoTgTWUIxL+J54JYiCHKeMb7tjmoAof3Si6G
	 zvuvH4PCgJPXA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 07 Jun 2024 16:55:36 +0200
Subject: [PATCH 3/4] fs: simplify error handling
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-vfs-listmount-reverse-v1-3-7877a2bfa5e5@kernel.org>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
In-Reply-To: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14-dev-2ee9f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SQAhfliB9A4fi4EiiOt7HGCAdbfU54EMw+aMNpy4EF4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQly5fVTbM1n7bCTWcHt8c8niVMD413ZTDOLVAXV59Te
 3lnv86HjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIncP8Pwzzy7aslGg5uc70+L
 HgznneK79xX/Z87PNvYl66+aamz8rMzw38d1z2SX23fWLNZorFgQJrV6funj9TyWD12Wv94tM9t
 KjgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on cleanup helper and simplify error handling

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 72c6e884728b..507f310dbf33 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5083,10 +5083,11 @@ static ssize_t do_listmount(struct mount *first, struct path *orig,
 SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req, u64 __user *,
 		mnt_ids, size_t, nr_mnt_ids, unsigned int, flags)
 {
+	struct path root __free(path_put) = {};
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mnt_id_req kreq;
 	struct mount *first;
-	struct path root, orig;
+	struct path orig;
 	u64 mnt_parent_id, last_mnt_id;
 	const size_t maxcount = (size_t)-1 >> 3;
 	ssize_t ret;
@@ -5112,10 +5113,9 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req, u64 __user *,
 	if (mnt_parent_id == LSMT_ROOT) {
 		orig = root;
 	} else {
-		ret = -ENOENT;
 		orig.mnt = lookup_mnt_in_ns(mnt_parent_id, ns);
 		if (!orig.mnt)
-			goto err;
+			return -ENOENT;
 		orig.dentry = orig.mnt->mnt_root;
 	}
 	if (!last_mnt_id)
@@ -5123,10 +5123,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req, u64 __user *,
 	else
 		first = mnt_find_id_at(ns, last_mnt_id + 1);
 
-	ret = do_listmount(first, &orig, mnt_parent_id, mnt_ids, nr_mnt_ids, &root);
-err:
-	path_put(&root);
-	return ret;
+	return do_listmount(first, &orig, mnt_parent_id, mnt_ids, nr_mnt_ids, &root);
 }
 
 

-- 
2.43.0


