Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E212437B7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 19:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhJVRLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 13:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhJVRLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:11:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDEC061764;
        Fri, 22 Oct 2021 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OHH0SJrdtpktWqvj5lo7lfZ6Ww+8Li+VufAv8MgJXIA=; b=RSijyQk2hXa/SC2xL1H2JkSjl0
        uk9SJ13Cr0ZoDllJSVXm8Wmb8tNRwmUclQ0u2BkzSe5cX0mEEnQ8PC870XBEZ5IDJecOtj8oMZUIE
        TtL9mecozh0TX1DKqlmpGrA1DgNCulTOx83WpHvw/VHAH8Oct4ERbkCvXI8rEDmEqIQsYzr5IYGSQ
        ZvmnaPQVaZbDNIrJjDm/dd35zJnJvVxk7faC4Ab0f7nNmapqFjvOXQKTJLbVOtabvAeEH3V/uw9OQ
        nV6mW1Naa72AKQ/63Ug8/g/OZ5eswbueonUUteuPCwmTipO9OGqlRToBKmbeRQN2GElfpUABm0AwM
        1rxQtSrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdy23-00Baki-Cr; Fri, 22 Oct 2021 17:08:39 +0000
Date:   Fri, 22 Oct 2021 10:08:39 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     schmitzmic@gmail.com, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        axboe@kernel.dk, hch@lst.de, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org
Subject: Re: [PATCH v3 0/3] last batch of add_disk() error handling
 conversions
Message-ID: <YXLwF1jit131Nb5u@bombadil.infradead.org>
References: <20211021163856.2000993-1-mcgrof@kernel.org>
 <66655777-6f9b-adbc-03ff-125aecd3f509@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66655777-6f9b-adbc-03ff-125aecd3f509@i-love.sakura.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:06:07AM +0900, Tetsuo Handa wrote:
> On 2021/10/22 1:38, Luis Chamberlain wrote:
> > I rebased Tetsuo Handa's patch onto the latest linux-next as this
> > series depends on it, and so I am sending it part of this series as
> > without it, this won't apply. Tetsuo, does the rebase of your patch
> > look OK?
> 
> OK, though I wanted my fix to be sent to upstream and stable before this series.

Sure, absolutely, your patch is certainly separate and is needed as a
fix downstream to stable it would seem.

> > If it is not too much trouble, I'd like to ask for testing for the
> > ataflop changes from Michael Schmitz, if possible, that is he'd just
> > have to merge Tetsuo's rebased patch and the 2nd patch in this series.
> > This is all rebased on linux-next tag 20211020.
> 
> Yes, please.
> 
> After this series, I guess we can remove "bool registered[NUM_DISK_MINORS];" like below
> due to (unit[drive].disk[type] != NULL) == (unit[drive].registered[type] == true).

Sounds good.

> Regarding this series, setting unit[drive].registered[type] = true in ataflop_probe() is
> pointless because atari_floppy_cleanup() checks unit[i].disk[type] != NULL for calling
> del_gendisk().

I see, will fix.

> And we need to fix __register_blkdev() in driver/block/floppy.c because
> floppy_probe_lock is pointless.

Sure, I take it you're going to work on a patch?

So much excitement with the floppy world, who would have thought? :)

  Luis
