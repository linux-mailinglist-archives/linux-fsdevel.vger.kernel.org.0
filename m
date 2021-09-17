Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1150A40F43B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245429AbhIQIhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 04:37:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52804 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhIQIhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:37:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4029F1FD68;
        Fri, 17 Sep 2021 08:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631867768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDZMWSg88cXL9HKFxT32RxAm4ej0/aggM2dOLgrWoG4=;
        b=VU2N8WY08v4AJuYPSnxafESTqtPiFgV5OxwYHRY9FC+EF23TfaVKZTl7Jr9Hw49aKLGB/U
        mwrvxdBlIBFt6fgR7Bo5HokIGOAZaZvlZuqcBtZ++5KVJsF+hiHHKl3CBvwJZ/CjWlh+8Y
        /wEalvKjenwy65aJzxo8EZLKXGeXMMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631867768;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MDZMWSg88cXL9HKFxT32RxAm4ej0/aggM2dOLgrWoG4=;
        b=1oSWeTNJCOeI811fzoFdYl4wwuxP5sbhVkYg9s5gDzeo3x2xH+amMh9FF63u6NuZiLRbJ1
        4M1h86og3VfGR5AA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 3070AA3BB8;
        Fri, 17 Sep 2021 08:36:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 13FFB1E0CA7; Fri, 17 Sep 2021 10:36:08 +0200 (CEST)
Date:   Fri, 17 Sep 2021 10:36:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Shameless plug for the FS Track at LPC next week!
Message-ID: <20210917083608.GB6547@quack2.suse.cz>
References: <20210916013916.GD34899@magnolia>
 <20210917083043.GA6547@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917083043.GA6547@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Let me also post Amir's thoughts on this from a private thread:

On Fri 17-09-21 10:30:43, Jan Kara wrote:
> We did a small update to the schedule:
> 
> > Christian Brauner will run the second session, discussing what idmapped
> > filesystem mounts are for and the current status of supporting more
> > filesystems.
> 
> We have extended this session as we'd like to discuss and get some feedback
> from users about project quotas and project ids:
> 
> Project quotas were originally mostly a collaborative feature and later got
> used by some container runtimes to implement limitation of used space on a
> filesystem shared by multiple containers. As a result current semantics of
> project quotas are somewhat surprising and handling of project ids is not
> consistent among filesystems. The main two contending points are:
> 
> 1) Currently the inode owner can set project id of the inode to any
> arbitrary number if he is in init_user_ns. It cannot change project id at
> all in other user namespaces.
> 
> 2) Should project IDs be mapped in user namespaces or not? User namespace
> code does implement the mapping, VFS quota code maps project ids when using
> them. However e.g. XFS does not map project IDs in its calls setting them
> in the inode. Among other things this results in some funny errors if you
> set project ID to (unsigned)-1.
> 
> In the session we'd like to get feedback how project quotas / ids get used
> / could be used so that we can define the common semantics and make the
> code consistently follow these rules.

I think that legacy projid semantics might not be a perfect fit for
container isolation requirements. I added project quota support to docker
at the time because it was handy and it did the job of limiting and
querying disk usage of containers with an overlayfs storage driver.

With btrfs storage driver, subvolumes are used to create that isolation.
The TREE_ID proposal [1] got me thinking that it is not so hard to
implement "tree id" as an extention or in addition to project id.

The semantics of "tree id" would be:
1. tree id is a quota entity accounting inodes and blocks
2. tree id can be changed only on an empty directory
3. tree id can be set to TID only if quota inode usage of TID is 0
4. tree id is always inherited from parent
5. No rename() or link() across tree id (clone should be possible)

AFAIK btrfs subvol meets all the requirements of "tree id".

Implementing tree id in ext4/xfs could be done by adding a new field to
inode on-disk format and a new quota entity to quota on-disk format and
quotatools.

An alternative simpler way is to repurpose project id and project quota:
* Add filesystem feature projid-is-treeid
* The feature can be enabled on fresh mkfs or after fsck verifies "tree id"
   rules are followed for all usage of projid
* Once the feature is enabled, filesystem enforces the new semantics
  about setting projid and projid_inherit

This might be a good option if there is little intersection between
systems that need to use the old project semantics and systems
that would rather have the tree id semantics.

I think that with the "tree id" semantics, the user_ns/idmapped
questions become easier to answer.
Allocating tree id ranges per userns to avoid exhausting the tree id
namespace is a very similar problem to allocating uids per userns.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/162848132775.25823.2813836616908535300.stgit@noble.brown/
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
