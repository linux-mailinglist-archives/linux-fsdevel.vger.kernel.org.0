Return-Path: <linux-fsdevel+bounces-47266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C57A9B1F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D5621B82AFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FFD1B423B;
	Thu, 24 Apr 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8q1ZZz1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75D17FAC2;
	Thu, 24 Apr 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507975; cv=none; b=TrcdkYQJgaAIcy7gCxoAm25Pto/pm45L10jdk2ImCnrXjAtH2oQcl3+DQW+i+wSYagQDGTen+Eiab1glAsuLpC4raptwf5bhX3OL/uo6OVZExMLdAal72JTLa60qiCrmq/8VBUlnSyRKMFQgLq/MlNdVmLN0dJKw6Izi6G2LvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507975; c=relaxed/simple;
	bh=fTRmjYed2VIYs6hY1s+vikS1UZUUZfpCUTS1lkr5CbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ8KZZ142xs3vBMBH+V1tUOcz/gw7tmjkuws59h2I/w87bf1qqcYR4MSIkPUm3Z2mT07zOgj1aXTBP9ZQW2L++AzvINk01lCzRH2c4RF4XmeyJnYYKymM+w90YEM7Y+e6pFDncQ4Z6kPBjNJmKBnWsWfiGj1EmzfjnJSV0nMsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8q1ZZz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5902DC4CEE3;
	Thu, 24 Apr 2025 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745507975;
	bh=fTRmjYed2VIYs6hY1s+vikS1UZUUZfpCUTS1lkr5CbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8q1ZZz1RpxrYmw2qzQZMKJfdpd9Olan3KNX/XD1bYAHAv1gPQw/K2JbynEZTE58u
	 Zz6dzDsY8G9RWGecpLGAWEbORehbRzrV4aT/0tS5FO0/GxCVCAeCf3Hz1NpVLowXwA
	 kXPnypu6UcdE5yDjB827LL26t52MXqdkfotnQNuvkjFi/aEOvDm0j1VXdz3u7i2ilv
	 dMH3WI8yTDQHyTt+1c2DDDL5m2dI5sCG3S/DqgeqcloBG62MYQIPHm3zwt7dLr1Xv7
	 Dky4OIMOwV7N1fslgftxWLdYo/bhAOmMLaWA/9Vb+AlD+ENqzG3IiNnByzVUt6P3CP
	 YWw2jxsvH+37w==
Date: Thu, 24 Apr 2025 17:19:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Rheinsberg <david@readahead.eu>
Cc: Oleg Nesterov <oleg@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Luca Boccassi <bluca@debian.org>, Lennart Poettering <lennart@poettering.net>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 2/4] net, pidfs: prepare for handing out pidfds for
 reaped sk->sk_peer_pid
Message-ID: <20250424-chipsatz-verpennen-afa9e213e332@brauner>
References: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
 <20250424-work-pidfs-net-v1-2-0dc97227d854@kernel.org>
 <c4a2468b-f6b1-4549-8189-ec2f72bef45e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4a2468b-f6b1-4549-8189-ec2f72bef45e@app.fastmail.com>

On Thu, Apr 24, 2025 at 02:44:13PM +0200, David Rheinsberg wrote:
> Hi
> 
> On Thu, Apr 24, 2025, at 2:24 PM, Christian Brauner wrote:
> [...]
> > Link: 
> > https://lore.kernel.org/lkml/20230807085203.819772-1-david@readahead.eu 
> > [1]
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Very nice! Highly appreciated!
> 
> > ---
> >  net/unix/af_unix.c | 90 
> > +++++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 79 insertions(+), 11 deletions(-)
> >
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index f78a2492826f..83b5aebf499e 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -100,6 +100,7 @@
> >  #include <linux/splice.h>
> >  #include <linux/string.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/pidfs.h>
> >  #include <net/af_unix.h>
> >  #include <net/net_namespace.h>
> >  #include <net/scm.h>
> > @@ -643,6 +644,14 @@ static void unix_sock_destructor(struct sock *sk)
> >  		return;
> >  	}
> > 
> > +	if (sock_flag(sk, SOCK_RCU_FREE)) {
> > +		pr_info("Attempting to release RCU protected socket with sleeping 
> > locks: %p\n", sk);
> > +		return;
> > +	}
> 
> unix-sockets do not use `SOCK_RCU_FREE`, but even if they did, doesn't
> this flag imply that the destructor is delayed via `call_rcu`, and
> thus *IS* allowed to sleep? And then, sleeping in the destructor is
> always safe, isn't it? `SOCK_RCU_FREE` just guarantees that it is
> delayed for at least an RCU grace period, right? Not sure, what you
> are getting at here, but I might be missing something obvious as well.

Callbacks run from call_rcu() can be called from softirq context and in
general are not allowed to block. That's what queue_rcu_work() is for
which uses system_unbound_wq.

> 
> Regardless, wouldn't you want WARN_ON_ONCE() rather than pr_info?

Sure.

