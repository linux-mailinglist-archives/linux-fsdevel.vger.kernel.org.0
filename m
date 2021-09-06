Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF48C401436
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 03:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241244AbhIFBcm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Sep 2021 21:32:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46474 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351572AbhIFBan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Sep 2021 21:30:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C40A1FF4F;
        Mon,  6 Sep 2021 01:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630891778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=na+7R1S+4icVQjnaL+FVDtQ+ahJOJz19HXFz4LslpyY=;
        b=mnYqc+ZUMtQoGJUsDfHThbCiZQYMKTqucZy96ObniBShVsRyJKIhRXPwge66uMg++6ZgE0
        BwhwlmtG2IuGQiaXiGaSRn8qVA7KuPYEBru7+AIZ1b3Fy7N3VveC0hQX5+pLVIpkqVn8XJ
        GggxifezGlmA9a7neY1+gmKFvJW558k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630891778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=na+7R1S+4icVQjnaL+FVDtQ+ahJOJz19HXFz4LslpyY=;
        b=Rf2mEtk1yXnUdkSYgSceILyZp+C+UQOV096d9G46j33P5IgezFQcSwy3TufskDP1SMwyxU
        pWJkXvi5FWLXisBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71E23133A4;
        Mon,  6 Sep 2021 01:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2wkXDABvNWFrFwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 06 Sep 2021 01:29:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Christoph Hellwig" <hch@infradead.org>,
        "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        "Josef Bacik" <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for btrfs export
In-reply-to: <20210905160719.GA20887@fieldses.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>,
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>,
 <YSkQ31UTVDtBavOO@infradead.org>,
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>,
 <YSnhHl0HDOgg07U5@infradead.org>,
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>,
 <YS8ppl6SYsCC0cql@infradead.org>, <20210901152251.GA6533@fieldses.org>,
 <163055605714.24419.381470460827658370@noble.neil.brown.name>,
 <20210905160719.GA20887@fieldses.org>
Date:   Mon, 06 Sep 2021 11:29:32 +1000
Message-id: <163089177281.15583.1479086104083425773@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 06 Sep 2021, J. Bruce Fields wrote:
> On Thu, Sep 02, 2021 at 02:14:17PM +1000, NeilBrown wrote:
> > On Thu, 02 Sep 2021, J. Bruce Fields wrote:
> > > I looked back through a couple threads to try to understand why we
> > > couldn't do that (on new filesystems, with a mkfs option to choose new
> > > or old behavior) and still don't understand.  But the threads are long.
> > > 
> > > There are objections to a new mount option (which seem obviously wrong;
> > > this should be a persistent feature of the on-disk filesystem).
> > 
> > I hadn't thought much (if at all) about a persistent filesystem feature
> > flag.  I'll try that now.
> > 
> > There are two features of interest.  One is completely unique inode
> > numbers, the other is reporting different st_dev for different
> > subvolumes.  I think these need to be kept separate, though the second
> > would depend on the first.  They would be similar to my "inumbits" and
> > "numdevs" mount options, though with less flexibility.  I think that
> > they would need strong semantics to be acceptable - "mostly unique"
> > isn't really acceptable once we are changing the on-disk data.
> 
> I don't quite follow that.

I agree it is a bit of a leap.

> 
> Also the "on-disk data" here is literally just one more flag bit in some
> superblock field, right?

Maybe.  I *could* be just one bit.
But even "just one bit" is, I think, more of a support commitement than
adding a mount option.
Mount options are fairly obvious to the user.  super-blocks not as much.
So "just one bit" might still be "one more question" than the supoort
people need to ask when handling a problem report.

When I wrote that I was thinking about how I would be comfortable with
if I were a btrfs maintainer.  And I don't think I'd like to spend and
on-disk change and only gain a "mostly harmless" solution.

Christoph's comment about possible vulnerabilities are probably part of
this.  I think that over NFS, concern about a user being able to
synthesise an inode number conflict is probably "mountain out of mole
hill" territory.  However for local access, I cannot convince myself
that it won't be a problem.  I can imagine (incautiously written)
auditing scans getting confused, and while auditing over NFS doesn't
make much sense, auditing locally does.

> 
> > I believe that some code *knows* that the root of any btrfs subvolumes
> > has inode number 256.  systemd seems to use this.  I have no idea what
> > else might depend on inode numbers in some way.
> 
> Looking.  Ugh, yes, there's  abtrfs_might_be_subvol that takes a struct
> stat and returns:
> 
>         return S_ISDIR(st->st_mode) && st->st_ino == 256;
> 
> I wonder why it does that?  Are there situations where all it has is a
> file descriptor (so it can't easily compare st_dev with the parent?)
> And if you NFS-export and wanted to answer the same question on the
> client side, I wonder what you'd do.

There are also a few references to BTRFS_FIRST_FREE_OBJECTID which is
256.

Uses seem to include:
 - managing quotas, which fits with my idea that subvols are like
   project-quota trees.
 - optionally preventing "rm -r" from removing subvols
 - some switching to/from "readonly" which I cannot follow
 - some special handling of user home-directories when they are
   subvols

These are probably reasonable and do point to subvols being a little bit
like separate filesytems.  These would break if we changed local inode
numbers. 

The project-quota management and the read-only setting are not available
via NFS so changing the inode number seen that way is not likely to
matter as much.  In any case, detecting "256" is only useful if you can
also detect "is btrfs", and you cannot do that of NFS.

Once upon a time ext[234] had a set of inode flags and xfs separately
had a bunch of inode flags.  These are now unified (to a degree) in
'struct fsattr' accessed by FS_IOC_FSGETXATTR and FS_IOC_FSSETXATTR.

btrfs supports that interface, but doesn't appear to have extended it
for subvol-specific things - preferring to create btrfs-specific ioctls
instead.   Maybe they weren't designed to be extensible enough.

Maybe what we really need is for a bunch of diverse filesystem
developers to get together and agree on some new common interface for
subvolume management, including coming up with some sort of definition
of what a subvolume "is".

Until that happens (and the new interfaces are implemented and widely
used) I can only see two possible solutions to the current
NFS-export-of-btrfs problem:

1/ change nfsd to export a different inode number to the one btrfs uses
   (or maybe a different fsid, but that is problematic in other ways)
2/ change userspace to check filehandles and not assume two things are
   the same if their filehandles are different.

Maybe I should write a patch for fts_read() and see how much glibc folk
will hate it.

NeilBrown
