Return-Path: <linux-fsdevel+bounces-35845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48829D8D8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 21:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B2528670A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A65A1C878E;
	Mon, 25 Nov 2024 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TTGmKGdc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F271C1F12
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 20:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732567782; cv=none; b=s+QItRZKfkw0MI7U/jbR/Nhsu8zpaZh+kL9HjQzglWqA76fTpC8Bs/Imu+VKLTfasd+54Lqm9IPLSMl1k8p6cu6LtdBD8eZWETqgdGOF5NBccoeD8Xi7Q1oqddy0zAugaFNazVG6ys1ZXdPlkagpJdG6weICeDUb/6RmrtI532c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732567782; c=relaxed/simple;
	bh=4Il62etn+pYD+YTeEf3cE1jJltd7AiCQuutxIUEmGFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUxxVB8MDXPLLlX0QyK/qfWzIhOmziIjONxnBk/IpTNBY8gLQKlY7VpZ7tmGDVk99Im+VFNpWuLFBsIVLUssnY0F0IOGwnsl7AX7mdPHlMLQKQH3nqyrmSOE5eBhdoY0xqBhl4KVgMiVIpEjKJWpzlM/9PH/1KF6wf4f+aYQUBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TTGmKGdc; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732567780; bh=H8Sa1TULrzTuhcjK1jbbH5OG+hYmMAcdXRi2XceZ80I=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TTGmKGdcUrm1hbKJQNfdILB6rqx+qWk5i5JFI/zaM2m2Aa0IBG3eY01d5WJvOjB+AHp+UQbFTtGCZceUweXSjaS1To0s84Cpl2IhwLccswrbbQVKsLpIbTEL84AfAkoRRJgRcrWN4kCckZN570eBRkItqiCnLR1oERbCE/12j36dKAIO0NsymqhM2lsxB8G4Yd0W7a3fUbYIh9eBe6dVzSsWr1cMUTKO7w1oOR4O7L/78qzv7Qb9TpaE+1WkSI+JJ0z6P7D2exDlMJwEvS2c97pdGKARiAsxltUMuTravhvBf2TQSTa1mKbDy824oHhrBxUCcML9GOILpIqHOkOIsw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732567780; bh=A1+QJCBvUp/LHWc4XhyHAhglPy2boFkGz/MPIOHz57/=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tr/2KnszOJQ9eBFRRc3GgIfJcX0hMD2opb7QyWsYIqZ/+kymBweb+Ij/7CcOXjr+KwFl3y9LRNcBvX0pd+jCPdK2oQB1WSX2tqDz1BzJWF/eyGBgDgoDfHvbW2YpNy9IOF7YvLd1NoSF9iUr0jHNqWTssTfEMSlpRI8GeApVnBGsB945VbajALnkouWq4GZJlhASsBe6FKgmFOvPrDsgSotigNd+OTZZ+MpisoFyoSxzTKv7aYcituWo92iefhRnW8nDj6Wifn64Ox1qIQ4OrdEpFe68swYqiDfuy5P1v2zwEBtjtOxev9BBXFyXOyx02OWVO8jPo772XcmoIVwJeA==
X-YMail-OSG: LvzJCG8VM1m82OkF6zUVAt7KApxqYG3_VIY9v_bCvaxUrFagJOOD4idfV20Y0MZ
 diBc8q9dIx_shO5z6Q0ldkiCqBqlAOoGmTz5ht89OLxsq_SuEMrJZc99FDQPUl7R9kQiMttqHl40
 8i_vjPwosMPyFgefpa4wg0vetyW59kumcY6bRV4HrbPEo2vxo_XfMo_fvkmK6930re4sNqROdrjU
 f6f14o3nzZyGN4.S1vQGFLT7ogOFHNtQWvNeYkiJ5cfxssyazo.gi7rPZQEm3KzUAQxYVZjRFHUA
 pFXm_tcRbept1aMIu9H_mXGeLPbCP5nNKEkO5Lb6NhXK6Aad132DIwuLioZUg2Hd8LdKuQwMMj23
 EQ62S9Q03AN3rzqxYCyvW51XQPZcQVJ9nMwDR6YzII5NFEoBeJNeLPgewVY7sZFXx.PuW81v1iel
 RsOONgSOVm_nTd64A4QToG42xIZMuqRC_IicA0ZBg94XyNnmk6n73dRATgpl.iLjgi1RCEWUxMX1
 ild8PlkK42PbAstxWJ3sSmJBfNjW1rfj3jyCVmCKWKKoMVwW37i3pM9rX0YQ741gcUnC.Cs2fC0T
 I_A..i6V6zNThXl4HwTZpDVpFUQlSm7VBPEegGycPLk1T6kGEPwSt05SSbLX_A.FwQRcfr0xkedP
 vH4j9tVB313Fx1te5lXcQ0Q8zzGBhCak.rOfrL158EgEAvH96WVkLrhwqY0HB25VS1E6ACfkTf9G
 K2pA_.FHotc2kYak.luVU4.TeMP8.N6G5XNhOrFeyRpgyWD.gOuPU8sqU3xwasf26FsE3BWKQBGf
 eKXJC5HP3XKVoSgd2Pt7VDMR3M3n0PoM3eFXAxwpwy1K5S9IGRMQwK.5pazatmtPMU2N3QMCO6si
 3QogyTPC9iiqw0HAs6.J3BcI9jS9AFpvsVvEDtbqfLFVQUTA9krkNuKPqrFDa7Y2xzdItATuBaXO
 N8FEvMMEy5GtAffIv.PXAEoZ_wsLkg2zgIcwk9SFarNJyvTenQ1b1_uiGpqbMD5h6k0PPLrykWC5
 nANSV2HLjAI6.rmOGYDz9BKANDvIYCZ3FSFbuK94s1pGk06DPU4a2wJF9blh5dyqA8UHfrJHsHqz
 2stIIdbdtumO0tB0JT9mtJTujhthJ8rsKWw1aPT5Bmi7hc68UMKivLKGdT.mEdPnqCGHd93A3l55
 VXvSLUAqd3aDeDYie5G5_1btw_5nftdgZWn1sm6FskmdABudNZn8mu_jmK2I4WNK6Z.GVsRhLChm
 1e._9OSrXFTzeg3Vmk4XWnL6BEwkcfDso2YGM455oK8_Ldnq1VHpbXOR0Tt1BP1XII0HXkHncJ4K
 D_otiCM1FCjzZmH20R01Sd2zJJvZIjsEG7BTjwyXI54CY5JYwmZVnaxuNBwqvcailhygp1xkoznl
 kyVR9ckk6pKhXCW7StqzbcVD85lK2PdB647a8F2AljSEthoXKzk0L_pDw89hok3lWjxsaxHGaKrw
 PJGkqYCSH6hHj0Dk2VEzcaRoukN8VxxoYlnGAfcEY0VYjtMOz2d92thrabLCEq8XQCLRPlumwJAo
 u.ePQj__v9ufUiOT38siY.k1OoIA3vcHb4Oi7mufyhOBRpBJ9Y1pTyIa.kEQB6ER8Ww.tEUDoqXE
 EgqKsTFZZmMAKqT6Iu4GjctwsURHgA6MBgZ614FIJCeCq7EMks0gev7_L42kicFUxUdCSHxxs5Bm
 6cojp1mobKzdjDTVaB22GHdBK6PB2vLxW8jEIcU3o3RgqSsvqbY1F5FAppPYQk3wuONIk9LB5wP_
 WRlPn_nQqnP4bDv6zNXNnjZa62Xf7_3zHFVjuwQ3LHAzPwPbSKQTzB8fG._3mfQDWeSg3rXNSYPE
 lxsmASpmy_SSa36xp0THO3hEY0jYsJvsyfXmkZhfWwY3EOPb1cnnBED_uOD2P5fRecnFcFWickrE
 _cIeSyoBHX9ylPx_nDCxjxWT36Pi8djEp0NOdVOy27yyEs3N3g43jdz7b5VUXKgmtRH3Ehk3Ww2s
 RBfswk1HR09asnk5EZHJQYMCSl2e71gu6sjCKmVbUWIFasQLnuBKBy.8kerLHasSLAmKdnY4hf7L
 TC.tWC9gysgIEJQzUtxO8PqZNuiVZ25MrfnvAUYnCswN53LKNTHHlwqSHoV1RVUATz54xO2QuLWh
 Uguj4Ddr7l_TpCcLVQQFb7B5wMNfISN2MUDoTvy6SdN.d3jfNC1uPcZCeGIogdz9feMmcXBXK5Wc
 LqQSS_vSNgIrdrp1g1a43zDTWBmYlNrbL9pI2ror1V4uq0_jBVyeCPP18svelO6XbjZ6N__hc9aU
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b73f9055-2660-471e-8023-1a97f25f2ff4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Mon, 25 Nov 2024 20:49:40 +0000
Received: by hermes--production-gq1-5dd4b47f46-wrqn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c2d774a1ca76b77014037fd5941ab78b;
          Mon, 25 Nov 2024 20:49:34 +0000 (UTC)
Message-ID: <93e2744a-6220-4c44-b7a8-a709c84bd788@schaufler-ca.com>
Date: Mon, 25 Nov 2024 12:49:31 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: "Dr. Greg" <greg@enjellic.com>
Cc: Song Liu <songliubraving@meta.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
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
References: <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
 <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
 <20241119122706.GA19220@wind.enjellic.com>
 <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
 <20241120165425.GA1723@wind.enjellic.com>
 <28FEFAE6-ABEE-454C-AF59-8491FAB08E77@fb.com>
 <20241121160259.GA9933@wind.enjellic.com>
 <d0b61238-735b-478c-9e18-c94e4dde4d88@schaufler-ca.com>
 <20241123170137.GA26831@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241123170137.GA26831@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/23/2024 9:01 AM, Dr. Greg wrote:
>>> Here is another thought in all of this.
>>>
>>> I've mentioned the old IMA integrity inode cache a couple of times in
>>> this thread.  The most peacable path forward may be to look at
>>> generalizing that architecture so that a sub-system that wanted inode
>>> local storage could request that an inode local storage cache manager
>>> be implemented for it.
>>>
>>> That infrastructure was based on a red/black tree that used the inode
>>> pointer as a key to locate a pointer to a structure that contained
>>> local information for the inode.  That takes away the need to embed
>>> something in the inode structure proper.
>>>
>>> Since insertion and lookup times have complexity functions that scale
>>> with tree height it would seem to be a good fit for sparse utilization
>>> scenarios.
>>>
>>> An extra optimization that may be possible would be to maintain an
>>> indicator flag tied the filesystem superblock that would provide a
>>> simple binary answer as to whether any local inode cache managers have
>>> been registered for inodes on a filesystem.  That would allow the
>>> lookup to be completely skipped with a simple conditional test.
>>>
>>> If the infrastructure was generalized to request and release cache
>>> managers it would be suitable for systems, implemented as modules,
>>> that have a need for local inode storage.
>> Do you think that over the past 20 years no one has thought of this?
>> We're working to make the LSM infrastructure cleaner and more
>> robust.  Adding the burden of memory management to each LSM is a
>> horrible idea.
> No, I cannot ascribe to the notion that I, personally, know what
> everyone has thought about in the last 20 years.
>
> I do know, personally, that very talented individuals who are involved
> with large security sensitive operations question the trajectory of
> the LSM.  That, however, is a debate for another venue.

I invite anyone who would "question the trajectory" of the LSM to
step up and do so publicly. I don't claim to be the most talented
individual working in the security community, but I am busting my
butt to get the work done. Occasionally I've had corporate backing,
but generally I've been doing it as a hobbyist on my own time. You
can threaten the LSM developers with the wrath of "large security
sensitive operations", but in the absence of participation in the
process you can't expect much to change.

> For the lore record and everyone reading along at home, you
> misinterpreted or did not read closely my e-mail.
>
> We were not proposing adding memory management to each LSM, we were
> suggesting to Song Liu that generalizing, what was the old IMA inode
> integrity infrastructure, may be a path forward for sub-systems that
> need inode local storage, particularly systems that have sparse
> occupancy requirements.
>
> Everyone has their britches in a knicker about performance.

Darn Toot'n! You can't work in security for very long before you
run up against those who hate security because of the real or
perceived performance impact. To be successful in security development
it is essential to have a good grasp of the impact on other aspects
of the system. It is vital to understand how the implementation
affects others and why it is the best way to accomplish the goals. 

> Note that we called out a possible optimization for this architecture
> so that there would be no need to even hit the r/b tree if a
> filesystem had no sub-systems that had requested sparse inode local
> storage for that filesystem.
>
>>> It also offers the ability for implementation independence, which is
>>> always a good thing in the Linux community.
>> Generality for the sake of generality is seriously overrated.
>> File systems have to be done so as to fit into the VFS infrastructure,
>> network protocols have to work with sockets without impacting the
>> performance of others and so forth.
> We were not advocating generality for the sake of generality, we were
> suggesting a generalized architecture, that does not require expansion
> of struct inode, because Christian has publically indicated there is
> no appetite by the VFS maintainers for consuming additional space in
> struct inode for infrastructure requiring local inode storage.
>
> You talk about cooperation, yet you object to any consideration that
> the LSM should participate in a shared arena environment where
> sub-systems wanting local inode storage could just request a block in
> a common arena.  The LSM, in this case, is just like a filesystem
> since it is a consumer of infrastructure supplied by the VFS and
> should thus cooperate with other consumers of VFS infrastructure.

I am perfectly open to a change that improves LSM performance.
This would not be the case with this proposal.


