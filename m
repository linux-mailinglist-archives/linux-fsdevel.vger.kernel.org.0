Return-Path: <linux-fsdevel+bounces-74236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 260F9D3864C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3654830A7BF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3D73A1E67;
	Fri, 16 Jan 2026 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMc4Qfmq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA7399A43
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593393; cv=none; b=Rw1gRGpRn+KFL3pmcYvBxoeex3H18vCWNbX2ERjsATkqjXcV1pPOqBApnXtH3mIAy2HsO+VqMc8gWQpb6S0jT+uDuDUeVBiqZ3R/rU6WJ0aC1Mmk4Dj3t7OjV5z2IiG5mGIZUjcFFpvLBVCk54J7OymqcRWE2b0/a+fnIf+Ay5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593393; c=relaxed/simple;
	bh=eYO3M2+xPQR000yZFl395HW9kp0UOalDe5aIv2leix8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SewOC1YpLEbep2aS5r3oo85ypWO9A3zQx2xQWacLoToT/0fKpIcwvereRbCwYPWEOapUHqYGMWVBEaikchpcAOSn4NLudixrOumD2VUlMT+LUuiaq7ekxtUDLCjSXxfAYGj5vXJszkva3oazfSzoiKJ9Ct7jZF0K/Rw+bOHnwJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMc4Qfmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CCFC19422;
	Fri, 16 Jan 2026 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768593393;
	bh=eYO3M2+xPQR000yZFl395HW9kp0UOalDe5aIv2leix8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rMc4QfmqOECN+7BNOobaFVYs7AxpXChyrU5/TswC+stPUz5mA0z/i+7XLTxaes1cP
	 YthrKnsuUm4ZKmD2we8F7we35TijGN52ulMxxlb90yoaJuy0xfotQsOb4cNj9Vf+9a
	 9FxIYcOymsSsR2Tq3SDF7wBKtY8o4rycKCAOl9XXvEywbSqQdUnM8J8OE49FI9Mqpr
	 QFsvO6bPqHA2juSxHO/pu+urihN2ezJRDXg8hDavWj9NXjxvre496CBHqkKjp3ezXM
	 AU0lp+fh9uBk+M6s9Qpqq5ZFVnnYmU9nRQGIW3e2NOaJyKgU0I56UXgoooM2dHhtPr
	 2MzpV9ShrsbKQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id C5328F4007B;
	Fri, 16 Jan 2026 14:56:31 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 16 Jan 2026 14:56:31 -0500
X-ME-Sender: <xms:75dqaQQ9QMSbS2HUk-5DUCMP17fTUwahWOWof4rw57gaKpwdRviviQ>
    <xme:75dqaYlmatl-DNy5Qerk1L0vgn92FYvx9t9P3MhPlg8FVq7wCbA4_uV0axcV-kETl
    mhmb6ThPTPEHEP-uNtI-gt6QNSLWAzPsyXfzZQxIxDmZilU0GgvyaY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdelkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpefhffekffeftdfgheeiveekudeuhfdvjedvfedvueduvdegleekgeetgfduhfefleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegthhhutg
    hklhgvvhgvrhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeifeegleel
    leehledqfedvleekgeegvdefqdgtvghlpeepkhgvrhhnvghlrdhorhhgsehfrghsthhmrg
    hilhdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehnvghilhessghrohifnhdrnhgrmhgvpdhrtghpthhtoheprhhitghkrdhmrg
    gtkhhlvghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggtohguughinhhgsehhrghm
    mhgvrhhsphgrtggvrdgtohhmpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvsghighhgvghrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    jhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhrohhnughmhieskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqtghrhihpthhosehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:75dqaS4d8RE2ipNZzNy4pBVTeF0KDEycDkBTV9v7Yqq6njkm3gHQZQ>
    <xmx:75dqaXsresvI_Q6s6N9_o6Qdd9GeSlG1y10Wq9bB_oJCMRBto3gP5Q>
    <xmx:75dqac0-yu0WA-M-85ovAcrqsjz4pvOxpceAq5kWAkv9P8qsiGf_4g>
    <xmx:75dqaYooM9GFsm1jsfdlEvY6vW-3QHCpiF1BDHSMHHSz1FXCmAJ4mg>
    <xmx:75dqaULV9lqBcEc3fqilH0r9ZWIiN0JTdBbEYCEDZ64mp3C-ayTkasOt>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A46FC780070; Fri, 16 Jan 2026 14:56:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AO3h44zqd9zZ
Date: Fri, 16 Jan 2026 14:55:47 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Benjamin Coddington" <bcodding@hammerspace.com>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Rick Macklem" <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Message-Id: <7951f103-8e2a-49f9-a053-5c9df12aeedf@app.fastmail.com>
In-Reply-To: <4A6213D5-BEFD-4090-9134-8D397C3F2ECE@hammerspace.com>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c49d28aade36c044f0533d03b564ff65e00d9e05.1768573690.git.bcodding@hammerspace.com>
 <bb62acdd-4185-41ed-8e91-001f96c78602@app.fastmail.com>
 <4A6213D5-BEFD-4090-9134-8D397C3F2ECE@hammerspace.com>
Subject: Re: [PATCH v1 2/4] nfsd: Add a key for signing filehandles
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Jan 16, 2026, at 11:42 AM, Benjamin Coddington wrote:
> On 16 Jan 2026, at 11:11, Chuck Lever wrote:
>> To save an extra pointer dereference on the hotter paths, maybe
>> fh_key should be the actual key rather than a pointer. You can
>> use kfree_sensitive() when freeing the whole struct nfsd_net, or
>> just memset the fh_key field before freeing nfsd_net.
>>
>> Just a random thought.
>
> Could do!  ..but its easier to check if a pointer is NULL than to check two
> u64's being unset.  That said, having half the key be zero is probably
> insane odds.  I also figured to minimize the size of nfsd_net when this is
> not used.  I think I like the pointer better, if that's acceptable.

Agreed, the pointer has the benefit of showing whether the fh_key
has been set or not.

-- 
Chuck Lever

