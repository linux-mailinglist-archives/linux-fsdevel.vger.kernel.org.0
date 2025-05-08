Return-Path: <linux-fsdevel+bounces-48446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D55AAAF334
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DF0177FB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 05:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2A215F49;
	Thu,  8 May 2025 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uUPgwH5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3645F134A8
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746683774; cv=none; b=nMXSl6iT8Z5lxFWaC5OvtGR991ZpMHrgvS0OvXsZy4JaiTSmIuChvit/Y+gOPBXPIxickoRfTuAUrS5qB+oeWqAXY1LJ/3uCA/kiAN2U2w2EZfLoDolprdYRhWIhiVtlgAJRxP/9l8ziwk31kVe74hBC9b6cSzvcWPCqW07djc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746683774; c=relaxed/simple;
	bh=7QTEb5Y84u9dsLF9/EhopGDY1WIYDhEYoTSg0tJY8zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYPgOUEDKFPvwqw5o6EmJZHQcBYBvUU7O2T5YGFTS3jOGf54gMsseoOFXyjBZEK3wyl624IGYbIQYVYrJyWy1dFje4skg46dPoc2Nht6z5Nxq8PpvXeGgRuF8L4mlOyRyyc3wJACC16M+JDEeRKzi9FXLNxlgLvVjUH/yQE5/yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uUPgwH5S; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5tBzNmyRL0MhDAjQfsB+x4fkGYmbyAoymagYvHtCgh0=; b=uUPgwH5SzC6e2rAQ7O3rb9TOH5
	PF6ErJyMKaCUDmAEwYQYGm7oKcDqwIImJZwxJ+fjN7TpVSUWQ7QKABIUO+warS3h7DF/E/V6PwSZT
	yUTI0+nmtmZbVWSmZcSZ9ef+bckmk5QyAgBMMRGKp1p9rZF7ye6qov7R/3ixYRey16lkER3YXYPvD
	klLEq9HumzanCopZcR3PKlgl37If1lL/FslEOF9WG3hjBnl0ezgaqX85RlZTZxKdkCfYvmqafG5Ib
	JagLUAIYC4OHiJI3C7V3NqXCa7L/ubFOgHJRPxllTuYEeqlG1bFt81kFI6FGAKezyM56dPdh76FPM
	tsNcynMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCuEs-000000043vZ-0LoY;
	Thu, 08 May 2025 05:56:10 +0000
Date: Thu, 8 May 2025 06:56:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: more breakage there (was Re: [RFC] move_mount(2): still breakage
 around new mount detection)
Message-ID: <20250508055610.GB2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428185318.GN2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 28, 2025 at 07:53:18PM +0100, Al Viro wrote:

> Up to you; propagation calculations *are* hard-serialized (on namespace_sem)
> and changing that is too much pain to consider, so I have no problem with
> globals in that specific case (note several such in propagate_mnt()
> machinery; that was a deliberate decision to avoid shitloads of arguments
> that would have to be passed around otherwise), but...

OK, now I finally understand what felt fishy about either solution.

Back when the checks had been IS_MNT_NEW, we were guaranteed that
anything on the the slave lists of new mount would be new as well.

No amount of copy_tree() could change ->mnt_master of existing mounts,
so anything predating the beginning of propagate_mnt() would still
have ->mnt_master pointing to old mounts - no operations other than
copy_tree() had been done since we have taken namespace_sem.

That's where your IS_MNT_PROPAGATED breaks.  It mixes "nothing useful
to be found in this direction" with "don't mount anything on this one".
And these are not the same now.

Suppose you have mounts A, B and C, A propagating to B, B - to C.

If you made B private, propagation would go directly from A to C,
and mount on A/foo would result in a copy on C/foo.

Suppose you've done open_tree B with OPEN_TREE_CLONE before making
B private.  After open_tree your propagation graph is
	A -> [B <-> B'] -> C
with new mount B' being in your anon_ns.  Making B private leaves you
with
	A -> B' -> C
and mount on A/foo still propagates to C/foo, along with foo in your
anon_ns.

So far, so good, but what happens if you move_mount the root of your
anon_ns to A/foo?  Sure, you want to suppress copying it to foo in B',
but you will end suppressing the copy on C/foo as well.  propagation_next()
will not visit C at all - when it reaches B', it'll see IS_MNT_PROPAGATED
and refuse to look what B' might be propagating to.

IOW, IS_MNT_PROPAGATED in propagate_one() is fine, but in propagation_next(),
skip_propagation_subtree() and next_group() we really need IS_MNT_NEW.
And the check in propagate_one() should be

	/* skip ones added by this propagate_mnt() */
	if (IS_MNT_NEW(m))
                return 0;
        /* skip if mountpoint is outside of subtree seen in m */
	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
		return 0;
	/* skip if m is in the anon_ns we are emptying */
	if (m->mnt_ns->mntns_flags & MNTNS_PROPAGATING)
		return 0;
That part of check is really about the validity of this particular
location, not the cutoff for further propagation.  IS_MNT_NEW(),
OTOH, is a hard cutoff.

FWIW, I would take the last remaining IS_MNT_PROPAGATED() (in
propagation_would_overmount()) as discussed in this thread -
with
-       if (propagation_would_overmount(parent_mnt_to, mnt_from, mp))
+       if (check_mnt(mnt_from) &&
+           propagation_would_overmount(parent_mnt_to, mnt_from, mp))
in can_move_mount_beneath() and lose the one in propagation_would_overmount()

I'll cook something along those lines (on top of "do_move_mount(): don't
leak MNTNS_PROPAGATING on failures") and if it survives overnight tests
post it tomorrow^Win the morning...

