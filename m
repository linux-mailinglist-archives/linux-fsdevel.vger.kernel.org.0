Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE71CA714
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 11:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgEHJW2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 May 2020 05:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgEHJW1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 May 2020 05:22:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2C6C05BD43;
        Fri,  8 May 2020 02:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xPhGP2jiYAjHpxSk/ggsWDYG1ptmeqnodXQwagIjz80=; b=O9BYEco6eWqsAs1PWLYmxNpjmD
        PoBKDzzLadPZjumipcrGt30j682jPS2N/LZPgAjG+d9zE7N64mb9uCLbtiC1w0iSlPNe4pHCebO9J
        ucCuOlaBfVYZPQ9xMintsgxB3rniNoIJPGggd5MGpbFnGdD8R0JnTVnRa9bt/5C/5036+UID/T3mk
        dS69zQ2VmCyxnm2Kk6pB3iTZDO3ddwPfeHSrh6Vhj/gNcSUJpttTphD4m9/pRK0ZKO5mdeBscV8AH
        Ow2hy6r/9QNcOKCd/xVixYFQcSeOEWmZ7zZK+tLbWQE+kZ2ueXryc5miatQD0NAdu+j0jmzAvzqjH
        5Gn3wVYQ==;
Received: from [2001:4bb8:180:9d3f:90d7:9df8:7cd:3504] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWzD9-0008Ii-AY; Fri, 08 May 2020 09:22:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 01/11] fs: call file_{start,end}_write from __kernel_write
Date:   Fri,  8 May 2020 11:22:12 +0200
Message-Id: <20200508092222.2097-2-hch@lst.de>
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

We always need to take a reference on the file system we are writing
to.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15eb..d5aaf3a4198b9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -508,6 +508,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	if (!(file->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 
+	file_start_write(file);
 	old_fs = get_fs();
 	set_fs(KERNEL_DS);
 	p = (__force const char __user *)buf;
@@ -520,6 +521,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 		add_wchar(current, ret);
 	}
 	inc_syscw(current);
+	file_end_write(file);
 	return ret;
 }
 EXPORT_SYMBOL(__kernel_write);
-- 
2.26.2

