Return-Path: <linux-fsdevel+bounces-56677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A27B1A8A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8E73B93A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9CF28B7D4;
	Mon,  4 Aug 2025 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tQM26qnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803981E51EF;
	Mon,  4 Aug 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328466; cv=none; b=ib3xvmwJ+Rk/fSA/XhaHlKxsv4Bcb35RB+LA8iYJDnsZafm3CXKoDguEfPxTlJslM4JZblDXabpW6DuW4azvacSocI0oU2uNt5kRae0TPefxiK5B54pMH4p08rOpp0LKwRDqfHKD+jDJOdcykYQecKR1CYc88Oq7pPZOcs0CB5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328466; c=relaxed/simple;
	bh=ctfsacsK2Fl1aDVbBdpkGAYL0DhKf6KDkMkitlncA0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfYXMiSN9DQf6FgH9T8lat2AGBGhdxWww5WzjNY+inRWnESvTOG+fCeGpRyteUBW/EGVJTD19SnFHzexdW4wc6S9b/UeTrVxOfVjHKVbrNFZVNFspOMSJtT960lycMBEUVZkBwyWZjxUZzqUi+CHzIMd3ygWi4eA2QSr8MKzK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tQM26qnJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=67sic9kDkYzicepXGm+7JEs5NBMq9PIdJXSJlsR3EcY=; b=tQM26qnJmZk9l3AHOjQKFeP6TG
	LQYo3vg58KT3u2IQlf4GNt+YYG6MJDz6sX3AhHdcnPdw0tmRihRJhQesl1HIL8YLrtFKh7NwRJbXx
	YD/K9I1Wulj2ViAgt+O+0kHVR4rzT5Y2xwZugxvql0ytEq9rWHIk503O9auciTZl0/ULirrN5s2GX
	KxwmE87dLWIYVDj0CkuTXPbgacicKWp38/IEcgQ1gO5eGw2FU9ith+eZLh4CO9nyqYJR1Wxyty2Vq
	LpjBwdRM/s/ejo5i/klJHvUES2FJRrjuQ0kik7yKpKjwmqtoTcJvfo8VpxK0DFR5S0t8ERZp7WEJE
	go793xoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uiyyL-0000000D8Am-1uCv;
	Mon, 04 Aug 2025 17:27:41 +0000
Date: Mon, 4 Aug 2025 18:27:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Jan Kara <jack@suse.cz>, Sargun Dhillon <sargun@sargun.me>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250804172741.GZ222315@ZenIV>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
 <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
 <20250804155229.GY222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804155229.GY222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 04, 2025 at 04:52:29PM +0100, Al Viro wrote:
> On Mon, Aug 04, 2025 at 02:33:13PM +0200, Christian Brauner wrote:
> 
> > +       guard(spinlock)(&files->file_lock);
> >         err = expand_files(files, fd);
> >         if (unlikely(err < 0))
> > -               goto out_unlock;
> > -       return do_dup2(files, file, fd, flags);
> > +               return err;
> > +       err = do_dup2(files, file, fd, flags);
> > +       if (err < 0)
> > +               return err;
> > 
> > -out_unlock:
> > -       spin_unlock(&files->file_lock);
> > -       return err;
> > +       return 0;
> >  }
> 
> NAK.  This is broken - do_dup2() drops ->file_lock.  And that's why I
> loathe the guard() - it's too easy to get confused *and* assume that
> it will DTRT, no need to check carefully.

Note, BTW, that in actual replacing case do_dup2() has blocking
operations (closing the replaced reference) after dropping ->file_lock,
so making it locking-neutral would not be easy; doable (have it
return the old reference in the replacing case and adjust the callers
accordingly), but it's seriously not pretty (NULL/address of old file/ERR_PTR()
for return value, boilerplate in callers, etc.).  Having do_dup2() called
without ->file_lock and taking it inside is not an option - we could pull
expand_files() in there, but lookup of oldfd in actual dup2(2)/dup3(2) has
to be done within the same ->file_lock scope where it is inserted into the
table.

Sure, all things equal it's better to have functions locking-neutral, but
it's not always the best approach.  And while __free() allows for "we'd
passed the object to somebody else, it's not ours to consume anymore",
guard() does not.

