Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670D41AD27E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgDPWBh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728550AbgDPWBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33AEC0610D5;
        Thu, 16 Apr 2020 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=LUwhSTK1vMW3m2USN7WX85bxcMLmlt2NFl9UXdFjwsc=; b=Oo8EIsV+2xcGYrCltYUJlK2dh/
        TtFkLrmnCc0WOs62+X17ev094OaKmdn4i5Rkcgfk0i+kwdwoH2dVZsvo6XQOkTiBSg0tcnSQ0JmDJ
        JSGAG998zr4qabZ8tjpyzHeC8uhBhu0L0VSx37ubLPJjpJTIEmgavnN4HlR3p3seytI/3YNQbW3Yi
        fe+kgdgB5vkI9uKk5g7tVcOVVTzpu4B6QxOc1NCSoeg079n5ef2AuIX7V6fGAnxEYc3kmfhPow/jE
        LE8Hb2dN5Oz3gw84FWeDN3Dcj0L8qidWVWWVAfVIL7Qt8rfThSiOSfK8lDSCYKgirWgypDC/QQ4Sz
        0X/9eZiA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPCZg-0003UV-J6; Thu, 16 Apr 2020 22:01:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 06/11] s390: Add clear_bit_unlock_is_negative_byte implementation
Date:   Thu, 16 Apr 2020 15:01:25 -0700
Message-Id: <20200416220130.13343-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
References: <20200416220130.13343-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This is the generic implementation.  I can't figure out an optimised
implementation for s390.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/bitops.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index 431e208a5ea4..d313ca6affaf 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -241,6 +241,15 @@ static inline void arch___clear_bit_unlock(unsigned long nr,
 	arch___clear_bit(nr, ptr);
 }
 
+static inline bool arch_clear_bit_unlock_is_negative_byte(unsigned int nr,
+						volatile unsigned long *p)
+{
+	arch_clear_bit_unlock(nr, p);
+	return arch_test_bit(7, p);
+}
+#define arch_clear_bit_unlock_is_negative_byte \
+	arch_clear_bit_unlock_is_negative_byte
+
 #include <asm-generic/bitops/instrumented-atomic.h>
 #include <asm-generic/bitops/instrumented-non-atomic.h>
 #include <asm-generic/bitops/instrumented-lock.h>
-- 
2.25.1

