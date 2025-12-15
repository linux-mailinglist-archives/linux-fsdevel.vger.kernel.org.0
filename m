Return-Path: <linux-fsdevel+bounces-71344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B182CCBE9BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19E793061C7C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C9E345752;
	Mon, 15 Dec 2025 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFCKKO8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65B3451D9;
	Mon, 15 Dec 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808401; cv=none; b=Uz/ULNkROUSRhpVbfpWDpmGr7rc+aSqYkuhZUQpXW2ca5s5v5GaCVfYrEHsTV21OrRLyo9H5EpnPv6NYtiV8WnaaNUYPk2w8VhG+NJCq8ji1GqJCOBp+mEhJrNq/q+LXzfX4xw7wjogdm0Ols8d/MTQzcgr/XqW2gPqaqketfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808401; c=relaxed/simple;
	bh=SOKNAp3KlXqmQkYAHiY1KnI5hmWZlwxQAhzfS0nZwp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIoEB+n1sPAcQgcbWZrUiLBH+jZQZY3o6jxGUMLFjiuxGX500ACkKSve6XLqihOQw8EGfPHDOGNnKS8OpLkaOFF+tBdZQb1xKhsgLoTGcgp1JuPnzZ7c67KaxgVeZHXxsXIsLIC2cP2eGx2RBcmLvjW8qVe5gMficrmvqbPcgfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFCKKO8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0605C4CEF5;
	Mon, 15 Dec 2025 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765808400;
	bh=SOKNAp3KlXqmQkYAHiY1KnI5hmWZlwxQAhzfS0nZwp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFCKKO8Y56kGcvgU39JK+toyUpk4jGwiPG6HyglacSq1MKmKkenC3jKNS9/HS5ipp
	 B6NSOx8wBgq7Am6EMfMeh1PNOzsczwCgxkrjC6/z42Hk9J8i+SuYZOm6VUp9ou3SV9
	 dgItcJM7Pf5rvLbJn9iHf33BlNlYry5yy3lCZ7IwJ+0MJKNGUTfNv5fUXEn1llrPl4
	 EdZzX8EDySvcR9aLsG+tR4I+BaJYILYt8x/3OPDwPDyv8kLUOno34+gcWfYODinh1u
	 qnMHAYCJBYMihFLwg4WxBl6Nw3qxa68g95/milv0l5zl+UvAMcycihLDuAxNErOEg+
	 Xu0/K5zP9ANjw==
Date: Mon, 15 Dec 2025 15:19:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Amir Goldstein <amir73il@gmail.com>, 
	NeilBrown <neil@brown.name>, Val Packett <val@packett.cool>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tyler Hicks <code@tyhicks.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Carlos Maiolino <cem@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-xfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Subject: Re: [PATCH] fuse: fix conversion of fuse_reverse_inval_entry() to
 start_removing()
Message-ID: <20251215-immens-hurtig-1f0b23aa4bf3@brauner>
References: <20251113002050.676694-1-neilb@ownmail.net>
 <20251113002050.676694-7-neilb@ownmail.net>
 <6713ea38-b583-4c86-b74a-bea55652851d@packett.cool>
 <176454037897.634289.3566631742434963788@noble.neil.brown.name>
 <CAOQ4uxjihcBxJzckbJis8hGcWO61QKhiqeGH+hDkTUkDhu23Ww@mail.gmail.com>
 <20251201083324.GA3538@ZenIV>
 <CAJfpegs+o01jgY76WsGnk9j41LS5V0JQSk--d6xsJJp4VjTh8Q@mail.gmail.com>
 <20251205-unmoralisch-jahrtausend-cca02ad0e4fa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251205-unmoralisch-jahrtausend-cca02ad0e4fa@brauner>

On Fri, Dec 05, 2025 at 02:09:41PM +0100, Christian Brauner wrote:
> On Mon, Dec 01, 2025 at 03:03:08PM +0100, Miklos Szeredi wrote:
> > On Mon, 1 Dec 2025 at 09:33, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Mon, Dec 01, 2025 at 09:22:54AM +0100, Amir Goldstein wrote:
> > >
> > > > I don't think there is a point in optimizing parallel dir operations
> > > > with FUSE server cache invalidation, but maybe I am missing
> > > > something.
> > >
> > > The interesting part is the expected semantics of operation;
> > > d_invalidate() side definitely doesn't need any of that cruft,
> > > but I would really like to understand what that function
> > > is supposed to do.
> > >
> > > Miklos, could you post a brain dump on that?
> > 
> > This function is supposed to invalidate a dentry due to remote changes
> > (FUSE_NOTIFY_INVAL_ENTRY).  Originally it was supplied a parent ID and
> > a name and called d_invalidate() on the looked up dentry.
> > 
> > Then it grew a variant (FUSE_NOTIFY_DELETE) that was also supplied a
> > child ID, which was matched against the looked up inode.  This was
> > commit 451d0f599934 ("FUSE: Notifying the kernel of deletion."),
> > Apparently this worked around the fact that at that time
> > d_invalidate() returned -EBUSY if the target was still in use and
> > didn't unhash the dentry in that case.
> > 
> > That was later changed by commit bafc9b754f75 ("vfs: More precise
> > tests in d_invalidate") to unconditionally unhash the target, which
> > effectively made FUSE_NOTIFY_INVAL_ENTRY and FUSE_NOTIFY_DELETE
> > equivalent and the code in question unnecessary.
> > 
> > For the future, we could also introduce FUSE_NOTIFY_MOVE, that would
> > differentiate between a delete and a move, while
> > FUSE_NOTIFY_INVAL_ENTRY would continue to be the common (deleted or
> > moved) notification.
> > 
> > Attaching untested patch to remove this cruft.
> 
> Should we revert the fuse specific bits of c9ba789dad15 ("VFS: introduce
> start_creating_noperm() and start_removing_noperm()") and then apply
> your changes afterwards?

I think we shouldn't have this sitting around indefinitely so it would
be good if we'd get a nod that this is ok or someone sending revert +
fix that I can pick up. :)

