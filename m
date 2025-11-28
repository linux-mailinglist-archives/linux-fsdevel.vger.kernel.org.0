Return-Path: <linux-fsdevel+bounces-70097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C4C9086F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE5A3A2A43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3214214812;
	Fri, 28 Nov 2025 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="Y8KcT6Yy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XudhksO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D594272617;
	Fri, 28 Nov 2025 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294336; cv=none; b=MCoaDvi+nfOE2fJwuaZpMJ4XXThrcOolaPnOwbYEhtEgRxOsMEFvuiIG5AUwvNdpfboswugdOThv3aIar9558wn9SAGgDCGFeEDKuF6BQB1leqO8SdGbod43OHBwMZafmELK4MWkjfYrWBxIu5Wk+Pr7eyKEftiKD4/T0yGZFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294336; c=relaxed/simple;
	bh=lijuLtfgcDwxlCSWm11f87UaINDmlryNgorh3HMGXAQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AgaWKM5XS4fzbectJncBy3fvWjfuDFZUJvOdUJoF3ZuBRL4/CZxEYeDihzHWXFAfSV3gChvtj1ZrxFrIEivnpndkxA2t4PgJVH81XzmfCtPcbvuZ2pWAvShp7OFo3i4WI7rrs5WRvWJdiBcy1XZljzR65oE5520F3Jyy8igVBK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=Y8KcT6Yy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XudhksO1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id DEE43EC0560;
	Thu, 27 Nov 2025 20:45:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 27 Nov 2025 20:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1764294332;
	 x=1764380732; bh=uPJfLIfCpN3TCxk+OPR4/jJssVP1ohQvi9xNqoI+h30=; b=
	Y8KcT6YyR0VoulOaUav6YtH5YtL9dpRu285C5/unnOWtiWyRzMHhqrF3VioUiRcr
	6YalMPZvHpnWnXs0X2KOxItfvm5FMoRC/MG3rHiCR4Y7VxnJN1z6BXPYtWgfvWzL
	huu6QzpRx+YK6Wn94h/0F8WmncGNemPqLJ1nHHLkds5Gjh6XQKGphYvNGQ6FVJjM
	scdLzlsXCR381cRr08Ioa7BaKXFQbWTPCVwuxX7MHU0leh6RFHmM583P1jXLovJz
	A2AhAKpZbFGeEjziD/g25mrKvS93Qg0Slzv2yE9haiV3ChVFpbVP1eTIuAkWebDN
	kDGwZE7ZrTqc39rEPFldBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764294332; x=
	1764380732; bh=uPJfLIfCpN3TCxk+OPR4/jJssVP1ohQvi9xNqoI+h30=; b=X
	udhksO1Cv+cVRypvGs0dBF+v9Ez2x2qBFUUwXjue+0zsHEYbrYUnkycLFj0Nk4oS
	TEuRA0JDtGi9qFNVp8z8nH8hcMjRVFXS6prJ8VIrjU96ieEFYuTgF4fXngqGoaQc
	r5y2NCkKyojdUnZXiVg3645A61hlAILl6rrGK6zGJFfBkUndwfCHcBQGQhy7ctf6
	rjQrqeUZE70Vxs5qR9U2SIuLWipFkzQYQVcuDKiQ20Ewsl5OZLe9B6cA2gwbGR25
	0ZoxkwKn5XDakqCoewSMMReG01DLfcJPkpeP4d2K98FICkRnzVfvgZ+IYmOnrW/X
	caudjrUjTFRm0D8IQZFcg==
X-ME-Sender: <xms:vP4oaWIRzmid_TzBvLQAua15Caic4Ien7Ylf1l-YSiFYamXbq8Fq2w>
    <xme:vP4oaR1meWPJsafK0eBpAfoN13usTEJHhu83_zdFJRR61-UQfPEbqS6eUOT0T3tco
    kxGuLaXEq2cb_jicMGoPwuwq-rBmRcsy-2SMsy8XhRSEWv3KT6yubM>
X-ME-Received: <xmr:vP4oafXVoXyKrpYedNNfTC1JZQyCijroj2EjU2z2zQMTZmPrDd7Ex9wKWI15FABqHGz_44SQN_Msut-Xmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeekieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepvd
    egudeugfdujefgtdetffdujeejleeliedukeeujeduheetgffhgedvteevffeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifth
    hmrdhorhhgpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopehgnhhorggtkhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopegrkhhhnhgrsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghnnhhhsehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehjvghffhiguhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhmrghilhdrtghomhdprhgtphht
    thhopehivhgrnhhovhdrmhhikhhhrghilhdusehhuhgrfigvihdqphgrrhhtnhgvrhhsrd
    gtohhm
X-ME-Proxy: <xmx:vP4oacx-fluN2q9mgfsuMFcbk--UrVcFa03lhcKsJHFwGjJNCSTrAA>
    <xmx:vP4oaezMQYbopoghxJUyANxcIVeQXyWnLaw-SqVYQbkQuhmtsXUEFw>
    <xmx:vP4oaZ2HzncPR26R6WS8JYTgbCElIjg2mFi6h4io3il5VpAxCH87Jw>
    <xmx:vP4oaUpf_p1128nNDLyBhcZTN2SITUQUEQghasj_zOcE3XGABhVf0Q>
    <xmx:vP4oacT5Lkhqwh5HOM-syRqc1orq3O5jvuoz-QNmdXDrRhkPUHr6Ps8v>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Nov 2025 20:45:30 -0500 (EST)
Message-ID: <adf1f57c-8f8e-45a9-922c-4e08899bf14a@maowtm.org>
Date: Fri, 28 Nov 2025 01:45:29 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v4 1/4] landlock: Fix handling of disconnected directories
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Ben Scarlato <akhna@google.com>,
 Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>,
 Jeff Xu <jeffxu@google.com>, Justin Suess <utilityemal77@gmail.com>,
 Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20251126191159.3530363-1-mic@digikod.net>
 <20251126191159.3530363-2-mic@digikod.net>
Content-Language: en-US
In-Reply-To: <20251126191159.3530363-2-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël,

I think this implementation makes sense - to me this feels better than
ignoring rules between the leaf and the mount when disconnected, given the
interaction with domain checks.  This approach is also simpler in code.

However, there is one caveat which, while requiring a slightly problematic
policy to happen in the first place, might still be a bit surprising: if,
for some reason, there are rules "hidden" in the "real" parent of a (bind)
mounted dir, a sandboxed program that is able to cause directories to be
disconnected (for example, because there are more bind mounts within the
bind mount, and the program has enough rename access (but not read/write))
may be able to "surface" those rules and "gain access" (requires the
existance of the already questionable "hidden" rule):

  root@g3ef6e4434e3a-dirty /# mkdir -p /hidden/bind1_src /bind1_dst
  /# cd hidden
  /hidden# mount --bind bind1_src /bind1_dst
  /hidden# mkdir -p bind1_src/bind2_src/dir bind1_src/bind2_dst
  /hidden# mount --bind /bind1_dst/bind2_src /bind1_dst/bind2_dst
  /hidden# echo secret > bind1_src/bind2_src/dir/secret
  /hidden# ls -la /bind1_dst/bind2_dst/dir/secret 
  -rw-r--r-- 1 root root 7 Nov 28 00:49 /bind1_dst/bind2_dst/dir/secret
  /hidden# mount -t tmpfs none /hidden
  /hidden# ls .
  bind1_src/
  /hidden# ls /hidden
  /hidden# LL_FS_RO=/usr:/bin:/lib:/etc:. LL_FS_RW= LL_FS_CREATE_DELETE_REFER=./bind1_src /sandboxer bash
                                        ^ this attaches a read rule to a "invisible" dir
  Executing the sandboxed command...
  /hidden# cd /
  /# ls /hidden
  ls: cannot open directory '/hidden': Permission denied
  /# cd /bind1_dst/bind2_dst/dir       
  /bind1_dst/bind2_dst/dir# cat secret
  cat: secret: Permission denied
  /bind1_dst/bind2_dst/dir# mv -v /bind1_dst/bind2_src/dir /bind1_dst/outside
  renamed '/bind1_dst/bind2_src/dir' -> '/bind1_dst/outside'
  /bind1_dst/bind2_dst/dir# ls ..
  ls: cannot access '..': No such file or directory
  /bind1_dst/bind2_dst/dir# cat secret
  secret

Earlier I was thinking we could make domain check for rename/links
stricter, in that it would make sure there are no rules granting more
access on the destination than what's granted by the "visible" rules on
the source even if those rules are "hidden" within the fs above the
mountpoint.  This way, the application would not be able to move the
source's parent to cause a disconnection in the first place.  However, I'm
not sure if this is worth the complication (e.g. in the case of exchange
rename, source is also the destination, and so this check needs to also
check that there are no "hidden" rules on the source that grants more access
than the "visible" rules on the destination).

I see another approach to mitigate this - we can disallow (return with
-EXDEV probably) rename/links altogether when the destination (and also
source if exchange) contains "hidden" rules that grants more access than
the "visible" rules.  However this approach would break backward
compatibility if a sandboxer or Landlock-enlightened application creates
such problematic policies (most likely unknowingly).

Stepping back a bit, I also think it is reasonable to leave this issue as
is and not mitigate it (maybe warn about it in some way in the docs),
given that this can only happen if the policy is already weird (if the
intention is to protect some file, setting an allow access rule on its
parent, even if that parent is "hidden", is questionable).

Not sure which is best, but even with this issue this patch is probably
still an improvement over the existing behavior (i.e. the one currently in
mainline, where if the path is disconnected, the "hidden" rules are used
and any "normal" rules from mnt_parent and above are ignored).

Reviewed-by: Tingmao Wang <m@maowtm.org>

Kind regards,
Tingmao

