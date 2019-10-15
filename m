Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F31D7A3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbfJOPnz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 11:43:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731230AbfJOPnz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mF/08n2fAE+Cf0p2QEGUuW9hepiucEN9OJ/KULoXRyc=; b=r+E134qwyxU9UwZ8oO6v1JCkl
        Tgw/yvyODHCVCX1f9MscjA9NAjC6p4MS8gLFLbmCqzpkc0gMBZPDqEjigumw2zUw3Ibi/18vCLHmC
        cOmJEeCft0HVXR9ECaqL2n4OaVE7C+W+M0M8QmAYfM0fMktGNKRMuBBzEzSwZpuLOAqDiGORaNYoh
        NJGaQ5F8iRE2WGVYnvi41guo2YNIIze+x+ihpqaoeBLihiaZOvRrKhVD93O+JSYFJoNH3HrTGm80f
        qpmCK1Qwgo8/+L744celIBR2zbMZ4wAZUY0o8eHfOW9OCRDUh3PP9Snp5v/Y+XY56VW+V6R4Y0mog
        CQtrQnLsw==;
Received: from [2001:4bb8:18c:d7b:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKOzG-0007u8-Gh; Tue, 15 Oct 2019 15:43:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: lift the xfs writepage code into iomap v7
Date:   Tue, 15 Oct 2019 17:43:33 +0200
Message-Id: <20191015154345.13052-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series cleans up the xfs writepage code and then lifts it to
fs/iomap/ so that it could be use by other file system.

Note that in this version a lot of the reviewed-by tag got dropped
as the patch organization changed quite a bit (the actual final
result changes very little, though).

Changes since v6:
 - actually add trace.c to the patch
 - move back to the old order that massages XFS into shape and then
   lifts the code to iomap
 - cleanup iomap_ioend_compare
 - cleanup the add_to_ioend checks

Changes since v5:
 - move the tracing code to fs/iomap/trace.[ch]
 - fix a bisection issue with the tracing code
 - add an assert that xfs_end_io now only gets "complicated" completions
 - better document the iomap_writeback_ops methods in iomap.h

Changes since v4:
 - rebased on top 5.4-rc1
 - drop the addition of list_pop / list_pop_entry
 - re-split a few patches to better fit Darricks scheme of keeping the
   iomap additions separate from the XFS switchover

Changes since v3:
 - re-split the pages to add new code to iomap and then switch xfs to
   it later (Darrick)

Changes since v2:
 - rebased to v5.3-rc1
 - folded in a few changes from the gfs2 enablement series

Changes since v1:
 - rebased to the latest xfs for-next tree
 - keep the preallocated transactions for size updates
 - rename list_pop to list_pop_entry and related cleanups
 - better document the nofs context handling
 - document that the iomap tracepoints are not a stable API
