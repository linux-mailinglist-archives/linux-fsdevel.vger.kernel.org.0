Return-Path: <linux-fsdevel+bounces-65518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E5C067AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 15:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906B73AEFE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208F331C584;
	Fri, 24 Oct 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuVCBusI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA422277CA4;
	Fri, 24 Oct 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312222; cv=none; b=lMfGc70Gdmanv6yp1RkEcLsp3wrn+EFmifvE6ns+JVFYk1UjLSiySpUzWL+1LiNeLkQoygbcXVy5TUrmF95wLLZYGpsa8XeLgRpapXcu2rpwtPdkuSqaqhFLQs3XNZL9Ec144tZ3L9otiBhVituu/0NWgl6snjA0AZ4TyC7FMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312222; c=relaxed/simple;
	bh=q1BS65qcRVA/+7DPksCa2hf/J5Z6Pw3KXpiVyNVsP9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxkhxjcIRSVbtarqTgimswnowowMVrPJzJV9fVnC4WH1/yAzR3bgqE2tn8XagfO0T3Qd0ciqSVSiChudQf+uZfTK1uJjnIukVyaHE/diZMYxCn0ND+rQTLUKpj9cWSyhUhKcrCQ0WttIs8ZJlUnbd2waYlKv6gpBRWTwLnxdQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuVCBusI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761312221; x=1792848221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q1BS65qcRVA/+7DPksCa2hf/J5Z6Pw3KXpiVyNVsP9U=;
  b=WuVCBusIwEnKWcSBJ5VpBOsz8lif0I/5KiRHvEXz/gSFJn4kVPMqSpmK
   zpCMTzshzv6389/qmRMdiw4vToiePHBxwr1QDAfxD6loKzE1jllQn545c
   392fgxbSDzprE8fbaXh6jGTqvrOgiaJKwuQy8cGp35qUKDwKVmIduG1nV
   lvTyF/GA8dpE05cG5B99/JdOi9v4wURWBG3aE9Yc+pU7Q1eMgBhrZ/P6B
   fwVjAVmoR0DHf53omg6FsF/ZnhI5iJYozLfiMVkRvf1P+LLI+TW2fAZsG
   it84AGgyWz0VTX9xf/x/wjAQtk8IQBo4cgOzqSN9kbL0MIe/VgveG3xHQ
   A==;
X-CSE-ConnectionGUID: Vyo6lHpoRDaSJoPBAaQABA==
X-CSE-MsgGUID: 3ow/iQGtTdSoWh/iDhIMqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73782876"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="73782876"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 06:23:40 -0700
X-CSE-ConnectionGUID: RfOQ0gepScC3uIpDOWSEgA==
X-CSE-MsgGUID: BpfyroqUREKNSFOuvjXtsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="221634196"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2025 06:23:38 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 20E5696; Fri, 24 Oct 2025 15:23:37 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] mnt: Remove dead code which might prevent from building
Date: Fri, 24 Oct 2025 15:23:36 +0200
Message-ID: <20251024132336.1666382-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang, in particular, is not happy about dead code:

fs/namespace.c:135:37: error: unused function 'node_to_mnt_ns' [-Werror,-Wunused-function]
  135 | static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
      |                                     ^~~~~~~~~~~~~~
1 error generated.

Remove a leftover from the previous cleanup.

Fixes: 7d7d16498958 ("mnt: support ns lookup")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/namespace.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..9145bb02e9b7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -132,16 +132,6 @@ EXPORT_SYMBOL_GPL(fs_kobj);
  */
 __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
 
-static inline struct mnt_namespace *node_to_mnt_ns(const struct rb_node *node)
-{
-	struct ns_common *ns;
-
-	if (!node)
-		return NULL;
-	ns = rb_entry(node, struct ns_common, ns_tree_node);
-	return container_of(ns, struct mnt_namespace, ns);
-}
-
 static void mnt_ns_release(struct mnt_namespace *ns)
 {
 	/* keep alive for {list,stat}mount() */
-- 
2.50.1


