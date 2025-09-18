Return-Path: <linux-fsdevel+bounces-62105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302CB8402F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 12:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA648580FA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E915330596A;
	Thu, 18 Sep 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKwYP7DP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8E3054D8;
	Thu, 18 Sep 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190372; cv=none; b=VN2woTfJjJVW1qqu6jWuISvIKPsQu1RCOe9aNJrmeqCr8kgo+sLTjrGSTWU/0bIfMHCu+n3woctT5GBFa53GHvGhGRw4pM63HcUdLmcjvRQAUkaHIUONF3SirBnZ4fZBJaWBaXQKU4l3nlaAh7sZtD0JKM7/FfpVgGczVOuLZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190372; c=relaxed/simple;
	bh=yZAVutrvboeNqrTjIA0TeZXp0AfWUyqn3YyVJqMz4LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M79+Jbzl4/qf98pKENQyQRxFha+ooOilecIdJjYdDlBVC9ZO8pNf22WH3FgYyal6snAGT2I/IPObtFSIHa5RW3vcZMLPkRvxrMvRjOswLlmLUCdCFI3YHs3MKPnxl1FKY5x1rsAbswpNPTb/aPQNd/LS7AmHa3aI/oywY7QAr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKwYP7DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5275C4CEF7;
	Thu, 18 Sep 2025 10:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190371;
	bh=yZAVutrvboeNqrTjIA0TeZXp0AfWUyqn3YyVJqMz4LU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cKwYP7DPsusoeqlXE+YfvB+i9BN6bVQ1RE27LpjACDar+JG6Ki18fuV9+W9yX6lkt
	 GVeAyxy1j3unF0lH/rAsY3C1+91Wy5wA+okYo9usmKUUol/jZwB4jrmPlO6QnFA+eL
	 tXTOygbW+fhFXqsTbni+fLlW8jFN4mmtSKXZmzJVhFDPUg88Nqp12aLFVuMh5X8CIh
	 rQ+3AEFmdAoRSHr6poGMKJV5njxfBA/Kp6Ju43oQ+4PMRTmH+w9PH67BGotx1F0mNO
	 Ld3pCxiIM5E09K6albOX+TU4R5d6IpQHW4uThIrm4GXmt4t2g/ibDM8tFcn8IARnD0
	 K/xrsLFlvOktg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 18 Sep 2025 12:11:57 +0200
Subject: [PATCH 12/14] net: port to ns_ref_*() helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-work-namespace-ns_ref-v1-12-1b0a98ee041e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1446; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yZAVutrvboeNqrTjIA0TeZXp0AfWUyqn3YyVJqMz4LU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWScvvWsLuNHV/AV6dkcltXvTy8N3rYpb/b03atqJ3Fwa
 64OWMtR21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARtZMM/53dz3884LP8h+DU
 b9/uqWcxmT1RLvlZkahSMyOVYYrZXhtGhoOc62cGzLH75BG8Sojpzb6/BZv33A5enz7rdd/e3Ii
 fMRwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Stop accessing ns.count directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/net/net_namespace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index fd090ceb80bf..3e7c825e5810 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -270,7 +270,7 @@ static inline struct net *to_net_ns(struct ns_common *ns)
 /* Try using get_net_track() instead */
 static inline struct net *get_net(struct net *net)
 {
-	refcount_inc(&net->ns.count);
+	ns_ref_inc(net);
 	return net;
 }
 
@@ -281,7 +281,7 @@ static inline struct net *maybe_get_net(struct net *net)
 	 * exists.  If the reference count is zero this
 	 * function fails and returns NULL.
 	 */
-	if (!refcount_inc_not_zero(&net->ns.count))
+	if (!ns_ref_get(net))
 		net = NULL;
 	return net;
 }
@@ -289,7 +289,7 @@ static inline struct net *maybe_get_net(struct net *net)
 /* Try using put_net_track() instead */
 static inline void put_net(struct net *net)
 {
-	if (refcount_dec_and_test(&net->ns.count))
+	if (ns_ref_put(net))
 		__put_net(net);
 }
 
@@ -301,7 +301,7 @@ int net_eq(const struct net *net1, const struct net *net2)
 
 static inline int check_net(const struct net *net)
 {
-	return refcount_read(&net->ns.count) != 0;
+	return ns_ref_read(net) != 0;
 }
 
 void net_drop_ns(void *);

-- 
2.47.3


