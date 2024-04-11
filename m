Return-Path: <linux-fsdevel+bounces-16658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE2A8A0BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A30B1C21D66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41CA142E65;
	Thu, 11 Apr 2024 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0De4/C7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B6140396;
	Thu, 11 Apr 2024 09:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712826305; cv=none; b=DnlQmxIh1ELqNhvYfuDQGx/tbcYCIO/62N3D1L08ykvwCvsMoODDK+7mv1Nziz1DDzqPwKt3f92wzGJONfyVb8cGQbECYxpfGfvGNWlP72LrMLqh9cyHYD+mO8cRnH+tKMWn+4v4Rk4eXkFcSQlowdY8wCHatv1BDrdws3GtN94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712826305; c=relaxed/simple;
	bh=o+/0y3Ieo193BWmJYH5o8du85gicknBAkm/zQSbBIY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMY4Y1MCkXWoSX/liGxD0nBNEnqrKInP8RiVTLUmgS4DJDuhJsdE8ND5wo8BOiWbmKycoSgbL0Fpv3U5kn+Xu3q6t6V7omg4rQkBdvnoSMt6HDAjVAcMVy42x2iM+906YPqvaAc0IY/nOHhXSTLtL68Wyo4NfZyW33Ti5svdGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0De4/C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A143C433F1;
	Thu, 11 Apr 2024 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712826304;
	bh=o+/0y3Ieo193BWmJYH5o8du85gicknBAkm/zQSbBIY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T0De4/C7NxC5OdeB2sTjskbPNWWhQYBx5GyPYMEXilDrUsLdGguuBlEEB69qbIhYc
	 pZ8Qc03Uc1uG0EbrSw3CASE+kcASpvWbKQ/IhHmHqAO5hZcZMcFsKN1+UAh27fMzA7
	 yc4TEQW3Otnplxqt1EUwLcS6nFEcva2IbtZcwiyJa79420u5eqJE8f1Yfhve2op0fb
	 wK4+Uab/js5XcL0UUok3DThHW8ItWNVaX87IyEe4SHdvaUDKYSlV2MX0DjXBG5UXRi
	 32/VBO49xp5Jiri3T2g6rlhyYobGqMkQRfkrwChjpRt3fIxnivD8TSRZNNm9Jyx5kI
	 yogJBhp0QpY6A==
Date: Thu, 11 Apr 2024 11:04:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() -
 requirements
Message-ID: <20240411-alben-kocht-219170e9dc99@brauner>
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>

On Wed, Apr 10, 2024 at 07:39:49PM -0700, Linus Torvalds wrote:
> On Wed, 10 Apr 2024 at 17:10, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > +               if (flags & LOOKUP_DFD_MATCH_CREDS) {
> > +                       if (f.file->f_cred != current_cred() &&
> > +                           !capable(CAP_DAC_READ_SEARCH)) {
> > +                               fdput(f);
> > +                               return ERR_PTR(-ENOENT);
> > +                       }
> > +               }
> 
> Side note: I suspect that this could possibly be relaxed further, by
> making the rule be that if something has been explicitly opened to be
> used as a path (ie O_PATH was used at open time), we can link to it
> even across different credentials.

I had a similar discussion a while back someone requested that we relax
permissions so linkat can be used in containers. And I drafted the
following patch back then:

https://lore.kernel.org/all/20231113-undenkbar-gediegen-efde5f1c34bc@brauner

IOW, I had intended to make this work with containers so that we check
CAP_DAC_READ_SEARCH in the namespace of the opener of the file. My
thinking had been that this can serve as a way to say "Hey, I could've
opened this file in the openers namespace therefore let me make a path
to it.". I didn't actually send it because I thought the original author
would but imho, that would be a worthwhile addition to your patch if
this makes sense...

> 
> IOW, the above could perhaps even be
> 
> +               if (flags & LOOKUP_DFD_MATCH_CREDS) {
> +                       if (!(f.file->f_mode & FMODE_PATH) &&
> +                           f.file->f_cred != current_cred() &&
> +                           !capable(CAP_DAC_READ_SEARCH)) {
> +                               fdput(f);
> +                               return ERR_PTR(-ENOENT);
> +                       }
> +               }
> 
> which would _allow_ people to pass in paths as file descriptors if
> they actually wanted to.
> 
> After all, the only thing you can do with an O_PATH file descriptor is
> to use it as a path - there would be no other reason to use O_PATH in
> the first place. So if you now pass it to somebody else, clearly you
> are intentionally trying to make it available *as* a path.
> 
> So you could imagine doing something like this:
> 
>          // Open path as root
>          int fd = open('filename", O_PATH);
> 
>         // drop privileges
>         // setresuid(..) or chmod() or enter new namespace or whatever
> 
>         linkat(fd, "", AT_FDCWD, "newname", AT_EMPTY_PATH);
> 
> and it would open the path with one set of privileges, but then
> intentionally go into a more restricted mode and create a link to the
> source within that restricted environment.
> 
> Sensible? Who knows. I'm just throwing this out as another "this may
> be the solution to our historical flink() issues".
> 
>            Linus

