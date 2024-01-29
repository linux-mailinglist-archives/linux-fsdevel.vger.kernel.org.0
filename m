Return-Path: <linux-fsdevel+bounces-9431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1661841315
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4121C234ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 19:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535C4C615;
	Mon, 29 Jan 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rIkU6Ws2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D9F3399F
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555370; cv=none; b=sBh5ZXMmZDDIZYypHuDr/4kixVuELZrzEWxdbV/nk7maOhRAruD8Rw+lMAWmP6oL6cQRz1IHLF/Q/zmbcbOPrS30RNe/7SaZINjHr1k4R35VP1YdxzJfytzt36bzrHsS7gCtOgJFxSqafs+3WdwcUPenmyhmEkEtI1bFpiHYQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555370; c=relaxed/simple;
	bh=511hvbc1Pbq2+EOuaGOVAprY+/qc4fIDXxmZ7B+0s2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hl/2x/gGECoKw85SoCSMyN8cI5FiS05mOlWPGvenO8x8lBlkuE0cDoSD//hWUcEE4cbe9OvoftyU9FFJZ51UkV3uoaWiEOt8WfSsEPGPIrg7IXzwWpxrfIBnMNOvZsLk6yHiTQRW+ETkOcC9dbZWQtymrCu+poBnjhZcosXQhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rIkU6Ws2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6de24201aa6so887111b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 11:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706555368; x=1707160168; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+pfwsAR7dQEMZaUbmAmf7P3tGpaqey93GDUy/LCXUY=;
        b=rIkU6Ws2QKHii+1VfbHJ2qXmJcqT+IfmpgjYD4xzI5MIRFiSvC+xRxCq3OP1SGpSgF
         4TglgnOJTGktPRPsH8rsgF7lN7JIo5WrTDlJVg1OO4glT8goQETCjiwYdIofMJ5z+XVc
         D3eVlvTYsLHUwtw4Ginkr08ZTdGu83VGHMZK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706555368; x=1707160168;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+pfwsAR7dQEMZaUbmAmf7P3tGpaqey93GDUy/LCXUY=;
        b=Q18zTzZfZ8SHwy0fHJrJIe1cE3yVZ2nW6hyne6XSIGL7fY0Ty7gINVZPuvvKlMhgp8
         IvQCffSCXDhaBkeG2Si7B4AkJzSWNZci3ovvhCFY2TkCkptYk4pX1WPPzvlyBgZN+UIk
         LwFAKKqpywE5J4phReoEcGkjgqeMHMCLlapVgZo+R/Uh8CHhL9qeI6Z6jnuiN9BPezo/
         O/zKPOwj27QNZSt4JBYxBqRIJ+hm5NhJIW5V+mGceRwCYipI7VFjx9EyaTtyWfbZjgBG
         4nWJL+aoOzVThMcrGR0oPj9JhDbyqpS85CcBj+0EHyNDmHpwRSej9OQyJPlJd4Bmtecb
         Nssg==
X-Gm-Message-State: AOJu0YwKxk0XASdws2kc8Cgl2Uv/j+M8kToC4mJOz7kscxx8JPsnveGD
	wltqLd/fJ2b5d9PGfoPRUCfWRn1CekfRJHVj53bTiSBnzuOKGgZ7xWF1d5YEhkk=
X-Google-Smtp-Source: AGHT+IESoPfU8AaOOY4JrFQlBadzLfIdEEVi2A6ryh3PYylu1gurZgUOMvs8PMQt3gmoBwZrfVF57g==
X-Received: by 2002:a05:6a00:939c:b0:6dd:8767:2fa1 with SMTP id ka28-20020a056a00939c00b006dd87672fa1mr4221676pfb.0.1706555367798;
        Mon, 29 Jan 2024 11:09:27 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id gu7-20020a056a004e4700b006db105027basm6234279pfb.50.2024.01.29.11.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jan 2024 11:09:27 -0800 (PST)
Date: Mon, 29 Jan 2024 11:09:23 -0800
From: Joe Damato <jdamato@fastly.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chuck.lever@oracle.com, jlayton@kernel.org,
	linux-api@vger.kernel.org, brauner@kernel.org, edumazet@google.com,
	davem@davemloft.net, alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com, kuba@kernel.org, weiwan@google.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Waterman <waterman@eecs.berkeley.edu>,
	Arnd Bergmann <arnd@arndb.de>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kara <jack@suse.cz>, Jiri Slaby <jirislaby@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Julien Panis <jpanis@baylibre.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	"(open list:FILESYSTEMS \\(VFS and infrastructure\\))" <linux-fsdevel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Steve French <stfrench@microsoft.com>,
	Thomas Huth <thuth@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH net-next v3 0/3] Per epoll context busy poll support
Message-ID: <20240129190922.GA1315@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <65b52d6381de7_3a9e0b2943d@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b52d6381de7_3a9e0b2943d@willemb.c.googlers.com.notmuch>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Sat, Jan 27, 2024 at 11:20:51AM -0500, Willem de Bruijn wrote:
> Joe Damato wrote:
> > Greetings:
> > 
> > Welcome to v3. Cover letter updated from v2 to explain why ioctl and
> > adjusted my cc_cmd to try to get the correct people in addition to folks
> > who were added in v1 & v2. Labeled as net-next because it seems networking
> > related to me even though it is fs code.
> > 
> > TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
> > epoll with socket fds.") by allowing user applications to enable
> > epoll-based busy polling and set a busy poll packet budget on a per epoll
> > context basis.
> > 
> > This makes epoll-based busy polling much more usable for user
> > applications than the current system-wide sysctl and hardcoded budget.
> > 
> > To allow for this, two ioctls have been added for epoll contexts for
> > getting and setting a new struct, struct epoll_params.
> > 
> > ioctl was chosen vs a new syscall after reviewing a suggestion by Willem
> > de Bruijn [1]. I am open to using a new syscall instead of an ioctl, but it
> > seemed that: 
> >   - Busy poll affects all existing epoll_wait and epoll_pwait variants in
> >     the same way, so new verions of many syscalls might be needed. It
> 
> There is no need to support a new feature on legacy calls. Applications have
> to be upgraded to the new ioctl, so they can also be upgraded to the latest
> epoll_wait variant.

Sure, that's a fair point. I think we could probably make reasonable
arguments in both directions about the pros/cons of each approach.

It's still not clear to me that a new syscall is the best way to go on
this, and IMO it does not offer a clear advantage. I understand that part
of the premise of your argument is that ioctls are not recommended, but in
this particular case it seems like a good use case and there have been
new ioctls added recently (at least according to git log).

This makes me think that while their use is not recommended, they can serve
a purpose in specific use cases. To me, this use case seems very fitting.

More of a joke and I hate to mention this, but this setting is changing how
io is done and it seems fitting that this done via an ioctl ;)

> epoll_pwait extends epoll_wait with a sigmask.
> epoll_pwait2 extends extends epoll_pwait with nsec resolution timespec.
> Since they are supersets, nothing is lots by limiting to the most recent API.
> 
> In the discussion of epoll_pwait2 the addition of a forward looking flags
> argument was discussed, but eventually dropped. Based on the argument that
> adding a syscall is not a big task and does not warrant preemptive code.
> This decision did receive a suitably snarky comment from Jonathan Corbet [1].
> 
> It is definitely more boilerplate, but essentially it is as feasible to add an
> epoll_pwait3 that takes an optional busy poll argument. In which case, I also
> believe that it makes more sense to configure the behavior of the syscall
> directly, than through another syscall and state stored in the kernel.

I definitely hear what you are saying; I think I'm still not convinced, but
I am thinking it through.

In my mind, all of the other busy poll settings are configured by setting
options on the sockets using various SO_* options, which modify some state
in the kernel. The existing system-wide busy poll sysctl also does this. It
feels strange to me to diverge from that pattern just for epoll.

In the case of epoll_pwait2 the addition of a new syscall is an approach
that I think makes a lot of sense. The new system call is also probably
better from an end-user usability perspective, as well. For busy poll, I
don't see a clear reasoning why a new system call is better, but maybe I am
still missing something.

> I don't think that the usec fine grain busy poll argument is all that useful.
> Documentation always suggests setting it to 50us or 100us, based on limited
> data. Main point is to set it to exceed the round-trip delay of whatever the
> process is trying to wait on. Overestimating is not costly, as the call
> returns as soon as the condition is met. An epoll_pwait3 flag EPOLL_BUSY_POLL
> with default 100us might be sufficient.
> 
> [1] https://lwn.net/Articles/837816/

Perhaps I am misunderstanding what you are suggesting, but I am opposed to
hardcoding a value. If it is currently configurable system-wide and via
SO_* options for other forms of busy poll, I think it should similarly be
configurable for epoll busy poll.

I may yet be convinced by the new syscall argument, but I don't think I'd
agree on imposing a default. The value can be modified by other forms of
busy poll and the goal of my changes are to:
  - make epoll-based busy poll per context
  - allow applications to configure (within reason) how epoll-based busy
    poll behaves, like they can do now with the existing SO_* options for
    other busy poll methods.

> >     seems much simpler for users to use the correct
> >     epoll_wait/epoll_pwait for their app and add a call to ioctl to enable
> >     or disable busy poll as needed. This also probably means less work to
> >     get an existing epoll app using busy poll.
> 

