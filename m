Return-Path: <linux-fsdevel+bounces-48184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2595AABD0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC183AAF9D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66424BBEE;
	Tue,  6 May 2025 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HM0hQepd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3352219A70;
	Tue,  6 May 2025 08:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519861; cv=none; b=R+Kj1k3YqeFJYfRnaiu4XSb8WMaMQX1Dq0xEnto3l9vJvPXnkciB4EkbBiXTYfwDG4njgzU7B8i7sYGDEkAdOECxxkZ4xHjXpnXajVWLP/FxEFYat3n8RcKLnHfZ/z40xXIKyAz76xqwD8PfNrzTbaJUk6ob0pc+MXGxsrsYZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519861; c=relaxed/simple;
	bh=lBTnRAFU0jsKirdN/eSj6PpIDMSdkp6AzoPeP/dvL18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHGCFpYEFad1TgDbNfgkD+MJ0K9X68SgGSlqTuSJSSVjvFPyPebH67mfzSmnrGknbPVZPljS+iFmfSXA3KyokNDwQeG9n6i1x+pX1CDMM0xtgC463Mnpi07t2m1bIECh0CFFUlqWz20RvPh5fTb1kkJ3gfgXbJFxgi3JF7kEMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HM0hQepd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E74C4CEED;
	Tue,  6 May 2025 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746519859;
	bh=lBTnRAFU0jsKirdN/eSj6PpIDMSdkp6AzoPeP/dvL18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HM0hQepdvOerw0p1YZTCd+c8nmAGgz/75a1BgRUXFSbVJAWTTrJ3NgFMKwgVs6EUV
	 2owTIDRf/872CL8P3sUQ9wxxva/29k5mFyC2GbL6ZP/I6wxKCZFeE5hc9fuj9YOAtz
	 t0PdEjfA0P1OMz22MP+jlLnsG4b5AEETJI4TShsenJK1HGHoOv9JlBtPKG8rsHtRbI
	 YolFohh4DZk2pHHNWKDAbQHCOcqULKzPiilzTlMpgBydsvtYmod2EWLFmZJD7+u3xH
	 SCk9ltLmB1o35CYp6yqRNRjH3mJj+lpWBSO9A3sEZLbHA/aL2KiuvSAoFxzxHYIL8Y
	 Eu5XOTnOMnioA==
Date: Tue, 6 May 2025 10:24:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexander@mihalicyn.com, bluca@debian.org, daan.j.demeyer@gmail.com, 
	davem@davemloft.net, david@readahead.eu, edumazet@google.com, horms@kernel.org, 
	jack@suse.cz, jannh@google.com, kuba@kernel.org, lennart@poettering.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, me@yhndnzj.com, 
	netdev@vger.kernel.org, oleg@redhat.com, pabeni@redhat.com, viro@zeniv.linux.org.uk, 
	zbyszek@in.waw.pl
Subject: Re: [PATCH RFC v3 04/10] coredump: add coredump socket
Message-ID: <20250506-pilze-wegstecken-1d792c7b79b7@brauner>
References: <20250505-work-coredump-socket-v3-4-e1832f0e1eae@kernel.org>
 <20250505184847.15534-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250505184847.15534-1-kuniyu@amazon.com>

On Mon, May 05, 2025 at 11:48:43AM -0700, Kuniyuki Iwashima wrote:
> From: Christian Brauner <brauner@kernel.org>
> Date: Mon, 05 May 2025 13:13:42 +0200
> > @@ -801,6 +846,40 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> >  		}
> >  		break;
> >  	}
> > +	case COREDUMP_SOCK: {
> > +		struct file *file __free(fput) = NULL;
> > +#ifdef CONFIG_UNIX
> > +		struct socket *socket;
> > +
> > +		/*
> > +		 * It is possible that the userspace process which is
> > +		 * supposed to handle the coredump and is listening on
> > +		 * the AF_UNIX socket coredumps. Userspace should just
> > +		 * mark itself non dumpable.
> > +		 */
> > +
> > +		retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
> > +		if (retval < 0)
> > +			goto close_fail;
> > +
> > +		file = sock_alloc_file(socket, 0, NULL);
> > +		if (IS_ERR(file)) {
> > +			sock_release(socket);
> > +			retval = PTR_ERR(file);
> > +			goto close_fail;
> > +		}
> > +
> > +		retval = kernel_connect(socket,
> > +					(struct sockaddr *)(&coredump_unix_socket),
> > +					COREDUMP_UNIX_SOCKET_ADDR_SIZE, 0);
> 
> This blocks forever if the listener's accept() queue is full.
> 
> I think we don't want that and should pass O_NONBLOCK.
> 
> To keep the queue clean is userspace responsibility, and we don't
> need to care about a weird user.

That seems fine to me. I've changed that.

