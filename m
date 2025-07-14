Return-Path: <linux-fsdevel+bounces-54862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB22B04281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78855188E73E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 15:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71768258CF2;
	Mon, 14 Jul 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c8OJBBXj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A5248F66;
	Mon, 14 Jul 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752505456; cv=none; b=pq2zoSNXV9P7DyR9AkMmf5DRNn2oF/8rSyiq61KEqC3CF16cGSlG1ESXq1pD1CVoa7ZDY5eWEpgjg+P0zUDicke1EJjJzU+1x0GVeQEvbfJNH2D1TspPKJ4PEMU7AtF36yrA891IiJjfIFvISMV5Og3m+YYb61hn1suXzzrcWM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752505456; c=relaxed/simple;
	bh=1RWP7gWYudmyUNCDkQFqY1qnF8dgr04rh+tbD1T+EDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZhhUZS4W/gwACNVenq+svHjGfvXc3feiXa9xcsuh6I5ekuKGCH4ggHyZoDbIUlQPlt7mWCMH/9Ng2+N/nRqejDnRUe29pRtyoG5KAu6LkUp6fRQQIJHP7XditklG/XVD0/QS+ZxsCbDFVysNBZqjJGH99YpXi8yJChLZWQD+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c8OJBBXj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AZ2bBbpLMiFmj8FPT59LVJGQMEx5FYYovRXTDGhiToY=; b=c8OJBBXjP6J1I4HPZx+j66+cC0
	9pcRXFruGddDwrJ++qJO8w8pbqruI2fhM/NjoqBuyWzu8buBZ+mh4RM9OE/0ul+a4FbhiTReG7guk
	FSRDQwjja31U6qOewe+kIdYf0IKMMhnd8soIccT+Dfc+K6cYpjp+NMmoZQzpQoBdRTRXJeVhGh1yf
	ebeISxri1K4B35u/w2IsRr7FL5iLpOqQjL6DLcxZoeWBDc+iIoZwUSqaEtz33Srch0VhBUX0n074U
	a6xKVFCLyQ7ytKdTh7gybgwoyw6nxmaRDoz0wtCZuP6bx+jr3p3n+TQjk0CjWZ/LL0pxFp0U90+29
	cPupUvSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKiy-00000008v4K-0d28;
	Mon, 14 Jul 2025 15:04:12 +0000
Date: Mon, 14 Jul 2025 16:04:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH][RFC] don't bother with path_get()/path_put() in
 unix_open_file()
Message-ID: <20250714150412.GF1880847@ZenIV>
References: <20250712054157.GZ1880847@ZenIV>
 <20250712063901.3761823-1-kuniyu@google.com>
 <20250714-digital-tollwut-82312f134986@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-digital-tollwut-82312f134986@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 14, 2025 at 10:24:11AM +0200, Christian Brauner wrote:
> On Sat, Jul 12, 2025 at 06:38:33AM +0000, Kuniyuki Iwashima wrote:
> > From: Al Viro <viro@zeniv.linux.org.uk>
> > Date: Sat, 12 Jul 2025 06:41:57 +0100
> > > Once unix_sock ->path is set, we are guaranteed that its ->path will remain
> > > unchanged (and pinned) until the socket is closed.  OTOH, dentry_open()
> > > does not modify the path passed to it.
> > > 
> > > IOW, there's no need to copy unix_sk(sk)->path in unix_open_file() - we
> > > can just pass it to dentry_open() and be done with that.
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > 
> > Sounds good.  I confirmed vfs_open() copies the passed const path ptr.
> > 
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> I can just throw that into the SCM_PIDFD branch?

Fine by me; the thing is, I don't have anything else in the area at the moment
(and won't until -rc1 - CLASS(get_unused_fd) series will stray there, but
it's not settled enough yet, so it's definitely the next cycle fodder).

So if you (or netdev folks) already have anything going on in the af_unix.c,
I've no problem with that thing going there.

