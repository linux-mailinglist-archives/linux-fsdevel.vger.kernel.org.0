Return-Path: <linux-fsdevel+bounces-63363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A960BB697E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 14:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5135D4E9D73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D111C2ECD31;
	Fri,  3 Oct 2025 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b="vS/zEbN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fMy1kXOg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2A619ABC6
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 12:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759493749; cv=none; b=bfZT47Zx5COYyXdldlICNQ9hckbOqIOPWxQvaqtccw37EzRaGNJqFt0ld7J86hnOEm+g5uLRLa+uTPUUfjLGOunx3icD/tV86PzoXf3P4zSQAvoZTjgM1/LCiHHOHI8TBfgDX8S1+zTNpRTOs47YfHQdIE5UlfZmmfBhA7bjkHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759493749; c=relaxed/simple;
	bh=R7yy2zwls0nWBqCExrcmPss7fju1GWmx6eCYRRJdpos=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=WK4ikhlNeOFQgB8dO/I3+rVqc38hPzsHWpZpuld/XLU321rmaj3Z0MIKnUa72XQDNZkhdD6j+dhmryhQWX8x2K8z7dlyWKdv/47Pv0/BoGJxaP9QDVqNfX6BLUUDXfNHoU7FQguPRCH2kGCGuL9tqdga5q7/nZT7snrcng4wePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li; spf=pass smtp.mailfrom=mazzo.li; dkim=pass (2048-bit key) header.d=mazzo.li header.i=@mazzo.li header.b=vS/zEbN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fMy1kXOg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mazzo.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mazzo.li
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C4CA9EC022F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 08:15:44 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-05.internal (MEProxy); Fri, 03 Oct 2025 08:15:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mazzo.li; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1759493744; x=1759580144; bh=R7yy2zwls0
	nWBqCExrcmPss7fju1GWmx6eCYRRJdpos=; b=vS/zEbN2z+sHp4S5/PaLHRzmbQ
	gLzO3+daDV0Foaeecm5ePkuuJ6AKv/1lmF+DnJ8NNnBRGhuEVqYGrJu4w6J2yD6h
	WXfG+EoJmIwMZM2rm7/Y83tMTGC67660BB97P4lres1RBu96McZUwspvIoxT0PCM
	BhO2mIH7vbpv67ZxPMEH6j5rkwoEjk/WMSXSEE3cWl/zlqUj+a4hWLFAH3I2FNhq
	PdCvRg3xSi6bXfha7h55jnkre1+laYkNAlZdyFcbL2DhhVvy9M4zow3ATkjds5T7
	j8u/pMGrClx2NfjVzG/v+C+dhJDSWchmul6w6czDPoNnK/Ua2yBneqnXXv+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759493744; x=1759580144; bh=R7yy2zwls0nWBqCExrcmPss7fju1GWmx6eC
	YRRJdpos=; b=fMy1kXOgdXwPGLi//uW7XpzzBcsamyRe68jARer2qc4Wk0Dz5KY
	wqJcyJbRgwPTqH76xtUWeTvGSWj8qw1TZ6lfg2uy1aP0L8MBqMJSCr7YzdP3nFGs
	nklwMntdgYgYCZHFyGcJ5uG0rmNYewOXIS0BuJ1ytgNe7Q/wMZtXf5fnvSg8piNA
	MyrQwNyWg1+pvIbC2wntEuQGJRkucOAb0jDeTLp7D6hDSfmOIGQgrR5RaZoUAQX+
	9dDc+FFPXh8+JY7agVPpn28Xi3LrmdphrJlCz7VOnCTlIQExeWzWzTYqW5ZhTKXK
	cZ57slOiJi2J++FtBhDzyjaUMv2rf+4PY0A==
X-ME-Sender: <xms:cL7faHD7xwbEBVHGdxiAYQ9-MreK7vxxYwXqpOOecCZPpZks_qOMdA>
    <xme:cL7faIWC21Xcj1nPIROJCFpKU24r6Bhp5GYkEksDL81hSVQ1O4Vex1vJQDL3BLTWD
    1zVHtf4HtzE3kDRtx78foRVQdzGa28msAIoPm6KKE9m52yXxYm6wY3m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekkeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkufgtgfesthejredtredttd
    enucfhrhhomhepfdfhrhgrnhgtvghstghoucforgiiiiholhhifdcuoehfsehmrgiiiiho
    rdhliheqnecuggftrfgrthhtvghrnhepjedtgfevgeehhfegvdegtddutdethfejvdeufe
    efhfelheelffeikeeludefjeegnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpgiht
    gihmrghrkhgvthhsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepfhesmhgriiiiohdrlhhipdhnsggprhgtphhtthhopedupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cL7faMTPc48rF8zIYh7AtYfHUK8Eu-BeI45bCTrL_B8U9h2dMb01TQ>
    <xmx:cL7faJsPHwqCyBmYn7t6B8SHCU7W3AZ6eBaC7PURY0EwbnS92H-hfA>
    <xmx:cL7faGvcR6XJN45HlCFnsZ1UzG1B74nITCWC_emvhmaJ43-5X6X_ZA>
    <xmx:cL7faHzo763lnE0vvQKB_r82pLtdQfgBQPfXfOFEaalepHVtQNOFvA>
    <xmx:cL7faOnKZPcCo6iHxqFYAcHdE56tXxxwiXDeSlqZAwXGEFS4Ghf385SL>
Feedback-ID: i78a648d4:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5C9BA216005F; Fri,  3 Oct 2025 08:15:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 03 Oct 2025 13:13:39 +0100
From: "Francesco Mazzoli" <f@mazzo.li>
To: linux-fsdevel@vger.kernel.org
Message-Id: <bc883a36-e690-4384-b45f-6faf501524f0@app.fastmail.com>
Subject: Mainlining the kernel module for TernFS, a distributed filesystem
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

My workplace (XTX Markets) has open sourced a distributed
filesystem which has been used internally for a few years, TernFS:
<https://github.com/XTXMarkets/ternfs>. The repository includes both the server
code for the filesystem but also several clients. The main client we use
is a kernel module which allows you to mount TernFS from Linux systems. The
current codebase would not be ready for upstreaming, but I wanted to gauge
if eventual upstreaming would be even possible in this case, and if yes,
what the process would be.

Obviously TernFS currently has only one user, although we run on more than
100 thousand machines, spanning relatively diverse hardware and running
fairly diverse software. And this might change if other organizations adopt
TernFS now that it is open source, naturally.

The kernel module has been fairly stable, although we need to properly adapt
it to the folio world. However it would be much easier to maintain it if
it was mainlined, and I wanted to describe the peculiarities of TernFS to
see if it would be even possible to do so. For those interested we also
have a blog post going in a lot more detail about the design of TernFS
(<https://www.xtxmarkets.com/tech/2025-ternfs/>), but hopefully this email
would be enough for the purposes of this discusion.

TernFS files are immutable, they're written once and then can't be modified.
Moreover, when files are created they're not actually linked into the
directory structure until they're closed. One way to think about it is that
in TernFS every file follows the semantics you'd have if you opened the file
with `O_TMPFILE` and then linked them with `linkat`. This is the most "odd"
part of the kernel module since it goes counter pretty baked in assumptions
of how the file lifecycle works.

TernFS also does not support many things, for example hardlinks, permissions,
any sort of extended attribute, and so on. This is I would imagine less
unpleasant though since it's just a matter of getting ENOTSUP out of a bunch
of syscalls.

Apart from that I wouldn't expect TernFS to be that different from Ceph or
other networked storage codebases inside the kernel.

Let me know what you think,
Francesco

