Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8137A5615
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 01:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjIRXMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 19:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:12:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31ED90;
        Mon, 18 Sep 2023 16:12:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3523FC433C7;
        Mon, 18 Sep 2023 23:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695078720;
        bh=kZYCDKLLl1LFOrASFlg3OaiiTYbfa6WuZkABtqkAOlk=;
        h=Subject:From:To:Cc:Date:From;
        b=bk2Be9IFJhE7+a2AG6tZRM6NN6RXN53pAryyR+sQC5PdPqCm2ftOZ030FS4LHJ3Dy
         TfuODvmFDnI6QW/XRSLCqDrBASMdL9Ge6hl76m/h0QX5rVX1ltDE2zjUKpf0PTdPuF
         l/SC6daKeBv1MzapnVVfbWLoTWx/TZlGE9CpFwYKS6PVbFAXyAhdWa66UYPeIWQ+7H
         ENtNPCaXCZqJONo0lwJbDwXmij6H++qao1/eGAX6NQpPnVUBv/DZVSxAO43V6Rm4FU
         U+NPPGDb4WgquXoQBcoj/yAmjuFCZrOnirbsBim7vi9WCukVd7Bv32EOmAJoQSpQ4M
         rUUNBuHlfuS1g==
Subject: [PATCHSET 0/2] iomap: fix unshare data corruption bug
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     ritesh.list@gmail.com, willy@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, willy@infradead.org
Date:   Mon, 18 Sep 2023 16:11:59 -0700
Message-ID: <169507871947.772278.5767091361086740046.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I rebased djwong-dev atop 6.6-rc1, and discovered that the iomap unshare
code writes garbage into the unshared file if the unshared range covers
at least one base page's worth of file range and there weren't any
folios in the pagecache for that region.

The root cause is an optimization applied to __iomap_write_begin for 6.6
that caused it to ignore !uptodate folios.  This is fine for the
write/zeroing cases since they're going to write to the folio anyway,
but unshare merely marks the folio dirty and lets writeback handle the
unsharing.

While I was rooting around in there, I also noticed that the unshare
operation wasn't ported to use large folios.  This leads to suboptimal
performance if userspace funshares a file and continues using the page
cache, since the cache is now using base pages.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been lightly tested with fstests.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=iomap-fix-unshare-6.6
---
 fs/iomap/buffered-io.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

