Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FB978AFB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjH1MJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 08:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjH1MJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:09:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89BA9;
        Mon, 28 Aug 2023 05:09:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CFEA56732A; Mon, 28 Aug 2023 14:09:40 +0200 (CEST)
Date:   Mon, 28 Aug 2023 14:09:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
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
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/30] block: also call ->open for incremental
 partition opens
Message-ID: <20230828120940.GB10552@lst.de>
References: <20230608110258.189493-1-hch@lst.de> <20230608110258.189493-2-hch@lst.de> <20230825024457.GD95084@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825024457.GD95084@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 25, 2023 at 03:44:57AM +0100, Al Viro wrote:
> That got me curious about the ->bd_openers - do we need it atomic?
> Most of the users (and all places that do modifications) are
> under ->open_mutex; the only exceptions are
> 	* early sync logics in blkdev_put(); it's explicitly racy -
> see the comment there.
> 	* callers of disk_openers() in loop and nbd (the ones in
> zram are under ->open_mutex).  There's driver-private exclusion
> around those, but in any case - READ_ONCE() is no worse than
> atomic_read() in those cases.
> 
> Is there something subtle I'm missing here?

No.  When I had to add unlocked readers I did the READ_ONCE initially,
but reviewers though the atomic_t would be better.  I didn't really feel
like arguing so went with this version.
