Return-Path: <linux-fsdevel+bounces-60782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9DB519D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887894849BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962DC341655;
	Wed, 10 Sep 2025 14:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdjNU8KV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609331A540;
	Wed, 10 Sep 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515074; cv=none; b=L3y6V2a6+i9aH62UUVEAhPkEPvMRgSjGfN1lyupOBnwpT4bKHqa+qorc99Ms9U1UEb64ami+lnjT+jHvy8dLYsX2P1hjyYESy03OmHkgs1AASy+y0pCIcxwhQAi9XjoL0b7lHCGTcxkHROLIywhH0jo92+DQ0DP8ksK4f51UHc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515074; c=relaxed/simple;
	bh=NK6WI3X3NLXas2ddU8r5M1j0jQ0BhLKIUJlLyAEhkI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCzaRFVWRRGQ+g76fgdnvMItrkQcsBMu3H/Espafa/2AxmiDZ1dIiRTJXXvYj8Ybrv1cuM/uwisRYz7ptbYWAn+gUWhVjP4A2TjRLtSSPJFlGwDYOz17JP9jGK4Xom2ETV34oXxkwZAHozARtEc161S4K7p1QLf8dMUgsZM/TH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdjNU8KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0876BC4CEEB;
	Wed, 10 Sep 2025 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515073;
	bh=NK6WI3X3NLXas2ddU8r5M1j0jQ0BhLKIUJlLyAEhkI4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qdjNU8KViBVgxHOsL+lnmjDw6MQElPNtYllJgpKnF17n0FK8coJWnUrJUsi26jaWV
	 is1+DG7fwt2V1qKDK17XWmxUCLvXbibyuUX/gNpEpd+jF3S7nHSvU0Rv57gvOuLbSz
	 59eehrkWkzR2b42DsHv3waMRsWpXc9njF6ayuDFW3HacGK6BtsYwNy/TqP5bxfKLKl
	 UFMhdsJ+faM1lEn8n0lPGmVmZynHiNkwUsFlWPeu7L5f1s7z5UZP3QhdiZ7SD5qlVh
	 4BWIwSOez6hsG9HxAvXUp9iML80jkeKfYAIwzemiNzOMacdXwMi9g+AeMnPQRQqzJr
	 qdaJJrE7DaEGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:36:53 +0200
Subject: [PATCH 08/32] ipc: use ns_common_init()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-8-4dd56e7359d8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=740; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NK6WI3X3NLXas2ddU8r5M1j0jQ0BhLKIUJlLyAEhkI4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OVov7TLt/Ngfmnm2t0v3DcEd/6ZrjWV9V179gKVx
 5O7e9ZodpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEKZKRYY5R7q+4BL1PS2zm
 zt5vZvdr+aJtih4aoq9fXl+xUNnNtpuRYUFKUI2I6xnZwxpT0oKbNydwxmsrr+HRKPgUulDynl4
 HMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Don't cargo-cult the same thing over and over.

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


