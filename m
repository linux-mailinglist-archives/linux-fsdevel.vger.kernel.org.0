Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963141E56B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 07:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgE1FlW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 01:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbgE1FlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 01:41:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77084C05BD1E;
        Wed, 27 May 2020 22:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=RKgk8zViaf8A5u7/beCuCOI0498LURgV/aa2JhdiYjs=; b=Zn6qhVBMpAn77GXpcuKN/iHPMA
        RbRTTRBammj4MrsO8AhNVVSuA0xsSJSsIlU8dOckiWeZ2FXN1+ty9K4+RR90K6u33N8xrKChrqQkb
        PwSsuITP+jEHA2q84Lxc3Uc3SGlPHG2HSK+fvMsnSPRXMyO+lGTf0rZxtCr54e8LTXDCJEIPdDL39
        6Nmg4vnARVXBh55dKoyPG5OEzrZRfZIUf5xncLNpj9SlvCp1eGWhS9jySc1peFI7eOVwkUZwdhSbD
        ui3LQbBjdHrJ3zEYg7ikFoVUuPOiZsz8+5NO3ug/7J/qII85sH2qNsEfBw0lXznhEentn4RdTEnwy
        un2XVTVQ==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeBI6-0002RT-Hj; Thu, 28 May 2020 05:41:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 12/14] fs: implement kernel_read using __kernel_read
Date:   Thu, 28 May 2020 07:40:41 +0200
Message-Id: <20200528054043.621510-13-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528054043.621510-1-hch@lst.de>
References: <20200528054043.621510-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate the two in-kernel read helpers to make upcoming changes
easier.  The only difference are the missing call to rw_verify_area
in kernel_read, and an access_ok check that doesn't make sense for
kernel buffers to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bd12af8a895c8..4e19152a7efe0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -453,15 +453,12 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 
 ssize_t kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 {
-	mm_segment_t old_fs;
-	ssize_t result;
+	ssize_t ret;
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	/* The cast to a user pointer is valid due to the set_fs() */
-	result = vfs_read(file, (void __user *)buf, count, pos);
-	set_fs(old_fs);
-	return result;
+	ret = rw_verify_area(READ, file, pos, count);
+	if (ret)
+		return ret;
+	return __kernel_read(file, buf, count, pos);
 }
 EXPORT_SYMBOL(kernel_read);
 
-- 
2.26.2

