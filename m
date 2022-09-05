Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642925ACB3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Sep 2022 08:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiIEGsX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Sep 2022 02:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbiIEGsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:48:21 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7743055D;
        Sun,  4 Sep 2022 23:48:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id ADCBD68BEB; Mon,  5 Sep 2022 08:48:16 +0200 (CEST)
Date:   Mon, 5 Sep 2022 08:48:16 +0200
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
Message-ID: <20220905064816.GD2092@lst.de>
References: <20220901074216.1849941-1-hch@lst.de> <20220901074216.1849941-5-hch@lst.de> <ffd39ae8-a7fb-1a75-a2d5-b601cb802b9c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffd39ae8-a7fb-1a75-a2d5-b601cb802b9c@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:04:34PM +0800, Qu Wenruo wrote:
> But for the verification part, I still don't like the idea of putting
> the verification code at endio context at all.

Why?

> This is especially true when data and metadata are still doing different
> checksum verfication at different timing.

Note that this does not handle the metadata checksum verification at
all.  Both because it actually works very different and I could not
verify that we'd actually always read all data that needs to be verified
together for metadata, but also because there is zero metadata repair
coverage in xfstests, so I don't dare to touch that code.

> Can we just let the endio function to do the IO, and let the reader to
> do the verification after all needed data is read out?

What would the benefit be?  It will lead to a lot of duplicate (and thus
inconsistent) code that is removed here, and make splitting the bios
under btrfs_submit_bio much more complicated and expensive.
