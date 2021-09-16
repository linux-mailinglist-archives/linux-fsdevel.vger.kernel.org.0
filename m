Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3675440D906
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Sep 2021 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbhIPLrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 07:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233746AbhIPLrj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:47:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91CBC60F3A;
        Thu, 16 Sep 2021 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631792779;
        bh=ilSfgE9OeRokKUSCpFGCI15iwJ6hLWzm6PfminbXi64=;
        h=From:To:Cc:Subject:Date:From;
        b=MUypo5OLPxXil1kqqB1cw9Vj1IQCB+f0vuijaT3GU3XH00Y2oIBACH7s1A5Spuptg
         JXCQ5TJRvC0yg4JbZWwABs/ztZmqtl6LyEyFrj8rDXkW06/sT+N66tjvVUD/zCc81f
         NPk8gnbLcCQtVHTFIi3pp4c12fI4fiVo9gid22E4NH1KlUhMxOhpkYUBvyj8vQ89Jy
         o/+HcYCUNBgBsliq5gHzLiiwerdxQQfexSQrI+Qs6Y+OZLZNQMzqnNjxTsV1pJRjgL
         /C4Gc9tqDR/x2ezG+wfx2oVkVwbUdebPYBEVgNEzg13YxaSIiXCVc8YG5LTaYoPSZq
         io2pnOstn2SsQ==
From:   Sasha Levin <sashal@kernel.org>
To:     stable-commits@vger.kernel.org, djwong@kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Patch "iomap: pass writeback errors to the mapping" has been added to the 5.13-stable tree
Date:   Thu, 16 Sep 2021 07:46:17 -0400
Message-Id: <20210916114617.720822-1-sashal@kernel.org>
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

to the 5.13-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     iomap-pass-writeback-errors-to-the-mapping.patch
and it can be found in the queue-5.13 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.



commit a1ee334c1e3ac554e238a70b451c2425325096f6
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
index 9023717c5188..35839acd0004 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1045,7 +1045,7 @@ iomap_finish_page_writeback(struct inode *inode, struct page *page,
 
 	if (error) {
 		SetPageError(page);
-		mapping_set_error(inode->i_mapping, -EIO);
+		mapping_set_error(inode->i_mapping, error);
 	}
 
 	WARN_ON_ONCE(i_blocks_per_page(inode, page) > 1 && !iop);
