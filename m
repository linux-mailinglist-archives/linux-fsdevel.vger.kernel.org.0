Return-Path: <linux-fsdevel+bounces-22510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C39A918207
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A31B25521
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 13:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE0184104;
	Wed, 26 Jun 2024 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fga8Ux79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795281891B8;
	Wed, 26 Jun 2024 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407407; cv=none; b=Fb/udPp6z89T1qBeJbp1i5HRNm38mhF1xvr6/s004BmI+kREi4HnVEUETTqVzqaDrMLUTAwJxqBtPMGbiJXfiTpLZBwrViDdmjxVYhmbQW4G2xKBlnN5gTvFoz0SlusSl3rSYDb0u81Nbnz2csbt+nPx/llANM/PYfV10xUI5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407407; c=relaxed/simple;
	bh=jK/3QtruOsnXjjBSZNkqfDNubM1EGnFDWABJ0MLfuGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bd9yVfNiDVJFXZnSIAYmy/6Igi98hrl7mGaZuFYxl9sRDe0LbAY6j/AGnenmlzcCys+sJkNhJxW3mUMvCCjf4dvJVcA+YrjG5RAF8yE/LRSJ5/nNl42hT0bnEqYlkELRiiT3BL2L/XAWiJxXCpvJ9JST5pwqAyAW2RGHZvxmsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fga8Ux79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30868C2BD10;
	Wed, 26 Jun 2024 13:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719407407;
	bh=jK/3QtruOsnXjjBSZNkqfDNubM1EGnFDWABJ0MLfuGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fga8Ux79LCwSYWL5W8BEDbjd/EVwvBQFUbfCSAOsqmL5usSX01jW7Tu6ms/vUuwZT
	 Kahd3vVVGQRtxkZBp5w6i8srse17KyjUnckQen5RmxWAT2xC6U2s+MmfCokqCI/Kxt
	 vC5AGi+xkKhzWgdkCupm25msgSM+QHR2ArD8TxEW2afJI212Gm9OjCCuK943f5M5wT
	 bypIwY3vRcrzaabm9L5J+ov4V9+7PMuqSJA6U9SIR1IkR6jJBOON2mfr7WcasZA+Mr
	 ky5sBz1suFco7veDhkaxvKj6MQXfLpqEuUz7ZK6IstiGgm+6RwuoCJIsVOG5L0fgCT
	 duu1K0GQpLJJQ==
Date: Wed, 26 Jun 2024 15:10:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Yu Ma <yu.ma@intel.com>, 
	viro@zeniv.linux.org.uk, edumazet@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com, 
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 3/3] fs/file.c: remove sanity_check from alloc_fd()
Message-ID: <20240626-rohstoff-robben-dfde8cc3f309@brauner>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-4-yu.ma@intel.com>
 <20240625120834.rhkm3p5by5jfc3bw@quack3>
 <CAGudoHGYQwigyQSqm97zyUafxaOCo0VoHZmcYzF1KtqmX=npUg@mail.gmail.com>
 <CAGudoHH4ixO6n2BgMGx7EEYvLS2Agb8WBz_RM55HjCWBQ5tMLg@mail.gmail.com>
 <20240625133031.jjew3uevvrgwgviw@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625133031.jjew3uevvrgwgviw@quack3>

On Tue, Jun 25, 2024 at 03:30:31PM GMT, Jan Kara wrote:
> On Tue 25-06-24 15:11:23, Mateusz Guzik wrote:
> > On Tue, Jun 25, 2024 at 3:09 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > On Tue, Jun 25, 2024 at 2:08 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Sat 22-06-24 11:49:04, Yu Ma wrote:
> > > > > alloc_fd() has a sanity check inside to make sure the struct file mapping to the
> > > > > allocated fd is NULL. Remove this sanity check since it can be assured by
> > > > > exisitng zero initilization and NULL set when recycling fd.
> > > >   ^^^ existing  ^^^ initialization
> > > >
> > > > Well, since this is a sanity check, it is expected it never hits. Yet
> > > > searching the web shows it has hit a few times in the past :). So would
> > > > wrapping this with unlikely() give a similar performance gain while keeping
> > > > debugability? If unlikely() does not help, I agree we can remove this since
> > > > fd_install() actually has the same check:
> > > >
> > > > BUG_ON(fdt->fd[fd] != NULL);
> > > >
> > > > and there we need the cacheline anyway so performance impact is minimal.
> > > > Now, this condition in alloc_fd() is nice that it does not take the kernel
> > > > down so perhaps we could change the BUG_ON to WARN() dumping similar kind
> > > > of info as alloc_fd()?
> > > >
> > >
> > > Christian suggested just removing it.
> > >
> > > To my understanding the problem is not the branch per se, but the the
> > > cacheline bounce of the fd array induced by reading the status.
> > >
> > > Note the thing also nullifies the pointer, kind of defeating the
> > > BUG_ON in fd_install.
> > >
> > > I'm guessing it's not going to hurt to branch on it after releasing
> > > the lock and forego nullifying, more or less:
> > > diff --git a/fs/file.c b/fs/file.c
> > > index a3b72aa64f11..d22b867db246 100644
> > > --- a/fs/file.c
> > > +++ b/fs/file.c
> > > @@ -524,11 +524,11 @@ static int alloc_fd(unsigned start, unsigned
> > > end, unsigned flags)
> > >          */
> > >         error = -EMFILE;
> > >         if (fd >= end)
> > > -               goto out;
> > > +               goto out_locked;
> > >
> > >         error = expand_files(files, fd);
> > >         if (error < 0)
> > > -               goto out;
> > > +               goto out_locked;
> > >
> > >         /*
> > >          * If we needed to expand the fs array we
> > > @@ -546,15 +546,15 @@ static int alloc_fd(unsigned start, unsigned
> > > end, unsigned flags)
> > >         else
> > >                 __clear_close_on_exec(fd, fdt);
> > >         error = fd;
> > > -#if 1
> > > -       /* Sanity check */
> > > -       if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
> > > +       spin_unlock(&files->file_lock);
> > > +
> > > +       if (unlikely(rcu_access_pointer(fdt->fd[fd]) != NULL)) {
> > >                 printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> > > -               rcu_assign_pointer(fdt->fd[fd], NULL);
> > >         }
> > > -#endif
> > 
> > Now that I sent it it is of course not safe to deref without
> > protection from either rcu or the lock, so this would have to be
> > wrapped with rcu_read_lock, which makes it even less appealing.
> > 
> > Whacking the thing as in the submitted patch seems like the best way
> > forward here. :)
> 
> Yeah, as I wrote, I'm fine removing it, in particular if Christian is of
> the same opinion. I was more musing about whether we should make the check
> in fd_install() less aggressive since it is now more likely to trigger...

We could change it to WARN_ON() and then people can get BUG_ON()
behavior when they turn WARN into BUG which apparently is a thing that
we support.

