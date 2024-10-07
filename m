Return-Path: <linux-fsdevel+bounces-31208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46820993034
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E028AB02
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D751D79BB;
	Mon,  7 Oct 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bah2ODZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83A1D2B35;
	Mon,  7 Oct 2024 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313015; cv=none; b=KzwFYVpeIPXj8bOjG6l7oHjlZ7ASiiC66/+63AZqt8HUoEFZXWlLuVVC9DZRsZXMOxfnpnuImp3LJA6O9VLj+ugF2FdXHf8qyzEdbZKoYa4FIXFTKf6z3oaQylSu+sFFbuM1nNpsD9maN9rlXIiLNmvoz9IahxTMZt4lcMz2Z5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313015; c=relaxed/simple;
	bh=6iic3wdWBosJglMC+i44cbzejQl/TRQeICH6/SoXQG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYJgjM1xbi9T030iIvkM+ByG+6HtuujTXiC75UkvNViD4x+gLyQr7WhjmCxe4QmguNahpaLtfVC3ch1XTHdbKwj2GafUkNMMnM/uU++UT4cHKARFm2ZsK/yfe2yzxORTaojyptY0RHwfBkVfNOyC2HRNdpHMzo/dQaycyEbvSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bah2ODZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA20CC4CEC7;
	Mon,  7 Oct 2024 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728313015;
	bh=6iic3wdWBosJglMC+i44cbzejQl/TRQeICH6/SoXQG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bah2ODZFwYUZb7WWkI6I6ImJPD6A657T4Y7NSH0+mA2HbCw902Z5ohPlE1vhal9WZ
	 bO8qgYwESXiry4oyLwBAGXHMaVqk8+JdHvZKwuxRUgkU38otGXKWT3EKIayw3s/PKE
	 kGltFpi9LJdAn+uY4V0KlIthXlH0DcmOyX90J9WyZ9JPtnbT0MwLmdZQh5e9zTnx++
	 PFmz2yNK3s0mBACLBps6TA3U9S+ycWBiWLmiTDOKDK8vW1Ds2z9swXwVY/vsnagQY5
	 hVlrp+OYthHILpkm4PnTDjuvoccHYr6/P9Z99ajJNSJ2nU9bLZN1Wu0OFuNj7eMrso
	 W+d2ecq5pFezw==
Date: Mon, 7 Oct 2024 16:56:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Uros Bizjak <ubizjak@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] namespace: Use atomic64_inc_return() in alloc_mnt_ns()
Message-ID: <20241007-unklar-wurzel-ce2d0693dfc8@brauner>
References: <20241007085303.48312-1-ubizjak@gmail.com>
 <20241007145034.GM4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241007145034.GM4017910@ZenIV>

On Mon, Oct 07, 2024 at 03:50:34PM GMT, Al Viro wrote:
> On Mon, Oct 07, 2024 at 10:52:37AM +0200, Uros Bizjak wrote:
> > Use atomic64_inc_return(&ref) instead of atomic64_add_return(1, &ref)
> > to use optimized implementation and ease register pressure around
> > the primitive for targets that implement optimized variant.
> > 
> > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > ---
> >  fs/namespace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 93c377816d75..9a3c251d033d 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -3901,7 +3901,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
> >  	}
> >  	new_ns->ns.ops = &mntns_operations;
> >  	if (!anon)
> > -		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
> > +		new_ns->seq = atomic64_inc_return(&mnt_ns_seq);
> 
> On which load do you see that path hot enough for the change to
> make any difference???

I don't think that's really an issue. Imho, *inc_return() is just
straightforward compared to the add variant. That can easily be
reflected in the commit message when I push out.

