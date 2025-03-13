Return-Path: <linux-fsdevel+bounces-43884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CEBA5EE97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D074B3B2FE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1072641D5;
	Thu, 13 Mar 2025 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmSuLQqD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F514263F35;
	Thu, 13 Mar 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856126; cv=none; b=jKsSaYuPGrmndYaBq2CaS1lvW+rfGo+I0IMu1XLI2a9+a3a3vKvCfehe3xE8GFBMAPTbkLAbbNPQDIC+MrLHD6FjE3IUd8JbDB39IKH/Nul/qMxSubZSoW/HA2W/dCPhtQH7nWQ4lTYszMl3ax52t5WIQC7CXTPopAhyaYICtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856126; c=relaxed/simple;
	bh=Khg9W2offMS1wtesP5x0nwj9KQm+80HBQi3YVnQnuKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGah1ZUGOM7OeJphGJEIxdSgVbedA2KvOp4dZhYbwofS4f29ARx17d1pEAFoYD0s1QOZEKlsom36PTuvXuzqUfbHAoNhudJ1ADHhp8yUolRBAD0FpUjY5mWfNBBd/8OYd8oScE91jfNDSXksdXbp2xpO/J67ApGfEMCj0PedV6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmSuLQqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6C7C4CEE3;
	Thu, 13 Mar 2025 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856125;
	bh=Khg9W2offMS1wtesP5x0nwj9KQm+80HBQi3YVnQnuKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmSuLQqDjpJj9Z4YYsn5v43IbfdoQ+Ompp/WNlil3vR1uINTcWqpiDd2oPltWcwML
	 Q0GNX9CHp77ZwhmtIkM79IOnLPiVJae6wOAZBeyBo4KFR3B88cqK2fxYDHhnzCI2Xw
	 V7pJhHBcJv7aRvD6I9CJIDNFN7OPr+uZ+2gqH3RW5Nl3EBRpFl2N5+BDs+KSfPTzG4
	 uHg7iGq6lGCu8FyWEVqJamlvNEGNidYBVWuj6AELnPwfvS9RAyUUdUt/Qj23pDS+V+
	 nNNNldXuDXh8Le79R2zkS/yoXryeticYplCtP+sx8iGkTc1BS29SdDagrrvRsVj587
	 TOGZEQGYVg31A==
Date: Thu, 13 Mar 2025 09:55:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: use debug-only asserts around fd allocation and
 install
Message-ID: <20250313-rufnummer-fehlen-1184066edf75@brauner>
References: <20250312161941.1261615-1-mjguzik@gmail.com>
 <CAGudoHFH70YpLYXnhJq4MDtjJ6FiY59Xn-D_kTB9xsE2UTJD_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFH70YpLYXnhJq4MDtjJ6FiY59Xn-D_kTB9xsE2UTJD_g@mail.gmail.com>

On Wed, Mar 12, 2025 at 06:21:01PM +0100, Mateusz Guzik wrote:
> On Wed, Mar 12, 2025 at 5:19 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > This also restores the check which got removed in 52732bb9abc9ee5b
> > ("fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()")
> > for performance reasons -- they no longer apply with a debug-only
> > variant.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > I have about 0 opinion whether this should be BUG or WARN, the code was
> > already inconsistent on this front. If you want the latter, I'll have 0
> > complaints if you just sed it and commit as yours.
> >
> > This reminded me to sort out that litmus test for smp_rmb, hopefully
> > soon(tm) as it is now nagging me.
> >
> >  fs/file.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index 6c159ede55f1..09460ec74ef8 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -582,6 +582,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
> >
> >         __set_open_fd(fd, fdt, flags & O_CLOEXEC);
> >         error = fd;
> > +       VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
> >
> 
> when restoring this check i dutifully copy-pasted the original. I only
> now mentally registered it uses a rcu primitive to do the load, while
> the others do a plain load. arguably the former is closer to being
> correct and it definitely does not hurt
> 
> so this line should replace the other 2 lines below. i can send a v2
> to that effect, but given the triviality of the edit, perhaps you will
> be happy to sort it out

Yes, sure. Done!

