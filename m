Return-Path: <linux-fsdevel+bounces-57192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E4B1F852
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 06:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 346851899A93
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 04:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062611DC9A3;
	Sun, 10 Aug 2025 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b="dhavXmDC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from vps01.wiesinger.com (vps01.wiesinger.com [46.36.37.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA18F6E;
	Sun, 10 Aug 2025 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.36.37.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754800691; cv=none; b=F/I6n3NwNA0aIwsO+c9pmcyZ3w7PYLwtuwHSRMyvQLcxblLcZ2xuiLWLUSlJkWtZF5KjZiizpgUWZyfIBikvQ5uEwvi8bMUMSAvbiLXfR/kEj32Iwd+eIYecldU1FiXv1TOFIrkdZy8GCVpQMKin8b4+yrRtGRH9Qfb9siVghfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754800691; c=relaxed/simple;
	bh=f2b1lACTIXxtBjl4k0cDVkZgPF53VUF7AT+sr3tLEfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OTaRBKcmejcia4MgEZaybXDE077Q3BFSJ9zDVksRWMGuHTKgL++3+ZToMMTR1LvHvg8HqbvsUrUJ5jtJxXjRrtSYZOWDZgD7k4+1X1/pi0XRHmY5G0DL75zhEiR9zXjOlG/1YJ0w/S/MzvSoSwyaF1v9tLRbg9ijjKWwpIXDbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com; spf=pass smtp.mailfrom=wiesinger.com; dkim=pass (4096-bit key) header.d=wiesinger.com header.i=@wiesinger.com header.b=dhavXmDC; arc=none smtp.client-ip=46.36.37.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wiesinger.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiesinger.com
Received: from wiesinger.com (wiesinger.com [84.112.177.114])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 0254D9F17F;
	Sun, 10 Aug 2025 06:30:34 +0200 (CEST)
Received: from [192.168.33.7] (wireguard7.intern [192.168.33.7] (may be forged))
	(authenticated bits=0)
	by wiesinger.com (8.18.1/8.18.1) with ESMTPSA id 57A4Tlnk1474492
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 10 Aug 2025 06:30:04 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 wiesinger.com 57A4Tlnk1474492
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiesinger.com;
	s=default; t=1754800234;
	bh=Ql1ef1pbf+/lPlq9bKd29v+6nLUxpRIcOlURimQeAZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dhavXmDCnK3qVFGV+jVRSXA2i4CFj1gdKHtlLsyLg9yCnGG1XalikGs2nVQWwsK7t
	 esVJ+R3s8Zhkx+5KTXJ2KjVkAzX8mzOWWIClG0bR5+lGozjrccRWFPbjAnwoZ4Q7Nm
	 yg/cLe7rVif1JQ3GldRxe+5fAhORFhxSUAwimIFoW6xWzBzPIu6OJXc7Xjt092fFys
	 JBzufpLyZ9UBmnUFoJu+qv+sUOpM6Cp/ECG0efyaXXxYtv1g3RzHDFHa49Sokpw6R/
	 5OoUVk0vGrctvoLlwf3+OTN9iMe/NP0KTUeW86cdVj+a0qIxA8XmVhQe/H+CNvVSgV
	 m4D5nNhsfzApdvuRbZ7oJyJrfW7JxEHlgBZMGDAfYm/GksgrO/2U5D0J27Forf47T2
	 LsQkiethQTgGGN13ah6ScT7VJBY8ZQtsWhbYH/ZQhF1aP2HWajrcxdKCcnQ3bc0Lhq
	 Fjy0Tmrr8h3rD9t/ggPUAW/pujJw+hlcPkoDpRddKVItXJaewzNwWLjhnOpktbwMNI
	 d4YlXIBLfP4xuSTUUdHKc1ZNvSSPPSN9ZEWP5FKzB31dwgcRuFeZM1S2hJDAnRPO8h
	 55GJzUJVaXpA3VyLjVIzhEq4zxW9i7UvbiiyXZNA/jhUeI0DeBuKhav9wAq3+m3j0X
	 1ELLVJTOzpsLjtJvP91DGnK0=
Message-ID: <f993a298-b455-4aa7-a4e1-f0416b255c5e@wiesinger.com>
Date: Sun, 10 Aug 2025 06:29:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Content-Language: en-US
To: Aquinas Admin <admin@aquinas.su>,
        =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Carl E. Thompson" <list-bcachefs@carlthompson.net>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
From: Gerhard Wiesinger <lists@wiesinger.com>
In-Reply-To: <5909824.DvuYhMxLoT@woolf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.2025 14:42, Aquinas Admin wrote:
> This "We don't start adding new features just because you found other bugs"
> sounds absurd. So, if we find bugs, they can't be fixed if we need to extend the
> functionality before the release? Excuse me, what? I clearly understand the
> absurdity of this requirement. Because it effectively means that if we notice
> that ext4 is corrupting data only in RC simply because some code was forgotten
> to be added to a subsystem during the release window, we can't accept the fix
> because it requires adding new functionality and we will release the version
> with the problem. I clearly understand that this is not the exact situation,
> but it was done as a solution to an existing user's problem. Moreover, the
> amount of changes is not that significant. Especially since it's not really a
> fix but a workaround, a useful one that can actually help some real users in
> certain situations.
>
> new USB serial driver device ids 6.12-rc7 is this new functionality or not?
> ALSA: hda/realtek: Support mute LED on HP Laptop 14-dq2xxx 6.11-rc7 - new
> functionality?
> ALSA: hda/realtek: Enable Mute Led for HP Victus 15-fb1xxx - 6.11-rc7
> Octeontx2-pf: ethtool: support multi advertise mode - 6.15-rc5
> drm/i915/flipq: Implement Wa_18034343758
> drm/i915/display: Add drm_panic support
> Is this different? Or are the rules somehow not for everyone?
>
> But no, instead, this is what happened.

That mentioned code parts are AFAIK NOT experimental and therefore 
stable. But still include feature request in RC7 phase. Will that be 
removed, too?

I think we should sort out 3 topics:

1. Technical topics

2. Working together from an organizational/process perspective

3. Working together from a personal perspective

my 2 cents.

Ciao,

Gerhard




