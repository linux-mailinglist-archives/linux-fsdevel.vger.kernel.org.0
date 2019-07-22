Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 823266FCEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfGVJu6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 05:50:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729403AbfGVJu5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=auG+WBB+E2ja85hNasZKDEATZdt3zPPsPEd9jG6xw9E=; b=NlhbxYGZJot8w6XK9LwZyefi0P
        7pANqGTVVBxi1afdz7v8OUxYs3BG/lrjtRbA5C6zftOpNdiQNXNcFUhJ5FQxaiwjTuvSnJ+cyAoBa
        vktF9Bq1wioEfxsR3Pox+8aklKUkRXG3ynpGM7xcXS1dKwzphqlBzdCMb3BJX/O2A8quLXKUi/WHH
        35BjnNcyCfFH9+mngqVOg4+LajSeIBf9XCocndsSCGf/jeFPs1m7UovqtjyTJfK70dRIK1d5cU3dF
        M+VUDT1byZsSkCm/nDYm8Cpg4/JrL8GG1sa5gs5xgE1YCSBLgBCAftD34BbQFmYrm69aI3j5IeRDK
        Wja4NGmg==;
Received: from 089144207240.atnat0016.highway.bob.at ([89.144.207.240] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hpUy7-0005hf-1j; Mon, 22 Jul 2019 09:50:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] xfs: set IOMAP_F_NEW more carefully
Date:   Mon, 22 Jul 2019 11:50:23 +0200
Message-Id: <20190722095024.19075-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722095024.19075-1-hch@lst.de>
References: <20190722095024.19075-1-hch@lst.de>
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
index 951350ec025d..d340db666c06 100644
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

