Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446FC400920
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Sep 2021 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351026AbhIDBkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 21:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351014AbhIDBkm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 21:40:42 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4B1C061575;
        Fri,  3 Sep 2021 18:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TQ80OKAWeIbCJBkkv2wko3z0JghBDWZldcKGy2+/JtU=; b=YVIKUi+7CrVfLqKI9PLwSgdSev
        JNLbK12ZAtZ96F7k3Dst6M0nucVGxz9HnoUVmByGsxtH2TSA+xKUDTCEggs7lTG9sPfBfHJfDQ3kV
        iXt56Oc3YUrHM8lSudbyOpbNt/vMZYprGyVKrNsZVYt26lAh4JTZKTCUwXR9ezdoqiZPeZ+/tvGPP
        1qkknba3VlFkhoUa7CYCiHKjq17V3BcfUVTiu9j4myKPJogUeyo1EzIzfdJJC4HoU4QBHArsyAAwy
        +bJozZrXbIhmagg6/rh4IkZRGyuSnp+HpYoEERg+Oi/aY5b2sHBj1OZl+DKv3KijxBv8EB91o2E66
        /oHRwPVQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKeb-00DLzr-2J; Sat, 04 Sep 2021 01:39:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, hch@lst.de, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] block: 7th -- last batch of add_disk() error handling conversions
Date:   Fri,  3 Sep 2021 18:39:30 -0700
Message-Id: <20210904013932.3182778-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 7th and final set of changes to convert all drivers over to
use and finally enforce add_disk() error handling. This set deals with
those old drivers using __register_blkdev() which in turn have a
respective add_disk() call made. The last patch ensures we won't
add new drivers without a check for the add_disk() call.

You can find the full set of patches on my kernel.org linux
20210901-for-axboe-add-disk-error-handling branch [0] which is now based
on axboe/master.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210901-for-axboe-add-disk-error-handling

Luis Chamberlain (2):
  block: make __register_blkdev() return an error
  block: add __must_check for *add_disk*() callers

 block/genhd.c           | 21 ++++++++++++---------
 drivers/block/ataflop.c | 20 +++++++++++++++-----
 drivers/block/brd.c     |  7 +++++--
 drivers/block/floppy.c  | 14 ++++++++++----
 drivers/block/loop.c    |  6 +++---
 drivers/md/md.c         | 10 +++++++---
 drivers/scsi/sd.c       |  3 ++-
 fs/block_dev.c          |  5 ++++-
 include/linux/genhd.h   | 10 +++++-----
 9 files changed, 63 insertions(+), 33 deletions(-)

-- 
2.30.2

