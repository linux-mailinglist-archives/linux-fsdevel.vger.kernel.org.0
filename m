Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4947EC1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351695AbhLXGXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351536AbhLXGXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ADCC06175D;
        Thu, 23 Dec 2021 22:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OekyBfbXeB8EtlRGQip5DS+j5G95XxfKmI9Yn9Wc/qE=; b=kS//ilOGiMu6o+nWqHf5bfoj8+
        hXF6jIh2sS7ug5totuZsthz+YsAdrtrGVC7D5g4r+jByzLTlGxgrIDM43qPD+DYJyGp9CxAaF22Ha
        ZJ1lkY+r4rkMPDNeKSijtXru3WTBgPfVnlQ+dUkhJwk0pFe2STnbNhXMHLBzte2AhSHjD9aa8ZVYA
        Du6Rsx3voZPi5Frme42WN9ofTesI8n3RTwsYySGJxQ20ivpuvDKYLMtp++UxFJrSerpwCCTHjOC4K
        RF9cyx55SrQxMWDNXgW+Qm6uNHQ2is7A6MKlkoRV2yHZtDWcbNPsaoM/x81e+aDazKxHiYatyGm7y
        QYhHnK9A==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dzD-00DnCL-GS; Fri, 24 Dec 2021 06:23:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 13/13] mm: hide the FRONTSWAP Kconfig symbol
Date:   Fri, 24 Dec 2021 07:22:46 +0100
Message-Id: <20211224062246.1258487-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Select FRONTSWAP from ZSWAP instead of prompting for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/Kconfig | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 430240289b02b..3326ee3903f33 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -445,20 +445,7 @@ config HAVE_SETUP_PER_CPU_AREA
 	bool
 
 config FRONTSWAP
-	bool "Enable frontswap to cache swap pages if tmem is present"
-	depends on SWAP
-	help
-	  Frontswap is so named because it can be thought of as the opposite
-	  of a "backing" store for a swap device.  The data is stored into
-	  "transcendent memory", memory that is not directly accessible or
-	  addressable by the kernel and is of unknown and possibly
-	  time-varying size.  When space in transcendent memory is available,
-	  a significant swap I/O reduction may be achieved.  When none is
-	  available, all frontswap calls are reduced to a single pointer-
-	  compare-against-NULL resulting in a negligible performance hit
-	  and swap data is stored as normal on the matching swap device.
-
-	  If unsure, say Y to enable frontswap.
+	bool
 
 config CMA
 	bool "Contiguous Memory Allocator"
@@ -523,7 +510,8 @@ config MEM_SOFT_DIRTY
 
 config ZSWAP
 	bool "Compressed cache for swap pages (EXPERIMENTAL)"
-	depends on FRONTSWAP && CRYPTO=y
+	depends on SWAP && CRYPTO=y
+	select FRONTSWAP
 	select ZPOOL
 	help
 	  A lightweight compressed cache for swap pages.  It takes
-- 
2.30.2

