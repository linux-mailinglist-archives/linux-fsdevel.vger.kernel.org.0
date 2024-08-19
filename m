Return-Path: <linux-fsdevel+bounces-26248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D929566D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2688280FA2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F015C14F;
	Mon, 19 Aug 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QejZE3XT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C885815B992
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059528; cv=none; b=iL5rtQV0Zh+F1xUtraQxZpCa1Np1ddoBsd/eYtCADRFMLq7KoJlD+SiIdXt82Aj1o462dvaHx5sFDiY3WNkTAIwPLYr9wtyVtsBR2fbl0Q9M5TwYbspt/xIrvMKpA3aS9cBWCP3XY0mqhsdJO6mfonoPGeQzUcYs4ZxsVVB9uck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059528; c=relaxed/simple;
	bh=f2KSOfgv+L0zUjW0WPPU+kn5KYfOa9Aym7lHEHTNC8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZW0njp91quCuy3NHnBfV3nS1ndmtZmUTxmW4cQGk4UcQvRkffwQ02dAxq54XvLEXtkGshsX5pT76yP7jUl0/eVfoNl/XMn497FFa8wGsE5YClqiV2+hJCoeeXA/oxNwQaK18l0VJZf8Nfsdd17ZjmLMr8QoUoMy4EF1312ydf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QejZE3XT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED804C32782;
	Mon, 19 Aug 2024 09:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724059528;
	bh=f2KSOfgv+L0zUjW0WPPU+kn5KYfOa9Aym7lHEHTNC8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QejZE3XTLwQUnIk4ydPLQCtrQmcw9sAFG0wgtbKgeSySwpXWlinqjXKVcokIsntnO
	 UmO5YOHncknTr42dHbDtHRAaZs7BWtNGSXHp1Rj4IcqY04TUapBGX68/8IadAUtfz6
	 Vw6rPU9C+TIDbd2y7RHqv8yVYfUVWwp0RjL4yCGyV79hJE2Gy315uUEL+VViZjXoIy
	 RUfjf5PaSfuFBpt9iSaFT2vmo2YJmJ5Zh2Zz5UlOe2jhTjIEZ7ocjQe92qNj0k8Woj
	 yZ1mO53yIha102sHRnIZto8FzqnbGT01a1Hf+IsiDxfh8k7NBZNksmzqQXIg4KGHD+
	 IdoHjIwgM6e7A==
Date: Mon, 19 Aug 2024 11:25:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] inode: remove __I_DIO_WAKEUP
Message-ID: <20240819-gemeckert-umgekehrt-631b6c0bdede@brauner>
References: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
 <ZsE24KlMQUiekolM@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZsE24KlMQUiekolM@dread.disaster.area>

> > -	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
> > +	inode_dio_wait_interruptible(inode);
> > +	return !inode_dio_finished(inode) ? -ERESTARTSYS : 0;
> 
> That looks broken. We have a private static function calling an
> exported function of the same name. I suspect that this static
> function needs to be named "netfs_dio_wait_interruptible()"....

Yep. I already fixed that in the tree.

> atomic_dec_and_test() is a RMW atomic operation with a return value,
> so has has fully ordered semanitcs according to
> Documentation/atomic_t.txt:
> 
> 	 - RMW operations that have a return value are fully ordered.
> 	[...]
> 	Fully ordered primitives are ordered against everything prior and everything
> 	subsequent. Therefore a fully ordered primitive is like having an smp_mb()
> 	before and an smp_mb() after the primitive.
> 
> So there's never a need for explicit barriers before/after an
> atomic_dec_and_test() operation, right?

Thanks for the comments on the barrires.

Frankly, I added the barriers because the internal implementation of the
wait_*() functions tend to confuse me as they require memory barriers to
ensure that wait_var_event() sees the condition fulfilled or
waitqueue_active() sees the waiter. And apparently I'm not the only one
with that confusion around these apis (see Neil's series).

