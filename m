Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAB55ACB71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 08:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbiIEG4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 02:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiIEGzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:55:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1622BD0;
        Sun,  4 Sep 2022 23:55:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DC54F68AFE; Mon,  5 Sep 2022 08:55:23 +0200 (CEST)
Date:   Mon, 5 Sep 2022 08:55:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/17] btrfs: split zone append bios in btrfs_submit_bio
Message-ID: <20220905065523.GI2092@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-17-hch@lst.de> <d02a11c0-ea7c-8921-8993-5c9d3645c7ad@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d02a11c0-ea7c-8921-8993-5c9d3645c7ad@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 02, 2022 at 10:46:13AM +0900, Damien Le Moal wrote:
> On 9/1/22 16:42, Christoph Hellwig wrote:
> > The current btrfs zoned device support is a little cumbersome in the data
> > I/O path as it requires the callers to not support more I/O than the
> > supported ZONE_APPEND size by the underlying device.  This leads to a lot
> 
> Did you mean: "...as it requires the callers to not issue I/O larger than
> the supported ZONE_APPEND size for the underlying device." ?
> I think you do mean that :)

Yes.
