Return-Path: <linux-fsdevel+bounces-10326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C0F849D54
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3357A1C21358
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4AF2C1A3;
	Mon,  5 Feb 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rath.org header.i=@rath.org header.b="AVZF5PWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t7/xxBl7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EEF2C1A4
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144397; cv=none; b=T18iNDYb6T0EtO3DFUsBZfFN0B1IhGLcd9+pFjVOfyQDB7/FvisvdpvNM/twyQzcht+yIEPt8ZASYEGna9GOHDW3NBqeibu+2jwlltKxKHbC13ckwQaX3p3prdLkdKUNyiB65mDy+kdFOUGD3Wou8xfg4F4xA0oQyDNE3/vMy94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144397; c=relaxed/simple;
	bh=hqeZzq7P9tsR+mtQdbZkamUt+217cQF1ubZdN1p4urA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oSjfgchNxGtupoYxqIEkVjd2tufInL17U9d7ylhAgU/OnTG9YHgzkg07YftVtz1Rp9ilHAdff+CAG+EROpKrGqC1/HUp6QojmEc3S8sOpzrijYcvaafQlEtQXrPFsyK4BhI65dwwzWC9p+1GFGSe1V5LreS6QmUnPq1QT3+Aw9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rath.org; spf=pass smtp.mailfrom=rath.org; dkim=pass (2048-bit key) header.d=rath.org header.i=@rath.org header.b=AVZF5PWb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t7/xxBl7; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rath.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rath.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 0DB573200A12;
	Mon,  5 Feb 2024 09:46:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 05 Feb 2024 09:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707144392; x=1707230792; bh=hqeZzq7P9t
	sR+mtQdbZkamUt+217cQF1ubZdN1p4urA=; b=AVZF5PWboauCi9aJ8xTmTtOH43
	buXXGQFAU38u35XpKE1IDSHVjheb3ktTRF6k3a6AOuMQBA45mPOdCAetLNobUuF2
	6O7xCVDk0bY0+oxq9NDPMpLtXnVN+N/CDWU9u+WfwvaJvaZMkJe6LmkPOvWM+RoA
	zC47idDRofHxJhEhJdkWZ/YE87fSHsRbiquJAA1QU8ANsFV0ImtV6eHNkmbOPSuX
	0KJGzV//diXSxYs5aBVLCi2HZOzQY5U5XKrLdrEjBWRs9mohI6wCe1AANwsx6nL7
	G0R43GSCX/p+VuAbeEgZu+Uj4yy74YsUGEvtLmbPx2Q+Z2B/+3eTEqjUEWaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707144392; x=1707230792; bh=hqeZzq7P9tsR+mtQdbZkamUt+217
	cQF1ubZdN1p4urA=; b=t7/xxBl7bS6jfKo5xRKTCb+b53GgSrkzMdxvWkX1SHIr
	QbOGO3JlQsSYDjpHC0dnMaPKd461TZtC1WASLy2bLyKQTtEN1sB3h9klH0lCtxex
	irIMh2mjQlbKDs5ZlHgMPXLUtgSEqTNXy7Z8YBvQBUlnuVd3oYDuleNyPZR0F51d
	Gu6nw2WAltlCPqPTyPb6bGw/y9zEc/KEggahjKFw7i8d9K+e4PK0Wpg52XYz+92n
	rS/R936UeDiHnWE9zHNfeIqGHdsGWwuQxKcD8wbevE5bZMeR9Kzz2e/r5P4cdmmM
	NIm4QwETfSDoyEbf2ltlx0NyS7JQBHJd3YEPqlvy6Q==
X-ME-Sender: <xms:x_TAZb0kfh3M19sutPUHkkplCVNLyt1wZ6Q80N_kZ6kK3IFDqWUyng>
    <xme:x_TAZaGO6e-tLPTbYuuHPux4dNVYE2R7PeQncgXVcKOuHEh_XkvWObccuOWrqyYn3
    Vb1ylLe-H-8xWTF>
X-ME-Received: <xmr:x_TAZb64Yg4gAQEwQd_BlgF0xUMVDPdH3rtdQjhXYMn5CysYUGQy6ZROiCV0DEZPoQeIEq2whL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufhffjgfkfgggtgesthdttddttdertdenucfhrhhomheppfhikhho
    lhgruhhsucftrghthhcuoefpihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtffrrg
    htthgvrhhnpefhheeiveekjeeujeevfeffgedvgfdvudeifedtffeukeelvddtteettdei
    ieffffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    fpihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:x_TAZQ3JDiqypDLdPjRcggUabA-ZnR1pcOuvCPsrH2tmFu2xK6Fu4A>
    <xmx:x_TAZeEMLQt0U1u8OW5FQiMVDYPDgjmL4l4-443jvgwAHYjTklq5wQ>
    <xmx:x_TAZR8-E7qakDW_w5aAy0Pr18z0qhTsB3ra_HsEkGq6acy44xi5EQ>
    <xmx:yPTAZR0DyLCE5FGYuEBHNIAXgNecy2fKRrcXtiLEzOrFM_WNOsqXPQ>
Feedback-ID: i53a843ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 09:46:31 -0500 (EST)
Received: from vostro.rath.org (vostro [192.168.12.4])
	by ebox.rath.org (Postfix) with ESMTPS id 38E8517D;
	Mon,  5 Feb 2024 14:46:30 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
	id B09C33F681; Mon,  5 Feb 2024 14:46:31 +0000 (GMT)
From: Nikolaus Rath <Nikolaus@rath.org>
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>,  Linux
 FS Devel <linux-fsdevel@vger.kernel.org>,  Antonio SJ Musumeci
 <trapexit@spawn.link>,  Miklos Szeredi <miklos@szeredi.hu>,  Amir
 Goldstein <amir73il@gmail.com>
Subject: Re: Future of libfuse maintenance
References: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com>
	<9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm>
Date: Mon, 05 Feb 2024 14:46:31 +0000
In-Reply-To: <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm> (Bernd
	Schubert's message of "Mon, 29 Jan 2024 10:22:07 +0100")
Message-ID: <87mssf9dfc.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bernd Schubert <bernd.schubert@fastmail.fm> writes:
>> If anyone has ideas for how libfuse could be maintained, please let me know.
>> Currently I see these options:
[...]
>> 3. Someone else takes over my role. I'd like this to be someone with a history
>> of contributions though, because libfuse is a perfect target for supply chain
>> attacks and I don't want to make this too easy.
>
> I'm maintaining our DDN internal version anyway - I think I can help to maintain
> libfuse / take it over.

Thank you for volunteering Bernd!

If no one voices objections by the end of this week, I'll transfer the
repository over to you and send you the release key by email.

Best,
-Nikolaus

