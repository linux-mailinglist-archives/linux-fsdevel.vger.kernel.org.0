Return-Path: <linux-fsdevel+bounces-10658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75DC84D200
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3E628A8EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370128529B;
	Wed,  7 Feb 2024 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR8vRHFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82254823DA;
	Wed,  7 Feb 2024 19:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707332848; cv=none; b=oAcHy/Ve/cMex0qozPOwoe4IdIHZ5FiEFBwZv2ztU5h8zE5VFk9tpextYOAMJ8v5Id5l2JVa7Hw3as+TQbDF/uPL3SQ2Kq78OlieBUArD0FkeLe3zSzzKKbdWdSKhV9Ls62OVfdB5RHFK6CyVJnlYnuKmsLf0lHxTlSkNkTysVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707332848; c=relaxed/simple;
	bh=32b8qXnDnhangiLWu11oK/IFaNchO41kne7P17ywF0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heqr4cW7QTzyoleLBei79rQZxYxexDgFOqMCphsIERYH9HGMULn2QQgx+KxVfbOc8lr5SsdTPoqnNtUEML2v+VyUU0YEqBLmVS49Af5DAQ9FAS+71sK17lNjczS+2dMdxRG0JZz8j9PQKXi7qukUVZ7O95zR7ReQXzyrIxWn9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR8vRHFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1103C433F1;
	Wed,  7 Feb 2024 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707332848;
	bh=32b8qXnDnhangiLWu11oK/IFaNchO41kne7P17ywF0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QR8vRHFKZY+rHXYBNbvc6eoNFkPkbaKZ3C8iazyT+m1abt7chD4Doq/5Auq53dnWW
	 HtNhDmwtQjqq7Xud4MLKS457LYKThGxyyDCbo/UlLIkPTiTrJMY7nXuj7SRVsRxTaE
	 S9g6rmGIAOFOvkSRG+oEDos7H4kV53VmtgVzN4sgEM3yAv24fWmACxMFFZB/PooYXg
	 oN3pWTndrcTNCWvh7MFlEc5kEbz+SzYzB7X59kHHMB/KOqgH6s11Ng94LVahrlLiDU
	 UhSGtnq5l/wmXezmk7jTGKuKK7IcCN8/zUQqHde5Q0UDRPzz9so56OTx3z5I1kgU0k
	 ab50T2sldLyYA==
Date: Wed, 7 Feb 2024 11:07:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
 brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
 alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, weiwan@google.com,
 David.Laight@ACULAB.COM, arnd@arndb.de, sdf@google.com,
 amritha.nambiar@intel.com, Jonathan Corbet <corbet@lwn.net>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Nathan Lynch
 <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Namjae Jeon
 <linkinjeon@kernel.org>, Steve French <stfrench@microsoft.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, Julien Panis <jpanis@baylibre.com>,
 Andrew Waterman <waterman@eecs.berkeley.edu>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "open
 list:DOCUMENTATION" <linux-doc@vger.kernel.org>, "open list:FILESYSTEMS
 (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 4/4] eventpoll: Add epoll ioctl for
 epoll_params
Message-ID: <20240207110726.68c07188@kernel.org>
In-Reply-To: <20240207185014.GA1221@fastly.com>
References: <20240205210453.11301-1-jdamato@fastly.com>
	<20240205210453.11301-5-jdamato@fastly.com>
	<ec9791cf-d0a2-4d75-a7d6-00bcab92e823@kernel.org>
	<20240207185014.GA1221@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 10:50:15 -0800 Joe Damato wrote:
> > This !! is unnecessary. Nonzero values shall be "converted" to true.
> > 
> > But FWIW, the above is nothing which should be blocking, so:
> "> 
> > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>  
> 
> netdev maintainers: Jiri marked this with Reviewed-by, but was this review
> what caused "Changes Requested" to be the status set for this patch set in
> patchwork?
> 
> If needed, I'll send a v7 with the changes Jiri suggested and add the
> "Reviewed-by" since the changes are cosmetic, but I wanted to make sure
> this was the reason.

Yes, I think that's it.

