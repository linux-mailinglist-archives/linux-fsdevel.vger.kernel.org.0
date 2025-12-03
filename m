Return-Path: <linux-fsdevel+bounces-70563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5171CC9F731
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 595DE3063C3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231F3327213;
	Wed,  3 Dec 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="WGB735LL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124EA325735;
	Wed,  3 Dec 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774836; cv=none; b=MC1/ucer36WfjqqfD26A6Mbzr5hrmOeWmE4emNfT83YErC2Qa6YNdZOHrzj7al/3p2z6X+D5hU8WAseI/EzMuhO9+KOuDqNadT1pZEVSNcMgb6XwnvxmThIYbIGEufJK/BouyjbNua9drsXiHAHA8rqw8eZh6kvkQf/p5X70FTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774836; c=relaxed/simple;
	bh=2/tSBOz+PiCZaXG/ct+4MljpRxJJsJHv6HuN/o2wvXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Keb7owdAx47q3rG7b2XN7OhE/J0U5khew00R3g9tiA0zwR2scOiFXtPqdnuRk/8ELzF9hyVzqHi75EVX/gRY1UEs+0GS7BiizD8F7Bq/hxuXpOPxW0S7MY8o2qJ4O47zzxDBi13Bhk5nBcM1IIbSgYshYmeYw3agmXp2PCawJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=WGB735LL; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 8C58014C2D6;
	Wed,  3 Dec 2025 16:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1764774833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hQf0VWKAwl8tCdlJSS2kYD/qAghSgtRdWIsKNjDMfXc=;
	b=WGB735LLIxDNHokh567k8nIAJxKRQpkks2YGc6sTnaYyvAx6xYEESUlb7o2AtjkFZ/W747
	ZjfzXivPiNszftYdQPBYDwXRu+LJuu09buxO791KLgi/LQ+fSoIhMnxfEKt1hX10bbQ27f
	yKviAMzHJrrXWkYdvmd1Ag6ocem4xLGn5jHKk4QaRMWHj4yBC+HgWnN6iOqEw6Or0fNKmV
	3HuGKBn0mrjl238kfLROlR9DuVuJqyXqQDXik5seCzWIsWdO6M2qTP32AwAUFxwpuk6l+r
	6K4GKIfCBSwURZXmT9U+J9DLtFvonGSZ4pXEpJy0PMkie/lsbiIES3nTn6th7Q==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 1f1d1cea;
	Wed, 3 Dec 2025 15:13:48 +0000 (UTC)
Date: Thu, 4 Dec 2025 00:13:33 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: Remi Pommarel <repk@triplefau.lt>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aTBTndsQaLAv0sHP@codewreck.org>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org>
 <aSdgDkbVe5xAT291@pilgrim>
 <aSeCdir21ZkvXJxr@codewreck.org>
 <b7b203c4-6e4b-4eeb-a23e-e6314342f288@redhat.com>
 <aS47OBYiF1PBeVSv@codewreck.org>
 <13d4a021-908e-4dff-874d-d4cbdcdd71d4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13d4a021-908e-4dff-874d-d4cbdcdd71d4@redhat.com>

Eric Sandeen wrote on Tue, Dec 02, 2025 at 04:12:36PM -0600:
> Working on this, but something that confuses me about the current
> (not for-next) code:
> 
> If I mount with "cache=loose" I see this in /proc/mounts:
> 
> 127.0.0.1 /mnt 9p rw,relatime,uname=fsgqa,aname=/tmp/9,cache=f,access=user,trans=tcp 0 0
> 
> note the "cache=f" thanks to show_options printing "cache=%x"
> 
> "mount -o cache=f" is rejected, though, because "f" is not a parseable
> number.
> 
> Shouldn't it be printing "cache=0xf" instead of "cache=f?"

Definitely should be!

> (for some reason, though, in my test "remount -o,ro" does still work even with
> "cache=f" in /proc/mounts but that seems to be a side effect of mount.9p trying
> to use the new mount API when it shouldn't, or ...???)

... and Remi explicitly had cache=loose in his command line, so I'm also
surprised it worked...

> I'll send my fix-up patch with a (maybe?) extra bugfix of printing
> "cache=0x%x" in show_options, and you can see what you think... it could
> be moved into a pure bugfix patch first if you agree.

Thank you! I would have been happy to see both together but it does make
more sense separately, I've just tested and pushed both your patches to
-next


I also agree the other show_options look safe enough as they either
print a string or int. . . .
Ah, actually I spotted another one:
        if (v9ses->debug)
                seq_printf(m, ",debug=%x", v9ses->debug);
This needs to be prefixed by 0x as well -- Eric, do you mind if I amend
your patch 5 with that as well?


Remi - I did check rootfstype=9p as well and all seems fine but I'd
appreciate if you could test as well


Thanks!
-- 
Dominique Martinet | Asmadeus

