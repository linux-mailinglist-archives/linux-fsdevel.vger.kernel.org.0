Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7265C54A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfGAVzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:55:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAVzo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z+qKL9RRNKxmk/kCJ6tXmEcYA51nBFDH9WG0ncD5vLQ=; b=EzL8AQ/jEUwo/OYQ59VO37/Oku
        64ueMBcCId3u+wczbAB/Cj5usMVAtbwx/gctgnE202wwRrnCooDJQBd1cll7T9TYtSBNgKhXR/Sb6
        bbFDUfLIHsKKpLq3z2gyp5ni628a6osXCR3WPMOYv/h8GMWPQv2G/0ze9397X8DTMn/8B5KwIVRch
        mT2ZUkisAp/a3WRV+YlAUkqVeP8VUnIqcyvhpirWe+TZsb+FXT03Dn00692cuyicJBXhDWU/6mcCd
        nDCXeUWd4HbEGdISQLhgV45lSLIbOE55mZxA17vE8TODPxiL396tV3cOYxWHH9OxiX7TKLAjJE3ZY
        GKFBYijQ==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4Gz-0001oU-U7; Mon, 01 Jul 2019 21:55:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 07/15] gfs2: use page_offset in gfs2_page_mkwrite
Date:   Mon,  1 Jul 2019 23:54:31 +0200
Message-Id: <20190701215439.19162-8-hch@lst.de>
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

Without casting page->index to a guaranteed 64-bit type the value
might be treated as 32-bit on 32-bit platforms and thus get truncated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 1cb0c3afd3dc..282a4aaab900 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -424,7 +424,7 @@ static vm_fault_t gfs2_page_mkwrite(struct vm_fault *vmf)
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_alloc_parms ap = { .aflags = 0, };
 	unsigned long last_index;
-	u64 pos = page->index << PAGE_SHIFT;
+	u64 pos = page_offset(page);
 	unsigned int data_blocks, ind_blocks, rblocks;
 	struct gfs2_holder gh;
 	loff_t size;
-- 
2.20.1

