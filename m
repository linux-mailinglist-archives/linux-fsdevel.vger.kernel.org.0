Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75981E2163
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 May 2020 13:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732038AbgEZLyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 07:54:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:57216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728513AbgEZLyB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 07:54:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07DF9AC69;
        Tue, 26 May 2020 11:54:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3A4FADA72D; Tue, 26 May 2020 13:53:01 +0200 (CEST)
Date:   Tue, 26 May 2020 13:53:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 0/3] Add file-system authentication to BTRFS
Message-ID: <20200526115300.GY18421@twin.jikos.cz>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35986E7B3F88F1EB288051A79BB00@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 07:50:53AM +0000, Johannes Thumshirn wrote:
> On 25/05/2020 15:11, David Sterba wrote:
> > On Thu, May 14, 2020 at 11:24:12AM +0200, Johannes Thumshirn wrote:
> > As mentioned in the discussion under LWN article, https://lwn.net/Articles/818842/
> > ZFS implements split hash where one half is (partial) authenticated hash
> > and the other half is a checksum. This allows to have at least some sort
> > of verification when the auth key is not available. This applies to the
> > fixed size checksum area of metadata blocks, for data we can afford to
> > store both hashes in full.
> > 
> > I like this idea, however it brings interesting design decisions, "what
> > if" and corner cases:
> > 
> > - what hashes to use for the plain checksum, and thus what's the split
> > - what if one hash matches and the other not
> > - increased checksum calculation time due to doubled block read
> > - whether to store the same parital hash+checksum for data too
> > 
> > As the authenticated hash is the main usecase, I'd reserve most of the
> > 32 byte buffer to it and use a weak hash for checksum: 24 bytes for HMAC
> > and 8 bytes for checksum. As an example: sha256+xxhash or
> > blake2b+xxhash.
> > 
> > I'd outright skip crc32c for the checksum so we have only small number
> > of authenticated checksums and avoid too many options, eg.
> > hmac-sha256-crc32c etc. The result will be still 2 authenticated hashes
> > with the added checksum hardcoded to xxhash.
> 
> Hmm I'm really not a fan of this. We would have to use something like 
> sha2-224 to get the room for the 2nd checksum. So we're using a weaker
> hash just so we can add a second checksum.

The idea is to calculate full hash (32 bytes) and store only the part
(24 bytes). Yes this means there's some information loss and weakening,
but enables a usecase.

> On the other hand you've asked 
> me to add the known pieces of information into the hashes as a salt to
> "make attacks harder at a small cost".

Yes and this makes it harder to attack the hash, it should be there
regardless of the additional checksums.
