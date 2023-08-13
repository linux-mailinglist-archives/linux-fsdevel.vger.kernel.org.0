Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DCF77AA8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Aug 2023 20:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjHMS0o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Aug 2023 14:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHMS0o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Aug 2023 14:26:44 -0400
Received: from out-108.mta0.migadu.com (out-108.mta0.migadu.com [IPv6:2001:41d0:1004:224b::6c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F4610CE
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Aug 2023 11:26:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691951203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EGnlBdzWiItWEyj1uxLZJa+yR+f6yFA61Olaqu7O6Xs=;
        b=ZpO3Pa8jpbyBweGMlDtpOFA1GFjTfTEl4PJduSIwRvVhng1wo6lurvZZ5TjYjN5lp5wjRy
        EceEyVNT1xZJumpjFUVB7NEltO/fu3xNPnqhpbwCiO28RGjfwl3fWidv8Vs3UB1L6u5oS6
        vOtu/kp4pkG3H1hVd+h+hl8HWatjnz8=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 0/3] bcachefs block layer prereqs
Date:   Sun, 13 Aug 2023 14:26:33 -0400
Message-Id: <20230813182636.2966159-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens, here's the (hopefully final) bcachefs block layer prereqs,
aiming for v6.6.

The "block: Don't block on s_umount from __invalidate_super()" patch has
been dropped for now - but we may want this later as there's a real bug
it addresses, and with the blockdev holder changes now landing I suspect
other filesystems will be hitting the same issue as bcachefs.

But that can be a topic for another thread.

Can I get either acks or have you take them via your tree, your
preference?

Kent Overstreet (3):
  block: Add some exports for bcachefs
  block: Allow bio_iov_iter_get_pages() with bio->bi_bdev unset
  block: Bring back zero_fill_bio_iter

 block/bio.c            | 18 +++++++++++-------
 block/blk-core.c       |  1 +
 block/blk.h            |  1 -
 include/linux/bio.h    |  7 ++++++-
 include/linux/blkdev.h |  1 +
 5 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.40.1

