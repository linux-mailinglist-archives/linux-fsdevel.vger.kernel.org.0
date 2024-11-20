Return-Path: <linux-fsdevel+bounces-35310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051EF9D3948
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9754AB2E0CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F8F19E994;
	Wed, 20 Nov 2024 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkcAN8OR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CE18660C;
	Wed, 20 Nov 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101185; cv=none; b=sYbDw5a2fipSN8NRfM27aqslIXHTcAEA2T3QvV1LnkDzvX3OrevxgvgBpa38BQGIabfOkloRADKU7Hwoebj/M4BLBqEGzXc91y2/n4LDfVvyOqAyGKS7oo2UmdtiPywOKJ6K3WVbr7huYWlaN9mKXuJ+Scav1HmTiFbgDVnPWZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101185; c=relaxed/simple;
	bh=1tK3mNV1medkTsrWi5AOiq1g0g7TLImk9SIlS9oUxJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxK5RTalPqPWQ2Dixq6TYn/5lfuCL7Gw88bOmIv67VckKJ+f2a0r0Y3XnqGvazi8VJgiwgRvTukkyJfkN75SnGHpoQYg3nZeh7uLEshl/FEb1mulFmU1od3ya9c2nv1XfqSYpJMnUUD8tR7YWqn9vLm711be+y9QYVZ0S2f+dAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkcAN8OR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D68C4CECD;
	Wed, 20 Nov 2024 11:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732101184;
	bh=1tK3mNV1medkTsrWi5AOiq1g0g7TLImk9SIlS9oUxJg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkcAN8ORF74aFH3WrhIEDG3ZIdnSG/SKW8//csuqj/WcsBLygQBVoNcBmyoCGxGlc
	 2A72KH31KkIJypBqxHI9U0Nxox229R9R6hVb4Pco2D1I28DGYpYSCWzW/LFt01qbT7
	 PmeTSCHkof9GvT1STlNmnavoSonRCupTOfca3V64uDCh/DBsc6btugI4hl/iiZfGgK
	 5hftA8xbK63wx/QfUA4sWwSCTd2iwaeRl2/2uL7bwCrYi4zmJXCxofkR3z/Pm+EOUJ
	 YwGJ4VZx4Cka/mRiwdPe5pUFmCZziCl1FYrdbK7vLdaOv60la3lRAHTyLqFyU3mByo
	 BotohyMqUeFyA==
Date: Wed, 20 Nov 2024 12:12:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, hughd@google.com, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] symlink length caching
Message-ID: <20241120-eisbahn-frost-824303fa16d9@brauner>
References: <20241119094555.660666-1-mjguzik@gmail.com>
 <20241120-werden-reptil-85a16457b708@brauner>
 <CAGudoHGOC6to4_nJX9vhWV8HnF19U2xmmZY3Nc0ZbZnyTtGyxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGOC6to4_nJX9vhWV8HnF19U2xmmZY3Nc0ZbZnyTtGyxw@mail.gmail.com>

On Wed, Nov 20, 2024 at 11:42:33AM +0100, Mateusz Guzik wrote:
> On Wed, Nov 20, 2024 at 11:33 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Nov 19, 2024 at 10:45:52AM +0100, Mateusz Guzik wrote:
> > > quote:
> > >     When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
> > >     speed up when issuing readlink on /initrd.img on ext4.
> > >
> > > Benchmark code at the bottom.
> > >
> > > ext4 and tmpfs are patched, other filesystems can also get there with
> > > some more work.
> > >
> > > Arguably the current get_link API should be patched to let the fs return
> > > the size, but that's not a churn I'm interested into diving in.
> > >
> > > On my v1 Jan remarked 1.5% is not a particularly high win questioning
> > > whether doing this makes sense. I noted the value is only this small
> > > because of other slowdowns.
> >
> > The thing is that you're stealing one of the holes I just put into struct
> > inode a cycle ago or so. The general idea has been to shrink struct
> > inode if we can and I'm not sure that caching the link length is
> > actually worth losing that hole. Otherwise I wouldn't object.
> >
> 
> Per the patch description this can be a union with something not used
> for symlinks. I'll find a nice field.

Ok!

> 
> > > All that aside there is also quite a bit of branching and func calling
> > > which does not need to be there (example: make vfsuid/vfsgid, could be
> > > combined into one routine etc.).
> >
> > They should probably also be made inline functions and likely/unlikely
> > sprinkled in there.
> 
> someone(tm) should at least do a sweep through in-vfs code. for

Yeah, in this case I was specifically talking about make_vfs{g,u}id().
They should be inlines and they should contain likely/unlikely.

> example LOOKUP_IS_SCOPED is sometimes marked as unlikely and other
> times has no annotations whatsoever, even though ultimately it all
> executes in the same setting
> 
> Interestingly even __read_seqcount_begin (used *twice* in path_init())
> is missing one. I sent a patch to fix it long time ago but the
> recipient did not respond

I snatched it.

