Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDA1C6485
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 01:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgEEXbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 19:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgEEXbN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 19:31:13 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9F8206B8;
        Tue,  5 May 2020 23:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588721473;
        bh=GMGRI/7B7obgzrjTPJ/8iNsojp2uGTZFf08eSuNHeJU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VWAqa+knJrdel5WunX0kvZp6Yk9iQSy6UbGWkskvQyAu4g0CqODs+4P0DtrBPKcOg
         PMc+v67MLU5pmaDNMOtWfohrvMBvuTnyR4NVpaR/Jx+Sc8uo6HBwgCb5EuKMMJEyO/
         0e7qpqajHXT7ycyT9IMQfkapdLWinQI/wYbwH2VE=
Date:   Tue, 5 May 2020 16:31:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200505233110.GE128280@sol.localdomain>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200504205935.GA51650@gmail.com>
 <20200505221448.GW18421@twin.jikos.cz>
 <20200505223120.GC128280@sol.localdomain>
 <20200505224611.GA18421@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505224611.GA18421@twin.jikos.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 06, 2020 at 12:46:11AM +0200, David Sterba wrote:
> On Tue, May 05, 2020 at 03:31:20PM -0700, Eric Biggers wrote:
> > > Using that example, the authenticated checksum cannot be subverted on
> > > the superblock. So even if there are untrusted superblock data used, it
> > > won't even pass the verification of the superblock itself.
> > 
> > You're missing the point.  For unkeyed hashes, there's no need to provide the
> > hash algorithm name at mount time, as there's no authentication anyway.  But for
> > keyed hashes (as added by this patch) it is needed.  If the attacker gets to
> > choose the algorithms for you, you don't have a valid cryptosystem.
> 
> I think we need to be more specific as I don't see how this contradicts
> what I've said, perhaps you'll show me the exact point where I missed
> it.
> 
> An example superblock contains:
> 
> 	u8 checksum[32];
> 	int hash_type;
> 	u8 the_rest[256];
> 
> The checksum is calculated from offsetof(hash_type) to the end of the
> structure. Then it is stored to the checksum array, and whole block is
> stored on disk.
> 
> Valid superblock created by user contains may look like:
> 
> 	.checksum = 0x123456
> 	.hash_type = 0x1	/* hmac(sha256) */
> 	.the_rest = ...;
> 
> Without a valid key, none of the hash_type or the_rest can be changed
> without producing a valid checksum.
> 
> When you say 'if attacker gets to chose the algorithms' I understand it
> as change to hash_type, eg. setting it to 0x2 which would be
> hmac(blake2b).
> 
> So maybe it violates some principle of not letting the attacker choice
> happen at all, but how would the attack continue to produce a valid
> checksum?

Example: you add support for keyed hash algorithm X, and it later turns out that
X is totally broken (or was never meant to be a cryptographic hash in the first
place, but was mistakenly allowed for authentication).  You deprecate it and
tell people not to use it.  But it doesn't matter because you screwed up the
design and the attacker can still choose algorithm X anyway.

This is a basic cryptographic principle, I'm surprised this isn't obvious.

- Eric
