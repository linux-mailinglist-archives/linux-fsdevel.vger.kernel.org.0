Return-Path: <linux-fsdevel+bounces-47718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B0AA4997
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A587AAEC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8865024BC01;
	Wed, 30 Apr 2025 11:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+UpynRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8071CD15;
	Wed, 30 Apr 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011678; cv=none; b=YeS21WmEay1FOP4LiUlEsXkt/eKkNe60LHKlmfl2NtJ+umHwc1mcm8iG1D6/I6HymsHVvlgrZ1ykHjFwYlEQtRqlFZw2w0oABr43OKPLx/YkNQGSL8BybM+HGhTL47CfJ5Lkwaf069xY+V5yPXtTFnb2gzy9UG9dVxk/nawlMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011678; c=relaxed/simple;
	bh=L0tt+X3CKteWE1usHBIaF4ll8fmC6jDHNC2/QxR/O8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXzya1lqxnBsHp9TxjmNdGx69u7nSovaLYLr8Wmch7yUCo6OdcRSZarXLMhooQx5g6h+oR92ARljlIxtbhFLHXZQdpqYTLY/f0NEyaYYp5S4Jf9YZGCxMvUmKna2jjZSeOnDdWv4ZOHpjxOWSQtd4ZfoidP1QRJTUIIuV5ts5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+UpynRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AFDC4CEE9;
	Wed, 30 Apr 2025 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746011677;
	bh=L0tt+X3CKteWE1usHBIaF4ll8fmC6jDHNC2/QxR/O8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W+UpynRMaelID6gp1sgmoSox2BoJYLTEKowUqd9R7NgiEqfHzOh8C6pNcLfnYWaR3
	 2hkkLaajaXRj6BFJyf726T/4ZJlRMemJ+ZlmWc3M0aWZPZZd18XCcIILOg2t7RAjhA
	 r4Yj7y/3fh8K6qcpfe/bW+gE5PIAy5t45uNjfVY6aRoNJwh09pUtXMEb/gxnLR49GF
	 8Ws3+BSRwUKBRBGb9ecHif6+oHoYH5owVy7pwlFb61R8dvYUjAh1kzeHgoZdKwGU9E
	 FW7XERaf/QCFp1f7OA6QOC3WflScDLA9ZoPdcrEozD3kyLUN6wKzSZF/JYuJ5Jg9EF
	 8bIxF0ofaXK3Q==
Date: Wed, 30 Apr 2025 13:14:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Oleg Nesterov <oleg@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 3/3] coredump: support AF_UNIX sockets
Message-ID: <20250430-alliierte-umbenannt-eeee362b1312@brauner>
References: <20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org>
 <20250430-work-coredump-socket-v1-3-2faf027dbb47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430-work-coredump-socket-v1-3-2faf027dbb47@kernel.org>

> This is easy to test:
> 
> (a) coredump processing (we're using socat):
> 
>     > cat coredump_socket.sh
>     #!/bin/bash
> 
>     set -x
> 
>     sudo bash -c "echo ':/tmp/stream.sock' > /proc/sys/kernel/core_pattern"
>     socat --statistics unix-listen:/tmp/stream.sock,fork FILE:core_file,create,append,truncate

Don't use "truncate" please. It's not a socat option and it won't work.
The correct option is "trunc".

