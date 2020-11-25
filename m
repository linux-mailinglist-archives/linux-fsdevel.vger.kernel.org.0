Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B032C4A73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 23:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgKYWJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 17:09:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:38378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732292AbgKYWJV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:09:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1627AC2D;
        Wed, 25 Nov 2020 22:09:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54545DA7B4; Wed, 25 Nov 2020 23:07:50 +0100 (CET)
Date:   Wed, 25 Nov 2020 23:07:50 +0100
From:   David Sterba <dsterba@suse.cz>
To:     dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Message-ID: <20201125220750.GQ6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <20201125214753.GP6430@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125214753.GP6430@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 10:47:53PM +0100, David Sterba wrote:
> On Tue, Nov 10, 2020 at 08:26:07PM +0900, Naohiro Aota wrote:
> > +int btrfs_get_dev_zone_info(struct btrfs_device *device)
> > +{
> > +	struct btrfs_zoned_device_info *zone_info = NULL;
> > +	struct block_device *bdev = device->bdev;
> > +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> > +	sector_t sector = 0;
> 
> I'd rather replace the sector_t types with u64. The type is unsigned
> long and does not have the same width on 32/64 bit. The typecasts must
> be used and if not, bugs happen (and happened).

Like in the same function a few lines below

   95         /* Get zones type */
   96         while (sector < nr_sectors) {
   97                 nr_zones = BTRFS_REPORT_NR_ZONES;
   98                 ret = btrfs_get_dev_zones(device, sector << SECTOR_SHIFT, zones,
   99                                           &nr_zones);

sector without a type cast to u64
