Return-Path: <linux-fsdevel+bounces-36066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6714F9DB625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 029C7164507
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9305192D66;
	Thu, 28 Nov 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="FtMXRgxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FdFV6ZI1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E0D13A3F3
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732791649; cv=none; b=M+LfZ569WfhvqwlIfw8s8CuL6d6jaCkwBnFu9a9nfAZqyRpynU1Cfg/EI/FJPdGDbulfoDZPbY4t6pUs1+O/wHVLOe9wc87jriX1FRILtHZY62BF+TxAo8vahIdPCbb4iD2dWSeEJY1eu2vBu+x91rO+uiqx2x+jRtihMT4FgaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732791649; c=relaxed/simple;
	bh=z09OXfJfU2yRdMkhEjg83cTjan2U5ec4oCUNmThn7Kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lH8JAQeHJsmygwKy3CBuiQ2W7OJKIZQOsjZT+P4w8/do3CBYOCvFrsexPkV8W1aqPwXJ2E9yVTLG6CPPq65HV2hna2OiWn1/fQXxcSUSyOzUUdvDHUIOEn9+tf3lFO1ILIbnvNnr9d5gJL9or4i68Injkn6kAdXnSlNWsUkK1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=FtMXRgxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FdFV6ZI1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8FA4F25401D2;
	Thu, 28 Nov 2024 06:00:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 28 Nov 2024 06:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732791646;
	 x=1732878046; bh=nfFnfrsqBOJWW5MRKWHo0bHObzI9nYMWE59i1He4GWA=; b=
	FtMXRgxZdPXsh6ZjcI0apneTasRHGcP8CXumUaoQZiUnd5H09i6YTYeEZ3kzJDSg
	IPFjJvY8JeBNGNQLd+w1wuaXjPXuiD86+uMNjQC9mdHofW1FG+q0OB2Im/20sJUR
	jyLc2nzXfdLgulsHn5hO8L4K3lP5dEyjZ5LMoTmqrOci/MPgKi051TzUbqYimBfE
	mviqLw03eKTJGqoR7uQxGZVNPTsu8ozgSAMIjqVtXp0I56RNslAzYst7x0IE3paO
	KQSPoU+0xFqhw4ap3d8reu0oPUCAZHJC5ERYZuimURVqMOtHh2VfYEM26g++cAtV
	jYDl5N0/6rIpm9erYw3NuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732791646; x=
	1732878046; bh=nfFnfrsqBOJWW5MRKWHo0bHObzI9nYMWE59i1He4GWA=; b=F
	dFV6ZI15F9OkpF4kUD4uPNYj+ZvMC8YL+bMFEWr8OaU570jMEEbqjtVNdP6oegGr
	nckuIYPiJTJKeVl8JrmkxHaOB9YfKumBcjyMk+hWPSuYJKbIJH+jTvBfH5+3mJct
	n8KYaDlKWsC20/C1WxpRlgW2WAHCgkSgVJywdsinOetcRYm8ssXwWxDnQaNxB0by
	H6AtMQ7Ez26Kdh2fdyH/YuhwEXoStOTuZ5pIoN4uZx8y1WI4W7FvQxen0XdEsman
	F9Y5dyBjknlm1RSPignVq1RBQ/Owyyvi79MGmcccxvPXCXhzPVk2Jpbi4Mz0owle
	2Svo5LjAz+opRqKd2QH1g==
X-ME-Sender: <xms:XU1IZ5f-vJnxNl6fWkQqlYBk9Zie2w6PexLdXk5FanYUC5_5ZMJiIg>
    <xme:XU1IZ3MsXi_kJ3xhTvsuzDkfdejx6iFK01XNKtTrIfdi-2jcHccupuh3PRzQLBiUO
    Hlx8K1PF4f0N86A>
X-ME-Received: <xmr:XU1IZyiXbHKadZK6Luc_Hs8y6KPiDSVytsnbog8tJ9tEdRBV783W_FqUpknvYIoTHIiyhvYKXq-F2QBYLeQECKJW6WxQNESO2MdETRbyQhXDWG8CeMjt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeen
    ucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrh
    htsehfrghsthhmrghilhdrfhhmqeenucggtffrrghtthgvrhhnpeffjeevfeefjefghfef
    hfeiueffffetledtgffhhfdttdefueevledvleetfeevtdenucffohhmrghinhepkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepsggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfhhmpdhnsggprh
    gtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsvghnohiihhgr
    thhskhihsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjohgrnhhnvghlkhhooh
    hnghesghhmrghilhdrtghomhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdr
    hhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohhsvghfsehtohigihgtphgrnhgurgdrtghomhdprhgt
    phhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtph
    htthhopehlrghorghrrdhshhgrohesghhmrghilhdrtghomhdprhgtphhtthhopehkvghr
    nhgvlhdqthgvrghmsehmvghtrgdrtghomhdprhgtphhtthhopegsshgthhhusggvrhhtse
    guughnrdgtohhm
X-ME-Proxy: <xmx:XU1IZy-4zZW5n0HdMHS7anYWeszB5cebk32Ok9qRMzFugLSQv7b_gw>
    <xmx:XU1IZ1tqqWXYJpQ_bUfI4_fc-SztgqZYZIe4YsZrlvMJl0algjqDFA>
    <xmx:XU1IZxGnevWRrhx5gvnsWrk93pYCgVfrP1mKWqNR3VtP60nioLU_fw>
    <xmx:XU1IZ8P5m-vg7avYA765W4pJ-8pZb6bUHIhnxN234ejlq9Dtw5Wa-w>
    <xmx:Xk1IZ7JCDdeMDBQQwMMWj3H0N4TW0XiGTMo0iVJOajXfp1uhubGwsH19>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 06:00:44 -0500 (EST)
Message-ID: <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm>
Date: Thu, 28 Nov 2024 12:00:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com,
 Bernd Schubert <bschubert@ddn.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com>
 <20241128104437.GB10431@google.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20241128104437.GB10431@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/28/24 11:44, Sergey Senozhatsky wrote:
> Hi Joanne,
> 
> On (24/11/14 11:13), Joanne Koong wrote:
>> There are situations where fuse servers can become unresponsive or
>> stuck, for example if the server is deadlocked. Currently, there's no
>> good way to detect if a server is stuck and needs to be killed manually.
>>
>> This commit adds an option for enforcing a timeout (in minutes) for
>> requests where if the timeout elapses without the server responding to
>> the request, the connection will be automatically aborted.
> 
> Does it make sense to configure timeout in seconds?  hung-task watchdog
> operates in seconds and can be set to anything, e.g. 45 seconds, so it
> panic the system before fuse timeout has a chance to trigger.
> 
> Another question is: this will terminate the connection.  Does it
> make sense to run timeout per request and just "abort" individual
> requests?  What I'm currently playing with here on our side is
> something like this:

Miklos had asked for to abort the connection in v4
https://lore.kernel.org/all/CAJfpegsiRNnJx7OAoH58XRq3zujrcXx94S2JACFdgJJ_b8FdHw@mail.gmail.com/raw


Thanks,
Bernd


