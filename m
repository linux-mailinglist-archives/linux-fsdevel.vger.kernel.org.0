Return-Path: <linux-fsdevel+bounces-17705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043F8B195E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 05:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0DC01F22FD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 03:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA51CAA6;
	Thu, 25 Apr 2024 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uM0Tao45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4933D17984
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015193; cv=none; b=A0Fdi3+TpNKUmLXu7pWFG2ru2RiBzTZM84PVYgKjyazH5ZYhrbeQFixEj0dUb5gJ4i3eYF07MrH8sMbWQntI1L84gBn5bY4S6Q7r672W1JoEkZzOT3DCSGBb1krk+2Oy1/rMjGJAqgFymaMGpJrlG6AoKjM2qHHrQNshxPVGnXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015193; c=relaxed/simple;
	bh=fD8T3dLEgtWYXQ7cIqDNZgxuaW2HPHX5IkAoXjBakDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k20bMqp2lmGBA1wVl0Mhfsuuh8icarWNAxlz0gTTy/WTUOxGhHfQkH/3dd00x+Y0XPKfjPE/0H7BKyhtv3v/+yL4yFZrio14PZyyc0i+tc3ykuSvKuBpdkfrnxAREM2qu6j4skofDLyUFzY7r4MbBGZ6F68RpEJ41ASUyQa8CKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uM0Tao45; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/z3wKLosr/vdejz9o0/hXx3uSH2XaPNYhwXaZQ3tMN4=; b=uM0Tao45uuz4HYtKk4gdEWWQAg
	uLxtlBcLEzTeKc4/+jklkROD/Cul9ocDH/VbgjBF5H9SEV7aH29E0U/uu4TrVgjhVKcq5Rjl9DWD0
	xHcRtOQ4DMWuK+JRi8lT7sFaYTuV/zFlBI/kPpj/aDSY/HSOlcDw7jjFbPBDe0ymiLBdTI2U6yPbP
	x+y94nnfqK8i/zK++evZTTnJgq1dtssrMy/K96Lgm20oerC6F4RWdYp8XSc72SF8aUEAxfnPwZ3ce
	21uFzbYfoB/tQ0idPv5BsIjFy3ux3vqofTojOi+Zrxamt040p9aqTYr7s+jX9puT3iIY6uAFxv5aC
	qqZtinew==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rzpeF-003Kgv-2s;
	Thu, 25 Apr 2024 03:19:48 +0000
Date: Thu, 25 Apr 2024 04:19:47 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Saner typechecking for closures
Message-ID: <20240425031947.GI2118490@ZenIV>
References: <Zic7USbiliQtnKZr@casper.infradead.org>
 <202404241559.D41E91F8@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404241559.D41E91F8@keescook>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Apr 24, 2024 at 04:01:45PM -0700, Kees Cook wrote:

> > That should give us the possibility of passing any pointer
> > to the function, but gets us away from void pointers.  I did this as a
> 
> This just means KCFI will freak out now, since it will see a mismatch
> between call->fn's type and the target function's type. :(
> 
> And instead of args like this, can't we use the regular container_of()
> tricks to get at the pointer we want? i.e. make "call" a member of the
> strut doing the delayed call?

Huh?   A typical situation is (kfree, void *) or (put_page, struct page *).
We are most certainly *not* embedding anything of that sort into struct
page...

What we want is (T -> void) x T : whenever is_pointer(T), but C doesn't
give that kind of polymorphism.  We can do (void * -> void) x void *,
with callbacks converting their arguments to desired types, but that
means that type mismatches are on your head - compiler won't catch
them.

It could be done with lambdas as
	(void)sizeof(f(p)),	// p is a valid argument for f
	call->fn = [](void *v){f((typeof(p))v);},
	call->arg = p

but AFAICS we don't have that implemented sanely - neither in gcc nor in clang.
As the result, we have things like
        set_delayed_call(callback, page_put_link, page);
...
void page_put_link(void *arg)
{
        put_page(arg);
}
and there's nothing to catch you if 'page' above is not struct page *.

It shouldn't need any kind of runtime checks, executable stack, etc. -
everything here can be done statically at compile time.  Oh, well...

