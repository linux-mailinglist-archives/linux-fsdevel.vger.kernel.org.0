Return-Path: <linux-fsdevel+bounces-41602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B14FA32AE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830EF188EA54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 15:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E22580C8;
	Wed, 12 Feb 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qZFm/zSV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5164E211A2C;
	Wed, 12 Feb 2025 15:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375498; cv=none; b=gTZhEopTy1znjfLT+Sa6VNL29Rj5FI5FMx/XIDslzKWNj86rbYbQf3QrSkuQCcLpA8EQ33hiyk9/VZbbrudVniTtj9MkEaU9etn3AyAr5iMeRPJZYYdPHk6cgRevV0AznUvePCrfj890o1xJ6+dHBI/V5ay/U4/1+aZuFZn0/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375498; c=relaxed/simple;
	bh=3Elp7Du8dvj8VL6H/WKoQqrGeu2o20YDyZQHxgN5FAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Btzewv/N8it+QaAl+dPLtHTnnefNtWkLTOBQeCjFJM5BWh4/yeMaAn+jjcXqfJYvjcYm/BsT8A2em1zcusgbHhhbSpU3BB/besD+xjzxXHkK4DlQHP0Y4TTGSqn/zliv7CJjEaUUff01IunFdcfo2NhYrt1cQ7JwX+xL0OZlZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qZFm/zSV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZJ8yWD/bsXA52HjsSAj+1eQUzVgGh8hI50BViS2oWb8=; b=qZFm/zSVGEGD4sJc6jQwefzOiw
	dxo5mq4gwYYgScpNb5/A93EBCeN6ENM6sHDw4wz/EsllDTwptIHrrC4t4FKgpFn1g0zChWkzuzA8Z
	nKqdWL3ZiZZH4Wd7BsELqNsvq3o/YuwZfDreAZac/YLCjFtykAdvH+7wCeVKhpQJuuXASUTmujekO
	K//FGuZOrboUKbj+u1ECwaDEfAiXNiZ6BAuWJTRrWWDHVB63OuwD1HSBWoW/y/1lpjj82sQNULS8k
	M6BqRAXX80eYANdwHU4iyR3qs70mWHvZE2zN03vEgiKrRQBYN/pMPI8orlb4o9Mm/TAj4nUwMF5Ht
	md+/f6Jw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiF1Q-0000000Bp8E-2B5g;
	Wed, 12 Feb 2025 15:51:32 +0000
Date: Wed, 12 Feb 2025 15:51:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] VFS: introduce lookup_and_lock() and friends
Message-ID: <20250212155132.GQ1977892@ZenIV>
References: <>
 <20250208231819.GR1977892@ZenIV>
 <173933773664.22054.1727909798811618895@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173933773664.22054.1727909798811618895@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Feb 12, 2025 at 04:22:16PM +1100, NeilBrown wrote:

> lookup_for_removal() etc would only be temporarily needed.  Eventually
> (I hope) we would get to a place where all filesystems support all
> operations with only a shared lock.  When we get there,
> lookup_for_remove() and lookup_for_create() would be identical again.
> 
> And the difference wouldn't be that one takes a shared lock and the
> other takes an exclusive lock.  It would be that one takes a shared or
> exclusive lock based on flag X stored somewhere (inode, inode_operations,
> ...) while the other takes a shared or exclusive lock based on flag Y.
> 
> It would be nice to be able to accelerate that and push the locking down
> into the filesystems call at once as Linus suggested last time:
> 
> https://lore.kernel.org/all/CAHk-=whz69y=98udgGB5ujH6bapYuapwfHS2esWaFrKEoi9-Ow@mail.gmail.com/
> 
> That would require either adding a new rwsem to each inode, possibly in
> the filesystem-private part of the inode, or changing VFS to not lock
> the inode at all.  The first would be unwelcome by fs developers I
> expect, the second would be a serious challenge.  I started thinking
> about and quickly decided I had enough challenges already.

I think it's the wrong way to go.

Your "in-update" state does make sense, but it doesn't go far enough
and it's not really about parallel anything - it's simply "this
dentry is nailed down <here> with <this> name for now".

And _that_ is really useful, provided that it's reliable.  What we
need to avoid is d_drop()/d_rehash() windows, when that "operated
upon" dentry ceases to be visible.

Currently we can do that, provided that parent is held exclusive.
Any lookup will hit dcache miss and proceed to lookup_slow()
path, which will block on attempt to get the parent shared.

As soon as you switch to holding parent shared, that pattern becomes
a source of problems.

And if we deal with that, there's not much reason to nest this
dentry lock inside ->i_rwsem.  Then ->i_rwsem would become easy
to push inside the methods.

Right now the fundamental problem with your locking is that you
get dentry locks sandwiched between ->i_rwsem on parents and that
on children.  We can try to be clever with how we acquire them
(have ->d_parent rechecked before going to sleep, etc.), but
that's rather brittle.

_IF_ we push them outside of ->i_rwsem, the role of ->i_rwsem
would shrink to protecting (1) the directory internal representation,
(2) emptiness checks and (3) link counts.

What goes away is "we are holding it exclusive, so anything that
comes here with dcache miss won't get around to doing anything
until we unlock".

