Return-Path: <linux-fsdevel+bounces-41269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8208A2D0D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 23:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8CD818836EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4DB1C701B;
	Fri,  7 Feb 2025 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="u8HTEcEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74691B85F8;
	Fri,  7 Feb 2025 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968099; cv=none; b=YvhgMNhtR4f+YwFnJ7SVU1mSqz/TVrkfgq9UmgmXaYINTrrfHSSFUUI30MGWsqGdGwYbQdUSDnYXWJKubloPc6/Z+dkrnowAydw2d1qMtjbw0/uoa5xvSPPYI1u62yeHJNMNOG8KR6ZTbCqsMh3OW4S2Z4yN880YLDgdzhT0azU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968099; c=relaxed/simple;
	bh=5ib1PTrHwCZ+lCJZnTPYTpCRuH0ctx+Px4qttu2dPnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVoWWw/lk9m7bpxi3pdtMNox6FcTpvh1AVSA3vGvN6P3//nr1zhVfNBwa7ut9dj7ubQx4b4mCW9JYNVVLakNFaxoNOnEPjDE3SDHX8jdlJGp2/ltNYhZHsaEsANkRfar6++LKv6T3JvqRvBJ1flgjsMiF6Yxe5wkKLgMYFta7Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=u8HTEcEt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qQvebxCbkMZCNGjKogtEbnvfJMWKBTT8tF0Exv7OWtk=; b=u8HTEcEt4GpqNwk3vtnXj2cTse
	BUQTX9ypsTEPpPlT8dJSWgu7Bm+/oYi+8/EEdbCQ5X0Px/rmnhnaHHIS8NSUppSEIiIfPsnHXYOJY
	YlU4lyRHaovcGTm+mjm0QIKvAwN1sai10dfrNYE8OSCVS5KXXzVc4C/f1IbuGbb/smgoxbqPWYCq3
	lmkNPQ20Q0uqkmpnaJta8V1Bjb83YMJdMQjdZOxdBYw1bZXkZXC+/bjITZwXHz6nNJG1qZkq7jdvz
	QZpq54b5DJRL2TFKKRDcwgax4gzVEo4ns3ppP/7d/yzK682+2bttcpEcgHNRx/h8ZG2i/so/WVVDb
	HkygA3SA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgX2U-00000006fyj-1HFS;
	Fri, 07 Feb 2025 22:41:34 +0000
Date: Fri, 7 Feb 2025 22:41:34 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/19] VFS: add _async versions of the various directory
 modifying inode_operations
Message-ID: <20250207224134.GM1977892@ZenIV>
References: <20250206054504.2950516-1-neilb@suse.de>
 <20250206054504.2950516-10-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206054504.2950516-10-neilb@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 06, 2025 at 04:42:46PM +1100, NeilBrown wrote:
> These "_async" versions of various inode operations are only guaranteed
> a shared lock on the directory but if the directory isn't exclusively
> locked then they are guaranteed an exclusive lock on the dentry within
> the directory (which will be implemented in a later patch).
> 
> This will allow a graceful transition from exclusive to shared locking
> for directory updates, and even to async updates which can complete with
> no lock on the directory - only on the dentry.

I'm sorry, but I don't buy the "complete with no lock on directory"
part - not without a verifiable proof of correctness of the locking
scheme.  Especially if you are putting rename into the mix.

And your method prototypes pretty much bake that in.

*IF* we intend to try going that way (and I'm not at all convinced
that it's feasible - locking aside, there's also a shitload of fun
with fsnotify, audit, etc.), let's make those new methods take
a single argument - something like struct mkdir_args, etc., with
inlines for extracting individual arguments out of that.  Yes, it's
ugly, but it allows later changes without a massive headache on
each calling convention modification.

Said that, an explicit description of locking scheme and a proof of
correctness (at least on the "it can't deadlock" level) is, IMO,
a hard requirement for the entire thing, async or no async.

We *do* have such for the current locking scheme.

