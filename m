Return-Path: <linux-fsdevel+bounces-23286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD48292A454
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 16:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674F91F21FB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC2C13C69A;
	Mon,  8 Jul 2024 14:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0acH4c+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B3084FA0
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447916; cv=none; b=KUiVq3HziPJJa4ETIB9u7/CIvqEXgRknEzsztMhl9I1KEJKpJ3a/xm4DOZFgxAa3SoaKAShWo9rW3cgxXeGgh21qk6UqJOOB8eLc3JvEFtDwGsfIAi1TOYEltMVuy+u9LViB7gRXF96hAR9XdLQsMitCC2PdxCXO3sTS+VdO2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447916; c=relaxed/simple;
	bh=1ByY6PXW2xxzSd22cVMso9XpgM+bCV0UwLxue8k786U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4vlPmk9sIZyCQ9MK7kab6MDUS8Wwi3zUefBwNXoS9kkKxHxyggRd2jyZZQhKzojoWwKnzpArRC/1cHh2+h6ebqWcAqeu2e6GPlBMMcwrcINrBMSxCoZ62VDKkGQcUXBVN9TM2nmhRSbMzxQs+vNCfjxga6jwUpP/jvTDacDktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0acH4c+/; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WHmJc6gmyzj4P;
	Mon,  8 Jul 2024 16:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720447904;
	bh=SWoeWAKcGmuLJ7xgWkDxhZp8KgZj+OA6pwC+rCsx6wA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0acH4c+/M6ebmADvJWrr2AgaJxbdxA1pjxR68UDUuNpv1tSf5MfgrTg0+iehNiNql
	 A4AXYGVpuT7vBw6mKyLNfvcxGphJDln0LhjwL+RXbQO7E7OGpARkqJPJJaBQlolaqN
	 73HbuXMjlnqwuaHK0vXVmo0UwglZYUxw/YC3O8Rs=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WHmJb6cmdzwJh;
	Mon,  8 Jul 2024 16:11:43 +0200 (CEST)
Date: Mon, 8 Jul 2024 16:11:41 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jann Horn <jannh@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, 
	syzbot <syzbot+5446fbf332b0602ede0b@syzkaller.appspotmail.com>, jmorris@namei.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [syzbot] [lsm?] general protection fault in
 hook_inode_free_security
Message-ID: <20240708.ig8Kucapheid@digikod.net>
References: <00000000000076ba3b0617f65cc8@google.com>
 <CAHC9VhSmbAY8gX=Mh2OT-dkQt+W3xaa9q9LVWkP9q8pnMh+E_w@mail.gmail.com>
 <20240515.Yoo5chaiNai9@digikod.net>
 <20240516.doyox6Iengou@digikod.net>
 <20240627.Voox5yoogeum@digikod.net>
 <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhT-Pm6_nJ-8Xd_B4Fq+jZ0kYnfc3wwNa_jM+4=pg5RVrQ@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Jun 27, 2024 at 02:28:03PM -0400, Paul Moore wrote:
> On Thu, Jun 27, 2024 at 9:34 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > I didn't find specific issues with Landlock's code except the extra
> > check in hook_inode_free_security().  It looks like inode->i_security is
> > a dangling pointer, leading to UAF.
> >
> > Reading security_inode_free() comments, two things looks weird to me:
> >
> > > /**
> > >  * security_inode_free() - Free an inode's LSM blob
> > >  * @inode: the inode
> > >  *
> > >  * Deallocate the inode security structure and set @inode->i_security to NULL.
> >
> > I don't see where i_security is set to NULL.
> 
> The function header comments are known to be a bit suspect, a side
> effect of being detached from the functions for many years, this may
> be one of those cases.  I tried to fix up the really awful ones when I
> moved the comments back, back I didn't have time to go through each
> one in detail.  Patches to correct the function header comments are
> welcome and encouraged! :)
> 
> > >  */
> > > void security_inode_free(struct inode *inode)
> > > {
> >
> > Shouldn't we add this check here?
> > if (!inode->i_security)
> >         return;
> 
> Unless I'm remembering something wrong, I believe we *should* always
> have a valid i_security pointer each time we are called, if not
> something has gone wrong, e.g. the security_inode_free() hook is no
> longer being called from the right place.  If we add a NULL check, we
> should probably have a WARN_ON(), pr_err(), or something similar to
> put some spew on the console/logs.
> 
> All that said, it would be good to hear some confirmation from the VFS
> folks that the security_inode_free() hook is located in a spot such
> that once it exits it's current RCU critical section it is safe to
> release the associated LSM state.
> 
> It's also worth mentioning that while we always allocate i_security in
> security_inode_alloc() right now, I can see a world where we allocate
> the i_security field based on need using the lsm_blob_size info (maybe
> that works today?  not sure how kmem_cache handled 0 length blobs?).
> The result is that there might be a legitimate case where i_security
> is NULL, yet we still want to call into the LSM using the
> inode_free_security() implementation hook.
> 
> > >       call_void_hook(inode_free_security, inode);
> > >       /*
> > >        * The inode may still be referenced in a path walk and
> > >        * a call to security_inode_permission() can be made
> > >        * after inode_free_security() is called. Ideally, the VFS
> > >        * wouldn't do this, but fixing that is a much harder
> > >        * job. For now, simply free the i_security via RCU, and
> > >        * leave the current inode->i_security pointer intact.
> > >        * The inode will be freed after the RCU grace period too.
> >
> > It's not clear to me why this should be safe if an LSM try to use the
> > partially-freed blob after the hook calls and before the actual blob
> > free.
> 
> I had the same thought while looking at this just now.  At least in
> the SELinux case I think this "works" simply because SELinux doesn't
> do much here, it just drops the inode from a SELinux internal list
> (long story) and doesn't actually release any memory or reset the
> inode's SELinux state (there really isn't anything to "free" in the
> SELinux case).  I haven't checked the other LSMs, but they may behave
> similarly.
> 
> We may want (need?) to consider two LSM implementation hooks called
> from within security_inode_free(): the first where the existing
> inode_free_security() implementation hook is called, the second inside
> the inode_free_by_rcu() callback immediately before the i_security
> data is free'd.

Couldn't we call everything in inode_free_by_rcu()?
I replied here instead:
https://lore.kernel.org/r/20240708.hohNgieja0av@digikod.net

> 
> ... or we find a better placement in the VFS for
> security_inode_free(), is that is possible.  It may not be, our VFS
> friends should be able to help here.

Christian? Al?

> 
> > >        */
> > >       if (inode->i_security)
> > >               call_rcu((struct rcu_head *)inode->i_security,
> > >                        inode_free_by_rcu);
> >
> > And then:
> > inode->i_security = NULL;
> 
> According to the comment we may still need i_security for permission
> checks.  See my comment about decomposing the LSM implementation into
> two hooks to better handle this for LSMs.

That was my though too, but maybe not if the path walk just ends early.

> 
> > But why call_rcu()?  i_security is not protected by RCU barriers.
> 
> I believe the issue is that the inode is protected by RCU and that
> affects the lifetime of the i_security blob.

It seems to be related to commit fa0d7e3de6d6 ("fs: icache RCU free
inodes").

