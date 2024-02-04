Return-Path: <linux-fsdevel+bounces-10225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86213848F3E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 17:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238111F228B4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 16:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF65F22EF4;
	Sun,  4 Feb 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="cWf5x1NP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38C522EE0;
	Sun,  4 Feb 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707063965; cv=none; b=d6CxCekiTRp1CNYNGo3tH5CIyBkp77FreB7K+hCQLF5xQkAwaKWIABedRB33wR/NGwiATPuVD5SV8A1dkXeUNZ5AyhdnlLZxFeNxshB1onY/qCfFuUL4bt7buemHDvWMg6DET8Bi3O5PL7AfhQuFuNFIIBNFu7rXfrvLUGLBIYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707063965; c=relaxed/simple;
	bh=TYrE7OeWwo6qLBtmcJPaIJ9NY33iAz58AQTG5E7m6qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdcgj7hbNW+O6NkbqzBt8QX9B5du7nNpG0KNdblR3H8j4KQ90OEkQkXZ0x6u3GrHjcrcPUjz59PFfeZ0kJ4GAVyarnphupV0J/VeqQWBMk4PGOfjWxIo8VmZ+1Ofb22MHX9qrf0MuQTKzO/f36YQodOXV6jTPlkwRfwxaFt2Gfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=cWf5x1NP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lp2W6AwdYS1QtTu5hBJMg1umxOVPx8GyqI2GdpCrMuQ=; b=cWf5x1NPnMFpK7ObcfuAMNM/BK
	F4oNkeiPtnqh//XO1eWdwdlczuRTlAfU2hmmTm9ulkIajDxWeBnoDT5n0gyiXH+i0R7uXFT1hGZmR
	z86iYwha38YjfGnv9yNEXqd7C/AR7h8q1ibxDftXHl67gGM6K/xSJEHQ/6tKtyTJH5c5eREo1HRP/
	Mxg+3TepEn+el9CClA1VeNDRIXVhLxAgcilRXfXWhUIQRbSKXw8aH7H+wWQ9URXYBqUlwH3SLpzgc
	CiVxAGj7zo8f08W06okS7CdcWmmsf8BG+M++R4U1t3UUEAIT8FMASEOyHxGmPcSD75Kpr5zJOqpG+
	qXqcmPFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWfJe-005BQS-0y;
	Sun, 04 Feb 2024 16:25:58 +0000
Date: Sun, 4 Feb 2024 16:25:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Steve French <smfrench@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 12/13] cifs_get_link(): bail out in unsafe case
Message-ID: <20240204162558.GJ2087318@ZenIV>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
 <20240204021739.1157830-12-viro@zeniv.linux.org.uk>
 <CAH2r5muOY-K6AEG_fMgTLfc5LBa1x291kCjb3C4Q_TKS8yn1xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muOY-K6AEG_fMgTLfc5LBa1x291kCjb3C4Q_TKS8yn1xw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 04, 2024 at 09:45:42AM -0600, Steve French wrote:
> I may be missing some additional change or proposed future change -
> but it looks like the patch to add check for null dentry in
> cifs_get_link causes
> an extra call to cifs_get_link in pick_link() (in namei.c - see
> below), so would be slightly slower than leaving code as is in
> cifs_get_link
> 
>                 if (nd->flags & LOOKUP_RCU) {
>                         res = get(NULL, inode, &last->done);
>                         if (res == ERR_PTR(-ECHILD) && try_to_unlazy(nd))
>                                 res = get(link->dentry, inode, &last->done);
> 
> cifs.ko doesn't use or check the dentry in cifs_get_link since the
> symlink target is stored in the cifs inode, not  accessed via the
> dentry, so wasn't clear to me
> from the patch description why we would care if dentry is null in
> cifs_get_link()

The very first thing you do in there is a GFP_KERNEL allocation.
You can't do that under rcu_read_lock(), for obvious reasons.

So if you ever get there (and it takes a somewhat convoluted setup -
you need to bind a cifs symlink over a file on a local filesystem),
you need to
	* carefully grab references to all dentries involved,
verify that they are still valid, etc.
	* drop rcu_read_lock()
before you can get on with fetching the symlink target.

That's precisely what try_to_unlazy() in the fragment you've
quoted is doing.

NULL dentry argument passed to ->get_link() is the way it is told
that we are in RCU pathwalk mode; anyone who can't handle that
should just return ERR_PTR(-ECHILD) and be done with that.  The
caller will switch to the non-RCU mode (with references pinned,
etc.) and call again.

*IF* you can tell the symlink body without blocking (e.g. you
have some cached information from the last time you've asked
the server and have reasons to trust it to be still valid),
sure, you can return it without dropping out of RCU mode.

It would be fairly useless for CIFS, since ->d_revalidate() of
CIFS dentries would reject RCU mode anyway.  That's what normally
saves you from having ->get_link() called that way, but it's not
guaranteed - there are convoluted setups that avoid having
->d_revalidate() called first.

See the description of RCU mode filesystem exposure in the
last posting in this thread for more details.

