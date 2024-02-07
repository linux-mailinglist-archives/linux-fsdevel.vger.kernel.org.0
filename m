Return-Path: <linux-fsdevel+bounces-10663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D92B84D2A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 21:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230BC1F245D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BCB1272CE;
	Wed,  7 Feb 2024 20:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcmA/0pz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401FA126F23;
	Wed,  7 Feb 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336686; cv=none; b=kXnlNkKoYK7XiW16OOGAwUa9DwHOA4znJdnsOLH4ss69pLV5fMKB7Fxygz0ACTPofPfT8mVBZzbxCB3hoplLcOynv5bCWuv5frkXHruA3P+StHBEcGCzvRmf1CjHhck4UvCgw+cxmmNZA8fMGBX2sdLeu8FwrOyRx+V+fqirrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336686; c=relaxed/simple;
	bh=QXN87N7aKQ5QhHocBoZZ4H7bNqPh3YgQREojYkDT/Vo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uL+Od+/AKE03TBkos98mhUep9JiRQJHj+wvmkKXR1aboD1VU+anLX+kElaE8UaE5J4RIteOJ22nWDUOvdn5857HMHIShlHrQ17wOGEcX8GQU8gW3nw142NiXmJIQGFQkMYe9JK80Gmxpyj+OFVfQd9GSS/JL5hmH8yduXx5n80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcmA/0pz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E0AC433F1;
	Wed,  7 Feb 2024 20:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707336685;
	bh=QXN87N7aKQ5QhHocBoZZ4H7bNqPh3YgQREojYkDT/Vo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dcmA/0pzJCuJimekNhCfo931qGd7ni5BMoqgHmGXnqAoAaFsiOGGwd4+j/YOSZW9m
	 b8czhw//KWjA0wtG2iPcyLqpsheF8BIDFPHGI2PqPhtYh+EytyriUhZKjox9mNnqYG
	 E4l4l3XhNm5Wva0YrmeEiQSJyAkhbKG4em4VXvmOJjubD+n7jSmjhUrf/PsSiZuKj7
	 9u3sluMv+mDHiy0KBEZoC3lmX5c3MZMA6z+5u3pwnS6z3r6gsewWJRSrCgeI6ZxoAd
	 vC9oU17Qu+hxR7047V4LHGAcRY1Ifa8BNfYQvMflMbkSe7ABr/8DNFTz8wQRjFYQj1
	 h5eFZZsOkLAfg==
Date: Wed, 7 Feb 2024 12:11:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, weiwan@google.com,
 David.Laight@ACULAB.COM, arnd@arndb.de, sdf@google.com,
 amritha.nambiar@intel.com, Alexander Viro <viro@zeniv.linux.org.uk>, Jan
 Kara <jack@suse.cz>, "open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 1/4] eventpoll: support busy poll per epoll
 instance
Message-ID: <20240207121124.12941ed9@kernel.org>
In-Reply-To: <20240207191407.GA1313@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
	<20240205210453.11301-2-jdamato@fastly.com>
	<20240207110413.0cfedc37@kernel.org>
	<20240207191407.GA1313@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 11:14:08 -0800 Joe Damato wrote:
> > Why do we need u64 for usecs? I think u16 would do, and u32 would give
> > a very solid "engineering margin". If it was discussed in previous
> > versions I think it's worth explaining in the commit message.  
> 
> In patch 4/4 the value is limited to U32_MAX, but if you prefer I use a u32
> here instead, I can make that change.

Unless you have a clear reason not to, I think using u32 would be more
natural? If my head math is right the range for u32 is 4096 sec,
slightly over an hour? I'd use u32 and limit it to S32_MAX.

