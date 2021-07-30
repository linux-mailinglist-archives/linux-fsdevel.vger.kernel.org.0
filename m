Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326923DB3F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhG3Gx4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 02:53:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59522 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbhG3Gx4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:53:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8A4F22366;
        Fri, 30 Jul 2021 06:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627628030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0VNkysLskS0vnZtSs3qO15oG+ZfZSStWcowuBEvjK0=;
        b=iQMSwnhihJwCoCZBEdV6IbqSoM5d74znAm0W70tiGcRRKKuODaPpef0bzHyDA6ei6YuYLW
        ZFO5+/hGt8TLtlcZ6othbK0CZagNoh7oHNx2nlsHXRmFuzANVCSbGl0oMUO1bo73/PBFaj
        m0uNeZ9uTPRMuxptfjrEdQpCTGSnIzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627628030;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O0VNkysLskS0vnZtSs3qO15oG+ZfZSStWcowuBEvjK0=;
        b=jLH0hAM1ut/uV7ynp2lkHt/4r19cZbXU03Cj/kSid1O5Ni0+OBLxJw1yy6pnR6jzCzcLUz
        EWGS6WGY2a2FS2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C543113BFD;
        Fri, 30 Jul 2021 06:53:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wn1wIPqhA2G5DgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 30 Jul 2021 06:53:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>
Cc:     "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>,
        "Neal Gompa" <ngompa13@gmail.com>,
        "Wang Yugui" <wangyugui@e16-tech.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, "Chris Mason" <clm@fb.com>,
        "David Sterba" <dsterba@suse.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>,
        linux-nfs@vger.kernel.org,
        "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
In-reply-to: <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>,
 <20210728125819.6E52.409509F4@e16-tech.com>,
 <20210728140431.D704.409509F4@e16-tech.com>,
 <162745567084.21659.16797059962461187633@noble.neil.brown.name>,
 <CAEg-Je8Pqbw0tTw6NWkAcD=+zGStOJR0J-409mXuZ1vmb6dZsA@mail.gmail.com>,
 <162751265073.21659.11050133384025400064@noble.neil.brown.name>,
 <20210729023751.GL10170@hungrycats.org>,
 <162752976632.21659.9573422052804077340@noble.neil.brown.name>,
 <20210729232017.GE10106@hungrycats.org>,
 <162761259105.21659.4838403432058511846@noble.neil.brown.name>,
 <341403c0-a7a7-f6c8-5ef6-2d966b1907a8@gmx.com>,
 <162762468711.21659.161298577376336564@noble.neil.brown.name>,
 <bcde95bc-0bb8-a6e9-f197-590c8a0cba11@gmx.com>
Date:   Fri, 30 Jul 2021 16:53:43 +1000
Message-id: <162762802395.21659.5310176078177217626@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Jul 2021, Qu Wenruo wrote:
> >
> > You mean like "du -x"?? Yes.  You would lose the misleading illusion
> > that there are multiple filesystems.  That is one user-expectation that
> > would need to be addressed before people opt-in
> 
> OK, forgot it's an opt-in feature, then it's less an impact.

The hope would have to be that everyone would eventually opt-in once all
issues were understood.

> 
> Really not familiar with NFS/VFS, thus some ideas from me may sounds
> super crazy.
> 
> Is it possible that, for nfsd to detect such "subvolume" concept by its
> own, like checking st_dev and the fsid returned from statfs().
> 
> Then if nfsd find some boundary which has different st_dev, but the same
> fsid as its parent, then it knows it's a "subvolume"-like concept.
> 
> Then do some local inode number mapping inside nfsd?
> Like use the highest 20 bits for different subvolumes, while the
> remaining 44 bits for real inode numbers.
> 
> Of-course, this is still a workaround...

Yes, it would certainly be possible to add some hacks to nfsd to fix the
immediate problem, and we could probably even created some well-defined
interfaces into btrfs to extract the required information so that it
wasn't too hackish.

Maybe that is what we will have to do.  But I'd rather not hack NFSD
while there is any chance that a more complete solution will be found.

I'm not quite ready to give up on the idea of squeezing all btrfs inodes
into a 64bit number space.  24bits of subvol and 40 bits of inode?
Make the split a mkfs or mount option?
Maybe hand out inode numbers to subvols in 2^32 chunks so each subvol
(which has ever been accessed) has a mapping from the top 32 bits of the
objectid to the top 32 bits of the inode number.

We don't need something that is theoretically perfect (that's not
possible anyway as we don't have 64bits of device numbers).  We just
need something that is practical and scales adequately.  If you have
petabytes of storage, it is reasonable to spend a gigabyte of memory on
a lookup table(?).

If we can make inode numbers unique, we can possibly leave the st_dev
changing at subvols so that "du -x" works as currently expected.

One thought I had was to use a strong hash to combine the subvol object
id and the inode object id into a 64bit number.  What is the chance of
a collision in practice :-)

Thanks,
NeilBrown
