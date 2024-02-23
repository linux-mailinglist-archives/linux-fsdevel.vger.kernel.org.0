Return-Path: <linux-fsdevel+bounces-12578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EB7861366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39E01C21BB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9128002B;
	Fri, 23 Feb 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cRIp1DUH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B961862A;
	Fri, 23 Feb 2024 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708696509; cv=none; b=fjIAHSOWjeJG3ZYgd3+IvUTuRMh8CXB8MnjNShXFhbq680578i6HxzQc3uuEeGrHg+Ur8rVSWgsmCXg9nNMY5Hv0oPglVU13y4s11ZT2sySa/NY0yQRCpylRp/4TSjfiPHZ4AwhIybB/p2kdjskK6IC6jtQFxGoUAjjVvhOSLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708696509; c=relaxed/simple;
	bh=QDOnvEHvmluOKUK80bI4w/1xdbotijfIQb6S7kHnNDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0hpIGLT5jMBbpeD/hlN5/6pWjwGE/zCMLitNmdmQmTPoBW1mXZJRcry3wkDotTQ6Njj1r7UuEfD3s4MgEVOBwXkicBr4B7hqErgFyECI1HZyIFWUtpzNPorIuAoKA2lqJevMM3c/3iGUVsxC07QQ/fk3grlAFPm8GbT71fVND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=cRIp1DUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A74C433C7;
	Fri, 23 Feb 2024 13:55:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cRIp1DUH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708696504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QDOnvEHvmluOKUK80bI4w/1xdbotijfIQb6S7kHnNDc=;
	b=cRIp1DUH1OZnz2MuPZPJ/UiMY9/nR3kOADJsJaXUW25oeLFyf5OrOvqoTyGpKxINe8ju7R
	3WgoCuzHwjwrwb8eYV2LchI2xWGKX76P6Qk67wnIJNjy9Xa+zBTkEJvRdLhL1jyWs9YN6O
	syvWGgDgZxQAcy58oxm+I4bDBjb5Syo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 36363131 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Feb 2024 13:55:04 +0000 (UTC)
Date: Fri, 23 Feb 2024 14:55:01 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, maple-tree@lists.infradead.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <ZdijtQNFuziHnqH2@zx2c4.com>
References: <20240222203726.1101861-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222203726.1101861-1-willy@infradead.org>

Hi Matthew,

On Thu, Feb 22, 2024 at 08:37:23PM +0000, Matthew Wilcox (Oracle) wrote:
> Rosebush is a resizing, scalable, cache-aware, RCU optimised hash table.
> I've written a load of documentation about how it works, mostly in
> Documentation/core-api/rosebush.rst but some is dotted through the
> rosebush.c file too.

If you're interested, WireGuard has some pretty primitive hashtables,
for which maybe Rosebush would be an interesting replacement:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireguard/peerlookup.c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireguard/peerlookup.h#n17
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireguard/ratelimiter.c#n167

In peerlookup.c, note the "At the moment, we limit" comment for an idea
of some of the hairy issues involved in replacing these. But I wouldn't
be entirely opposed to it, if you see some interesting potential for
Rosebush here. That's a very tentative interest -- maybe it won't work
out in the end -- but nonetheless, seeing this piqued my curiosity. If
you're looking to see how this behaves in a place beyond dcache, this
might be something to play with.

Jason

