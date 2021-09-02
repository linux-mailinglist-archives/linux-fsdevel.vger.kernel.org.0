Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123003FE84F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 06:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhIBEPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 00:15:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhIBEPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 00:15:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8FB2224BC;
        Thu,  2 Sep 2021 04:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630556061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bgb2nvS8+/8reZZV/agOAadMtosg8d0yRFRv2TodBAc=;
        b=lnUWV6IfDoRmkrFW6sBlBFPQ9oYJN0+QU7oZnz32LN5TPZqQQ0uJ7RAcIlCAvKLh7J8WCn
        eIQNoPOhF7s+RPvnL1CifT8ndodozadqwxs2iVczDia4zLM3DipfNF06OEC+rBFc7dTkDQ
        Vpm4erDWtMkaQeY4TWTshg3TX4eEa3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630556061;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bgb2nvS8+/8reZZV/agOAadMtosg8d0yRFRv2TodBAc=;
        b=EETyF5ropdYZNhJoAfM+PwTTc6waChFjMPqN2+EPUeaQrZPbts6dgEjjDWIz0MWoMaRWdu
        MIQlodDl1pP20qAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 102B713B3F;
        Thu,  2 Sep 2021 04:14:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A28EL5tPMGE3fQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 02 Sep 2021 04:14:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Josef Bacik" <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210901152251.GA6533@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <YSkQ31UTVDtBavOO@infradead.org>,
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>,
 <YSnhHl0HDOgg07U5@infradead.org>,
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>,
 <YS8ppl6SYsCC0cql@infradead.org>, <20210901152251.GA6533@fieldses.org>
Date:   Thu, 02 Sep 2021 14:14:17 +1000
Message-id: <163055605714.24419.381470460827658370@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 02 Sep 2021, J. Bruce Fields wrote:
> I looked back through a couple threads to try to understand why we
> couldn't do that (on new filesystems, with a mkfs option to choose new
> or old behavior) and still don't understand.  But the threads are long.
> 
> There are objections to a new mount option (which seem obviously wrong;
> this should be a persistent feature of the on-disk filesystem).

I hadn't thought much (if at all) about a persistent filesystem feature
flag.  I'll try that now.

There are two features of interest.  One is completely unique inode
numbers, the other is reporting different st_dev for different
subvolumes.  I think these need to be kept separate, though the second
would depend on the first.  They would be similar to my "inumbits" and
"numdevs" mount options, though with less flexibility.  I think that
they would need strong semantics to be acceptable - "mostly unique"
isn't really acceptable once we are changing the on-disk data.

The "unique inode numbers" bit (UIN) would require that file object-ids
fit in some number of bits (maybe 40) and that subvolume numbers fit in
the remaining bits (24) and would then combine them together for the
inode number.  This could obviously be set at mkfs time.  Could it be
set on an unmounted filesystem?

The "single-dev" flag (SD) could be toggled any time that UIN was set,
and mkfs would default it on if UIN was selected.

If UIN was in effect, then creating a subvol beyond the permitted max
would have to fail.  24 bits is small enough that we would probably want
a warning of impending doom - maybe at 23 bits? The current 48bits
doesn't need that.
Similarly creating an inode beyond 40bits would have to fail.  This is
probably more problematic and so might need more warnings.  Do we want a
warning each time any subvol crosses some limit?  If not we would need a
flag for each warning.

What should a sysadmin do when they see the warning? If 40 bit an
unacceptable limit of the total number of inodes in a subvol, or is it
only a problem because of btrfs' practice of never reusing object-ids?

Backup-and-restore would compact object-ids, but would be a big cost.
Off-line reindexing would be cheaper (does anyone else remember using
"renum" programs with BASIC??).  Online lazy re-indexing might be
possible if the inode number was maintained separately from the
object-id and an atomic "switch which inode number to use" could be done
at mount time.

Setting UIN on an existing filesystem would require checking that only
24bit are used for subvolumes (easy) and that only 40 were usgd for
objects in any individual subvolume (presumably that would require
checking all subvolumes, which might take a little while, but shouldn't
take more than a few minutes.

Doing this would break any indexes that might be created over files, and
would probably upset any active NFS mounts, and would likely have other
problems.  Se it would need to be a well-documented step with clear
rewards.

An alternative to renumbering would be to maintain file-ids and
subvolume-ids which are separate from the object-id.  Apparently reusing
subvolume object-ids is not possible and reusing file object-ids is
quite costly.  If the file-id were separate from the object-id, these
problems would vanish.

This would require extra space in the inode (there are several reserved
u64s, so that isn't a problem) and space in each directory entry (might
be more of a problem).  It would also require some way to keep track of
used (or unused) id numbers.  This avoids the cost of renumbering, by
spreading it out over every creation.  I suspect the average
inode-creation overhead could be kept quite low, but not quite zero.

I believe that some code *knows* that the root of any btrfs subvolumes
has inode number 256.  systemd seems to use this.  I have no idea what
else might depend on inode numbers in some way.

I suspect that if we tried to roll out a change like this, either almost
no-one would use it (if it wasn't the default), or things would start
breaking (if it was).  I'm not against breaking things, but we need to
be sure there is a solution for fixing them, and I'm certainly not up to
doing that myself.

So yes - I think that using a mkfs option would open up other avenues
for a solution.  There would still be a lot of work to find something
that continues to meet everyone's needs.

The advantage of an nfsd-focusses solution is that we can have working
code today with minimal down-sides.  I'm certainly not prepared to go
digging through btrfs code to determine how to implement a btrfs-only
solution without strong buy-in from btrfs maintainers.

NeilBrown
