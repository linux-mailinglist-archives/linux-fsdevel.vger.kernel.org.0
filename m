Return-Path: <linux-fsdevel+bounces-35472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE59D525F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 19:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C21B2131A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 18:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9A0139579;
	Thu, 21 Nov 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SUHLzibK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic305-8.consmr.mail.bf2.yahoo.com (sonic305-8.consmr.mail.bf2.yahoo.com [74.6.133.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19713BC0D
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.133.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212683; cv=none; b=f9zR9FKjTJQ4lh06uRp+gqY14c/lg3mw67DonWzXBl0plktgwOMxwvk2dp13rF5Mubq0K1BexJg1/ImAwo9FRe4PixUD73fWX93eR4Y915ESCtHKAUw2qYikgjzJsB2E+SHHojnbLokRXC80kKkNsMpobGfwxILCp97iLjWs0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212683; c=relaxed/simple;
	bh=p5EiXeoiyIlCjE1Gs5yxDJv+07wbO2dJFkOdynqIwlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KklwyAdZbqtLRwZHZPG8zUrYjR4624pv3jFaZyp6jse9mNPlIPZEcndElkEZOVVCfNmP/W8VGB2Ts4A6/lsKcI1zBQFPxKNvPW+i4rulH3T19ewE+6yMLqeFcDLsXvZmxctiFLRYl9dbSRViZ+jVzVP8eL7ku6VBkdE78SqauX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SUHLzibK; arc=none smtp.client-ip=74.6.133.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732212681; bh=TlJacywSl5XUuc9rK8QkbRlFOpt/mKvGPn2CAespQ5U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SUHLzibKn1YZrNcdLgJU5eMgqbBIveALXcISGBC19vdv0MZLZAVdcj9iY5iiFJRK3jkM4Jl0g0Mym6I4E0yo4JQL3dWspRLPmP6FJ6kvLJjmMlwTGG2h1ayb5Lpz4OTBj2pOM4YneVO0BAHNx/VXJzJ9I7dBCVjAB2Ahx1AE0EjCe4e4LIq41I8xpmyuGDzDY2mSd0qhXpHsIlIZB8PQl7hTUi+lFYnzaw9Br3elo+UsMjM8KZbCtfLAngZVeemqYx6JIQ08WthN1SFJ7D/U1ZB9cY2IZ+gGHY9//N8fwww5aTcyqV0xETQLtyvMhRTHTStmccdzz0+YXM1jnYWOJA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732212681; bh=njRPAqCup4OcwJjD83DhCVHXrYyd1FNWoNN5k/lS0lN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HKAJqlptfN9zoVZo1go9lKoDz6A/aASZiYnp+ykqt2Gj7nMC7hZmLbOkLsR3b8w/YTYGCbcN1ITCPteX3GlTsKv6vMqJOn4msepnGkNLGEH3zRAnq9+eIiAWd04o+csw0XCnKs9rmWAM4rdM9YQE2iRA0op5gTVzV7MSXz15jKOPlTMh5BaKOem1LwZZDv1e+gR2bVwpVj9Za2oLzPehTRcf9zkGicJ/nL5E7wXa3cFS6sgJSlfFxEy+kR9xYFfRCCnONPCDlSq+5T7WaYLimiQmyM14lxAoeCGMhcmrYYe12E5CbvP3W50hrt/J+AU1DaoPEf5NSyryB6fMklla+Q==
X-YMail-OSG: IVnG8s8VM1nT_9Ij2L_TEJuYFH55WI4zGOxgpVJFBhrPmBixS8b4vkuT19sPV0X
 lEmwsO6AJ1T45Ss5yrYdnVk9D.0BTfucrbuERfrMA5qJzRlUi0Zrg3bkJQWWRT4drXTqDSBIywko
 5sIN_hTSLHvWvklkhZnGQh.LWQuybddG9Wa_c4SlzVJz25pK1lug.V.GOQ8BLgSfxcOCubi6VhJP
 2jiivY0f90c6W3Du3hEAYTMnnJJr86rwKWwcOc29xEAtmj2U6uTc6RHcNjMzvHC5T8UxqzVuH8_m
 KpjgDmM26RdqsMqg1ji1bX8P_oiKCxfYjpM.TqxBzfo3Adg4Y_6Dr5lyYCCxpvwhPyFKcUVfW_4M
 5LdwZzPr6pc1RVHupBM9Xh2i3qCRnx7GLrXcXUKmDe351y.rvlqnnpn7SzmroI3WUPata_QasOyG
 s6hMbProf200nxpSgdp5bkIpWRYvUDRTApOEtX5tyn7QKPTvevqQTGDtcNea5Y7fbBokyyRfuasG
 eUnHXw3axs10OBEbG.nesK98ad5b_1Kb.wxSUFLoj7S3L44VJnDY_NznfRgr7ywKk3lWMtWEagYx
 yi.l14_mzBiLC23wP72YKR1NdxsmG37uR6ig1bhZX5mxkUAGDUUgCNr4FWy_XJIo8UHyNmJtpEYe
 d3.ONoDZckXudFGY14zeiL08XNP07SCN528PEyds__OVezI1AzbORkAHMXUteocnXEvqXXnZB9tz
 SdX107AZ2UTw0wok5ixSvAQ0enNOZDBruGrDHxiKW3fZCePk1ul8biQYIcVjwfiU1ogLnCpK_BI6
 uofjr2gfGFTwf580HXlVmfzCzVX_Uyo4VP1k2m0n9V1y_II6PPWMY5KpkOKSwyaQUq47YVH2nyPs
 YPa4U6FhnM6etSVkpmAjTufcnjTV1LgDMdozHH9ve2sC_vev5_4cxBEE..umhR9l3MEAf0O20tHW
 CJJGVZ7f.aemyhq8edmEIlBeC0wjZvQp3peq.NtzUKBMjlBFykwg_LuUaD9Rr_K6.50EYuVdNra0
 tn.hfXJaCcQIhHdHH3xnNXImV67MH_duSJ5m71EQw.GmH5OceMKDqGljs8xr2HKMGpIK._0ywOLC
 hxRThDDJv49I3mWtyZIcqOJyh16LVMSY0UIICZHOo.QuRL0puF48ErCHAON7LF_uZPwtRz.UR9Dz
 UlFnWNbDM.UObSe9eo2hxZPziS9f919sR.TDWZsvYd0Q6.ph5y3KuQYidwacl0oVfAumy5L0AouM
 IdaTDnZqixkXBgtwRGf0Br_kFmXDaciqsNqZ6kjD5WNMS9m8hY3ZFg4EAOaCNzkIzYyMu6CY5Ydk
 WpBUo25qPZHwcKu1WdIzU5myrUKtjzMv1q1F1mN0ICGUJzs4KziDDEQOne18o.tGPkg17AMliUQS
 N0_yECNc7w7vaocLZLGQ2241E3rSJ.L9HIbPQlGV6aPLcBxDDGk8nf.bqbNIqRoU6qELEn_zyfVy
 SiUMU_9vmeU1BP.HZPp_ccWFf9IILSe25DJPMVzsXLE3x3iMCJsfIhE1zirIluu5N8Vj69Aaxt1I
 vidI5G0JH8eVoGuC.7U2twjjje9EZSWOelkrc1rDZrCL3B8XAMAlOSEQRqW0lBq5KsFE.oBGUsdU
 pA355VSDAqhzAkpzeBWrI.TwquRmT2Ua0uMZvfPPJv9_trJornzZs0KEfShSWyaU8oElmTa4bbhN
 9hDWMu.F3N0IhZFmxjFKKlvkCi8H6lINTKrwvqt9u5vgKG26dnRKtg9hgAouN8NjiRcCTSxejKvO
 0Jrg2d_oPKqXRBvzMKym929YxCiLPcUfScXbLAN4mXPpU4KxoaERKiBYbjktwnHzQpqLx5wfAfAz
 bPsLYbTYbXjKL19zNOfXqExxKfic_ffYjDNpNvidZgSuP41WJdZe.MEvzx1Qa.63LXvWbiu13mcn
 q_1En6a_hPaHGKxqKoLwx7i0RZNZbGotWUAvL6SqoBekrVOOSpz4EKq_mk8lESYrDpFQ_ap1LfIc
 d2wz3Y6KNehPbFlFSppNUYQMpgtKfFXT3DwAx4MjmC2u0Bzjo2uAlCMxsa9COVr8xlqxdSXy8OQq
 MxuDHiJuyKuV2WPA1SRx0E1zJwuld9HWcuPvhXqiOCAaCjbyvpLxq0uOW1HW2ZX9M0YVRs9CtYV0
 Ri7PThuhzVI_y23M9ChUYDslYqr.FWttONtspecY48OoKvnerddHIQjm4Lf9N1VNnsnpGwW2LuOL
 wKy1rwXvm4v0EemJOAdhMHaFdf7x3M5Qdmmv5o6JO4nFg0Ctp7YpksYFTdSk6VIfgdqgQViobEW5
 svx4wff8c.AU-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 40243f7a-6e57-43cd-9331-03d7256e6cac
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Thu, 21 Nov 2024 18:11:21 +0000
Received: by hermes--production-gq1-5dd4b47f46-whghm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 817620235f897ab102377e7ef77fa846;
          Thu, 21 Nov 2024 18:11:18 +0000 (UTC)
Message-ID: <d0b61238-735b-478c-9e18-c94e4dde4d88@schaufler-ca.com>
Date: Thu, 21 Nov 2024 10:11:16 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: "Dr. Greg" <greg@enjellic.com>, Song Liu <songliubraving@meta.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
 "jack@suse.cz" <jack@suse.cz>, "brauner@kernel.org" <brauner@kernel.org>,
 Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "repnop@google.com" <repnop@google.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>,
 "gnoack@google.com" <gnoack@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
 <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
 <20241119122706.GA19220@wind.enjellic.com>
 <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
 <20241120165425.GA1723@wind.enjellic.com>
 <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
 <20241121160259.GA9933@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241121160259.GA9933@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/21/2024 8:02 AM, Dr. Greg wrote:
> On Thu, Nov 21, 2024 at 08:28:05AM +0000, Song Liu wrote:
>
>> Hi Dr. Greg,
>>
>> Thanks for your input!
> Good morning, I hope everyone's day is going well.
>
>>> On Nov 20, 2024, at 8:54???AM, Dr. Greg <greg@enjellic.com> wrote:
>>>
>>> On Tue, Nov 19, 2024 at 10:14:29AM -0800, Casey Schaufler wrote:
>> [...]
>>
>>>>> 2.) Implement key/value mapping for inode specific storage.
>>>>>
>>>>> The key would be a sub-system specific numeric value that returns a
>>>>> pointer the sub-system uses to manage its inode specific memory for a
>>>>> particular inode.
>>>>>
>>>>> A participating sub-system in turn uses its identifier to register an
>>>>> inode specific pointer for its sub-system.
>>>>>
>>>>> This strategy loses O(1) lookup complexity but reduces total memory
>>>>> consumption and only imposes memory costs for inodes when a sub-system
>>>>> desires to use inode specific storage.
>>>> SELinux and Smack use an inode blob for every inode. The performance
>>>> regression boggles the mind. Not to mention the additional
>>>> complexity of managing the memory.
>>> I guess we would have to measure the performance impacts to understand
>>> their level of mind boggliness.
>>>
>>> My first thought is that we hear a huge amount of fanfare about BPF
>>> being a game changer for tracing and network monitoring.  Given
>>> current networking speeds, if its ability to manage storage needed for
>>> it purposes are truely abysmal the industry wouldn't be finding the
>>> technology useful.
>>>
>>> Beyond that.
>>>
>>> As I noted above, the LSM could be an independent subscriber.  The
>>> pointer to register would come from the the kmem_cache allocator as it
>>> does now, so that cost is idempotent with the current implementation.
>>> The pointer registration would also be a single instance cost.
>>>
>>> So the primary cost differential over the common arena model will be
>>> the complexity costs associated with lookups in a red/black tree, if
>>> we used the old IMA integrity cache as an example implementation.
>>>
>>> As I noted above, these per inode local storage structures are complex
>>> in of themselves, including lists and locks.  If touching an inode
>>> involves locking and walking lists and the like it would seem that
>>> those performance impacts would quickly swamp an r/b lookup cost.
>> bpf local storage is designed to be an arena like solution that
>> works for multiple bpf maps (and we don't know how many of maps we
>> need ahead of time). Therefore, we may end up doing what you
>> suggested earlier: every LSM should use bpf inode storage. ;) I am
>> only 90% kidding.
> I will let you thrash that out with the LSM folks, we have enough on
> our hands just with TSEM.... :-)
>
> I think the most important issue in all of this is to get solid
> performance measurements and let those speak to how we move forward.
>
> As LSM authors ourself, we don't see an off-putting reason to not have
> a common arena storage architecture that builds on what the LSM is
> doing.  If sub-systems with sparse usage would agree that they need to
> restrict themselves to a single pointer slot in the arena, it would
> seem that memory consumption, in this day and age, would be tolerable.
>
> See below for another idea.
>
>>>>> Approach 2 requires the introduction of generic infrastructure that
>>>>> allows an inode's key/value mappings to be located, presumably based
>>>>> on the inode's pointer value.  We could probably just resurrect the
>>>>> old IMA iint code for this purpose.
>>>>>
>>>>> In the end it comes down to a rather standard trade-off in this
>>>>> business, memory vs. execution cost.
>>>>>
>>>>> We would posit that option 2 is the only viable scheme if the design
>>>>> metric is overall good for the Linux kernel eco-system.
>>>> No. Really, no. You need look no further than secmarks to understand
>>>> how a key based blob allocation scheme leads to tears. Keys are fine
>>>> in the case where use of data is sparse. They have no place when data
>>>> use is the norm.
>>> Then it would seem that we need to get everyone to agree that we can
>>> get by with using two pointers in struct inode.  One for uses best
>>> served by common arena allocation and one for a key/pointer mapping,
>>> and then convert the sub-systems accordingly.
>>>
>>> Or alternately, getting everyone to agree that allocating a mininum of
>>> eight additional bytes for every subscriber to private inode data
>>> isn't the end of the world, even if use of the resource is sparse.
>> Christian suggested we can use an inode_addon structure, which is 
>> similar to this idea. It won't work well in all contexts, though. 
>> So it is not as good as other bpf local storage (task, sock,
>> cgroup). 
> Here is another thought in all of this.
>
> I've mentioned the old IMA integrity inode cache a couple of times in
> this thread.  The most peacable path forward may be to look at
> generalizing that architecture so that a sub-system that wanted inode
> local storage could request that an inode local storage cache manager
> be implemented for it.
>
> That infrastructure was based on a red/black tree that used the inode
> pointer as a key to locate a pointer to a structure that contained
> local information for the inode.  That takes away the need to embed
> something in the inode structure proper.
>
> Since insertion and lookup times have complexity functions that scale
> with tree height it would seem to be a good fit for sparse utilization
> scenarios.
>
> An extra optimization that may be possible would be to maintain an
> indicator flag tied the filesystem superblock that would provide a
> simple binary answer as to whether any local inode cache managers have
> been registered for inodes on a filesystem.  That would allow the
> lookup to be completely skipped with a simple conditional test.
>
> If the infrastructure was generalized to request and release cache
> managers it would be suitable for systems, implemented as modules,
> that have a need for local inode storage.

Do you think that over the past 20 years no one has thought of this?
We're working to make the LSM infrastructure cleaner and more robust.
Adding the burden of memory management to each LSM is a horrible idea.

> It also offers the ability for implementation independence, which is
> always a good thing in the Linux community.

Generality for the sake of generality is seriously overrated.
File systems have to be done so as to fit into the VFS infrastructure,
network protocols have to work with sockets without impacting the
performance of others and so forth.


