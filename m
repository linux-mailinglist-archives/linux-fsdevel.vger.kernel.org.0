Return-Path: <linux-fsdevel+bounces-31518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24EC998035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 10:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25171C22369
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 08:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E891BFE0B;
	Thu, 10 Oct 2024 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnqejGhS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D351BC9E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548018; cv=none; b=UMfcGdeyJHUk4M/oP50JYwmgjfwwi17kL5p5puWKA/olfw7uuQi4C/kVx7vIZVaVesr+frhfyCLkW8M1W8knBPWtAcBofg0cPa2YSdB/TmGgyJPJVeMxR9u3ubT3sQSo7gbIR6vmyLupetjMHOHupu5r6md+Qt0Py+C1razttCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548018; c=relaxed/simple;
	bh=kOEHEsKub5YZo4OOeERPb7ktkRMSNCFMxDKA/+xSCvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqBCEfQVtBYlQswib2sdd87hJv2nO2tnEabsnyjyzAXLrEDQqiPh8JhC0ECa1Q2zBu+R+s/tsqpLZYUP4vYrM7sBw0fzYIkTSkg8Y/qzg5HHTpb6Yb1n0ivRz1zU7K6HvU9WKEWKvwtHFDKhHLS/acngbgBe087r0calr4vFhxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnqejGhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFE4C4CEC5;
	Thu, 10 Oct 2024 08:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728548017;
	bh=kOEHEsKub5YZo4OOeERPb7ktkRMSNCFMxDKA/+xSCvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LnqejGhSS6xux8JFbbi7V06Y9rDaftd6qNiuB+IiNxXHWkSDUQ8mWfhONlYL51j+C
	 WQ6G44AdoqlkorvesSDAODScgkpWNu88KQBhEGo8yY9f+GuDWuQV+i4+Dx3aeSGOAE
	 Mp0A4ZUe1Z9TNjDnJUfsJvJicsinkkRGs4HbFxIjNnr+VP2wYVscvNQ/QQTe+9o3iM
	 yy0RncbtM5VvcnlW/fPjvO8kO6u51xXr8EdJPfOkRXxcbJwdUYe2KMpuQ1Z/13gIUZ
	 Obbwtqz5r9MYhwxO8So6vYA/BR/NU9owT0b0dE0/Xe42PnHC3Z9TytgTUI+EVAAbE5
	 9smoAKguZXHZg==
Date: Thu, 10 Oct 2024 10:13:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Price <steven.price@arm.com>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v3 10/11] make __set_open_fd() set cloexec state as well
Message-ID: <20241010-selber-bratkartoffeln-560bedeeda53@brauner>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
 <20241007174358.396114-10-viro@zeniv.linux.org.uk>
 <f042b2db-df1f-4dcb-8eab-44583d0da0f6@arm.com>
 <20241009-unsachlich-otter-d17f60a780ba@brauner>
 <20241009152411.GZ4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009152411.GZ4017910@ZenIV>

On Wed, Oct 09, 2024 at 04:24:11PM +0100, Al Viro wrote:
> On Wed, Oct 09, 2024 at 04:19:47PM +0200, Christian Brauner wrote:
> > On Wed, Oct 09, 2024 at 11:50:36AM GMT, Steven Price wrote:
> > > On 07/10/2024 18:43, Al Viro wrote:
> > > > ->close_on_exec[] state is maintained only for opened descriptors;
> > > > as the result, anything that marks a descriptor opened has to
> > > > set its cloexec state explicitly.
> > > > 
> > > > As the result, all calls of __set_open_fd() are followed by
> > > > __set_close_on_exec(); might as well fold it into __set_open_fd()
> > > > so that cloexec state is defined as soon as the descriptor is
> > > > marked opened.
> > > > 
> > > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > ---
> > > >  fs/file.c | 9 ++++-----
> > > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/fs/file.c b/fs/file.c
> > > > index d8fccd4796a9..b63294ed85ec 100644
> > > > --- a/fs/file.c
> > > > +++ b/fs/file.c
> > > > @@ -248,12 +248,13 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
> > > >  	}
> > > >  }
> > > >  
> > > > -static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
> > > > +static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
> > > >  {
> > > >  	__set_bit(fd, fdt->open_fds);
> > > >  	fd /= BITS_PER_LONG;
> > > 
> > > Here fd is being modified...
> > > 
> > > >  	if (!~fdt->open_fds[fd])
> > > >  		__set_bit(fd, fdt->full_fds_bits);
> > > > +	__set_close_on_exec(fd, fdt, set);
> > > 
> > > ... which means fd here isn't the same as the passed in value. So this
> > > call to __set_close_on_exec affects a different fd to the expected one.
> 
> ACK.
> 
> > Good spot. Al, I folded the below fix so from my end you don't have to
> > do anything unless you want to nitpick how to fix it. Local variable
> > looked ugly to me.
> 
> Wait, folded it _where_?  And how did it end up pushed to -next in the
> first place?
> 
> <checks vfs/vfs.git>

Did you just not read:

https://lore.kernel.org/r/20241008-baufinanzierung-lakai-00b02ba0ac19@brauner

by any chance?

