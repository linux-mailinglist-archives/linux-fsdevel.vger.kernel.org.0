Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000C31C6415
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 00:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgEEWrC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 18:47:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:53876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726568AbgEEWrC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 18:47:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 052FDAE64;
        Tue,  5 May 2020 22:47:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4ECC4DA7AD; Wed,  6 May 2020 00:46:12 +0200 (CEST)
Date:   Wed, 6 May 2020 00:46:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200505224611.GA18421@twin.jikos.cz>
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
 <20200505221448.GW18421@twin.jikos.cz>
 <20200505223120.GC128280@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505223120.GC128280@sol.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 03:31:20PM -0700, Eric Biggers wrote:
> > Using that example, the authenticated checksum cannot be subverted on
> > the superblock. So even if there are untrusted superblock data used, it
> > won't even pass the verification of the superblock itself.
> 
> You're missing the point.  For unkeyed hashes, there's no need to provide the
> hash algorithm name at mount time, as there's no authentication anyway.  But for
> keyed hashes (as added by this patch) it is needed.  If the attacker gets to
> choose the algorithms for you, you don't have a valid cryptosystem.

I think we need to be more specific as I don't see how this contradicts
what I've said, perhaps you'll show me the exact point where I missed
it.

An example superblock contains:

	u8 checksum[32];
	int hash_type;
	u8 the_rest[256];

The checksum is calculated from offsetof(hash_type) to the end of the
structure. Then it is stored to the checksum array, and whole block is
stored on disk.

Valid superblock created by user contains may look like:

	.checksum = 0x123456
	.hash_type = 0x1	/* hmac(sha256) */
	.the_rest = ...;

Without a valid key, none of the hash_type or the_rest can be changed
without producing a valid checksum.

When you say 'if attacker gets to chose the algorithms' I understand it
as change to hash_type, eg. setting it to 0x2 which would be
hmac(blake2b).

So maybe it violates some principle of not letting the attacker choice
happen at all, but how would the attack continue to produce a valid
checksum?
