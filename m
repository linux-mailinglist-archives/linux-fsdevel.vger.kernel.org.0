Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523C95AD4D2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238290AbiIEObJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 10:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238133AbiIEObF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:31:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6457144558;
        Mon,  5 Sep 2022 07:31:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 390F168AA6; Mon,  5 Sep 2022 16:31:00 +0200 (CEST)
Date:   Mon, 5 Sep 2022 16:31:00 +0200
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
Subject: Re: [PATCH 04/17] btrfs: handle checksum validation and repair at
 the storage layer
Message-ID: <20220905143100.GA5426@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-5-hch@lst.de> <ffd39ae8-a7fb-1a75-a2d5-b601cb802b9c@gmx.com> <20220905064816.GD2092@lst.de> <227328cc-a41c-be15-ab9f-fa81419b7348@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <227328cc-a41c-be15-ab9f-fa81419b7348@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:59:33PM +0800, Qu Wenruo wrote:
> Mostly due to the fact that metadata and data go split ways for
> verification.
>
> All the verification for data happens at endio time.

Yes.

> While part of the verification of metadata (bytenr, csum, level,
> tree-checker) goes at endio, but transid, checks against parent are all
> done at btrfs_read_extent_buffer() time.
>
> This also means, the read-repair happens at different timing.

Yes.  read-repair for metadata currently is very different than that
from data.  But that is something that exists already in is not new
in this series.

> But what about putting all the needed metadata info (first key, level,
> transid etc) also into bbio (using a union to take the same space of
> data csum), so that all verification and read repair can happen at endio
> time, the same timing as data?

I thought about that.  And I suspect it probably is the right thing
to do.  I'm mostly stayed away from it because it doesn't really
help with the goal in this series, and I also don't have good
code coverage to fail comfortable touching the metadata checksum
handling and repair.  I can offer this sneaky deal:  if someone
help creating good metadata repair coverage in xfstests, I will look
into this next.
