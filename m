Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27881C6445
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 01:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgEEXDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 19:03:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:56626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgEEXDk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 19:03:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 69B5CAE87;
        Tue,  5 May 2020 23:03:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CB267DA7AD; Wed,  6 May 2020 01:02:50 +0200 (CEST)
Date:   Wed, 6 May 2020 01:02:50 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Jeff Mahoney <jeffm@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200505230250.GC18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jeff Mahoney <jeffm@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        david <david@sigma-star.at>, Sascha Hauer <s.hauer@pengutronix.de>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <164471725.184338.1588629556400.JavaMail.zimbra@nod.at>
 <SN4PR0401MB3598DDEF9BF9BACA71A1041D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <bc2811dd-8d1e-f2ff-7a9b-326fe4270b96@suse.com>
 <6d15c666-c7c8-8667-c25c-32bb89309b6d@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d15c666-c7c8-8667-c25c-32bb89309b6d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 08:39:21PM +0800, Qu Wenruo wrote:
> > That the checksums were originally intended for bitflip protection isn't
> > really relevant.  Using a different algorithm doesn't change the
> > fundamentals and the disk format was designed to use larger checksums
> > than crc32c.  The checksum tree covers file data.  The contextual
> > information is in the metadata describing the disk blocks and all the
> > metadata blocks have internal checksums that would also be
> > authenticated.  The only weak spot is that there has been a historical
> > race where a user submits a write using direct i/o and modifies the data
> > while in flight.  This will cause CRC failures already and that would
> > still happen with this.
> > 
> > All that said, the biggest weak spot I see in the design was mentioned
> > on LWN: We require the key to mount the file system at all and there's
> > no way to have a read-only but still verifiable file system.  That's
> > worth examining further.
> 
> That can be done easily, with something like ignore_auth mount option to
> completely skip hmac csum check (of course, need full RO mount, no log
> replay, no way to remount rw), completely rely on bytenr/gen/first_key
> and tree-checker to verify the fs.

Technical note: no unnecessary mount options, reuse the auth_key with
some special value.
