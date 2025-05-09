Return-Path: <linux-fsdevel+bounces-48546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E9AAB0D22
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144C23AA381
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 08:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D0272E74;
	Fri,  9 May 2025 08:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Eyvkqbgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464D78F44
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 08:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746779329; cv=none; b=fVzLCMRClF9bpl+jmkYAqa1+LC3t2DrNnp1vFkyKl2aBbE6gyED1ElMjS5PQmZZVU6QPrzSKfTyuS8uaiDm80ifuOXKeUBMiv4a0IqzdScYgf6xs41InxW22ZkgcCZKBNs9FOAdEKTvO7AAVN32VBPBTwKn6ZrnSJFcYyLoM3sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746779329; c=relaxed/simple;
	bh=E6k1zYvvllkWO8HC1sxnbogYdG+CiC1yWkmwYgAOxe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lH/+iXe8sIJOP3gSH0l1jTKhSoJCmG+v1qpKiv65kd+caS9igUUgClyMZsYh4ChaZ+qQoe/fxLVNWgXTRyNJnu1v2Jrod4N+BzTNiBDu1/C6/4qagv13A0hV2/2J6jNK/OYEAwXIvRUaQ1FTCfvbwCFslkroG5lSzjY6nqmhdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Eyvkqbgx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Od7YTwK6MKoMSro9cTzBRQkFZp5PQCYxYAcxl+U3a8=; b=EyvkqbgxpBDhKt4CznerUG252o
	IJJrV4yGnxdD91ePM0b7ANERQEE4wDI473wOziCJmpNz/rTkUeNnGnIOAWgAZ/IQfQLa6cDk6d0f9
	aI59uKrjz6jXNhPm7NQp5SbLKAS/yODktCO7fnDbYp8WdgkmiYaLEoZSjWpzDel7H2LPZa3AL/DNm
	m93/TMV8RlRM0TihmQUy7wSxKscK5fZt+WDo6j/YuQG7Rpk1qXXjuHU6nvkheraS0a/N4QmQno2i7
	mWOSkic0L8yOU3en2/bAT9k/lXPfzAIArWUv9VfC4AKMuS8lzoELrJ7vRtWbP2GdFwBpN0cSQ0D9O
	6trrPREA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDJ65-0000000Ay5I-498E;
	Fri, 09 May 2025 08:28:46 +0000
Date: Fri, 9 May 2025 09:28:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [BUG] propagation graph breakage by MOVE_MOUNT_SET_GROUP
 move_mount(2)
Message-ID: <20250509082845.GV2023217@ZenIV>
References: <20250509082628.GU2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509082628.GU2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 09, 2025 at 09:26:28AM +0100, Al Viro wrote:
> AFAICS, 9ffb14ef61ba "move_mount: allow to add a mount into an existing
> group" breaks assertions on ->mnt_share/->mnt_slave.  For once, the data
> structures in question are actually documented.
> 
> Documentation/filesystem/sharedsubtree.rst:
>         All vfsmounts in a peer group have the same ->mnt_master.  If it is
> 	non-NULL, they form a contiguous (ordered) segment of slave list.
> 
> fs/pnode.c:
>  * Note that peer groups form contiguous segments of slave lists.
> 
> fs/namespace.c:do_set_group():
>         if (IS_MNT_SLAVE(from)) {
>                 struct mount *m = from->mnt_master;
> 
>                 list_add(&to->mnt_slave, &m->mnt_slave_list);
>                 to->mnt_master = m;
>         }
> 
>         if (IS_MNT_SHARED(from)) {
>                 to->mnt_group_id = from->mnt_group_id;
>                 list_add(&to->mnt_share, &from->mnt_share);
>                 lock_mount_hash();
>                 set_mnt_shared(to);
>                 unlock_mount_hash();
>         }
> 
> Note that 'to' goes right after 'from' in ->mnt_share (i.e. peer group
> list) and into the beginning of the slave list 'from' belongs to.  IOW,
> contiguity gets broken if 'from' is both IS_MNT_SLAVE and IS_MNT_SHARED.
> Which is what happens when the peer group 'from' is in gets propagation
> from somewhere.
> 
> It's not hard to fix - something like
> 
>         if (IS_MNT_SHARED(from)) {
> 		to->mnt_group_id = from->mnt_group_id;
>                 list_add(&to->mnt_share, &from->mnt_share);
> 		if (IS_MNT_SLAVE(from))
> 			list_add(&to->mnt_slave, &from->mnt_slave);
> 		to->mnt_master = from->mnt_master;
>                 lock_mount_hash();
>                 set_mnt_shared(to);
>                 unlock_mount_hash();
>         } else if (IS_MNT_SLAVE(from)) {
> 		to->mnt_master = from->mnt_master;
> 		list_add(&to->mnt_slave, &from->mnt_master->mnt_slave_list);
> 	}
> 
> ought to do it.  I'm nowhere near sufficiently awake right now to put
> together a regression test, but unless I'm missing something subtle, it
> should be possible to get a fairly obvious breakage of propagate_mnt()
> out of that...

Not sufficiently awake is right - wrong address on Cc...  Anyway, bedtime
for me...

