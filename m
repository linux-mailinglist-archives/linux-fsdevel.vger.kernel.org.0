Return-Path: <linux-fsdevel+bounces-9331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E712D8400B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A95282F52
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 08:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98A54BEC;
	Mon, 29 Jan 2024 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rath.org header.i=@rath.org header.b="A72hjZtC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOygT1qE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492954BCC
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518629; cv=none; b=OK2AjdNZjfg2+FLpP5YpqQHHBYwArR3voCJuoW9lYtU1K1rmso1xsoxGA9IkIzR8ydZ4pL7PQj1xMeEvSwTInU867uZkQgSG695P+U0jiOQ/w6AjqKbfp8ABIETCbkTPnuPyFeMzLzmWfeD/CgogemFdofnppLZdFk2hJeC0am4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518629; c=relaxed/simple;
	bh=STLGFry2tq1Kft8zpy8x9J63tdIsNtHo1KkUQPHMdBw=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=XljddQuBgqo7Z31S36DtTMfT+aeYHRRBbzqG7f6K2PBTo6j6s03opT9iwBejQSRziQEXmlXaH74zuDiN53Koe1bsglz8UlEbqaECtQt8Hc/tfdmSZX6JP9GBm634koVGyV0tAlwVVW3gy5fhYww29d5SnerjJO91Ore80OeUkBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rath.org; spf=pass smtp.mailfrom=rath.org; dkim=pass (2048-bit key) header.d=rath.org header.i=@rath.org header.b=A72hjZtC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOygT1qE; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rath.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rath.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id B25775C012B;
	Mon, 29 Jan 2024 03:57:05 -0500 (EST)
Received: from imap45 ([10.202.2.95])
  by compute6.internal (MEProxy); Mon, 29 Jan 2024 03:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1706518625; x=1706605025; bh=STLGFry2tq1Kft8zpy8x9J63tdIsNtHo
	1KkUQPHMdBw=; b=A72hjZtCo+Zuk2ctG7HmmdvRoJpUh9mQzlRxSMYiv543rbXP
	C9nc5eWXBJpZrGu36Zi09dhf+be9REXWrcWrZcwCXhLVEPYpmaidn5FJHAkJK5zm
	PhEBXEPt/3iJdRg/sEVwqEa5jIoJfO5FdjqclWvJH2CjSg0V6sTTH1Z16gmv2NK8
	T5ygEw8XT+fyqNOialrqL6zXGw7KvQB0NMgZWoJlL8RyDrKpjV3lyF2/Cnq+Mw+H
	wwOsRucvihA8BPtyFnjqy1sdAmQQsNmqHGjib/9rMGq8yvUrYdi5BlBKqa55fSbz
	/Daxz1AmhLWhp59+Yhcdg+XsyDPK4YoraaqRtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1706518625; x=1706605025; bh=STLGFry2tq1Kft8zpy8x9J63tdIsNtHo1Kk
	UQPHMdBw=; b=dOygT1qEpn2g5Rg1S/jxiYaENmybLR6noSRoR/wmVBvV+qt2F+P
	9XO4D+OjHeXxBbrCxqRveVxDg/i7jVeDg8ooSOmL+YstofFvQzRbFCSXEdxiQrXL
	QH+XptSP0pA/fmICzbf2mEKpcCSz1jmon1Jgx0Kb7VMKeR2lI8X5guv2o6Jadenh
	lo0bn4TkNYg958aRQtBo66qzsXOXZULDBJ6i8bkgK217e67FxFmazzxMS1CTBADH
	pn9pFfjmJqNtjsyw6cJQeNZoTQbmNllhVGMfm5QOKHW8lJqUD0LNOHlZmN5VYEoT
	A2596EI6/xQwYDEtwfNVZDPIXHNdBtF45Jg==
X-ME-Sender: <xms:YWi3ZRYHJyLODlmmOaB5RYYTV1lXFWBhYWS8lSuvXAX9s3Xoa7pHSA>
    <xme:YWi3ZYbkOX9hu_YdlJwhtQu5bovOvsWrUlQj3C7nENhor2PuJJYdS9UbH6p2kNOqo
    EWRtMTaqWxX3byf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtfedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfpihhk
    ohhlrghushcutfgrthhhfdcuoehnihhkohhlrghushesrhgrthhhrdhorhhgqeenucggtf
    frrghtthgvrhhnpeekjeeitdejgefggffhjeefveeffeefgfejtdelhefggeefheevvdek
    gfefleekffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehnihhkohhlrghushesrhgrthhhrdhorhhg
X-ME-Proxy: <xmx:YWi3ZT8J3wV7pOOYMmwgzFrg4ZhoMmK9HEFYJtTd1xIUpivEvUF5UA>
    <xmx:YWi3Zfr1PE_jEOfieJKqVIRd_ECR7cGPrc37Qf9hFs2DqV1nW3slow>
    <xmx:YWi3Zcobr0xWEqwf240Vkdakb1UpAp5ZFzGdSDVg09BcWhjKy7wyhg>
    <xmx:YWi3ZdddXBtjqGg9VzRKVTRj-mxvcKQKlDZIkGDHzIQtTYHRSKdelw>
Feedback-ID: i53a843ae:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 603E4272007C; Mon, 29 Jan 2024 03:57:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com>
Date: Mon, 29 Jan 2024 08:56:44 +0000
From: "Nikolaus Rath" <nikolaus@rath.org>
To: "Martin Kaspar via fuse-devel" <fuse-devel@lists.sourceforge.net>,
 "Linux FS Devel" <linux-fsdevel@vger.kernel.org>
Cc: "Antonio SJ Musumeci" <trapexit@spawn.link>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amir Goldstein" <amir73il@gmail.com>,
 "Bernd Schubert" <bernd.schubert@fastmail.fm>
Subject: Future of libfuse maintenance
Content-Type: text/plain

[Resend as text/plain so it doesn't bounce from linux-fsdevel@]

Hello everyone,

The time that I have availability for libfuse maintenance is a lot less today than it was a few years ago, and I don't expect that to change.

For a while, it has worked reasonably well for other people to submit pull requests that I can review and merge, and for me to make regular releases based on that.

Recently, I've become increasingly uncomfortable with this. My familiarity with the code and context is getting smaller and smaller, so it takes me more and more time to review pull requests and the quality of my reviews and understanding is decreasing.

Therefore, I don't think this trajectory is sustainable. It takes too much of my time while adding too little value, and also gives the misleading impression of the state of affairs.

If anyone has ideas for how libfuse could be maintained, please let me know.

Currently I see these options:

1. Fully automate merge requests and releases, i.e. merge anything that passes unit tests and release every x months (or, more likely, just ask people to download current Git head).

2. Declare it as unmaintained and archive the Github project

3. Someone else takes over my role. I'd like this to be someone with a history of contributions though, because libfuse is a perfect target for supply chain attacks and I don't want to make this too easy.

Best,
-Nikolaus

