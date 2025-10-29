Return-Path: <linux-fsdevel+bounces-66219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECBBC1A315
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3770F1A679EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB353491D0;
	Wed, 29 Oct 2025 12:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfQoxu1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811E12FB97F;
	Wed, 29 Oct 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740468; cv=none; b=rjv9q1yID4UWUicP7vPFYPyDbDtmiFwsCzVyzIypNOAmnqpvCXscarXF9ot9JmyaFpibyn2CjmHnAhsU1jSFxivh8yG0oDDvgnhn+jmxlxHu2PoIkwsHqMlq1Us/+GYgMcT2MHT63UZ9K/Pb7TjwkHpMX8YnWk8z4/4TFIfOO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740468; c=relaxed/simple;
	bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlLuSfMIH1El+mf3G0LeryfsNB4qXjSrdn4AdGZJdmRQNJ7R/0rTUTu9lolOv5LIe6YtXqxtnVClB7wlo+LNDPLsKoiO6Hh/cxGPP2mmOK3ZWNe/+s35KzYQyO+kFlQ/UiMPrOvSxBF+f9xblYj0d8gP3SgVYZCtkNybff/3crQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfQoxu1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15AEC4CEF7;
	Wed, 29 Oct 2025 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740468;
	bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WfQoxu1Fr9KYAvKbDOOFWpWqct56ailzDn7rYJrmQcCmqex2sTmgVVJdaUgMJd7jR
	 zUK0WJXtwHIQCYchtlLhLvyFt+R9rWgpy8GAdudjXuVJxkbatU+0lcPSb7j8reC8vg
	 s+ZFK607951sMTW298wUZExI1zvQCYzIZACT1f4hiEo7iTcIYRm129/vUf4NOSKZid
	 0PQijqpEub6FXD5Tvl+8KVmu0pw0pSVHOv1fqURHJTGYXJg75usobwxNmrVU0exGBf
	 COXQ2J7FoeCOzaIYzFB/n/KDYf/5yob4Wu13iDymNtp2BWVPrJG/74F/HdwEumCwkH
	 QWF5IbdtjzypQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:19 +0100
Subject: [PATCH v4 06/72] cgroup: add cgroup namespace to tree after owner
 is set
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-6-2e6f823ebdc0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=brauner@kernel.org;
 h=from:subject:message-id; bh=74AZcYyOqxtykIDy/RGdL2vrgfuHMaAEm8WcGrCjYG4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfV82Nh2Kt3x2J19H7L4Igs2fGiJibvRJv+M5c3Za
 CEX1sqEjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImk6zH89+T+NDUtwqmBQe2V
 T7LH+6mxXs4s5d78Cp/O6SjIXXrvzcjQ3mBQfeJvdcVpj9OHb03c5Jgqsbd70ZVYGxlR0bVP9vx
 jBQA=
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


