Return-Path: <linux-fsdevel+bounces-43743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 976D5A5D30F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 00:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27954189AB83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 23:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FF522FACA;
	Tue, 11 Mar 2025 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="R33NVmO7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H9wdx+rP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFD14F117;
	Tue, 11 Mar 2025 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735137; cv=none; b=k+ijuTrwv5OdrvqnHkAD54gEqjrNz1NDG7xDAqHksOgfj7L6D0hRqJ4a0Lpn1NOELOW3gxybsfLTatJ8CcWKou/NwdGeimyPJCpRD4zploDONeh08wJmhLKGzcnNNCLcj0N83oevk6cOCHjvVMjW32mQB9mnDVXkWPukJJkBXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735137; c=relaxed/simple;
	bh=BTSwDeUVq9UPDpqm8BsNvk6ciNap3kvZUI0Bdc1MGYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ha4WxABfzkt6uWHpOyuto/Jyklcn3AMH6jE/NtaLTkVe/SSpOgeXtSBMNHx+RmAd6CWr8IG51WdaPuTXWCKvG/pjH94LfPuSkh8UnlDcM6WpOnk4OaGIJAqEKFiwhhgYNaU3EtuHvg9lh9pZgaTThIuZKltlHtTvbBtKkuOnjEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=R33NVmO7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H9wdx+rP; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 2D5C21D41267;
	Tue, 11 Mar 2025 19:18:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 11 Mar 2025 19:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741735133;
	 x=1741738733; bh=crRX9uE+ooOi0V96Xu/LVXF8iKiANj0u/9DiYRjeUUE=; b=
	R33NVmO79gQ3N1/zbl38kymGXlM0XMrqmgHk9qC4HAdT00alctgR0fcs9mrnXIjS
	IZ0/cK5WB+2R8q+KomYrohAhv3ul85J5iZA3O5sPd6kpSWlQ5eb6tuIVO8Xjly5R
	9bmNKVM47fjmsdTMEVENUVoq3RyzmiKfD9gaqAX0D7AN58Vp4IfojpUX+Bt2icox
	I/HWuz5oYsdz39J5kwjYFphY7JxKFLTwKqHq2r/8LF0t5yi78dmLMBzV2E2LDoA/
	zgRr+kX5APXRxCXBS5mvjBHp/X2WxEiPdevuZLQfRR7c3zVzS98DJjAzJXV8F2lJ
	QHKmUxTBIHIlJAIPBqQ7cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741735133; x=
	1741738733; bh=crRX9uE+ooOi0V96Xu/LVXF8iKiANj0u/9DiYRjeUUE=; b=H
	9wdx+rPqmmry9qevd5In2rFNVsNKO/Yqf7n+WzyYDhC/3GkEa0CfOSNNHCi0IMiq
	MbrzHhW6Tc7vo2Z4FAWAZxkofR5SHAaoqFnl5nyPA1ePGjB0efsvZ9t7QaCmtaGi
	EvSFkewFdXIq2q6dNYFpavlbRW27ftlMj0sYfn9zUT7X3FxLXxDAzLEpmc4K3jwW
	GIu429U7QxIOtCaTHncmaN4/Isiu8SpgOCzooNRP0j1tp0t+xuCuTcV9HHnXeyEp
	M5OFV58zVd0Chi5CkzbVKk05seqC82D/nNlaYENxIPqRh4wYbb9cJtewqxHGnk7y
	5aTzZQY1wpSfUDR1hyyjA==
X-ME-Sender: <xms:3MTQZwrPsmiKejzJRzUZMs7bu2aMG-UGvkWVVRM7RrKTRl9tzdZ_EA>
    <xme:3MTQZ2o_UwtgpU9XxQhQlWgiPMB7UlKdEqHDpoI_KkcpE1lPNBXLE30qcn-RrMxyD
    ElZHvZvwS8WysCHQV0>
X-ME-Received: <xmr:3MTQZ1OUg_YmJn90ofjpTslIszpuaRTSfBu_ysdepS-67qZfk9A3tiErosQo0LdV6_k8aZtu6Cnyff9JuubDa_zGFvlw-DYB_yc9Q45rjfch_rFmoECTY8My>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhrgh
    eqnecuggftrfgrthhtvghrnhepudekvefhgeevvdevieehvddvgefhgeelgfdugeeftedv
    keeigfeltdehgeeghffgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtg
    hpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehjrggtkhes
    shhushgvrdgtiidprhgtphhtthhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprhgvphhnohhpsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:3MTQZ34lsCj0emFBvVp9gRmBzOCKwPQkfwh6Sy4viUevCpIu3aepuQ>
    <xmx:3MTQZ_7uGqWcngwBfhoyGAhJdkQgjPNEPGREI8FkQnl6ycluR0NEAA>
    <xmx:3MTQZ3iSPpY791yiazrdpKrWOAx1tPTf9T2l3tmm5fzf0Bz7qSGGhQ>
    <xmx:3MTQZ56-ebniW9vwoRqHp1-OJ-1YEWjq2H2rLJZVVkYZBmiz31WyHQ>
    <xmx:3MTQZ1T-VKVCl3MvHz1oJyKwMN7gwbmI8yoBSWbP6U_fgmj5mAC00ozu>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 19:18:51 -0400 (EDT)
Message-ID: <63681c08-dd9e-4f8f-9c41-f87762ea536c@maowtm.org>
Date: Tue, 11 Mar 2025 23:18:49 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/9] Define user structure for events and responses.
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>,
 linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
References: <cover.1741047969.git.m@maowtm.org>
 <cde6bbf0b52710b33170f2787fdcb11538e40813.1741047969.git.m@maowtm.org>
 <20250304.eichiDu9iu4r@digikod.net>
 <fbb8e557-0b63-4bbe-b8ac-3f7ba2983146@maowtm.org>
 <543c242b-0850-4398-804c-961470275c9e@maowtm.org>
 <20250311.laiGhooquu1p@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250311.laiGhooquu1p@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 19:28, Mickaël Salaün wrote:
> On Mon, Mar 10, 2025 at 12:39:04AM +0000, Tingmao Wang wrote:
>> On 3/6/25 03:05, Tingmao Wang wrote:
>> [...]
>>> This is also motivated by the potential UX I'm thinking of. For example,
>>> if a newly installed application tries to create ~/.app-name, it will be
>>> much more reassuring and convenient to the user if we can show something
>>> like
>>>
>>>       [program] wants to mkdir ~/.app-name. Allow this and future
>>>       access to the new directory?
>>>
>>> rather than just "[program] wants to mkdir under ~". (The "Allow this
>>> and future access to the new directory" bit is made possible by the
>>> supervisor knowing the name of the file/directory being created, and can
>>> remember them / write them out to a persistent profile etc)
>>
>> Another significant motivation, which I forgot to mention, is to auto-grant
>> access to newly created files/sockets etc under things like /tmp,
>> $XDG_RUNTIME_DIR, or ~/Downloads.
> 
> What do you mean?  What is not currently possible?

It is not currently possible with landlock to say "I will allow this 
application access to create and open new file/folders under this 
directory, change or delete the files it creates, but not touch any 
existing files". Landlock supervisor can make this possible (keeping 
track via its own state to allow future requests on the new file, or 
modifying the domain if we support that), but for that the supervisor 
has to know what file the application tried to create, hence motivating 
sending filename.

(I can see this kind of policy being applied to dirs like /tmp or my 
Downloads folder. $XDG_RUNTIME_DIR is also a sensible place for this 
behaviour due to the common pattern of creating a lock/pid file/socket 
there, although on second thought a GUI sandbox probably will want to 
create a private copy of that dir anyway for each app, to do dbus 
filtering etc)


