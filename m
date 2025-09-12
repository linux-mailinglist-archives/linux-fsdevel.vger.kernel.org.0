Return-Path: <linux-fsdevel+bounces-61054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD14FB54BE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DC71CC55A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8E30BF52;
	Fri, 12 Sep 2025 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqqP0RFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C3303A3F;
	Fri, 12 Sep 2025 11:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678033; cv=none; b=Z2FQjr62l0zlgunpxYTEcOaGEKnPABHwT2DZvHcXbmFKVGwfwKcdlKfKOvI4SEwwxOteCDzmtV+aTXyefqbwFEciPUke3EDAqng7wrt7DuwIytRDfbkd1TtvI+o0xYpeUGCXrjIcW6rnv1HruomoOtXEGy1X0cZKC8rGm5FRm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678033; c=relaxed/simple;
	bh=IMSdktbk/DR8t5NlQtvmlTG7SEp8nxV5MJXzExjap+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7GYw0rCztmeYBf496PLU5tIkXHXnJMGkLJORlcQU2wY3k5aXBEcCNsEYpk/Eya3uK7JUmi/m7hiRICFClWVN9Ojx2KIquECr1MU0TMQmmfoHy/SWZW4LMwtobsvDenpWqUsbYTz13s7Y549z53PhbKQfFBi+t4noXt7OhCOQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqqP0RFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06E8C4CEF9;
	Fri, 12 Sep 2025 11:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678032;
	bh=IMSdktbk/DR8t5NlQtvmlTG7SEp8nxV5MJXzExjap+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lqqP0RFDnQ1WWNmMD4oDJdnHi0k4LWfyJq0Q+FB3RVYb7+hn0oUjvdi62T9viuyjO
	 mnQyliV0tDTtTyuZfjriLXU8c+OJaKXv4NPtcY2gMEeZhSI0NpzPnGNqexz9VyHL7j
	 LQnfhXOMBUlvn6A3jnknigdN+6rZf2vhgImbu/BBkrHcFNvlWQZBELiH0/NCUVzlIl
	 B1jmaVYnBLSFHn3EfGUWbRnY4uUFJ1heBh2BIeYRcb3FZLsQznBxswKHvy7xY65b3h
	 rwezn5ZClj7PxkuIG1qcHAX0RIH9kIhUGC6sG7ppNrTkWlhAIOItE+DLQfLv4fJ3ch
	 eD02Cj4lF2uWQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:32 +0200
Subject: [PATCH v2 09/33] ipc: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-9-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=778; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IMSdktbk/DR8t5NlQtvmlTG7SEp8nxV5MJXzExjap+s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4ZwS0rvl7fwJx/IXLmop0U3r0z3zP5MhI2bBKoN4u
 wW8yyZO7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIfDXDP1uBm1N37j/6kFNU
 IvhElcDqn3uqShvLu9/4Na2YNzno1X5Ghq8rooPSF4nMcn5+f79UW2bx1Cx3hQcH2s8/nSyYF8c
 myAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 ipc/namespace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ipc/namespace.c b/ipc/namespace.c
index 4df91ceeeafe..d4188a88ee57 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -61,12 +61,10 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	if (ns == NULL)
 		goto fail_dec;
 
-	err = ns_alloc_inum(&ns->ns);
+	err = ns_common_init(&ns->ns, &ipcns_operations, true);
 	if (err)
 		goto fail_free;
-	ns->ns.ops = &ipcns_operations;
 
-	refcount_set(&ns->ns.count, 1);
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 

-- 
2.47.3


