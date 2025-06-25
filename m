Return-Path: <linux-fsdevel+bounces-52906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A7AE842B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8BE1896AA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3226462B;
	Wed, 25 Jun 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NgQ4wJnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC9262FDE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857262; cv=none; b=WWVPK6w2jyMtMPOyixxOr8sjR36Nn8ZvctlEwSp3v0Tjzzd2tb5KKtatBX+bDrRlVs36/71FpI+fXA3R3sGsDVIUcvl1DcCn1Ol9P3zr7jPnryY+86mQg56q9XxvnXmN16Qg1SiWMLG2MWQxY/m3Q/j835dVu+Hn1cTDy/RzQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857262; c=relaxed/simple;
	bh=VyVL4KpvH5PpIzU7d6A8maGwHpB/XkUHFTH7hoYbrgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afPjAz0u5FDEcJYlv2/TviwS5pFQNG1cgTvTRmnSwfUXW1UPcuXAwmGSUKfeAeVgamLOKy9wfuLl0MOZL1usEqNfhfZ6NfPBLAF3svRkn998ysIoPHx4NAaww+Xcr6WIJNNqXf0nIZ2zev/PhRznXhKjJMx59CVLkKG8u+b+bDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NgQ4wJnQ; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bS2Mk28xSz4gR;
	Wed, 25 Jun 2025 15:14:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1750857250;
	bh=43gwrFzk4hwmv82prep9JmI9Q2MWI5mtLdOFVMSWLhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgQ4wJnQug59/VS2Oh7JY+Jr/FDR5DtjwhxRri1FhNkqbFQ98Q56GFLR7DHBsCkGs
	 bvo158SXQyDMKoVRoSSsTcsyjc2FcyOfMwWoXW3XKFbYOrhVFjX0so85UBO99Rclv7
	 jweEbF7djyq7VG+JJ+1QixEJ2MLc5oAIhHG6EUWA=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4bS2Mj0pxCzMjj;
	Wed, 25 Jun 2025 15:14:09 +0200 (CEST)
Date: Wed, 25 Jun 2025 15:14:08 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: NeilBrown <neil@brown.name>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, brauner@kernel.org, kernel-team@meta.com, andrii@kernel.org, 
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	Tingmao Wang <m@maowtm.org>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Message-ID: <20250625.Ee2Ci6chae8h@digikod.net>
References: <>
 <20250624.xahShi0iCh7t@digikod.net>
 <175080113326.2280845.18404947256630567790@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175080113326.2280845.18404947256630567790@noble.neil.brown.name>
X-Infomaniak-Routing: alpha

On Wed, Jun 25, 2025 at 07:38:53AM +1000, NeilBrown wrote:
> On Wed, 25 Jun 2025, Mickaël Salaün wrote:
> > On Fri, Jun 20, 2025 at 02:59:17PM -0700, Song Liu wrote:
> > > Hi Christian, Mickaël, and folks,
> > > 
> > > Could you please share your comments on this version? Does this
> > > look sane?
> > 
> > This looks good to me but we need to know what is the acceptable next
> > step to support RCU.  If we can go with another _rcu helper, I'm good
> > with the current approach, otherwise we need to figure out a way to
> > leverage the current helper to make it compatible with callers being in
> > a RCU read-side critical section while leveraging safe path walk (i.e.
> > several calls to path_walk_parent).
> 
> Can you spell out the minimum that you need?

Sure.  We'd like to call this new helper in a RCU
read-side critical section and leverage this capability to speed up path
walk when there is no concurrent hierarchy modification.  This use case
is similar to handle_dots() with LOOKUP_RCU calling follow_dotdot_rcu().

The main issue with this approach is to keep some state of the path walk
to know if the next call to "path_walk_parent_rcu()" would be valid
(i.e. something like a very light version of nameidata, mainly sequence
integers), and to get back to the non-RCU version otherwise.

> 
> My vague impression is that you want to search up from a given strut path,
> no further then some other given path, looking for a dentry that matches
> some rule.  Is that correct?

Yes

> 
> In general, the original dentry could be moved away from under the
> dentry you find moments after the match is reported.  What mechanisms do
> you have in place to ensure this doesn't happen, or that it doesn't
> matter?

In the case of Landlock, by default, a set of access rights are denied
and can only be allowed by an element in the file hierarchy.  The goal
is to only allow access to files under a specific directory (or directly
a specific file).  That's why we only care of the file hierarchy at the
time of access check.  It's not an issue if the file/directory was
moved or is being moved as long as we can walk its "current" hierarchy.
Furthermore, a sandboxed process is restricted from doing arbitrary
mounts (and renames/links are controlled with the
LANDLOCK_ACCESS_FS_REFER right).

However, we need to get a valid "snapshot" of the set of dentries that
(could) lead to the evaluated file/directory.

> 
> Would it be sufficient to have an iterator which reported successive
> ancestors in turn, or reported that you need to restart because something
> changed?  Would you need to know that a restart happened or would it be
> acceptable to transparently start again at the parent of the starting
> point?

If the path walk is being invalidated, we need to reset the collected
access right and start again the path walk to get all the access rights
from a consistent/real file hierarchy.

> 
> Or do you really need a "one step at a time" interface?

We need to check each component of the path walk, so either we call an
helper to get each of them and we do our check after that (we should be
able to do that in RCU), or we provide a callback function which is
called by the path walk helper.

> 
> Do you need more complex movements around the tree, or is just walking
> up sufficient?

Just walking up.

> 
> If this has been discussed or documented elsewhere I'd be happy for you
> just to provide a reference, and I can come back with follow-up
> questions if needed.

Tingmao initially described the goal here:
https://lore.kernel.org/all/afe77383-fe56-4029-848e-1401e3297139@maowtm.org/

and she sent an RFC to illustrate that:
https://lore.kernel.org/all/cover.1748997840.git.m@maowtm.org/

The discussion mainly raised two questions:
- Should we have one or two APIs?
- How to store the state of the walk without exposing VFS internals to
  the rest of the kernel?

Thanks

> 
> Thanks,
> NeilBrown
> 
> 
> > 
> > > 
> > > Thanks,
> > > Song
> > > 
> > > On Mon, Jun 16, 2025 at 11:11 PM Song Liu <song@kernel.org> wrote:
> > > >
> > > > In security use cases, it is common to apply rules to VFS subtrees.
> > > > However, filtering files in a subtree is not straightforward [1].
> > > >
> > > > One solution to this problem is to start from a path and walk up the VFS
> > > > tree (towards the root). Among in-tree LSMs, Landlock uses this solution.
> > > >
> > > 
> > > [...]
> > > 
> > 
> 
> 

