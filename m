Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0A41A29D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 00:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238267AbhI0WHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 18:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbhI0WHI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:07:08 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E33AC061775;
        Mon, 27 Sep 2021 15:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=OH7OyuzUfCp9u8gErHhVg3xkJixK9lFHEReF7qenfiE=; b=A0tL2FxoD+nA88GKKxQfIqQt+u
        5joFEUlvjWS9Kh3iXG8l4EgdCQ3Z0LK/2K8kHPvo/ZxPzAtg6qAaeAU4hbWiZxGCQSYYKarC4MzFv
        ABBKywabOLyMwmttu/vwfgj/+bEe0EHZNqXM+vXlKt5RgclhVYpvqojBX3l6JD66O5K1V0r5fO9lm
        RnMtxAA61+RcCD87HuxYTxbEcDw+83IlZDKd93NMG7GqWA8fd8ovmBIcugoyY4oKq9o3yRsO1A1Bq
        14YG+t2wiauf9xWt5GtrEB9pb1WwBP12aForrGI4Hv0oiHXXNUIshXv9DJ807gymWOb1ob9ziG85e
        6PZUPRMQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyij-004VaK-1s; Mon, 27 Sep 2021 22:03:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hch@lst.de, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 0/2] block: 7th -- last batch of add_disk() error handling conversions
Date:   Mon, 27 Sep 2021 15:03:30 -0700
Message-Id: <20210927220332.1074647-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 7th and last set of driver conversions for add_disk() error
handling. The entire set of pending changes can be found on my
20210927-for-axboe-add-disk-error-handling branch [0].

Changes on this v2:

  - rebased onto linux-next tag 20210927
  - I modified the drivers to be sure to treat an existing block device on
    probe as a non-issue, and expanded the documentation to explain why we
    want to driver's probe routine to behave this way.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-for-axboe-add-disk-error-handling

Luis Chamberlain (2):
  block: make __register_blkdev() return an error
  block: add __must_check for *add_disk*() callers

 block/bdev.c            |  5 ++++-
 block/genhd.c           | 27 ++++++++++++++++++---------
 drivers/block/ataflop.c | 20 +++++++++++++++-----
 drivers/block/brd.c     |  7 +++++--
 drivers/block/floppy.c  | 14 ++++++++++----
 drivers/block/loop.c    | 11 ++++++++---
 drivers/md/md.c         | 12 +++++++++---
 drivers/scsi/sd.c       |  3 ++-
 include/linux/genhd.h   | 10 +++++-----
 9 files changed, 76 insertions(+), 33 deletions(-)

-- 
2.30.2

