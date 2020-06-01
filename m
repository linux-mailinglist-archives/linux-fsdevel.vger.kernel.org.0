Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3731EA66A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFAO7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 10:59:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:45834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbgFAO7b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 10:59:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AC677AD3A;
        Mon,  1 Jun 2020 14:59:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 444DEDA79B; Mon,  1 Jun 2020 16:59:27 +0200 (CEST)
Date:   Mon, 1 Jun 2020 16:59:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 0/3] Add file-system authentication to BTRFS
Message-ID: <20200601145926.GV18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200525131040.GS18421@twin.jikos.cz>
 <SN4PR0401MB35986E7B3F88F1EB288051A79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200526115300.GY18421@twin.jikos.cz>
 <SN4PR0401MB35987BC70887DA064136F82A9BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35987BC70887DA064136F82A9BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 12:44:28PM +0000, Johannes Thumshirn wrote:
> On 26/05/2020 13:54, David Sterba wrote:
> > On Tue, May 26, 2020 at 07:50:53AM +0000, Johannes Thumshirn wrote:
> >> On 25/05/2020 15:11, David Sterba wrote:
> >>> I'd outright skip crc32c for the checksum so we have only small number
> >>> of authenticated checksums and avoid too many options, eg.
> >>> hmac-sha256-crc32c etc. The result will be still 2 authenticated hashes
> >>> with the added checksum hardcoded to xxhash.
> >>
> >> Hmm I'm really not a fan of this. We would have to use something like 
> >> sha2-224 to get the room for the 2nd checksum. So we're using a weaker
> >> hash just so we can add a second checksum.
> > 
> > The idea is to calculate full hash (32 bytes) and store only the part
> > (24 bytes). Yes this means there's some information loss and weakening,
> > but enables a usecase.
> 
> I'm not enough a security expert to be able to judge this. Eric can I hear 
> your opinion on this?

Given that this has implications on strength and the usecases, I'd
rather let the filesystem provide the options and let the user choose
and not make the decision for their behalf.

This would increase number of authenticated hashes to 4 in the end:

1. authenticated with 32byte/256bit hash (sha256, blake2b)
   + full strength
   - no way to verify checksums without the key

2. authenticated with 24bytes/192bit hash (sha256, blake2b)
   where the last 8 bytes are xxhash64
   ~ weakened strength but should be still sufficient
   + possibility to verify checksums without the key
   - slight perf cost for the 2nd hash

As option 2 needs some evaluation and reasoning whether it does not
compromise the security, I don't insist on having it implemented in the
first phase. I have a prototype code for that so it might live in
linux-next for some time before we'd merge it.

Regarding backward compatibility, the checksums are easy compared to
other features. The supported status can be deteremined directly from
superblock so adding new types of checksum do not require compat bits
and the code for that.
