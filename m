Return-Path: <linux-fsdevel+bounces-42374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D746A412B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 02:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B99171568
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 01:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B00156C5E;
	Mon, 24 Feb 2025 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FPng/gD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF5DF60
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740361129; cv=none; b=Vova02XHl9de5G0KPXvvqzJxQygteuCaXkZFEVPjWP6/1Vxjge0tGeyRfzTENs13YZPjjCaY2nsfkYzJ2SDhuSotRV2aNLJ2dA/kJ1JazrkJhpZ+Sfq4K5xLcs4Bf9Ia2KPpGzDo/9/D1RVBAo+LW40Mk7PH9ov1jf5SporagnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740361129; c=relaxed/simple;
	bh=HNi95zKY8D8zTmdqldZzF2f0ubhndZHh4gW9nL1O79U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9xXxd2nAqp86lS5syCWNm8g7QVg8J9SxfNhAVxhqoYLey0cyLVubJQvKrq0YWgPTRU/lMOJTKwXTyYH0NKC3YAhqiW1viNg29IKzDbliuMwgFDIck704P3VtBqu+fTc+Xv7wyW/OCEu4fn+iLw1pApB4A70qQw5MSfKCzBXPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FPng/gD+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7ntHLc2uqqFlMoJB/KFqTTh9vBwoZ7Jsa6gE+MIkWL8=; b=FPng/gD+SXv+DxZtXESjzgb+xo
	Xs5bNozfenENjKkbbRrbWVZCWUYuXSJ3sh/LB+s07OjcROLQt+C5X9k0viw7GOkwLsDv6Sao06Fcv
	m3qYWK+fDYnwX86IKeULrwtcIHZm3I7ifiTnnFXh6KDan51iU2WJz/8RcTl8XhzgycgivucJGhAn2
	fEfwRkWQ+u0gq5JbEmT52nbgGSyRoJUUlzj7Qu8YCPgqnVR/RtyJWAgpUDi7WwWhlHFeUYsNFv24J
	rXd2oe6W+BULc1mFO3TToxZCjJbafl15NmFm98buXxQh+qbIFGe84LKHM4rlJv77+DNNGFfV4YRct
	EvZLxV4w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmNQi-00000006ZJy-2Oso;
	Mon, 24 Feb 2025 01:38:44 +0000
Date: Mon, 24 Feb 2025 01:38:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Neil Brown <neilb@suse.de>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC] dentry->d_flags locking
Message-ID: <20250224013844.GU1977892@ZenIV>
References: <20250224010624.GT1977892@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224010624.GT1977892@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Feb 24, 2025 at 01:06:24AM +0000, Al Viro wrote:

> PS: turns out that set_default_d_op() is slightly more interesting
> than I expected - fuse has separate dentry_operations for its
> root dentry.  I don't see the point, TBH - the only difference is
> that root one lacks
> 	* ->d_delete() (never even called for root dentry; it's
> only called if d_unhashed() is false)
> 	* ->d_revalidate() (never called for root)
> 	* ->d_automount() (not even looked at unless you have
> S_AUTOMOUNT set on the inode).
> What's wrong with using fuse_dentry_operations for root dentry?
> Am I missing something subtle here?  Miklos?

Speaking of fun questions - does pidfs_dentry_operations need
->d_delete()?  I mean, it's not even called for unhashed
dentries and AFAICS there's no way for those to be hashed...
The same goes for all filesystems created by init_pseudo().

Is there any reason to have that in pidfs_dentry_operations and
ns_dentry_operations?

I think nsfs is my sloppiness back then - original commit message
explicitly says that neither dentries nor inodes in that thing
are ever hashed, so ->d_delete() had been clearly pointless
from the very beginning.

Christian, pidfs looks like it just had copied that from nsfs.
Is there something subtle about pidfs that makes ->d_delete()
needed there?

