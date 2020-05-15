Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB52A1D50A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 16:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgEOOg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 10:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgEOOg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 10:36:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A41C061A0C;
        Fri, 15 May 2020 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=f8uY0F5J9sPe3diCT135xJ/N/Dw+x4WW5zJnRGaybDU=; b=msMI36+CPB2aX7WIDOvf9a7ihe
        A7+CS1wrGUYzvnMjk+QNuVEq6hdstYIgZPQorAgs/fWSXI09jbVs89riMnRBVwBQviupyy3DYOayE
        JmluGvH20OMtC9Xya8H8+tf43obb46YOBQDhJyEunvFokJSClqB+BYiCKrmFLOa42PsHXDhDHPrDg
        +WL9g+3vPWyosfG4RR5+SAek+0gkDoqEOMBae3KTFjfCYISW1pGgPedRT2GT+SPT55i+D+tHCdocc
        hwAsGs57t3OgA7geJGJWqHENAgWbH0LMOJor1hUDGuRNCVKlG9U2TeWdIlcGEah5uy0ULp3wurKV4
        KfwrUS2Q==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZbSF-0003nT-QU; Fri, 15 May 2020 14:36:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Roman Zippel <zippel@linux-m68k.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Michal Simek <monstr@monstr.eu>,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/29] arm: fix the flush_icache_range arguments in set_fiq_handler
Date:   Fri, 15 May 2020 16:36:18 +0200
Message-Id: <20200515143646.3857579-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515143646.3857579-1-hch@lst.de>
References: <20200515143646.3857579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The arguments passed look bogus, try to fix them to something that seems
to make sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/kernel/fiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index cd1234c103fcd..98ca3e3fa8471 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -98,8 +98,8 @@ void set_fiq_handler(void *start, unsigned int length)
 
 	memcpy(base + offset, start, length);
 	if (!cache_is_vipt_nonaliasing())
-		flush_icache_range((unsigned long)base + offset, offset +
-				   length);
+		flush_icache_range((unsigned long)base + offset,
+				   (unsigned long)base + offset + length);
 	flush_icache_range(0xffff0000 + offset, 0xffff0000 + offset + length);
 }
 
-- 
2.26.2

