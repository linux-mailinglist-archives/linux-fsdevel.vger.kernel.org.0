Return-Path: <linux-fsdevel+bounces-17806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE08B2580
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F9B1F21C7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A014C587;
	Thu, 25 Apr 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWYGpdSr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0921494BF;
	Thu, 25 Apr 2024 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059940; cv=none; b=iu5cpeyhTdF2fiwKPzDRipXtcxK7VO3AmIbTZtFwL/zPFlbvxbSgS4HfVPbKl8hXj+hFBsYg6AlucgfpDDXIYzkvdfOs2mitxEvAffB4VfnU1msnq1CGyWUZZQV7rPckSBTbAgffZW5kbU8fpNziSIKXxY1MDXfRf5ckmZp676A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059940; c=relaxed/simple;
	bh=ivTRNNRVsf/5/k0lJkiiGxW01LVY2QvpE5H4WN6G1fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGLJg61VIH/fDRUa78o63dS04yHaImkIqjZlPSLHO1yRXm5zCeKurO4UhPKDHAMtohJLA0gb2wCj95DiCctgvb65L5f4SSKTAUPsZj/hh0pv5I8ZX588TXN0ynI2+Q8iuDddhj6UZKEaDD0xsg2D92ZIoJnoCrOhnrM6UlMKCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWYGpdSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BFF0C113CC;
	Thu, 25 Apr 2024 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059939;
	bh=ivTRNNRVsf/5/k0lJkiiGxW01LVY2QvpE5H4WN6G1fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZWYGpdSrAGjApXVhM4YNwmnftEX8T5ZI8SYKxHx3hfLV9REa9rZXCh8pzr0psmlJW
	 3C6kep7M2PElbnjoDNXVIApiXuE/RMEIeJu2KHzRfd/+mFlQMGDyaLzTUHOpw0zDB/
	 4IAIPyYB0Gmo5Px/Nf+h6sZJqAmSlwi+oA6KFLL8/9qstq95AwZobl0HddXZwKCHOL
	 YJWd2ApjvYBR/5j6XFrFD3OGnf9RqVHRJ/7XByFHlVTOFT0/yb8K4V4JEKOwHCgvvv
	 P1yRt0aGQ/JHzqXdfgPKkRu1qNKTYltSBc9k9rzSCHbnQL8zwihaFfO+a9AEIsfBAL
	 4Lt8gUNhZIzTg==
Date: Thu, 25 Apr 2024 08:45:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, Steve French
 <sfrench@samba.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netfs@lists.linux.dev,
 linux-crypto@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] Fix a potential infinite loop in
 extract_user_to_sg()
Message-ID: <20240425084537.6e406d86@kernel.org>
In-Reply-To: <1967121.1714034372@warthog.procyon.org.uk>
References: <1967121.1714034372@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Apr 2024 09:39:32 +0100 David Howells wrote:
> Fix extract_user_to_sg() so that it will break out of the loop if
> iov_iter_extract_pages() returns 0 rather than looping around forever.

Is "goto fail" the right way to break out here?
My intuition would be "break".

On a quick read it seems like res = 0 may occur if we run out of
iterator, is passing maxsize > iter->count illegal?

