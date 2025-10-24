Return-Path: <linux-fsdevel+bounces-65520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CADC06A31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53461C05C0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE8E322753;
	Fri, 24 Oct 2025 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hlVWpuEo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q3qANt1i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C8B31814A;
	Fri, 24 Oct 2025 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314920; cv=none; b=bIZwyYOF/2PbpKOMKnewspX4vNdkrR4gNlEMt4uxz3ixb4VUqifHp6ERPdW2Tu5GljA58BTfGUCfaXntArIQ5zLJ5hjuoLrKVCSMKPl7rx8YSX/BPKXhizUYk3eIJVOx16skUAVEbnqjGRyPAKw2s/SiZPo4LggJxHyV7RkWSEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314920; c=relaxed/simple;
	bh=VB7MUbFzQw0hGAqr2p+CQiUuP9dG3eG52n6sxVb7FEk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Kn2EGa8N1ppsuIUSU6uAfpeEARpbX/XGo5RvU0xrWrMURr/3d58/k0aUW8VpAK6OybhfNsI/CBCKMchy2MuGPRfxlahOqDyh1m2K3gE2IILuvYRGfMOUmz3EphKnBOqwV65MPhFemfhbl/oQ0ze15RP7vF8g4GU9gfpFsGxHo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hlVWpuEo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q3qANt1i; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id AEEFD13006B5;
	Fri, 24 Oct 2025 10:08:37 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 24 Oct 2025 10:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761314917;
	 x=1761322117; bh=Cb+ptnx07ebPr7o44PcZpvCH+xBEfVRPWdIj9Bu8PAI=; b=
	hlVWpuEowvcQ6T6uZqLHfrUU9JlFXqGHcV8BHQkCM0MzrkM4uyGfftYu1MeCSqni
	QUWKUgEfY83yORtU0utfCF2h4y0inSZNJyvQdZtaxL5NNctp0Xdcf53q8wtR7E9c
	xvUMbDaI5R/3AGOwHOlOGpQBi0tChugU5qRNoml9LZuXqNSMOYFRH0KMgVHAT0/I
	gRfJh3uJDQGKxtA/lwkNSoeG9L92ihfF9XSiEwauzOyY80tA/Mge612399gJSGxJ
	kUpnX157bWwSifx3GLcd8eaEmERuOkWZSJgFDhu6CRNExLfKS6Jh7urUEzMXadoB
	zoGexToHJXiWQMTgw8ynEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761314917; x=
	1761322117; bh=Cb+ptnx07ebPr7o44PcZpvCH+xBEfVRPWdIj9Bu8PAI=; b=Q
	3qANt1i+zXY6oUOAlXErT5FKFmPLwU+e0ZdhkeYCRbn8e8NVgiOQoa4NhDvRL+0Z
	J7MIR9cWPfn96kD8nYrOZVFb1vlglmDP24GBi5iYU7+0GVoSgwVdXyL0h68qPMVR
	BXD02sO1Ls9m7FOWtVaMLms+Wjv6KgV5URYsYaJJKChl87/+WPQE3QmDyrsZxrBH
	X8564wcaN4vIXrhYz9ggib+c0Nsm/xbM2LwhrMasDqVksXgZwAev+id6/75mFMHP
	Tsw4pQwkaJl1IZC2JzW+5LizuevV3AdysERGuzFlTqHnujuGdElQWJMaDBX8ZCDB
	i4vO+HXb1nqngVqDTnkGA==
X-ME-Sender: <xms:ZIj7aA3Eg3Y0rlzk26ezjCER1IzRbSwN2wjgyobpPn-bU88Qf21ZAQ>
    <xme:ZIj7aF77yLXSQjINknf_EQXACdywcpQQUYKqCnaMnAKK8PTIjJT8EVsUlpIE2YeBc
    9Ly1OQd9u0EbOnRqmT7Y1GJn6AczAC_Jx25CRn-xdDC47-qzdNu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmiiigrhgvrghrhiestdhpohhinhhtvghrrdguvgdprhgtphhtth
    hopehhrghnnhgvshestghmphigtghhghdrohhrghdprhgtphhtthhopegthihphhgrrhes
    tgihphhhrghrrdgtohhmpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepuggrrghnrdhjrdguvghmvgihvghrsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrg
    hnnhhhsehgohhoghhlvgdrtghomhdprhgtphhtthhopeiisgihshiivghksehinhdrfigr
    fidrphhlpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZYj7aG4UJ2M8mc3pnSzWeFpW2CG5XHRvFuvCPGbR3JoK59nl83qsmQ>
    <xmx:ZYj7aBPgrinlB_DSWtycLsEcaniQY6W2WbSpix2NBrnlgimoI32iDQ>
    <xmx:ZYj7aH7BdLb6AqXBIH_FZBmjsIWL8OL5ThWIUAzV5tYwajH9yU0IbA>
    <xmx:ZYj7aIzWcoJTsQ_UTsWxc6_N0j7AIb1XaVzd0jMwaWXpD3G9F5ukbQ>
    <xmx:ZYj7aPDZv86yheOLByNFoKdlBVjT8Z9V_vZax3GzdYaa2VPAbx1q-aCp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DCF42700054; Fri, 24 Oct 2025 10:08:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvgbtRMgB1Po
Date: Fri, 24 Oct 2025 16:08:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christian Brauner" <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 "Josef Bacik" <josef@toxicpanda.com>, "Jeff Layton" <jlayton@kernel.org>
Cc: "Jann Horn" <jannh@google.com>, "Mike Yuan" <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 "Lennart Poettering" <mzxreary@0pointer.de>,
 "Daan De Meyer" <daan.j.demeyer@gmail.com>,
 "Aleksa Sarai" <cyphar@cyphar.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Tejun Heo" <tj@kernel.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 Netdev <netdev@vger.kernel.org>
Message-Id: <cfefa1c8-4cd2-478e-8c68-627a0a767f7d@app.fastmail.com>
In-Reply-To: 
 <20251024-work-namespace-nstree-listns-v3-18-b6241981b72b@kernel.org>
References: 
 <20251024-work-namespace-nstree-listns-v3-0-b6241981b72b@kernel.org>
 <20251024-work-namespace-nstree-listns-v3-18-b6241981b72b@kernel.org>
Subject: Re: [PATCH v3 18/70] arch: hookup listns() system call
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 24, 2025, at 12:52, Christian Brauner wrote:
> Add the listns() system call to all architectures.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

This looks correct to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> diff --git a/include/uapi/asm-generic/unistd.h 
> b/include/uapi/asm-generic/unistd.h
> index 04e0077fb4c9..942370b3f5d2 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -857,9 +857,11 @@ __SYSCALL(__NR_open_tree_attr, sys_open_tree_attr)
>  __SYSCALL(__NR_file_getattr, sys_file_getattr)
>  #define __NR_file_setattr 469
>  __SYSCALL(__NR_file_setattr, sys_file_setattr)
> +#define __NR_listns 470
> +__SYSCALL(__NR_listns, sys_listns)
> 
>  #undef __NR_syscalls
> -#define __NR_syscalls 470
> +#define __NR_syscalls 471
> 

I still need to remove this unused file, but that is my problem,
not yours. No need to add patch 71 to your series ;-)

    Arnd

