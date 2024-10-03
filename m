Return-Path: <linux-fsdevel+bounces-30884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBF98F081
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4916EB21AD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 13:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF36F145B1F;
	Thu,  3 Oct 2024 13:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="0Z3oQEyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23034C70
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962561; cv=none; b=tKOL0gZ1wmo2EMHAFs55JdU1SQ6ErF7AeppfQq8JZLQrlqda3UxD2fFAOMozR9e3f8EfY92rzgAcc6uX0jm+1Ajt2pCAPAf4oS83Lalf1tTV6kfTZE+T2/g8RhZ0EelDdwjI6izoMI2wo/wFXAIPL1z7HmW0V/YVKuMbPZz5w1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962561; c=relaxed/simple;
	bh=IYUWfu1GPkk7tW+imquhNZ2H55pgGP4BiuyjLAcXJi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bllx0MYKyoY/2gKCJ9tdOJY1QsAtJf8U5tD4zW2Jzp6Di483lPjFbEHTgxV0/TLgOZQAm7wzpB5+WeRqmgxE70tt9TcVT5X7EAjNZMsHZoWhz+VSCV1u1XkxbnfowQOqucqcNkCoRYqDit+1D0SQbUanPm0Q46V/+8rOAts+9/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=0Z3oQEyK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e109539aedso870766a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 06:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1727962559; x=1728567359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mZAKL7EAiCi/gQr9jLemKWgPvKxknL4IDkDRFsgw4LM=;
        b=0Z3oQEyKLI/5nzyn+vn/DAX4anHdqvdn+32u5TOInBbxpXEKOjGUUX8vgP1vwvPBbv
         E2V7nSEt+Ci7YHEbIsVyV4jEhZIhBwIHhPvu6pjUugi/YfOBT+C5eQisBRMIQtWq6q+o
         hTzncH7M8fe7cBQIQ4WdYQuqhXL4tdDyU/8lAu1whP+4eoIwCM0v6FoNbhNd2uwqHhy9
         KkPbYC0d5OC+JnPWrV/x9oNHZYP9lcrZ76egLAroRyYEBOQuYGhYhRC7xpYLHIY0p8AM
         i85PVFy9PZY+TyNUKq4lJS/rQRJ8eWisLd84bDWj9vsGKCFAq6JYBRjGobyuVeaByhbf
         5WFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727962559; x=1728567359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZAKL7EAiCi/gQr9jLemKWgPvKxknL4IDkDRFsgw4LM=;
        b=sLhG8Om0Im36kHikoHNTr1VPWx/xI66L9LqSdewAJDQgbj2h7o6TQguhmFHJAVxRJU
         pt0Nt9wDHYDvrpHfDys9QSQ9p4qXdI7CSK4o9gYcOaq6tjyC11JyNKy/dOcTPCWxlcpK
         4hG/r7oVm3W98c3/iB6VHKjJN1xoxrShaDcZVzR5AUdYncsmtrzIa5T2+ZvKdJf27y9f
         ss6dOnr1BnnnGr8qguIGXjZARPLiTm7RE1g4Syvxs7NEpS4s6C2CO/xFnJQB8WLpdDH9
         Vf9tZwOyAVQaMS23cj4ZDXzdbROSApdpQP9r77H8Cbzj+ot2gnhS1Ir8nYT6iydZias/
         erHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfnF0V+/6R6CJzKgZHIRY+it/ghAN/ku266/cMr9ihUE36PtpmoLKHw+3yN4XgogHeEX/Q+Rk5zzNy75us@vger.kernel.org
X-Gm-Message-State: AOJu0YwFsjFch6AzlmGUgadnT3oF6gorAOft7AyDHaLbc8isslSqQg99
	jS49B4rrcsqSg3zkm6gsMm1MLt2QwR1RJ+yHjR5rSDTAEak3eBjgVS647eMWz9w=
X-Google-Smtp-Source: AGHT+IHDxoI0gNIAwGJf4C3QsyVQPomEeY43/JpCrdta+TjkXgvhmW2gsnZ4m/Ving6k2wsvslo/Pg==
X-Received: by 2002:a17:90a:d250:b0:2d8:27c1:1d4a with SMTP id 98e67ed59e1d1-2e1847f3928mr8644873a91.24.1727962559235;
        Thu, 03 Oct 2024 06:35:59 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfad7d0esm1588006a91.8.2024.10.03.06.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 06:35:58 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1swLzo-00DP8E-0o;
	Thu, 03 Oct 2024 23:35:56 +1000
Date: Thu, 3 Oct 2024 23:35:56 +1000
From: Dave Chinner <david@fromorbit.com>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org,
	kent.overstreet@linux.dev, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <Zv6dvCpGIqOr9IPw@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241003114555.bl34fkqsja4s5tok@quack3>
 <Zv6Llgzj7_Se1m7H@infradead.org>
 <20241003124619.wfgozqj4yoyl4xbu@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003124619.wfgozqj4yoyl4xbu@quack3>

On Thu, Oct 03, 2024 at 02:46:19PM +0200, Jan Kara wrote:
> On Thu 03-10-24 05:18:30, Christoph Hellwig wrote:
> > On Thu, Oct 03, 2024 at 01:45:55PM +0200, Jan Kara wrote:
> > > /* Find next inode on the inode list eligible for processing */
> > > #define sb_inode_iter_next(sb, inode, old_inode, inode_eligible) 	\
> > > ({									\
> > > 	struct inode *ret = NULL;					\
> > 
> > <snip>
> > 
> > > 	ret;								\
> > > })
> > 
> > How is this going to interact with calling into the file system
> > to do the interaction, which is kinda the point of this series?
> 
> Yeah, I was concentrated on the VFS bits and forgot why Dave wrote this
> series in the first place. So this style of iterator isn't useful for what
> Dave wants to achieve. Sorry for the noise. Still the possibility to have a
> callback under inode->i_lock being able to do stuff and decide whether we

I did that first, and turned into an utter mess the moment we step
outside the existing iterator mechanism.

I implemented a separate XFS icwalk function because having to hold
the inode->i_lock between inode lookup and the callback function
means we cannot do batched inode lookups from the radix tree.

The existing icwalk code grabs 32 inodes at a time from the radix
tree and validates them all, then runs the callback on them one at a
time, then it drops them all.

If the VFS inode callback requires the inode i_lock to be held and
be atomic with the initial state checks, then we have to nest 32
spinlocks in what is effectively a random lock order.

So I implemented a non-batched icwalk method, and it didn't get that
much cleaner. It wasn't until I dropped the inode->i_lock from the
callback API that everything cleaned up and the offload mechanism
started to make sense. And it was this change that also makes it
possible for XFs to use it's existing batched lookup mechanisms
instead of the special case implementation that I wrote for this
patch set.

IOWs, we can't hold the inode->i_lock across lookup validation to
callback if we want to provide freedom of implementation to the
filesystem specific code. We aren't really concerned about
performance of traversals, so I went with freedom of implementation
over clunky locking semantics to optimise away a couple of atomic
ops per inode for iget/iput calls.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

