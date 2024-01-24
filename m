Return-Path: <linux-fsdevel+bounces-8762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E17B83ABA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 15:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5131C224A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893707C08C;
	Wed, 24 Jan 2024 14:26:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05667A717;
	Wed, 24 Jan 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106391; cv=none; b=c0AjvIXvUjfRfeLX2qAhdfOdRpCzAg3QvNWMUCH8oxQYnlt0Q5S0Df8mL+uUfKTBOoWlzQP5rXn+BMtd4ri208xJv9edCoJlvzXpCYGYifKRpAwih//ZKZ/FQNuuApzdZktGDbscf66T7cUoFIXV9wUJxmK0moT4FmewVju2EFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106391; c=relaxed/simple;
	bh=XxIR8G6KchKU6wk5xqbi4STGiKxsOiyyqLu0eG/Irxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWGEFXmag6aWv5xYPNgqHNULwSIxdHUNEwW7oVk7ciuX19Zk/1FxASI8x85iKEhHlAcJa1hcZD8d/vKEyEA5fT/fzujSItpBb4jAS2VG7KaMPOgZX5ND7NOiDN3jnrB82fxKKbXk2xZnMRK8avjBuCTybB+ONSS96Mm1+yeCjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TKmSz02qNzsWJK;
	Wed, 24 Jan 2024 22:25:23 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 1284F14011A;
	Wed, 24 Jan 2024 22:26:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 22:26:25 +0800
From: Baokun Li <libaokun1@huawei.com>
To: <linux-fsdevel@vger.kernel.org>
CC: <torvalds@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <arnd@arndb.de>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>, kernel
 test robot <lkp@intel.com>
Subject: [PATCH v2 3/3] asm-generic: remove extra type checking in acquire/release for non-SMP case
Date: Wed, 24 Jan 2024 22:28:57 +0800
Message-ID: <20240124142857.4146716-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124142857.4146716-1-libaokun1@huawei.com>
References: <20240124142857.4146716-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)

If CONFIG_SMP is not enabled, the smp_load_acquire/smp_store_release is
implemented as READ_ONCE/READ_ONCE and barrier() and type checking.
READ_ONCE/READ_ONCE already checks the pointer type, and then checks it
more stringently outside, but the non-SMP case simply isn't relevant, so
remove the extra compiletime_assert_atomic_type() to avoid compilation
errors.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202401230837.TXro0PHi-lkp@intel.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 include/asm-generic/barrier.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 961f4d88f9ef..0c0695763bea 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -193,7 +193,6 @@ do {									\
 #ifndef smp_store_release
 #define smp_store_release(p, v)						\
 do {									\
-	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	WRITE_ONCE(*p, v);						\
 } while (0)
@@ -203,7 +202,6 @@ do {									\
 #define smp_load_acquire(p)						\
 ({									\
 	__unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);		\
-	compiletime_assert_atomic_type(*p);				\
 	barrier();							\
 	(typeof(*p))___p1;						\
 })
-- 
2.31.1


