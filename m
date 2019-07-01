Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 371915C559
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGAV4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:56:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44836 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAV4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vX2uExoGEoH7cuVcUudPGfuv9M2S/fV8smKpldgjqos=; b=h0/iCV1hBIMMoQco+ii5ZLj+Mk
        a0rt8JPYEcfLSy3IWVh9VwI5q6qjgsHUH3GI47qwTXji5c5er6y4zO4BWAF4qRyifeIusGopYEtiM
        O3q4Aw5Qvv6Zpon0kipBb3bfATKlmkhEGF7kSn7Me1YxHAkvVtZ6HmHk8fYN4ohY8hcraLTH9Gg3M
        g5/QIteYnsL3DBz7YKx1bK1kJ/gPlc0dadojqax4BptAibD/H15JBLpuZYyTPu8VSF7Zx7/j7eUvQ
        8cT3M6nJWt1PVM64CIg53rHuL7oW0yAFD6ByB7ZsAYCP8nIMCHfb1BkyGGV9BEsMkFmJqLr2bitP8
        wzwAUfwg==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4HZ-0001u9-JQ; Mon, 01 Jul 2019 21:56:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 12/15] gfs2: use iomap_bmap instead of generic_block_bmap
Date:   Mon,  1 Jul 2019 23:54:36 +0200
Message-Id: <20190701215439.19162-13-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
References: <20190701215439.19162-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

No need to indirect through get_blocks and buffer_heads when we can
just use the iomap version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/aops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 030210f1430b..15a234fb8f88 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -697,7 +697,7 @@ static sector_t gfs2_bmap(struct address_space *mapping, sector_t lblock)
 		return 0;
 
 	if (!gfs2_is_stuffed(ip))
-		dblock = generic_block_bmap(mapping, lblock, gfs2_block_map);
+		dblock = iomap_bmap(mapping, lblock, &gfs2_iomap_ops);
 
 	gfs2_glock_dq_uninit(&i_gh);
 
-- 
2.20.1

