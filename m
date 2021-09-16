Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2440D922
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238467AbhIPL5g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 07:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238437AbhIPL5g (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:57:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 310176058D;
        Thu, 16 Sep 2021 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631793375;
        bh=xQQHoYXzLHYfntIuTWMNjDg9VWuR9pgURBkImnFaPhs=;
        h=From:To:Cc:Subject:Date:From;
        b=qiTTqsQ+PHdvIh2z+XZVZVBGL0Bl7WYBE30WLP/fIab3fLEcBT0zXDdI/yvJPbnxY
         uX7wUvLkJMp5NRhGj9P5X7H16thJSl1ZqdbxV/m32NrvuHkNr8lyNofGd/DFERKDF8
         uYaeu1n0M4voiSx9QhNJwpDe7vnAFB/++tCxB+Ahw1P3081mzcTAriypVtqtaAImJS
         5Kpd7GpsxGapoBsi4RoOnpuIq/eejXeFYOKXOchBddaBV/S5j0T1CDtPaKfac1DgAg
         UwSer4N21emvJjujgyBmkNZdXuoaDEaFpDe2VqMy8N8mM+YoOIeuiKKemQDkymjNfO
         X+y71VEn3osOg==
From:   Sasha Levin <sashal@kernel.org>
To:     stable-commits@vger.kernel.org, djwong@kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Patch "iomap: pass writeback errors to the mapping" has been added to the 5.10-stable tree
Date:   Thu, 16 Sep 2021 07:56:14 -0400
Message-Id: <20210916115614.739479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a note to let you know that I've just added the patch titled

    iomap: pass writeback errors to the mapping

to the 5.10-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iomap-pass-writeback-errors-to-the-mapping.patch
and it can be found in the queue-5.10 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.



commit 078b33c7e63a833578dcb49316c689a6d1b40487
Author: Darrick J. Wong <djwong@kernel.org>
Date:   Tue Aug 10 18:32:55 2021 -0700

    iomap: pass writeback errors to the mapping
    
    [ Upstream commit b69eea82d37d9ee7cfb3bf05103549dd4ed5ffc3 ]
    
    Modern-day mapping_set_error has the ability to squash the usual
    negative error code into something appropriate for long-term storage in
    a struct address_space -- ENOSPC becomes AS_ENOSPC, and everything else
    becomes EIO.  iomap squashes /everything/ to EIO, just as XFS did before
    that, but this doesn't make sense.
    
    Fix this by making it so that we can pass ENOSPC to userspace when
    writeback fails due to space problems.
    
    Signed-off-by: Darrick J. Wong <djwong@kernel.org>
    Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 10cc7979ce38..caed9d98c64a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1045,7 +1045,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
 
 	if (error) {
 		SetPageError(page);
-		mapping_set_error(inode->i_mapping, -EIO);
+		mapping_set_error(inode->i_mapping, error);
 	}
 
 	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
