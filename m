Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBBA3F069B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhHROYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239958AbhHROYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:24:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38145C0612A3;
        Wed, 18 Aug 2021 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EItct/4LybJFgbzlVrgpqSv7WDkE+DpQx7uqSXk8vHY=; b=Oi9YlwS38JMx8g2TCuOBCZ/rGs
        FvpX/QMst217W1jvJ/yiGztjw5E2p9zV9VDhXbodHOXs9Gb2Ka2LUWolbL4+Q0sF+deWk9K6/lRAI
        RN76vlgkG69i1yiVq0wX/GGS8/8xmU24iFYX7fdR23FRDtBRYs7N2Wvcfs6U2eo6C0tcQ8+USY4bn
        03ZTm/qeArw87v+PRoTkOmIAuoruSYRtkoZPK/J0QMITKJd1ZX9FxM+eWsrfruc5qodR2tx5vNkWA
        f6spZbtYv/Xs2ApMtsuX9sNdXziaMqzs4Eqm1GMLiGKD9xdioADPx4Op+s39mNMwQLAnzgS8LDAHY
        LtaUuS0Q==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMRk-003vEu-0m; Wed, 18 Aug 2021 14:21:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 11/11] unicode: only export internal symbols for the selftests
Date:   Wed, 18 Aug 2021 16:06:51 +0200
Message-Id: <20210818140651.17181-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The exported symbols in utf8-norm.c are not needed for normal
file system consumers, so move them to conditional _GPL exports
just for the selftest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/utf8-norm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 829c7e2ad764..768f8ab448b8 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -17,7 +17,6 @@ int utf8version_is_supported(const struct unicode_map *um, unsigned int version)
 	}
 	return 0;
 }
-EXPORT_SYMBOL(utf8version_is_supported);
 
 /*
  * UTF-8 valid ranges.
@@ -407,7 +406,6 @@ ssize_t utf8nlen(const struct unicode_map *um, enum utf8_normalization n,
 	}
 	return ret;
 }
-EXPORT_SYMBOL(utf8nlen);
 
 /*
  * Set up an utf8cursor for use by utf8byte().
@@ -442,7 +440,6 @@ int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
 		return -1;
 	return 0;
 }
-EXPORT_SYMBOL(utf8ncursor);
 
 /*
  * Get one byte from the normalized form of the string described by u8c.
@@ -588,4 +585,10 @@ int utf8byte(struct utf8cursor *u8c)
 		}
 	}
 }
-EXPORT_SYMBOL(utf8byte);
+
+#ifdef CONFIG_UNICODE_NORMALIZATION_SELFTEST_MODULE
+EXPORT_SYMBOL_GPL(utf8version_is_supported);
+EXPORT_SYMBOL_GPL(utf8nlen);
+EXPORT_SYMBOL_GPL(utf8ncursor);
+EXPORT_SYMBOL_GPL(utf8byte);
+#endif
-- 
2.30.2

