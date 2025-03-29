Return-Path: <linux-fsdevel+bounces-45254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C26A75524
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F985188FB5A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB443192B82;
	Sat, 29 Mar 2025 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiP0o3WH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5121E1B960;
	Sat, 29 Mar 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743236643; cv=none; b=XyvhkQfgGzVntNyH0eLZ58lbmztdCQ+7n6rGxMJQiQW34hvvapi4JPHLZOK2PgV3RfSGazuR6w8JYiIGdzlrYuSCPxPgWNZJ2i7oOK0dY3zXYuqA9ntcTEptVK/Wxvai0SXAZH72z3CAHtEoMO4yPl/ji5UEUywzjv83N5TGwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743236643; c=relaxed/simple;
	bh=6/F1xo1a6hz9D0lSpJzTOclIxwyWre8k8tXllZh2aMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehQRVHfBsEN0ioakFExa1vlN1ABRaZ0oDUGs62THcgYXv7UJD7PQKMizRsItl7rg67mXwRkMkJS/0kra/FQtTsOAf/qzHW1Xm53DNy6tSQAle+XkBHZg8NUD2Cv+Z+WovKWVHgF/HgPKQSKdBeS1Ca9ry1meJo5hRZsOma0vA9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiP0o3WH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FE5C4CEE2;
	Sat, 29 Mar 2025 08:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743236642;
	bh=6/F1xo1a6hz9D0lSpJzTOclIxwyWre8k8tXllZh2aMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiP0o3WHLbD6GTr3EAM6IrF9gAM6aLPa3OhSemYNs4hC07FimS+33ssZsVirDOUo8
	 IAqVmoSUx+JZq/hAmQfVDCgVTD5it5FlF+XC18fZf4yJNmpQiOkaybzqiOsrj0HBID
	 p2CfZJ4sKG/BufXhtYV5wTO1EzaLhnlaxZdSkUeihVe8D0/DzUFH9qImOZT+uemhgy
	 Ajz+0WhShLzNn55r2nYhNyWd2bwVt4EAddi1TB00zACaDlusVPrwFuk/LVDub1wKBf
	 kBZfst0iZQCdOahkIcNVDypELCTzJlLFaiMYGewhK5TegN/mFunpiYVJXB6dpZnsoE
	 7Vq1ixP65s/Hw==
Date: Sat, 29 Mar 2025 09:23:56 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mcgrof@kernel.org, jack@suse.cz, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [RFC PATCH 4/4] vfs: add filesystem freeze/thaw callbacks for
 power management
Message-ID: <20250329-nahebringen-abhandeln-c8198e8c58fc@brauner>
References: <20250327140613.25178-1-James.Bottomley@HansenPartnership.com>
 <20250327140613.25178-5-James.Bottomley@HansenPartnership.com>
 <20250328-luxus-zinspolitik-835cc75fbad5@brauner>
 <cd5c3d8aab9c5fb37fa018cb3302ecf7d2bdb140.camel@HansenPartnership.com>
 <20250328-ungnade-feldhasen-4a447a33068c@brauner>
 <018ff37dde2bacf47f5d5f6aacd7f560795385b3.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <018ff37dde2bacf47f5d5f6aacd7f560795385b3.camel@HansenPartnership.com>

On Fri, Mar 28, 2025 at 12:15:55PM -0400, James Bottomley wrote:
> On Fri, 2025-03-28 at 16:52 +0100, Christian Brauner wrote:
> [...]
> > 
> > > various operations from races.  Taken exclusively with down_write
> > > and shared with down_read. Private functions internal to super.c
> > > wrap this with grab_super and super_lock_shared/excl() wrappers.
> > 
> > See also the Documentation/filesystems/lock I added.
> 
> you mean locking.rst which covers s_umount?  It would be nice to add
> the others as well.
> 
> > > The explicit freeze/thaw_super() functions require the s_umount
> > > rwsem in down_write or exclusive mode and take it as the first step
> > > in their operation.  Looking at the locking in
> > > fs_bdev_freeze/thaw() implies that the super_operations
> > > freeze_super/thaw_super *don't* need this taken (presumably they
> > > handle it internally).
> > 
> > Block device locking cannot acquire the s_umount as that would cause
> > lock inversion with the block device open_mutex. The locking scheme
> > using sb_lock and the holder mutex allow safely acquiring the
> > superblock. It's orthogonal to what you're doing though.
> 
> OK, but based on the above and the fact that the code has to call
> either the super op freeze/thaw_super or the global call, I think this
> can be handled in the callback as something like rather than trying to
> thread an exclusive s_umount:

Eww, no. We're not going to open-code that in two different places.

> static void filesystems_thaw_callback(struct super_block *sb)
> {
> 	if (unlikely(!atomic_inc_not_zero(&sb->s_active)))
> 		return;
> 
> 	if (sb->s_op->thaw_super)
> 		sb->s_op->thaw_super(sb, FREEZE_MAY_NEST
> 				     | FREEZE_HOLDER_KERNEL
> 				     | freeze_flags);
> 	else if (sb->s_bdev)
> 		thaw_super(sb,	FREEZE_MAY_NEST | FREEZE_HOLDER_KERNEL
> 			   | freeze_flags);
> 
> 	deactivate_super(sb);
> }

This is broken. The freeze/thaw functions cannot be called with s_umount
held otherwise they deadlock. And not holding s_umount while taking an
active reference count isn't supported as we're optimistically dropping
reference counts. We're not introducing exceptions to that scheme for no
good reason.

The other option is to move everything into the caller and bring back
get_active_super() and then add SUPER_ITER_UNLOCKED instead of
SUPER_ITER_GRAB. That's what I've done now.

