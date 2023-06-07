Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B7725E8E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbjFGMRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240343AbjFGMRG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:17:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4A31BD9;
        Wed,  7 Jun 2023 05:17:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52B4E6732D; Wed,  7 Jun 2023 14:16:58 +0200 (CEST)
Date:   Wed, 7 Jun 2023 14:16:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Richard Weinberger <richard@nod.at>,
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
Subject: Re: [PATCH 28/31] block: replace fmode_t with a block-specific
 type for block open flags
Message-ID: <20230607121658.GA13632@lst.de>
References: <20230606073950.225178-1-hch@lst.de> <20230606073950.225178-29-hch@lst.de> <20230607-kocht-kornfeld-a249c6740e38@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607-kocht-kornfeld-a249c6740e38@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 11:21:14AM +0200, Christian Brauner wrote:
> On Tue, Jun 06, 2023 at 09:39:47AM +0200, Christoph Hellwig wrote:
> > The only overlap between the block open flags mapped into the fmode_t and
> > other uses of fmode_t are FMODE_READ and FMODE_WRITE.  Define a new
> 
> and FMODE_EXCL afaict

FMODE_EXCL isn't used outside the block layer and removed in the last
patch.

> > +blk_mode_t file_to_blk_mode(struct file *file)
> > +{
> > +	blk_mode_t mode = 0;
> > +
> > +	if (file->f_mode & FMODE_READ)
> > +		mode |= BLK_OPEN_READ;
> > +	if (file->f_mode & FMODE_WRITE)
> > +		mode |= BLK_OPEN_WRITE;
> > +	if (file->f_mode & FMODE_EXCL)
> > +		mode |= BLK_OPEN_EXCL;
> > +	if ((file->f_flags & O_ACCMODE) == 3)
> 
> I really don't like magic numbers like this.

I don't like them either, but this is just moved around and not new.

> Groan, O_RDONLY being defined as 0 strikes again...
> Becuase of this quirk we internally map
> 
> O_RDONLY(0) -> FMODE_READ(1)
> O_WRONLY(1) -> FMODE_WRITE(2)
> O_RDWR(3)   -> (FMODE_READ | FMODE_WRITE)

O_RDWR is 2.

> so checking for the raw 3 here is confusing in addition to being a magic
> number as it could give the impression that what's checked here is
> (O_WRONLY | O_RDWR) which doesn't make sense...

Well, that is exactly what we check for.  This is a 30-ish year old
quirk only used in the floppy driver.

> So my perference would be in descending order of preference:
> 
> (file->f_flags & O_ACCMODE) == (FMODE_READ | FMODE_WRITE)
> 
> or while a little less clear but informative enough for people familiar
> with the O_RDONLY quirk:
> 
> if ((file->f_flags & O_ACCMODE) == O_ACCMODE)

I don't understand this part.  Especially the above doesn't make
any sense as FMODE_READ and FMODE_WRITE are in a completely different
symbol space to O_*, and not a UAPІ but a kernel internal thing that
could be renumbered any time.
