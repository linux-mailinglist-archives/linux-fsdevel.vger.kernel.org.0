Return-Path: <linux-fsdevel+bounces-72619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE8CFE374
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BF6C30704FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42DA32A3F5;
	Wed,  7 Jan 2026 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dustymabe.com header.i=@dustymabe.com header.b="z/GaYuPU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pVx+QKPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55603316184;
	Wed,  7 Jan 2026 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795075; cv=none; b=Er1+qVpQ8Ohy++H3EDeiCb2Ry8TYMAKTVGlxWeVWUR5AaJ5IX4GeokIKB/SyjQYuipQfXiDUBQ/rZ6fQK4UIUVzoQyVEDkCK75lMGeqxv8i6/yqHnr2R4T4QpmQuvkkSr0+GFEaRw6okKzUVjhor3O61YDdwdQbY3ccsf7QtNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795075; c=relaxed/simple;
	bh=5SuDaHkl4fPKLQ2uVUfydjXdZ7EONM2FvGMa+EGKVzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3/ApMWr0tAXYaO1qf3D6/aNZJaaBUddWfN5+WotHMA/rmuFnceXgI/S0pEq9NCaseFr1B0bIjzb74u/TNJYASKDELWInQhSPJTvjTFlzAm2R2h08R7qdEzOTYJQMES4I+hEviexVF74VrSUDG+36TWVJ9+3I86z/1jAZyNHKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dustymabe.com; spf=pass smtp.mailfrom=dustymabe.com; dkim=pass (2048-bit key) header.d=dustymabe.com header.i=@dustymabe.com header.b=z/GaYuPU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pVx+QKPX; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dustymabe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dustymabe.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 600D7EC008C;
	Wed,  7 Jan 2026 09:11:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 09:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustymabe.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1767795072; x=1767881472; bh=dOKD9JMTnRtbOxhVDcnF3A5ak+ih4nA3
	hWhXQ0/WKc4=; b=z/GaYuPU3WkHTw6BIu8x4ibkRiKb+Bs8z7PuJcMVCM1uqJ2G
	kLbqEceqAlV0FVbnLH1ZG9WO3Y6rOROZI5lk2pXPyZuG+99T0ZrUFOAGk/Mrmd+p
	0hE6buJUtaTtxM9AgR1ur40ZB/zndqBkCcXcy38ynQh/GJCAmLxRSflWQOp1PGhs
	6P91rQwKp0+Q89cXrRlfhOzAoQ7NLywpUeAiWI/0ym2JqapyfexGjeG9plGqBQgz
	+qLFAbUU8BHtoxs+HUsGzeeP/4duSeB2ExtMIBAI7eC6WM733o5FuzNvOvwTpqv9
	SbArT31ibYXzCG5mUeptju1QXZLQBNGBQO5Mwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767795072; x=
	1767881472; bh=dOKD9JMTnRtbOxhVDcnF3A5ak+ih4nA3hWhXQ0/WKc4=; b=p
	Vx+QKPXnKQeYDYlFo3HgeFCT1BTr05iIAPBHxr1xJgq1MyAv7u7naSC2HLEpNhfj
	FZ7Lf0i5iYcp+T6sHM1kLyG2hdLTQ/lPk3yex8vlupQ4HN/T3FzB0rxY3EXXNLgR
	LP7gndJSqXSGGZuCQq4ePr5aNggckzUKImOPCaqdx2n8wfKROD7DkTevxJ6lo3R2
	l6+Dktr2glc2EzNg0tGk/9kGvdfilF4CMbI5tjzYV0QMl14IvH5Qr9r9aTvRuyZ3
	rsJQXr8/ZP/GfDAWFQix37eL/xs7uFDVa1FKN2oJFTjsoG/OQHOp8qZjiLOenXrA
	MMDjLlrmLdQDrQhfSxpCA==
X-ME-Sender: <xms:f2leaRsG3FVO-zEVMkl0Owquz7WO907OZGLvKVE8cg2xbxuhfsAQ_w>
    <xme:f2leaQ1aeZldWdlQF92Tmyx1S5vjXFljhQH4etm-uibK7npZ1hu5QIOZNluvl3ICa
    g4DzPLOt-BfYwKTu0wrx2XSHcegEnoZrDKgXFNwxcFrNlLk38pgew>
X-ME-Received: <xmr:f2leaRAnfyZJqeyqKQV6nQWLI5pSqeeHuye847KKDUvCrHFqd6dEXQVcmbjP4g7P7nSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeffuhhsthih
    ucforggsvgcuoeguuhhsthihseguuhhsthihmhgrsggvrdgtohhmqeenucggtffrrghtth
    gvrhhnpeetjedvueevfeehhfeuteeufedukeeugeethfetueekfeehfedvieevtdeffeei
    vdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguuhhsthihsegu
    uhhsthihmhgrsggvrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohephhhsihgrnhhgkhgroheslhhinhhugidrrghlihgsrggsrgdr
    tghomhdprhgtphhtthhopehlihhnuhigqdgvrhhofhhssehlihhsthhsrdhoiihlrggssh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepthhimhesshhiohhsmhdrfhhrpdhrtghpthhtohep
    rghnseguihhgihhtrghlthhiuggvrdhiohdprhgtphhtthhopegrmhhirhejfehilhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrlhgvgihlsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:f2leaWChaemY0tI97gN2-LLQzg4NKU3LbpHqqjTQOEShedrroJYhzg>
    <xmx:f2leaakAYOb2RaUnDhYspT7rVTzSbXKmfuo2_QnqV6Zx2-PxnEZw0w>
    <xmx:f2leaehp7o57w-PD3ZZDEy0wlF0O6ZJKWbfCW6lZEuxRJ4Jdw1zanA>
    <xmx:f2leachqd1pQOnYWzlVpLdPlztvUJEJ1oxb0X2yBhEXFzv3YZmHuEQ>
    <xmx:gGleaUXaqskCkLBRAtRikoNbx18my_IQhGQiiBF-vCBHVADA3IvS38_E>
Feedback-ID: i13394474:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 09:11:10 -0500 (EST)
Message-ID: <6b5047ca-b6f5-4959-80d0-227f735f61dc@dustymabe.com>
Date: Wed, 7 Jan 2026 09:11:10 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Timoth=C3=A9e_Ravi?=
 =?UTF-8?Q?er?= <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?=
 <an@digitaltide.io>, Amir Goldstein <amir73il@gmail.com>,
 Alexander Larsson <alexl@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
 Sheng Yong <shengyong1@xiaomi.com>, Zhiguo Niu <niuzhiguo84@gmail.com>
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Dusty Mabe <dusty@dustymabe.com>
In-Reply-To: <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/6/26 12:05 PM, Gao Xiang wrote:
> Previously, commit d53cd891f0e4 ("erofs: limit the level of fs stacking
> for file-backed mounts") bumped `s_stack_depth` by one to avoid kernel
> stack overflow when stacking an unlimited number of EROFS on top of
> each other.
> 
> This fix breaks composefs mounts, which need EROFS+ovl^2 sometimes
> (and such setups are already used in production for quite a long time).
> 
> One way to fix this regression is to bump FILESYSTEM_MAX_STACK_DEPTH
> from 2 to 3, but proving that this is safe in general is a high bar.
> 
> After a long discussion on GitHub issues [1] about possible solutions,
> one conclusion is that there is no need to support nesting file-backed
> EROFS mounts on stacked filesystems, because there is always the option
> to use loopback devices as a fallback.
> 
> As a quick fix for the composefs regression for this cycle, instead of
> bumping `s_stack_depth` for file backed EROFS mounts, we disallow
> nesting file-backed EROFS over EROFS and over filesystems with
> `s_stack_depth` > 0.
> 
> This works for all known file-backed mount use cases (composefs,
> containerd, and Android APEX for some Android vendors), and the fix is
> self-contained.
> 
> Essentially, we are allowing one extra unaccounted fs stacking level of
> EROFS below stacking filesystems, but EROFS can only be used in the read
> path (i.e. overlayfs lower layers), which typically has much lower stack
> usage than the write path.
> 
> We can consider increasing FILESYSTEM_MAX_STACK_DEPTH later, after more
> stack usage analysis or using alternative approaches, such as splitting
> the `s_stack_depth` limitation according to different combinations of
> stacking.
> 
> Fixes: d53cd891f0e4 ("erofs: limit the level of fs stacking for file-backed mounts")
> Reported-by: Dusty Mabe <dusty@dustymabe.com>
> Reported-by: Timothée Ravier <tim@siosm.fr>
> Closes: https://github.com/coreos/fedora-coreos-tracker/issues/2087 [1]
> Reported-by: "Alekséi Naidénov" <an@digitaltide.io>
> Closes: https://lore.kernel.org/r/CAFHtUiYv4+=+JP_-JjARWjo6OwcvBj1wtYN=z0QXwCpec9sXtg@mail.gmail.com
> Acked-by: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Larsson <alexl@redhat.com>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Cc: Sheng Yong <shengyong1@xiaomi.com>
> Cc: Zhiguo Niu <niuzhiguo84@gmail.com>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>



Tested-by: Dusty Mabe <dusty@dustymabe.com>

I tested this fixed the problem we observed in our Fedora CoreOS CI documented over in
https://github.com/coreos/fedora-coreos-tracker/issues/2087

