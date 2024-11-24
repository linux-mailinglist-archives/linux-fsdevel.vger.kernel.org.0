Return-Path: <linux-fsdevel+bounces-35701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009289D7308
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA36A284EF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B72212EE1;
	Sun, 24 Nov 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKIJhUru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C29A2101A4;
	Sun, 24 Nov 2024 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455910; cv=none; b=CTPeVtez4iK7nJ3Aiu5bHn1YvvHGXcOROn42J7XH+YW+b+kcDp0PPtufeu80+3Iaz19O6PsBULwG1KEHkixS+YqwILC5MwPYH7rqOsdSQ7N6WqjLf8uiI4f1jBAMZsQfp2PvlshUCQruRgeR2RAcpFR5FFi9kwxjY4xQ+PtCpV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455910; c=relaxed/simple;
	bh=Cxwbe8QlWEJJCmaXE8xmYnN+TJILRMFJ54WvDGDeDgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h60lLVF5dW3VUU1chpeVNfKBugPosygoPTn5jVRLAHx98aH0SKYReov/1xfoQ8Q2KCrtiT/dbgRcG6KxXP0C+M+HPXAnnSeWf1F/ux8rIDsQxMcj4oU3iO6v5qPePl2E3e9GI7mkDttMhgLGbzjmWXS5wkYK55aY1tJlGWOpR6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKIJhUru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D452C4CECC;
	Sun, 24 Nov 2024 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455909;
	bh=Cxwbe8QlWEJJCmaXE8xmYnN+TJILRMFJ54WvDGDeDgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iKIJhUruV9FeRFuGmVYkwumvyPUoLtWv3jgJYbB3e+J11oJiJU/NH3j6HndXFyElN
	 gggNjGqrODywtdKxENqvzPTK5SYCKjggqaxDVVLtAK9nn0wcEZc7Lc/87TQt08IZBB
	 SXhSYB9ZSH0WG0HddoUWcSRIqg02DVuVGq/av1EcGCD07GYw7EuGzZJ0XU/JQWIkFA
	 thOBUYbLTACjB4qsh3IrvZmTHJT2rMiMulA9BTSykNKuYZuhfsKYsKgz/AaQFsIITK
	 eFC500+kLaUDZjJzJLmPaczZwnBJLGNnw/h2ArEz6oGtO+65QNgD0GkldqzDwsnoI5
	 B3BUaYR8qtlOQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 26/26] dns_resolver: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:12 +0100
Message-ID: <20241124-work-cred-v1-26-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=brauner@kernel.org; h=from:subject:message-id; bh=Cxwbe8QlWEJJCmaXE8xmYnN+TJILRMFJ54WvDGDeDgs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76y6uD0w3PaB1pfvlnc1fYutrr73SVQszd1pi4PT09 OEvRyYt7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI6iiGP5xdam/3P0x4yZ3u kuNRXKslsrFcQnvazZPnuSwFRX4GmzH8zzmhtUhI5f5rtWLb96FdexnO/Dotl5nDkmky8ciyyTy cnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/dns_resolver/dns_query.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/dns_resolver/dns_query.c b/net/dns_resolver/dns_query.c
index 0b0789fe2194151102d5234aca3fc2dae9a1ed69..82b084cc1cc6349bb532d5ada555b0bcbb1cdbea 100644
--- a/net/dns_resolver/dns_query.c
+++ b/net/dns_resolver/dns_query.c
@@ -124,9 +124,9 @@ int dns_query(struct net *net,
 	/* make the upcall, using special credentials to prevent the use of
 	 * add_key() to preinstall malicious redirections
 	 */
-	saved_cred = override_creds(get_new_cred(dns_resolver_cache));
+	saved_cred = override_creds(dns_resolver_cache);
 	rkey = request_key_net(&key_type_dns_resolver, desc, net, options);
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 	kfree(desc);
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);

-- 
2.45.2


