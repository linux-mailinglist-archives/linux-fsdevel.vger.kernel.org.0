Return-Path: <linux-fsdevel+bounces-47237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F2A9ADCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44071194837E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7727A927;
	Thu, 24 Apr 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="gjI6fAtm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZvVtmnh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B627A926;
	Thu, 24 Apr 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498681; cv=none; b=DD4cL124tRS/KYv4JjFE2RgEXxhtG2lnYibO2kCKKSnbH58dbj50anBvAI1BKQRJlXeWnsG92KuL02kK3N9GGYL4DeWcPdphjBwqY1fiVy74pfvKkKnhEhSPiCNEIDG+WB3l15wOMb7j1elIWMNq7THEleZC6qgXFzo8p0wVNCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498681; c=relaxed/simple;
	bh=7Ltb0P0T/p13f9Ik10z0acW2tEdNURIaj8Y/bKnt3lU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UG4W46NMyCOuuH2ae7xRQKQjTlgoINXD+7wdTb+93ErFIJ3cHcCECoJI/jS/jvVyZ7qcfGB6Uwxf3ZG5WEpM5tlAbh0IsIzfdC2Rq/bXmg52837DpIYjy34beZL9UK8Fqm2CFKr1AIEeEEQe7tk7n7vB5w9EppCobd4ORbamlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=gjI6fAtm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hZvVtmnh; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7D62A1140230;
	Thu, 24 Apr 2025 08:44:35 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Thu, 24 Apr 2025 08:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745498675;
	 x=1745585075; bh=P6aDXOzwfsUnkNloFebsWwC3WTiLNzsId1SEYLxZLUM=; b=
	gjI6fAtmShaUzCLuZWKm+0H9DwH3BEsgke5uu8sRtB+X1KmfJo4qupEP+vIMcw25
	/nnx1Ziq7pK9O3OxzFebBTgy+ZUESapjWFRS1E0vSyMlPFvv4npwJL3iP4K8aXPX
	xcgcwbQZO85G1KsH4ejPjGY9bMx3GWthWLOJP1v+fDQdtJy3WPUQ6oO9mKOZRPJy
	nwlQtYyFvdFNR97WMCJcGCRtl0ioF4RG/btIUrqaoYHqqRVz0SS8mfTd3bpCknUA
	HvH5P1TZzLBuyzC4qCN3S4xhm5NQ2Yd/wdRetJ/D0dBix0B6vK2JD0AEdTGNp0gp
	HfYMF2azwdmFDVAVbhXcQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745498675; x=
	1745585075; bh=P6aDXOzwfsUnkNloFebsWwC3WTiLNzsId1SEYLxZLUM=; b=h
	ZvVtmnhAKsf+lJgCFQKecmp/PsIEzk7Hssrx7G3itJgyN91f6CZwOJB0BWcAQra7
	6TSLhvtx2dIypSu8lEBHKxDzb6OUfJP2ZkrjDAqTe6aRbimJyNHTleTy1PL69eA4
	Rx+WtVaQNO0Xuk2bfAbirZh2iQpNwoL1yOQ7PyLn9vDkSSmCBUVD1uJQTdYURIUq
	5kvCvx7BNoqSEEtGv3D3cB7Y06tmkmLv1Z/HBtSt0aOXBRSbffx/v3sGzXaBjnGH
	bw/D+dTGfVRzwrXj526OIAzPCS3OH5KVWMs4UsNoTwGTJckwuW0lbydE+5OYh/c8
	pzsEWO3PvIZnP7SsjLeXQ==
X-ME-Sender: <xms:MjIKaMbhhkdI-NXbQcX3oX4rMIdBEQGiiBticGgGSGcDPEFf7HRpsQ>
    <xme:MjIKaHYhxMGGodPrHWrwBuERGWbwkOWCaXsF-1XFucGn2XHtlZYf7KXEc1RHzKDQj
    41RGFna9ZI7d8ewZUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeelhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfffgrvhhiugcutfhhvghinhhssggvrhhgfdcuoegurghvihguse
    hrvggruggrhhgvrggurdgvuheqnecuggftrfgrthhtvghrnhepueekteduueejkeehheel
    vdefleeivdeugfekvdfffefgkeefuedvtdfftddvveeknecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegurghvihgusehrvggruggrhhgvrggurdgvuhdpnhgspghrtghpthhtohepudejpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgt
    ohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtth
    hopegslhhutggrseguvggsihgrnhdrohhrghdprhgtphhtthhopegurggrnhdrjhdruggv
    mhgvhigvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgigrnhguvghrsehmihhhrghlihgt
    hihnrdgtohhm
X-ME-Proxy: <xmx:MjIKaG-butq-hwKt-54QBobV3JRjgepWUpTsEwNDcxQWKuJOGOKUCA>
    <xmx:MjIKaGpUUZoWqfdCVvjRiMgzcBSvqPA4-WDckm9gEEFX8oDnHCCXtA>
    <xmx:MjIKaHrxc8BbX5zU4BxjN2bKGsNfD0CxaA62KuefvNfSOsA36cGKtw>
    <xmx:MjIKaEQJsAUqE7_jK4Fw-RkL-0LcLudYY7bNHr2R5LnU9oetNXTPXw>
    <xmx:MzIKaKYZDwdnNCoSUzgelQCncNKew6_h2mL2tXuwoeZfNFvbKqhZRoi7>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 33FB418A006E; Thu, 24 Apr 2025 08:44:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ta1cb5089883f0698
Date: Thu, 24 Apr 2025 14:44:13 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Christian Brauner" <brauner@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, "Kuniyuki Iwashima" <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, "Jan Kara" <jack@suse.cz>,
 "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
 "Luca Boccassi" <bluca@debian.org>,
 "Lennart Poettering" <lennart@poettering.net>,
 "Daan De Meyer" <daan.j.demeyer@gmail.com>, "Mike Yuan" <me@yhndnzj.com>
Message-Id: <c4a2468b-f6b1-4549-8189-ec2f72bef45e@app.fastmail.com>
In-Reply-To: <20250424-work-pidfs-net-v1-2-0dc97227d854@kernel.org>
References: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
 <20250424-work-pidfs-net-v1-2-0dc97227d854@kernel.org>
Subject: Re: [PATCH RFC 2/4] net, pidfs: prepare for handing out pidfds for reaped
 sk->sk_peer_pid
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Thu, Apr 24, 2025, at 2:24 PM, Christian Brauner wrote:
[...]
> Link: 
> https://lore.kernel.org/lkml/20230807085203.819772-1-david@readahead.eu 
> [1]
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Very nice! Highly appreciated!

> ---
>  net/unix/af_unix.c | 90 
> +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 79 insertions(+), 11 deletions(-)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f78a2492826f..83b5aebf499e 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -100,6 +100,7 @@
>  #include <linux/splice.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> +#include <linux/pidfs.h>
>  #include <net/af_unix.h>
>  #include <net/net_namespace.h>
>  #include <net/scm.h>
> @@ -643,6 +644,14 @@ static void unix_sock_destructor(struct sock *sk)
>  		return;
>  	}
> 
> +	if (sock_flag(sk, SOCK_RCU_FREE)) {
> +		pr_info("Attempting to release RCU protected socket with sleeping 
> locks: %p\n", sk);
> +		return;
> +	}

unix-sockets do not use `SOCK_RCU_FREE`, but even if they did, doesn't this flag imply that the destructor is delayed via `call_rcu`, and thus *IS* allowed to sleep? And then, sleeping in the destructor is always safe, isn't it? `SOCK_RCU_FREE` just guarantees that it is delayed for at least an RCU grace period, right? Not sure, what you are getting at here, but I might be missing something obvious as well.

Regardless, wouldn't you want WARN_ON_ONCE() rather than pr_info?

Otherwise looks good to me!
David

