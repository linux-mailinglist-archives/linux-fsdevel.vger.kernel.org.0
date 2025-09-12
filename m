Return-Path: <linux-fsdevel+bounces-61055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8FB54BE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADFFAA0C51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5730C60E;
	Fri, 12 Sep 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWt41UFa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5B302776;
	Fri, 12 Sep 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678038; cv=none; b=sXP4wUEKtkcJLGUjwIzCIEJ4F1IFYiCVyqtKhHccxs4CZo4k18ZOCpuv9t+S8XkerQUBbUdHMiLnUJ2d/pgET22cQiaZSuFSB8wjbxb3JTKhOrpO1JA7NkTBmqm+Q58GWDFNsTbHSnG8Q+64TMhGqcCwGwbzeLJ8KghY72S3xH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678038; c=relaxed/simple;
	bh=Phd3HR/M3gw7fF5jYmjBxs2fmTqbxr/FmjNHOBEz7P0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+UELjkclPbkSH4DTNHKt3ugCFS3lAa6jr3Tw2mKA8zC4+YeaQB1yGIGHX6N8pjWMbgebsjvDvLMhVfdxNkeqEmjDLBEsr7oJmkYBohRy/to+5sbvnaMrBPc6K/8bnneUaR/EaUzJIoslC9q3/BJkWcuQfrHpzB1oik3t/di8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWt41UFa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CEDC4CEF1;
	Fri, 12 Sep 2025 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678038;
	bh=Phd3HR/M3gw7fF5jYmjBxs2fmTqbxr/FmjNHOBEz7P0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UWt41UFaKiwtDPLQlYrLzSe0j36OjLHQaLTRRBnvvkQDTqgVF1HJpm50FcZVgsEMT
	 NvZnwF3ytbSZEuhLSudhN100bfTKFuUl3T3wCQgsPUTqPC3R9lkFnY9LsACg+FtkSx
	 aFICWwISIv3iSSAL/ObPORARsmjCl3quOg4GkJX854VSte4oYxhmqJzpBtyhPJt75H
	 6PKcXGJrZbIjsVIyK+OIodS+7chBNqCCyzaQ6ixMBIpKxXo5d31kMaGosVbJtv/tN9
	 hGuFOnMJjOS+DgRhi6nzw5RsDI/Bnx6Ot6W2xDzFKVBt3Rn+HLX80Wb8e6sgB4zT71
	 xcIpDd7gmGzng==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:33 +0200
Subject: [PATCH v2 10/33] mnt: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-10-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Phd3HR/M3gw7fF5jYmjBxs2fmTqbxr/FmjNHOBEz7P0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zyy1/Lyt41fTm482Dm/SsfHvF35HWv860tS78xtz
 6XI5p/16ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIxUSGf9aTrTonfvzzfGoF
 58Snpksa+mLswn5NdK7iYWYJ/2F09wQjw+4T02a/nWS32SP/e3vaL9+/0iumXC8TvXro8BOLOVt
 efmAAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..14c5cdbdd6e1 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4177,18 +4177,15 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 		dec_mnt_namespaces(ucounts);
 		return ERR_PTR(-ENOMEM);
 	}
-	if (!anon) {
-		ret = ns_alloc_inum(&new_ns->ns);
-		if (ret) {
-			kfree(new_ns);
-			dec_mnt_namespaces(ucounts);
-			return ERR_PTR(ret);
-		}
+
+	ret = ns_common_init(&new_ns->ns, &mntns_operations, !anon);
+	if (ret) {
+		kfree(new_ns);
+		dec_mnt_namespaces(ucounts);
+		return ERR_PTR(ret);
 	}
-	new_ns->ns.ops = &mntns_operations;
 	if (!anon)
 		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);
-	refcount_set(&new_ns->ns.count, 1);
 	refcount_set(&new_ns->passive, 1);
 	new_ns->mounts = RB_ROOT;
 	INIT_LIST_HEAD(&new_ns->mnt_ns_list);

-- 
2.47.3


