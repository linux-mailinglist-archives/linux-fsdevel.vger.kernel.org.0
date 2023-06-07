Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682F3725FF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 14:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbjFGMsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 08:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbjFGMr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:47:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF482100;
        Wed,  7 Jun 2023 05:47:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC44063EC7;
        Wed,  7 Jun 2023 12:47:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F576C4339B;
        Wed,  7 Jun 2023 12:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686142035;
        bh=yQwyPVuAGoNHQWOMctts7HBR5pbTnomidetU1VDq7mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KY16ohuxDUXf8jhwatNYz+c9Rc4twpyKWnQ7ldIraz/oidrRhEkgKjDaCyV7fu+/D
         hyPEXDLCndSEKQzmdg0sd7RtJsiVXZkKH9YZD/rZPdkgDjEfakY63lgFslkki2sVId
         9aw42j6uL8oCpHNIXRMF+V8IaaIdwDSR9Lo2IhWB34MF3i5ImLcmOTYcFE8YqPxQZy
         vs7oB2HoHfPekk9Wo0uu34t8cgoDOIABPz67CJlm5dSZc8w51ypbNJGMVTv0G8WUu1
         ficc1osgWKt3z27CzmGiEUD/rWC+VhJRlyKTAeZUUWmkZq8ur2sbvHeLvycrfjH5AS
         qC1hC1l2dB0UA==
Date:   Wed, 7 Jun 2023 14:47:06 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 28/31] block: replace fmode_t with a block-specific type
 for block open flags
Message-ID: <20230607-bekannt-sonnig-c881b3228862@brauner>
References: <20230606073950.225178-1-hch@lst.de>
 <20230606073950.225178-29-hch@lst.de>
 <20230607-kocht-kornfeld-a249c6740e38@brauner>
 <20230607121658.GA13632@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230607121658.GA13632@lst.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 02:16:58PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 07, 2023 at 11:21:14AM +0200, Christian Brauner wrote:
> > On Tue, Jun 06, 2023 at 09:39:47AM +0200, Christoph Hellwig wrote:
> > > The only overlap between the block open flags mapped into the fmode_t and
> > > other uses of fmode_t are FMODE_READ and FMODE_WRITE.  Define a new
> > 
> > and FMODE_EXCL afaict
> 
> FMODE_EXCL isn't used outside the block layer and removed in the last
> patch.
> 
> > > +blk_mode_t file_to_blk_mode(struct file *file)
> > > +{
> > > +	blk_mode_t mode = 0;
> > > +
> > > +	if (file->f_mode & FMODE_READ)
> > > +		mode |= BLK_OPEN_READ;
> > > +	if (file->f_mode & FMODE_WRITE)
> > > +		mode |= BLK_OPEN_WRITE;
> > > +	if (file->f_mode & FMODE_EXCL)
> > > +		mode |= BLK_OPEN_EXCL;
> > > +	if ((file->f_flags & O_ACCMODE) == 3)
> > 
> > I really don't like magic numbers like this.
> 
> I don't like them either, but this is just moved around and not new.
> 
> > Groan, O_RDONLY being defined as 0 strikes again...
> > Becuase of this quirk we internally map
> > 
> > O_RDONLY(0) -> FMODE_READ(1)
> > O_WRONLY(1) -> FMODE_WRITE(2)
> > O_RDWR(3)   -> (FMODE_READ | FMODE_WRITE)
> 
> O_RDWR is 2.

Yeah, that was a typo. See the other mail I sent right after:
https://lore.kernel.org/all/20230607-kribbeln-dilettanten-b901b57dd962@brauner

> 
> > so checking for the raw 3 here is confusing in addition to being a magic
> > number as it could give the impression that what's checked here is
> > (O_WRONLY | O_RDWR) which doesn't make sense...
> 
> Well, that is exactly what we check for.  This is a 30-ish year old
> quirk only used in the floppy driver.

Ugh, it's f_flags. I misread that as f_mode...

This is rather ugly. Then please, make it explicit and check for
== (O_WRONLY | O_RDWR) and leave a brief comment.

Anything's better than that raw 3 in there. We just had fun with
figuring out why there was a raw coredump in fs/coredump.c 30 years
later.
