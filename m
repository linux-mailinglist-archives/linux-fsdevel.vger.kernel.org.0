Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602821C63CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 00:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgEEWPk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 18:15:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:45014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgEEWPj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 18:15:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19364AC6D;
        Tue,  5 May 2020 22:15:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E45AADAD88; Wed,  6 May 2020 00:14:48 +0200 (CEST)
Date:   Wed, 6 May 2020 00:14:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200505221448.GW18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Eric Biggers <ebiggers@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504205935.GA51650@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 01:59:35PM -0700, Eric Biggers wrote:
> On Mon, May 04, 2020 at 10:09:44AM +0000, Johannes Thumshirn wrote:
> > On 01/05/2020 07:39, Eric Biggers wrote:
> > > The hash algorithm needs to be passed as a mount option.  Otherwise the attacker
> > > gets to choose it for you among all the supported keyed hash algorithms, as soon
> > > as support for a second one is added.  Maybe use 'auth_hash_name' like UBIFS
> > > does?
> > 
> > Can you elaborate a bit more on that? As far as I know, UBIFS doesn't 
> > save the 'auth_hash_name' on disk, whereas 'BTRFS_CSUM_TYPE_HMAC_SHA256' 
> > is part of the on-disk format. As soon as we add a 2nd keyed hash, say 
> > BTRFS_CSUM_TYPE_BLAKE2B_KEYED, this will be in the superblock as well, 
> > as struct btrfs_super_block::csum_type.
> 
> The data on disk isn't trusted.  Isn't that the whole point?  The filesystem
> doesn't trust it until it is MAC'ed, and to do that it needs the MAC algorithm.

Once the auth key and filesystem is set up, that's true. The special
case is the superblock itself. It's a chicken-egg problem: we cannot
trust the superblock data until we verify the checksum, but what
checksum should be used is stored in the superblock itself.

This can be solved by requesting the checksum type externally, like the
mount option, but for the simple checksums it puts the burden on the
user and basically requires the mkfs-time settings to be permanently
used for mounting. I do not consider that a good usability.

Without the mount option, the approach we use right now is to use the
checksum type stored in the untrusted superblock, verify it and if it
matches, claim that everything is ok. The plain checksum can be
obviously subverted, just set it to something else nad recalculate the
checksum.

But then everything else will fail because the subverted checksum type
will fail on each metadata block, which immediatelly hits the 1st class
btree roots pointed to by the super block.

The same can be done with all metadata blocks, still assuming a simple
checksum.

Using that example, the authenticated checksum cannot be subverted on
the superblock. So even if there are untrusted superblock data used, it
won't even pass the verification of the superblock itself.
