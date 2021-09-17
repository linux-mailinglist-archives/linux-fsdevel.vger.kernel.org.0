Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB43340F4F9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbhIQJkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 05:40:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56358 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245597AbhIQJkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:40:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 91D98221DA;
        Fri, 17 Sep 2021 09:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631871518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2jn6TG6RiuPvPdae7dyVVFfCHRmFfoyDj/mSNAFf6k=;
        b=uqqLE+QM42UG5V8x7sVRPkw2fYmkmZS9ZJgrqO/d6xjsWlQu72uUXriamvk/3moql8v1Rl
        ouVMNTRnfZgReUJA+VlUQBQr2lnO7XKpmSp9wBmoJeLKhfP3BDJ2YhCPgaYGnRES2a+OXe
        8reQkXsp0Lw9u14OOKbMt2IuPDIrUxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631871518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w2jn6TG6RiuPvPdae7dyVVFfCHRmFfoyDj/mSNAFf6k=;
        b=P2pSHxaSlmyPNOUSh2cROw0Z45o8WdpyK8yIBmAeqbOvEYHSABgUnJCcsnwArgz3Wxmuyt
        SxaHcgh/Ux3Kz4BQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 857C1A3BA0;
        Fri, 17 Sep 2021 09:38:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 63E4B1E0CA7; Fri, 17 Sep 2021 11:38:38 +0200 (CEST)
Date:   Fri, 17 Sep 2021 11:38:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Shameless plug for the FS Track at LPC next week!
Message-ID: <20210917093838.GC6547@quack2.suse.cz>
References: <20210916013916.GD34899@magnolia>
 <20210917083043.GA6547@quack2.suse.cz>
 <20210917083608.GB6547@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917083608.GB6547@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-09-21 10:36:08, Jan Kara wrote:
> Let me also post Amir's thoughts on this from a private thread:

And now I'm actually replying to Amir :-p

> On Fri 17-09-21 10:30:43, Jan Kara wrote:
> > We did a small update to the schedule:
> > 
> > > Christian Brauner will run the second session, discussing what idmapped
> > > filesystem mounts are for and the current status of supporting more
> > > filesystems.
> > 
> > We have extended this session as we'd like to discuss and get some feedback
> > from users about project quotas and project ids:
> > 
> > Project quotas were originally mostly a collaborative feature and later got
> > used by some container runtimes to implement limitation of used space on a
> > filesystem shared by multiple containers. As a result current semantics of
> > project quotas are somewhat surprising and handling of project ids is not
> > consistent among filesystems. The main two contending points are:
> > 
> > 1) Currently the inode owner can set project id of the inode to any
> > arbitrary number if he is in init_user_ns. It cannot change project id at
> > all in other user namespaces.
> > 
> > 2) Should project IDs be mapped in user namespaces or not? User namespace
> > code does implement the mapping, VFS quota code maps project ids when using
> > them. However e.g. XFS does not map project IDs in its calls setting them
> > in the inode. Among other things this results in some funny errors if you
> > set project ID to (unsigned)-1.
> > 
> > In the session we'd like to get feedback how project quotas / ids get used
> > / could be used so that we can define the common semantics and make the
> > code consistently follow these rules.
> 
> I think that legacy projid semantics might not be a perfect fit for
> container isolation requirements. I added project quota support to docker
> at the time because it was handy and it did the job of limiting and
> querying disk usage of containers with an overlayfs storage driver.
> 
> With btrfs storage driver, subvolumes are used to create that isolation.
> The TREE_ID proposal [1] got me thinking that it is not so hard to
> implement "tree id" as an extention or in addition to project id.
> 
> The semantics of "tree id" would be:
> 1. tree id is a quota entity accounting inodes and blocks
> 2. tree id can be changed only on an empty directory
> 3. tree id can be set to TID only if quota inode usage of TID is 0
> 4. tree id is always inherited from parent
> 5. No rename() or link() across tree id (clone should be possible)
> 
> AFAIK btrfs subvol meets all the requirements of "tree id".
> 
> Implementing tree id in ext4/xfs could be done by adding a new field to
> inode on-disk format and a new quota entity to quota on-disk format and
> quotatools.
> 
> An alternative simpler way is to repurpose project id and project quota:
> * Add filesystem feature projid-is-treeid
> * The feature can be enabled on fresh mkfs or after fsck verifies "tree id"
>    rules are followed for all usage of projid
> * Once the feature is enabled, filesystem enforces the new semantics
>   about setting projid and projid_inherit
> 
> This might be a good option if there is little intersection between
> systems that need to use the old project semantics and systems
> that would rather have the tree id semantics.

Yes, I actually think that having both tree-id and project-id on a
filesystem would be too confusing. And I'm not aware of realistic usecases.
I've heard only of people wanting current semantics (although these we more
of the kind: "sometime in the past people used the feature like this") and
the people complaining current semantics is not useful for them. This was
discussed e.g. in ext4 list [2].

> I think that with the "tree id" semantics, the user_ns/idmapped
> questions become easier to answer.
> Allocating tree id ranges per userns to avoid exhausting the tree id
> namespace is a very similar problem to allocating uids per userns.

It still depends how exactly tree ids get used - if you want to use them to
limit space usage of a container, you still have to forbid changing of tree
ids inside the container, don't you?

> [1] https://lore.kernel.org/linux-fsdevel/162848132775.25823.2813836616908535300.stgit@noble.brown/

[2] https://lore.kernel.org/linux-ext4/20200428153228.GB6426@quack2.suse.cz

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
