Return-Path: <linux-fsdevel+bounces-65446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E7EC05B54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 12:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3430335CC15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 10:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B14F314D30;
	Fri, 24 Oct 2025 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwBPmxQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726C3126C7;
	Fri, 24 Oct 2025 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303211; cv=none; b=fg4+H2N5+FnQuJiqBz8VYa4sMVL49NuUhI6OyJ9htceWN1Z8eD7KLNqVPwYR2IfaVilba9k9m3tAkeTnJhRhBPytgOO5qw7H1UDmqRWz6MyU3s7fZwIm0sjs3YjlTKzSSfgQw1iGzwzGttaRhWNkGDy2fUqilzHbmhDlwwJ35Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303211; c=relaxed/simple;
	bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mzaPIEZGcOi8mLkH6KtfoC95yJCJSnhmZ06Og7WZ+DOf5eQeuEu/OvKZyWq/uKBYIhTMyW8UdWUkcJ1ndhcp17aAYvSdtFOnfRLIHk1BaqnNb3gE2kJYQFFwD9BpAn2rxHl28fJmeajv0AxmzXv157bJtvWBdJHvThmZ7f7gpYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwBPmxQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271EDC4CEF1;
	Fri, 24 Oct 2025 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761303211;
	bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rwBPmxQuvvRwSb5irTHJqsFp02PfOUotVvq7YyND6SwL1mkek2U+SPuhRD3gaWHKx
	 XPPweYijvHDEan0SBgsIEAiMS4sbdjsKhOAp+SpSBkwXPOajW86v+jQAcSxBh16ED3
	 C90JBNmvvJtS0HHktVbWPyaRSOCBokdn5LryB3BDTADGbIbLhME4wXW97An7xdRsPP
	 OR+DsIqfxGdtdwYjp404UQsW5hmTFfkz0dpZM6FD0z2MtOPRLDvjold4Nr5koYtgec
	 rrgMmfN9B7E3kOUaOpbtM0yoVtx8UbsNc6Sa7CbQIAn7j4nS2WkUyJcM77UB8kgAl/
	 lO0LX0Cv+288A==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Oct 2025 12:52:35 +0200
Subject: [PATCH v3 06/70] cgroup: add cgroup namespace to tree after owner
 is set
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-work-namespace-nstree-listns-v3-6-b6241981b72b@kernel.org>
References: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
In-Reply-To: <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=brauner@kernel.org;
 h=from:subject:message-id; bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT8jmrRPFHBncNbLVXQk3DwT5jV+/VTmsS/nxEPn3bC2
 kGrisO2o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKObQz/qyNifzXYzPQwWmvx
 qenFj+1udgc3fW/fnW0545G3nrDVE0aG31N2OQVF7F99u+zJj78Lc4qP9slX2Kw79HOnoH/EgoJ
 qbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Otherwise we trip VFS_WARN_ON_ONC() in __ns_tree_add_raw().

Fixes: 7c6059398533 ("cgroup: support ns lookup")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/cgroup/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index fdbe57578e68..db9617556dd7 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -30,7 +30,6 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 	ret = ns_common_init(new_ns);
 	if (ret)
 		return ERR_PTR(ret);
-	ns_tree_add(new_ns);
 	return no_free_ptr(new_ns);
 }
 
@@ -86,6 +85,7 @@ struct cgroup_namespace *copy_cgroup_ns(u64 flags,
 	new_ns->ucounts = ucounts;
 	new_ns->root_cset = cset;
 
+	ns_tree_add(new_ns);
 	return new_ns;
 }
 

-- 
2.47.3


