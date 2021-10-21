Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03B0436814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 18:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbhJUQlX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhJUQlW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:41:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43783C0613B9;
        Thu, 21 Oct 2021 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+HTJWJrd9rZKk81dNjjaOacqrLI32yRAcBDJVKSMPKU=; b=fDQKgsDz6lz/2o0SgY00VzX+Dq
        AVM6dWMf6vomhDcR+uJaiANhzqqDW/KSK1SRfoPUmWVKLSbjJZGA1ZEuvVFjmEDXFAZ6xy1d/dPB+
        H+Y1vzMxLr4gT766Fd9xwI0mLv92P97flZflO7UbnJ9gID7regIXJvm/7sc0sfBvKKZTibRcjwX9I
        S2qaowC3KN03Ms0HB4qSwdf8jc1aDB+pKxBlKaUyKtBgQ+eUWfuokUZv6x3u/x6UhcLqfAfjWQpKH
        GbGnFJo+S1cgErwXS8azOYZ2ogzfwj22prCFURukhk1nC2HeG6AQKpjQxZtmGKnO0OpY6RsYlRGS5
        khIFBxrg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdb5l-008OYu-UU; Thu, 21 Oct 2021 16:38:57 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hch@lst.de, penguin-kernel@i-love.sakura.ne.jp,
        schmitzmic@gmail.com, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 0/3] last batch of add_disk() error handling conversions
Date:   Thu, 21 Oct 2021 09:38:53 -0700
Message-Id: <20211021163856.2000993-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is v3 series of the last patch set which should be considered
once nvdimm/blk driver is removed, as Dan Williams noted it would be
gone and once *all* add_disk() error handling patches have been merged.

I rebased Tetsuo Handa's patch onto the latest linux-next as this
series depends on it, and so I am sending it part of this series as
without it, this won't apply. Tetsuo, does the rebase of your patch
look OK?

If it is not too much trouble, I'd like to ask for testing for the
ataflop changes from Michael Schmitz, if possible, that is he'd just
have to merge Tetsuo's rebased patch and the 2nd patch in this series.
This is all rebased on linux-next tag 20211020.

Changes in this v3:

  - we don't set ataflop registered to true when we fail, an issue
    spotted during review by Tetsuo
  - rebased to take into consideration Tetsuo's changes, both his old
    and the latest patch carried in this series
  - sets the floppy to null on failure from add_disk(), an issue spotted
    by Tetsuo during patch review
  - removes out label from ataflop as suggested by Finn Thain
  - we return the failure from floppy_alloc_disk as suggested by Finn Thain

Luis Chamberlain (2):
  block: make __register_blkdev() return an error
  block: add __must_check for *add_disk*() callers

Tetsuo Handa (1):
  ataflop: remove ataflop_probe_lock mutex

 block/bdev.c            |  5 +++-
 block/genhd.c           | 27 +++++++++++------
 drivers/block/ataflop.c | 66 +++++++++++++++++++++++++----------------
 drivers/block/brd.c     |  7 +++--
 drivers/block/floppy.c  | 17 ++++++++---
 drivers/block/loop.c    | 11 +++++--
 drivers/md/md.c         | 12 ++++++--
 drivers/scsi/sd.c       |  3 +-
 include/linux/genhd.h   | 10 +++----
 9 files changed, 105 insertions(+), 53 deletions(-)

-- 
2.30.2

