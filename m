Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1567A36D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjAXTzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjAXTzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:55:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06992E0DC;
        Tue, 24 Jan 2023 11:55:35 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E55006732D; Tue, 24 Jan 2023 20:55:31 +0100 (CET)
Date:   Tue, 24 Jan 2023 20:55:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/34] btrfs: remove the direct I/O read checksum
 lookup optimization
Message-ID: <20230124195531.GA16743@lst.de>
References: <20230121065031.1139353-1-hch@lst.de> <20230121065031.1139353-5-hch@lst.de> <1f02fc92-18e8-3c68-8a31-36b4e4a07efd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f02fc92-18e8-3c68-8a31-36b4e4a07efd@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 24, 2023 at 10:55:25PM +0800, Anand Jain wrote:
>
> I was curious about the commit message.
> I ran fio to test the performance before and after the change.
> The results were similar.
>
> fio --group_reporting=1 --directory /mnt/test --name dioread --direct=1 
> --size=1g --rw=read  --runtime=60 --iodepth=1024 --nrfiles=16 --numjobs=16
>
> before this patch
> READ: bw=8208KiB/s (8405kB/s), 8208KiB/s-8208KiB/s (8405kB/s-8405kB/s), 
> io=481MiB (504MB), run=60017-60017msec
>
> after this patch
> READ: bw=8353KiB/s (8554kB/s), 8353KiB/s-8353KiB/s (8554kB/s-8554kB/s), 
> io=490MiB (513MB), run=60013-60013msec

That's 4k reads.  The will benefit from the inline csum array in the
btrfs_bio, but won't benefit from the existing batching, so this is
kind of expected.

The good news is that the final series will still use the inline
csum array for small reads, while also only doing a single csum tree
lookup for larger reads, so you'll get the best of both worlds.
