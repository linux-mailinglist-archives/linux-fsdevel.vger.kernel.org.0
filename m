Return-Path: <linux-fsdevel+bounces-51213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B770AD4776
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 02:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93046188802D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7877115E97;
	Wed, 11 Jun 2025 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="M72LdKSz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9ldIW/d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608479DA;
	Wed, 11 Jun 2025 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749601437; cv=none; b=bhtltWMCd88NQ6YpTF7gnsQ7SA/ZDKJIfhnDoa/wwP0XfNPH9WUHCDobIbSMd7+qyrc84XJHGwjH9aqKUWoNpyiEn+/IvO0Kk0DFx0lvzhpyRDQYRHakoLPSqYIiqv7WZjYiQp/hxe1vIxux5Ne4tJ+ttdg6bLpDPnq+aRsHYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749601437; c=relaxed/simple;
	bh=qgHubdTxv57bGTk1of/rJdqy+LmbhQpEv1QKoORclIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDPN/LFPk6ABd7M7l+g6ZbETPlv5cf8JKu+mBcVQc3LUvxHapspUlblqI3CuB42Vs3te81HPdVTBCCziSnFa29ZG2nEA/hm6JMda7wk1ISd0ZT9pj0FJEAj4gKepDNIEjuqPDoqANJDdNIUK4/uOt/rnD1ksgBg2sImzRXqrSfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=M72LdKSz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9ldIW/d; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 1A61220069B;
	Tue, 10 Jun 2025 20:23:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 10 Jun 2025 20:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749601434;
	 x=1749608634; bh=pW98W2lJtLiwekAVVtO/Jv1f0oaMGloSBkI5n6j43Js=; b=
	M72LdKSzFi6AhpmBdMfq0W92Tm4F+b23EOtvf0QijTWVEEzc0L3GHw7lBU/A5AI6
	SEi0ySR9D4xPY/vwXiwC5EKE1rfMoNXuJdQ2QcGfot5UKBa0INCsAumLTyRKLcX5
	9DMTKU6JNYQQ5Wv4u91A5D7ADSc+y4j0kJb47MZZ0qff2QZhX+HPZ2GTQlVZH5QX
	cOG5PVcfwEvxIfUamVSscQRx85h2wmsYxg0G4PLSAEd/ebem334b01AJIX63yqi7
	+qBw4bJYHhPF/FHH3EKTVNaAQwgRqdUzW+WKw+k3lJYiX+A6GesQDqZrpGVQAl82
	q64MHqH8w+Gp3DZpxLSCmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749601434; x=
	1749608634; bh=pW98W2lJtLiwekAVVtO/Jv1f0oaMGloSBkI5n6j43Js=; b=j
	9ldIW/dQiRlFRacP1GEB2LIcOnmifUwPDSlREdtYRAvBAPp/3IE8aaIXYgCnq/B3
	1aOExY2rgxuymZlMsermw/8hopiuKsqIBRqx7iTydfSZUMTr0NnpeQWBeYEcgX/r
	DMfsUtxfodWCGuup77mN3faaVYw4nQrxAejUEuSck371wkla1fH0Nss3R9iUQv27
	1prglVnUFQ00M3RbWQVkKuEUav60ra90J2JH9heTkswJcNZPHNpAEtk2S9UHpT4S
	LIqyhNgUcwHOHQfTMdkNkmW3Q5pcbBjxGQJusAqjMkd5CNIUjUPAox8HQRwPvT4c
	Ha81AU2AeAJeKUL1vshQg==
X-ME-Sender: <xms:mMxIaM-J3F-UveY-ExtQ-LI_cm_-T7vD1fIINkoxPcoFrKQDp8KdDg>
    <xme:mMxIaEvDgMloit5gffJYIgsHdGK9MK6gzyBrmJX_KPt_OTPf1KBzOMaYtgHlw1Zyd
    lr_PNJfD4XS2ZJbM64>
X-ME-Received: <xmr:mMxIaCDhzIUhVoROK8Bgx_cE-tDllChgeYkk1rxXXc8Jq4Ly8V0lttf46cDL1_l5ssJv9NinuToeLFOSIErgcVjk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepvfhinhhgmhgrohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqe
    enucggtffrrghtthgvrhhnpedukeevhfegvedvveeihedvvdeghfeglefgudegfeetvdek
    iefgledtheeggefhgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohepvddvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhitgesughighhikhhougdrnhgvthdprhgtphhtthhopegsphhfsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvggtuhhrih
    hthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgv
    rhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:mcxIaMcG4phxurxcpgZhcwQnMUYOVP1L-m2qOXuRG_pDAYedkj53sQ>
    <xmx:mcxIaBNxCzhiR5pOWCz2vzWj4oHDvvM0w5lEWlfOGiqC2VcdbndfTA>
    <xmx:mcxIaGnT4FwAHpwEbgBatl1A3ISJHAwnimz_wBUWFK4R56p0b6zOCg>
    <xmx:mcxIaDvrE-9NZcas-megW6Igl_E1VPR6QSAlGKQNKEts2hseFcIO5Q>
    <xmx:msxIaLeTqSY8DMUIwV40taV0eTdtJIqtHiprr-cO9XnZdq990jByXRvn>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 20:23:50 -0400 (EDT)
Message-ID: <fd995e37-9369-4375-8718-8338e732860f@maowtm.org>
Date: Wed, 11 Jun 2025 01:23:49 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
To: Song Liu <song@kernel.org>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz, kpsingh@kernel.org,
 mattbobrowski@google.com, amir73il@gmail.com, repnop@google.com,
 jlayton@kernel.org, josef@toxicpanda.com, gnoack@google.com
References: <20250606213015.255134-1-song@kernel.org>
 <20250606213015.255134-2-song@kernel.org> <20250610.rox7aeGhi7zi@digikod.net>
 <CAPhsuW5G0Th+9dRSmxDjo5E7CxV1E9N8AiKjw3cKyEhOBVWJFw@mail.gmail.com>
 <d7d755ea-5942-440b-8154-21198cb6a0f1@maowtm.org>
 <CAPhsuW75h3efyXmCcYE_UEmZGXR5KMSEw8h-_vrZH82BYU=WVw@mail.gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <CAPhsuW75h3efyXmCcYE_UEmZGXR5KMSEw8h-_vrZH82BYU=WVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/11/25 00:08, Song Liu wrote:
> On Tue, Jun 10, 2025 at 3:26 PM Tingmao Wang <m@maowtm.org> wrote:
> [..]
>>>
>>>                 if (!choose_mountpoint(real_mount(path->mnt), root, &p))
>>>                         return false;
>>>                 path_put(path);
>>>                 *path = p;
>>>                 ret = true;
>>>         }
>>>
>>>         if (unlikely(IS_ROOT(path->dentry)))
>>>                 return ret;
>>
>> Returning true here would be the wrong semantic right?  This whole thing
>> is only possible when some mount shadows "/".  Say if you have a landlock
>> rule on the old "/", but then we mount a new "/" and chroot into it (via
>> "/.."), the landlock rule on the old "/" should not apply, but if we
>> change *path and return true here then this will "expose" that old "/" to
>> landlock.
> 
> Could you please provide more specific information about this case?

Apologies, it looks like I was mistaken in the above statement.

I was thinking of something like

# mount --mkdir -t tmpfs none tmproot
# cp busybox tmproot/ && chmod +x tmproot/busybox
# mount --move tmproot /
# env LL_FS_RW=/ LL_FS_RO=/.. ./sandboxer chroot /.. /busybox sh
  # echo can write to root > /a
  sh: can't create /a: Permission denied
  ^^^^ this does not work, but I was mistakenly thinking it would

I think because choose_mountpoint_rcu only returns true if
    if (mountpoint != m->mnt.mnt_root)
passes, this situation won't cause ret to be true in your code.

But then I can't think of when
      if (unlikely(IS_ROOT(path->dentry)))
          return ret;
would ever return true, unless somehow d_parent is corrupted?  Maybe I'm
just missing something obvious here.

Anyway, since there's a suggestion from Neil to refactor this, this might
not be too important, so feel free to ignore for now.

> 
> Thanks,
> Song
> 
>> A quick suggestion although I haven't tested anything - maybe we should do
>> a special case check for IS_ROOT inside the
>>     if (unlikely(path->dentry == path->mnt->mnt_root))
>> ? Before "path_put(path);", if IS_ROOT(p.dentry) then we just path_get(p)
>> and return false.
>>
>>>
>>>         parent = dget_parent(path->dentry);
>>>         dput(path->dentry);
>>>         path->dentry = parent;
>>>         return true;
>>> }
>>>
>>> Thanks,
>>> Song
>>


