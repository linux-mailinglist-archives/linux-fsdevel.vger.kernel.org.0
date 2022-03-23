Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC6A4E4D15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 08:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiCWHMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbiCWHMX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:12:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D406C958;
        Wed, 23 Mar 2022 00:10:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0077868B05; Wed, 23 Mar 2022 08:10:50 +0100 (CET)
Date:   Wed, 23 Mar 2022 08:10:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 28/40] btrfs: do not allocate a btrfs_io_context in
 btrfs_map_bio
Message-ID: <20220323071050.GA25442@lst.de>
References: <20220322155606.1267165-1-hch@lst.de> <20220322155606.1267165-29-hch@lst.de> <d9062a7d-c83c-06d7-50ac-272ffc0788f1@gmx.com> <20220323061339.GJ24302@lst.de> <ebb61597-dc43-2e81-2106-e448145f212c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebb61597-dc43-2e81-2106-e448145f212c@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:59:10PM +0800, Qu Wenruo wrote:
>> How do we waste memory?  We stop allocating the btrfs_io_context now
>> which can be quite big.
>
> Doesn't we waste the embedded __stripe if we choose to use the pointer one?
> And vice versus.
>
> And for SINGLE profile, we don't really need btrfs_bio_stripe at all, we
> can fast-path just setting bdev and bi_sector, and submit without even
> overriding its endio/private.

Yes, the 16 byes of the embedded stripe is wasted for I/O that doesn't
use it.  But all reads use it, which is typically the majority of all
I/O and the most performance critical one.  If the "waste" is a concern
we can split out a separate btrfs_read_bio.  Chance are that it will
just use slack by the time this all settles with a bunch of other
members that can be removed or unioned.
