Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715E21C48AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 22:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEDU7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 16:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:32790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgEDU7h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 16:59:37 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA9F206A5;
        Mon,  4 May 2020 20:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588625976;
        bh=53OHInTw9sNfsV+8pEntSpT2NrmGF+EPe5Sli3OSZ0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLttWRN5A1goAYEow/hG9CmSC5n0sBoT3OwEP9sTeDC4lvmDh2G+4YPyOmFT6W3Ia
         aabiSYWQBExhG5VO5KJLW4qPb3pY3DXQQbM6qF3BlMytp2CAXKKjMiJoODFyZJu8EK
         MiYIoNX0EDj8r9mGp/KaCpzRM4YgBibKVZakg5lk=
Date:   Mon, 4 May 2020 13:59:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        David Sterba <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 1/2] btrfs: add authentication support
Message-ID: <20200504205935.GA51650@gmail.com>
References: <20200428105859.4719-1-jth@kernel.org>
 <20200428105859.4719-2-jth@kernel.org>
 <20200501053908.GC1003@sol.localdomain>
 <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598198E5FB728B68B39A1589BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 04, 2020 at 10:09:44AM +0000, Johannes Thumshirn wrote:
> On 01/05/2020 07:39, Eric Biggers wrote:
> [...]
> 
> Thanks for taking the time to look through this.
> 
> > 
> > This is a good idea, but can you explain exactly what security properties you
> > aim to achieve?
> 
> My goal is to protect the file-system against offline modifications. 
> Offline in this context means when the filesystem is not mounted.
> 
> This could be a switched off laptop in a hotel room or a container 
> image, or a powered off embedded system. When the file-system is mounted 
> normal read/write access is possible.

But your proposed design doesn't do this completely, since some times of offline
modifications are still possible.

So that's why I'm asking *exactly* what security properties it will provide.

> 
> > As far as I can tell, btrfs hashes each data block individually.  There's no
> > contextual information about where eaech block is located or which file(s) it
> > belongs to.  So, with this proposal, an attacker can still replace any data
> > block with any other data block.  Is that what you have in mind?  Have you
> > considered including contextual information in the hashes, to prevent this?
> > 
> > What about metadata blocks -- how well are they authenticated?  Can they be
> > moved around?  And does this proposal authenticate *everything* on the
> > filesystem, or is there any part that is missed?  What about the superblock?
> 
> In btrfs every metadata block is started by a checksum (see struct 
> btrfs_header or struct btrfs_super_block). This checksum protects the 
> whole meta-data block (minus the checksum field, obviously).
> 
> The two main structure of the trees are btrfs_node and btrfs_leaf (both 
> started by a btrfs_header). struct btrfs_node holds the generation and 
> the block pointers of child nodes (and leafs). Struct btrfs_leaf holds 
> the items, which can be inodes, directories, extents, checksums, 
> block-groups, etc...
> 
> As each FS meta-data item, beginning with the super block, downwards to 
> the meta-data items themselves is protected be a checksum, so the FS 
> tree (including locations, generation, etc) is protected by a checksum, 
> for which the attacker would need to know the key to generate.
> 
> The checksum for data blocks is saved in a separate on-disk btree, the 
> checksum tree. The structure of the checksum tree consists of 
> btrfs_leafs and btrfs_nodes as well, both of which do have a 
> btrfs_header and thus are protected by the checksums.

Does this mean that a parent node's checksum doesn't cover the checksum of its
child nodes, but rather only their locations?  Doesn't that allow subtrees to be
swapped around without being detected?

> 
> > 
> > You also mentioned preventing replay of filesystem operations, which suggests
> > you're trying to achieve rollback protection.  But actually this scheme doesn't
> > provide rollback protection.  For one, an attacker can always just rollback the
> > entire filesystem to a previous state.
> 
> You're right, replay is the wrong wording there and it's actually 
> harmful in the used context. What I had in mind was, in order to change 
> the structure of the filesystem, an attacker would need the key to 
> update the checksums, otherwise the next read will detect a corruption.
> 
> As for a real replay case, an attacker would need to increase the 
> generation of the tree block, in order to roll back to a older state, an 
> attacker still would need to modify the super-block's generation, which 
> is protected by the checksum as well.

Actually, nothing in the current design prevents the whole filesystem from being
rolled back to an earlier state.  So, an attacker can actually both "change the
structure of the filesystem" and "roll back to an earlier state".

It very well might not be practical to provide rollback protection, and this
feature would still be useful without it.  But I'm concerned that you're
claiming that this feature provides rollback protection when it doesn't.

> > The hash algorithm needs to be passed as a mount option.  Otherwise the attacker
> > gets to choose it for you among all the supported keyed hash algorithms, as soon
> > as support for a second one is added.  Maybe use 'auth_hash_name' like UBIFS
> > does?
> 
> Can you elaborate a bit more on that? As far as I know, UBIFS doesn't 
> save the 'auth_hash_name' on disk, whereas 'BTRFS_CSUM_TYPE_HMAC_SHA256' 
> is part of the on-disk format. As soon as we add a 2nd keyed hash, say 
> BTRFS_CSUM_TYPE_BLAKE2B_KEYED, this will be in the superblock as well, 
> as struct btrfs_super_block::csum_type.
> 

The data on disk isn't trusted.  Isn't that the whole point?  The filesystem
doesn't trust it until it is MAC'ed, and to do that it needs the MAC algorithm.

- Eric
