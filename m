Return-Path: <linux-fsdevel+bounces-17547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 304BD8AF738
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 21:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634461C25006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70781411E0;
	Tue, 23 Apr 2024 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vxiLZCma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0456140367;
	Tue, 23 Apr 2024 19:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900145; cv=none; b=T5rdMI6Q3CkiPSLvOmZpDW+MMtb/S1/dkLsQeg8TFaWCqu3313ool174kd3aGlMUCk/WGLo8JSKtZ5KZQpk6iH+qQWa9Os7v0zJY9J/ZeltgSsJYSA9sfHPiqb3mdrZlIXLinGUYRmT2kglLQrdvJA4Nqr8Bf9xnvBoYGyCnFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900145; c=relaxed/simple;
	bh=TXpKuuBZAw7XLuMVlMCZHKeGjYVk37z7qTLtUWCrQ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6KH91MqHduNf+NfUVCGDLciUSe39O5zvD0INdHrPPaq6pVFHAvQ6MSwOQ95C4QYTgZUe7KG9Jd2P3pJ33ap/t0j5NOP8Z7PY9LRjOSjezE6nAASjN0K7L14aWtL+bWLr1UuwVx5EcPhX9jtaDeuniIrEdWhmnS/ShDGFShTncs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vxiLZCma; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4AXHJdmSYJnEI0IP6FH8bmSpXiYxRSvQ1Evd/zp1EnA=; b=vxiLZCmaDDlR7+8fenhQsKOVeS
	/+y9kr2bwsOY/lXfCe+0MXzsZAhtLqxIEenPWKkOg6+83wzWyeBbfvBb4c7oENEXy9VX0T5a4MjrI
	EwP6RrJNgnnQPZsJgYNxBo8bJlOA7htBxgfCpF6/FihJOcJBoMlk+54kFeSt0SnZM0T3SvAfiv6de
	WvoluQF7Chl67Ui4zCnKqE32+t1peZjhnPSbKhXnE+CkLUGj9+VjnAO276PWYEI9EJRopvA8Ao6Ks
	MjQHqKJzl2/8qwABHC2uysuNYc9lGuFisBE5sJgcFUvqQYhWSSB6Nt0drk0pD+/Kb67G9rkqzFC4m
	2nU6eK7g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzLig-00000001GKm-2wcw;
	Tue, 23 Apr 2024 19:22:22 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: akpm@linux-foundation.org,
	willy@infradead.org,
	Liam.Howlett@oracle.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	david@fromorbit.com,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH v2 1/2] tools: fix userspace compilation with new test_xarray changes
Date: Tue, 23 Apr 2024 12:22:20 -0700
Message-ID: <20240423192221.301095-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423192221.301095-1-mcgrof@kernel.org>
References: <20240423192221.301095-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Liam reported that compiling the test_xarray on userspace was broken.
I was not even aware that was possible but you can via and you can
run these tests in userspace with:

make -C tools/testing/radix-tree
./tools/testing/radix-tree/xarray

Add the two helpers we need to fix compilation. We don't need a
userspace schedule() so just make it do nothing.

Reported-by: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Fixes: a60cc288a1a2 ("test_xarray: add tests for advanced multi-index use")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/radix-tree/linux/kernel.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-tree/linux/kernel.h
index c5c9d05f29da..c0a2bb785b92 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -18,6 +18,8 @@
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
+#define schedule()
+#define PAGE_SHIFT	12
 
 #define __acquires(x)
 #define __releases(x)
-- 
2.43.0


