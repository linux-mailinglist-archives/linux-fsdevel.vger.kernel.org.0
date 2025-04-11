Return-Path: <linux-fsdevel+bounces-46275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D0FA8609C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 16:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5424F4679EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Apr 2025 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A31F417A;
	Fri, 11 Apr 2025 14:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="Hk/jymRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZPNVHNPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A1226AD9;
	Fri, 11 Apr 2025 14:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381773; cv=none; b=J8ur63XKnDaQDDnWdkF6TUsJR4rcuWO5b7C8bW0lV6jeP7J747T/3WXTvivWN8/Fayer6d4QJPK7RCt712V/i4bFCo1fBK1AzSejwtD4EeTkyvUxjKXfK8iXuELJyHvk6QgCAwGtFR9aAALSb8tdaMi0MsIrh+k1aSztyame7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381773; c=relaxed/simple;
	bh=Fr7pBHRQUwrq8mG1Siu5C41KQwrsNWFub2BvHEpnhYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laXut8fxYyKei75axKf50c1RTfniYt6dlg/ftI3eSao88/wPHoYlWn6oWB2mHUWUghwOlqBQjkZEC3i53GXO1CqNROXlXi/uaOb2xvIs5/7EAJ/gXffelaL/2WjVap1vMmTBJLlOvnwAAol7bI4eSY+fD9SuQmdO1a6207jrNvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=Hk/jymRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZPNVHNPS; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 167EA13802AB;
	Fri, 11 Apr 2025 10:29:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Apr 2025 10:29:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744381770;
	 x=1744468170; bh=hQvzssuOivYR8Q+o0ul4zKYc+bQGnbH8XMYUw560duo=; b=
	Hk/jymRoMMHWwNm10LmffWLC5oLsFv6PVq5qiyIJM3Bdoi2N79ihLMoQ+GkNMnbV
	26lgjxkN5UCfxkfN8MTXtGgqu4SfdHPDgbyPhtVxkNiVwB0PyDcbtWOQ6Sv4K82m
	YLtD/2z9T6k0BiT9zUlW+52OtEtv6UUhh34xgucoGEY+OAYlQdPM/TrkGgl141Tq
	PEMTeJh/h0Wj3mYB3LqdE3TDOwRCuszQs25zLvIUPh8j26jn7UT7XnyHohFrYXX+
	cALnvPtJqR617wr205zt1gak6JqzSI89UZKVg7tvP+zlXcWC4NKsozPVR2NBOmcc
	85Q8Pyu3ihjwqy33EUO+eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744381770; x=
	1744468170; bh=hQvzssuOivYR8Q+o0ul4zKYc+bQGnbH8XMYUw560duo=; b=Z
	PNVHNPS0TpTB8sUN4qEeCKl8Eo53pFi8Ph2DU+HOykO4YCTD/qpUv311paPloMhu
	w0DJrig7+BbhO1szBBAKwO2IOZvzvLL2cUFx67FYfoMUJi1aPe7Uk+JlEB2YKVBU
	1X9W8XFZINxL9w8b38bKSZI/lnRPTP5qjXEOtaVKniDMBMGztixwJyq9829dg4aL
	scTIDFeJgqBcznXmEiEAMCNw4TXJR6dQiZPO+olzYeHiyzAj86UGsGSmV0hG91DM
	rnPgy9+XNe9lED/abfN9g3cGubrjifeewjjNirvfiVl53qRZRMSa0ubZGVHVFWaM
	8jP0Wc3q7sr5sOhdFxQXg==
X-ME-Sender: <xms:SSf5Z0kaeKsTqFmABL1MO2APEmU30KeltUOw009KO5_szPMpzuotcQ>
    <xme:SSf5Zz3jAruGVOD6j4pQsfwwfB_AEpWbJl-6SxQPjQieLtQiQqT4MjUYIjcmfngjJ
    wQpmSygS_yGZC46>
X-ME-Received: <xmr:SSf5Zyrn_5FY2aEvvez0jmTebIRTyBQQT8h7Ouof2TiSe-Jw3YwvVrTZdLor-1GqrOpjYSqFR1y217vjwjK5UtYXM6M6-lCmwtap2UkOwHFZ5ixTSIC7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnheptddugefgjeef
    kedtgefhheegvddtfeejheehueeufffhfeelfeeuheetfedutdeinecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmhdpnh
    gspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhh
    nhesghhrohhvvghsrdhnvghtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughird
    hhuhdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthho
    pehshhgrjhhnohgtiiesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhoshgvfhesth
    hogihitghprghnuggrrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepjhhgrhhovhgvshesmhhitghrohhnrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SSf5ZwmVQN_n4TqhEHOGGtJKbrofZW-8doEV8x_khKBSfmgd6FBocw>
    <xmx:SSf5Zy1P9YIktNk8SQSIPcpeJEVm2qg_-tZE-Yh8b1YuSUbH1O3Rtw>
    <xmx:SSf5Z3vA96tc1C0Oh9Co3jv0WHp5k9DhJG7eUlWIrFxZel0T3phjQA>
    <xmx:SSf5Z-UHbV3qEu8XslNVy7Z3JHzWprPUF_na5fL_RXb2V4OWyWAwoA>
    <xmx:Sif5Z4i6lS7aPCaSpX7hBqUl9E2S7YTzoShEdMMxhDLi9aPAQrAa3oqF>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 10:29:27 -0400 (EDT)
Message-ID: <7b3cc835-28cd-4258-985a-c9e236b71620@fastmail.fm>
Date: Fri, 11 Apr 2025 16:29:26 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: famfs port to fuse - questions
To: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>,
 Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Joanne Koong
 <joannelkoong@gmail.com>, John Groves <jgroves@micron.com>,
 linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org,
 Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>,
 Eishan Mirakhur <emirakhur@micron.com>
References: <20250224152535.42380-1-john@groves.net>
 <yt5zatqobd5wa27l6nownqheqvqxfz2wkojqlbj5jsu2uz52am@fh7uud2u4v4b>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <yt5zatqobd5wa27l6nownqheqvqxfz2wkojqlbj5jsu2uz52am@fh7uud2u4v4b>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/25 16:11, John Groves wrote:
> 
> OK, I'm on track to post the first famfs/fuse RFC patches next week. This 
> will be a kernel patch, a libfuse patch and a pointer to a compatible famfs 
> user space and instructions.
> 
> Dumb question: where do I post the libfuse patchs?
> 

https://github.com/libfuse/libfuse


Thanks,
Bernd

