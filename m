Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775161F964F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 14:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729776AbgFOMNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 08:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbgFOMNH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:13:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09228C061A0E;
        Mon, 15 Jun 2020 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=fw2+4gebTcJUXyNcS2c+cOqcMRuf3D2bJUNwgAt6wzg=; b=KXplkiHZzZavRX9c6x4yElRiWI
        PiVjHiuc1WKPZpyV3w6ZlaXIrHZltHeHyCTjYjavzt6PR7KhIDHml7hB1ZLKdvm10dVnWSP3eM+Y0
        HKnsa2aAKEn/nE/PQV1MVaQVIyiPqvBqhx1syoFCHVtlJqLvOMhP0j0FxdW3hU+pBLs91PK35jxPH
        d+YX5hfeZeuxVYujnXMdUqDRs1MXj4Zsn2/po/HypByFHGMJgAuELJHs5EeEpTGC+itwTVCqg+kOk
        x664eDt2L1v+i5k8xSm394AaL8F+aQiDWzT18/qpoGHlgEWFaETXPFcIcqSp2nM8DW5YH37wKb1bb
        /CWbG7bA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknz4-0006zA-OK; Mon, 15 Jun 2020 12:13:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 01/13] cachefiles: switch to kernel_write
Date:   Mon, 15 Jun 2020 14:12:45 +0200
Message-Id: <20200615121257.798894-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615121257.798894-1-hch@lst.de>
References: <20200615121257.798894-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__kernel_write doesn't take a sb_writers references, which we need here.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 fs/cachefiles/rdwr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index e7726f5f1241c2..3080cda9e82457 100644
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

