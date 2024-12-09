Return-Path: <linux-fsdevel+bounces-36794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4359E96EB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 14:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA72161D5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F01B043C;
	Mon,  9 Dec 2024 13:26:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC34233152;
	Mon,  9 Dec 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750766; cv=none; b=rMoqjCGg4mdRAncC0XJ/L2CjowYYUw5eQ+trC2yuWJCYfzH//EogHldzN7SSdWZpU+Q0BCJj8kBqKsUtf0mJ901NFtp2o92amyssMs5Mb6KfAbxhW6N5IlnzuL+xgq5o8aN8Lbdb8BmtI8+97d+wUttPXCoQ3LB2UNWUUpDAqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750766; c=relaxed/simple;
	bh=MfX2re32uvOZKZSpSy/UU/o+nsTuburhQAIl8Bo9thc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1lVxAlUxSYtVQKFLJ9CaSzEjss5MrxnotwoI9QtKKJUADEMcBBxxoKHbW6GLRsk6hpKeC8YAI29xLwguTAyIjkO5rk+C2XjB+s9AiYLt4vG1OS9Z4MeJn/1qmJXQI8Gh2ZlHbpNfvpOxlsQuTkBQ06Ms3VUS60NSqnhBbmjfmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y6MxM4KTbzgZ7S;
	Mon,  9 Dec 2024 21:23:03 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id CC659180102;
	Mon,  9 Dec 2024 21:25:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 9 Dec
 2024 21:25:55 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<akpm@linux-foundation.org>, <Liam.Howlett@Oracle.com>,
	<lokeshgidra@google.com>, <lorenzo.stoakes@oracle.com>, <rppt@kernel.org>,
	<aarcange@redhat.com>, <ruanjinjie@huawei.com>, <Jason@zx2c4.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
Subject: [PATCH 1/2] userfaultfd: handle dup_userfaultfd() NULL check inline
Date: Mon, 9 Dec 2024 21:25:48 +0800
Message-ID: <20241209132549.2878604-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209132549.2878604-1-ruanjinjie@huawei.com>
References: <20241209132549.2878604-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Make the NULL check for vma's userfaultfd ctx inline, so we can
avoid the function call overhead if the ctx is NULL.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 fs/userfaultfd.c              |  5 +----
 include/linux/userfaultfd_k.h | 11 ++++++++++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7c0bd0b55f88..7e551c234832 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -615,15 +615,12 @@ static void userfaultfd_event_complete(struct userfaultfd_ctx *ctx,
 	__remove_wait_queue(&ctx->event_wqh, &ewq->wq);
 }
 
-int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
+int __dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 {
 	struct userfaultfd_ctx *ctx = NULL, *octx;
 	struct userfaultfd_fork_ctx *fctx;
 
 	octx = vma->vm_userfaultfd_ctx.ctx;
-	if (!octx)
-		return 0;
-
 	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
 		userfaultfd_reset_ctx(vma);
 		return 0;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index cb40f1a1d081..06b47104aa1a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -247,7 +247,16 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	    vma_is_shmem(vma);
 }
 
-extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
+int __dup_userfaultfd(struct vm_area_struct *, struct list_head *);
+static inline int dup_userfaultfd(struct vm_area_struct *vma,
+				  struct list_head *fcs)
+{
+	if (likely(!vma->vm_userfaultfd_ctx.ctx))
+		return 0;
+
+	return __dup_userfaultfd(vma, fcs);
+}
+
 extern void dup_userfaultfd_complete(struct list_head *);
 void dup_userfaultfd_fail(struct list_head *);
 
-- 
2.34.1


