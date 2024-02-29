Return-Path: <linux-fsdevel+bounces-13169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFEF86C2AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 08:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1081F2539C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 07:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F0644C7A;
	Thu, 29 Feb 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PAFxoh3H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0361F951
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192542; cv=none; b=cnMRtaOGKxSQSbODAbvjHbStveqYRTliQFgJYkl0SrdHc9QwL51ceQNN/F8ubvOsNUii5EKO6eZseW6eTLXO1h7N8mklbcOsa9+D98AJXlUH/3QBxMzp94PRSncWM8dOPDzTnVJvDyPWjEkKK3LA4KUkmPnLGUNXzwlq+JhgLBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192542; c=relaxed/simple;
	bh=0Yb997k+j5gLuE4rcfEl7CxJEyw8+ZxIDkiTOn38w9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFGKQWpjnFVW9Pm8fpl0AUqYjS/FC+exS/ghRigRVu7f1AXSArHE7Jw/3JQGW5psPP1dw88nZcfG2GHePO2/HobgqtL0y06MoMoBqTBxPOsfXaxVoJ157IwrIN/eLisCXhbvm465kIYBfg9wDBcwFo0dCxdNv1Ke2fJZEVBife0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PAFxoh3H; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 02:42:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709192537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a+7Wgl/LElsu4LmPtEP+OSliQ1nGBJ0mbaPqWWeKZsg=;
	b=PAFxoh3HZ6s5ZeYnnCi6u1o9IPjCr21vF4Elz925OTRa6RopS5JyqnZSF7LB1Jl/DpWaU5
	J7Mg0FEnit5mKG+qHQ2VTO04PIuNu4kb9BR+yEQmVAl0CGtg3qFdrwkBYHgEZL69mf92U9
	ATEkX6HiFZN7InjatJnboW2xy9L/UqI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	david@fromorbit.com, mcgrof@kernel.org, hch@lst.de, willy@infradead.org
Subject: Re: [PATCH 2/2] bcachefs: Buffered write path now can avoid the
 inode lock
Message-ID: <z3zxghw5yok5qftgj7pygfrspwwiadcrg73cbvr3okwoti7tho@zwmw2naayz5c>
References: <20240229063010.68754-1-kent.overstreet@linux.dev>
 <20240229063010.68754-3-kent.overstreet@linux.dev>
 <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whf9HsM6BP3L4EYONCjGawAV=X0aBDoUHXkND4fpqB2Ww@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 11:20:44PM -0800, Linus Torvalds wrote:
> On Wed, 28 Feb 2024 at 22:30, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Non append, non extending buffered writes can now avoid taking the inode
> > lock.
> 
> I think this is buggy.
> 
> I think you still need to take the inode lock *shared* for the writes,
> because otherwise you can have somebody else that truncates the file
> and now you will do a write past the end of the size of the file. That
> will cause a lot of issues.
> 
> So it's not a "inode_lock or not" situation. I think it's a
> "inode_lock vs inode_locks_shared" situation.
> 
> Note that the reading side isn't all that critical - if a read races
> with a truncate, at worst it will read some zeroes because we used the
> old length and the page cache got cleared in the meantime.
> 
> But the writing side ends up having actual consistency issues on disk.
> You don't want to have a truncate that removes the pages past the end
> of the new size and clears the end of the new last page, and race with
> another write that used the old size and *thought* it was writing to
> the middle of the file, but is now actually accessing a folio that is
> past the end of the whole file and writing to it.
> 
> There may be some reason that I'm missing that would make this a
> non-issue, but I really think you want to get the inode lock at least
> shared for the duration of the write.

It's even mentioned in one of the comments - bcachefs's pagecache add
lock guards against that. The rules for that lock are

 - things that add to the pagecache take the add side of that lock
 - things that remove the pagecache take the block side of that lock

I added that so that we wouldn't have pagecache inconsistency issues
with dio and mmap'd IO - without it anything that needs to shoot down
the pagecache while it's doing IO that bypasses the pagecache is buggy
(fpunch, fcollapse...).

> Also note that for similar reasons, you can't just look at "will I
> extend the file" and take the lock non-shared. No, in order to
> actually trust the size, you need to *hold* the lock, so the logic
> needs to be something like
> 
>  - take the lock exclusively if O_APPEND or if it *looks* like you
> might extend the file size.
> 
>  - otherwise, take the shared lock, and THEN RE-CHECK. The file size
> might have changed, so now you need to double-check that you're really
> not going to extend the size of the file, and if you are, you need to
> go back and take the inode lock exclusively after all.

That one - yes.

pagecache add lock was also supposed to handle that because anything
that changes i_size downward needs pagecache block, but I moved where we
take that lock for lock ordering reasons, and I really didn't need
too...

I'm undecided on that one. I dislike using pagecache add lock to guard
i_size because that's really not what it's for, but I also hate hitting
the inode lock if we don't actually need it.

Kinda waiting for Al to drop in and mention the other super obscure
reason the inode lock actually is needed here...

