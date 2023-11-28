Return-Path: <linux-fsdevel+bounces-4049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C07FBEBB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 16:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42451282678
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 15:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF0535294;
	Tue, 28 Nov 2023 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naYslMMs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E39D3526C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Nov 2023 15:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48D8C433C8;
	Tue, 28 Nov 2023 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701186991;
	bh=WctrKyB1AYxWkSdaGspZTSgYuwbAZhrEyHsHzSrFTMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naYslMMsoUul56kbv74256RVWEv6Lfccp1UL+DFJyA6GsYijzO5ayk1d7QxbTwuKA
	 e28XNZBVQzyGM7pwsqmLgLxrsJFiLLlarNbYwmcb4LskBGc8krhgfhnXv89ks+e+69
	 uN7f40nLN8d366ijMPXaD9LDxIvnVg3j0HGClxPU4ce36Dujz5m5pVbqW8BK4MzAyl
	 DvY+BfMkfqpYCve82B/5IkR9JyZ/gNTF10DbXxWFAI1WlRmfMMxErhCHsx9wMQ7gTm
	 Ky9Zk6Qu8FTt6Jtdfjh3J2VyEYuX+WI06hpqlpU8QXWyuY5FcZv+6lpupGWANUM7sX
	 v6bZPL18dfs2w==
Date: Tue, 28 Nov 2023 16:56:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] super: massage wait event mechanism
Message-ID: <20231128-begleichen-probanden-8c0ec2dc7280@brauner>
References: <20231127-vfs-super-massage-wait-v1-0-9ab277bfd01a@kernel.org>
 <20231127-vfs-super-massage-wait-v1-1-9ab277bfd01a@kernel.org>
 <20231127164637.GA2398@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231127164637.GA2398@lst.de>

On Mon, Nov 27, 2023 at 05:46:37PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 12:51:30PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/super.c | 51 ++++++++++++++-------------------------------------
> >  1 file changed, 14 insertions(+), 37 deletions(-)
> > 
> > diff --git a/fs/super.c b/fs/super.c
> > index aa4e5c11ee32..f3227b22879d 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -81,16 +81,13 @@ static inline void super_unlock_shared(struct super_block *sb)
> >  	super_unlock(sb, false);
> >  }
> >  
> > +static bool super_load_flags(const struct super_block *sb, unsigned int flags)
> >  {
> >  	/*
> >  	 * Pairs with smp_store_release() in super_wake() and ensures
> > +	 * that we see @flags after we're woken.
> >  	 */
> > +	return smp_load_acquire(&sb->s_flags) & flags;
> 
> I find the name for this helper very confusing.  Yes, eventually it
> is clear that the load maps to a load instruction with acquire semantics
> here, but it's a really unusual naming I think.  Unfortunately I can't
> offer a better one either.

I'll just drop the load from the middle then.

> 
> Otherwise this looks good except for the fact that I really hate
> code using smp_load_acquire / smp_store_release directly because of
> all the mental load it causes.

Hm, it's pretty common in our code in so many places...

