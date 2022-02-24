Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF4D4C378A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 22:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiBXVYN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 16:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiBXVYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 16:24:10 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35989184626;
        Thu, 24 Feb 2022 13:23:35 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 57D0C72F9; Thu, 24 Feb 2022 16:23:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 57D0C72F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1645737814;
        bh=OkVG8HhEKCzBDMlS68Ne4qJf64Q9ibr4f7QoJtnKZBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3lRwZHs04vSExkB+AR4Cj6i+T8amI3WBtE7BQV//KHaX9D9tmAAtNYi7kXGcqw4v
         gxlS0urkwsmqndbPb0jpGcvMdL0HvvJzWGV+WlV/PuWyj6Ukh+9CDMVTGUWzBxfZ/4
         jrqQQmPv/3TigWBEo87OM0kJuUxTJipmmjMrBqVY=
Date:   Thu, 24 Feb 2022 16:23:34 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daire Byrne <daire@dneg.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
Message-ID: <20220224212334.GB29410@fieldses.org>
References: <164549669043.5153.2021348013072574365@noble.neil.brown.name>
 <20220222190751.GA7766@fieldses.org>
 <164567931673.25116.15009501732764258663@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164567931673.25116.15009501732764258663@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 04:08:36PM +1100, NeilBrown wrote:
> On Wed, 23 Feb 2022, J. Bruce Fields wrote:
> > For what it's worth, I applied this to recent upstream (038101e6b2cd)
> > and fed it through my usual scripts--tests all passed, but I did see
> > this lockdep warning.
> > 
> > I'm not actually sure what was running at the time--probably just cthon.
> > 
> > --b.
> > 
> > [  142.679891] ======================================================
> > [  142.680883] WARNING: possible circular locking dependency detected
> > [  142.681999] 5.17.0-rc5-00005-g64e79f877311 #1778 Not tainted
> > [  142.682970] ------------------------------------------------------
> > [  142.684059] test1/4557 is trying to acquire lock:
> > [  142.684881] ffff888023d85398 (DENTRY_PAR_UPDATE){+.+.}-{0:0}, at: d_lock_update_nested+0x5/0x6a0
> > [  142.686421] 
> >                but task is already holding lock:
> > [  142.687171] ffff88801f618bd0 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: path_openat+0x7cb/0x24a0
> > [  142.689098] 
> >                which lock already depends on the new lock.
> > 
> > [  142.690045] 
> >                the existing dependency chain (in reverse order) is:
> > [  142.691171] 
> >                -> #1 (&type->i_mutex_dir_key#6){++++}-{3:3}:
> > [  142.692285]        down_write+0x82/0x130
> > [  142.692844]        vfs_rmdir+0xbd/0x560
> > [  142.693351]        do_rmdir+0x33d/0x400
> 
> Thanks.  I hadn't tested rmdir :-)

OK.  I tested with this applied and didn't see any issues.

--b.

> 
> "rmdir" and "open(O_CREATE)" take these locks in the opposite order.
> 
> I think the simplest fix might be to change the inode_lock(_shared) taken
> on the dir in open_last_Lookups() to use I_MUTEX_PARENT.  That is
> consistent with unlink and rmdir etc which use I_MUTEX_PARENT on the
> parent.
> 
> open() doesn't currently use I_MUTEX_PARENT because it never needs to
> lock the child.  But as it *is* a parent that is being locked, using
> I_MUTEX_PARENT probably make more sense.
> 
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3513,9 +3513,9 @@ static const char *open_last_lookups(struct nameidata *nd,
>  	}
>  	shared = !!(dir->d_inode->i_flags & S_PAR_UPDATE);
>  	if ((open_flag & O_CREAT) && !shared)
> -		inode_lock(dir->d_inode);
> +		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
>  	else
> -		inode_lock_shared(dir->d_inode);
> +		inode_lock_shared_nested(dir->d_inode, I_MUTEX_PARENT);
>  	dentry = lookup_open(nd, file, op, got_write);
>  	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
>  		fsnotify_create(dir->d_inode, dentry);
> 
> Thanks,
> NeilBrown
