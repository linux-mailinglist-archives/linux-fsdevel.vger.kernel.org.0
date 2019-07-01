Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD15C547
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGAVzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:55:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44720 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAVzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:55:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XgsyZiPoqigt0wTp9eM2fKxd51xD82tSal1tU271zVY=; b=CdMxF+fmlNWuahESPETvqEa7kH
        xpjTGooi3KTTM01XuAZBnhU9BKrRsflzPq+N7bFDdgsBpNWF3EmKHsTgA52X7J1Q16SpPrl/mcKtK
        1Yw2uY+/YfUc+1gpNuNaqUgQfq9eG/cw8o47df9PqF5YAAz0xsY7XgUHArdZqLee2dStdniSynZHZ
        iIR9DzEXtPDDgXq9x0UFBHoavjs0MZvSgvVwLrRYt3luvLKERS/iAt1qiFRgjSttuTycUHw6XJD31
        N1jVA3kFyTrWkxuloIsl1UGxlCxLaQiNIyUWXoNgOgSeeAxWZZ8uVdKHXUcJJvYpbupSNWwJm1Rr2
        8i3w+Bdg==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4Gr-0001nI-L6; Mon, 01 Jul 2019 21:55:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 06/15] HACK: disable lockdep annotation in iomap_dio_rw
Date:   Mon,  1 Jul 2019 23:54:30 +0200
Message-Id: <20190701215439.19162-7-hch@lst.de>
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

gfs2 seems to never calls this with i_rwsem held, disable for testing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap.c b/fs/iomap.c
index 63952a7b1c05..264cfb2e796f 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -1885,7 +1885,7 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	struct blk_plug plug;
 	struct iomap_dio *dio;
 
-	lockdep_assert_held(&inode->i_rwsem);
+//	lockdep_assert_held(&inode->i_rwsem);
 
 	if (!count)
 		return 0;
-- 
2.20.1

