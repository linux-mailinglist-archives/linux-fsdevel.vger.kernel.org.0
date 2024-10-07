Return-Path: <linux-fsdevel+bounces-31206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57285993026
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F428A394
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEF01D7E37;
	Mon,  7 Oct 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b="u/43ePR2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PGesNq7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780EB1D88D2;
	Mon,  7 Oct 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312899; cv=none; b=b3I5BFLbgWEh0W0it331KFdc2aq8uhwFL+dBe1FXiIoQELgm1gj91ejwoCHHOt+fWxrAvfzlnblW1UhCYEDiRv0ErJ+jHdNRYrZYfEa9Bh9BLzyISWAb0TSPvx2xlNY8fT6f9sj4IiQOn9pRdqaZzMCtCC2Tc4lBnB05d9dvnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312899; c=relaxed/simple;
	bh=Chjdo4B4945DNyZFQ5W1A0sxa6Fj/cOk0C6uKPSllSU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:Subject:
	 Content-Type; b=cNs2s/sEoAIDkbMUiS3YDgGK0F+BW+b1/ISl0A+ThRbRj0VGmgDKSgJMZIUYGSO+RL1i/Wg8V5bWOAyzTOCVSmrG6w2Dxo+UTZYrUGMQTKPcIV7+f5HN+2yO5GT7Lu4m+MeZVVAZE00eV6mkA8Yhl4GzxV9erO9o9M4Mq6dTASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org; spf=pass smtp.mailfrom=joshtriplett.org; dkim=pass (2048-bit key) header.d=joshtriplett.org header.i=@joshtriplett.org header.b=u/43ePR2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PGesNq7c; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joshtriplett.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 711DC138024C;
	Mon,  7 Oct 2024 10:54:56 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-12.internal (MEProxy); Mon, 07 Oct 2024 10:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	joshtriplett.org; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1728312896; x=1728399296; bh=+zETDJVIuuQb6NDuacP4RzC0wFbiECMa
	xhOidZj2O/c=; b=u/43ePR2Yj3tNsFZIekl1St3DhWeQTPJ2wmuqlP/tT02iyuV
	UXLz/9owPRgxKE7JB2vfBLgcpoW/pzLpeHywuCa5gZ8qhnLG839tvunBObG70r+h
	5K8L28ZK76WLSOsfpNDLeEoOJEnqN/Nu1kUIIGvGKhsYzwogTTcQXx+/EfnIM69Y
	9X7wQ7WbSO3idpE9jqVR3pPe9vpVFzQ05G30aDxdbJS2yIqnmvTEfstr43700u8w
	xZZEvWC2EkxU4ZGKlwvgMQAW+0kRLN204VEb+s18dJ6B1LGx9W8P5OlzXe12+/V4
	BwR1r19bBtsi7CAvrrguOCACJg1K5prOaBBMtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728312896; x=
	1728399296; bh=+zETDJVIuuQb6NDuacP4RzC0wFbiECMaxhOidZj2O/c=; b=P
	GesNq7cqsklHQMavEWBalymh92VS5ZAu7KwUe8Zg0p6KCepttM5K68tu9k+JuOQq
	Jxs+FqdMOLiEg5WxFwenidTbUSKRiDEz4n9sAJ2nRtziirCeE2k9GiTFln6IbmgF
	nITxYrMgZiSfISZ0gZmUtLtQIyeWgZ8tEoEAZE4iOtndVj2oLQjTQsE3wbKZJpRj
	/vLQoimfMQbZ00ChIm6q6q11N6yP8w1v9U703rzXDOZlAjgbvAx752q8pNKZH9HC
	ttn2iaj+tgvFmKg0TES541u0kGMKto2c7qR9VbCjosKgbO//mm8F68YVot78j99Q
	iMaW83fbTOZcVw/n17B/A==
X-ME-Sender: <xms:P_YDZ2AamqeK6E2b_wGq0zz2mxp58JMVBo47sUxnGCqg4rKFOy2L6A>
    <xme:P_YDZwiXxai1W-G06LPar51zlMN25nXvwqNSeimcLOQ0uCYyYZ9M2lOAkaEva-VoZ
    idRJgESe2aN3rUbmGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvledgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefoggffhf
    fvvefkjgfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhoshhhucfvrhhiphhlvght
    thdfuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueehtedufffffeevudevueejffefveeggfdvudeijeeuffethfehfeehlefflefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhosh
    hhsehjohhshhhtrhhiphhlvghtthdrohhrghdpnhgspghrtghpthhtohepkedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrrdgsohgttggrshhsihesghhmrghilh
    drtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghulhesph
    gruhhlqdhmohhorhgvrdgtohhmpdhrtghpthhtohepohhlvghgsehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:P_YDZ5nWkoRcLmG-yYq1dMsFQbWSfmHHKOAW2T8UdMOqexJNNVXMig>
    <xmx:P_YDZ0xBQifq1LlSisunHDivIR2g4iV0G2nvhKznwWPgZCVW3EeJdA>
    <xmx:P_YDZ7TZM5RiEEJmOdGXHBOn9lwspsO0G8Rlajt70UxMvfKJBCJWxQ>
    <xmx:P_YDZ_YFgvqRjeieNMxRcpmKgYshK6sVGPqd2KQ6w1kDnrbOSnpYfQ>
    <xmx:QPYDZ0TzYscl_K3aEOQ-OqunpKHQq-leK7fPIzhVrq6nvxodWf07FRZM>
Feedback-ID: i83e94755:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B40183020080; Mon,  7 Oct 2024 10:54:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 07 Oct 2024 07:54:35 -0700
From: "Josh Triplett" <josh@joshtriplett.org>
To: brauner@kernel.org
Cc: jlayton@kernel.org, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, luca.boccassi@gmail.com, oleg@redhat.com,
 paul@paul-moore.com
Message-Id: <2ab879f1-2938-4ece-a6b2-be34e4ad4c5d@app.fastmail.com>
In-Reply-To: <20241004-signal-erfolg-c76d6fdeee1c@brauner>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Christian Brauner wrote:
> struct pidfd_info {
>	/* Let userspace request expensive stuff explictly. */
>	__u64 request_mask;
>	/* And let the kernel indicate whether it knows about it. */
>	__u64 result_mask;

I don't think it's necessary to have these two fields separate. The kernel should write to the same mask field userspace used.

In theory there could be an operation to probe for *everything* the kernel understands, but in practice with a binary structure there's little point finding out about flags you don't know the corresponding structure bits for.

