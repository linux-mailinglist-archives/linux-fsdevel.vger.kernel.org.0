Return-Path: <linux-fsdevel+bounces-25503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F31594CB89
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 09:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C58C1C2239A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 07:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9E517A588;
	Fri,  9 Aug 2024 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tiljeset.com header.i=@tiljeset.com header.b="VQi2XReo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XKQjgJHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D39E178374;
	Fri,  9 Aug 2024 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723189206; cv=none; b=lPZzuc4BMPNGXJ/Mw7CiNz38dovNGnIlRjgDtQfIWTKHW0EsHRBctbNAJtmPD9bAhL9peUhOSKfG75bto2BEu3q8qvfwcV1cl6Zqv/6Uq5TRnkuyrpGtqp9vhu00rTWzDu2i5C1fw5AiYfXS8K5EhEmjb2ig0H5CTNBbPN8uiGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723189206; c=relaxed/simple;
	bh=mboX3krB7igLGhZuMPvm5bs7qXeswVH5zMlbTOV/Y9A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FLEHwkL8DDiGYVBTas+lWjYXM2tBzs6mJuc8VMeyQmwQNCcH3AIvJOdY5S/cW66LchgaNS2Za8b5IxjmFPM0hPQqNfKuOMM52/4Uf0RKDMC77Zpa/ZhhYVLHh3604JY6g4+XS5I+/c2mhQmIfhPActNBvs+H2Sd0O6E+Oo0A16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiljeset.com; spf=pass smtp.mailfrom=tiljeset.com; dkim=pass (2048-bit key) header.d=tiljeset.com header.i=@tiljeset.com header.b=VQi2XReo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XKQjgJHz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tiljeset.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tiljeset.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 51EC51151ABD;
	Fri,  9 Aug 2024 03:40:03 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 09 Aug 2024 03:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiljeset.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1723189203;
	 x=1723275603; bh=mboX3krB7igLGhZuMPvm5bs7qXeswVH5zMlbTOV/Y9A=; b=
	VQi2XReolFiRpevJ0yxofoa1Vz4cHe4oSZGkGVBDC/Yx9SVxkzQmGi3Hpg43DcGI
	LNM4DU/qYNI7ZZRy6Y+iQ3YUCkocQHp90xS98pAGkL4mZ2TbJYSJtJ/5N1T6Npn5
	gxZ4tUVgPpnSnzuOr3gICr2yMT3PUwjT7JId6PxZCl4rvpN631mCDYrgWQAKHFDI
	PZN4WWV2VZCxI4oiedR6AOn5ESTDUhg5i2FcDWGZKGEL92u07nsdPjbBL7c9HwTA
	U3dpK+LVTHgQlrJQ3TEejJG48rnfYIbeIkrubGk/TUPh/vpYXyjaQ8BIqxNQ45Ah
	qI8mXVjEpqTQS5RC6BB9xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723189203; x=
	1723275603; bh=mboX3krB7igLGhZuMPvm5bs7qXeswVH5zMlbTOV/Y9A=; b=X
	KQjgJHzvJgXVYJonl3yVh5rRKdWsXz6X6QYAhiHSu9AfWQAFWF7zOKLcP2XH1FQN
	sCPxh/AzuCPSvU1qFjSRTkvwZCxa6fSIS6I2MkokhzwYrujCRbjhI8QVeSI+azPn
	3AUReLFEbEjbeMa/lmvp6/dhtJ2YFn/Te0RnTisLwKo5f3Pybme0f78jIm078b6F
	QdzoCUVRivhwhF66AO2KVWGu8cBJGOF/3WZVK6sSvcxmbz+cp4/fF3VegScL+dra
	njWaJgEZ2G7gkE5fmdecGnZQPuUQUVjFF+3fvTxyQkYP0jl00e6ccJHvjNs69YQP
	YWc/VvxUR2wFN5LOrYSJA==
X-ME-Sender: <xms:08e1Zj6KaUY2HnLd06p4qWfWC8FKDZGHSDYEDjHEPuiFo8LtgptL-A>
    <xme:08e1Zo6sQUreaPZIsLDV-A8tbDTaIr6k8cqZ3deWuNPwioZih5AFumpcrITdRckdL
    gnRRG6CvuQKDFHw_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleefgdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfofhorhhtvghnucfjvghinhcuvfhilhhjvghsvghtfdcuoehmohhrth
    gvnhesthhilhhjvghsvghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefffehgeekieef
    jedvieejtdefteelhfdtkedufefgiefhjeeujedtgedvtdeiveenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmohhrthgvnhesthhilhhjvghs
    vghtrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:08e1ZqdkRs15_sGqlGd0neFcUcPer1vvRVRXsQoiFFcMkyhnUsH2Fw>
    <xmx:08e1ZkJRPoZLoY2tnMbIp072pcyl64VEPY8kurOwwco3owYvpPBbAA>
    <xmx:08e1ZnKppYbV-3iSgvBte8z7sSHYUC81h9pmK7b09MKZVbcRjJ_x1w>
    <xmx:08e1ZtwtxLz768zkwxpc2kJp71r7cU9qpiSHwJDc6F3qL8mzBAuwVw>
    <xmx:08e1ZuWy3Uf8UxaUrrs-hoMEVOmsxkBg_UZJ9m7YCaIsWGvHcvqqQ5WT>
Feedback-ID: i7bd0432c:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0E232B6008D; Fri,  9 Aug 2024 03:40:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 09 Aug 2024 09:39:41 +0200
From: "Morten Hein Tiljeset" <morten@tiljeset.com>
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <dc25520d-e068-49bd-9faa-07c6f6928c35@app.fastmail.com>
In-Reply-To: <20240808-kontinental-knauf-d119d211067e@brauner>
References: <22578d44-b822-40ff-87fb-e50b961fab15@app.fastmail.com>
 <20240808-hangar-jobverlust-2235f6ef0ccb@brauner>
 <e244e74d-9e26-4d4e-a575-ea4908a8a893@app.fastmail.com>
 <20240808-kontinental-knauf-d119d211067e@brauner>
Subject: Re: Debugging stuck mount
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> The file descriptor could already be closed but the task could be stuck
> exiting and so queued task work including destroying files wouldn't be
> done yet. You could also try and see if you can figure out what tasks
> require your workload to do a lazy umount in the first place. That might
> bring you closer to the root cause.
>
> What kernel version are you running anyway?
That's an interesting idea about the stuck task, I'll try looking into that. We're not
doing lazy unmounts on purpose -- I'm only concluding that it must be happening based on
the mount namespace being NULL. I wonder if the lazy unmount could happen implicitly
as a consequence of some other operation?

I'm on kernel 6.1.53 and I've also experienced the problem on the 5.15.x series.

