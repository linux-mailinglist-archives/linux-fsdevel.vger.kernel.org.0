Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B9C3586A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbhDHOPR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHOPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 10:15:16 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE41C061760;
        Thu,  8 Apr 2021 07:15:05 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 36F954EED; Thu,  8 Apr 2021 10:15:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 36F954EED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1617891304;
        bh=dOmSvj8o6Mxs8CG0sMgv2OAEtdtvrroO6SzhTOKgBKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ME88SfqRorC9DJaS5UPilD8skUqUXC6gs9m+vZYNuyOw/Co6A4LNLPhAPLzHbzgO2
         hXju5rTGYmI2A+ozdIlerKxG2f8wmhPHHJ4Vo04qMssYq27e7AQvm1vyGyYgcE5bfS
         GwI8jNZ7pLzWBfRfzvY2JancSs3QwM5yMVCiM+1A=
Date:   Thu, 8 Apr 2021 10:15:04 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: open_by_handle_at() in userns
Message-ID: <20210408141504.GB25439@fieldses.org>
References: <20210328155624.930558-1-amir73il@gmail.com>
 <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
 <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
 <CAOQ4uxiizVxVJgtytYk_o7GvG2O2qwyKHgScq8KLhq218CNdnw@mail.gmail.com>
 <20210331100854.sdgtzma6ifj7w5yn@wittgenstein>
 <CAOQ4uxjHsqZqLT-DOPS0Q0FiHZ2Ge=d3tP+3-qd+O2optq9rZg@mail.gmail.com>
 <20210408125530.gnv5hqcmgewklypn@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408125530.gnv5hqcmgewklypn@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 02:55:30PM +0200, Christian Brauner wrote:
> On Thu, Apr 08, 2021 at 02:44:47PM +0300, Amir Goldstein wrote:
> > > One thing your patch
> > >
> > > commit ea31e84fda83c17b88851de399f76f5d9fc1abf4
> > > Author: Amir Goldstein <amir73il@gmail.com>
> > > Date:   Sat Mar 20 12:58:12 2021 +0200
> > >
> > >     fs: allow open by file handle inside userns
> > >
> > >     open_by_handle_at(2) requires CAP_DAC_READ_SEARCH in init userns,
> > >     where most filesystems are mounted.
> > >
> > >     Relax the requirement to allow a user with CAP_DAC_READ_SEARCH
> > >     inside userns to open by file handle in filesystems that were
> > >     mounted inside that userns.
> > >
> > >     In addition, also allow open by handle in an idmapped mount, which is
> > >     mapped to the userns while verifying that the returned open file path
> > >     is under the root of the idmapped mount.
> > >
> > >     This is going to be needed for setting an fanotify mark on a filesystem
> > >     and watching events inside userns.
> > >
> > >     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Requires fs/exportfs/expfs.c to be made idmapped mounts aware.
> > > open_by_handle_at() uses exportfs_decode_fh() which e.g. has the
> > > following and other callchains:
> > >
> > > exportfs_decode_fh()
> > > -> exportfs_decode_fh_raw()
> > >    -> lookup_one_len()
> > >       -> inode_permission(mnt_userns, ...)
> > >
> > > That's not a huge problem though I did all these changes for the
> > > overlayfs support for idmapped mounts I have in a branch from an earlier
> > > version of the idmapped mounts patchset. Basically lookup_one_len(),
> > > lookup_one_len_unlocked(), and lookup_positive_unlocked() need to take
> > > the mnt_userns into account. I can rebase my change and send it for
> > > consideration next cycle. If you can live without the
> > > open_by_handle_at() support for now in this patchset (Which I think you
> > > said you could.) then it's not a blocker either. Sorry for the
> > > inconvenience.
> > >
> > 
> > Christian,
> > 
> > I think making exportfs_decode_fh() idmapped mount aware is not
> > enough, because when a dentry alias is found in dcache, none of
> > those lookup functions are called.
> > 
> > I think we will also need something like this:
> > https://github.com/amir73il/linux/commits/fhandle_userns
> > 
> > I factored-out a helper from nfsd_apcceptable() which implements
> > the "subtree_check" nfsd logic and uses it for open_by_handle_at().
> > 
> > I've also added a small patch to name_to_handle_at() with a UAPI
> > change that could make these changes usable by userspace nfs
> > server inside userns, but I have no demo nor tests for that and frankly,
> > I have little incentive to try and promote this UAPI change without
> > anybody asking for it...
> 
> Ah, at first I was confused about why this would matter but it matters
> because nfsd already implements a check of that sort directly in nfsd
> independent of idmapped mounts:
> https://github.com/amir73il/linux/commit/4bef9ff1718935b7b42afbae71cfaab7770e8436

Only in the NFSEXP_NOSUBTREECHECK case.  Taking a quick look, I think
Amir's not proposing a check like that by default, so, fine.  (I assume
problems with e.g. subtreechecking and cross-directory renames are
understood....)

> Afaict, an nfs server can't be mounted inside of userns right now. That
> is something that folks from Netflix and from Kinvolk have been
> interested in enabling. They also want the ability to use idmapped
> mounts + nfs. Understandable that you don't want to drive this of
> course. I'll sync with them about this.

I think those would both be reasonable things to do.

--b.

> Independent of that, I thought our last understanding was that you
> wouldn't need to handle open_by_handle_at() for now.
> 
> Christian
