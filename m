Return-Path: <linux-fsdevel+bounces-52506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD51AE397D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03933A7154
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E96233149;
	Mon, 23 Jun 2025 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="bRi21mMs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDch6ECM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E9231846
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669622; cv=none; b=s6D0kNay3mvJ6kFAe/cjrkc3oA6Oo3DRcHmtU2fuxlVqWi4jNIT0A1cUE7mKUWEH3d1sJ29zU+RvEQ68t4sp3ApQdMI+BERLFgILf7m9mwYIbPDrvnU+YeRkmKqGMmO90iDFCx1J4Jc+arDH67oc4mUExXQVaVyDLOBi/DD8v9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669622; c=relaxed/simple;
	bh=sK2O/FJFWa9wv7aTJ0i2nr3XZwRqwgTyeUBdXLz9HaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GRCe4NejQfyzk8eMXOqe+nC9CgdKPbk3IUxFBaoFTrClvQgi/we5p0+HIcEKNpx6kjz4N5ZFN8xM1c+yoBaTMrp46531qULvU9Jf+hq/4Dy7GMEBmUfU3VKIy150sDKnuzexKJVaJabsbeiBokuQml5I+FwiPznNM8lNu2anQGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=bRi21mMs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDch6ECM; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C06062540138;
	Mon, 23 Jun 2025 05:06:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 23 Jun 2025 05:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750669618;
	 x=1750756018; bh=Xf9MzHwHAGIM/akzCpNXSJ7Z1vgOCpYo8REnBOpFAwM=; b=
	bRi21mMsexYjLJ7wxW6l96W5AaW9+/0XpkAA5x+6fd38R5S92a/zBgD0yyTQbld4
	nsGVIe9WJQvFHwK5zoBwGPxeY5vtCrQhK0yshwbxH2uU2Q4D5ymbgn80v+gV0t7O
	czxjvFj7yVSvknfPNSDNzaOb/vuROXGBFY85KEYqCg19DMO9LaxCai3vY1D4zWNU
	TmnIvOk6SN/h7CW12VOFoiQ/kXKOdpqJz4EuL/fpmYGhfcZYTNBd5bZJrX4fvNI8
	MgotxrTg6gGdtdA3MxG6kNweoS46nZw3Ph9ExDENLTVYLei8IDRvvd4RrAE6+Pqb
	Ej528HrLAR2NND7cYHdewg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750669618; x=
	1750756018; bh=Xf9MzHwHAGIM/akzCpNXSJ7Z1vgOCpYo8REnBOpFAwM=; b=X
	Dch6ECMlYgKxfijhm/pmf5UJFVa4hcEKPi7RgyzadI68l3SM2LRSteC/WTVsH+sG
	+9rFibh4gt8D0dNHManX6joGmP/Y8wguH1bet85nqEV2DNRSNn7TFxeaIBDsbWPv
	rsoLJNOKClpU4Kfbuvvyfsi3DntBawLsJNujzsjjBkImp7yz1qbNPPtUxxQ4ie45
	L21jh5GQilF1L62eW8GhyIG/T+kfXcYE+yBz9qMKQKRjS0t3t+w3aBXdhr3KdTsz
	p4hAdAUTEwPD7VLU36VdhdXu4hYH9lUo4ncgRJFhui98WrA0lem4A6DlogSSMuKy
	CF2v9WLEQhuPUg2qZ1cUA==
X-ME-Sender: <xms:MhlZaJLzhhLXS94mJuG7CYvrQjyojKXHyqdH0-z3-u0AKTS5_E1tmw>
    <xme:MhlZaFL92JDrP5Dquu_nbU1t5_bSR60x2cHupY5QJYxsB76zVJVEVlo7_ojX-5yAe
    jMeAIdwdIlP>
X-ME-Received: <xmr:MhlZaBvg8zr8gPubu7eiH3kihwkya_0J3qclh7obE1R88PlkG__mnnLjS1RTkro0NJMEo9BFC2xMTnAXhqmjgY5-LpxGk2VHD5ZOU9HUA6o7ldtLLKGUSF_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduieeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpeeigf
    fgveffvdejtdetuddtfeehhefgjeeiudeuffevleeufeefueffudffvdekveenucffohhm
    rghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvghtpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhrohesiigvnhhivh
    drlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopeht
    ohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    epvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomh
X-ME-Proxy: <xmx:MhlZaKYZ9nwEGiFTjEhFh3mxQPjJqGDIKl5OKTXMA18st-ibiDM1ig>
    <xmx:MhlZaAbUHyVjzt7xnBBksj6VXastk9UQ4KMNvIXdlf3tk--4LpgYiQ>
    <xmx:MhlZaOBGeZGBs0_CbgC7J-76I8FfcxoeAZNTjPd2PKTfT22vX5hehg>
    <xmx:MhlZaOb-be-_hP09UC3rafUh9KZyX0N7rZt601wphkMngTPWiPJlxg>
    <xmx:MhlZaPbEcVA4n083a9rIEe-R2vcPS2b3yFuEqjJHGju42obtMFbuy8cd>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 05:06:55 -0400 (EDT)
Message-ID: <93a5388a-3063-4aa2-8e77-6691c80d9974@themaw.net>
Date: Mon, 23 Jun 2025 17:06:52 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHES v2][RFC][CFR] mount-related stuff
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Biederman <ebiederm@xmission.com>
References: <20250610081758.GE299672@ZenIV> <20250623044912.GA1248894@ZenIV>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20250623044912.GA1248894@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/6/25 12:49, Al Viro wrote:
> On Tue, Jun 10, 2025 at 09:17:58AM +0100, Al Viro wrote:
>> 	The next pile of mount massage; it will grow - there will be
>> further modifications, as well as fixes and documentation, but this is
>> the subset I've got in more or less settled form right now.
>>
>> 	Review and testing would be very welcome.
>>
>> 	This series (-rc1-based) sits in
>> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
>> individual patches in followups.
> Updated variant force-pushed to
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> individual patches in followups.  It seems to survive testing here, but
> more testing and review would be very welcome.  That's still not all -
> there's more stuff in local queue, but it needs more massage; this is
> the reasonably settled-down subset at the moment.

I'll have a look through these too and run my tests against them.

Btw, I did run my tests against v1 without any noticeable problem.


I also have revived my patch to make may_umount_tree() namespace aware

and it still seems to work fine. I'm not going to spend time on my second

patch that was meant to add some optimization because it seemed too

aggressive somehow and stopped working a while after it was done and I

couldn't see why. So for now I've dropped it.


Ian

>
> Changes since v1:
> Added fixes (-stable fodder, IMO):
> 	replace collect_mounts()/drop_collected_mounts() with safer variant
> 	attach_recursive_mnt(): do not lock the covering tree when sliding something under it
>
> Another thing that is probably a -stable candidate:
> 	prevent mount hash conflicts
> That's an old headache hopefully taken care of; what we get out of it
> is the warranty that there won't be more than one hashed mount with
> given parent/mountpoint at any given time.  I've pulled that very
> early in the sequence, so that we had a chance to backport it.
> That comes with two prereqs (reordered from the middle of v1 series),
> both should be trivial to backport.
>
> Added cleanups:
> 	__attach_mnt(): lose the second argument
> 	copy_tree(): don't link the mounts via mnt_list
> All uses of ->mnt_list are transient now - basically, various sets
> used during umount_tree().
> 	mount: separate the flags accessed only under namespace_sem
> Makes for simpler locking; some of the flags are accessed only under
> namespace_sem, and we already rely upon that in the readers; taking
> them to a separate word avoids the need to grab mount_lock on the
> write side.
> 	propagate_one(): get rid of dest_master
> 	propagate_mnt(): get rid of globals
> Linus asked to get rid of fs/pnode.c globals; done.
> 	take freeing of emptied mnt_namespace to namespace_unlock()
>
> A couple of commits made simpler by "prevent mount hash conflicts" -
> 	Rewrite of propagate_umount()
> reparenting is guaranteed that there won't be more than one overmount now,
> no loop needed.
> 	don't have mounts pin their parents
> simpler logics for "is there something other than overmount?"
>
> 	Rough overview:
>
> Part 1: fixes
>
> 1) replace collect_mounts()/drop_collected_mounts() with safer variant
> 2) attach_recursive_mnt(): do not lock the covering tree when sliding something under it
>
> Part 2: getting rid of mount hash conflicts for good
>
> 3) attach_mnt(): expand in attach_recursive_mnt(), then lose the flag argument
> 4) get rid of mnt_set_mountpoint_beneath()
> 5) prevent mount hash conflicts
>
> Part 3: trivial cleanups and helpers:
>
> 6) copy_tree(): don't set ->mnt_mountpoint on the root of copy
> 7) constify mnt_has_parent()
> 8) pnode: lift peers() into pnode.h
> 9) new predicate: mount_is_ancestor()
> 10) constify is_local_mountpoint()
> 11) new predicate: anon_ns_root(mount)
> 12) dissolve_on_fput(): use anon_ns_root()
> 13) __attach_mnt(): lose the second argument
> 	... and rename to make_visible()
> 14) don't set MNT_LOCKED on parentless mounts
> 15) clone_mnt(): simplify the propagation-related logics
> 16) do_umount(): simplify the "is it still mounted" checks
>
> Part 4: (somewhat of a side story) restore the machinery for long-term
> mounts from accumulated bitrot.
>
> 17) sanitize handling of long-term internal mounts
>
> Part 5: propagate_umount() rewrite (posted last cycle)
>
> 18) Rewrite of propagate_umount()
>
> Part 6: untangling do_move_mount()/attach_recursive_mnt().
>
> 19) make commit_tree() usable in same-namespace move case
> 20) attach_recursive_mnt(): unify the mnt_change_mountpoint() logics
> 21) attach_recursive_mnt(): pass destination mount in all cases
> 22) attach_recursive_mnt(): get rid of flags entirely
> 23) do_move_mount(): take dropping the old mountpoint into attach_recursive_mnt()
> 24) do_move_mount(): get rid of 'attached' flag
>
> Part 7: change locking for expiry lists.
> 25) attach_recursive_mnt(): remove from expiry list on move
> 26) take ->mnt_expire handling under mount_lock [read_seqlock_excl]
>
> Part 8: struct mountpoint massage.
> 27) pivot_root(): reorder tree surgeries, collapse unhash_mnt() and put_mountpoint()
> 28) combine __put_mountpoint() with unhash_mnt()
> 29) get rid of mountpoint->m_count
>
> Part 9: regularize mount refcounting a bit
> 30) don't have mounts pin their parents
>
> Part 10: misc stuff, will grow...
> 31) copy_tree(): don't link the mounts via mnt_list
> 32) mount: separate the flags accessed only under namespace_sem
> 33) propagate_one(): get rid of dest_master
> 34) propagate_mnt(): get rid of globals
> 35) take freeing of emptied mnt_namespace to namespace_unlock()
>
> Diffstat:
>   Documentation/filesystems/porting.rst          |   9 +
>   Documentation/filesystems/propagate_umount.txt | 484 +++++++++++++++
>   drivers/gpu/drm/i915/gem/i915_gemfs.c          |  21 +-
>   drivers/gpu/drm/v3d/v3d_gemfs.c                |  21 +-
>   fs/hugetlbfs/inode.c                           |   2 +-
>   fs/mount.h                                     |  36 +-
>   fs/namespace.c                                 | 783 +++++++++++--------------
>   fs/pnode.c                                     | 499 ++++++++--------
>   fs/pnode.h                                     |  28 +-
>   include/linux/mount.h                          |  24 +-
>   ipc/mqueue.c                                   |   2 +-
>   kernel/audit_tree.c                            |  63 +-
>   12 files changed, 1214 insertions(+), 758 deletions(-)
>   create mode 100644 Documentation/filesystems/propagate_umount.txt
>

