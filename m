Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511225B5BAE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiILNzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 09:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiILNzf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:55:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F818359;
        Mon, 12 Sep 2022 06:55:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 902F268AFE; Mon, 12 Sep 2022 15:55:28 +0200 (CEST)
Date:   Mon, 12 Sep 2022 15:55:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/17] btrfs: allow btrfs_submit_bio to split bios
Message-ID: <20220912135528.GA723@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-8-hch@lst.de> <9a34f412-59eb-7bcd-5d09-7afd468c81af@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a34f412-59eb-7bcd-5d09-7afd468c81af@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 12, 2022 at 08:20:37AM +0800, Qu Wenruo wrote:
> Sorry for the late reply, but I still have a question related the
> chained bio way.
>
> Since we go the chained method, it means, if we hit an error for the
> splitted bio, the whole bio will be marked error.

The only chained bios in the sense of using bio chaining are the
writes to the multiple legs of mirrored volumes.

> Especially for read bios, that can be a problem (currently only for
> RAID10 though), which can affect the read repair behavior.
>
> E.g. we have a 4-disks RAID10 looks like this:
>
> Disk 1 (unreliable): Mirror 1 of logical range [X, X + 64K)
> Disk 2 (reliable):   Mirror 2 of logical range [X, X + 64K)
> Disk 3 (reliable):   Mirror 1 of logical range [X + 64K, X + 128K)
> Disk 4 (unreliable): Mirror 2 of logical range [X + 64K, X + 128K)
>
> And we submit a read for range [X, X + 128K)
>
> The first 64K will use mirror 1, thus reading from Disk 1.
> The second 64K will also use mirror 1, thus read from Disk 2.
>
> But the first 64K read failed due to whatever reason, thus we mark the
> whole range error, and needs to go repair code.

With the code posted in this series that is not what happens.  Instead
the checksum validation and then repair happen when the read from
mirror 1 / disk 1 completes, but before the results are propagated
up.  That was the prime reason why I had to move the repair code
below btrfs_submit_bio (that it happend to removed code and consolidate
the exact behavior is a nice side-effect).

> Does the read-repair code now has something to compensate the chained
> behavior?

It doesn't compensate it, but it is invoked at a low enough level so
that this problem does not happen.
