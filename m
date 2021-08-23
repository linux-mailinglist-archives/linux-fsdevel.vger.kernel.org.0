Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8623F4ABB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 14:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhHWMhO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhHWMhO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:37:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEBC061575;
        Mon, 23 Aug 2021 05:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sfkVfOgG74aYLnhMI+d3SuhRKy5IdFLySI4HRvR755E=; b=v+RNWWQzXpfrQxjL0zkwnUqwFY
        LsJIrmvxJVdeDYpfG0kSJyKMJQ+xwYyHOAWdBKcWRRyw4g8WiaUOqY61UdYzorc9HoQqN6Sh7u9HD
        Di/+ale2RACtQ+b68boj108W8ueu4lJhNolGERvfTDd1nv3ICQt/YAPfujeliAu26gdmnZ6lka3kd
        dNT562U7MROIVArLLmqTNJuC24A3CoxxIFiUb5tdBvlS24wG4XFtMREyjE6Ib0mzODnAyLOIVd+yr
        7fu5bqNRTfmxHN5/8CQVZyCQ2eXDcCbkA34QG8SSXcgarm6r0GZByGK2C2wAks73XryoXcO4RSD5K
        oFSNxIew==;
Received: from [2001:4bb8:193:fd10:c6e8:3c08:6f8b:cbf0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI9Aa-009izg-W5; Mon, 23 Aug 2021 12:35:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: dax_supported() related cleanups
Date:   Mon, 23 Aug 2021 14:35:07 +0200
Message-Id: <20210823123516.969486-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series first clarifies how to use fsdax in the Kconfig help a bit,
and te untangles the code path that checks if fsdax is supported.

Diffstat
 drivers/dax/super.c   |  191 +++++++++++++++++++-------------------------------
 drivers/md/dm-table.c |    9 --
 drivers/md/dm.c       |    2 
 fs/Kconfig            |   17 +++-
 fs/ext2/super.c       |    3 
 fs/ext4/super.c       |    3 
 fs/xfs/xfs_super.c    |   16 +++-
 include/linux/dax.h   |   41 +---------
 8 files changed, 113 insertions(+), 169 deletions(-)
