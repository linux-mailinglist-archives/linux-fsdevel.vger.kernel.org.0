Return-Path: <linux-fsdevel+bounces-34685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA59C7AF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03173B27453
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F8920124C;
	Wed, 13 Nov 2024 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="BBQGjNFK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B3174EFA
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521799; cv=none; b=UBj02Th4ZWZHpbfty6YO+WGUuoBY8F6RvBroxC0qukP2PLdL7sVj7gwyye9K5dhNrzjxdFix2JaUxUaQkS7gRQ1AbD2+0XWTH5May0h37uPh+UTgY4LLvBxqItyxG+G4VSj1LXSrrKT8giWnJV3nE0bv7UM08U9AxbUH6KRg5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521799; c=relaxed/simple;
	bh=98TZmzT2MooiEezIeSkgUrdFZXX490rOVv6Tto3W0wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWxKCTlHGgCJVWCiKLG3QAcF+V0O18aHCz2KTnfJA+CWvWK6xMyebWaKLs2Z6V4H1bFe8oaGM86dL5vzqwx58h0tHq5dqVZ8gNeIm6nJG0EYcBw/hy78m7T9j5tBfcLYpp94phKCm5Uj1KXEEn52oCQj/jp+3bkjwbrmPiEsWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=BBQGjNFK; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731521795; bh=nK3uVT0icuqVtInCsSNHN4I+MCkUBZj85NQuNcPcveQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BBQGjNFKCOrMnODOnGG382npnC7ZeH5NRQmjZdBM2kHpbeqVdxERVJ7Tvii8qj5k3CL6usuj3yrdh8PWWZ+8oDTV/6HZ3jWJmLgrkL9dg9GZG39gHpdfmlq+kOnkfJkmXu1DbA3H0UrAKkSdQfy2D1+azEpjJJfNiSTKvV6ckIjasLm8hMbOE48vQ8hZg/u07WzBpYMlyAaqzpazPR7sNRaPQ/Bi0J3sCKfdhd3zY2TrmBQiFdmrvOHQXgjv4MZM6haF1lRRIzYWzBeyLzcbbXIOqXyO0hdd+U2IgazYm3WZgJKH7B+lanAcmdE/5eRJSR1a0Y502kXDFe+xVlhyMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731521795; bh=FIB1zkKfbVnVlu9VXpXQHBr463sAXJtADbyBSe7jgIs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pVpL4w4+SIiHomhjWAmBicEazKOoXG+SUBjTJAQTiMa8mfHOMGPpX++WGh60rGNBYW2+isnZZKwnQPKqi2uB/Hb0DFiMWW2nR6SOhlSoQUYiCKlNUL+dMmD895J3xwEDcgkyRzCR6ioEi97qEQxUVMPAH0JMKX7woWvm+CwKg0rRCmr8l7WI3w0UzIytKZvyE5ITfIOIb4SYP+ilu+FjKvSecu+q9onSXz6vIlqn+fcVqOT6aMYxd8BqKRbY9Y2yVu+KpK08QfOgGO2HmlFspRfjO9xr2EsGAvv6fYJWIkh+SNy90wf3BAyCdhoPQKG50gFMdo3yfAHkunltUxaAKw==
X-YMail-OSG: Uxjk32kVM1luneeRTquscdUZ4LgKFH.IAkCUxC5LV.UP.gulMSYd04ah4LUwcU0
 LD3.wRosaVEzYtfAkWU7Z_LTYnQ06y_oxjnJmpDKzhMCWg2njhnkUHtCgITevk6nyHfbi5UH2NOU
 2IxCzvy1k4ZlfLkvf2jIFDytUpSSOYI7k3c.6JGqQjF.8V5kadDoX8nejGdOVIB8rOuLeA.7pAmX
 zMZ_X2NpJBcO8kOZpCFDte2lwLxsWn4Sct6mXUDJt7_y5.FZXQHx0my9ULIphC2sZRHvAukfYO9P
 s2Y19pY_Onm5JTnCqj4Wj8xFKcI9ku6bdZLSqQCmaIFTLSrrqfZ8brcTUW8gRQQ.28yCrJhBO7fU
 KYxUUMApjUTiLDj4Nwt4GR.B_BOfcH7QK5.kQBQ3HFYmhn2XYIURB7cXmyP8xYlK0qqTSJYPTfiX
 w0vQ4xksf_WkGwjXZCG6AukyhckFdWTXLMAhw8GoyJ9Qsspx39XR8HqioGmxM30yzdmIyIybZUkt
 WCU6blPIEextXkCMEJDDf_8JrCq4zSEaWlqU3wC0B9FAOTQkrLDhoZNcqrXxmzkx7fxst.ooBHxn
 EsXfJMegnFMoYeZna9WALp9v8TVFiKniRPioMjmR9RGcdolK3QzxDdddO0_EOr1TCSoFk1gE..Iu
 6mSRCiOctTPG9ZdDhZ6PPLfn.PUHHfrRncIlVtTxf_g6WmKo_lJXorFe.ginNVOWXt4m1sW77FOM
 xbg.C5nI9lDIVCFjhp6uRbociKZtOYdhhXzqKYPYVwgXhRjznQX4jp9QuWWtycetTQRi8l1DjCeG
 CAWgMGQDsK1aYkEhamOF48xjHFnuH8x7Tby8NZtrZ1g4IS1OgRN9l381_35EnPp8hYXFmvKzRSLw
 Cu8OvKIhjvpeXJqxOHH5XY4iJNNMxvgB29_rMPxotTzWIbUmUshaQwLuHIkZgC9GFFRuXpHDqBnW
 WShy4OBMVtxy8PgSa7oLGN7VO7bV6vE0K4.srHyEdQb9YTrEYUSvUmcrKRgCexTusTzp9NuTl8LS
 _tLM6OcOMMyVVj00GRip_5yF0qqv5lTI5OAzos73R4WkyT6d1BElDysgjrokJnJqxn8IAjp8rkMF
 dZIYsaagoaBwwrp_KpbVBTGTh8RtLU5wcqSS0pNSoz2MdMIIlUCU_li3omFvzLuvv.eqExNoffwJ
 9I_sJB9uvHsSVjRjb0XIuc9awy0m_twhjpRajB4I9rXYiHPYZG_B_YpNjiD9ZwGWkz6xqgwknNvS
 jbwNXzqxvJBniwa4won.ARKeNwvJPKrppCyMohuH49R_4CeyCwiUpdv09sTjke.tbhxW1GYqqGMd
 7.7vrE5_ahv_zbFAdlvS9Fx5HwHP5niboB2eUNCdTNAIvX_Q7QclcWZeuEDK8gaMRA8rJ3NscHey
 iOvAYcDkwHWSaBfY4a598zmt1yrwmTsrch0L1jkwQaxuN9Twpxq1szlzv6e66RtrDZsZQd.2fP7x
 xRP__yFGS4mxecz7GjTVA6PzGR4ZCWke0jGnWK8ip8fCZwbdRVdkt1ewz5o0MpikZ1a_Tq9_cN00
 AidJstdHNRuQp6DQp9pLPiHnVaM8fOk9npgbWM.MbyBfJK.B5tYVK3naQRhUe_sDsOALGufxY4PQ
 KP34cqMdSNvN1_cJuJDK0eLpQAs5RyjM4Pf3mFizK2th4jlDEBgfKQOHgC3yFzcFOSsDnX7vKgcE
 4kCdfpnEPX7R2Tim0tkpJXD3sGFtjYxE_PzKOyFeBeEN3wM2EdzjKDGWIXZVSMnfFVNngiCrrB9N
 1INigPvBNyKnbTNipkn8NcBaRQUQcabmuODql7VM6kN9EjVVP6JpxT6wdxvmAnXibOyKCi.S0JVG
 krRtnxnSxNT_xA_fi5LEOxzWCW31NL9fluxf3DrfFGmXtD.x4Ez4m.F.qBWfOixt1w3VjXXtp.Vm
 Tw59EGEFR4FMnWCG94LAgA7MPLyWSsEaQrqr0d9y3TPemyTvmywQSnJtrECtSbyyPq3019SZ6McB
 .D3zJG.np3KJBCS_2zqwY0JxsZWRXQ828z0aVjIeRxYvfX4UUK8SAZrOQo9kxUhaRkeLdmJmyqfQ
 Q2e1YQ4U5VlEBf4s_TxpbQo3sV_LL2pJEdOe.wHkDeSTG_KOkS.qihmw3kv2a0j83aM_n3TmGa.t
 EmczdJBbd7lxkO.UrBsxA3Ckd66HZEyAWMewm3VKLKbUiUXPfCE9fOmbJyUg3ZMTpawiWUVAtKG.
 zacAbSPsGR9jyeME6WTudQxkDth.eSqgrS1sLdY94lV4KhLS8vMzxdCUhtM5bx_spqA99NTgX.fw
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 523fd01a-36c6-4113-a0a5-f206da02e08a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2024 18:16:35 +0000
Received: by hermes--production-gq1-5dd4b47f46-ps69l (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3a47f707b068f3c37ad3e14e6ceee550;
          Wed, 13 Nov 2024 18:06:25 +0000 (UTC)
Message-ID: <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
Date: Wed, 13 Nov 2024 10:06:23 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "repnop@google.com" <repnop@google.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>,
 "gnoack@google.com" <gnoack@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241112082600.298035-1-song@kernel.org>
 <d3e82f51-d381-4aaf-a6aa-917d5ec08150@schaufler-ca.com>
 <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
 <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/12/2024 5:37 PM, Song Liu wrote:
>
>> On Nov 12, 2024, at 5:10 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>> On 11/12/2024 10:44 AM, Song Liu wrote:
>>> Hi Casey, 
>>>
>>> Thanks for your input. 
>>>
>>>> On Nov 12, 2024, at 10:09 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>
>>>> On 11/12/2024 12:25 AM, Song Liu wrote:
>>>>> bpf inode local storage can be useful beyond LSM programs. For example,
>>>>> bcc/libbpf-tools file* can use inode local storage to simplify the logic.
>>>>> This set makes inode local storage available to tracing program.
>>>> Mixing the storage and scope of LSM data and tracing data leaves all sorts
>>>> of opportunities for abuse. Add inode data for tracing if you can get the
>>>> patch accepted, but do not move the LSM data out of i_security. Moving
>>>> the LSM data would break the integrity (such that there is) of the LSM
>>>> model.
>>> I honestly don't see how this would cause any issues. Each bpf inode 
>>> storage maps are independent of each other, and the bpf local storage is 
>>> designed to handle multiple inode storage maps properly. Therefore, if
>>> the user decide to stick with only LSM hooks, there isn't any behavior 
>>> change. OTOH, if the user decides some tracing hooks (on tracepoints, 
>>> etc.) are needed, making a inode storage map available for both tracing 
>>> programs and LSM programs would help simplify the logic. (Alternatively,
>>> the tracing programs need to store per inode data in a hash map, and 
>>> the LSM program would read that instead of the inode storage map.)
>>>
>>> Does this answer the question and address the concerns?
>> First off, I had no question. No, this does not address my concern.
>> LSM data should be kept in and managed by the LSMs. We're making an
>> effort to make the LSM infrastructure more consistent.
> Could you provide more information on the definition of "more 
> consistent" LSM infrastructure?

We're doing several things. The management of security blobs
(e.g. inode->i_security) has been moved out of the individual
modules and into the infrastructure. The use of a u32 secid is
being replaced with a more general lsm_prop structure, except
where networking code won't allow it. A good deal of work has
gone into making the return values of LSM hooks consistent.

Some of this was done as part of the direct call change, and some
in support of LSM stacking. There are also some hardening changes
that aren't ready for prime-time, but that are in the works.
There have been concerns about the potential expoitability of the
LSM infrastructure, and we're serious about addressing those.

>
> BPF LSM programs have full access to regular BPF maps (hash map, 
> array, etc.). There was never a separation of LSM data vs. other 
> data. 
>
> AFAICT, other LSMs also use kzalloc and similar APIs for memory 
> allocation. So data separation is not a goal for any LSM, right?
>
> Thanks,
> Song
>
>> Moving some of
>> the LSM data into an LSM specific field in the inode structure goes
>> against this. What you're proposing is a one-off clever optimization
>> hack. We have too many of those already.
>
>

