Return-Path: <linux-fsdevel+bounces-62099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4BDB83FDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA404A8571
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697253009F2;
	Thu, 18 Sep 2025 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsJkMcbP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73FF2FFFB2;
	Thu, 18 Sep 2025 10:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190343; cv=none; b=GSnAwldc2ezcKWVAHSvvOPJ4rah48vCcV5H63k0JG9Md86T9X3/CdrR+DrAh6TaMOw22tX2r6DiGa4cXh38dbia3n2+9uAPtr6u/9P0IZbsIzZH7NZoecHEk0KShmFaFxQXp6XBJInEBdKxqqqdhGp3ZLnry03hGBPidULr1oPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190343; c=relaxed/simple;
	bh=4amAutzpiwVYLHgtnhIXGGuhoIt8EcWOZn5DDS6SJmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASuFiqCx7eDpuXmhFgrx1xom4xPgy1u+I+HGA2MWyohP3d7bQxtWfVEe7iAIfzDqINtJOVtgvvgrMCdsrPP7uMNN3Qf/fdlNkfR++K4K2IA1PqvuDnEre9qH7T4rnmYuN9WVIvtsYg+dyth7cIHILgrH1XPvWb1kwYF31xZLKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsJkMcbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ACEC4CEE7;
	Thu, 18 Sep 2025 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190343;
	bh=4amAutzpiwVYLHgtnhIXGGuhoIt8EcWOZn5DDS6SJmE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EsJkMcbPk5O5ehnVhIO5sp2dcNyCdQtyKV3tSSGaIHYQEHTJQRBsVpaLYWz1YT/XZ
	 5r1jqGZIv3XmRrHFGyv0Dz8pTz1N3UfrXIBBg+hxaC7J/vOwO4kESOoXNYp3hVFaJQ
	 LMrdPGiX4AvsW2YyG+LVdaQji2WAmkzP5JUX3j6OCDilBYheciNiHCdO4eEqI7LnEn
	 BKp1qSjcBAaQziAKhUeQHfnN46zEBQNcb23tgVb/EX2HDpJkleBY/UDxI2dMKAwmc0
	 rSpA2FUzj+vkzJwfNy5lE6qigDmEDSkEm/z+NVD1LgWUqe3Aw1n/JRo5cHTku5IGDz
	 kyGK8ozDBz8rA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:51 +0200
Subject: [PATCH 06/14] time: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-6-1b0a98ee041e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4amAutzpiwVYLHgtnhIXGGuhoIt8EcWOZn5DDS6SJmE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvW013CTaGDpGQGXSuVtyTt/3DqiH/AwSvDmloOLx
 Hy9OawndpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyEi4vhn514yeam59ybJDiv
 H+Bw/prWwX48+YLnuYx9RyvFLv3MrGL4Hxt0Zu+VT+/n+mvyeKk/kVQ7Wc5/sn3T+i8htSp/720
 15AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/time_namespace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index a47a4ce4183e..f3b9567cf1f4 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -44,7 +44,7 @@ extern void timens_commit(struct task_struct *tsk, struct time_namespace *ns);
 
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
-	refcount_inc(&ns->ns.count);
+	ns_ref_inc(ns);
 	return ns;
 }
 
@@ -57,7 +57,7 @@ struct page *find_timens_vvar_page(struct vm_area_struct *vma);
 
 static inline void put_time_ns(struct time_namespace *ns)
 {
-	if (refcount_dec_and_test(&ns->ns.count))
+	if (ns_ref_put(ns))
 		free_time_ns(ns);
 }
 

-- 
2.47.3


