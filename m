Return-Path: <linux-fsdevel+bounces-62356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BA4B8EE60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 06:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 116B47A95AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 03:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292FA1D5ABF;
	Mon, 22 Sep 2025 04:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="sI5giXfG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UchXesen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DAEC148
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758513626; cv=none; b=ScDeDRPIg5DZ8EJKvK5ij+is8vAm3n2+ABn6pMpspv4bpVmCtXht4gvztNT7uveiO/BswdcsSjv/MLTQz8ptSteuCIqqlhEcoLbJbR8Z6pAmx+XNGJG2TVgBKspvE9cW23d9AEs6nCn4TDZgbif0K5ycgdsHNjAQfCZlyW8Rbbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758513626; c=relaxed/simple;
	bh=0ouheljq5PPsbT+6ecRKGuc96KXVL2Cf81WUbfXmkfs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=PfjR8yXH6j7WfIueHn45bVgOY1JVYB8fdyhgerErc4/93Od6vUv/y42MuX5l6rEOSTnLV/lUBir+2vpUMiyKfwNGMVr7Ae1/aZy8T2Jn81l2tGEIaC/gR+4tugAtTjNL0fdMKhhsU1d7/1pI5KJ1//xw2p+Aq21BekAvtjFDdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=sI5giXfG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UchXesen; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D9B2EEC00A5;
	Mon, 22 Sep 2025 00:00:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 22 Sep 2025 00:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1758513622; x=1758600022; bh=KEvNWZhi0Zc3TXKLKRQxbFkZlm7FTqPfL4j
	EAoExMtI=; b=sI5giXfG1jUd1EiLUqWzZIzCL6wWKE0zL/vku+XKe09AzjlW1t0
	lxe/t6KJzOEvGYygtFnoS34Wu00uOR8+8WjceVioq7V6Y/RxKL6nHr2vsAQj8CPs
	CzmjZ0jxoudb5sjT/PwFbctX6KoEusBnWPD+pkTMGMVWmCsnWzlsQjewHInybSfF
	0kQIng6Or0ppax3yBKfJs3FsjfS+H1/lNs2u+fUQSQtDY84HQYFm1gqbrUogngw3
	VnzC2X7Fxq0SnrISoN0J0hedPkWt7QCzDDYZveE35iKWJZCbpx/5J4VOYjHtHhDA
	gr/1ZcOSV7Jg2t8SVJdAuIWOgb0K9/Q2dNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758513622; x=
	1758600022; bh=KEvNWZhi0Zc3TXKLKRQxbFkZlm7FTqPfL4jEAoExMtI=; b=U
	chXesenf00bKr4Z/xF+C/ciYWi0q+ZLCFFwa0Ga44Rmv+RhH9on27W5l/SZWLyrF
	m04HdLCeYI0sv8jIn5jKKFltjmqyGs7Q/NqrV5n6d8v+sez6+zXsLrIA3PO5ngUP
	v4l9vTqHMhFOgKnVSM6Nyye3H+TJv7A1g/Lbu+UzWSK+WlL2yzELLH/RK/0iUt1C
	q3JE+8Kbj5g9csccRzL8p/lupwiQ669EZKo+UeEAtO0baHt2axmbq7V/OqoYgneq
	ynTT/TsoXsNecbvqD/fF5F2E5cagCmhAhK78GaqD2nfseWkhVFtu1ZztmdG0WhEN
	ZNG0x9O/iKMMjoioyxbRw==
X-ME-Sender: <xms:1snQaIJ82WO6VWh9BaffkC7m0cUp7FsScvtdPM5SK0Y-okwhDHCQVg>
    <xme:1snQaDDZIdscMieynxRqs3eakeJT_MqV74ub22Pqe-KGcC5QhCsR6rx1Pmnv97Hzx
    NsG3gsp2PGxcA>
X-ME-Received: <xmr:1snQaAha-fFTsvVYHr2vXlhgUbbW4Zqp-XTNGB3f8zm0fnDYD8f9UuhqI0lavkughWHsx7wVwKHvdWZ-tSpPL3oWKzx7REzZ_8xsmNq4HKwz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthejredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    duteefhfduveehvdefueefvdffkeevkefgtdefgffgkeehjeeghfetiefhgffgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmshiivghrvgguihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:1snQaDmTWGuu2YpGiwyBjjuZaszBE8NM45vW6c16XSLV6AYu6nc1OA>
    <xmx:1snQaErzp0hKpwegB1dLHIzsv3S5Is0BzJf00Dw3WBQOD08DxpQd5Q>
    <xmx:1snQaEFIkPW-1eOBVPFTqjXm7tiRLoFF7nfEoDdNTHvTNu_fgRo8JQ>
    <xmx:1snQaIx323efDHicDS5wAm_NU0LE1jhcGVNXQv3DqH-J2RPSyv7hMQ>
    <xmx:1snQaPI3rBA8Uc1t5_7wZ5HlP-ZWcBUXgQ_GUePMy6PK_jkxz_YSpg1t>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 00:00:21 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Miklos Szeredi" <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, "Al Viro" <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] namei: fix revalidate vs. rename race
In-reply-to: <175832640326.1696783.9546171210030422213@noble.neil.brown.name>
References: <20250919081843.522786-1-mszeredi@redhat.com>,
 <175832640326.1696783.9546171210030422213@noble.neil.brown.name>
Date: Mon, 22 Sep 2025 14:00:16 +1000
Message-id: <175851361686.1696783.16398864818078148778@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 20 Sep 2025, NeilBrown wrote:
> 
> So, at present, I would be in favour of duplicating lookup_dcache() to
> lookup_dcache_locked() and call lookup_dcache() only when parent isn't
> locked.
> Then removed the d_invalidate() calls after a failing d_revalidate() in
> cases where the parent isn't locked.
> 
> I think that is a simple solution that gets us most of what we need.

I've been reflecting on this and I'm now not sure sure it is quite
right.
It would mean a ->d_revalidate() might do an expensive check when
unlocked and it might then have to be repeated after taking the lock.
So I think we need to tell ->d_revalidate() if the lock is held so that
it can decide if it is worth do an expensive revalidation.
We could achieve that by passing LOOKUP_RCU.  This could be taken to
mean "the parent is not locked".  If '1' is returned we could still
invalidate, but if -ECHILD were returned the revalidate would be retried
with the parent locked.

That needs to provide a good balance to me - though would could introduce
a new LOOKUP_UNLOCKED rather than overloading LOOKUP_RCU.

NeilBrown

