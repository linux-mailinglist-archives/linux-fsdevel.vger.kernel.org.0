Return-Path: <linux-fsdevel+bounces-48581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E252AB1180
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB361C052F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 11:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FC928ECEE;
	Fri,  9 May 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huLkuQIC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2DB221555
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788789; cv=none; b=C6Ee5tBUqUcSPriTKt9ny5M3lZhS6GK7EmLZZYmNduytSlT79u3NuWmbG9/qT8b5NHHHDFrWaUOUIuNAUTrgcg3Va5TAcUlLIL/QQd9d9IdeUdFJ9oBg8OyVLwZGsENEVUtNH70CKYw77o6iI/tDss0ny2TN58rZsm1/uyj/hc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788789; c=relaxed/simple;
	bh=wMkgu9pTZS6226RvCZzhU17CtKoTip/jUt/hunqMQvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbghDO17cZg85e7uLrf5Ih2jczrDHEvGKV0ZJkSs8skGKLplqmq7OEbWSUFd1adqCGNobb8QPPOUTc+lXC91YQrtvrmeFl15/DgM80+7pFeRxB3f0ymHYEvqG03XA3Cxny1lBFXpVcKDEsqTbDO6dlJipftkmv54WN0zuiPSq8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huLkuQIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9FAC4CEEE;
	Fri,  9 May 2025 11:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746788788;
	bh=wMkgu9pTZS6226RvCZzhU17CtKoTip/jUt/hunqMQvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=huLkuQICXwuaEnwqOM8vxOE69n4+Czy1kLtdm5nSeUtUzF9QRw2moTXEgngjPfKbw
	 tmEtdOYly4H8G+4vdycnCWrIuQPT0SV/IWspUuDnuNVFzS+T7a3HzlDqt3b/S2dLiX
	 qPwoPVNjIiy5cRNAcjZbpX69TOqQJeig//1l+XrElN0ouYBt2uE57MatCncyo5DYEK
	 3kwdsgPTP7Q4Bag1mW9DY6zwecTHqOThsl3YPm/xpanDI6+JdiW66qtamafrEur/lf
	 N+KnjN3cc2x6ThVSiOaFGa6NRMo0riKRbPJH4NUGlcPJc0ScjDN4WtDnMlpEZGZwoN
	 vWcx4o7cmQheQ==
Date: Fri, 9 May 2025 13:06:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: more breakage there (was Re: [RFC] move_mount(2): still breakage
 around new mount detection)
Message-ID: <20250509-nimmst-magerquark-21b49ee0438d@brauner>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250508055610.GB2023217@ZenIV>

On Thu, May 08, 2025 at 06:56:10AM +0100, Al Viro wrote:
> On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:
> 
> > Up to you; propagation calculations *are* hard-serialized (on namespace_sem)
> > and changing that is too much pain to consider, so I have no problem with
> > globals in that specific case (note several such in propagate_mnt()
> > machinery; that was a deliberate decision to avoid shitloads of arguments
> > that would have to be passed around otherwise), but...
> 
> OK, now I finally understand what felt fishy about either solution.
> 
> Back when the checks had been IS_MNT_NEW, we were guaranteed that
> anything on the the slave lists of new mount would be new as well.
> 
> No amount of copy_tree() could change ->mnt_master of existing mounts,
> so anything predating the beginning of propagate_mnt() would still
> have ->mnt_master pointing to old mounts - no operations other than
> copy_tree() had been done since we have taken namespace_sem.

Yes.

> 
> That's where your IS_MNT_PROPAGATED breaks.  It mixes "nothing useful
> to be found in this direction" with "don't mount anything on this one".
> And these are not the same now.
> 
> Suppose you have mounts A, B and C, A propagating to B, B - to C.
> 
> If you made B private, propagation would go directly from A to C,
> and mount on A/foo would result in a copy on C/foo.
> 
> Suppose you've done open_tree B with OPEN_TREE_CLONE before making
> B private.  After open_tree your propagation graph is
> 	A -> [B <-> B'] -> C
> with new mount B' being in your anon_ns.  Making B private leaves you
> with

I cannot describe how much I hate mount propagation and how much I would
like to burn it from the face of this earth.

> 	A -> B' -> C
> and mount on A/foo still propagates to C/foo, along with foo in your
> anon_ns.
> 
> So far, so good, but what happens if you move_mount the root of your
> anon_ns to A/foo?  Sure, you want to suppress copying it to foo in B',
> but you will end suppressing the copy on C/foo as well.  propagation_next()
> will not visit C at all - when it reaches B', it'll see IS_MNT_PROPAGATED
> and refuse to look what B' might be propagating to.

I regret that I reenabled propagation into anonymous mount namepaces in
the first place.

> 
> IOW, IS_MNT_PROPAGATED in propagate_one() is fine, but in propagation_next(),
> skip_propagation_subtree() and next_group() we really need IS_MNT_NEW.
> And the check in propagate_one() should be
> 
> 	/* skip ones added by this propagate_mnt() */
> 	if (IS_MNT_NEW(m))
>                 return 0;
>         /* skip if mountpoint is outside of subtree seen in m */
> 	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
> 		return 0;
> 	/* skip if m is in the anon_ns we are emptying */
> 	if (m->mnt_ns->mntns_flags & MNTNS_PROPAGATING)
> 		return 0;
> That part of check is really about the validity of this particular
> location, not the cutoff for further propagation.  IS_MNT_NEW(),
> OTOH, is a hard cutoff.
> 
> FWIW, I would take the last remaining IS_MNT_PROPAGATED() (in
> propagation_would_overmount()) as discussed in this thread -
> with
> -       if (propagation_would_overmount(parent_mnt_to, mnt_from, mp))
> +       if (check_mnt(mnt_from) &&
> +           propagation_would_overmount(parent_mnt_to, mnt_from, mp))
> in can_move_mount_beneath() and lose the one in propagation_would_overmount()

Yes.

> 
> I'll cook something along those lines (on top of "do_move_mount(): don't
> leak MNTNS_PROPAGATING on failures") and if it survives overnight tests
> post it tomorrow^Win the morning...

Thanks!

