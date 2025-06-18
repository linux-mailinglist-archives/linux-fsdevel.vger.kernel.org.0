Return-Path: <linux-fsdevel+bounces-52006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DD6ADE30A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5453BD9C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 05:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B661FBEBE;
	Wed, 18 Jun 2025 05:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="F2uP2R1D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0553A1DB;
	Wed, 18 Jun 2025 05:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750224473; cv=none; b=qWrN7Mvn+r3HH3Ak2tmDOkqkBytwPtBLvVJcy+nBFgffjs4ooCL3hfaRUt0ww8KOpj6+t+yut1p8+ZdlH+1dMiQlYk+ZtjgZWhOvTqDxiF571UEwASvCSWsxwo0tdf0aTVgHJnN4d2bPKoic6d6h1H6+Wd6f4iLis2oQ8VCubx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750224473; c=relaxed/simple;
	bh=dTOUd3rxOM5ABmHhQR7xQTSuiU+Zbz9Gd/d9Ce6CNeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwa3KCb1JnEvqlS+dxzXK5ow6CsalqPr6o5qHJ8KJW8dg2r1K0d/sZs6ViPjOH/N2NqCExqnMEU7bGE0NL2da+DjoQpkefZ1aVZWJahNwmZjmBhaF0n9HzsoHbFXjQGuYQ0ywr0Rt3sPUn5sCMCBZ/agrsOw+vV7o7v6f03NMoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=F2uP2R1D; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1uNx4XCscIMDxHJEBBZ1W6p4eJHT017FfmnCVTXjIw4=; b=F2uP2R1Dw8BRdUiR3t2pgUw8mS
	5mF4ZAa5my55EWzQlXFeA8QyIWFDPTrsgwQQWCm2B1u8+SMXMY/q68I97rfDJcBeFbZeQpdYJrq9W
	rJvF+ntl7C7Dsjk4lYXM83l25BXQkJF8nMwirRacQIaekTHE5XuYbsr47JbiaREuR8KKVlzTNsJ+Z
	yVPMfw0ScEjtjxpYV2Tx3GCZRzA3KFU9WcN9ykqRmXXESAD0q7jWt8wFl3wKyMEdeoiMTKbyDigKm
	seivu1J223/a+rro7bT7jp8zMkF9BzcMkn3XVFaToor/jWr8pqLqnSh5sVR/DjN0UUhqArI6Z0og3
	K6TeOnkg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRlKt-00000005yBg-3UiG;
	Wed, 18 Jun 2025 05:27:48 +0000
Date: Wed, 18 Jun 2025 06:27:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+1aa90f0eb1fc3e77d969@syzkaller.appspotmail.com,
	almaz.alexandrovich@paragon-software.com, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fs: Prevent non-symlinks from entering pick link
Message-ID: <20250618052747.GQ1880847@ZenIV>
References: <685120d8.a70a0220.395abc.0204.GAE@google.com>
 <tencent_7FB38DB725848DA99213DDB35DBF195FCF07@qq.com>
 <20250618045016.GO1880847@ZenIV>
 <20250618050200.GP1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618050200.GP1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 18, 2025 at 06:02:00AM +0100, Al Viro wrote:
> On Wed, Jun 18, 2025 at 05:50:16AM +0100, Al Viro wrote:
> 
> > NAK.  This is not the first time that garbage is suggested and no,
> > we are not going to paper over that shite in fs/namei.c.
> > 
> > Not going to happen.
> > 
> > You ARE NOT ALLOWED to call make_bad_inode() on a live inode, period.
> > Never, ever to be done.
> > 
> > There's a lot of assertions it violates and there's no chance in
> > hell to plaster each with that kind of checks.
> > 
> > Fix NTFS.  End of story.
> 
> To elaborate a bit: if you look at the end of e.g. their attr_set_size(),
> you'll see
> out:
>         if (is_bad) {
> bad_inode:
> 		_ntfs_bad_inode(&ni->vfs_inode);
> 	}
> 	return err;
> }
> 
> This is a bug.  So are similar places all over the place there.
> You are not supposed to use make_bad_inode() as a general-purpose
> "something went wrong, don't wanna see it anymore" tool.
> 
> And as long as it stays there, any fuzzing reports of ntfs are pretty
> much worthless - any of those places (easily located by grepping for
> _ntfs_bad_inode) can fuck the kernel up.  Once ntfs folks get around
> to saner error recovery, it would make sense to start looking into
> fuzzing that thing again.  Until then - nope.  Again, this is *NOT*
> going to be papered over in a random set of places (pretty certain
> to remain incomplete) in VFS.

Note that anything that calls __d_add(dentry, inode) with is_bad_inode(inode)
(or d_add(), or d_instantiate(), or d_splice_alias() under the same conditions)
is also FUBAR.

So's anything that calls make_bad_inode() on a struct inode that might be
in process of being passed to one of those functions by another thread.

This is fundamentally wrong; bad inodes are not supposed to end up attached
to dentries.

