Return-Path: <linux-fsdevel+bounces-62081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD82B8390E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 10:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827124A370E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D52F7459;
	Thu, 18 Sep 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lYGWU1n9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jDXhMLqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74D2F3C21
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 08:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184735; cv=none; b=CaUtZgJbiVXQ3CAjcjXtS3EC5HN9gRTNh85TUbkeNVCy6Tk+q9308/bDEZADczc+tqV0Iqwi+aanKlz0JlAGBbIrqK+jfBFGnPNhZuzaLlwUAISGI1aUvgqVmYjgQU3DVukGSXmc8aCezWQxcM6SFCh2HzomtTL47L+HtPc9n/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184735; c=relaxed/simple;
	bh=G8WzSGFPHxEstLChRXKwgJv1NUV4+915caYraa9HJfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=A3xBGOFSlPbBBBbadGbEZ1mAhhhYP5myjbEY9+nOcBPG68R02VTb/v5QdeePcVb9BOmjw+vbmAIp9K2MGinDLF6EcwyKoU7o49uiTe768y5nvAB9a9MyuYZzK9OYFmS+sFet3KfgiBY5i1UWRlIsVgQpmPlHYw1uo0zNP0Nk6bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lYGWU1n9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jDXhMLqq; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id CE9D31D00308;
	Thu, 18 Sep 2025 04:38:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 18 Sep 2025 04:38:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758184730;
	 x=1758271130; bh=FYmQvDTRl040Q1SYSX7rEdiO8HJKUj/rnYo0a6lVRH0=; b=
	lYGWU1n9M53lph8vec8HYBFJjL+ewVP4ogMcgRKgdlvXXqu1KsslqZeDi+rCzp3V
	WY1JETp6ZdIwLViAry3Wi5TA2orSq7FGOW8tIGyYVdIM6ULpg15dlERnD1WseJXe
	CDvoIyBn4lzlhvUZk4r9c2WVp5P9uEOntPo/PhK3sh00py4zEIXlXMD8BNmaeF84
	vnzD2/QPkP7XDqumAyG0Sa0XoUvmVsOqXeYg5ZibQSkZIWzg9W/sRYzHlklWGz7d
	pWNyDlTy2fayEP0vceD6wiej4BJLiffeWKpEXtJCXXxqEgTr5zyddsRf2JB8eNFI
	OZ96UeJDAWAHN0RiFEO9pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758184730; x=
	1758271130; bh=FYmQvDTRl040Q1SYSX7rEdiO8HJKUj/rnYo0a6lVRH0=; b=j
	DXhMLqqRxm0S9Xf6sMy/jDOj82vXlHI1/gfPwCnrYY6fKbZYT0Ef7PQY1Ife9r2A
	kJIrGA9LYQPR/ZXiEC130mji+V9v3Bqzhvd3XIznGoVUkwE5BO3mOgWTx/ESp/iK
	jUxZBGjnk1/xg3AR552/X15Tmh8TXFRkcAIvjlXfNnR8dcRLt0VKbkq9z5aNcbUj
	J52rsXUixEvQodBOqcQ+/sK2McxOBu+zH/q8jaY8koNfarXEeErMYx5uqW7OCFbk
	DJnVsz1kwSZcCnyzCUPHDG/uutEDiErHiG1Ne4VDmHDtvm7zNz5st+njPyl8IPUC
	T5g/jQvWxzfLNCmz0QsEA==
X-ME-Sender: <xms:GsXLaNHIEj2IuMbaNXpH650BYU8hnAo63MZJh2w7iFiiHnltNRzssw>
    <xme:GsXLaCg9YHRaltgj6InTO-7wgPMqVLLz1XsLx8uX0ys2IDjH0CZGOk_miaJGYX_cn
    RsYcSKewA2AWUf2>
X-ME-Received: <xmr:GsXLaA9DpjzxKqk0pwG6KB_3gBYOnakf0HOac724rbnCii203hRXuPsFj3NWIviLqDsG10TuY3FSB8xPwSBMbEkpa6HrJzDXF3kHkwqUFfzJ8aGfwU69>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertd
    dtvdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgusegsshgs
    vghrnhgurdgtohhmqeenucggtffrrghtthgvrhhnpeffveekieelleeifefhieekveefve
    eiteejleejfeetffffhfegheehteethfelhfenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmpdhlkhhmlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegutghhghdvtddttdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GsXLaBqFpPDeIJSI0Z7fetfT3tdesJgGxnC52RUDe3HzHYoELRRrOw>
    <xmx:GsXLaH_zMSOuIIAf_-kKOMUPxN7ipOaQ6W8XbyEdWhUAeX2t17Ic2w>
    <xmx:GsXLaNV5sVOxs0Szk8Dsy83fWJvjtMJreZqngg4jvCRKeraC8Vd-mw>
    <xmx:GsXLaFA1NM6vs5TDjQgsDS8x2v8r-pxBL8X4VH_tx0zKOf9XDfyK2Q>
    <xmx:GsXLaNonF7if4KspKOiw4ksipDyAAS3Up5h5tNQRM1JARARKoGEp-NbJ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 04:38:50 -0400 (EDT)
Message-ID: <dbb91af0-ef9d-4a17-852e-ffaa1c759661@bsbernd.com>
Date: Thu, 18 Sep 2025 10:38:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fuse over io_uring mode cannot handle iodepth > 1 case properly
 like the default mode
To: Gang He <dchg2000@gmail.com>
References: <CAGmFzScM+UFXCuw5F3B3rZ8iFFyZxwSwBHJD6XwPnHVtqr5JMg@mail.gmail.com>
 <E1CDDCDF-0461-4522-985E-07EF212FE927@bsbernd.com>
 <CAGmFzSe+Qcpmtrav_LUxJtehwXQ3K=5Srd1Y2mvs4Y-k7m05zQ@mail.gmail.com>
 <5f63c8e3-c246-442a-a3a6-d455c0ee9302@bsbernd.com>
 <CAGmFzSe66awps9Tbnzex3J8Tn18Q6aEVF3uJnwJfVAsn36_yrg@mail.gmail.com>
 <CAGmFzSdD71SxAxCJp5BbJZ7-JVARtoDPPScGvxhTF=+HQ+D6jw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
In-Reply-To: <CAGmFzSdD71SxAxCJp5BbJZ7-JVARtoDPPScGvxhTF=+HQ+D6jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[Added back fsdevel into CC]

Hi Gang,

On 9/18/25 05:05, Gang He wrote:
> Hi Bernd,
> 
> Sorry for interruption again.
> About enable fuse over io_uring feature, I can back-port the related
> kernel patch set.
> But, for user-space libfuse, when will you or the team release a
> tag(e.g. 3.18)? then I can upgrade the libfuse directly, rather than
> back-port patches.
> Second, Fuse over io_uring mode cannot handle iodepth > 1 case
> quickly, I feel this is a by-design issue, the iouring uses the own
> thread queue to handle the requests from the user space. I write a
> kernel patch, which can fix this case, but for the most cases, we
> still use the current design. the patch is attached, could you take a
> look at it, to see if this patch make sense, or not.


I will try to find time to release libfuse-3.18 today, one io-uring
related patch is missing (re-init of some fields in struct fuse_req) and
then just the release process.

Regarding queue balancing, please have a look here:

https://github.com/bsbernd/linux/commits/reduced-nr-ring-queues_3.1/


The tricky part and which is why I didn't publish v2 of this series is
to keep performance for blocking/sync requests (like DIO, metadata,
etc). At DDN we run with an additional workaround patch that disables
migration in fuse_request_end(), which results in kind of
wake_up_on_current_cpu(). Adding in wake_up_on_current_cpu() to fuse is
simple, I have the patch, problem is more that wake_up_on_current_cpu()
is not perfect. I'm just in the middle to walk through scheduler code.
For example, wake_up_on_current_cpu() gets perfect after increasing
/sys/kernel/debug/sched/migration_cost_ns
Now I don't want to change system wide migration costs, but it needs to
be time limited change when waking up from fuse. Additionally it needs
to be a hint, depending on if the queue has more pending work - that is
the part that gets even more complex with reduced queues and queue
balancing.

Also see https://lkml.org/lkml/2023/5/3/646 and related threads for
reference.

Thanks,
Bernd

