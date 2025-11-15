Return-Path: <linux-fsdevel+bounces-68565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1A4C6081F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 16:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9C33BC31B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 15:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED2829CB52;
	Sat, 15 Nov 2025 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLEtXJs9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fCWvnkFh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77C221F13;
	Sat, 15 Nov 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763222014; cv=none; b=YOaRKnLceNphbc3EbUzul39tmSNdxf3ra1vdu8xtQeL5R8jJB/qfW2II3N/7PM9nPIzkGJE/OzwYiD54o01Xvzx20fKSxbE7ffQRp5AEBRBkkYVLxCroU+/aklGgkHlbiVq+brvnRSE7/lRKRnkNTurqDvG/IqXANyp64NCzgmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763222014; c=relaxed/simple;
	bh=EwI8Hmw+254IZUwdLgVMHCQUgGZu/DpRy2TKDt3lpxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cA4KvByywCF0279xvn0aqkG44ePnQMyvJ2Fa1KUbuyRBYHkQlno35KTmLADG3AOrB3/AFF8Yss83UBJJi8G2mPwNRm43FoM6kis7X76bhrHzskPlcKX2+8tR2Jik9L/2ghHKguj29yI9MIpKctzmULjdOOXwdQZJ6A/Fl8eJ5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLEtXJs9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fCWvnkFh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763222011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZ3ruAdoiAVL5AiOWMufuanCJT2Hk+KKUqr8L/GImxg=;
	b=SLEtXJs90G/7NF9CrSjBMolaz51zpek96DGbr3R8BvIftzWculk19f97DkjJIqgyyOE5b1
	rJq4JYu+8eltZRC6K+Ky57qlhN2irEA0MVU6CbJrmV6I2WxV6d7H4STn3FmW2Nm2iAukJ1
	Lb8+gYcxQTz8PXfTHVLntDKFeg/wHLmYTUNXVU7q8+YKUJOK7GGJ4Ht7pDCTSTNrD9qetm
	bwZVGPoW3pSFcoWuUh5ciT5paxc6cOtYOyWcMyrDIjB0kKPRd+w9rnUbKiuawGL22julqt
	2tsXicGSHUzzZFnVkQbPDZJumodu0COCelq70rNBeeac/Ib2X38KS/w1VXZucw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763222011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xZ3ruAdoiAVL5AiOWMufuanCJT2Hk+KKUqr8L/GImxg=;
	b=fCWvnkFhaCE05joawZuvor/UjHcnZb/Uv1cgWtTEj3z+VMFBzvtxj4oixCLjs41kiNl59I
	ipV96EcnsYStGXCg==
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
Subject: Re: [PATCH v4 03/10] uaccess: Use
 masked_user_{read/write}_access_begin when required
In-Reply-To: <5effda898b110d413dc84a53c5664d4c9d11c1bf.1762427933.git.christophe.leroy@csgroup.eu>
References: <cover.1762427933.git.christophe.leroy@csgroup.eu>
 <5effda898b110d413dc84a53c5664d4c9d11c1bf.1762427933.git.christophe.leroy@csgroup.eu>
Date: Sat, 15 Nov 2025 16:53:30 +0100
Message-ID: <87h5uv9ts5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 06 2025 at 12:31, Christophe Leroy wrote:
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 66eaee783e8be..4a65f9baa87e7 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -274,7 +274,7 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
>  		check_object_size(data, cmlen - sizeof(*cm), true);
>  
>  		if (can_do_masked_user_access())
> -			cm = masked_user_access_begin(cm);
> +			cm = masked_user_write_access_begin(cm);
>  		else if (!user_write_access_begin(cm, cmlen))
>  			goto efault;

Shouldn't this be converted to scoped_....() ?

