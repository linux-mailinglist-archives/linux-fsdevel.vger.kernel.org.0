Return-Path: <linux-fsdevel+bounces-41308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A68A2DAD0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 05:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 792C91659EB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 04:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6FC3987D;
	Sun,  9 Feb 2025 04:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DWPU8XLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4118E20;
	Sun,  9 Feb 2025 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739077031; cv=none; b=BvwVlkYLDuzwXb9T7IwYL2XVX6ABxEKPKdEmDDq4mprbLfIU3vGqWM7cHpFZS6U8famooz4ArKXNR7HQnELnUDE6q8BFhHfe8JtJC5NEYDuomahhBFmQh3wdJ4Kuqyi6v8V2Erf6z2fDTSYA9408UeHq9Czdtc7tVE4la9w0VdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739077031; c=relaxed/simple;
	bh=8WVxcrG8DMuotq8XlM+nrgEWfwUEiChi0u0AcBwIQg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY3iynjS6ks02D+4aJO5xs3Q4zmwY5vyVezrA93/JgtpRysdIqNT+6zke/1n0J4fQrhRKQIcY9WOOQSF9JiVtsDL8RASaa6lIGkozL3lnDZ0WmOmntVcVtQnfGd3DMqldnTMieLJszbxVM3NqHUhfPvURnd1bauF0He/2qKHdJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DWPU8XLG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ipohgxEHhucEtBSiOUojyX5ghPXE6kNGqrYly1+V7Fw=; b=DWPU8XLGXecvrrYdZPlyW0GCgq
	28gbe0oRz3afbUOItSGyaycJGCBV4N9GTTdDALp2x2aDAZa1Goy5Ej73DTPc+aVmDq5D2QQuWtFFH
	G0wCj44IZ0kr9a6pyC4NpcYvS1FWu2KX4QaHealj+TRUUjT/b0T31Vl4Ajkwgt4CGxGBgxTNUcdge
	NC/NBodRkJZCdchWri0n2EM28QE1PgBvlX8rJqPZZh8JHCnAIMSQkfEEtVgwkfx+qbwyPOmoZxX6e
	igw2fy6awTQHHqtG0j7nhMJxz8NNbLCPYU96thv0YrOepdlInLlg+SdRw+zbNjSa9gzd/fksACyDN
	5sn8GjcQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgzNR-000000089SN-3iM7;
	Sun, 09 Feb 2025 04:57:05 +0000
Date: Sun, 9 Feb 2025 04:57:05 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/19] VFS: add _async versions of the various directory
 modifying inode_operations
Message-ID: <20250209045705.GU1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-10-neilb@suse.de>
 <20250207224134.GM1977892@ZenIV>
 <20250209010910.GT1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209010910.GT1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 09, 2025 at 01:09:10AM +0000, Al Viro wrote:
> On Fri, Feb 07, 2025 at 10:41:34PM +0000, Al Viro wrote:
> 
> > I'm sorry, but I don't buy the "complete with no lock on directory"
> > part - not without a verifiable proof of correctness of the locking
> > scheme.  Especially if you are putting rename into the mix.
> > 
> > And your method prototypes pretty much bake that in.
> > 
> > *IF* we intend to try going that way (and I'm not at all convinced
> > that it's feasible - locking aside, there's also a shitload of fun
> > with fsnotify, audit, etc.), let's make those new methods take
> > a single argument - something like struct mkdir_args, etc., with
> > inlines for extracting individual arguments out of that.  Yes, it's
> > ugly, but it allows later changes without a massive headache on
> > each calling convention modification.
> > 
> > Said that, an explicit description of locking scheme and a proof of
> > correctness (at least on the "it can't deadlock" level) is, IMO,
> > a hard requirement for the entire thing, async or no async.
> > 
> > We *do* have such for the current locking scheme.
> 
> While we are at it, the locking order is... interesting.  You
> have
> 	* parent's ->i_rwsem before child's d_update_lock()
> 	* for a child, d_update_lock() before ->i_rwsem
> and that - on top of ordering between ->i_rwsem of various
> inodes.
> 
> Do you actually have a proof that it's deadlock-free?

Note that "child's d_update_lock()" might very well be sleeping
on something that is no longer the parent's child, so the
ordering by depth, with ->i_rwsem and d_update_lock interspersed
does not hold.

What am I missing here?  I'd been trying to come up with
a proof of deadlock avoidance, but... no luck so far.

