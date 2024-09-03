Return-Path: <linux-fsdevel+bounces-28454-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9432296AC48
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 00:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE27B2130B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 22:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86C91B9827;
	Tue,  3 Sep 2024 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="bLmc0mm9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwniJ5ae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pfhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA7186E30
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 22:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403084; cv=none; b=PP9z6fXggzPKSJRPQ1SlO7ATBlV5mkjlhdzWv0OycO133sXzFRZZCDDD8qUVYjU9nrQWLk2xpSXjQOASAxYsmjexHD8/c9bH+2SvwX+bUoAbqE1ivxCTZ5OE5m83ZX1XAcaRoF5jiAHmCI5NAPIBk84IjOj/Teiqk7nQy+A4nQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403084; c=relaxed/simple;
	bh=Hp8vADAbPCgyRaWXVX8BFmsT7qu+mGbjJdIXw46+zRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCKgjbSCI1pzmN8xl7Cx9JH8mVl3pd38SBrGWUB+67t7aIQJXutOTLDuATuRuA2zL0nEQ0yt+24AN60X0GleGV3TYqziqOoU0IJJvmLXPKULaizE7lJaqiPcYH6F/toBYuPuLK7GbyJdqUEWr3pwasDGA2Mr+FnHF7Yz0zOLOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=bLmc0mm9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwniJ5ae; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A6DE5114047E;
	Tue,  3 Sep 2024 18:38:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Sep 2024 18:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725403081;
	 x=1725489481; bh=FT6/ws71RbBv93Q+ptc7Na+/5wr0QnoILTYalU2ouOQ=; b=
	bLmc0mm9nxsIhcXgAVMCwOKAta9xmv0XHNuPa8i5UAwjsU+4CDPiTlpRvuZmIoGx
	Vt09RN9Efc9N1mOR4Sg/e5XJPnbsV/WXsvWx3/Mfdjlyd81Xn7/mpUbjV/tmmHUd
	t82sSanYJQvOB9KYLCFfOyXrMJkW5CKjYa0okSEVihFqExlKlNUfItAUWlBcGms2
	lgXoRCJC4m8LmYVJOZ9cAw644jxr5SSDFnFpPdszbc7vGr4WszZYnLyrhGVBwGc2
	Tgn1rPvOfMk94P5Ppc25J88m5m3hTOcwTDIjs//+/tlEmYiZw5FubpZ75Bo5S/fa
	jJUAZUxURn0JL8EAeame5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725403081; x=
	1725489481; bh=FT6/ws71RbBv93Q+ptc7Na+/5wr0QnoILTYalU2ouOQ=; b=J
	wniJ5ae8v2lwWDs5TK0FNJa67hdQBj3BImKHOaby0GwhL+gj9nngyQr8e44DWmbg
	iE+BKTI6xxROsjNlKhmTSYJ9oyMvfq+wtxv0LSVxUJ0ht2A9sB3WL3m/oNzaLs3M
	sOmAzbUFjGeJEwTDK6zH/5QhvM7ePXcELBLDILu9EQpQrtiaJeonUWAAcnFm6ZC1
	jx+obmS+/wHBpF96xFWYHS374y7qngX5mgPizdXI8wGN4r2jzFoFKU6lKsLZirxn
	0Yxm7KM+zxuSANJIY4eq5/vuupL8qC/l0QK+biNwXtQcy+fLn2+QoU0roubndVU3
	odtSPtkCoiCjCTbfN/qkA==
X-ME-Sender: <xms:yI_XZh-0i2FaGUBFW675r8q7YQhpvc6OJejcmkP_0sYym1ZyTJoTww>
    <xme:yI_XZlun2UIM1RqivbEx38YgxSBFTS3voZFbB5TgJVuFYfB5EPwzCJeJRs1dAQGWs
    XRLMdwefbAaWDwp>
X-ME-Received: <xmr:yI_XZvBbTCw4xabhnjxG-HQ0AutRV-Wfqv0a5omMr1V9wxIKW7LqzNfrhYbKFPYmG3moRlDxR1LP83vn4Q9VPFA_GELpOJBaD-C-OkQMUiAvak_7VLPy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuhgsvg
    hrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudevudev
    leegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggvrhht
    sehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgt
    phhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhs
    vghfsehtohigihgtphgrnhgurgdrtghomhdprhgtphhtthhopehjvghffhhlvgiguheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlrghorghrrdhshhgrohes
    ghhmrghilhdrtghomhdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehmvghtrgdrtg
    homh
X-ME-Proxy: <xmx:yI_XZlcxQJ3fWQQ-F_aRCVAZL4qJhysHpfrfHtU7h0GpuuQywaB9iQ>
    <xmx:yI_XZmPwIMtf4CPni9k73msh26cfNMPA4Pwgd61PV-7yV57LQ9BiRQ>
    <xmx:yI_XZnnoKQvnMCIuqm1TuJ3hBH-FKOnDdONR6pFDMGwKEWR446SudQ>
    <xmx:yI_XZgtD3hc1KCtL8FVJWz69xeR4YdKZ0DNbfJKhfHEsuPD-82YqLA>
    <xmx:yY_XZle-N5T9RROXNye3fIZONEWL5y_TQ5qquFwex4WCCNOs6bosTB62>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 18:37:59 -0400 (EDT)
Message-ID: <02b45c36-b64c-4b7c-9148-55cbd06cc07b@fastmail.fm>
Date: Wed, 4 Sep 2024 00:37:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] fuse: add optional kernel-enforced timeout for
 requests
To: Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com
References: <20240830162649.3849586-1-joannelkoong@gmail.com>
 <20240830162649.3849586-2-joannelkoong@gmail.com>
 <CAJfpegug0MeX7HYDkAGC6fn9HaMtsWf2h3OyuepVQar7E5y0tw@mail.gmail.com>
 <CAJnrk1ZSEk+GuC1kvNS_Cu9u7UsoFW+vd2xOsrbL5i_GNAoEkQ@mail.gmail.com>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1ZSEk+GuC1kvNS_Cu9u7UsoFW+vd2xOsrbL5i_GNAoEkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/3/24 19:25, Joanne Koong wrote:
> On Mon, Sep 2, 2024 at 3:38 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>> On Fri, 30 Aug 2024 at 18:27, Joanne Koong <joannelkoong@gmail.com> wrote:
>>>
>>> There are situations where fuse servers can become unresponsive or
>>> stuck, for example if the server is in a deadlock. Currently, there's
>>> no good way to detect if a server is stuck and needs to be killed
>>> manually.
>>>
>>> This commit adds an option for enforcing a timeout (in seconds) on
>>> requests where if the timeout elapses without a reply from the server,
>>> the connection will be automatically aborted.
>>
>> Okay.
>>
>> I'm not sure what the overhead (scheduling and memory) of timers, but
>> starting one for each request seems excessive.
>>
>> Can we make the timeout per-connection instead of per request?
>>
>> I.e. When the first request is sent, the timer is started. When a
>> reply is received but there are still outstanding requests, the timer
>> is reset.  When the last reply is received, the timer is stopped.
>>
>> This should handle the frozen server case just as well.  It may not
>> perfectly handle the case when the server is still alive but for some
>> reason one or more requests get stuck, while others are still being
>> processed.   The latter case is unlikely to be an issue in practice,
>> IMO.
> 
> In that case, if the timeout is per-connection instead of per-request
> and we're not stringent about some requests getting stuck, maybe it
> makes more sense to just do this in userspace (libfuse) then? That
> seems pretty simple with having a watchdog thread that periodically
> (according to whatever specified timeout) checks if the number of
> requests serviced is increasing when
> /sys/fs/fuse/connections/*/waiting is non-zero.
> 
> If there are multiple server threads (eg libfuse's fuse_loop_mt
> interface) and say, all of them are deadlocked except for 1 that is
> actively servicing requests, then this wouldn't catch that case, but
> even if this per-connection timeout was enforced in the kernel
> instead, it wouldn't catch that case either.
> 
> So maybe this logic should just be moved to libfuse then? For this
> we'd need to pass the connection's device id (fc->dev) to userspace
> which i don't think we currently do, but that seems pretty simple. The
> one downside I see is that this doesn't let sysadmins enforce an
> automatic system-wide "max timeout" against malicious fuse servers but
> if we are having the timeout be per-connection instead of per-request,
> then a malicious server could still be malicious anyways (eg
> deadlocking all threads except for 1).
> 
> Curious to hear what your and Bernrd's thoughts on this are.


I have question here, does it need to be an exact timeout or could it be
an interval/epoch? Let's say you timeout based on epoch lists? Example

1) epoch-a starts, requests are added to epoch-a list.
2) epoch-b starts, epoch-a list should get empty
3) epoch-c starts, epoch-b list should get empty, kill the connection if
epoch-a list is not empty (epoch-c list should not be needed, as epoch-a
list can be used, once confirmed it is empty.)


Here timeout would be epoch-a + epoch-b, i.e.
max-timeout <= 2 * epoch-time.
We could have more epochs/list-heads to make it more fine grained.


From my point of view that should be a rather cheap, as it just
adding/removing requests from list and checking for timeout if a list is
empty. With the caveat that it is not precise anymore.

That could be implemented in kernel and/or libfuse?


Thanks,
Bernd

