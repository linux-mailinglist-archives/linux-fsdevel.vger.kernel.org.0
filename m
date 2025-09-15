Return-Path: <linux-fsdevel+bounces-61368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BADB57AB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 792394E1FBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611DF309DA1;
	Mon, 15 Sep 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOL987am"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595E3002A0;
	Mon, 15 Sep 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938921; cv=none; b=Ys44g4j9p48S7lsTSEM1ugYQVG2dY03PN4ajKFF6zwRE8b5JYnXpLkGGNqgpLxVMbolTBrl/8nd31gF5f3m7gVgNeV8BxZUsR0cZuuAQdPNkwLuVnVt6/Vx85m1RqG6qqm6VqVxDWODd1fkPjG4TEKyC73epkofCjuYGRbC1yRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938921; c=relaxed/simple;
	bh=wqChBPKYTZwSBTY+wUKCdLB+xWLXUmuk7h+6PsQOCpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5sooY//eUl3bPwy5U39CuFdtXY1fiOQ6LWsUY9DUEvqIwo0t69Z2GiuvkYP+U7rcdzSnZAmRNuEvzGDEJLQ29JOFoK0DeboBh1F02UlDr1T9kHLhL0zmusc0F89pxIaD8moBxxNZkrUiWQMcsf1R1HMT2rfUY7M3cZ7FhMWALM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOL987am; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A042AC4CEF5;
	Mon, 15 Sep 2025 12:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938921;
	bh=wqChBPKYTZwSBTY+wUKCdLB+xWLXUmuk7h+6PsQOCpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOL987am8SHXNwbrbwaJ5504uBX2I9gN6ifz1m9Ju66XJT9O7+SZpjuI7eYH13YjN
	 Xj0PK3EpBP+iWwdxlzUIIS1yoOojz/bL/wTP2z5X/yDfL8ZJaOehdhZBTPsRzOpjhI
	 +pF+TBBqbTfJUdRGgK+nRziNEqv3YJQYxKpyFi59vXWvNYcVWUY9DIDJSaWHTGVSDo
	 PUgCOrmwV98dNRKaR0WEHE+C2SJELgHAK54axLhy13ktSvLJ2Y3gfLHpTpIVnYXUbQ
	 UUCCUb4BKYFKyUeTw1aF/GFS3REWkuouzypruNMeyQx/XjSWYRoRzLj+QRmxwJ8T0D
	 ub3YwUWBPZqSA==
Date: Mon, 15 Sep 2025 14:21:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Mark Tinguely <mark.tinguely@oracle.com>, ocfs2-devel@lists.linux.dev, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	jlbec@evilplan.org, mark@fasheh.com, willy@infradead.org, david@fromorbit.com
Subject: Re: [External] : [PATCH] ocfs2: retire ocfs2_drop_inode() and
 I_WILL_FREE usage
Message-ID: <20250915-anlocken-brummen-b86b3cba8ccf@brauner>
References: <f3671198-5231-41cf-b0bc-d1280992947a@oracle.com>
 <CAGudoHHT=P_UyZZpx5tBRHPE+irh1b7PxFXZAHjdHNLcEWOxAQ@mail.gmail.com>
 <8ddcaa59-0cf0-4b7c-a121-924105f7f5a6@linux.alibaba.com>
 <rvavp2omizs6e3qf6xpjpycf6norhfhnkrle4fq4632atgar5v@dghmwbctf2mm>
 <f9014fdb-95c8-4faa-8c42-c1ceea49cbd9@linux.alibaba.com>
 <fureginotssirocugn3aznor4vhbpadhwy7fhaxzeullhrzp7y@bg5gzdv6mrif>
 <CAGudoHGui53Ryz1zunmd=G=Rr9cZOsWPFW7+GGBmxN4U_BNE4A@mail.gmail.com>
 <tmovxjz7ouxzj5r2evjjpiujqeod3e22dtlriqqlgqwy4rnoxd@eppnh4jf72dq>
 <CAGudoHHNhf2epYMLwmna3WVvbMuiHFmPX+ByVbt8Qf3Dm4QZeg@mail.gmail.com>
 <CAGudoHEBDA1XKu8WTPQ4Nn+GTUWg_FMUavcAddBQ=5doY1aQxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEBDA1XKu8WTPQ4Nn+GTUWg_FMUavcAddBQ=5doY1aQxw@mail.gmail.com>

On Tue, Sep 09, 2025 at 11:57:11AM +0200, Mateusz Guzik wrote:
> On Tue, Sep 9, 2025 at 11:52 AM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Tue, Sep 9, 2025 at 11:51 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Mon 08-09-25 17:39:22, Mateusz Guzik wrote:
> > > > I think generic_delete_inode is a really bad name for what the routine
> > > > is doing and it perhaps contributes to the confusion in the thread.
> > > >
> > > > Perhaps it could be renamed to inode_op_stub_always_drop or similar? I
> > > > don't for specifics, apart from explicitly stating that the return
> > > > value is to drop and bonus points for a prefix showing this is an
> > > > inode thing.
> > >
> > > I think inode_always_drop() would be fine...
> >
> > sgtm. unfortunately there are quite a few consumers, so I don't know
> > if this is worth the churn and consequently I'm not going for it.
> >
> > But should you feel inclined... ;-)
> 
> Actually got one better: inode_just_drop(), so that it is clear this
> is not doing anything else.

That's a simple git sed tbh. Just send it to me this week. All big
changes should be done by now.

