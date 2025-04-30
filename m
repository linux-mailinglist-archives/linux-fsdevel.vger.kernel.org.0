Return-Path: <linux-fsdevel+bounces-47719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C923AA499A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4789A294E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56370254859;
	Wed, 30 Apr 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGpA3Ryz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98786248F7B;
	Wed, 30 Apr 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011701; cv=none; b=XHNgXI2znfQCwCIVLUBW8c0nRwG51E/cEmJdvoqSeLXFf8KVwxmw/TL2CY2NKHSxedSHSVzSLDCYbicrvNCWMGpMvNF8qeLPJtp+FeIiqeBNhHOS0YmrPOTdr7sG4cvXojYjPehwimLIQs0dlOCe4JojSsr/bnHPO6pivNT9sRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011701; c=relaxed/simple;
	bh=BBbMbBBjau772ZZnHqBKPyCSzIz4r3pDZpX2m1DAo8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6jRrDl+uD/81/FI2PhmNam4FH2ok1MeK78NwwuwzchqIvPimaVqfLDuHJNye7ScXlR86WxT/Jsr44nh36Kdh+xjrPWp2XayCmiEfetuq6Z3P9NzXEhW8Mbz2VHGVld11PwvyFW0NV9BZg82u5g10mqGtnsrJfzA+PA/gqn8uEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGpA3Ryz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7414C4CEEA;
	Wed, 30 Apr 2025 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746011701;
	bh=BBbMbBBjau772ZZnHqBKPyCSzIz4r3pDZpX2m1DAo8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGpA3RyzHldaAo+hHcp4UUPUGsQ779XpgQOUzzg/OCpuG6WKMPZyvMYCRI2CPoeLx
	 0+5AalRpln85pKGtq8IEgTpm6PEugh5MV61ASN04o9iLDDh+Ziu5PvFai3h2JpAvM3
	 Erzt5KRkIXGCzdIMtQjiju3kyTZvdpDWtAbHw8aYBDIgAffaGoJLLqK89CNUp8qfgc
	 OidsHl4+ksyi8WOh6YbRURDFMHvsNXk5N+AC3aZesQ+Num4S32PO9BbnaPRcJ4PPp8
	 LU13bhNg5jjfOYgTmKV9zg+Cbnxgil/XXvoqsA0+tZSKHfaIg6OFYNVr0/zKpoxgpN
	 x9KJfMzq/o/Cg==
Date: Wed, 30 Apr 2025 13:14:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Oleg Nesterov <oleg@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] coredump: support AF_UNIX sockets
Message-ID: <20250430-devotionalien-umgewandelt-5bf0eb664caa@brauner>
References: <20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org>

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

