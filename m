Return-Path: <linux-fsdevel+bounces-25605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC694E142
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 14:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AAE1C20EE0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB8B535A3;
	Sun, 11 Aug 2024 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1AfxvSp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0002F4FB
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723380151; cv=none; b=jfFy/UF+3ZEbrWB1rCl2lFFPQSyKphilPA3fIhi1q8P5W+BQ0ISIA6mUNYwSW+iQGCO9unJKkE9MxkkUIijI3Ti/qB/VR/in6ZNd3baG9xuRWsTQEp8ppepAd1I2Z7GuwxMh2Y7axBjEXbwblBFkXEoQVe/x1Cq7OUgDmbsJjbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723380151; c=relaxed/simple;
	bh=faSluxF5RFwGvACjhCxCKAJ9zkyymRLgFSkidB4Gmds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znj+ELU/owWVgUaHpiMFXvEjnDT6BLdwhIDKNstSn3aJi/yGqpI3BX7C8G8sbzcrwldW0Z2fuEbu1BsyHKB3xwg1Bpppt4AZRHHtyYGUUeZOWLkc//eUEYt0CAMMaMEHJ4VimB+sahOjtlhbHI1PiAcfMDlT/ZLJWxN9TNz6grw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1AfxvSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C771CC32786;
	Sun, 11 Aug 2024 12:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723380150;
	bh=faSluxF5RFwGvACjhCxCKAJ9zkyymRLgFSkidB4Gmds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1AfxvSpdbmdRWXv6WGKTxVgpstJ4M9FBNPTs54Q5EjUBWOXCFVtIS3hAnMylZ8Xi
	 Bd/j0izFcCDxOpLTFHBN3lhu8WtTF+B6QocOhtZ7CDm16CF+2MlMWHpq717mmtxCrV
	 pxHsBByj6nW9n1vxFYrN3YNHjvHN5WFmzF+4+gQA3cb0haRRwd57kWgxqh7d2ku8Mq
	 B90GGEp5s4QUYptZr+xGUz7jEeLWYG4Zhm6wLNq9y9RE9jUZMfls1zGxSPh0dLCvIu
	 v5MWBpNnJr9xD1R/iyDBagY8/9XbkAzAy407AyYtZtLp56HliD7beQYWAk1BOg5AGn
	 ogLspcl1RT3ig==
Date: Sun, 11 Aug 2024 14:42:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [DRAFT RFC]: file: reclaim 24 bytes from f_owner
Message-ID: <20240811-geldgeber-lauwarm-0d162fe31e60@brauner>
References: <20240809-koriander-biobauer-6237cbc106f3@brauner>
 <6o2fjmgt2yixzjwc2fffzdtbr4cjey3vhm6kwpieag33kzmmga@5ogofkglj2hj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6o2fjmgt2yixzjwc2fffzdtbr4cjey3vhm6kwpieag33kzmmga@5ogofkglj2hj>

> So *some* saving can be achieved without moving stuff out.

I thought about that but fowner doesn't need to be in there at all.
And then we don't have to care about growing or shrinking the struct, or
its padding.

> > +struct fown_struct nop_fown_struct = {
> > +	.lock		= __RW_LOCK_UNLOCKED(nop_fown_struct.lock),
> > +	.pid		= NULL,
> > +	.pid_type	= PIDTYPE_MAX,
> > +	.uid		= INVALID_UID,
> > +	.euid		= INVALID_UID,
> > +	.signum		= 0,
> > +};
> 
> why this instead of NULL checking?

Dedicated nop types makes it harder to cause accidental NULL
dereferences and currently checking whether a signal needs to be sent is
predicated on ->pid within fowner not being NULL. Which made a nop type
at least a viable option. I don't have a strong opinion.

> > +
> > +/*
> > + * Allocate an file->f_owner struct if it doesn't exist, handling racing
> > + * allocations correctly.
> > + */
> > +struct fown_struct *file_f_owner_allocate(struct file *file)
> > +{
> > +	struct fown_struct *f_owner;
> > +
> > +	f_owner = smp_load_acquire(&file->f_owner);
> 
> For all spots of the sort you don't need an acquire fence, a consume
> fence is sufficient which I believe in Linux is guaranteed to be
> provided with READ_ONCE. I failed to find smp_load_consume, presumably
> for that reason.

Thanks.

> > +struct fown_struct *file_f_owner_allocate(struct file *file)
> > +{
> > +	struct fown_struct *f_owner;
> > +
> > +	f_owner = smp_load_acquire(&file->f_owner);
> > +	if (f_owner != &nop_fown_struct)
> > +		return NULL;
> > +
> > +	f_owner = kzalloc(sizeof(struct fown_struct), GFP_KERNEL);
> > +	if (!f_owner)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	rwlock_init(&f_owner->lock);
> > +	f_owner->file = file;
> > +	/* If someone else raced us, drop our allocation. */
> > +	if (unlikely(cmpxchg(&file->f_owner, &nop_fown_struct, f_owner) !=
> > +		     &nop_fown_struct)) {
> > +		kfree(f_owner);
> > +		return NULL;
> 
> this wants to return the found pointer, not NULL

Caller was supposed to only see an allocation if they own it.

