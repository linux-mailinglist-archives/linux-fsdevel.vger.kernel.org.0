Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12111C6494
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 01:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgEEXjI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 19:39:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:40004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgEEXjI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 19:39:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7F974AC46;
        Tue,  5 May 2020 23:39:08 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 321E1DA7AD; Wed,  6 May 2020 01:38:17 +0200 (CEST)
Date:   Wed, 6 May 2020 01:38:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 0/2] Add file-system authentication to BTRFS
Message-ID: <20200505233816.GE18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200501212648.GA521030@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501212648.GA521030@zx2c4.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 03:26:48PM -0600, Jason A. Donenfeld wrote:
> > Currently BRTFS supports CRC32C, XXHASH64, SHA256 and Blake2b for checksumming
> > these blocks. This series adds a new checksum algorithm, HMAC(SHA-256), which
> > does need an authentication key. When no, or an incoreect authentication key
> > is supplied no valid checksum can be generated and a read, fsck or scrub
> > operation would detect invalid or tampered blocks once the file-system is
> > mounted again with the correct key. 
> 
> In case you're interested, Blake2b and Blake2s both have "keyed" modes,
> which are more efficient than HMAC and achieve basically the same thing
> -- they provide a PRF/MAC. There are normal crypto API interfaces for
> these, and there's also an easy library interface:
> 
> #include <crypto/blake2s.h>
> blake2s(output_mac, input_data, secret_key,
>         output_mac_length, input_data_length, secret_key_length);
> 
> You might find that the performance of Blake2b and Blake2s is better
> than HMAC-SHA2-256.

As Eric also pointed out, the keyed blake2b is suitable.

> But more generally, I'm wondering about the general design and what
> properties you're trying to provide. Is the block counter being hashed
> in to prevent rearranging? Are there generation counters to prevent
> replay/rollback?

Hopefully the details will be covered in the next iteration, but let me
to give you at least some information.

The metadata blocks contain a logical block address and generation.
(https://elixir.bootlin.com/linux/latest/source/fs/btrfs/ctree.h#L161)
The generation is incremented by one each time the superblock (and thus
the transaction epoch) is written. The block number changes when it is
COWed. The metadata block (sizes are 4k up to 64k) is checksummed from
the 'fsid' member to the end of the block, ie. including the generation
and block address.

The mapping of physical blocks on devices and the logical addreses is
stored in a separate b-tree, as dedicated items in metadata blocks, so
there's inherent checksumming of that information.

The data blocks themselves have a detached checksum stored in checksum
tree, again inside items in metadata blocks.

The last remaining part is the superblock and that is being discussed in
https://lore.kernel.org/linux-btrfs/20200505221448.GW18421@twin.jikos.cz/
