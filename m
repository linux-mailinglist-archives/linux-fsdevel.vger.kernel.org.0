Return-Path: <linux-fsdevel+bounces-51203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C506BAD45F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31374189E5CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 22:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A5328C03D;
	Tue, 10 Jun 2025 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="OIvzHK+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SzYUHwkp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03991242D7D;
	Tue, 10 Jun 2025 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594409; cv=none; b=icAlwjLQfWnjsaQRxmzpxtIRvypZ71RuSBna50yMdhghoMhCdt446SGyVZY38URZcPTKFOQa7TA++0hZdMOE2VnCsgzblm3H18r3RqUNO9UxoNGHkbC6mTcUm4ORtLMIRpOUGssNGAcPtHKqmTny03t+xfqSaSM7xQuT2KHoqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594409; c=relaxed/simple;
	bh=n8Q4u2oeyOV/7+exq8azslKtTa2cYnR5fxSWc0KScxc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EeX7eE3y5VoB18jp6S6rH0nS5zM1OALG1cp+6Ve3vWae4nNzeNwSFLRVptbjxDS2aWaBnG2NBALlQFiyag4pTxI9VGh9Q9orZNgA9rGg+tEWCtMMkM2erlCAyQReZTlt3XiDzn/q1oNP8Zqo7//oRTI2UwsZgrjWvxxtQ+PUY34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=OIvzHK+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SzYUHwkp; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id E19692002FE;
	Tue, 10 Jun 2025 18:26:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 10 Jun 2025 18:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749594405;
	 x=1749601605; bh=TxAnDEWJjQsKX26bwE46ame44kXTPSaz+0UXyq1anCs=; b=
	OIvzHK+K6Tfy6RB6U4Jns32ib4vRtt7zkMrmZPFB/IM29aKjcQTs22DFN1+JrMI0
	NJe2io+254WdvKYyNYM/h0jHpcKX+7HjMa2wTAs1JexjcTaGChj9AgmDGoBTmF4Y
	mP6SVWscVaNiSViTcEO8qhut6MMsUgFZ/1YCmxy7IcRwh4omDhFqtjQ5PRESfgBn
	8YzAoytXOBLaDfXOF8zCmyzkFf9gTwp/GzD/bj9Ezcbuj1/Gz0DBgZtW0yFdkTfB
	m0Lm4MDY9+Hz1UGy3OgDYmoFs8kHcHTvBgR7bOulRIHQ6HjgvCaIJWN/3RpL9NXu
	ccJEh9DDbyh3asuksIrBcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749594405; x=
	1749601605; bh=TxAnDEWJjQsKX26bwE46ame44kXTPSaz+0UXyq1anCs=; b=S
	zYUHwkpatPE5DmHQMXURlWceO6/Xr9241OzrPNC5wR4hDA1HQvwc87Fsal1Nejb7
	hlSaNvKO/dmX1OKjHyIxI/5Zx4sgkcNmcDYsqiuPi9iQq3Jn+FuywMEHZxQ257jB
	/Hd49YbsfUvmtHVWbyHIIo9Vgl6os97jmPv1t4eJA9R8S148zi0pZwQfzA7Y1WzF
	HV3ADwxMB11tI5ZK7qCsb54Un9icIwYIYYL8NgZ8r5GS2iYAj6MbPlKe+7W+KZlZ
	FtqOh3qHkspgIsvVe4xI91nm9ldTgyEKGI4VZXKiLl8yGHxlfApn7U19y83LjsCT
	go3jMeqmxNRhwyxwkYwSA==
X-ME-Sender: <xms:JLFIaKFnBAS5bR4XB4wiKssU2_fEjDwWRXYpfTLyiFggD6q4svqG-Q>
    <xme:JLFIaLXhXBkxRePNPL1Bvc2wbOhI6cmJuGfSAceaw-2kkDGo9IE48cWogwcnD9EqQ
    QO_Qvi5yO6kk8MQQH0>
X-ME-Received: <xmr:JLFIaEIQkT-5YS7sYuUPvWGNPenACNYPPPKEAHrAS9QqF2SfqxN2Xr7fRaDssVcAJcZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfhuffvvehfjggtgfesthekredttddv
    jeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpedvgeduuefgudejgfdtteffudejjeelleeiudekueejudeh
    tefghfegvdetveffueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepvddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopegsphhfsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrih
    hthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JLFIaEGkGuPc-ZHIo2fTCLBNjfrkcLmdcfLodzJyLOv2Af9sDeOdhA>
    <xmx:JLFIaAUaGqiaWfBpvoWs-zuEgr6PS_sNpConKTnVXV_UAiDUOFjAaQ>
    <xmx:JLFIaHMuANo8ROhHG_OEcaqpafbD87NO8KIXakg5IzDidkSPE0ueZw>
    <xmx:JLFIaH2qcPoeib2UOGrqOx57u33HIi-kh-nlyNs8ec2RufFDK47HAQ>
    <xmx:JbFIaKEOWGvRZRhdNbaTX6Iq_7XYUXUvezcGjKK8FHo00ftQBgTU2hFa>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 18:26:42 -0400 (EDT)
Message-ID: <d7d755ea-5942-440b-8154-21198cb6a0f1@maowtm.org>
Date: Tue, 10 Jun 2025 23:26:41 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tingmao Wang <m@maowtm.org>
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
To: Song Liu <song@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org> <20250610.rox7aeGhi7zi@digikod.net>
 <CAPhsuW5G0Th+9dRSmxDjo5E7CxV1E9N8AiKjw3cKyEhOBVWJFw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAPhsuW5G0Th+9dRSmxDjo5E7CxV1E9N8AiKjw3cKyEhOBVWJFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/10/25 18:26, Song Liu wrote:
> On Tue, Jun 10, 2025 at 10:19 AM Mickaël Salaün <mic@digikod.net> wrote:
>>
>> On Fri, Jun 06, 2025 at 02:30:11PM -0700, Song Liu wrote:
>>> [...]
>>> + * Returns:
>>> + *  true  - if @path is updated to its parent.
>>> + *  false - if @path is already the root (real root or @root).
>>> + */
>>> +bool path_walk_parent(struct path *path, const struct path *root)
>>> +{
>>> +     struct dentry *parent;
>>> +
>>> +     if (path_equal(path, root))
>>> +             return false;
>>> +
>>> +     if (unlikely(path->dentry == path->mnt->mnt_root)) {
>>> +             struct path p;
>>> +
>>> +             if (!choose_mountpoint(real_mount(path->mnt), root, &p))
>>> +                     return false;
>>> +             path_put(path);
>>> +             *path = p;
>>> +     }
>>> +
>>> +     if (unlikely(IS_ROOT(path->dentry)))
>>
>> path would be updated while false is returned, which is not correct.
> 
> Good catch.. How about the following:
> 
> bool path_walk_parent(struct path *path, const struct path *root)
> {
>         struct dentry *parent;
>         bool ret = false;
> 
>         if (path_equal(path, root))
>                 return false;
> 
>         if (unlikely(path->dentry == path->mnt->mnt_root)) {
>                 struct path p;
> 
>                 if (!choose_mountpoint(real_mount(path->mnt), root, &p))
>                         return false;
>                 path_put(path);
>                 *path = p;
>                 ret = true;
>         }
> 
>         if (unlikely(IS_ROOT(path->dentry)))
>                 return ret;

Returning true here would be the wrong semantic right?  This whole thing
is only possible when some mount shadows "/".  Say if you have a landlock
rule on the old "/", but then we mount a new "/" and chroot into it (via
"/.."), the landlock rule on the old "/" should not apply, but if we
change *path and return true here then this will "expose" that old "/" to
landlock.

A quick suggestion although I haven't tested anything - maybe we should do
a special case check for IS_ROOT inside the
    if (unlikely(path->dentry == path->mnt->mnt_root))
? Before "path_put(path);", if IS_ROOT(p.dentry) then we just path_get(p)
and return false.

> 
>         parent = dget_parent(path->dentry);
>         dput(path->dentry);
>         path->dentry = parent;
>         return true;
> }
> 
> Thanks,
> Song


