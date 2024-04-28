Return-Path: <linux-fsdevel+bounces-18012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8D18B4B09
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 11:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6A1281A5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE2F55C22;
	Sun, 28 Apr 2024 09:48:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2BF54BD6;
	Sun, 28 Apr 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714297722; cv=none; b=g179HTTjabe+jzf1KgG5PQ87jXxNtJxpjYdsjlfAx3Y1aY86uiT8jnlXr3+Wqn5qCBHs2ivoDdq5Ry2Q/zMV3fr1v6NWasLDIsb9gG9tiXXY5D10bkaiS8VAZg2g9CKd5RKxTiTLajqedChGJVTHor6Kb1G4QKzqz2qh6Dcvqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714297722; c=relaxed/simple;
	bh=61V0FG6lZJoM5tNsRbbC+xrZH4lh6If1Bwi8I0o2NrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=phq+NNITosHd9YkJZK/dF1c0bDu41jZUDhvtK5KPEX8sYQvhLi89mnQmSnwjBHrg4A1VQLyOJqn8mQHjCruhB0cZXhq2rjONDw3X7kesCD0ztF6EHs176GcqmX6nqR4/NSKZlOsKXvkKxuVLlAk/e1zoCf/SwARLty+MdxTLNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VS1pT15XczccCC;
	Sun, 28 Apr 2024 17:47:29 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 927D91401E9;
	Sun, 28 Apr 2024 17:48:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 28 Apr
 2024 17:48:35 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<j.granados@samsung.com>, <brauner@kernel.org>, <david@redhat.com>,
	<willy@infradead.org>, <oleg@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] proc: Remove unnecessary interrupts.c include
Date: Sun, 28 Apr 2024 17:48:47 +0800
Message-ID: <20240428094847.42521-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)

The irqnr.h is included in interrupts.h and the fs.h is included in
proc_fs.h, they are unnecessary included in interrupts.c, so remove it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 fs/proc/interrupts.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7cbf09..463a0f754edf 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/irqnr.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 
-- 
2.34.1


