Return-Path: <linux-fsdevel+bounces-26235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB8A95655F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747361F219D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 08:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE2315B113;
	Mon, 19 Aug 2024 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI56XoEr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7615B0EC;
	Mon, 19 Aug 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055400; cv=none; b=pOJOfngtiCX3RYKr6zJbkMPoeuI/YtkSjWAR12bu/mO9q39pQaovlrOza/dQi0thu274CAO0I981uG6rKtb2/dsRiD/AWSE2pF9SPL97uNVDI3e6wFFZ6tBgEIcxLdnjqoa4b3XxwdhZMEP82bo4yAkL33yYt3zRzxO4ZZsGfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055400; c=relaxed/simple;
	bh=h1/IeXnJlg4PwqUBxpJtR9xjk5xcC/BYick01gFCaf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQwk3Ti3qVYziMMfRLIo6qu6fkB3kVPbyTc0bv2c/XLlJh8ahZv5ja/Pt/jwj7z1TcGD4oJv0p7+k6SX2L9znLSTlz1vYZu3wegSUAwuRsBE4TXVoFIxOtM4JMjIpysZzjJtaqymn3uk4erCTs/vuk6muHqQoPe91ptsIlnCMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI56XoEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33A6C32782;
	Mon, 19 Aug 2024 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724055399;
	bh=h1/IeXnJlg4PwqUBxpJtR9xjk5xcC/BYick01gFCaf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kI56XoEro8Gy7MN+czzH37fsYLhTjBBRuEOKgRzHCx6lb4jIQkmGnZofsM9225ONq
	 rYzwv9ot6flMBFf2olqbtoM7xN8AX/P7SoxuAQZtD87uYqJNNfu/udx8cBcnNYxHYe
	 slkcuSPOfILgPp9Nkv6IXUdyh3qD/rqxChUZJxN3JY8dvvG+SQGJYtNNmvnnfA0ME9
	 0Ix3z0GND1BVtOwXnccAdcwZUqULJqBceN5rxus0zyzI+cb0Giwf+kSoqXZHAYETqV
	 RCqUXvDqspBJztt7KahmCrSfBFA6dY5yWKAFalg3FredV0lCuXvHnoBj2sknVEwcuv
	 0uBfBzdzkPmOA==
Date: Mon, 19 Aug 2024 10:16:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
Message-ID: <20240819-bestbezahlt-galaabend-36a83208e172@brauner>
References: <20240819053605.11706-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240819053605.11706-1-neilb@suse.de>

On Mon, Aug 19, 2024 at 03:20:34PM GMT, NeilBrown wrote:
> I wasn't really sure who to send this too, and get_maintainer.pl
> suggested 132 addresses which seemed excessive.  So I've focussed on
> 'sched' maintainers.  I'll probably submit individual patches to
> relevant maintainers/lists if I get positive feedback at this level.
> 
> This series was motivated by 
> 
>    Commit ed0172af5d6f ("SUNRPC: Fix a race to wake a sync task")
> 
> which adds smp_mb__after_atomic().  I thought "any API that requires that
> sort of thing needs to be fixed".
> 
> The main patches here are 7 and 8 which revise wake_up_bit and
> wake_up_var respectively.  They result in 3 interfaces:
>   wake_up_{bit,var}           includes smp_mb__after_atomic()
>   wake_up_{bit,var}_relaxed() doesn't have a barrier
>   wake_up_{bit,var}_mb()      includes smb_mb().

It's great that this api is brought up because it gives me a reason to
ask a stupid question I've had for a while.

I want to change the i_state member in struct inode from an unsigned
long to a u32 because really we're wasting 4 bytes on 64 bit that we're
never going to use given how little I_* flags we actually have and I
dislike that we use that vacuous type in a bunch of our structures for
that reason.

(Together with another 4 byte shrinkage we would get a whopping 8 bytes
back.)

The problem is that we currently use wait_on_bit() and wake_up_bit() in
various places on i_state and all of these functions require an unsigned
long (probably because some architectures only handle atomic ops on
unsigned long).

I have an experimental patch converting all of that from wait_on_bit()
to wait_var_event() but I was hesitant about it because iiuc the
semantics don't nicely translate into each other. Specifically, if some
code uses wait_on_bit(SOME_BIT) and someone calls
wake_up_bit(SOME_OTHER_BIT) then iiuc only SOME_OTHER_BIT waiters will
be woken. IOW, SOME_BIT waiters are unaffected.

But if this is switched to wait_var_event() and wake_up_var() and there
are two waiters e.g.,

W1: wait_var_event(inode->i_state, !(inode->i_state & SOME_BIT))
W2: wait_var_event(inode->i_state, !(inode->i_state & SOME_OTHER_BIT))

then a waker like

inode->i_state &= ~SOME_OTHER_BIT;
// insert appropriate barrier
wake_up_var(inode->i_state)

will cause both W1 and W2 to be woken but W1 is put back to sleep? Is
there a nicer way to do this? The only thing I want is a (pony) 32bit
bit-wait-like mechanism.

