Return-Path: <linux-fsdevel+bounces-11107-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407F08511EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF58280CDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED18738DDB;
	Mon, 12 Feb 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Locg0NS6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B628387;
	Mon, 12 Feb 2024 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736297; cv=none; b=s2lRdRb2L7XDmUqKlneRQUeFDQTnazTG38phC6sHROf+wC6mXpzwGnXI0vzD50hCN3w6fOUPdTdCf4V/87A7Ke+B1b0A/Q7FiXlo43dK4KW5IF2GX5CsHFOZrI8YbB2OLmV0JeupWEFUhus+bKhS8xjWG7eFSYfg1q+Qzf5gap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736297; c=relaxed/simple;
	bh=fmFXpzMLiXEhfZ2iwoIMSDtmszK/t2dPiZLskOnlv0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kApFAu1Z8bLyEIGpmzPfqNcDSyumqb+4DDU+2PmEM85JL/58NyxAf/Xk1rpTiz6GAQ7+sywRY6+D6MWC0oE3ZQLHcfzcs+624BUTowDdTFTJJ1GHy06m5chGRKoD02torOwjoLRxjCLEHj9s3vXO42VgzLtc+JvmEG9lv8DCw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Locg0NS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F707C433F1;
	Mon, 12 Feb 2024 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707736296;
	bh=fmFXpzMLiXEhfZ2iwoIMSDtmszK/t2dPiZLskOnlv0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Locg0NS67Nd65HnzswOHyuI2e981RMHTJCEIP510Wwi7MgA6rWBOxQ7HnlxFa+xqH
	 8pee/Qt9be0vDo4pylorsBEjCejMAl32UH2+vCh50JE/0xiGlTJ8qxAcRoH29lncwg
	 vT4m2Eq3D9LNPaNZnq6bfBdrZcTolSsd2EKAT5OtlUrAIfdwiE/6zSGYoJYLILhu+t
	 KYCW8Y1UOk/7UV8VsaClH8FmVcQfrNa4aCox7a5VObBxL4ZttFaajd6JWYPNjFQixl
	 9Px88SujVIFZbt6qmWuKKmBL/u7+Jnn6DaKjct/ALjDKPnD2c3pH0qxZWfP+xNpbhA
	 5gETYGZqRUlKA==
Date: Mon, 12 Feb 2024 12:09:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, 
	Paul Moore <paul@paul-moore.com>, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 1/8] landlock: Add IOCTL access right
Message-ID: <20240212-gelungen-holzfiguren-3a07655ad780@brauner>
References: <20240209170612.1638517-1-gnoack@google.com>
 <20240209170612.1638517-2-gnoack@google.com>
 <ZcdYrJfhiNEtqIEW@google.com>
 <036db535-587a-4e1b-bd44-345af3b51ddf@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <036db535-587a-4e1b-bd44-345af3b51ddf@app.fastmail.com>

On Sat, Feb 10, 2024 at 12:49:23PM +0100, Arnd Bergmann wrote:
> On Sat, Feb 10, 2024, at 12:06, Günther Noack wrote:
> > On Fri, Feb 09, 2024 at 06:06:05PM +0100, Günther Noack wrote:
> >
> > The IOCTL command in question is FIONREAD: fs/ioctl.c implements
> > FIONREAD directly for S_ISREG files, but it does call the FIONREAD
> > implementation in the VFS layer for other file types.
> >
> > The question we are asking ourselves is:
> >
> > * Can we let processes safely use FIONREAD for all files which get
> >   opened for the purpose of reading, or do we run the risk of
> >   accidentally exposing surprising IOCTL implementations which have
> >   completely different purposes?
> >
> >   Is it safe to assume that the VFS layer FIONREAD implementations are
> >   actually implementing FIONREAD semantics?

Yes, otherwise this should considered a bug.

> >
> > * I know there have been accidental collisions of IOCTL command
> >   numbers in the past -- Hypothetically, if this were to happen in one
> >   of the VFS implementations of FIONREAD, would that be considered a
> >   bug that would need to get fixed in that implementation?
> 
> Clearly it's impossible to be sure no driver has a conflict
> on this particular ioctl, but the risk for one intentionally
> overriding it should be fairly low.
> 
> There are a couple of possible issues I can think of:
> 
> - the numeric value of FIONREAD is different depending
>   on the architecture, with at least four different numbers
>   aliasing to it. This is probably harmless but makes it
>   harder to look for accidental conflicts.
> 
> - Aside from FIONREAD, it is sometimes called SIOCINQ
>   (for sockets) or TIOCINQ (for tty). These still go
>   through the same VFS entry point and as far as I can
>   tell always have the same semantics (writing 4 bytes
>   of data with the count of the remaining bytes in the
>   fd).
> 
> - There are probably a couple of drivers that do something
>   in their ioctl handler without actually looking at
>   the command number.
> 
> If you want to be really sure you get this right, you
> could add a new callback to struct file_operations
> that handles this for all drivers, something like
> 
> static int ioctl_fionread(struct file *filp, int __user *arg)
> {
>      int n;
> 
>      if (S_ISREG(inode->i_mode))
>          return put_user(i_size_read(inode) - filp->f_pos, arg);
> 
>      if (!file->f_op->fionread)
>          return -ENOIOCTLCMD;
> 
>      n = file->f_op->fionread(filp);
> 
>      if (n < 0)
>          return n;
> 
>      return put_user(n, arg);
> }
> 
> With this, you can go through any driver implementing
> FIONREAD/SIOCINQ/TIOCINQ and move the code from .ioctl
> into .fionread. This probably results in cleaner code
> overall, especially in drivers that have no other ioctl
> commands besides this one.
> 
> Since sockets and ttys tend to have both SIOCINQ/TIOCINQ
> and SIOCOUTQ/TIOCOUTQ (unlike regular files), it's

I'm not excited about adding a bunch of methods to struct
file_operations for this stuff.

