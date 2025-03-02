Return-Path: <linux-fsdevel+bounces-42906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA0A4B326
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 17:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008D13B1510
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 16:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC431E9B32;
	Sun,  2 Mar 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMNHeEUy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85A1E9B21
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932996; cv=none; b=n2DXgXnak9Hq2dYglxG0tSwwCi5ALye36NeNYV5AD4ru1FNKHUoK0r4s1qPzJY7pezcV/wT9BOalHBwE6XCOPRLmh5iEtuQ+6zBnP1bK/OtIehL1OJAGtl0sTfypMSLrjqDTrCJYhQW6A7lefI6VJggeexckY0I0/xR1oKG2SIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932996; c=relaxed/simple;
	bh=OzOuIwcxbbKuAlBs5naAH6ms8oJXXOrqVbPvDqMYUao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZTug4pq6ZTLk7dkidKxwRM1LIpTbyQTQoymPeMTtuSRDBI2BwZ8SDEhSdy5Q4CoPW3a8SsVFffX+6m7MtP0WusS5OoGxXbblnezFxf/FHPzxX3YD1qnuwrj4pueRuNqTYkeQgzYWSK1UEkGH7sXEfVf/55PmYBWpGOc7xrUD2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMNHeEUy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95DCC4CED6;
	Sun,  2 Mar 2025 16:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740932995;
	bh=OzOuIwcxbbKuAlBs5naAH6ms8oJXXOrqVbPvDqMYUao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMNHeEUy+dIt8EBnFmMjrln/HDGGol2TsvfFwnUze+i5KL9k5gGrIrsEUXRx51Pl6
	 uIjI8f0i3mqZVB+fQL0X2XGCjXFz9BwlL5dXzVGOaPwD5UDo7GNkM89aeX2maTtTkg
	 5LvJSIUiglSwSFHT8IYI/WxPfQcjqj3cti2n9gofqicwBaifPDQt5YzCa6aFO+r0j0
	 xezUhXiJI6I2gARe0btmw4hZqrKALDfElVwmeb7RCwDV/2jnrNoR8UZLRZw7vVxApz
	 /oZLhv9UejcNIz7bv3SOrzris9EihJEqQjn6CNuVG8OPLw/FmZLihR6BO41vbt6t9i
	 VRtaXPIhRmlbw==
Date: Sun, 2 Mar 2025 17:29:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 03/10] pidfs: move setting flags into
 pidfs_alloc_file()
Message-ID: <20250302-barometer-niedrig-6c85afc8f398@brauner>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-3-5bd7e6bb428e@kernel.org>
 <20250302130936.GB2664@redhat.com>
 <20250302-erbsen-leihen-e30d8feff54e@brauner>
 <20250302160522.GE2664@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250302160522.GE2664@redhat.com>

On Sun, Mar 02, 2025 at 05:05:23PM +0100, Oleg Nesterov wrote:
> On 03/02, Christian Brauner wrote:
> >
> > On Sun, Mar 02, 2025 at 02:09:36PM +0100, Oleg Nesterov wrote:
> > > On 02/28, Christian Brauner wrote:
> > > >
> > > > @@ -696,6 +696,10 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
> > > >  		return ERR_PTR(ret);
> > > >
> > > >  	pidfd_file = dentry_open(&path, flags, current_cred());
> > > > +	/* Raise PIDFD_THREAD explicitly as dentry_open() strips it. */
> > >                                             ^^^^^^^^^^^^^^^^^^^^^^^
> > > Hmm, does it?
> > >
> > > dentry_open(flags) just passes "flags" to alloc_empty_file()->init_file(),
> > > and init_file(flags) does
> > >
> > > 	f->f_flags      = flags;
> > >
> >
> > dentry_open()
> > -> do_dentry_open()
> >    {
> >            f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> 
> Ah, indeed, thanks ;) so perhaps you can update the comment,
> s/dentry_open/do_dentry_open/ to make it more clear?

Will do!

