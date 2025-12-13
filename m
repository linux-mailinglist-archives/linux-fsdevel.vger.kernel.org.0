Return-Path: <linux-fsdevel+bounces-71242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C664CBA683
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 08:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E8B830BFD50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEF26CE05;
	Sat, 13 Dec 2025 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fltvT9Uk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AFF212B0A;
	Sat, 13 Dec 2025 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765610537; cv=none; b=k4M8QvYBFxq2vqTkOvLHFp/0OFJ1MGDT+cIIiHI0e1ntqxlD/k7IiIz5trxog6W2vp+xg2+RsmwMYkANNOdQeR3j3S38R6XCRBYDYA8qOrRvoyqJkYtphCHsYY18H3hQTCF8cr91+g3ZJrJovQTPCEgh6zEfLbb8Y7oFCXzv8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765610537; c=relaxed/simple;
	bh=GMHyMAIUlxlDdjq/tAYkUYRYukprZK9ZZdct46MLFMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9slukPOWthUAb534/u0sqvscTlFIrf3aDlnbfZv2N88rmhBRFkLbR2+ToS02CG2uX/D7rFp8tkebubGepVofvqH3SpW7U4lCEk0hMMnwoM5wx4FBeGOKjd5VU7WUaaiAP4lLT2+Txr79PLORob7u3r6YltEoFo3vw+cs4WDceU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fltvT9Uk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jzmbE0f51Wo+UCICFtoAAZFgv4mhRqnt1ZueZdlnSx8=; b=fltvT9UkLNu+8PoclHWABfa/2f
	HP7Y3G5hzMe/WHcqxamYDg8kJ0d3IuyU9ekBnCTzQBP6BmdhMKublw09N20RR2NEmZXzC+eLd5sWY
	+3FlgMt4mNa27kf1NTAZV+l4EUZ4Gqs5OEPT5A0pRWZY8ixYIIgzRY9CwlXkfJS9+wT4+eW+TXrsw
	MhMmUSyQjihqU+BTcdmwh5g5t4OCjvdacEHw0q3B+mJq2ugjQIiDrNkzL3AxOev0NlCZppRM+quJk
	StIjY6kJpegJZ9kwR2xgIc6HGXff6HhARQAdJ2Sz0gO0BYwacMRTvKE4n6acrOMis4b7Yy4wb55Tq
	Hl9JbqiQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vUJxh-00000008Axs-1dGQ;
	Sat, 13 Dec 2025 07:22:41 +0000
Date: Sat, 13 Dec 2025 07:22:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Hugh Dickins <hughd@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: 6.19 tmpfs __d_lookup() lockup
Message-ID: <20251213072241.GH1712166@ZenIV>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com>
 <20251212050225.GD1712166@ZenIV>
 <20251212053452.GE1712166@ZenIV>
 <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
 <20251212063026.GF1712166@ZenIV>
 <2a102c6d-82d9-2751-cd31-c836b5c739b7@google.com>
 <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed18e79-ab2b-2a8f-0c32-77e6d27e2a05@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 12, 2025 at 02:12:17AM -0800, Hugh Dickins wrote:

> Well, more than that: it's exactly the right thing to do, isn't it?
> shmem_mknod() already called d_make_peristent() which called __d_rehash(),
> calling it a second time naturally leads to the __d_lookup() lockup seen.
> And I can't see a place now for shmem_whiteout()'s "Cheat and hash" comment.
> 
> Al, may I please leave you to send in the fix to Christian and/or Linus?
> You may have noticed other things on the way, that you might want to add.
> 
> But if your patch resembles the below (which has now passed xfstests
> auto runs on tmpfs), please feel free to add or omit any or all of
> 
> Reported-by: Hugh Dickins <hughd@google.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Tested-by: Hugh Dickins <hughd@google.com>

	The problem is that the comment is not quite accurate ;-)
What it's trying to say is that we get whiteout and old_dentry
sharing parent, name and both hashed, but that won't last for
long - as soon as we get to d_move(), old_dentry will change
name and/or parent.

	The trouble is, it might not _get_ to that d_move() at
all.  It used to be guaranteed back when shmem_whiteout() had
been introduced (shmem_renameat2() used to have no failure
exits past shmem_whiteout() returning success), but it's no longer
true - not since a2e459555c5f "shmem: stable directory offsets"
two years ago.

	Failure, AFAICS, requires severe a OOM, but it's still
a bug.  What's more, simple_offset_rename() itself does not recover
from a failure, without any whiteouts being involved.

	What I'm going to do is a couple of patches - one fixing
the regression in this cycle (pretty much what you'd been testing),
then a separate fix for stable offsets failure handling (present
since 2023).  I'll feed them to Linus; I hoped to do that with
old regression fixed first, to reduce the PITA for backports,
but if I don't have that debugged tomorrow, I'll send the recent
regression fix first.


