Return-Path: <linux-fsdevel+bounces-57263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70488B200D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 09:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF38E3A67AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5D52DA769;
	Mon, 11 Aug 2025 07:52:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E562147E5;
	Mon, 11 Aug 2025 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898741; cv=none; b=B2azKD7VsYIljjHFvdlgQwQ206Qe8wmSvmkSrsFuHu+Cfwx7hiNjgij5P6jFqKne0BeSI2nPaZ+lCVfpB5JNRGbFwUR2pFbkXdnzneY24AnpvK9NseE+QfUWlwLoqAeYVRPwmmnaddJjtJ5u0EKo2IJtS/TwBglpbpMw8aboLzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898741; c=relaxed/simple;
	bh=L25t/Sr19wMgqGnyV9YKwIuCYL1tLJTnmARnQ06MDXk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T28KQTxcqKXh3y+LE34NLQeiaHZtW/Wp42XnXaw3lGW41ijTYiM+vFpcLX7Ad6Sq09BPDaG6da1zuN/esftsA7o4scYyVKWHzpfRdgyeKltkeBxmRKMKaoNG6DZvYdcUJJl2WWXGM0awxoh4j6MeEjQdyG2yhWnXGIt19/m6CGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>, Fushuai
 Wang <wangfushuai@baidu.com>
Subject: [PATCH] coredump: simplify coredump_skip()
Date: Mon, 11 Aug 2025 15:51:55 +0800
Message-ID: <20250811075155.7637-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc7.internal.baidu.com (172.31.3.17) To
 bjhj-exc17.internal.baidu.com (172.31.4.15)
X-FEAS-Client-IP: 172.31.4.15
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the multi-if conditional check with a single return statement.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 fs/coredump.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index fedbead956ed..3fcbf108099b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1077,13 +1077,8 @@ static void coredump_cleanup(struct core_name *cn, struct coredump_params *cprm)
 static inline bool coredump_skip(const struct coredump_params *cprm,
 				 const struct linux_binfmt *binfmt)
 {
-	if (!binfmt)
-		return true;
-	if (!binfmt->core_dump)
-		return true;
-	if (!__get_dumpable(cprm->mm_flags))
-		return true;
-	return false;
+	return (!binfmt || !binfmt->core_dump ||
+		!__get_dumpable(cprm->mm_flags));
 }
 
 void vfs_coredump(const kernel_siginfo_t *siginfo)
-- 
2.36.1


