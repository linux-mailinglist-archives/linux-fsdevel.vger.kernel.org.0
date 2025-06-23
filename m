Return-Path: <linux-fsdevel+bounces-52538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470AAE3E86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B7C170CA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2B924169D;
	Mon, 23 Jun 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+9Z7d1M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F223182D;
	Mon, 23 Jun 2025 11:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750679427; cv=none; b=CPxoIpOhcYViD7s8rdnQG0HHsJ/9YleooR6IQYtB3RE0lMb/fkApbN/Vo2hvSE7VVr63QfeToCGol5hFSLzrHV8/W9ozeTDKf99eluNc8YqfDGnEkuNK2NGsZ79fx2V4jtXCvqDA8KpWuwmZo3RTDTRg6ZPPWqKlDZBow6v/4d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750679427; c=relaxed/simple;
	bh=ActTs+qIg1fuo+yvfrQokf0GdyTmEgBrTcnMxW4n8hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qeldqlhG+S9DfMyJMas9x8z4+OtzhjU3F0lLLXxdrubiZYEleGHQd2KobErIKdT9weOEpJrni+RBFGU6O/7InLc4UvtHuNhgr4tdJuNMKmeT5f+NDQpj4F7wIBJODSmoTEs6NvXsphK61ljxsV4Om2lSCEc+d0A2TW5X0r5dbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+9Z7d1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A998C4CEEA;
	Mon, 23 Jun 2025 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750679426;
	bh=ActTs+qIg1fuo+yvfrQokf0GdyTmEgBrTcnMxW4n8hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h+9Z7d1MZYThb4BzC0sAtbzRCw2VDvjT/N1z/g0j1L4XdAT9UD9UR9CI4vA1PqZ5d
	 iGYoetZQ/yTHvVS/ZbgCV6707ruW7FBquAvH6tcQoSWF2XFrUnDMGJMCgs7XIUu9av
	 IW6kGBVeQp+V6IAsL2X2DmlZmt0mQSHqNqldozuJBHnoxS1YBLvZwo6zykE9RHGPma
	 8A2ALmHgOibmvUFWhU2se6YH/2X7g0d4AEwslixKX3ozxncqxUV7LI6NVwu8sBM6CW
	 pnMROxuJ9XK7frRtRVaXfpg0WDw1+6Qf/CU+MVYTl3En2FaWP3alBcvmhfe/8c8H6k
	 3Qy8HKIFSuqRA==
Date: Mon, 23 Jun 2025 13:50:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	David Hildenbrand <david@redhat.com>, John Hubbard <jhubbard@nvidia.com>, 
	Christoph Hellwig <hch@infradead.org>, willy@infradead.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <mszeredi@redhat.com>, torvalds@linux-foundation.org, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: AF_UNIX/zerocopy/pipe/vmsplice/splice vs FOLL_PIN
Message-ID: <20250623-absetzbar-barzahlung-3d124847a2b4@brauner>
References: <1069540.1746202908@warthog.procyon.org.uk>
 <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
 <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
 <1015189.1746187621@warthog.procyon.org.uk>
 <1021352.1746193306@warthog.procyon.org.uk>
 <2135907.1747061490@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2135907.1747061490@warthog.procyon.org.uk>

On Mon, May 12, 2025 at 03:51:30PM +0100, David Howells wrote:
> I'm looking at how to make sendmsg() handle page pinning - and also working
> towards supporting the page refcount eventually being removed and only being
> available with certain memory types.
> 
> One of the outstanding issues is in sendmsg().  Analogously with DIO writes,
> sendmsg() should be pinning memory (FOLL_PIN/GUP) rather than simply getting
> refs on it before it attaches it to an sk_buff.  Without this, if memory is
> spliced into an AF_UNIX socket and then the process forks, that memory gets
> attached to the child process, and the child can alter the data, probably by
> accident, if the memory is on the stack or in the heap.
> 
> Further, kernel services can use MSG_SPLICE_PAGES to attach memory directly to
> an AF_UNIX pipe (though I'm not sure if anyone actually does this).

I would possible be interested in using this for the coredump af_unix socket.

