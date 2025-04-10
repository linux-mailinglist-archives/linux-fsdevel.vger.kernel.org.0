Return-Path: <linux-fsdevel+bounces-46199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE2A84216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC58173B1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23DD2836A3;
	Thu, 10 Apr 2025 11:52:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7422165F3;
	Thu, 10 Apr 2025 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285965; cv=none; b=KURaYEEShbnomO7Ww3z2l/4PLO61DJNLy40f86AjhomZGFB0TU3dCXgEpbrsYTwuYeDCae3Q70DJUnNBfn6/q0/fOkFJB6Sslhw6k9yM6iA2Z1Bj6kQuLwO1bSDmsYTQV6zKhVjeId7iI+UQV9uHtcX+G8W1M1RFuvN7wiPTZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285965; c=relaxed/simple;
	bh=JDkaw1wOk/UYnZY3BX0aROF5pCYw/LPE7tZYGSQHoms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PE0Km2HtpE7BCenHyCa+2hn8eYeD7Z4ow8D7oMt8MDP1U8s5fRfcqFDnoihf5m7rhweamPubo6Ohhj0qgdhCLA7dEkY48hUbmZPsTE03TyrIjdlfSbWsurBemOZC7gImeiB/MwzJu9RBW6J8EJ5uTS4RAGGZJlsw/VH5UNArnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] fs: Make file-nr output the total allocated file handles
Date: Thu, 10 Apr 2025 19:21:17 +0800
Message-ID: <20250410112117.2851-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJHW-Mail-Ex11.internal.baidu.com (10.127.64.34) To
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-04-10 19:21:24:085
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-04-10 19:21:24:085
X-FEAS-Client-IP: 10.127.64.38
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Make file-nr output the total allocated file handles, not per-cpu
cache number, it's more precise, and not in hot path

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 fs/file_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index c04ed94..138114d 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -102,7 +102,7 @@ EXPORT_SYMBOL_GPL(get_max_files);
 static int proc_nr_files(const struct ctl_table *table, int write, void *buffer,
 			 size_t *lenp, loff_t *ppos)
 {
-	files_stat.nr_files = get_nr_files();
+	files_stat.nr_files = percpu_counter_sum_positive(&nr_files);
 	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 }
 
-- 
2.9.4


