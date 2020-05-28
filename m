Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892BB1E56CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 07:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgE1FlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 01:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgE1Fk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 01:40:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5FEC05BD1E;
        Wed, 27 May 2020 22:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OfbCGpVq2bSVaxzX21SAbOgZUqmrr254Kbi/uKi31mE=; b=S5cqbOTDRp5dleW5ZVjmCZMgnu
        1SwnwIkimBF14ZxVRjVGNMMIKvyBjK79Sc9tkggRt3QluIug/5YhnLZotNXsMFGM/yd47DUmZdCQ3
        eKobcr/s0EIDpuAWd4YckaRcgRyoHNpNvoDCSSrl9B/ruy1JFxIxh3lGosjOTTcwVUTzY9FkUJGS5
        FkEavwas4oZ+yPQqpdWT03zfKRBzkbmZqdGKpHjm703RKnnX+NsJARtOwYhY54NHs1BJeXd6rX0Da
        nznZy7SudQgQrhLjIKOzbA5zF+V/xPX6pighYz9SCdA+ba4TiF5vyMpupj7e1uQB1lulWHPsKNCDH
        Gb+xIt5A==;
Received: from p4fdb1ad2.dip0.t-ipconnect.de ([79.219.26.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeBHk-0002Ka-87; Thu, 28 May 2020 05:40:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 04/14] fs: unexport __kernel_write
Date:   Thu, 28 May 2020 07:40:33 +0200
Message-Id: <20200528054043.621510-5-hch@lst.de>
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

This is a very special interface that skips sb_writes protection, and not
used by modules anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/read_write.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index bbfa9b12b15eb..2c601d853ff3d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -522,7 +522,6 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	inc_syscw(current);
 	return ret;
 }
-EXPORT_SYMBOL(__kernel_write);
 
 ssize_t kernel_write(struct file *file, const void *buf, size_t count,
 			    loff_t *pos)
-- 
2.26.2

