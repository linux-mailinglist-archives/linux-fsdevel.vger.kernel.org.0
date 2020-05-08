Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39871CA700
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 11:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgEHJWs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 05:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbgEHJWp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 05:22:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC34C05BD43;
        Fri,  8 May 2020 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=v2d8pva8LsFTXWqDIrLlQ4NNcDJbw9ZGB5N3mHruM2Q=; b=hy8jbfxBdHRLA63hXlAM8XAENS
        gGYr4RCSkaLOb23GrcvL4ap/hgUcbFR8px9M6FibgZvYzAORKvw5/sirIfzb5hrJzqKwdHvTH+U5u
        bgYMzjpOchyC1Pz5lekkCleC8Dz+efnHbIdY/QNpHZ81n0St9GOqsfAhf5C7zW2mWet1EG9W6P56g
        vWlKWTXudBRjvFIR7/a62Ghnrn4rjNJg0YslRaiU4qwZC0jHHKt0VNdk1GRK1ttGG564UqqnqtLAN
        55ahucBgZ5nf0aZHmcGyH2MErwpXIjAl9pV7vyPv3caHKDphDIeyRJRyhoGuDCJw/druVeDSa2FSR
        jSvB6nXA==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzDR-000084-0I; Fri, 08 May 2020 09:22:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 08/11] integrity/ima: switch to using __kernel_read
Date:   Fri,  8 May 2020 11:22:19 +0200
Message-Id: <20200508092222.2097-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508092222.2097-1-hch@lst.de>
References: <20200508092222.2097-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__kernel_read has a bunch of additional sanity checks, and this moves
the set_fs out of non-core code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 security/integrity/iint.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index e12c4900510f6..1d20003243c3f 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -188,19 +188,7 @@ DEFINE_LSM(integrity) = {
 int integrity_kernel_read(struct file *file, loff_t offset,
 			  void *addr, unsigned long count)
 {
-	mm_segment_t old_fs;
-	char __user *buf = (char __user *)addr;
-	ssize_t ret;
-
-	if (!(file->f_mode & FMODE_READ))
-		return -EBADF;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = __vfs_read(file, buf, count, &offset);
-	set_fs(old_fs);
-
-	return ret;
+	return __kernel_read(file, addr, count, &offset);
 }
 
 /*
-- 
2.26.2

