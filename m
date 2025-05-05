Return-Path: <linux-fsdevel+bounces-48123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD1AA9C67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 21:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B6817E4F6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899926FD81;
	Mon,  5 May 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qEmdSgcF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E971C2335;
	Mon,  5 May 2025 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472877; cv=none; b=mgLhXTV9WYBL+JhAYZ2wuy/Ue/4Hhxz0z3qpA1PSOBYm6ZKNKp6K7lw2Fk/9pQ7j4mPaPf+t1xtuHgMYyc9bWat+KEBnPZiKpqSkiVqj9A2v99b0aMLJ1Gs7Yxwa5CqTV3SlwRJehRwoMTenGA6v8KMMjTcPp9SKjpQb4y8wgKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472877; c=relaxed/simple;
	bh=2o6qr+fHmN9pgquP02b3XCjNjRGm3F4nTOBm4Di+yKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1uXuP1qHZsgBpd3BrEwEjvqqRTYxBnYMnCUHjoRclAn21HwafQy3bYawlkC9FQqSir5aWwbR5qpSKb3ktap/7ZJ1gMO5NqX82xkZummbq3WALD64QSliZ9EEX3+Gx4VemejMnKORrwTdgGYkB2396juTqHBt9MoHpW3+gzsVR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qEmdSgcF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ton5nVJpxImyrBYmbgbsO+2sxMUNoZgaaOLlpnALkyE=; b=qEmdSgcFacq3fu3BlbtZjd4bQ3
	5giu5JVNTXasxn9tiXreLTOaGtq5QR1rq33By2Bx75K2zYEAl+pEfaKVkSablVa7zk8wGU9RgoDIQ
	sYks1Yyf7XbQbU+rFIh42CepvtGRknOK/88As+BL33b55iCbOcQrk77YvhVTT6zTBbUdcWwSYbZx3
	zR6ctchFIhZrvKUbZtFMuyeTOXVHMnC9jk+2HAnnUxGHPxxoPwUxHqNYZhAaciC7xCGfpZJLdfx15
	1uVx4+JbuFsmC4gA+R+XmY2fgifIEJ9w9njlvnMcyVdMoCYq55hr6YsU/fe6gFZ73E7eIOIO4Ae5C
	vg4Cdc3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC1NH-000000065nk-0Vt7;
	Mon, 05 May 2025 19:21:11 +0000
Date: Mon, 5 May 2025 20:21:11 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Sterba <dsterba@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [RFC][PATCH] btrfs_get_tree_subvol(): switch from fc_mount() to
 vfs_create_mount()
Message-ID: <20250505192111.GH2023217@ZenIV>
References: <20250505030345.GD2023217@ZenIV>
 <20250505175807.GB9140@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505175807.GB9140@twin.jikos.cz>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 05, 2025 at 07:58:07PM +0200, David Sterba wrote:

> > -	if (fc->sb_flags & SB_RDONLY)
> > -		return ret;
> > -
> > -	down_write(&mnt->mnt_sb->s_umount);
> > -	if (!(fc->sb_flags & SB_RDONLY) && (mnt->mnt_sb->s_flags & SB_RDONLY))
> > +	if (!(fc->sb_flags & SB_RDONLY) && (fc->root->d_sb->s_flags & SB_RDONLY))
> >  		ret = btrfs_reconfigure(fc);
> > -	up_write(&mnt->mnt_sb->s_umount);

> So this open codes fc_mount(), which is vfs_get_tree() + vfs_create_mount(),
> the only difference I see in the new code is that
> btrfs_reconfigure_for_mount() dropped the SB_RDONLY check.
> 
> Why the check is there is explained in the lengthy comment above
> btrfs_reconfigure_for_mount(), so it should stay. If it can be removed
> then it should be a separate patch from the cleanup.

What do you mean, dropped?  It's still right there - the current
variant checks it *twice*, once before grabbing ->s_umount, then
after it's been grabbed.  Checking it before down_write() makes sense
if we are called after ->s_umount had been dropped (by fc_mount()).
I'm not sure why you recheck it after down_write(), since it's not
going to change, but you do recheck it.  In this variant we don't need
to bother grabbing the rwsem, since that thing is called while ->s_umount
is still held...

I can turn that into
	if (fc->sb_flags & SB_RDONLY)
		return ret;
	if (fc->root->d_sb->s_flags & SB_RDONLY)
		ret = btrfs_reconfigure(fc);
	return ret;
but I don't see how it's better than the variant posted; up to you, of course...

