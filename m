Return-Path: <linux-fsdevel+bounces-58898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08447B33254
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 21:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64192011CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F221B9DA;
	Sun, 24 Aug 2025 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D394cjco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8214A4F9;
	Sun, 24 Aug 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756063151; cv=none; b=WFCRkr8vZ4cU+ZltSFhVSx3DGPDcN6zpju6wZKBQQxgwSxWKh73ZJxUbCCEJd9HY+bOc60nFgF+6KsJrYwHIKoSowRwnr8p1fosibI7MMdMjhW40EFmhXHjSKU2cpI6iZlvVAXAuKVXAnb8/u5hNS7PeHEoJvZN4uTKGour0aXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756063151; c=relaxed/simple;
	bh=/1xtDA2ZP2iTb5TKj4DY26eJQ8cZ+dH0KLRsU3nZgYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwNfOEo69C/KhWjYlmHSGpa75hYe43hBGIPd9f+mE6yh4TLy+u7jXR3fsj3UD0qyxbGA3Yzx/CxmO3/m+XPzTFaMdWfWBt+ZokWvx+UFNMO1nGvJ8ddYg8qlWN5tuzWLhHuDJsDWbOF3p4XOrCnMsrKXie5obXEVXNz4GxykhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D394cjco; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=POwG9kiQjmCUvTSc5Dkeyc+aw3vynEXhqi2lvc1CRck=; b=D394cjcoM4mbtwaybjgR9Cwh9i
	ZvDdE8lF0uG/d+jd0Fzw7cIX+0paPQM+qxi3grXdJiPXlJ3UUgMkq6nJo9KPOiPFL8lvzoLzxMPhL
	wp9RgnpwmyFtPv+sFxIKy4XWY93XDnLiIkOeY4Q6wE43qEgslIHwa7cP7DHLRH53W3qvosL+FtpTw
	PBmaO9MwNMQa2vOsVFRbme0R4DRczcHLSc7x6mNCf/V4riaCYUuuCQnSuoyFTFTmiysCfLvAl3iXN
	iOZLdAkSDFUYquTCuV4JN2onEwAM6sepKJnp4AD4HsYFPy6kS7C4PsMKEGkFBt7jjH+/8VWNKdDoc
	9mlI28rg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqGF9-0000000GFuA-01gc;
	Sun, 24 Aug 2025 19:19:07 +0000
Date: Sun, 24 Aug 2025 20:19:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: ssranevjti@gmail.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, jack@suse.cz,
	syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: Re: [PATCH] fs/namei: fix WARNING in do_mknodat due to invalid inode
 unlock
Message-ID: <20250824191906.GH39973@ZenIV>
References: <20250824185303.18519-1-ssrane_b23@ee.vjti.ac.in>
 <20250824190714.GG39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824190714.GG39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Aug 24, 2025 at 08:07:14PM +0100, Al Viro wrote:
> On Mon, Aug 25, 2025 at 12:23:03AM +0530, ssranevjti@gmail.com wrote:
> > From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> > 
> > The done_path_create() function unconditionally calls inode_unlock() on
> > path->dentry->d_inode without verifying that the path and inode are valid.
> > Under certain error conditions or race scenarios, this can lead to attempting
> > to unlock an inode that was never locked or has been corrupted, resulting in
> > a WARNING from the rwsem debugging code.
> > 
> > Add defensive checks to ensure both path->dentry and path->dentry->d_inode
> > are valid before attempting to unlock. This prevents the rwsem warning while
> > maintaining existing behavior for normal cases.
> > 
> > Reported-by: syzbot+0cee785b798102696a4b@syzkaller.appspotmail.com
> 
> No.  You are papering over some bugs you have not even bothered to describe -
> "certain error conditions or race scenarios" is as useless as it gets.
> 
> Don't do that.  Fixing a bug found by syzbot is useful; papering over
> it does no good whatsoever.
> 
> NAK.

Incidentally, syzbot report in question seems to be the one at

https://lore.kernel.org/all/689edffb.050a0220.e29e5.000d.GAE@google.com/
"[syzbot] [gfs2?] WARNING in do_mknodat (3)"

I won't have time to look at it in details until tomorrow, though.

Again, the patch upthread is no-go.  Whatever is going on with that
reporducer, this is not a fix.

