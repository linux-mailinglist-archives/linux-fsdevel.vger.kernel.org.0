Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B99B7580C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 12:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfF0Ksp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 06:48:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfF0Ksp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YZIstLvvOVjbwqyMiHOXyEM4s8XMoafn2QngRTNnj2o=; b=SvksoWbK4/4xdHGUobg2iB1lm
        NqzINWvemRpc/Y0qLJrhVAegfD4fvnN/FmVO8Io326Z8Y6zAP6fxzZ74DdBzCMbPEDxmqW+gYdLW4
        69V4IgApgVNqGF9PuxTe4H6myP327VGAGEzyBiL8mL76HJ5kZh6raXn50wMrZ2X6gg8aBW4UMGjuQ
        x/H7lA9sL8czsv+HloXetaqpJXQQ2G5xbSwH43GnzrKZp6i/cBnvPydNruY219HRMPkTzHG+9xXCY
        +QxUdI+Hh6UHme/HUylSkORu1tc3iYkiXQ1JkzqVz7obe1Xlw3xZY6OIMw9LkuF/xwkf2H77UO+3F
        ahlOIWppQ==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxJ-000533-7g; Thu, 27 Jun 2019 10:48:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: lift the xfs writepage code into iomap v2
Date:   Thu, 27 Jun 2019 12:48:23 +0200
Message-Id: <20190627104836.25446-1-hch@lst.de>
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

This new version should have addressed all comments from the review,
except that I haven't split iomap.c, which is a little too invasive
with other pending changes to the file.  I do however offer to submit
a split right at the end of the merge window when it is least invasive.

Changes since v1:
 - rebased to the latest xfs for-next tree
 - keep the preallocated transactions for size updates
 - rename list_pop to list_pop_entry and related cleanups
 - better document the nofs context handling
 - document that the iomap tracepoints are not a stable API
