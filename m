Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0D230CBB4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 20:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239851AbhBBTct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 14:32:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239707AbhBBTbc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:31:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E186FACD4;
        Tue,  2 Feb 2021 19:30:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AC91DDA6FC; Tue,  2 Feb 2021 20:28:57 +0100 (CET)
Date:   Tue, 2 Feb 2021 20:28:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v14 32/42] btrfs: avoid async metadata checksum on ZONED
 mode
Message-ID: <20210202192857.GZ1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
 <13728adcc4f433c928b00be73ea5466f62ccb4b9.1611627788.git.naohiro.aota@wdc.com>
 <20210202145418.GX1993@twin.jikos.cz>
 <SN4PR0401MB3598A4EF13B1D61B3720E5889BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598A4EF13B1D61B3720E5889BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:50:26PM +0000, Johannes Thumshirn wrote:
> On 02/02/2021 15:58, David Sterba wrote:
> >> static int check_async_write(struct btrfs_fs_info *fs_info,
> >>  			     struct btrfs_inode *bi)
> >>  {
> >> +	if (btrfs_is_zoned(fs_info))
> >> +		return 0;
> > This check need to be after the other ones as zoned is a static per-fs
> > status, while other others depend on either current state or system
> > state (crypto implementation).
> > 
> >>  	if (atomic_read(&bi->sync_writers))
> >>  		return 0;
> >>  	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &fs_info->flags))
> 
> Can you explain the reasoning behind that rule? For a non-zoned FS this won't
> make a huge difference to check fs_info->zoned and for a  zoned FS we're 
> bailing out fast as we can't support async checksums.

On first sight it looked like a special case for zoned while it's not
the major usecase but the test is cheap and fast, it's ok to keep it
first.
