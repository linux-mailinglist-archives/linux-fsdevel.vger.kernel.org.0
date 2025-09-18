Return-Path: <linux-fsdevel+bounces-62098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EEBB83FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE10585C18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5B22FFF83;
	Thu, 18 Sep 2025 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhPDhwhR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FEF28137A;
	Thu, 18 Sep 2025 10:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190341; cv=none; b=OScsB6SRygqIkIeKi4W6/leUi4RpRKXB/h5GHEFfpkbGOYB/8i9v7NgjhqfnGqUBAagfZ48MwYTDaVfshl2RAxnxUsVA1ky3IYxMWxrHCVtAByrwreGIHJj27ccm53FnSiX4NhyZWo2nYX+1RspdYFznWgYPRJPyWWWhYRdFVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190341; c=relaxed/simple;
	bh=wYEQfvSmlmlDWynjlphXrD2qwb3KWxhdfH/o1XOT9aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pd4GZ+pAEBdx8+BBVs/AUf4uDd/ePevaMMbvj3AU0iGkAKXG93f5Oi3VDc5yWIC1mtL3RgQZDeI7qwpmU7LGleazMR5MoogoUT9eJ+cTT/DSYO1cp2qU9w3hE3F/3M5bVsoHZxCtrO/hHP2QvrdA2amxH2fvjkhZjq2KqJ1/fn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhPDhwhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68507C4CEF0;
	Thu, 18 Sep 2025 10:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190338;
	bh=wYEQfvSmlmlDWynjlphXrD2qwb3KWxhdfH/o1XOT9aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GhPDhwhRDK/8wxIUNlLH1gVNLYR/ZvSZ6sPXtDoU9ggEN7lvrxZas52yRbkzRuoig
	 i/BCqdIe089xMP3iZ45uszzUOpu+XSy9P1wZ5IFbSGdNNba5FyEHfGUe0XgnUdtxAD
	 qDLl4vZKvn/NJ20OYqYzoChYW+nOvLIlbMIhwoxM5B2831hXy54P7PDF5blgtbpymW
	 IqpjxMhOnyp0rYdn81tQlXyUOLpscKptWOp4WeZbr68KnsufFmTR3TMOjtidaCNpzG
	 lDSOFaZGk07BnohLEn2wyGsk0D8f3kCrfYToJdlYiMxEl07Pm24/VwiwZVQkz4iccw
	 nHTwpcrcDilQg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:50 +0200
Subject: [PATCH 05/14] pid: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-5-1b0a98ee041e@kernel.org>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
In-Reply-To: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wYEQfvSmlmlDWynjlphXrD2qwb3KWxhdfH/o1XOT9aY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvV0YtW6/Usktqzp7cmPCn7+k3/TDVvvml3X3+59e
 XmSqfT3rx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATWZHEyHB9/tY5WpvceK/p
 nr1z9fLxYuPmix2WS9QkyuX6gj427NRl+Cu5Olr78Av/RRd9ZYOnSGatPz8p4Jb1nXnF23muJs+
 orecHAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/pid_namespace.h | 2 +-
 kernel/pid_namespace.c        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index ba0efc8c8596..5b2f29d369c4 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -62,7 +62,7 @@ static inline struct pid_namespace *to_pid_ns(struct ns_common *ns)
 static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
 {
 	if (ns != &init_pid_ns)
-		refcount_inc(&ns->ns.count);
+		ns_ref_inc(ns);
 	return ns;
 }
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 27e2dd9ee051..162f5fb63d75 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -169,7 +169,7 @@ static void destroy_pid_namespace_work(struct work_struct *work)
 		parent = ns->parent;
 		destroy_pid_namespace(ns);
 		ns = parent;
-	} while (ns != &init_pid_ns && refcount_dec_and_test(&ns->ns.count));
+	} while (ns != &init_pid_ns && ns_ref_put(ns));
 }
 
 struct pid_namespace *copy_pid_ns(unsigned long flags,
@@ -184,7 +184,7 @@ struct pid_namespace *copy_pid_ns(unsigned long flags,
 
 void put_pid_ns(struct pid_namespace *ns)
 {
-	if (ns && ns != &init_pid_ns && refcount_dec_and_test(&ns->ns.count))
+	if (ns && ns != &init_pid_ns && ns_ref_put(ns))
 		schedule_work(&ns->work);
 }
 EXPORT_SYMBOL_GPL(put_pid_ns);

-- 
2.47.3


