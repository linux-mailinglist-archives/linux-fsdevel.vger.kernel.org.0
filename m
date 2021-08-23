Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D913F539E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 01:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhHWXW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 19:22:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbhHWXW4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:22:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D3A9420019;
        Mon, 23 Aug 2021 23:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629760931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7BBVvHaQw/s+KITQeP577sqWBVDyFdUma/can/bxpE=;
        b=edSs3Cs2bRbe3wwxDwxWAQ9KkrRQSbqpE8pyiBzj8LmIDreY1QLcC0kCnQUDtYPncYpsZi
        c78F4UyB1UADRlWMV870uphXPLDA3/YCYvUrHNmdX7qvx5ij98ZEU2w7DjsxRCbpI0bfLh
        jCs2KlnzqcQnVUOMmmJLiHaFMOyNs1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629760931;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C7BBVvHaQw/s+KITQeP577sqWBVDyFdUma/can/bxpE=;
        b=OycGFkFf79VlirrFV/hlYK8bqfQ/Ha/b+aLB997bk3Us0/M//inY93I1sWozTg5KYHPmic
        +YWzXHXK3yD1jGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6559113BB4;
        Mon, 23 Aug 2021 23:22:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5EnCCKAtJGFDLQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Aug 2021 23:22:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
Cc:     "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] VFS/BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210822192917.GF29026@hungrycats.org>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <162881913686.1695.12479588032010502384@noble.neil.brown.name>,
 <20210818225454.9558.409509F4@e16-tech.com>,
 <162932318266.9892.13600254282844823374@noble.neil.brown.name>,
 <20210819021910.GB29026@hungrycats.org>,
 <162942805745.9892.7512463857897170009@noble.neil.brown.name>,
 <20210822192917.GF29026@hungrycats.org>
Date:   Tue, 24 Aug 2021 09:22:05 +1000
Message-id: <162976092544.9892.3996716616493030747@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Aug 2021, Zygo Blaxell wrote:
...
> 
> Subvol IDs are not reusable.  They are embedded in shared object ownership
> metadata, and persist for some time after subvols are deleted.
...
> 
> The cost of _tracking_ free object IDs is trivial compared to the cost
> of _reusing_ an object ID on btrfs.

One possible approach to these two objections is to decouple inode
numbers from object ids.
The inode number becomes just another piece of metadata stored in the
inode.
struct btrfs_inode_item has four spare u64s, so we could use one of
those.
struct btrfs_dir_item would need to store the inode number too.  What
is location.offset used for?  Would a diritem ever point to a non-zero
offset?  Could the 'offset' be used to store the inode number?

This could even be added to existing filesystems I think.  It might not
be easy to re-use inode numbers smaller than the largest at the time the
extension was added, but newly added inode numbers could be reused after
they were deleted.

Just a thought...

NeilBrown
