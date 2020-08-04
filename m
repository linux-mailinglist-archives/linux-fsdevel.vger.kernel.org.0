Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0923BDEC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgHDQSH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 12:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgHDQR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:17:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09604C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2020 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KiHlXYS4cF7DbYKmhvpQJucCJKOOEpy6PdUPrjFSFcU=; b=mpVj2g/h7OLKGHc/P8PtqZSCwY
        JwFqnxG75JALlCY9NeAC3OGGbHXe4B5iN4snjrWt8zUx4pLU2uIOd/uuy0uU28ddRaQ8svacINH+z
        zZVaSleGpmpBhP6PxeQb8NUaNIEXi/eU46KSlms0Hw05G1Fe8y2zJAmhCR7oRilU2DNX1fHgTkV3A
        6Th/ybwF4TUC6PflViuoiuHdsy4lKnVlaKFL2qbeSEwnTJV+SJqGs2aS4zwMPV7yzpM2HLZ+Opn+J
        3QvbOT9w6uccaH6iBfWzgLDUXIP2agGAM2/hw4lXUp2qXUM/vvlRXiwIwNvKf1yBa21ZexQ0csOd2
        CH7DzTQg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2zdV-0002dy-B6; Tue, 04 Aug 2020 16:17:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-nvdimm@lists.01.org
Subject: [PATCH 0/4] Remove nrexceptional tracking
Date:   Tue,  4 Aug 2020 17:17:51 +0100
Message-Id: <20200804161755.10100-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We actually use nrexceptional for very little these days.  It's a constant
source of pain with the THP patches because we don't know how large a
shadow entry is, so either we have to ask the xarray how many indices
it covers, or store that information in the shadow entry (and reduce
the amount of other information in the shadow entry proportionally).
While tracking down the most recent case of "evict tells me I've got
the accounting wrong again", I wondered if it might not be simpler to
just remove it.  So here's a patch set to do just that.  I think each
of these patches is an improvement in isolation, but the combination of
all four is larger than the sum of its parts.

I'm running xfstests on this patchset right now.  If one of the DAX
people could try it out, that'd be fantastic.

Matthew Wilcox (Oracle) (4):
  mm: Introduce and use page_cache_empty
  mm: Stop accounting shadow entries
  dax: Account DAX entries as nrpages
  mm: Remove nrexceptional from inode

 fs/block_dev.c          |  2 +-
 fs/dax.c                |  8 ++++----
 fs/inode.c              |  2 +-
 include/linux/fs.h      |  2 --
 include/linux/pagemap.h |  5 +++++
 mm/filemap.c            | 15 ---------------
 mm/truncate.c           | 19 +++----------------
 mm/workingset.c         |  1 -
 8 files changed, 14 insertions(+), 40 deletions(-)

-- 
2.27.0

