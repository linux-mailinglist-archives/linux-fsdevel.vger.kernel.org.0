Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967B379840F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbjIHI3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 04:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjIHI27 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 04:28:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3321FC6;
        Fri,  8 Sep 2023 01:28:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80BDF68B05; Fri,  8 Sep 2023 10:28:46 +0200 (CEST)
Date:   Fri, 8 Sep 2023 10:28:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        syzbot <syzbot+1fa947e7f09e136925b8@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-block@vger.kernel.org,
        hch@lst.de
Subject: Re: [syzbot] [xfs?] INFO: task hung in clean_bdev_aliases
Message-ID: <20230908082846.GB9560@lst.de>
References: <000000000000e534bb0604959011@google.com> <ZPeaH+K75a0nIyBk@dread.disaster.area> <CANp29Y4AK9dzmpMj4E9iz3gqTwhG=-_7DfA8knrWYaHy4QxrEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y4AK9dzmpMj4E9iz3gqTwhG=-_7DfA8knrWYaHy4QxrEg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 07:20:15PM +0200, Aleksandr Nogikh wrote:
> On Tue, Sep 5, 2023 at 11:14 PM 'Dave Chinner' via syzkaller-bugs
> <syzkaller-bugs@googlegroups.com> wrote:
> >
> > [cc linux-block, Christoph]
> >
> > Another iomap-blockdev related issue.
> >
> > #syz set subsystems: block
> >
> > syzbot developers: Please review how you are classifying subsystems,
> > this is the third false XFS classification in 24 hours.
> 
> The reason why syzbot marked this report as xfs is that, per
> MAINTAINERS, fs/iomap/ points to linux-xfs@vger.kernel.org. I can
> adjust the rules syzbot uses so that these are routed to "block".
> 
> But should MAINTAINERS actually also not relate IOMAP FILESYSTEM
> LIBRARY with xfs in this case?

I'd tag it with iomap, as it's a different subsystem just sharing
the mailing list.  We also have iommu@lists.linux.dev for both the
iommu and dma-mapping subsystems as a similar example.

But what's also important for issues like this is that often the
called library code (in this case iomap) if often not, or only
partially at fault.  So capturing the calling context (in this
case block) might also be useful.

And to get out of these meta discussions:  I'll look into the actual
issues in a bit, I'll try to find time despite travelling.

