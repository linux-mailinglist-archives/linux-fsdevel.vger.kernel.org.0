Return-Path: <linux-fsdevel+bounces-60273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E2B43DDB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0803A797E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3132B2FDC4F;
	Thu,  4 Sep 2025 13:57:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE7980B;
	Thu,  4 Sep 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994242; cv=none; b=bZQff6VpjlQizWt4Gj6Uli94m4FHyw7s/EVOV4yhcosRGvoEWqvknCDzamOrRaTUHISI5qTab1ro9hjb/6Xdsw2ll0D4NZZqq+cd8kbHdszMG53pdIqhd3I6yyAlgCPmVNom8VFZvUNAy+oEC3k9bWieBL7PrP7gHcsTYPRJyJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994242; c=relaxed/simple;
	bh=32lbB6avdRofV4naQnwYCcbd+Bx6PztM5o10tMnJsAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ETlxro4Tf3BR4E6PFnLvcAIAxfV9CeD4TiVY098TP4R0Z77B+itpSIgZhFqlqjLpcbFnt3IQff+vmg86xCnXGD1P7ziQUC4ZhmeqOdxM1kGeBn4uBoaC9Xj2m5av1+32Yz6kosTSvGMyE9mu2Jydq8KZgFQtH1p5CTndbGPctBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cHgyG3HJdzYm8RS;
	Thu,  4 Sep 2025 21:56:54 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 21:57:17 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 4 Sep
 2025 21:57:17 +0800
From: wangzijie <wangzijie1@honor.com>
To: <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<viro@zeniv.linux.org.uk>, <adobriyan@gmail.com>
CC: <jirislaby@kernel.org>, <sbrivio@redhat.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, wangzijie
	<wangzijie1@honor.com>, Brad Spengler <spender@grsecurity.net>
Subject: [PATCH] proc: fix type confusion in pde_set_flags()
Date: Thu, 4 Sep 2025 21:57:15 +0800
Message-ID: <20250904135715.3972782-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a011.hihonor.com
 (10.68.31.243)

Commit 2ce3d282bd50 ("proc: fix missing pde_set_flags() for net proc files")
missed a key part in the definition of proc_dir_entry:

union {
	const struct proc_ops *proc_ops;
	const struct file_operations *proc_dir_ops;
};

So dereference of ->proc_ops assumes it is a proc_ops structure results in
type confusion and make NULL check for 'proc_ops' not work for proc dir.

Add !S_ISDIR(dp->mode) test before calling pde_set_flags() to fix it.

Fixes: 2ce3d282bd50 ("proc: fix missing pde_set_flags() for net proc files")
Reported-by: Brad Spengler <spender@grsecurity.net>
Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/proc/generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index bd0c099cf..176281112 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -393,7 +393,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 	if (proc_alloc_inum(&dp->low_ino))
 		goto out_free_entry;
 
-	pde_set_flags(dp);
+	if (!S_ISDIR(dp->mode))
+		pde_set_flags(dp);
 
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
-- 
2.25.1


