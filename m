Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124F644A8C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 09:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244205AbhKIIgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 03:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244164AbhKIIga (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 03:36:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED8CC061764;
        Tue,  9 Nov 2021 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2hdJQNYtTkHjlgB+ErQ7+D3qJYkOGkFpVLGZwHIDkoE=; b=v01uu7zuFXE6OzaFnvNPLS6DM9
        we1jFH8kq7XG7NoLThXOUN3woQ9moHW3tiBxvJSA8H/93eklUaznPl9SEz80oUz+eeflZ+Dhej1Bi
        B+EkFwLRDIwwJ1UpBNlsOL2xFgcVPbPgOO7bgTWTzwIQzb1KlCPzKVh8u9AtdTJVUPTsWSM6EyZXv
        dSZ5fvCfriseWTA0NZMREA8ccwUlhgXdDjjXrHAC8JalJha4nWoJjQPbtm4titoop7ij7F4fLuaLI
        tvHVcPs5ixt4k51zTEEtpN7jI6Zm0Mi5taVD7fWcCjaM6P2ZTsJ4MehB/rsw/CjXm3ZEO/SiJQbx3
        lv78QPEw==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkMZT-000s2I-1A; Tue, 09 Nov 2021 08:33:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        dm-devel@redhat.com, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 12/29] fsdax: remove a pointless __force cast in copy_cow_page_dax
Date:   Tue,  9 Nov 2021 09:32:52 +0100
Message-Id: <20211109083309.584081-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Despite its name copy_user_page expected kernel addresses, which is what
we already have.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 4e3e5a283a916..73bd1439d8089 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -728,7 +728,7 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
 		return rc;
 	}
 	vto = kmap_atomic(to);
-	copy_user_page(vto, (void __force *)kaddr, vaddr, to);
+	copy_user_page(vto, kaddr, vaddr, to);
 	kunmap_atomic(vto);
 	dax_read_unlock(id);
 	return 0;
-- 
2.30.2

