Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4097984EC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 11:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241031AbjIHJlu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 05:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjIHJlt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:41:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45E19A8;
        Fri,  8 Sep 2023 02:41:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FBAC433C7;
        Fri,  8 Sep 2023 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694166105;
        bh=EYYCmHgeod1hykCRSKvFEakI9Z9BAhA43sKlrKvmmHA=;
        h=Date:From:To:Cc:Subject:From;
        b=fgI7swrD7LO1mhoG3nRsKef9+oGYxkSrs3AFtFNumzf5KFWgbDT+cqdoyxt96Y10Y
         8EZwVM6TD/k7pnAb+vgeA4VdYx6B6XD21QbH2pA2qMl1cYdITwv+UzriH2WrPHG92Z
         QgBOjLxjjw4ctFNQQ0mZXvZMavjHIuMn/MuG9Bg1qYHHtSqViY6qwgRj5PolPm1CN8
         fc6QQPSBy4KKuUk44UTLeMTfYUg/SxqF3yLGosvxmFAmErbxVY47xkJHUNoY1vgWnZ
         /8jWZTb4TXp2wG2iQxgJUu9q/345umVF4SgQnszb1/VrkFV/8AVqKGz/SaBFclCzAR
         rmA3G/nhOI6uQ==
Date:   Fri, 8 Sep 2023 11:41:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: btrfs freezing question
Message-ID: <20230908-merklich-bebauen-11914a630db4@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey everyone,

I have a patch series unrelated to btrfs that moves block device
freezing and thawing to block device holder operations - Jan and
Christoph are aware. As part of that I took a look at various freezing
implementations to make sure that there are no regressions and that I'm
testing correctly.

So what puzzled me with btrfs is that freezing operations triggered
through freeze_bdev() seem broken.

For example, triggering a freeze through dm_ioctl() would currently do:

freeze_bdev()
-> get_active_super()
   -> sb->freeze_fs()

And get_active_super() (which will go away with my patch series) walks
all super blocks on the systems and matches on sb->s_bdev to find any
superblock associated with that device. But afaict - at least on a
regular mount - btrfs doesn't set that pointer to anything right now.

IOW, get_active_super() can never find the btrfs superblock that is
associated with that device mapper device (sticking with the example).
That means while we freeze the underlying block device the btrfs
filesystem making use of that block device isn't.

Is that known/expected? Am I missing something else why that's ok? Or am
I misanalysing? Probably not a very common use-case/scenario but still.

I'm pretty sure this would be fixable with my series. It just requires
that btrfs would finally move to the new model where bdev->bd_holder is
set to the superblock instead of the filesystem type and would start
using fs_holder_ops if that's possible.

Because implementing block device freeze/thaw as holder operations
wouldn't need to match on s_bdev anymore at all. It can go straight from
bdev->bd_holder to the superblock and call the necessary ops.

My series can proceed independent of fixing btrfs but I'm just trying to
make people aware in case that somehow wasn't known.

Christian
