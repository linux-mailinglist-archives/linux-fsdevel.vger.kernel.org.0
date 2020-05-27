Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064601E376E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 06:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgE0Egz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 00:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgE0Egy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 00:36:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF762C061A0F;
        Tue, 26 May 2020 21:36:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 185so2988049pgb.10;
        Tue, 26 May 2020 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOpmpojWwwDKmdgvBgyDR/91akL7lsEVaaRXHGRRif0=;
        b=RhgQiHKjSFxt0e4hdk9XFdFmwXlaqqy/oTAekflZtHFdhEKO64qFc1mpKDXZr69CPy
         jdKKGgMYF3/PwLMQqZRA0p7MJV/Go6tkta/h4swizRoRpVhai4LlQKtDfpzOQXol3xcY
         3TW/CBGWUO1G35QH1UIuJXs9WTI3G+E29PktRQFzMSdgmMsbx+ViIkPx4XIoQKnwHjtI
         iuFirKyvXOkp6bKvGs8xYK3w/Dn4sctZ1lOJtxsH8Aa2nP03Bsx7PgwJODEguoGDFtQe
         EV7yB1UHGazYqjCw0y7SPUOzeb1Rx+s20xn4YP/gkyyGkm4H/LKnhLTIPlstwN50FD9J
         kU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOpmpojWwwDKmdgvBgyDR/91akL7lsEVaaRXHGRRif0=;
        b=D04p47AQjHiFVOLa1Xh9S82T1TQSXfPu4wykqPdRaEnJY3choB7Zy/8EsvzJAaIKgq
         Rbg6/DEh5iBwjGiA3ps9Ygt67mVmPEUNfb2Yv7Ktb2XxyoDw6EVp03UAvw9fDxBVfo0+
         8YysgchrbyChFVHXA8wh0ht8hp+uDYVkOV50iyixHGSLe584qU74hnQK8EZyNI65MBFR
         HKuFkNlwEjxNWIUKgcJ3/q8JXhuSGzcGRLQ2gFZaJBmVRtADBfafD1T6or1QgWLUsusu
         CKDVZ0NqgIhSMu/JIcHL32GNOG7eqXsVb+f4E4a77Q4ezQOouP6OzeNP4L/+O9looQRt
         353w==
X-Gm-Message-State: AOAM532ZbR1SF3hgJuyeojKsQhntXLGLx5PXTeCF5wAgIB2eawYyCiNo
        oannJ3fyqSMhNoXMHvoFdIA=
X-Google-Smtp-Source: ABdhPJxaG/pR1wu1n7WufrFJ+x4wcg8X7uq9rcDJKu3YRWfpwt3nhECM4aeG8mrZfzsEkO9ezvPt1w==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr2035203pfj.164.1590554214171;
        Tue, 26 May 2020 21:36:54 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id e13sm893604pfm.103.2020.05.26.21.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 21:36:53 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     hch@lst.de
Cc:     akpm@linux-foundation.org, arnd@arndb.de, jeyu@kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        monstr@monstr.eu, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, x86@kernel.org, zippel@linux-m68k.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] media: omap3isp: Shuffle cacheflush.h and include mm.h
Date:   Tue, 26 May 2020 21:34:27 -0700
Message-Id: <20200527043426.3242439-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200515143646.3857579-7-hch@lst.de>
References: <20200515143646.3857579-7-hch@lst.de>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After mm.h was removed from the asm-generic version of cacheflush.h,
s390 allyesconfig shows several warnings of the following nature:

In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
                 from drivers/media/platform/omap3isp/isp.c:42:
./include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct'
declared inside parameter list will not be visible outside of this
definition or declaration

cacheflush.h does not include mm.h nor does it include any forward
declaration of these structures hence the warning. To avoid this,
include mm.h explicitly in this file and shuffle cacheflush.h below it.

Fixes: 19c0054597a0 ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

I am aware the fixes tag is kind of irrelevant because that SHA will
change in the next linux-next revision and this will probably get folded
into the original patch anyways but still.

The other solution would be to add forward declarations of these structs
to the top of cacheflush.h, I just chose to do what Christoph did in the
original patch. I am happy to do that instead if you all feel that is
better.

 drivers/media/platform/omap3isp/isp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index a4ee6b86663e..54106a768e54 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -39,8 +39,6 @@
  *	Troy Laramy <t-laramy@ti.com>
  */
 
-#include <asm/cacheflush.h>
-
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/delay.h>
@@ -49,6 +47,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/omap-iommu.h>
 #include <linux/platform_device.h>
@@ -58,6 +57,8 @@
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
 
+#include <asm/cacheflush.h>
+
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 #include <asm/dma-iommu.h>
 #endif
-- 
2.27.0.rc0

