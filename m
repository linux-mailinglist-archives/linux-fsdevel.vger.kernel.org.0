Return-Path: <linux-fsdevel+bounces-67144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFE4C36329
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 16:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31CC04FF7FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 14:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7223332D0E7;
	Wed,  5 Nov 2025 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ixdPaQRV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2m96Jera"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CE32145E;
	Wed,  5 Nov 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354472; cv=none; b=j/ulP0OE9pnEs/znBp5+pu6I+lE8FkOXuzRJFt607z1P4iZKpRDoh+npxs5VgJWlAw4ytaQZN+mX2c3DWG7l5nRJ7cMfktS2yQgxpnyMfQnCYnoGAg2yTpADzjfvMdcQlDCgrsC0MvTYhBT4e7zjj4tvf0lNSitzIpVrLeX52PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354472; c=relaxed/simple;
	bh=wg6hvq1fDEKKHo+ksANPIzinuZ9SiV9KbZGzhCFjZa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k9yX+fOEw4IWS7ZB18LhlbUYaFA2CrstnZ1FotGIeSr+OLabvCbXZ3sE1UajNeqF3/JYpEX0xF53S155t27EfUhXiEEjdZcoGJJ5YbmjD/BicNO99fMtv7aJeyuww6Qum4RRdYym0+JWm/sfev5+gJw6/obzYUQ9yyM8kMmdgR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ixdPaQRV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2m96Jera; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762354469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WxYZ+JeksWx9qzLRbdr/qx4v36wWsQth6BFNnfgxlQ=;
	b=ixdPaQRVOB+Vf/Rjjt9TIHFHfrqbSTg3oXt1SBrY/0vcLZ3MY87d7ex88vzn9l3lEIuIr4
	SYOhn1zLfUUR9JxPwjeVT3ocT2rGfFH9s0+WhzF8+55J3QdyYj0GGo9OxBGtgCLzc3cEB4
	j+7huapGfATu6aXcGZx3HvIVIRJd2rx361EYoZ4iWJww4qISDNV+YhQMhfuIfwD9zpD4EU
	0vfvDqS4xB2aOQCu29sG8SGr4nzHqkpKmfxGlwBIaWjcQXMCYgdpWNJH4BD4eRd+S5GU80
	LcUK6NbiRXQLTibQHLucRQq7kjLOW/8GAhso1ChYyGhbENo+5sYW9hDGQAAu6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762354469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4WxYZ+JeksWx9qzLRbdr/qx4v36wWsQth6BFNnfgxlQ=;
	b=2m96Jera/0TPmblmwvx8TPXahXVuSgKJFttdj9F8sJkbbeCoeN5f4LoITxROKlrWQVRSFQ
	9nPJhdCcdzIbFODw==
To: Petr Mladek <pmladek@suse.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: syzbot <syzbot+3686758660f980b402dc@syzkaller.appspotmail.com>,
 "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
 brauner@kernel.org, chao@kernel.org, djwong@kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [iomap?] kernel BUG in folio_end_read (2)
In-Reply-To: <aQpFLJM96uRpO4S-@pathway.suse.cz>
References: <CAJnrk1bF8sLU6tG2MGkt_KR4BoTd_k01CMVZJ9js2-eyh80tbw@mail.gmail.com>
 <69096836.a70a0220.88fb8.0006.GAE@google.com>
 <CAJnrk1Yo4dRVSaPCaAGkHc+in03KaTXJ+KxckhLoSrRxbEdDBg@mail.gmail.com>
 <aQpFLJM96uRpO4S-@pathway.suse.cz>
Date: Wed, 05 Nov 2025 16:00:28 +0106
Message-ID: <87ldkk34yj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-11-04, Petr Mladek <pmladek@suse.com> wrote:
> Adding John into Cc.

Thanks.

> It rather looks like an internal bug in the printk_ringbuffer code.
> And there is only one recent patch:
>
>    https://patch.msgid.link/20250905144152.9137-2-d-tatianin@yandex-team.ru
>
> The scenario leading to the WARN() is not obvious to me. But the patch
> touched this code path. So it is a likely culprit. I have to think
> more about it.

I have been digging into this all day and I can find no explanation.

The patch you refer to brings a minor semantic change: is_blk_wrapped()
returns false if begin_lpos and next_lpos are the same, whereas before
we would have true. However, these values are not allowed to be the same
(except for the data-less special case values).

> Anyway, I wonder if the WARNING is reproducible and if it happens even after
> reverting the commit 67e1b0052f6bb82be84e3 ("printk_ringbuffer: don't
> needlessly wrap data blocks around")

Note that a quick search on lore shows another similar report:

https://lore.kernel.org/all/69078fb6.050a0220.29fc44.0029.GAE@google.com/

We may want to revert the commit until we can take a closer look at
this.

I will divert my energies from code-reading to trying to reproduce this.

John

