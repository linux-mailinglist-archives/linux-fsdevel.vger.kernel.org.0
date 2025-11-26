Return-Path: <linux-fsdevel+bounces-69903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F8C8AB73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 16:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A8973511BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 15:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0D833A70E;
	Wed, 26 Nov 2025 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NONAjYmo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17833A003
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764171756; cv=none; b=sVEieNfGnrApJPrnHwVznOzJ8hWop9IRHH8KyLqdD6hRh+gatPKv1PDM/RvxmTU+owBqWQ4d5PyWOH5cr958recXUbUYLRMz7NN+Ug6gv/GQAIY258H2xip9Iy3rKXcjFWINdih7lyfZn1ZF1JtBtusVPYWLKB3EOnlhTIftlNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764171756; c=relaxed/simple;
	bh=VGKaVfICgJGHSKSeBv12nWC1fPNr9vGasFo7XthZ8Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSZYZkbzi0OjXosiqsGPgRClaZIRaqOeVZwbWm1QvoHaEkPh11W7V+PzBhUkCH1Zfj1KCL1TZ6FrjYLq15PrYNKUMea0ZqaUxpvFyTO50mCiJAOPOjtMDvVBNA9HpdlEYDZ+wfbvekIgVnn8Fk67Eu+51ke9DTbULxcxflSF5y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NONAjYmo; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dGk8L0j0yzWhJ;
	Wed, 26 Nov 2025 16:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1764171153;
	bh=yyZSmgbUtBmbNW8C1z7X+aSYcQgfxQDBTlBVle5b2G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NONAjYmoKbD868tPV1HcXeRpuQLHvXNBNf7CMVt2ZE1QaJesDSw+pfcVhYx8TEEPw
	 t6dyXYWHst5uuhsBgiD64z4/VwiX/YtynzTEdmAnk5Jf3pwN7K/rMRATdqWx6JbJKh
	 9VIofC4ZZZobR78EQqVZBpmzwAwxypb87QSJBHQs=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4dGk8K1dpZz2Kw;
	Wed, 26 Nov 2025 16:32:33 +0100 (CET)
Date: Wed, 26 Nov 2025 16:32:32 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jann Horn <jannh@google.com>, John Johansen <john.johansen@canonical.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>, 
	Christian Brauner <brauner@kernel.org>, Daniel Burgener <dburgener@linux.microsoft.com>, 
	Jeff Xu <jeffxu@google.com>, NeilBrown <neil@brown.name>, Paul Moore <paul@paul-moore.com>, 
	Ryan Sullivan <rysulliv@redhat.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Abhinav Saxena <xandfury@gmail.com>
Subject: Re: [PATCH v3 2/4] landlock: Fix handling of disconnected directories
Message-ID: <20251125.woxo4hooGaid@digikod.net>
References: <20250719104204.545188-1-mic@digikod.net>
 <20250719104204.545188-3-mic@digikod.net>
 <18425339-1f4b-4d98-8400-1decef26eda7@maowtm.org>
 <20250723.vouso1Kievao@digikod.net>
 <b0f46246-f2c5-42ca-93ce-0d629702a987@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0f46246-f2c5-42ca-93ce-0d629702a987@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Jul 28, 2025 at 01:13:10AM +0100, Tingmao Wang wrote:
> On 7/23/25 22:01, Mickaël Salaün wrote:
> > On Tue, Jul 22, 2025 at 07:04:02PM +0100, Tingmao Wang wrote:
> >> On 7/19/25 11:42, Mickaël Salaün wrote:
> >>> [...]
> >>> @@ -784,12 +787,18 @@ static bool is_access_to_paths_allowed(
> >>>  	if (WARN_ON_ONCE(!layer_masks_parent1))
> >>>  		return false;
> >>>  
> >>> -	allowed_parent1 = is_layer_masks_allowed(layer_masks_parent1);
> >>> -
> >>>  	if (unlikely(layer_masks_parent2)) {
> >>>  		if (WARN_ON_ONCE(!dentry_child1))
> >>>  			return false;
> >>>  
> >>> +		/*
> >>> +		 * Creates a backup of the initial layer masks to be able to restore
> >>> +		 * them if we find out that we were walking a disconnected directory,
> >>> +		 * which would make the collected access rights inconsistent (cf.
> >>> +		 * reset_to_mount_root).
> >>> +		 */
> >>
> >> This comment is duplicate with the one below, is this intentional?
> >>
> >>> [...]
> >>
> >> On the other hand, I'm still a bit uncertain about the domain check
> >> semantics.  While it would not cause a rename to be allowed if it is
> >> otherwise not allowed by any rules on or above the mountpoint, this gets a
> >> bit weird if we have a situation where renames are allowed on the
> >> mountpoint or everywhere, but not read/writes, however read/writes are
> >> allowed directly on a file, but the dir containing that file gets
> >> disconnected so the sandboxed application can't read or write to it.
> >> (Maybe someone would set up such a policy where renames are allowed,
> >> expecting Landlock to always prevent renames where additional permissions
> >> would be exposed?)
> >>
> >> In the above situation, if the file is then moved to a connected
> >> directory, it will become readable/writable again.
> > 
> > We can generalize this issue to not only the end file but any component
> > of the path: disconnected directories.  In fact, the main issue is the
> > potential inconsistency of access checks over time (e.g. between two
> > renames).  This could be exploited to bypass the security checks done
> > for FS_REFER.
> 
> Hi Mickaël,
> 
> (replying to this one even though I've read the further replies, since I
> don't have anything to address there)
> 
> I spent some time thinking about how this could be exploited and I can see
> one concrete situation where disconnected directories can be taken
> advantaged of, which is when an application has rename access across the
> "source" of a bind mount, as well as some place outside of it, but only
> has read/write access on certain subdirs of it, in which case it can use
> this to move files under the bind mount that it does not have access to,
> to a place where it has, by first making the target destination
> disconnected, then connecting it back:
> 
> 	/ # mkdir bind_src bind_dst outside
> 	/ # mount --bind bind_src bind_dst
> 	/ # mkdir -p bind_src/d1
> 	/ # echo secret > /bind_src/foo
> 	/ # LL_FS_RO=/usr:/bin:/lib:/etc LL_FS_RW=/bind_src/d1:/outside LL_FS_CREATE_DELETE_REFER=/ /sandboxer bash
> 		## (sandboxer patched with ability to add just create/delete/refer
> 		    rule on a path - maybe we can add this to the sandboxer but
> 		    call it something like LL_FS_DIR_RW?)
> 	Executing the sandboxed command...
> 	/ # cat /bind_src/foo /bind_dst/foo
> 	cat: /bind_src/foo: Permission denied
> 	cat: /bind_dst/foo: Permission denied
> 	/ # cd /bind_dst/d1
> 	/bind_dst/d1 # mv -v /bind_src/d1 /outside
> 	renamed '/bind_src/d1' -> '/outside/d1'
> 	/bind_dst/d1 # ls ..
> 	ls: cannot access '..': No such file or directory
> 	/bind_dst/d1 # mv -v /bind_dst/foo .
> 	renamed '/bind_dst/foo' -> './foo'
> 	/bind_dst/d1 # mv -v /outside/d1 /bind_src/d1
> 	renamed '/outside/d1' -> '/bind_src/d1'
> 	/bind_dst/d1 # cat foo
> 	secret

Good catch! This is definitely an issue.

> 
> (I think this is probably not an issue with the existing Landlock code, as
> the application would need to have rules outside the bind mount in order
> for Landlock to not see it when the directory is disconnected, but in that
> case it already has access to the target file anyway due to hierarchy
> inheritance)
> 
> The other way I can think of where this inconsistency could be taken
> advantaged of is for regaining access to a file within a disconnected
> directory that the application originally had access to (basically the
> situation I wrote about earlier), but that is arguably a less worrisome
> case and your option 1 would make access in this case allowed anyway.  So
> far I can't think of any other way an application could use this to gain
> access it didn't have on the file before.
> 
> > 
> > I see two solutions:
> > 
> > 1. *Always* walk down to the IS_ROOT directory, and then jump to the
> >    mount point.  This makes it possible to have consistent access checks
> >    for renames and open/use.  The first downside is that that would
> >    change the current behavior for bind mounts that could get more
> >    access rights (if the policy explicitly sets rights for the hidden
> >    directories).  The second downside is that we'll do more walk.
> > 
> > 2. Return -EACCES (or -ENOENT) for actions involving disconnected
> >    directories, or renames of disconnected opened files.  This second
> >    solution is simpler and safer but completely disables the use of
> >    disconnected directories and the rename of disconnected files for
> >    sandboxed processes.
> 
> I think -ENOENT might be confusing if the disconnection is accidentally
> triggered (e.g. due to a bug, race etc) (I guess given that ".." doesn't
> work in disconnected dirs, nobody should be setting them up deliberately,
> so maybe any situation where a disconnected directory exists is always a
> bug, or at least a temporary race?), but on the other hand VFS already
> returns -ENOENT for ".." when in disconnected directories so maybe it's
> OK, as long as this is clarified in the doc, I guess.
> 
> Also by "rename" I assume we're implicitly including links as well (and
> since one couldn't rename an opened file just from the fd anyway, any
> rename would be for files underneath).
> 
> > 
> > It would be much better to be able to handle opened directories as
> > (object) capabilities, but that is not currently possible because of the
> > way paths are handled by the VFS and LSM hooks.
> > 
> > Tingmao, Günther, Jann, what do you think?
> 
> I wonder if there is a third option where we do option 1, but only for
> disconnected dirs, so basically for any disconnected directories Landlock
> would allow rules either on the path from the target to its fs root, or on
> the path from its mountpoint to the real root.  In addition, domain check
> for rename/links would be stricter, in that it would make sure there are
> no rules granting more access on the destination than the source even if
> those rules are "hidden" beneath the mountpoint, so that even if the
> destination later become disconnected access is not widened.
> 
> While this does leaves inconsistency since now some "hidden" rules would
> be applied only in the disconnected case, maybe this could still be a
> better option since it prevents accidentally widening access checks in the
> common case, especially for existing code (after all, currently Landlock
> does not apply those "hidden" rules, and if an application can't move the
> files into a disconnected directory, for example because write access are
> not granted to any bind mounted places, or because it only has access to
> the mount destination but not the source (achievable by putting the rule
> above the mountpoint, and in that case it can't move a dir outside the
> mount so it will always be connected), it will not be able to surface
> them).
> 
> One could argue that a reasonable policy is not supposed to have rules on
> those "hidden" directories in the first place, but in that case whether or
> not we do this extra walk to fs root for the non-disconnected case makes
> no difference.
> 
> The advantage of this option is also that we don't increase the
> performance overhead for the non-disconnected case which is the vast
> majority of cases (and this perf benefit might be significant since we're
> likely not backporting any ref-less pathwalk).  Also, while I'm not sure
> whether this option or option 1 has any difference in terms of backporting
> difficulty, I think option 1 is a more significant change compared to
> this, and maybe in the future if we do get to have opened directory
> capabilities, keeping the changes introduced by the current "workaround"
> small would be better?  This would probably also make it easier to adopt
> Song's path iterator too.
> 
> If we do this, then we would probably have a warning in e.g.
> Documentation/userspace-api/landlock.rst about the fact that Landlock will
> do this walk to the fs root if the directory is disconnected (either
> caused by the sandboxed application or by other means).

Thinking more about this, I think this third option is the best
approach.  In theory, for a direct access (i.e. not a rename/link), it
may grant more access on disconnected directories because the collected
access rights are the union of N hierarchies, but each of these
hierarchies are defined by the security policy which explicitly allows
such access.  This means that in practice these access rights should
already be granted when independently accessing the target file N times
through these N hierarchies.  This approach also improves guarantees
about not widening access rights with rename/link, and it only impacts
access to disconnected directories.  This will also simplify backports
and reduce merge conflicts.

The main downside is about the inconsistency with access to a connected
directory, but access to disconnected directories is already
inconsistent anyway and the VFS cannot do much about this case.

I'll send a new version today.

> 
> Just thoughts and suggestions tho, my opinions aren't very strong, and I
> probably don't have a good grasp of how Landlock is currently used in
> practice.
> 
> Best,
> Tingmao
> 
> > 
> > It looks like AppArmor also denies access to disconnected path in some
> > cases, but it tries to reconstruct the path for known internal
> > filesystems, and it seems to specifically handle the case of chroot.  I
> > don't know when PATH_CONNECT_PATH is set though.
> > 
> > John, could you please clarify how disconnected directories and files
> > are handled by AppArmor?
> > 
> >>
> >> Here is an example test, using the layout1_bind fixture for flexibility
> >> [...]
> 

