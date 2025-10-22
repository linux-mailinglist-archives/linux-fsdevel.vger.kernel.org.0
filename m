Return-Path: <linux-fsdevel+bounces-65195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D11F2BFD7CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 19:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34CBF566753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324228000F;
	Wed, 22 Oct 2025 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pbJR9jVQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sCG7m/Gr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF525A341;
	Wed, 22 Oct 2025 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761152713; cv=none; b=hAs+W6x9aIpWIJO5ewwgPdQ/ybcxZ8DbCs8XRCWXynw0PUaJ/DdAU+zg3ghTlnC2EJlgCIjrh6fil9rS0qEskYcwfEPt9DaZUvQiiQ+6WkyhnMLMsVe8KGp7B2yPz9uvshzhIFRXRRK5NVeyV4Y1/aer8LOq60gN7l8tzrq2zHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761152713; c=relaxed/simple;
	bh=UiPn/GnL997VS+8t5o8a29N6aQcfn2fNK+YW5w5pdRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s/aXo+F675BwWlpAFsjEGDZARl0LyC69zRk/AecgJcDX4Ipzylk7fkP3UnNlZpxND3RFJzR6vmajw2D+KLukl4PDEcx8Dh9D0C5ew79puag5N2Ll5iPSOfSGqTlK165pOgpaz+SgbXNRs4DAIe9P32RATF5x7M37tmR9o0FVhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pbJR9jVQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sCG7m/Gr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761152709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oQ2RBVYKWQ5VGf96MS/2zH2TN/ADfNL38D/U5RR3xQM=;
	b=pbJR9jVQB5nr+G8FFj8RmvDtwsOIWSvd8E6t+m3j3n+0H3B0jqNrjeiEi2dk1Plj3VirQN
	yA/1V7sUF8faAQfZfcsGicIAzo3BuCrCtp9sM1r+CCFvRumcubP0BTQjKsmmkHkqsU4SB6
	P4FKQ4SXRCBNVgzpu7rNh5bRZmUxbM5wYzbEVt4q3BfiT2pVRWQKtJjAhC7QXvUch9Wc5g
	1ykJvAtC37H+CceUcCldztlAX1LwExlWrqz+ncLjsiQfm/fPFU+/nr5IWQvZalrCr+kiBY
	+AAFXvOu5w0HuDFiuQYd4GUcnBqs1oot36h5XkZZ06TOGao+ogzZSCsP6vRpTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761152709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oQ2RBVYKWQ5VGf96MS/2zH2TN/ADfNL38D/U5RR3xQM=;
	b=sCG7m/GraXt0ezpnYBgZ/Npnx8XVxrxQ5s9GmVsZF5pgEe3UYpCM3NR8gSrtBKmgBh+DVK
	EdE+sr9Ir7P4SxDw==
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, Andre Almeida <andrealmeid@igalia.com>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen
 <dave.hansen@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 03/10] uaccess: Add
 masked_user_{read/write}_access_begin
In-Reply-To: <a4ef0a8e1659805c60fafc8d3b073ecd08117241.1760529207.git.christophe.leroy@csgroup.eu>
References: <cover.1760529207.git.christophe.leroy@csgroup.eu>
 <a4ef0a8e1659805c60fafc8d3b073ecd08117241.1760529207.git.christophe.leroy@csgroup.eu>
Date: Wed, 22 Oct 2025 19:05:09 +0200
Message-ID: <87bjlyyiii.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 17 2025 at 12:20, Christophe Leroy wrote:
> Allthough masked_user_access_begin() is to only be used when reading
> data from user at the moment, introduce masked_user_read_access_begin()
> and masked_user_write_access_begin() in order to match
> user_read_access_begin() and user_write_access_begin().
>
> That means masked_user_read_access_begin() is used when user memory is
> exclusively read during the window, masked_user_write_access_begin()
> is used when user memory is exclusively writen during the window,
> masked_user_access_begin() remains and is used when both reads and
> writes are performed during the open window. Each of them is expected
> to be terminated by the matching user_read_access_end(),
> user_write_access_end() and user_access_end().
>
> Have them default to masked_user_access_begin() when they are
> not defined.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Can we please coordinate on that vs. the scoped_access() work as this
nicely collides all over the place?

Thanks,

        tglx



