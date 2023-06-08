Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DB72759A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 05:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjFHDYT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 23:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjFHDYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 23:24:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD427210A;
        Wed,  7 Jun 2023 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=cxhjXp8UqaZuHQSEUX/zpZgXQq8nJphVe5X9oVt9Lt4=; b=B09aOYuo6yIOyWUGfX5fEyLtt7
        9ou3FUywOhl2aerjKqarqR7I4edV+KOUpAfSQcfUg9++n0fDaMzqD09DLsjve8Q0P+/cRGHEXvExV
        49UFEwzi8xZ3VqNoQMjhcwe2t5cHVjPS7F43P6o3qOqpiafEjz0rfAbR2pBaJQBc7lD1cAEIvxXEX
        6IfHGl8e/bavFWsCc5+A4MKi76oxJa4U7nPPLrqzMegUJcvs2/ocSV4CZd/mEaJctLO5Dvoi88NjB
        FmsVdc3W1+HNF35BsaFIyj8vReE9FqbMuwQslUKlZk0OTCDCrkEGk/BMBZUZxasGsPhx8ihPxjNE0
        LooAL6HQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q76Fr-007uuc-2Q;
        Thu, 08 Jun 2023 03:24:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, willy@infradead.org
Cc:     hare@suse.de, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, patches@lists.linux.dev, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, mcgrof@kernel.org, corbet@lwn.net,
        jake@lwn.net
Subject: [RFC 0/4] bdev: allow buffer-head & iomap aops to co-exist
Date:   Wed,  7 Jun 2023 20:24:00 -0700
Message-Id: <20230608032404.1887046-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At LSFMM it was clear that for some in order to support large order folios
we want to use iomap. So the filesystems staying and requiring buffer-heads
cannot make use of high order folios. This simplifies support and reduces
the scope for what we need to do in order to support high order folios for
buffered-io.

As Christoph's patches show though, we can only end up without buffer-heads
if you build and boot a system without any support for any filesystem that
requires buffer-heads. That's a tall order today.

We however want to be able to support block devices which may want to
completely opt-in to to only use iomap and iomap based filesystems. We
cannot do that today. To help with this we must extend the block device
cache so to enable each block device to get its own super block, and so
to later enable us to pick and choose the aops we use for the block
device.

The first patch seems already applicable upstream. The second is just
makes future changes easier to read. The third patch probably just needs
to be squashed into Christoph's work.

The last patch is the meat of this.

It goes boot tested, and applies on top of Christoph's patches which
enable you to build a sytem without buffer-heads. For convenience I've
stashed what this looks like on my large-block-20230607-dev-cache
branch [0].

The hot swapping of the aops is what would be next, and when we do that.
One option is to pursue things as-is now and then only flip if we need
high order folios. I'm sure Christoph will have better ideas how to do
that cleanly. But this is is what I have so far.

Lemme know how crappy this looks or pitfalls I'm sure I missed.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=large-block-20230607-dev-cache

Luis Chamberlain (4):
  bdev: replace export of blockdev_superblock with BDEVFS_MAGIC
  bdev: abstract inode lookup on blkdev_get_no_open()
  bdev: rename iomap aops
  bdev: extend bdev inode with it's own super_block

 block/bdev.c       | 106 +++++++++++++++++++++++++++++++++++++--------
 block/blk.h        |   1 +
 block/fops.c       |  14 +++---
 include/linux/fs.h |   4 +-
 4 files changed, 98 insertions(+), 27 deletions(-)

-- 
2.39.2

