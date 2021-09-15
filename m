Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C001840C03E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 09:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbhIOHMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 03:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhIOHMS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:12:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3EFC061574;
        Wed, 15 Sep 2021 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZpomFWwUpYf+IqpVbx+BDcZslxhkwYY2lCkG5RS4qRY=; b=BEWQ4g879RktvHp67Ny4ElsHRE
        MiSkfHkEbPpI3AWn4qRufIIyGPfVHrP9AXd+ORok+zE95lxJaXgBjWaVBCQcNgUrvF7O0IJnyXL/Z
        yRKtE55VKEPMoQwvbWVf6yxv1/fAUshz7YtBuiAm2/UWa8xstP/5Cbepc3vOkwGKpIyAvdKJ3aqjw
        /Ar9eV3jH9RXVnA0KJEovtEn0QM6xhyxya4d9E1o7M0IXjI0cOegLjHGWOYfN5mcfW4fSUJIWBltK
        NWEU6qalX2Jrsc6jdCtJnJ5MWrAvJ0vXybB2xYgPe/pKuPIEP64BoHrRvZ/a47PYOpUv/XmTYzywJ
        KWs+lUSg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQP3W-00FRzK-Mq; Wed, 15 Sep 2021 07:10:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 11/11] unicode: only export internal symbols for the selftests
Date:   Wed, 15 Sep 2021 09:00:06 +0200
Message-Id: <20210915070006.954653-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
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
index 829c7e2ad764a..768f8ab448b8f 100644
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

