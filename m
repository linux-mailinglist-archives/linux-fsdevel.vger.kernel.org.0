Return-Path: <linux-fsdevel+bounces-56144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EC8B14065
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF300189D2C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563E02749C7;
	Mon, 28 Jul 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JwaLrMxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5633F218ABD;
	Mon, 28 Jul 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720532; cv=none; b=S8pqZu2AbgJwM7egtqLt0kBveDlVYwN1f5AFXBfD5UMCb1udJJAh+LZTGHKL+k/DtcC/JTo8QSs8nblbyu0hj3EkRjM/AJ2VSBQsWIAoiOJ4zmUTw2e0HYPd007HccfAY3nbtDMFClnGTgcayjInOEDmcz4EOLnNIrv+cLiUa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720532; c=relaxed/simple;
	bh=J3mkOSyeVFwZ6L2Z3lU2OC02lTmvK9iiN9OUxvYG1HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIz6aC+hhSePQOByl1GyXvKOhDO6CnUMW/v4T1Ho4xlpXC5QAOw2E95c534LQm3oJi9Tm0wZbDynX68COgNBHVIUp1kNZnBXch19ayIdJEa11AjLlMTcAnvwjRmfpoAHON5aqC9dl8db9LkLnoohM+N1W5hGqEY/RTVaizbVIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JwaLrMxW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=19/NOO2jPN4bacTElw/sXQdj6nMNToZ8EY1lHqhxVG4=; b=JwaLrMxWG66/X6Nw1hAXiBl/zC
	vnYRrMmfYaAXq66V8tCFLitnlVvWagG/UvGhRMO5G3NwaXVhaJ5Qrj42Iy4Xrnphxatb2TM62O0wX
	Hq7T9daEHEbEsxW/NBgYNerZBEKKqjPnq44a2d0ntkylWs04iZiY/bw5nMLblRl6PLuqHX5y8JWcN
	8a/P2GvuWRtuntWRnUtNk+eK3FUB4GRdSzxpFUlFRCvGoRSHy4TFB0MlnVb4tvvndc3e53yX0nV2D
	4yJ3R1spgF97G4BUBrLLXxRnyUdA8bsoL000X7HCbUq9PqgdEZHQ5jOKFv8iN0O7q4KrYwT6a8MfY
	W+z1ygbw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugQow-0000000BUe5-1i2n;
	Mon, 28 Jul 2025 16:35:26 +0000
Date: Mon, 28 Jul 2025 17:35:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] fat: Prevent the race of read/write the FAT16 and FAT32
 entry
Message-ID: <20250728163526.GD222315@ZenIV>
References: <6887321b.a00a0220.b12ec.0096.GAE@google.com>
 <tencent_E34B081B4A25E3BA9DBBB733019E4E1BD408@qq.com>
 <20250728160445.GC222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728160445.GC222315@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jul 28, 2025 at 05:04:45PM +0100, Al Viro wrote:
> On Mon, Jul 28, 2025 at 07:37:02PM +0800, Edward Adam Davis wrote:
> > The writer and reader access FAT32 entry without any lock, so the data
> > obtained by the reader is incomplete.
> 
> Could you be more specific?  "Incomplete" in which sense?
> 
> > Add spin lock to solve the race condition that occurs when accessing
> > FAT32 entry.
> 
> Which race condition would that be?
> 
> > FAT16 entry has the same issue and is handled together.
> 
> FWIW, I strongly suspect that
> 	* "issue" with FAT32 is a red herring coming from mindless parroting
> of dumb tool output
> 	* issue with FAT16 just might be real, if architecture-specific.
> If 16bit stores are done as 32bit read-modify-write, we might need some
> serialization.  Assuming we still have such architectures, that is -
> alpha used to be one, but support for pre-BWX models got dropped.
> Sufficiently ancient ARM?

Note that FAT12 situation is really different - we not just have an inevitable
read-modify-write for stores (half-byte access), we are not even guaranteed that
byte and half-byte will be within the same cacheline, so cmpxchg is not an
option; we have to use a spinlock there.

