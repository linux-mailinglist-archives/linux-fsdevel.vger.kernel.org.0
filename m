Return-Path: <linux-fsdevel+bounces-62096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DFFB83FB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4BF1C08567
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEBD2FC89C;
	Thu, 18 Sep 2025 10:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP7bz9WC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26302DF13C;
	Thu, 18 Sep 2025 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190329; cv=none; b=R2Wjd6NEWuEzENUfE4glJtx8vvpUOny7vIGCxCfJZZ494f5WorG+V2H6t54BJ+jrIeN+DUjynaUZkT2kpm+kQYi7sRV7DszEDeVjRpqYq4tzBELTmvYCvA7X36PgaKpm7dJF2QyF/Xk09teWKEmlUdA6fTk7LhmNMW2F1eIKzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190329; c=relaxed/simple;
	bh=AwtpcsfwgtDwnthC1bV7e8x5rzSiJNY1IAfYMJ4PVyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHRFXUoMGlk0fVG+iXbdud/V9WxH+Kwn4il0IpxcMApR7Y2bF4EuqUbuYHZ+AFjENBY6W1kRzPoQEj6etADfu/QeC+bC4dQxmBkcXoJSGCL/0X4Vz3sD+QUz9RgHadTNDf32w1vhsZAAQmRS1cBBxcDKGRbubq0MkCF/P/7l5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP7bz9WC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFC2C4CEE7;
	Thu, 18 Sep 2025 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190329;
	bh=AwtpcsfwgtDwnthC1bV7e8x5rzSiJNY1IAfYMJ4PVyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cP7bz9WCG2K9Yn/WJo5jsHocvHH2K7u/Ohnlf/zHtbQAByPTLJd+CtXaubML2+0qJ
	 0SyrPYgPOCcO8FB5t+g1PmY9nFbJ3N92nd67F64fF0LzIdnlYls0vyLknoenw26R5e
	 k81q2EXbUSYY6mCq3a7UrY2E6al3MtPEL5WyWr437bZzA5hNoqa7g/cAHh/BGF/5yO
	 yhVv3gDexP5f0VXkOAHIP9R0hDw5+OnIfAxBIxpFU8FlrZFWjVRUHNhskn57SUp0gI
	 Ol8BbKKF1GKUIjTTm8pMiZFuhkcRE4WGbL6NfbItxaPVPAQ5u/oM+rUU5P1LhTDzku
	 L1cMdRoFEi3kw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:48 +0200
Subject: [PATCH 03/14] cgroup: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-3-1b0a98ee041e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AwtpcsfwgtDwnthC1bV7e8x5rzSiJNY1IAfYMJ4PVyw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvXUw16y/nCzcuS60N2va/KZEg21JzIxJ6hddaxdm
 5f0gM+8o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLbTjAy3Lf1elvcUjbjxh/n
 0BdHdjxrPqOlto4tzVzqaGXXlAUL9jMytDSeLzyRJr89k1PWi2Gj4exga4e1PSvXHwvu8O2fkB/
 HCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cgroup_namespace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup_namespace.h b/include/linux/cgroup_namespace.h
index c02bb76c5e32..b7dbf4d623d2 100644
--- a/include/linux/cgroup_namespace.h
+++ b/include/linux/cgroup_namespace.h
@@ -29,12 +29,12 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 
 static inline void get_cgroup_ns(struct cgroup_namespace *ns)
 {
-	refcount_inc(&ns->ns.count);
+	ns_ref_inc(ns);
 }
 
 static inline void put_cgroup_ns(struct cgroup_namespace *ns)
 {
-	if (refcount_dec_and_test(&ns->ns.count))
+	if (ns_ref_put(ns))
 		free_cgroup_ns(ns);
 }
 

-- 
2.47.3


