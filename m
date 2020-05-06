Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D851C6518
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 02:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgEFAal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 20:30:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgEFAal (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 20:30:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A962AC61;
        Wed,  6 May 2020 00:30:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 50D2CDA7AD; Wed,  6 May 2020 02:29:48 +0200 (CEST)
Date:   Wed, 6 May 2020 02:29:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200506002947.GF18421@twin.jikos.cz>
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
 <20200505224611.GA18421@twin.jikos.cz>
 <20200505233110.GE128280@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505233110.GE128280@sol.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 04:31:10PM -0700, Eric Biggers wrote:
> On Wed, May 06, 2020 at 12:46:11AM +0200, David Sterba wrote:
> > On Tue, May 05, 2020 at 03:31:20PM -0700, Eric Biggers wrote:
> Example: you add support for keyed hash algorithm X, and it later turns out that
> X is totally broken (or was never meant to be a cryptographic hash in the first
> place, but was mistakenly allowed for authentication).  You deprecate it and
> tell people not to use it.  But it doesn't matter because you screwed up the
> design and the attacker can still choose algorithm X anyway.
> 
> This is a basic cryptographic principle, I'm surprised this isn't obvious.

I want to avoid confusion raising from too much assuming and obvious
calling, from the filesystem side and from the crypto side. I can say
that it's clear that the existing data structures provide enough
guarantees for authentication, and that it's obvious.

But I don't do that and maybe it looks dumb and uninformed but I don't
care as long as the end result is ack from a crypto-knowleagable people
that it all plays well together and there are no further doubts.

Back to the example. The problem with deprecation hasn't been brought up
so far but I probably lack imagination _how_ can an attacker choose the
algorithm in the context of the filesystem. That this is easy in
scenarios with some kind of handshake is obvious, eg. the SSL/TLS
downgrade attacks. But I see a big difference in the persistence nature
of network connections and filesystems/storage, so the number of
opportunities to force bad algorithm is quite different. Mkfs time for
sure, and at mount it's in the example I provided in my previous email.

If some algorithm is found to be broken and unsuitable for
authentication it will be a big thing. Users will be sure told to stop
using it but the existing deployments can't be saved. The support from
mkfs can be removed, kernel will warn or refuse to mount the
filesystems, etc. but what else can be done from the design point of
view?
