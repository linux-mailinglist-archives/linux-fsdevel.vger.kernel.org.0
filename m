Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B992E18F7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 07:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgLWGb4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 01:31:56 -0500
Received: from m12-18.163.com ([220.181.12.18]:59838 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgLWGbz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ir0Z7
        hf5gWb4v2SG15f0NYgChr3Crfln+YyC/91u4/k=; b=RKkctj+qvAtmz0sFpPV6A
        wFbz6VISLUly+pMJlpRkt2r4Fuh+3XlYQRjQ8RE5+w7to9gmkrEVuQQMcTOa4Q4z
        8gD3zH4hHZGSfx/tshsid8WG04nXfQz1dat7Jf6ItBAhVEt6i7noptv2nUe4NnhX
        aGj9vjSh0TzyCSrCwq0TjA=
Received: from localhost (unknown [101.86.213.121])
        by smtp14 (Coremail) with SMTP id EsCowADHkBjq4+JfvFX1LA--.25218S2;
        Wed, 23 Dec 2020 14:30:02 +0800 (CST)
Date:   Wed, 23 Dec 2020 14:30:02 +0800
From:   Hui Su <sh_def@163.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Cc:     sh_def@163.com, songmuchun@bytedance.com
Subject: [PATCH] mm/buffer.c: remove the macro check in check_irqs_on()
Message-ID: <20201223063002.GA1526597@ubuntu-A520I-AC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EsCowADHkBjq4+JfvFX1LA--.25218S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0fHjUUUUU
X-Originating-IP: [101.86.213.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIAoEX10TCqUscwADsM
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The macro irqs_disabled is always defined in include/linux/irqflags.h,
so we don't need the macro check.

Signed-off-by: Hui Su <sh_def@163.com>
---
 fs/buffer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 32647d2011df..34b505542d96 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1247,9 +1247,7 @@ static DEFINE_PER_CPU(struct bh_lru, bh_lrus) = {{ NULL }};
 
 static inline void check_irqs_on(void)
 {
-#ifdef irqs_disabled
 	BUG_ON(irqs_disabled());
-#endif
 }
 
 /*
-- 
2.25.1


