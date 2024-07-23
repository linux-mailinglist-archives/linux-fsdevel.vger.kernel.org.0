Return-Path: <linux-fsdevel+bounces-24143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2A993A3AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 17:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786C6B22B22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jul 2024 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A6156F55;
	Tue, 23 Jul 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUyJmG7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B164A3D55D;
	Tue, 23 Jul 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721747986; cv=none; b=VpDd7x5WhrX3Ae74LSZcC6qdGZuko3jL4B16hTcrFqieB7C/HtZDJz83M8tl4EkgETAZQ9h2DmcCV2Vn4AsQdm2HFN4xvXrQRCo3bHxGObsjag6R0sKEMpkGmipc/97cTuGF06J+F3ePwjcsRohc1Jz7AO90rH6lEgiaM7lhpts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721747986; c=relaxed/simple;
	bh=FwPpgS4qRjlEJADupC/3U3E6AgMhwSAnIXwqKsSfzK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ii+dcZJnIp7mW9iKOiqhJW2PeTPeUXSONDgm2EoMnNmWuxcOc1KmPhrYCSCTEoTw8Fd0n85Lh5iBfWpX7mZg1kbp/YnGvNiEZtUjIP/wegB2qa5aUn74eIaJ3hg+/PrG6dVz9dkWkprR6rc728D4jEU5Z3M4++626pCtEJAvuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUyJmG7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1C9C4AF09;
	Tue, 23 Jul 2024 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721747986;
	bh=FwPpgS4qRjlEJADupC/3U3E6AgMhwSAnIXwqKsSfzK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUyJmG7wwbd1xfqy1LCcUUztVhYv1mjmyLFSESrHiudgz/0+RB0kyJbPuWmOHDS6h
	 H5hnH3CDR9fHV73GYHyn4+UWJ6bzfK2IO0lueVqppT+0XRSEBT03HfRCjNUSjpjNIE
	 h6rrL/hDl5sQT0zZ6nn7Q5wmNp88YLeI3o4bOvMBDdRtGzMcJ5TnxohfBnZJIfJ7xf
	 V8j/HXq/TOkhzg2ymsLEfjJLUyiSz+JnhQMYOX4wBfNbEY/uu+TjTC/qm74q+Wp3Ti
	 hktBrUpZWIZg3Nj9ckj/Z4OL3WCxrZuNFtt+HEy2Ndfv5G7uzn9lOHCdmgA9WBNq7v
	 RGhC+8KWPco5g==
Date: Tue, 23 Jul 2024 17:19:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Paul Moore <paul@paul-moore.com>, Matus Jokay <matus.jokay@stuba.sk>, 
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
Message-ID: <20240723-winkelmesser-wegschauen-4a8b00031504@brauner>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
 <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
 <Zp8k1H/qeaVZOXF5@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zp8k1H/qeaVZOXF5@dread.disaster.area>

On Tue, Jul 23, 2024 at 01:34:44PM GMT, Dave Chinner wrote:
> On Mon, Jul 22, 2024 at 03:46:36PM -0400, Paul Moore wrote:
> > On Mon, Jul 22, 2024 at 8:30 AM Matus Jokay <matus.jokay@stuba.sk> wrote:
> > > On 10. 7. 2024 12:40, Mickaël Salaün wrote:
> > > > On Tue, Jul 09, 2024 at 10:40:30PM -0400, Paul Moore wrote:
> > > >> The LSM framework has an existing inode_free_security() hook which
> > > >> is used by LSMs that manage state associated with an inode, but
> > > >> due to the use of RCU to protect the inode, special care must be
> > > >> taken to ensure that the LSMs do not fully release the inode state
> > > >> until it is safe from a RCU perspective.
> > > >>
> > > >> This patch implements a new inode_free_security_rcu() implementation
> > > >> hook which is called when it is safe to free the LSM's internal inode
> > > >> state.  Unfortunately, this new hook does not have access to the inode
> > > >> itself as it may already be released, so the existing
> > > >> inode_free_security() hook is retained for those LSMs which require
> > > >> access to the inode.
> > > >>
> > > >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > >
> > > > I like this new hook.  It is definitely safer than the current approach.
> > > >
> > > > To make it more consistent, I think we should also rename
> > > > security_inode_free() to security_inode_put() to highlight the fact that
> > > > LSM implementations should not free potential pointers in this blob
> > > > because they could still be dereferenced in a path walk.
> > > >
> > > >> ---
> > > >>  include/linux/lsm_hook_defs.h     |  1 +
> > > >>  security/integrity/ima/ima.h      |  2 +-
> > > >>  security/integrity/ima/ima_iint.c | 20 ++++++++------------
> > > >>  security/integrity/ima/ima_main.c |  2 +-
> > > >>  security/landlock/fs.c            |  9 ++++++---
> > > >>  security/security.c               | 26 +++++++++++++-------------
> > > >>  6 files changed, 30 insertions(+), 30 deletions(-)
> > 
> > ...
> > 
> > > Sorry for the questions, but for several weeks I can't find answers to two things related to this RFC:
> > >
> > > 1) How does this patch close [1]?
> > >    As Mickaël pointed in [2], "It looks like security_inode_free() is called two times on the same inode."
> > >    Indeed, it does not seem from the backtrace that it is a case of race between destroy_inode and inode_permission,
> > >    i.e. referencing the inode in a VFS path walk while destroying it...
> > >    Please, can anyone tell me how this situation could have happened? Maybe folks from VFS... I added them to the copy.
> > 
> > The VFS folks can likely provide a better, or perhaps a more correct
> > answer, but my understanding is that during the path walk the inode is
> > protected by a RCU lock which allows for multiple threads to access
> > the inode simultaneously; this could result in some cases where one
> > thread is destroying the inode while another is accessing it.
> 
> Shouldn't may_lookup() be checking the inode for (I_NEW |
> I_WILLFREE | I_FREE) so that it doesn't access an inode either not
> completely initialised or being evicted during the RCU path walk?

Going from memory since I don't have time to go really into the weeds.

A non-completely initalised inode shouldn't appear in path lookup.
Before the inode is attached to a dentry I_NEW would have been removed
otherwise this is a bug. That can either happen via unlock_new_inode()
and d_splice_alias() or in some cases directly via d_instantiate_new().
Concurrent inode lookup calls on the same inode (e.g., iget_locked() and
friends) will sleep until I_NEW is cleared.

> All accesses to the VFS inode that don't have explicit reference
> counts have to do these checks...
> 
> IIUC, at the may_lookup() point, the RCU pathwalk doesn't have a
> fully validate reference count to the dentry or the inode at this
> point, so it seems accessing random objects attached to an inode
> that can be anywhere in the setup or teardown process isn't at all
> safe...

may_lookup() cannot encounter inodes in random states. It will start
from a well-known struct path and sample sequence counters for rename,
mount, and dentry changes. Each component will be subject to checks
after may_lookup() via these sequence counters to ensure that no change
occurred that would invalidate the lookup just done. To be precise to
ensure that no state could be reached via rcu that couldn't have been
reached via ref walk.

So may_lookup() may be called on something that's about to be freed
(concurrent unlink on a directory that's empty that we're trying to
create or lookup something nonexistent under) while we're looking at it
but all the machinery is in place so that it will be detected and force
a drop out of rcu and into reference walking mode.

When may_lookup() calls inode_permission() it only calls into the
filesystem itself if the filesystem has a custom i_op->permission()
handler. And if it has to call into the filesystem it passes
MAY_NOT_BLOCK to inform the filesystem about this. And in those cases
the filesystem must ensure any additional data structures can safely be
accessed under rcu_read_lock() (documented in path_lookup.rst).

If the filesystem detects that it cannot safely handle this or detects
that something is invalid it can return -ECHILD causing the VFS to drop
out of rcu and into ref walking mode to redo the lookup. That may happen
directly in may_lookup() it unconditionally happens in walk_component()
when it's verified that the parent had no changes while we were looking
at it.

The same logic extends to security modules. Both selinux and smack
handle MAY_NOT_BLOCK calls from security_inode_permission() with e.g.,
selinux returning -ECHILD in case the inode security context isn't
properly initialized causing the VFS to drop into ref walking mode and
allowing selinux to redo the initialization.

Checking inode state flags isn't needed because the VFS already handles
all of this via other means as e.g., sequence counters in various core
structs. It also likely wouldn't help because we'd have to take locks to
access i_state or sample i_state before calling into inode_permission()
and then it could still change behind our back. It's also the wrong
layer as we're dealing almost exclusively with dentries as the main data
structure during lookup.

Fwiw, a bunch of this is documented in path_lookup.rst, vfs.rst, and
porting.rst.

(I'm running out of time with other stuff so I want to point out that I
can't really spend a lot more time on this thread tbh.)

