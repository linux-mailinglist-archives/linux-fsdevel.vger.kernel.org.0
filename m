Return-Path: <linux-fsdevel+bounces-60789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD6DB51A03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0301B23873
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7BC3568E9;
	Wed, 10 Sep 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7D27ayK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D93314CB;
	Wed, 10 Sep 2025 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515116; cv=none; b=L1akY0QSgZZ5tmd9n1B7zLlMF8VoxY2JRSuzHeVVKptPOM5/OUYiZvvVUTKjfwlJgCQSTvozzICpsTriGSj7JvT7qegGJQxroJxWdeh1ebHMxXP7CkasTMNEd9H+mHNuyBzjiCoqzvqJDVI11zsslqyKTiVy7hhSy2Od4ArW2e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515116; c=relaxed/simple;
	bh=UnI5m7SqHWsMxkZIWEiFZAf4ouVfPgpP2czPm9uoPxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qsbOFqZ2m321eITe+ipIqJDRg3hpA8jlE01vWH7TV9MKhECCeZRZ5mC6wgvL2rOE25rxTFRC/z22xvw9hBoXXA6PcU97cOWbbhp8Qkt9C8R8AoCjlEFXlegzXkSIt7k0zoNqZdU1YXmg9fuUOUzy6JNBD06ZcPy1pCYtZprJd6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7D27ayK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08346C4CEFB;
	Wed, 10 Sep 2025 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515115;
	bh=UnI5m7SqHWsMxkZIWEiFZAf4ouVfPgpP2czPm9uoPxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s7D27ayKL2ko/bOsxxIYGseQoCeIRO0vBs6zyp95hOSVeVYiG8aXuhPWyKoDfJjQ5
	 hvk8P5uyqLkLt8imKU53ABEBWZNgRKn18z3e0eYsPPdpgufZdI4xAQYsbvY7Cxgd92
	 5p1L9eAWZmrQ7XSSPAoMWj1LyuumDfrmCYhoNnu7tpvHWQ09uDoEiAva4iRv2LjctR
	 bO/FGIbF3rG2aG0SwxVJJeN6Wh3mEwbvFiTLAymj3zIJ02afHyDX4AucKPby0xxTO8
	 at/XTK4vDBYvzjBIu0XalEiaPR3s4jqFbveFLms55G3WmiKdWgwklqqGEr4YdGETnE
	 vZHVogV27V77A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:00 +0200
Subject: [PATCH 15/32] ns: remove ns_alloc_inum()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-15-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=711; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UnI5m7SqHWsMxkZIWEiFZAf4ouVfPgpP2czPm9uoPxs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OUQM5ud87fs/cWkSx36k6uyOnYvu6z9IunXc1+D+
 HfhPE67O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayyZXhf+HpmZ+SA6at8V4W
 npuhMtOC87Da5ScHRKL27y+SMFWTeMfI0LVH9+LGQo0k1e5wRmdDDr/Em2+nqvZ9DJ8YwDk3fFk
 mJwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's now unused.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/proc_ns.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index dbb119bda097..e50d312f9fee 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -66,12 +66,6 @@ static inline void proc_free_inum(unsigned int inum) {}
 
 #endif /* CONFIG_PROC_FS */
 
-static inline int ns_alloc_inum(struct ns_common *ns)
-{
-	WRITE_ONCE(ns->stashed, NULL);
-	return proc_alloc_inum(&ns->inum);
-}
-
 static inline int ns_common_init(struct ns_common *ns,
 				 const struct proc_ns_operations *ops,
 				 bool alloc_inum)

-- 
2.47.3


