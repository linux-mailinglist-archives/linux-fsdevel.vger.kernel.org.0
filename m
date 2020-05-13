Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488781D0920
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgEMG5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 02:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgEMG5D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 02:57:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44102C061A0C;
        Tue, 12 May 2020 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=e06V50DvlSAd0cjThq/uEzcBoN3nGl+GOyNKKGYH+cE=; b=Cpy9yo5pJaasmJZsjzEAZa0x5+
        gwmF1NxkUhySvtE4qn/S4sEiFThHS+Kf2wfJsyUXCtdxOjhJCemsH620xTWSg9It1OkVL12ImlWuX
        sKjjRO3xKjeb0GaAtwvAWEGPTKomzP07xsg7XavQX6YYU4grcmeva7yxxz85nsKrKj29X2E8DX7e3
        ictdHvmVK71ERYZqFi2ci5q7HgilydEoAZm07OF+vpNKp4fL1xZzDwVufvNMosdns1CGasPEH1L1f
        ce5m/KudHyk/nY6jDXg5+VanH9GKV8PDv0o+nBJPz0wpnnVJ/kikwdDRPdv0sckZoPjqirShS6lTf
        FvXD7b8w==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYlK8-0003UW-S1; Wed, 13 May 2020 06:57:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 01/14] cachefiles: switch to kernel_write
Date:   Wed, 13 May 2020 08:56:43 +0200
Message-Id: <20200513065656.2110441-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513065656.2110441-1-hch@lst.de>
References: <20200513065656.2110441-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__kernel_write doesn't take a sb_writers references, which we need here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/cachefiles/rdwr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 1dc97f2d62013..c0b99ccd9a79f 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -937,7 +937,7 @@ int cachefiles_write_page(struct fscache_storage *op, struct page *page)
 	}
 
 	data = kmap(page);
-	ret = __kernel_write(file, data, len, &pos);
+	ret = kernel_write(file, data, len, &pos);
 	kunmap(page);
 	fput(file);
 	if (ret != len)
-- 
2.26.2

