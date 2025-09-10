Return-Path: <linux-fsdevel+bounces-60737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4744AB50F27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 09:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9304545C2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 07:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C163090E2;
	Wed, 10 Sep 2025 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gy5v3Ty6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91B1A4E70
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757489069; cv=none; b=f0FtA3HYVJEVtrZpQYe4qXkmMI7pGNR9DJ/esuzoaTUWelj3UXFIiEHGmKxCMPi4G28pTefY1scLA8WtPmZZ5R8d39qMq2l0v1kqNCNUQ12XPi2v70eMs2jqQEJLZO7x1WahTW31WLEJWWCzMmt+WNQH+FG/rLR/APHe1+8Zzls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757489069; c=relaxed/simple;
	bh=933m4veJzQ97k2969/XJNUGJnhjftaeLiHsS/31PWrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQraipIq4CmgM7y6RlikHZiAP+ATQhX6ab9uRjwBkVs83xly/iAadtaptR6MC9W82+JfcUWpG0/34yL1hjNsNrnkBhbMIfByCg0+66fnTtUflon/RmmlZOSv+AIMovDBtx5HYVe2SVuhEZBoiYlgXu7iG2obaTmWQawJaX6cMMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gy5v3Ty6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6XcPZcBFhv6ytxRBs0ZO/Yj58f7tYuAH7xlFnPzjp6I=; b=gy5v3Ty6WEBwpESyursjVoyvV2
	glJM/ggUNOLYYzBjQ6V98DvKmW+fl+LqZj/8vRjv+VAzZgORJLCp3x0XLpOl2o15Aa2E/HbeUR3w1
	OxMxZyS4HIFiBN3AAvAp/RSuvnFK81VRHiURrcilhkmdU2mJZF4kCuukYuIoLwMIjF1615ABVGkm5
	2GSqLDkbsRZ2HAgsh6pe6wy5txm9/mWQBakWLRIW/WvtOanFKJSf1ZE8r6hZGsCuQHG1EAFHMghsh
	Xuts5bsj+PZ/js4MXqIfPHTzAOxfwS1QHKRHh+W+BTw0H3keAnT2dLra8YSRHUUvul+57Lf3mcHR6
	4JmhBcfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwFBn-0000000GOBT-2om7;
	Wed, 10 Sep 2025 07:24:23 +0000
Date: Wed, 10 Sep 2025 08:24:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
Message-ID: <20250910072423.GR31600@ZenIV>
References: <>
 <20250908090557.GJ31600@ZenIV>
 <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 10, 2025 at 12:45:41PM +1000, NeilBrown wrote:

>    - dentry is negative and a shared lock is held on parent inode.
>      This is guaranteed for dentries passed to ->atomic_open when create
>      is NOT set.

Umm...  The same goes for tmpfile dentry while it's still negative (nobody
else could make it positive - it's only reachable via the parent's list
of children and those who traverse such will ignore anything negative unhashed
they find there.

> One thing I don't like is the name "unwrap_dentry()".  It says what is
> done rather than what it means or what the purpose is.
> Maybe "access_dentry()" (a bit like rcu_access_pointer()).
> Maybe "dentry_of()" - then we would want to call stable dentries
> "stable_foo" or similar.  So:
> 
>  static int afs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>                       struct stable_dentry stable_child, const char *content)

That has too much of over-the-top hungarian notation feel for my taste, TBH...

Note that these unwrap_dentry() are very likely to move into helpers - if some
function is always called with unwrapped_dentry(something) as an argument,
great, that's probably a candidate for struct stable_dentry.

I'll hold onto the current variant for now...

