Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C66B0B29
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 15:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjCHOaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 09:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjCHO35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:29:57 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9483E31E04;
        Wed,  8 Mar 2023 06:29:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AAAF567373; Wed,  8 Mar 2023 15:28:18 +0100 (CET)
Date:   Wed, 8 Mar 2023 15:28:18 +0100
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
Subject: Re: [PATCH 03/34] btrfs: add a btrfs_inode pointer to struct
 btrfs_bio
Message-ID: <20230308142817.GA14929@lst.de>
References: <20230121065031.1139353-1-hch@lst.de> <20230121065031.1139353-4-hch@lst.de> <88b2fae1-8d95-2172-7bc4-c5dfc4ff7410@gmx.com> <20230307144106.GA19477@lst.de> <96f5c29c-1b25-66af-1ba1-731ae39d912d@gmx.com> <5aff53ea-0666-d4d6-3bf1-07b3674a405a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5aff53ea-0666-d4d6-3bf1-07b3674a405a@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 02:04:26PM +0800, Qu Wenruo wrote:
> BTW, I also checked if I can craft a scrub specific version of 
> btrfs_submit_bio().
>
> The result doesn't look good at all.
>
> Without a btrfs_bio structure, it's already pretty hard to properly put 
> bioc, decrease the bio counter.
>
> Or I need to create a scrub_bio, and re-implement all the needed endio 
> function handling.
>
> So please really consider the simplest case, one just wants to read/write 
> some data using logical + mirror_num, without any btrfs inode nor csum 
> verification.

As said before with a little more work we could get away without the
inode.  But the above sounds a little strange to me.  Can you share
your current code?  Maybe I can come up with some better ideas.
