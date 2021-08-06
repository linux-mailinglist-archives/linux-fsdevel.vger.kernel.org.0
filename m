Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63A3E27C9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 11:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244689AbhHFJw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 05:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbhHFJw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:52:29 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CAAC061798;
        Fri,  6 Aug 2021 02:52:13 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id b1so6085348qtx.0;
        Fri, 06 Aug 2021 02:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ATk9Anx8RibhuRL+d9V0PBWYVmLm0E28C/cJ0kw8glI=;
        b=pSv9CS0W82JWMyDOQgRLLe6M4ldB/7hZuEfts9NVe6hPNJ6kXF3ZP7Cxvw15wsJBr5
         01sfTFtzO/hBHYpcNWUXUieatfJUQrmt7gLrCuU7yo7qu5Qztyf/Ru3y7ltRKHCgByDn
         U28u+yIUoZlkH7x/R+uRiAuyyHIhuodbp1w7PxbzVM+dag50B25rydsgaElt6h5xt+Wg
         /c7tp1OKsCbsRoDgHKqbTi1xQY4s4BfyCoawI2bhFGC3JdPNp/Z3doK53qALFE2pMQzB
         ITuwuslAMeBMm0w0rh7ZarPQMJCafwFbf54EAz+XMHvGqCMikWvWHY57y2qJaSAhZzgk
         8bVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ATk9Anx8RibhuRL+d9V0PBWYVmLm0E28C/cJ0kw8glI=;
        b=Bg6UZx0qI0+FUHKgDPAm6Fa3rqJQl/IVovwfB7rEgLc+6yI9axUGDoFVPgiEO0ZMAe
         D0l8ObtZzMzAjQwRhpc/kDYrR31wv37fDWJ+u1U2is2IFrAdcB2Igy3TVTRHvm4Qa7T3
         7XG7p+vkZH1Z62k97m2iP/EApUttH+HWugbknax6lTV77vKdKbH6atsC685SsAZbuWBT
         l6dHB59bqY4y2eSlWQ0jMzZcTTrv1ONfLbiwOc+H99EOIPg/tsoYGbt+ad48fJbkaX0v
         FeW4NWH0CqSA4qOswMJngFH5O9uOriNnuUioMRN/KBh/Hs4DMcR1sJOApa1b+AVYPXJX
         8Ixw==
X-Gm-Message-State: AOAM531abgRdafkLbkTfHFvrbPVIxeGLkPf36FnxepYjjjI/hK3qLCDM
        axpQSMPOcl6EJAxqoQP3PoY=
X-Google-Smtp-Source: ABdhPJwirvIQEW30b40xytudpr0bhXVDPRSML1mNd6bQkFBKyhH9WgJgnlBtrUkG5iD3Rl1BjIakCA==
X-Received: by 2002:ac8:5ac7:: with SMTP id d7mr8149530qtd.240.1628243533052;
        Fri, 06 Aug 2021 02:52:13 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id s3sm3296915qtn.4.2021.08.06.02.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 02:52:12 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sjpark@amazon.de>, rdunlap@infradead.org,
        broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        willy@infradead.org, linux-damon@amazon.com
Subject: [PATCH 1/2] mm/PAGE_IDLE_FLAG: Set PAGE_EXTENSION for none-64BIT
Date:   Fri,  6 Aug 2021 09:51:52 +0000
Message-Id: <20210806095153.6444-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210806092246.30301-1-sjpark@amazon.de>
References: <20210806092246.30301-1-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 128fd80c4c07 ("mm/idle_page_tracking: Make PG_idle reusable") of
linux-mm[1] allows PAGE_IDLE_FLAG to be set without PAGE_EXTENSION
while 64BIT is not set.  This makes 'enum page_ext_flags' undefined, so
build fails as below for the config (!64BIT, !PAGE_EXTENSION, and
IDLE_PAGE_FLAG).

    $ make ARCH=i386 allnoconfig
    $ echo 'CONFIG_PAGE_IDLE_FLAG=y' >> .config
    $ make olddefconfig
    $ make ARCH=i386
    [...]
    ../include/linux/page_idle.h: In function ‘folio_test_young’:
    ../include/linux/page_idle.h:25:18: error: ‘PAGE_EXT_YOUNG’ undeclared (first use in this function); did you mean ‘PAGEOUTRUN’?
       return test_bit(PAGE_EXT_YOUNG, &page_ext->flags);
    [...]

This commit fixes this issue by making PAGE_EXTENSION to be set when
64BIT is not set and PAGE_IDLE_FLAG is set.

[1] https://github.com/hnaz/linux-mm/commit/128fd80c4c07

Fixes: 128fd80c4c07 ("mm/idle_page_tracking: Make PG_idle reusable")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index d0b85dc12429..50ca602edeb6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -741,6 +741,7 @@ config DEFERRED_STRUCT_PAGE_INIT
 
 config PAGE_IDLE_FLAG
 	bool "Add PG_idle and PG_young flags"
+	select PAGE_EXTENSION if !64BIT
 	help
 	  This feature adds PG_idle and PG_young flags in 'struct page'.  PTE
 	  Accessed bit writers can set the state of the bit in the flags to let
@@ -749,7 +750,6 @@ config PAGE_IDLE_FLAG
 config IDLE_PAGE_TRACKING
 	bool "Enable idle page tracking"
 	depends on SYSFS && MMU && BROKEN
-	select PAGE_EXTENSION if !64BIT
 	select PAGE_IDLE_FLAG
 	help
 	  This feature allows to estimate the amount of user pages that have
-- 
2.17.1

