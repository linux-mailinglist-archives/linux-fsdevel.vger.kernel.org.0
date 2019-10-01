Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9693C2E01
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfJAHOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 03:14:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfJAHOG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=05bkF6rfXAAwDpMMZrz27fGcm2XNmSRHMddlz5fNxtY=; b=i4V+yewNt9R2912iXLKimNDqM
        EpdrSULekBLGo9gzqoPDsaNCL27p62xEEsZYoqEQXC7mTee+SberSVePBkj6EIg5cMXX4Y5apQX1o
        vfZKrbJOGaPcp0vrChcQV6vYvbWU/+H6gsnVb70u5QiPqfL2jNAI/MBCrYe7LvNZJoH3IaYn0VIki
        ShR+kWh9lyalkXDWPeRK6ulvMK6a0GzUUsAs1tZv3hU+aeiq0eIzvAGo4qdGp5pPfMO9zvF6GMk85
        r1GU7fLa5IJ0bPVeGzNQ67/05NZpXxnOvgiSb3P9w5nOZXL2VlHZkkzmlKuu66HKGbVLhkYL0YZHK
        xgl0vh1sQ==;
Received: from 089144211233.atnat0020.highway.a1.net ([89.144.211.233] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCMG-0008Cr-Mx; Tue, 01 Oct 2019 07:14:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: lift the xfs writepage code into iomap v5
Date:   Tue,  1 Oct 2019 09:11:41 +0200
Message-Id: <20191001071152.24403-1-hch@lst.de>
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
fs/iomap.c so that it could be use by other file system.  I've been
wanting to this for a while so that I could eventually convert gfs2
over to it, but I never got to it.  Now Damien has a new zonefs
file system for semi-raw access to zoned block devices that would
like to use the iomap code instead of reinventing it, so I finally
had to do the work.

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
