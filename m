Return-Path: <linux-fsdevel+bounces-33692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EBA9BD5A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047C128455F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 19:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A91EBA0A;
	Tue,  5 Nov 2024 19:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="XjUd9H0H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hutAm7G1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDB1E3796;
	Tue,  5 Nov 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833632; cv=none; b=G55ClKvf17GIrV6G0x/Wi3KCudNH3q9T162ZSJvhDYdd+gjrvzOQ1sqfdCFTGQAa7qcH5WA4/utWKkmVStzz0oYCeuOTc7nZVlgZefNSIa0FQO5jmmLHth+chK+wosrhLBr11JN7fp5sLLU+r6g19TFMves6J0p03rpbSExfbRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833632; c=relaxed/simple;
	bh=aiffeFvMny/3ip24X8IqMiW6IyxDHkiaOjg2GvouxGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lELc5c+xjJARyWwLLOkgeCmVTMiHa+/sOjz6dJlSzDPJsLM5YlIkEFSW03/RvR3jJZaoSt+X1dNhVSOF8bwZ4dho7DAbz+bNur+QD9qeX6ENshcaupCpmfobs/OubUCt0vRw1e60Q/xpUkgOwV2Ylrgk/Ue/UjFSiznb2K9yz3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=XjUd9H0H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hutAm7G1; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2F811114016F;
	Tue,  5 Nov 2024 14:07:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 05 Nov 2024 14:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730833629; x=1730920029; bh=Q9TQIfEYCu
	OxbtDhygMHBbUHqm0TEXM3xROT8eAMRoI=; b=XjUd9H0Hjyx3bxW0VQOY0EjHUX
	NeYQy4WK+v6uMfTssEpxNlYur2iT12vAWeDBDvOyI4cscfX1WLRWSf/woYBIS+bt
	AX75JrQwZhjSeiO7rysjv1RX//aKU2PVpIcEZkCrZXzKA1Hntz3mPuUDwDE6uwfr
	bkLtM89Gul1rZ6DvyCpzh7ElJ2TRh0uhIA3if0lYbXxT8eHUgvjkgp2BxcvmEWQT
	qgZpvvhh/B6eff7+WTJFb+tVxe8blWJuxgb+YicjsvTsJjhsIF+N4VaJHHJvNrxE
	7KApXO1RHhCFK3X6WEL3q7hxZrDmbh8VZPSPDNHJS+IRkTZYQJLrK71YtTOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730833629; x=1730920029; bh=Q9TQIfEYCuOxbtDhygMHBbUHqm0TEXM3xRO
	T8eAMRoI=; b=hutAm7G1P9CXmRmKK8aCmzFigdJ+MMn/u0E/EnMaSvaISC6tMWe
	y8PGLb4eWZ66bKigepNC4cdlDJoVTQjcujhIlut9gUSmBZAPSR9xhe1r1GsDMJjk
	JsBxIB0hULRGlcAHbLpmjWdC0025RNIuk8Zy9N1XuizXXCpv66AxfbntBshPG1L3
	iFvpfaELpRrzMoxrovYm2W/rr/tVpmlFMlJLL0HEf/efDaQt+6kMBoIyVRqHJqEA
	RTKx/snqbGy2nQqFd14eWTjN0HgRPaxLul0cg8PnycngBJ6+/T9Y8C6pO0pcJ8xN
	LmKh2pYnZg6bYiFxpIpIjDxNnNqwAIsMcqw==
X-ME-Sender: <xms:3GwqZ3fzQpjkT88lZeMQn9mZ2ZY7iq1ftwwtylalRIS0iNeGN5SqMA>
    <xme:3GwqZ9Ov6OYqtODa-QmQn6_pviUuQ0HZWuc8_cbAtl32zO-xSnEUo1FW7Ss-LqPuz
    n3yFwYfn6v7_ClHAy8>
X-ME-Received: <xmr:3GwqZwjH7mZjYuHwZgXqDgncYU5dGnMkScY7p8kInDZUrNNw64ADNGhj0Q4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpih
    iiiigrqeenucggtffrrghtthgvrhhnpeelveduteeghfehkeeukefhudfftefhheetfedt
    hfevgfetleevvdduveetueefheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohes
    thihtghhohdrphhiiiiirgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhi
    rhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehshiiisghoth
    dotdefvgdurghfhegtfeefvdhfjegvtdgvsgekgegssehshiiikhgrlhhlvghrrdgrphhp
    shhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepvggsihgv
    uggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhm
    sehkvhgrtghkrdhorhhgpdhrtghpthhtohepthgrnhguvghrshgvnhesnhgvthhflhhigi
    drtghomh
X-ME-Proxy: <xmx:3GwqZ49avwo1W3Rgj3aZxfRMQu7aqhrh-TFombce81ArUtINLs24mA>
    <xmx:3GwqZzvN7TjGHw-Tl77RdC9Jg5BJO-6yBugpmO__gf6HdU5yUhfaiw>
    <xmx:3GwqZ3EA7sB_dmqphjPZbOGFiY_JZCU2rGQ_VLtEoCfliM4vGCxkTw>
    <xmx:3GwqZ6NHhdIlugi5hKfaAQfJUckgNKM9oC3R3hlZ-2D_z7UkEng1WA>
    <xmx:3WwqZ8F27rqeEnSJxKXesKnj6KlbwYz6ygD6jOLUEIicqTF_7doad4Gy>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 14:07:06 -0500 (EST)
Date: Tue, 5 Nov 2024 12:07:03 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Tycho Andersen <tandersen@netflix.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] exec: NULL out bprm->argv0 when it is an ERR_PTR
Message-ID: <Zyps12C3+qvunTYp@tycho.pizza>
References: <20241105181905.work.462-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105181905.work.462-kees@kernel.org>

On Tue, Nov 05, 2024 at 10:19:11AM -0800, Kees Cook wrote:
> Attempting to free an ERR_PTR will not work. ;)
> 
>     process 'syz-executor210' launched '/dev/fd/3' with NULL argv: empty string added
>     kernel BUG at arch/x86/mm/physaddr.c:23!
> 
> Set bprm->argv0 to NULL if it fails to get a string from userspace so
> that bprm_free() will not try to free an invalid pointer when cleaning up.
> 
> Reported-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6729d8d1.050a0220.701a.0017.GAE@google.com
> Fixes: 7bdc6fc85c9a ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Tycho Andersen <tycho@tycho.pizza.

Thanks.

