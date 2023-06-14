Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940FF72FD49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbjFNLrA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjFNLq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:46:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D214C10D8;
        Wed, 14 Jun 2023 04:46:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9223D1FDEB;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686743217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YFHMf/7AFROZukssL33URO15KYKs2xMsFMw9VWiHPOA=;
        b=k5uyzmJjl8nFyPS17MLVkLMQyQAYSsHNR9iCRdJTxOo3Mli2N4LeCJwsg4gGodxtSTebgs
        L5Q3whjVIHACOH0T+GqVxS5l1abx8As73k2JfYHCg3Kqp3XjKd/tzPu39hsHqasLZUkrtc
        GlfPPmmwWOgZ9aqN98gqvJFA0Ys6Kas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686743217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YFHMf/7AFROZukssL33URO15KYKs2xMsFMw9VWiHPOA=;
        b=gwE4RXfx6xQuGXY51gX1+mV11s57CjBgyCTXv/7QuYxYMB4EaVTWB9c29nQJzwm8vwwe16
        wADlEWYv1f7JsrAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7C1C02C141;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 6CF3A51C4E09; Wed, 14 Jun 2023 13:46:57 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/7] RFC: high-order folio support for I/O
Date:   Wed, 14 Jun 2023 13:46:30 +0200
Message-Id: <20230614114637.89759-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

now, that was easy.
Thanks to willy and his recent patchset to support large folios in
gfs2 turns out that most of the work to support high-order folios
for I/O is actually done.
It only need twe rather obvious patches to allocate folios with
the order derived from the mapping blocksize, and to adjust readahead
to avoid reading off the end of the device.
But with these two patches (and the patchset from hch to switch
the block device over to iomap) (and the patchset from ritesh to
support sub-blocksize iomap buffers) I can now do:

# modprobe brd rd_size=524288 rd_blksize=16384
# mkfs.xfs -b size=16384 /dev/ram0

it still fails when trying to mount the device:

XFS (ram0): Cannot set_blocksize to 16384 on device ram0

but to my understanding this is being worked on.

Christoph, any chance to have an updated submission of your
patchset to convert block devices over to iomap?
I don't actually need the last one to switch off buffer heads,
but the others really do help for this case.

The entire tree can be found at:

git.kernel.org:/pub/scm/linux/git/kernel/hare/scsi-devel.git
branch brd.v2

Happy hacking!

Hannes Reinecke (6):
  brd: convert to folios
  brd: abstract page_size conventions
  brd: make sector size configurable
  brd: make logical sector size configurable
  mm/filemap: allocate folios with mapping blocksize
  mm/readahead: align readahead down to mapping blocksize

Pankaj Raghav (1):
  brd: use XArray instead of radix-tree to index backing pages

 drivers/block/brd.c     | 320 +++++++++++++++++++++-------------------
 include/linux/pagemap.h |   7 +
 mm/filemap.c            |   7 +-
 mm/readahead.c          |  10 +-
 4 files changed, 186 insertions(+), 158 deletions(-)

-- 
2.35.3

