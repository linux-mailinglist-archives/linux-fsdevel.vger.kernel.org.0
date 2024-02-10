Return-Path: <linux-fsdevel+bounces-11054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835D9850748
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Feb 2024 00:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B58D81C20E8C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 23:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B3360240;
	Sat, 10 Feb 2024 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vy54Gspn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4835FF07
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Feb 2024 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707607645; cv=none; b=psVWfDadoESLCnscVFD5zUe64Ud1pF0Swn5oIo2O4lmE7Q4V86KqwADg1DcX8sLdRcM6BYd/9IpsHlmgzrONM5MVWmeE7EZvYOYMY3gbMsLQElIOzFWT7kTAxYOQCBraYfB9jEUQDmaYBqQidVQmYW0SP5Z+NJ5bZ6nKt4P2y8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707607645; c=relaxed/simple;
	bh=H9TyBsS2FeOii05Yyfj9owxMN+73mvLkya1tI9ox5Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEJElnK03b1CKglyBWAlmcqOth6hoApH5qwFl+C73dAH8GgeJFmOXJewNdH2MwF+kwcHOfWZNAHilZzNpdQNwG56wBk94KttY/NtwcSP7/CUFx272krrVyxJKeuGcl/YpJkNcSx1QdbZn9BtbVKf97iQdxbSXbMTDyYDvfjOhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vy54Gspn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HZ51g0UGzeKqB9nWdGMxiSkghV0SKmVNRgT9K/Yj5ak=; b=vy54Gspnc3WSfLM6sjV/2eFuX3
	82T0fIsCl1b6cU4pR0Ss2IO9zC6Gh3WKquTWFV43yFK4qf4yNfSn6PeE8fyz5bMvBg3aL2BxgY2FU
	OHwWMqC6IxlhLCJKrvVtuNrS7hny8AywGFPdI/05Fawekew+Sxn4bmHV1mNNeyE0wXWC4yJK3YF2b
	JdCEhF0lwzQWoufbnZJCYFV5eLSJWmwJThaatba5dtoOz4sH+BRf0y0CkqeRgKnWExLwG2B1RJL5l
	oDE81DSAX9WmwrtL7kqh6sU7HegSFEHrOeYiofjJsRy6ytgnXrmnjBvtXt1IiVIUpO9cHsQoi++qa
	doYMQ4rQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rYwkg-005NJl-2y;
	Sat, 10 Feb 2024 23:27:19 +0000
Date: Sat, 10 Feb 2024 23:27:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] dcache: rename d_genocide()
Message-ID: <20240210232718.GG608142@ZenIV>
References: <20240210100643.2207350-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210100643.2207350-1-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Feb 10, 2024 at 12:06:43PM +0200, Amir Goldstein wrote:

> I am not usually for PC culture and I know that you are on team
> "freedom of speech" ;-), but IMO this one stood out for its high ratio
> of bad taste vs. usefulness.
> 
> The patch is based on your revert of "get rid of DCACHE_GENOCIDE".
> I was hoping that you could queue my patch along with the revert.
> 
> BTW, why was d_genocide() only dropping refcounts on the s_root tree
> and not on the s_roots trees like shrink_dcache_for_umount()?
> Is it because dentries on s_roots are not supposed to be hashed?

Because secondary roots make no sense for "everything's in dcache"
kind of filesystems, mostly.

FWIW, I don't believe that cosmetic renaming is the right thing to
do here.  The real issue here is that those fs-pinned dentries are
hard to distinguish.  The rule is "if dentry on such filesystem is
positive and hashed, that contributes 1 to its refcount".

Unfortunately, that doesn't come with sane locking rules.
If nothing else, I would rather have an explicit flag set along
with bumping ->d_count on creation side and cleared along with
dropping refcount on removal, both under ->d_lock.

Another piece of ugliness is the remaining places that try to
open-code simple_recursive_removal(); they get it wrong more
often than not.  Connected to the previous, since that's where
those games with simple_unlink()/simple_rmdir() and associated
fun with refcounts tend to happen.

I'm trying to untangle that mess - on top of that revert,
obviously.  Interposing your patch in there is doable, of course,
but it's not particularly useful, IMO, especially since the
whole d_genocide() thing is quite likely to disappear, turning
kill_litter_super() into an alias for kill_anon_super().

