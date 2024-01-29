Return-Path: <linux-fsdevel+bounces-9336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4645884014D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A1771C20D8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FC154FA8;
	Mon, 29 Jan 2024 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="DKbY3vpd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qyIV1Txm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1552F54F86
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jan 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520133; cv=none; b=hEOVszBRPHUd8k+BBu+TkOZP7po8RJte0dhNimpsLa5KJMuIFM5aaOvsczc1NIdzv2VgsCI+Hi3cy7MTm9SS3SCFSH/XRqVZ+n8YRCu+GGA8CD0CVEqZ635H+7R6P5UGp8ekTiushaj95cqbpKj+9IBfcoQ7b8GhImTRMREObqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520133; c=relaxed/simple;
	bh=th18CgkbqhNz1BrILvR/kyrOzjlqNDwOo6wtEPDvwMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfnPTc6NV6Ye9WT3u+G/QP3QegRUArOZFAhSdb60i99XTU2ulYZlhbU+f4cnnsyJAoupKpRrQr2pMilR3XWv80Gy5dGGMLwQ8IK7puz6INoxv03eJeIb3kNiwIFNyna7zMAxverHGZCeQ3lzdjNonajy15ABykfF2Y4rvQvwdoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=DKbY3vpd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qyIV1Txm; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 08CB15C00B4;
	Mon, 29 Jan 2024 04:22:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Jan 2024 04:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1706520130;
	 x=1706606530; bh=kRx4PIjLbz3OMoO4ufIqAXqiHAxblGyaQhTPqi7XN8I=; b=
	DKbY3vpdb2rqCqMftLQIABnjIoRmNf19mNIva5wisQy/8ZmOMbKrvLBPT/gmbWSr
	YRZWYLLE/DowGVrwtO3i72Nin7c72bUb7w2xf9vCisK7QYJlmWmdWRSXEbk+p2S3
	5kpluSA8nLInemCc+afUnlCVpqYeDqO7tUfMQa3iGOYTKA+zXhjiuK6SLVu1OJDQ
	5LU4adp9ygtgfoQylVKjKXcl/VnqGMsOuYdfb7NVi8W6i3Ue+7JEGYgxx/XPDFLS
	JCBakPHsKqjWIBQ5UvqC8FCovL9lBvzD6zwD8uVso+wAXqN7qcMb/2nMs7yMqUDd
	s6AtsBtaY5UkP0YBVvo7XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1706520130; x=
	1706606530; bh=kRx4PIjLbz3OMoO4ufIqAXqiHAxblGyaQhTPqi7XN8I=; b=q
	yIV1TxmQR0b+HpuhFUAN+gT4GW2W1BVXm7tu47dHEJo+wLJc9RhoaAdj42ZCQVRq
	pN8HT8HoMfYWkWAlnCBendVB6IGQqR88oQOAxnWM4TvyK9vntbug5calebF4bU44
	7ObhIpN0pZwPn9PU1N1jyzJ7dbJGZH4+W3SlPnmEXhqUFuMTQtCrbECMLKNk2To3
	DxImzk2Oe/CR2oHlfMD0xlixp6TjA2K8cs1k1suuXVh3z6fod4EwlsmXVhD0XenB
	vCQIA0mlsa7M0rq4b6AFRQpK8QbziKPjUISUjcfiO6if3hdU/8pgqgKE4Er14bpi
	FpY/XeAZ4Az4GbB9B0lPg==
X-ME-Sender: <xms:QW63ZWFYkjXO_-jEFWHyCRuxlxRpofJhCgKbuzZXwufWV0U7Odfu0w>
    <xme:QW63ZXXjGCpP2C--XemaLKZkfm36HW7R_DJY0_dWRhgU6eMCprwGCsbUyZlvu3PFF
    Rsp0fE7zQHlAArp>
X-ME-Received: <xmr:QW63ZQJPMGYqhZQvWkkoxMfyw4m1mSC7yZ0mBKdAjinwj1ga2QWHVbaqnKK611uO_LmchmqGCqoDdvEtWGQuYJa9Jn3Ko2PpM00s9Rto3wXvntfBkhcE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghr
    nhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrih
    hlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledtudfgtdfggeelfedvheefieev
    jeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdr
    fhhm
X-ME-Proxy: <xmx:QW63ZQHcSMDL4imS0JpTO9mXe2LkSYernD3Fcm6NBKfmzBpAKTRLDA>
    <xmx:QW63ZcVW3j_EetDW8YeJmAZ641NRBjDs3-Aj18XsdYMiOGsTm7pXIQ>
    <xmx:QW63ZTOMIkjapEQAdFzaQ0yviqJBVu6uvr6Qw0awu9rlN4_BXhVsgw>
    <xmx:Qm63Zawu41-S1Q4L8lCDToepl358IdOeeJvS4zV8PW85oQrs2qz-2g>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 04:22:08 -0500 (EST)
Message-ID: <9ed27532-41fd-4818-8420-7b7118ce5c62@fastmail.fm>
Date: Mon, 29 Jan 2024 10:22:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Future of libfuse maintenance
To: Nikolaus Rath <nikolaus@rath.org>,
 Martin Kaspar via fuse-devel <fuse-devel@lists.sourceforge.net>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>,
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
References: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com>
Content-Language: en-US, de-DE, fr
From: Bernd Schubert <bernd.schubert@fastmail.fm>
In-Reply-To: <b1603752-5f5b-458f-a77b-2cc678c75dfb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Nikolaus,

On 1/29/24 09:56, Nikolaus Rath wrote:
> [Resend as text/plain so it doesn't bounce from linux-fsdevel@]
> 
> Hello everyone,
> 
> The time that I have availability for libfuse maintenance is a lot less today than it was a few years ago, and I don't expect that to change.

firstly. thanks a lot for your great work over the last years!

> 
> For a while, it has worked reasonably well for other people to submit pull requests that I can review and merge, and for me to make regular releases based on that.
> 
> Recently, I've become increasingly uncomfortable with this. My familiarity with the code and context is getting smaller and smaller, so it takes me more and more time to review pull requests and the quality of my reviews and understanding is decreasing.
> 
> Therefore, I don't think this trajectory is sustainable. It takes too much of my time while adding too little value, and also gives the misleading impression of the state of affairs.
> 
> If anyone has ideas for how libfuse could be maintained, please let me know.
> 
> Currently I see these options:
> 
> 1. Fully automate merge requests and releases, i.e. merge anything that passes unit tests and release every x months (or, more likely, just ask people to download current Git head).

Please not, that is quite dangerous. I don't think the tests are 
perfect, especially with compatibility tests are missing. In principle 
we would need to get github to run tests on different kernel versions - 
no idea how to do that.


> 
> 2. Declare it as unmaintained and archive the Github project
> 
> 3. Someone else takes over my role. I'd like this to be someone with a history of contributions though, because libfuse is a perfect target for supply chain attacks and I don't want to make this too easy.

I'm maintaining our DDN internal version anyway - I think I can help to 
maintain libfuse / take it over.

Btw, I also think that kernel fuse needs a maintenance team - I think 
currently patches are getting forgotten about - I'm planning to set up 
my own fuse-bernd-next branch with patches, which I think should be 
considered - I just didn't get to that yet.


Thanks,
Bernd

