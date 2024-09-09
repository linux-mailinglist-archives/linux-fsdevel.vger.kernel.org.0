Return-Path: <linux-fsdevel+bounces-28952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6786F971D3C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 16:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB9AFB229C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285A01BBBFA;
	Mon,  9 Sep 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pHqKADI5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0B1AE039
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893718; cv=none; b=AeUuMz+UsSo2nxOb0yDOAbXSnj7cMbg8FtfoghGSyr/fzqKIG9tgURuqLenyqcAwOS+p/xnwphlliMuq9FYRAp6qNp8Vd64Rlhb4ztdKDK5uCXuLUVVP+DBEEUgM9RM7Vs35I3dnvqe08XOyD0BHevIel++XAnsaBk/btirMu8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893718; c=relaxed/simple;
	bh=yhSCggSk2ztEFwaANl/f5hH5EJaph6GMZd5YjOBjSxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0t5iUdRYSBk5EztT1DUkugEnpHm8L/jhiP/pSUpdXy/e8/RTO4Ga/GQmJ7easfRpUJBWRu3mS/gP3aAXH+0Mxqq/Cvul0xBBRQjEtuOzOva+xLLkZLTWOZxO922gagO9yS+vXzIXZnt2DtS08apMhRyr1AduwlmELHNy45lHRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pHqKADI5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mRmS78jNSEjRbW1RfkNVcIiFQs+BtHlpdjo+RIOliaY=; b=pHqKADI599qjUdgBEYHYVyDqe6
	ou0qZ6mtipU3S8/Eiqj4Pd5m+fm9PeKEPgRjq8PIwM93gLrRIEHfIypzmcW01nbySu6HTLdBx35Tk
	Gu16v/G7/9q+pkktWzEtV0AdfjowT4yPU2yitKZzNx1NfDssUQHuHC/3X2eezwavD6f5tSY66o+B6
	6LoLigZFFyUjS/KOgmCHOpBQhnea4mvNqPRGFheQsZ8zeyDqDGrg3eGQT+fz6tSDSKO+OmEbf1WGd
	5yA1mP2EX+uvHM73Fx8RaT8toZMgsF6mayW1XU1Z6x8Mtpu6oBG9hn96oABxTDFN6WcHeUPw88XBv
	mfwFkw3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1snfnG-0000000AKOl-3Xs9;
	Mon, 09 Sep 2024 14:55:06 +0000
Date: Mon, 9 Sep 2024 15:55:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Mike Rapoport <rppt@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: copying from/to user question
Message-ID: <20240909145506.GL1049718@ZenIV>
References: <4psosyj7qxdadmcrt7dpnk4xi2uj2ndhciimqnhzamwwijyxpi@feuo6jqg5y7u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4psosyj7qxdadmcrt7dpnk4xi2uj2ndhciimqnhzamwwijyxpi@feuo6jqg5y7u>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Sep 09, 2024 at 10:50:04AM +0200, Christian Brauner wrote:
> Hey,
> 
> This is another round of Christian's asking sus questions about kernel
> apis. I asked them a few people and generally the answers I got was
> "Good question, I don't know." or the reasoning varied a lot. So I take
> it I'm not the only one with that question.
> 
> I was looking at a potential epoll() bug and it got me thinking about
> dos & don'ts for put_user()/copy_from_user() and related helpers as
> epoll does acquire the epoll mutex and then goes on to loop over a list
> of ready items and calls __put_user() for each item. Granted, it only
> puts a __u64 and an integer but still that seems adventurous to me and I
> wondered why.
> 
> Generally, new vfs apis always try hard to call helpers that copy to or
> from userspace without any locks held as my understanding has been that
> this is best practice as to avoid risking taking page faults while
> holding a mutex or semaphore even though that's supposedly safe.
> 
> Is this understanding correct? And aside from best practice is it in
> principle safe to copy to or from userspace with sleeping locks held?

You do realize that e.g. write(2) will copy from userland with a sleeping
lock (->i_rwsem) held, right?  Inevitably so.

It really depends upon the lock in question; sure, milder locking environment
is generally less headache, but that's about it.  You can't do that under
page lock.  You can do that under ->i_rwsem.  As for the epoll mutex...
do we ever have it nested inside anything taken on #PF paths?  I don't
see anything of that sort, but I might've missed something...

