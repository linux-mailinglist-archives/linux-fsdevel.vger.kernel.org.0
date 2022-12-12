Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F9464AA0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Dec 2022 23:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiLLWOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 17:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiLLWOd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:14:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC5C183B1;
        Mon, 12 Dec 2022 14:14:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A21E31F8C3;
        Mon, 12 Dec 2022 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670883269;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iu1km/g1sPbdm1PysSK8oZqkVLK+FsDA35rUtF19Te4=;
        b=YQisxeGOiVeV1btWZg2vu9Oq/MIJ/DYQ7x4NiwtZN0r0F+WfeZEm351kJPg74lUhVfIbwO
        +Bati0xiymrARzFgqPPEQGB0I9TTrRD5Rt7In/1pos1bHGc4/H/s1V51xR+row9cagJgAs
        p2EKhOxvGKZ1wcpiT9tRE4Fw+2icJ1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670883269;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iu1km/g1sPbdm1PysSK8oZqkVLK+FsDA35rUtF19Te4=;
        b=vAAtT6/yI5XUmZaJwfp7omtuY5X2OVQJRIDLgBLJHp2s109ksM/bnK8klJCpf6q31rNDBZ
        6Nof02Z5CRU/IkBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54443138F3;
        Mon, 12 Dec 2022 22:14:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2c+nE8Wnl2PdHwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Mon, 12 Dec 2022 22:14:29 +0000
Date:   Mon, 12 Dec 2022 23:13:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/19] btrfs: handle checksum validation and repair at
 the storage layer
Message-ID: <20221212221347.GC5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20221120124734.18634-1-hch@lst.de>
 <20221120124734.18634-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120124734.18634-3-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 20, 2022 at 01:47:17PM +0100, Christoph Hellwig wrote:
> Currently btrfs handles checksum validation and repair in the end I/O
> handler for the btrfs_bio.  This leads to a lot of duplicate code
> plus issues with variying semantics or bugs, e.g.
> 
>  - the until recently broken repair for compressed extents
>  - the fact that encoded reads validate the checksums but do not kick
>    of read repair
>  - the inconsistent checking of the BTRFS_FS_STATE_NO_CSUMS flag
> 
> This commit revamps the checksum validation and repair code to instead
> work below the btrfs_submit_bio interfaces.  For this to work we need
> to make sure an inode is available, so that is added as a parameter
> to btrfs_bio_alloc.  With that btrfs_submit_bio can preload
> btrfs_bio.csum from the csum tree without help from the upper layers,
> and the low-level I/O completion can iterate over the bio and verify
> the checksums.
> 
> In case of a checksum failure (or a plain old I/O error), the repair
> is now kicked off before the upper level ->end_io handler is invoked.
> Tracking of the repair status is massively simplified by just keeping
> a small failed_bio structure per bio with failed sectors and otherwise
> using the information in the repair bio.  The per-inode I/O failure
> tree can be entirely removed.
> 
> The saved bvec_iter in the btrfs_bio is now competely managed by
> btrfs_submit_bio and must not be accessed by the callers.
> 
> There is one significant behavior change here:  If repair fails or
> is impossible to start with, the whole bio will be failed to the
> upper layer.  This is the behavior that all I/O submitters execept
> for buffered I/O already emulated in their end_io handler.  For
> buffered I/O this now means that a large readahead request can
> fail due to a single bad sector, but as readahead errors are igored
> the following readpage if the sector is actually accessed will
> still be able to read.  This also matches the I/O failure handling
> in other file systems.

This patch is apparently doing several things at once, please split it.
Thanks.
