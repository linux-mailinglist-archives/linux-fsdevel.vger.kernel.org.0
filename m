Return-Path: <linux-fsdevel+bounces-19361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32558C3AFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 07:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CB31F21141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 05:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B67F146589;
	Mon, 13 May 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NRfwid4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C6146006
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715578319; cv=none; b=o7xeQwq7n7edSy1nE4NGLtiV0uZ/B/jz4zAcbtLs+iaO7u88AgR+zt4IY5/4jFfNAzMx2zKAIIzTV44E5EgRoZ0lza6Rb4nuFHyQ4lJAZ61YhOHF4txfzOAbzbyTc80pST3ZK8UysxLq5Yz7B+7zfG2giHxOFZImddwD49NF+gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715578319; c=relaxed/simple;
	bh=ipHZWgR8YhQThgNo5q7IjlhBCukt1ZodEaQ2RyBoDNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrhX/Vqc7nXnR6YkBj3lRvkZxJRyc8nsIc3vZu/fsDqGdSt1S8LGQ8lYcfKNta3m74KSH+TlRVp6F0OmNVl6cI6PU1CwX+xlW+xFdtaOvzC7MAU7OFkszXWmE+YTZBKf7Q5yKnWYddtlA+1W6PoTCrqIQJKsuusSlX96VcPqcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NRfwid4r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jGWWLRx0MTjWk3p9JV1lHW3vtOwSJ2pgHLI8n6Oi41A=; b=NRfwid4r4AvyJYnOAnhNrqZWn8
	hPeVdlWPK07Q8i8NQBdJliKxY8eBR9DHrsGreGtY0An95aw7KK242G9ZGL3dDExOt5N+GY6jEHY8c
	tb50BU+tXlQGTA4tGrTM7s4Wz3Vwcd8BulUGRK2EjgEnFwu8++f4NuFwIsmfIdk8UEZiofheIw9BD
	Yaj7D76sIe0WdVm45Ye2bwhvo0RtgeCjnhURLgBO8dgvPq/AJx448ppQv/UshfH689v5jhL7LWPRt
	Q373AIbGNcxWDKlnOfglKghZ/2AQGkpFL26M4IH0nFa44LKubuh+j171PgYCSxJthrEjat4q7OZnW
	PD1ANNCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s6OHk-00595l-05;
	Mon, 13 May 2024 05:31:40 +0000
Date: Mon, 13 May 2024 06:31:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org, longman@redhat.com,
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <20240513053140.GJ2118490@ZenIV>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
 <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV>
 <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
 <20240512161640.GI2118490@ZenIV>
 <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgU6-AMMJ+fK7yNsrf3AL-eHE=tGd+w54tug8nanScyPQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 12, 2024 at 12:59:57PM -0700, Linus Torvalds wrote:
> so the removed directory entry itself will have either turned into a
> negatve dentry or will unhash it (if there are other users).
> 
> So the children are already unreachable through that name, and can
> only be reached through somebody who still has the directory open. And
> I do not see how "rmdir()" can *possibly* have any valid semantic
> effect on any user that has that directory as its PWD, so I claim that
> the dentries that exist at this point must already not be relevant
> from a semantic standpoint.
> 
> So Al, this is my argument: the only dentry that *matters* is the
> dentry of the removed directory itself, and that's the one that sees
> the "d_delete()" (and all the noise to make sure you can't do new
> lookups and can't mount on top of it).

Recall what d_delete() will do if you have other references.
That's why we want shrink_dcache_parent() *before* d_delete().

BTW, example of the reasons why d_delete() without directory being locked
is painful: simple_positive() is currently called either under ->d_lock
on dentry in question or under ->i_rwsem on the parent.  Either is enough
to stabilize it.  Get d_delete() happening without parent locked and
all callers of simple_positive() must take ->d_lock.

This one is not hard to adjust, but we need to find all such places.
Currently positivity of hashed dentry can change only with parent
held exclusive.  It's going to take some digging...

