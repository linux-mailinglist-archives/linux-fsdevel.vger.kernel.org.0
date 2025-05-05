Return-Path: <linux-fsdevel+bounces-48085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D043AA94EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 15:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACDC1767B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C50258CC5;
	Mon,  5 May 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWA0TpLX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D561FDD
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453288; cv=none; b=M4jLqOpfJ+trrEl+hI3pPrv/XblU0VZ7+bj1GqMHJ726uXKIzcBir1gk6+220mVAbkDKZy3Qqsphb7iyGcH+0zf99Z5X/Ix73CNl+xk+4RqmqeblL780SeiLaVK4BwVT7tphcCaGf7DhuSIZ80pBDTmzJ+fYkXiF9Dx98KC9n9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453288; c=relaxed/simple;
	bh=Qn7uvVYHTJ5WRy7pDWCa629/TUC+NLm4cg1D59ru1cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEOR//GN/CDtPLG5mlFxP5wLEzzVrpmuZp/btkluU751qhL77Gr/zHup5ZVanhVjfvYS2jtJui0uyI1H1oAPhLAzTYUKbWkuXzS4MXGX9l9axLDzfUjJipf9vtmWiMWGk2UXjq4wNuCcHGLSoX+qLkU1Qp86G1zZDsUVuiw1YVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWA0TpLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42E1C4CEE4;
	Mon,  5 May 2025 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746453288;
	bh=Qn7uvVYHTJ5WRy7pDWCa629/TUC+NLm4cg1D59ru1cM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWA0TpLXbu8LVjoiFR/bU0cHUaQ2pxsUh0v78hM/+DjaMhtpjW7gCbamgyIpZwI+X
	 gx6MyzglidZ7xs4NY8ta8LtimzAwKUuI/Mok8fw2qLMVBsp8epumQ2pXBM3dabd9+l
	 GouGSkHGhBuRCBeqc7yQntCHNbgilwhmrQm9/bhKesc2YX58yPisE5QRdMepMVpUnk
	 zmIIKPh3mksFAKDUkU/ypLevhM47DvffRURztPopjcUkndUJO7ekeatm0cs8ukNh2L
	 cG7JJzEfCG9S5LPpJw4GQTDceKNogemmLSnlloMwCyNNf0NfhL4dhybEIyzuWEHE9I
	 I9sFX1MPG1Zag==
Date: Mon, 5 May 2025 15:54:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] MNT_LOCKED vs. finish_automount()
Message-ID: <20250505-ausfuhr-zuschauen-1dbf7b0ea9bd@brauner>
References: <20250501201506.GS2023217@ZenIV>
 <87plgq8igd.fsf@email.froward.int.ebiederm.org>
 <20250504232441.GC2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250504232441.GC2023217@ZenIV>

On Mon, May 05, 2025 at 12:24:41AM +0100, Al Viro wrote:
> On Fri, May 02, 2025 at 10:46:26PM -0500, Eric W. Biederman wrote:
> > Al Viro <viro@zeniv.linux.org.uk> writes:
> > 
> > > 	Back in 2011, when ->d_automount() had been introduced,
> > > we went with "stepping on NFS referral, etc., has the submount
> > > inherit the flags of parent one" (with the obvious exceptions
> > > for internal-only flags).  Back then MNT_LOCKED didn't exist.
> > >
> > > 	Two years later, when MNT_LOCKED had been added, an explicit
> > > "don't set MNT_LOCKED on expirable mounts when propagating across
> > > the userns boundary; their underlying mountpoints can be exposed
> > > whenever the original expires anyway".  Same went for root of
> > > subtree attached by explicit mount --[r]bind - the mountpoint
> > > had been exposed before the call, after all and for roots of
> > > any propagation copies created by such (same reason).  Normal mount
> > > (created by do_new_mount()) could never get MNT_LOCKED to start with.
> > >
> > > 	However, mounts created by finish_automount() bloody well
> > > could - if the parent mount had MNT_LOCKED on it, submounts would
> > > inherited it.  Even if they had been expirable.  Moreover, all their
> > > propagation copies would have MNT_LOCKED stripped out.
> > >
> > > 	IMO this inconsistency is a bug; MNT_LOCKED should not
> > > be inherited in finish_automount().
> > >
> > > 	Eric, is there something subtle I'm missing here?
> > 
> > I don't think you are missing anything.  This looks like a pretty clear
> > cut case of simply not realizing finish_automount was special in a way
> > that could result in MNT_LOCKED getting set.
> > 
> > I skimmed through the code just a minute ago and my reading of it
> > matches your reading of it above.
> > 
> > The intended semantics of MNT_LOCKED are to not let an unprivileged user
> > see under mounts they would never be able to see under without creating
> > a mount namespace.
> > 
> > The mount point of an automount is pretty clearly something that is safe
> > to see under.  Doubly so if this is a directory that will always be
> > empty on a pseudo filesystem (aka autofs).
> 
> Does anybody have objections to the following?
> 
> [PATCH] finish_automount(): don't leak MNT_LOCKED from parent to child
> 
> Intention for MNT_LOCKED had always been to protect the internal
> mountpoints within a subtree that got copied across the userns boundary,
> not the mountpoint that tree got attached to - after all, it _was_
> exposed before the copying.
> 
> For roots of secondary copies that is enforced in attach_recursive_mnt() -
> MNT_LOCKED is explicitly stripped for those.  For the root of primary
> copy we are almost always guaranteed that MNT_LOCKED won't be there,
> so attach_recursive_mnt() doesn't bother.  Unfortunately, one call
> chain got overlooked - triggering e.g. NFS referral will have the

/me rolls eyes. Why is it always NFS.

> submount inherit the public flags from parent; that's fine for such
> things as read-only, nosuid, etc., but not for MNT_LOCKED.
> 
> This is particularly pointless since the mount attached by finish_automount()
> is usually expirable, which makes any protection granted by MNT_LOCKED
> null and void; just wait for a while and that mount will go away on its own.
> 
> The minimal fix is to have do_add_mount() treat MNT_LOCKED the same
> way as other internal-only flags.  Longer term it would be cleaner to
> deal with that in attach_recursive_mnt(), but that takes a bit more
> massage, so let's go with the one-liner fix for now.
> 
> Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

> diff --git a/fs/namespace.c b/fs/namespace.c
> index 04a9bb9f31fa..352b4ccf1aaa 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3761,7 +3761,7 @@ static int do_add_mount(struct mount *newmnt, struct mountpoint *mp,
>  {
>  	struct mount *parent = real_mount(path->mnt);
>  
> -	mnt_flags &= ~MNT_INTERNAL_FLAGS;
> +	mnt_flags &= ~(MNT_INTERNAL_FLAGS | MNT_LOCKED);
>  
>  	if (unlikely(!check_mnt(parent))) {
>  		/* that's acceptable only for automounts done in private ns */

