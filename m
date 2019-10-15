Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B622D7A1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbfJOPoB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 11:44:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731230AbfJOPn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z2mOV5fCnzJ/ajtJffEAioA43RGvYrL3qCbBjued7wQ=; b=CdNtKYwSXmP7KlUNGRzsNW9j82
        Vn6sBfLdpMUS6sC/oIgDOCC9n9TxPv1q1B4AchmEVzjGq3d9pz8pCa3euTaYQ1ZvOCv44+Yy2cmRz
        F4xorByijm4gHqGmShZ5O/BwNiARIEmeBMKSTFr0/Aca4tvn2qPLhqh0JZMH1AcMgbW6wVsNnDM4N
        arv2+HS4NY7sKICPf7FoW/68/C91s2sjvqVa+B6DOSlZoZRvJTAJepYaAkyl/HFOxRUMv6sg5O392
        CnaudvhiSxtLY/I5P/JTExcTSRYjpEkqZF6Ohrmdfb+q02cVmZtMRN9HZHG73oEo+mt172wT/Jh+0
        VnF/b7Jw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKOzM-0007uc-Rf; Tue, 15 Oct 2019 15:43:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] xfs: set IOMAP_F_NEW more carefully
Date:   Tue, 15 Oct 2019 17:43:35 +0200
Message-Id: <20191015154345.13052-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191015154345.13052-1-hch@lst.de>
References: <20191015154345.13052-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't set IOMAP_F_NEW if we COW over and existing allocated range, as
these aren't strictly new allocations.  This is required to be able to
use IOMAP_F_NEW to zero newly allocated blocks, which is required for
the iomap code to fully support file systems that don't do delayed
allocations or use unwritten extents.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 54c9ec7ad337..c0a492353826 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -707,9 +707,12 @@ xfs_file_iomap_begin_delay(
 	 * Flag newly allocated delalloc blocks with IOMAP_F_NEW so we punch
 	 * them out if the write happens to fail.
 	 */
-	iomap_flags |= IOMAP_F_NEW;
-	trace_xfs_iomap_alloc(ip, offset, count, whichfork,
-			whichfork == XFS_DATA_FORK ? &imap : &cmap);
+	if (whichfork == XFS_DATA_FORK) {
+		iomap_flags |= IOMAP_F_NEW;
+		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &imap);
+	} else {
+		trace_xfs_iomap_alloc(ip, offset, count, whichfork, &cmap);
+	}
 done:
 	if (whichfork == XFS_COW_FORK) {
 		if (imap.br_startoff > offset_fsb) {
-- 
2.20.1

