Return-Path: <linux-fsdevel+bounces-14061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6400B877288
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 18:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFBA21F21472
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B624A19;
	Sat,  9 Mar 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="t7mLcWQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDEFC1F
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710006726; cv=none; b=d2vvmISJnJZOkmQuMgDPYwEejxtAksOwRSTtMktbQCICLTpZN8/rQxjjwF3enJWkvKBlD2MAdjxolGRvIBzLzP4a5vLiDv8I/xtn5AEGY9549mqeGfDbkKC7mA2udfidfL81T44peC3cWg2uh5xcMFVj5mmZSBABpb3LwEQpllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710006726; c=relaxed/simple;
	bh=G5oLUG/BEiYp5TeQRA4uuoUPCKWwc2niLb/38FBQNl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKSfuxsxLgbfFMScGisfcTxzfovxjLzg0LzmkbBbuwidWalwR+39b2tr4hn5cnnjxT9D/TDO/IPQtPUO+v9qnLolQjI8DQJ75g1aAjSjyeLeg75lcEnmH4icpqH65B3zI2jFV0h6MmXPGslTbstgm7BU3msWn9tfoaSIMfxukDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=t7mLcWQK; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710006718; bh=u7tMELVYxrHeEhwbJn5DLnNoEh719SDsa0BieDyMCtA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=t7mLcWQKUzPNoPoTE+thfcNTNSVWqBuyc9ol4Zz6imcq6Mr7Ip5zXoZsWIFKj3OCvzwGZIB6P4h5UymZg8qArGQ3oQK3CLkJzwSquQ5Mb9IQnnppf2rCutNpHwdMlRrD7MQ6lSCtqbOJlsZ4AJjeqvoPOalcZhL/3zOFnu0SBoOBlpCNHiXMOIbuo9Mgjn21Rwm8cgqulKbCYZs8re9If4fGqp6Y1Sb68eaV2hPyodz/yIHfoyZx11R2mU86NGhUwCbWRbPQ/VUT9/RcWzcXb8KluXa2FamPnI54+OxvBHHm2m9axSO0cfIdLQdjfGTukRv7oLymcmq50IcFRwH4cA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710006718; bh=2Nt8vJ5b34H+xDyEFXkyhI/rANRH/n6ZMJ3OGfkhZ4n=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RTEat1JDaYOQmRYeKHryHW31pMb1I2Go4IdOZ/T2oreNWGEKL/8wjZ/l61E4YcPmgXzToMa0lEpgXwBuyzQs/Wp5g9GyHe+9juz697PzfSCzdDfUDVdLPPCs5k36pU5QPw+uGWip/3wnNOeuSL1yT4ElEewZ7m9zjYGC1Ddai/dI4s0pSD6yu89OzMFg1qgY1Ec519xDmUzm+8hhisEZIZttXMmnjLs7PgRuKf2VdqxMjsUSuWwNmqSzPzyRwXT9mhTAM7UoEtOC0jNHhLepdw1as8o/ki9halv7MPLEw7vbWgr5W3LKeiO3PhLW+3TCssJPi3ak7Ii7puraxqGmLw==
X-YMail-OSG: ytOKT_oVM1mvrLrssbf7o9sc7S0Tx8L0btjXk76m9SI_e2wOxFxrfFi70m9AFHA
 QpOn.dRmJX5wX1exQ_sIRRDYziNMv.TB5itky7ovefJHAkmZJ_mZLZZHrjpxcEQUDJJIfJlFvC99
 7rE8kaVT3FHmasp_nndtsDTa8VJrteg5JDyoXPGxQganxBAqAdsKSDZOClsenncysTFJ3Iz8zBl.
 _aJgrjAg27AsjiKfN92IGFKd_99BE.v1bKuOF1VF8Ny0kYfc6axivTsQSjSifY3ktT9kN2Bso.Ox
 j8DSDEBw064P.Cs7JIXLvbJ5Fw5IuiXnAUJc5xcSBsK3zgFTyWJV2mggDK6iJTjMz2GJeH3dBDIb
 tnz6Snc1VWPwYnhk2kTUynuhuAZ9M_ePUxcgYeVkpAaqu9WZbO.yPrcTyaB9grJ7vmtL0B70EylB
 .V9Q_b7rKh2GKscf2s_9mI_DdpjahFKeoLnUaDjkLKMYjGe1V08b1gjv7Ry.ldyyF2abksggYrSo
 KSJvvOOmnXn9gaTZdXyhhbVEhgcfHoimggehM9Lfbm6CVzKmO51fpbEo57YCByv61tHruSI..qHG
 3QDRDbqUgKK0phG1kFDTZUFIxggsVWYIUwOTBwuhr132Auy8S4sZKkteyVtzOMpz5tuDDYgm87_X
 Hh9BkrNNudGJCOrwa39Zqop_00dNlbCJhjPIEskrLJIA6M9aSu2zV__jCPEcyP4dghYrHE5FCsQa
 BrGBhlgKVm70I0T3clTQEE_pGRMKoBmYW.zUoRGPE5b9LzJB9nsk4.LKVnK4den11j.cU6q4IWAN
 .F08j9.6SmTJPu.qjhqRMUB0adhliEQWjr2Hv_yZxlSRHp.Wj87r1fHil3sEl4vCDRuMvWiuJdLf
 __Nb9dOoQ2Q1nTw5Fy.hkMxG14zfH2IOoC5Rmw1Spxto6PeXNek9nE.G0gzGWE403IhD0PgePCxa
 3rQ9jswKJz_9k1GIgMxLtEGx7UwVMjY7wn7dMQK0JWbRrWCaO4.AWNlcV1S46kcH4XHRvZIdLT7y
 pK9uak8_Qq8ehYvn0v.FmDEUWqBsbWCbZtnHN2ZSPseOxZkvGMgzAVcgudw8DdvDmGTsOXYAbJkV
 Z.JK.JIBSSn.Fzc0oZiUFY5hPzBu3V_GNatbpY5bi4UXTE0XBxloJ29L.h3IeTT0YTJJBtrX0wEv
 fQyIALjA5PzQ2NigZrdAWuP0c_JTaqMLP_ZhGuljIK3Twfjojh0PhsvUIYiBIPMkKErEvOOmmWFh
 GZ6TIpZb61Az0ifV39G2znJOIDsqK_RxcsV000YkMIm.fC3LqXlyNHvR4z57tPXjZFerKD.dObPT
 mevsvkX5ciUNkxF9sdlHhDagaPawYQ_XnMR7Fys3uue9GRRNG13enuqtolhr.ilOe4_MBpRAnzc7
 TJQwnMLnVbYAM6m8_TQjC.rPJi.K4cC_6iOFEymErke_o5o1lxgw4bLeXcjBFQO4QkFqODtdZT8i
 FlEWkOrFGNKHnBec3nm3zBIw.8uZxlHzB_IaoKSbLgn4s.jIOH4qVjk77GHL7mhRliQR6zeQD.er
 _p71Zk9ZF54HDGJ519YVfjE4ObfkTgZ20NzsN7fsMS.Jhddc8UvEn3aadtvn8GRQ5fj1bylZHhhn
 YImoev_Akd6NiSn2nJnEa8jhaGjWIDbZKJZjvE6u_48xQL9nhE.IMNnk0chhl0sQmJkQO9H4_37E
 nNDcF.k3GZtfS4gxpcr_hrfFkvXwj5ho5tyKxbPth7mbjdx7Nt_WhrSa3i22Q15WvGrQbxtFzAVD
 dUeLk0u1lSEON6L_YSSmLbqAC2nPOGDynP6hCAP_lbJAScTX_d4_CDNWM2lcuijzN5mkuprWt3zu
 Q71ya.Zap.mCb9KJSI4CDKsOxfKSpCA1lK0TAfe07eUq_SUesJTLiS5OG08e3V58PZVFR3uKkOzY
 8JAGd54ELIbA30v0kFPociNuSIYFOkzjk7LjEnpruynQFYtJPqxPX_F091epWC5zZxPyOVTVPUnt
 GLRrqEfqmQOdK7Gn3fSX.jnVrnCuhqyww.zr.T9W.7upHWjaqc9bHAzMd0Pth7BRNq37CLTWGgGy
 YE83g_NvBbbR.DwCJCGrpApZAI9ihvf0zFjDhbGo0uYubDC1OH9rGX5NcBrxWs0o92hCzgJeCPFn
 3znZY1OVfFJsQwXbFNf3LVE1BKCL4ehoWfa4Kxi___NB.7q3hyAldnvbsQ1ydlCiEhd4zQGh9yGu
 kKwv2ojq.1M94fNp1MLicBtxR_VG6GCJqinLl7MKyhSKnCk1q9qnsW5Yf1EUeJWRCWhTS5EBaQR9
 6UsBk0RFpDyGr1Vg5p70-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f88bd46c-b70c-40c9-898c-597c4c3bf625
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 9 Mar 2024 17:51:58 +0000
Received: by hermes--production-gq1-5c57879fdf-qprqq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d147dbabc4c789e746e3de95c804a6df;
          Sat, 09 Mar 2024 17:41:47 +0000 (UTC)
Message-ID: <9019ee6f-444e-43b5-9c84-8190f6e9beb6@schaufler-ca.com>
Date: Sat, 9 Mar 2024 09:41:46 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fs: Add vfs_masks_device_ioctl*() helpers
Content-Language: en-US
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>,
 Christian Brauner <brauner@kernel.org>, Allen Webb <allenwebb@google.com>,
 Dmitry Torokhov <dtor@google.com>, Jeff Xu <jeffxu@google.com>,
 Jorge Lucangeli Obes <jorgelo@chromium.org>,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 Matt Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240307-hinspiel-leselust-c505bc441fe5@brauner>
 <9e6088c2-3805-4063-b40a-bddb71853d6d@app.fastmail.com>
 <Zem5tnB7lL-xLjFP@google.com>
 <CAHC9VhT1thow+4fo0qbJoempGu8+nb6_26s16kvVSVVAOWdtsQ@mail.gmail.com>
 <ZepJDgvxVkhZ5xYq@dread.disaster.area>
 <32ad85d7-0e9e-45ad-a30b-45e1ce7110b0@app.fastmail.com>
 <20240308.saiheoxai7eT@digikod.net>
 <CAHC9VhSjMLzfjm8re+3GN4PrAjO2qQW4Rf4o1wLchPDuqD-0Pw@mail.gmail.com>
 <20240308.eeZ1uungeeSa@digikod.net>
 <CAHC9VhRnUbu2jRwUhLGboAgus_oFEPyddu=mv-OMLg93HHk17w@mail.gmail.com>
 <ZewaYKO073V7P6Qy@google.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ZewaYKO073V7P6Qy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/9/2024 12:14 AM, Günther Noack wrote:
> On Fri, Mar 08, 2024 at 05:25:21PM -0500, Paul Moore wrote:
>> On Fri, Mar 8, 2024 at 3:12 PM Mickaël Salaün <mic@digikod.net> wrote:
>>> On Fri, Mar 08, 2024 at 02:22:58PM -0500, Paul Moore wrote:
>>>> On Fri, Mar 8, 2024 at 4:29 AM Mickaël Salaün <mic@digikod.net> wrote:
>>>>> Let's replace "safe IOCTL" with "IOCTL always allowed in a Landlock
>>>>> sandbox".
>>>> Which is a problem from a LSM perspective as we want to avoid hooks
>>>> which are tightly bound to a single LSM or security model.  It's okay
>>>> if a new hook only has a single LSM implementation, but the hook's
>>>> definition should be such that it is reasonably generalized to support
>>>> multiple LSM/models.
>>> As any new hook, there is a first user.  Obviously this new hook would
>>> not be restricted to Landlock, it is a generic approach.  I'm pretty
>>> sure a few hooks are only used by one LSM though. ;)
>> Sure, as I said above, it's okay for there to only be a single LSM
>> implementation, but the basic idea behind the hook needs to have some
>> hope of being generic.  Your "let's redefine a safe ioctl as 'IOCTL
>> always allowed in a Landlock sandbox'" doesn't fill me with confidence
>> about the hook being generic; who knows, maybe it will be, but in the
>> absence of a patch, I'm left with descriptions like those.
> FWIW, the existing IOCTL hook is used in the following places:
>
> * TOMOYO: seemingly configurable per IOCTL command?  (I did not dig deeper)
> * SELinux: has a hardcoded switch of IOCTL commands, some with special checks.
>   These are also a subset of the do_vfs_ioctl() commands,
>   plus KDSKBENT, KDSKBSENT (from ioctl_console(2)).
> * Smack: Decomposes the IOCTL command number to look at the _IOC_WRITE and
>   _IOC_READ bits. (This is a known problematic approach, because (1) these bits
>   describe whether the argument is getting read or written, not whether the
>   operation is a mutating one, and (2) some IOCTL commands do not adhere to the
>   convention and don't use these macros)

These shortcomings are well understood. It's a whole lot better than what was
done originally, but definitely not up to formal scrutiny. Back in the bad old
days of UNIX security evaluations we spent as much time on ioctl() as we did
on the rest of the system. Or so it seemed.

>
> AppArmor does not use the LSM IOCTL hook.
>
>
>>>> I understand that this makes things a bit more
>>>> complicated for Landlock's initial ioctl implementation, but
>>>> considering my thoughts above and the fact that Landlock's ioctl
>>>> protections are still evolving I'd rather not add a lot of extra hooks
>>>> right now.
>>> Without this hook, we'll need to rely on a list of allowed IOCTLs, which
>>> will be out-of-sync eventually.  It would be a maintenance burden and an
>>> hacky approach.
>> Welcome to the painful world of a LSM developer, ioctls are not the
>> only place where this is a problem, and it should be easy enough to
>> watch for changes in the ioctl list and update your favorite LSM
>> accordingly.  Honestly, I think that is kinda the right thing anyway,
>> I'm skeptical that one could have a generic solution that would
>> automatically allow or disallow a new ioctl without potentially
>> breaking your favorite LSM's security model.  If a new ioctl is
>> introduced it seems like having someone manually review it's impact on
>> your LSM would be a good idea.
> We are concerned that we will miss a change in do_vfs_ioctl(), which we would
> like to reflect in the matching Landlock code.  Do other LSMs have any
> approaches for that which go beyond just watching the do_vfs_ioctl()
> implementation for changes?
>
>
>>> We're definitely open to new proposals, but until now this is the best
>>> approach we found from a maintenance, performance, and security point of
>>> view.
>> At this point it's probably a good idea to post another RFC patch with
>> your revised idea, if nothing else it will help rule out any
>> confusion.  While I remain skeptical, perhaps I am misunderstanding
>> the design and you'll get my apology and an ACK, but be warned that as
>> of right now I'm not convinced.
> Thanks you for your feedback!
>
> Here is V10 with the approach where we use a new LSM hook:
> https://lore.kernel.org/all/20240309075320.160128-1-gnoack@google.com/
>
> I hope this helps to clarify the approach a bit.  I'm explaining it in more
> detail again in the commit which adds the LSM hook, including a call graph, and
> avoiding the word "safe" this time ;-)
>
> Let me know what you think!
>
> Thanks!
> —Günther
>

