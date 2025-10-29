Return-Path: <linux-fsdevel+bounces-66220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE0C1A31E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D6F465D15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F46634AAF0;
	Wed, 29 Oct 2025 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QysMhgKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F233FE26;
	Wed, 29 Oct 2025 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740473; cv=none; b=Rkrv4rkH1zuxVcCHjW8upE0+4ERu5u2pBtvDS/n75Fiv+cLOZ5iUAMMB0rXV/hxiHt0GLjom7U9/2/d/R1ABYJddFKx0D4p2z1N+rSti9EW+TnzH7Lb8xb6D5FpzQ+qqsqKeSrvQ0j5ejTLehMn2RQTAt9nQnoOLuxKoButqqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740473; c=relaxed/simple;
	bh=7aAHCcaecm2VZuosAD5WF6qVRIAZipjG6VYIR7g9o5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=apxAi+fDO18A+/Wb5XruGVKIl7zD1jVSWUifCR5+OQWzdRK7KdLT5qLGqhXoqZwxySRjP/YOdeq+lfBtllx2joPvoQnP21PvEGNvH+N6hfKi/gDdPaOpTE+M4cwye+TvkKympTkTlCCZURzHLRXj4asTo0anbDFIBUB/kzfWfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QysMhgKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29FCC4CEFD;
	Wed, 29 Oct 2025 12:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740473;
	bh=7aAHCcaecm2VZuosAD5WF6qVRIAZipjG6VYIR7g9o5A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QysMhgKFHXy+MbUYKRoJBcQAac5y/bDxpqUezj32fQNyI1ospix3GKtZNRo8cTuaL
	 frTVDYkKXcs4INnd4JpKF5D/fLX6NarWdNZo6PyGySNW7JJdwb8mIf+dVqPAM7adfF
	 X1qsUD9d1ZdaKmfu3AU+IsTO1jpdDiSjmDVOhxWkMD1SiQOTSwZyLo0Mxtvn4TRtpG
	 dZKTnppgKq4vfhEOPga9jVHTR9V3Z6SOAZqWw+zuWZ54CXYaz2+5ycU9MN/LKYO7K8
	 8QmnA1n3c+PO/eyotADLbyuwAWmuGFX0seIcUzTCiLOhzw0OO0GSJTH3GG+XvxamWM
	 KLR8cY+ipwHSQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:20 +0100
Subject: [PATCH v4 07/72] nstree: simplify return
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-7-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=670; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7aAHCcaecm2VZuosAD5WF6qVRIAZipjG6VYIR7g9o5A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfVcODejdaHzbpMbPAs38qVqKF9WX6B2l3+J9f/Xe
 UXvzfLDO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYy9RojQ5P0yY+z/5X5n/m0
 5KaMtuBP/gUv9t868nHF1YYcBhNrxy+MDLsV0qM3hPBe2bfY+ffVjyEaOzae2nDzxPPWA2+cZ6r
 G93ICAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

node_to_ns() checks for NULL and the assert isn't really helpful and
will have to be dropped later anyway.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/nstree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/nstree.c b/kernel/nstree.c
index b24a320a11a6..369fd1675c6a 100644
--- a/kernel/nstree.c
+++ b/kernel/nstree.c
@@ -194,11 +194,6 @@ struct ns_common *ns_tree_lookup_rcu(u64 ns_id, int ns_type)
 			break;
 	} while (read_seqretry(&ns_tree->ns_tree_lock, seq));
 
-	if (!node)
-		return NULL;
-
-	VFS_WARN_ON_ONCE(node_to_ns(node)->ns_type != ns_type);
-
 	return node_to_ns(node);
 }
 

-- 
2.47.3


