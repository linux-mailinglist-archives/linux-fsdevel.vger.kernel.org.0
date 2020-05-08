Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AE31CA6FA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 11:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgEHJWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgEHJWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 05:22:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E100C05BD43;
        Fri,  8 May 2020 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/Vw1xBDqcg+had1H7ldfhCCl+Ssv4JonY1VaXlhtXBk=; b=I2fV/Il/XU+eajjiZQcidKGoMT
        QP56q4Zq+TTHB6ncYlzWGgrpbxz/uo9TmD78E/YEV0jmqMMkBZVYJZIntxXpZfkLbPa4d7mth9gUn
        jL9SFH0ecXzMGl24/Jr7EUTaNpPsHZVuoHecEHc1rrZ6iVoRTtJifMi5x9wsVtXzbtr2rzQY3JUYD
        VScP/8znNa9NNBap7UDX3bA8i7GgKHkmUaAtJ6Gs/LAj+D5O3sakvOdDonXtn/i0F9csiafQ15TOy
        1kfHXRJWsiFsUb22CIeRZHzRx6fsUz9VlHejkw2ivZBeLYbXlJTmf8KOYI9nW1DizG07e2Z6vTpOJ
        Bie1R+kQ==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzDG-0008KE-UI; Fri, 08 May 2020 09:22:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 04/11] fs: implement kernel_write using __kernel_write
Date:   Fri,  8 May 2020 11:22:15 +0200
Message-Id: <20200508092222.2097-5-hch@lst.de>
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

Consolidate the two in-kernel write helpers to make upcoming changes
easier.  The only difference are the missing call to rw_verify_area
in kernel_write, and an access_ok check that doesn't make sense for
kernel buffers to start with.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index d91fe7ff6cc55..6b456a257b31c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -531,16 +531,13 @@ EXPORT_SYMBOL(__kernel_write);
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
 {
-	mm_segment_t old_fs;
-	ssize_t res;
 
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	/* The cast to a user pointer is valid due to the set_fs() */
-	res = vfs_write(file, (__force const char __user *)buf, count, pos);
-	set_fs(old_fs);
+	ssize_t ret;
 
-	return res;
+	ret = rw_verify_area(WRITE, file, pos, count);
+	if (ret)
+		return ret;
+	return __kernel_write(file, buf, count, pos);
 }
 EXPORT_SYMBOL(kernel_write);
 
-- 
2.26.2

