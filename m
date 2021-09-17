Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 524B340FDA4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbhIQQNl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 12:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243366AbhIQQNj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:13:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3277611C4;
        Fri, 17 Sep 2021 16:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631895137;
        bh=uTmfg0vv6vwj4FrYE4j5mba4CVZJQ7Gc8JrPKcVhY6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZGw6F7XEdLNKWtHFnkGjC3Ph1hUrkzryX/AlGu21AjxOK7y6XRDuw4EtGarkW718
         PW4QaNJbqocm43BnVSv5y3w17CVyQCBMwyi3nDSVlWyFwkcjFOcBKOzEfwOL0mVxLO
         6fGIXqxp9lWaBjtHdQSRmuwqlVRa/gkt3fdRDUe27RRvSIjm1EVE84RWMbm0QvLj45
         sWe0pF/CtzkDe4ATWLyVZpldl9RyD9IQuJcx4uHZKq4RTzeRpdUrvHzo+DhU5t7RpF
         d32CbQJB0zEYyimHbuA45lgUzp3aX8m9ciQJFKhTEaMWEdRE1LeiudX80IjWAOS4Ky
         1tP2YpEe0zD3w==
Date:   Fri, 17 Sep 2021 09:12:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: Shameless plug for the FS Track at LPC next week!
Message-ID: <20210917161217.GB10224@magnolia>
References: <20210916013916.GD34899@magnolia>
 <20210917083043.GA6547@quack2.suse.cz>
 <20210917083608.GB6547@quack2.suse.cz>
 <20210917093838.GC6547@quack2.suse.cz>
 <CAOQ4uxg3FYuQ3hrhG5H87Uzd-2gYXbFfUkeTPY7ESsDdjGB5EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg3FYuQ3hrhG5H87Uzd-2gYXbFfUkeTPY7ESsDdjGB5EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 01:23:08PM +0300, Amir Goldstein wrote:
> On Fri, Sep 17, 2021 at 12:38 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 17-09-21 10:36:08, Jan Kara wrote:
> > > Let me also post Amir's thoughts on this from a private thread:
> >
> > And now I'm actually replying to Amir :-p
> >
> > > On Fri 17-09-21 10:30:43, Jan Kara wrote:
> > > > We did a small update to the schedule:
> > > >
> > > > > Christian Brauner will run the second session, discussing what idmapped
> > > > > filesystem mounts are for and the current status of supporting more
> > > > > filesystems.
> > > >
> > > > We have extended this session as we'd like to discuss and get some feedback
> > > > from users about project quotas and project ids:
> > > >
> > > > Project quotas were originally mostly a collaborative feature and later got
> > > > used by some container runtimes to implement limitation of used space on a
> > > > filesystem shared by multiple containers. As a result current semantics of
> > > > project quotas are somewhat surprising and handling of project ids is not
> > > > consistent among filesystems. The main two contending points are:
> > > >
> > > > 1) Currently the inode owner can set project id of the inode to any
> > > > arbitrary number if he is in init_user_ns. It cannot change project id at
> > > > all in other user namespaces.
> > > >
> > > > 2) Should project IDs be mapped in user namespaces or not? User namespace
> > > > code does implement the mapping, VFS quota code maps project ids when using
> > > > them. However e.g. XFS does not map project IDs in its calls setting them
> > > > in the inode. Among other things this results in some funny errors if you
> > > > set project ID to (unsigned)-1.
> > > >
> > > > In the session we'd like to get feedback how project quotas / ids get used
> > > > / could be used so that we can define the common semantics and make the
> > > > code consistently follow these rules.
> > >
> > > I think that legacy projid semantics might not be a perfect fit for
> > > container isolation requirements. I added project quota support to docker
> > > at the time because it was handy and it did the job of limiting and
> > > querying disk usage of containers with an overlayfs storage driver.
> > >
> > > With btrfs storage driver, subvolumes are used to create that isolation.
> > > The TREE_ID proposal [1] got me thinking that it is not so hard to
> > > implement "tree id" as an extention or in addition to project id.
> > >
> > > The semantics of "tree id" would be:
> > > 1. tree id is a quota entity accounting inodes and blocks
> > > 2. tree id can be changed only on an empty directory
> > > 3. tree id can be set to TID only if quota inode usage of TID is 0
> > > 4. tree id is always inherited from parent
> > > 5. No rename() or link() across tree id (clone should be possible)
> > >
> > > AFAIK btrfs subvol meets all the requirements of "tree id".
> > >
> > > Implementing tree id in ext4/xfs could be done by adding a new field to
> > > inode on-disk format and a new quota entity to quota on-disk format and
> > > quotatools.
> > >
> > > An alternative simpler way is to repurpose project id and project quota:
> > > * Add filesystem feature projid-is-treeid
> > > * The feature can be enabled on fresh mkfs or after fsck verifies "tree id"
> > >    rules are followed for all usage of projid
> > > * Once the feature is enabled, filesystem enforces the new semantics
> > >   about setting projid and projid_inherit

I'd probably just repurpose the project quota mechanism, which means
that the xfs treeid is really just project quotas with somewhat
different behavior rules that are tailored to modern adversarial usage
models. ;)

IIRC someone asked for some sort of change like this on the xfs list
some years back.  If memory serves, they wanted to prevent non-admin
userspace from changing project ids, even in the regular user ns?  It
never got as far as a formal proposal though.

I could definitely see a use case for letting admin processes in a
container change project ids among only the projids that are idmapped
into the namespace.

> > >
> > > This might be a good option if there is little intersection between
> > > systems that need to use the old project semantics and systems
> > > that would rather have the tree id semantics.
> >
> > Yes, I actually think that having both tree-id and project-id on a
> > filesystem would be too confusing. And I'm not aware of realistic usecases.
> > I've heard only of people wanting current semantics (although these we more
> > of the kind: "sometime in the past people used the feature like this") and
> > the people complaining current semantics is not useful for them. This was
> > discussed e.g. in ext4 list [2].
> >
> > > I think that with the "tree id" semantics, the user_ns/idmapped
> > > questions become easier to answer.
> > > Allocating tree id ranges per userns to avoid exhausting the tree id
> > > namespace is a very similar problem to allocating uids per userns.
> >
> > It still depends how exactly tree ids get used - if you want to use them to
> > limit space usage of a container, you still have to forbid changing of tree
> > ids inside the container, don't you?
> >
> 
> Yes.
> This is where my view of userns becomes hazy (so pulling Christain into
> the discussion), but in general I think that this use case would be similar
> to the concept of single uid container - the range of allowed tree ids that
> is allocated for the container in that case is a single tree id.
> 
> I understand that the next question would be about nesting subtree quotas
> and I don't have a good answer to that question.
> 
> Are btrfs subvolume nested w.r.t. capacity limit? I don't think that they are.

One thing that someone on #btrfs pointed out to me -- unlike ext4 and
xfs project quotas where the statvfs output reflects the project quota
limits, btrfs qgroups don't do that.  Software that tries to trim its
preallocations when "space" gets low (e.g. journald) then fails to react
and /var/log can fill up.

Granted, it's btrfs quotas which they say aren't production ready still
and I have no idea, so ... <shrug>

--D

> 
> Thanks,
> Amir.
