Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52C67FCC7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jan 2023 05:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjA2Equ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Jan 2023 23:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Eqt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Jan 2023 23:46:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1097822A39
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Jan 2023 20:46:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1DF60C82
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 04:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D9AC433EF;
        Sun, 29 Jan 2023 04:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674967607;
        bh=PXwJncBGl8HG9How7WEgeo2qflyTk4vfxxh5fbr+634=;
        h=Date:From:To:Cc:Subject:From;
        b=ufQj8BLsDz7vPIW0y4QhPF1lNXOCZbkK3dUzpumg37HbMIlRyNvF5BB9EaX5XxEBU
         a6PmZJ0YLe4yTDd4W+vPKqzdUzYvesFvmmeMEivgFSN7vDtlY5BlyNctl2jJrMbeOI
         tHPf8wUYzkEAfRrIDg5ztscwkS9x3SoY8HMXu5CxWj1vm7ZJsNPvPbYrTUCO6pVqPI
         0cAuI+YeZfB+WJ34QWXsU6cnLRv68wnfwBROS8OHoQrxIrXJ9usDKGtjyxtRBM3Pbw
         hreREhVNBWFyTzQDp3l2jC459ExvXD8VIye9B6BFRWY2WccPpo0j7TnmA4CHTFKmN9
         /GfWWjstYfo3g==
Date:   Sat, 28 Jan 2023 20:46:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: LSF/MM/BPF 2023 IOMAP conversion status update
Message-ID: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One of the recurring themes that comes up at LSF is "iomap has little
to no documentation, it is hard to use". I've only recently taken a
little nose dive into it, and so I also can frankly admit to say I don't
grok it well either yet. However, the *general* motivation and value is clear:
avoiding the old ugly monster of struct buffer_head, and abstracting
the page cache for non network filesystems, and that is because for
network filesystems my understanding is that we have another side effort
for that. We could go a bit down memory lane on prior attempts to kill
the struct buffer_head evil demon from Linux, or why its evil, but I'm not
sure if recapping that is useful at this point in time, let me know, I could
do that if it helps if folks want to talk about this at LSF. For now I rather
instead focus on sharing efforts to review where we are today on the effort
towards conversion towards IOMAP for some of the major filesystems:

https://docs.google.com/presentation/d/e/2PACX-1vSN4TmhiTu1c6HNv6_gJZFqbFZpbF7GkABllSwJw5iLnSYKkkO-etQJ3AySYEbgJA/pub?start=true&loop=false&delayms=3000&slide=id.g189cfd05063_0_225

I'm hoping this *might* be useful to some, but I fear it may leave quite
a bit of folks with more questions than answers as it did for me. And
hence I figured that *this aspect of this topic* perhaps might be a good
topic for LSF.  The end goal would hopefully then be finally enabling us
to document IOMAP API properly and helping with the whole conversion
effort.

My gatherings from this quick review of API evolution and use is that,
XFS is *certainly* a first class citizen user. No surprise there if a
lot of the effort came out from XFS. And even though btrfs now avoids
the evil struct buffer_head monster, its use of the IOMAP API seems
*dramatically* different than XFS, and it probably puzzles many. Is it
that btrfs managed to just get rid of struct buffer_head use but missed
fully abstracting working with the page cache? How does one check? What
semantics do we look for?

When looking to see if one can help on the conversion front with other
filesystems it begs the question what is the correct real end goal. What
should one strive for? And it also gets me wondering, if we wanted to abstract
the page cache from scratch again, would we have done this a bit differently
now? Are there lessons from the network filesystem side of things which
can be shared? If so it gets me wondering if this instead should be
about why that's a good idea and what should that look like.

Perhaps fs/buffers.c could be converted to folios only, and be done
with it. But would we be loosing out on something? What would that be?

  Luis
