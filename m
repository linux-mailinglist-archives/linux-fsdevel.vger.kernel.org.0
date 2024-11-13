Return-Path: <linux-fsdevel+bounces-34584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B7D9C6696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 02:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5854FB28E34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D270805;
	Wed, 13 Nov 2024 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="r/X7UDw9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic310-31.consmr.mail.ne1.yahoo.com (sonic310-31.consmr.mail.ne1.yahoo.com [66.163.186.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40820482EB
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731460817; cv=none; b=qAsnX9CPfk2mXZIuJpYKQt1ZkSHVqMDeB4irtpjchQhFU9keHQuqu/mv8a0AgP3+oNOOC7jI+fgSIqd328/kdH3RnWvtYqoDgnlMxRxfp8O6aAwBJjdG42dk5gkH79005HKLd4mHE8TxRHc7aILKZWAz9LpzGKQ1TaN+VH87ooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731460817; c=relaxed/simple;
	bh=SlroORLPVCsS8/MtfzHMV8o/2y8GFOAdZJOG9/IDfPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bq66A5xz6y7oA05JviHLEGjm+egpY4RAQVx6XJV5JNSbZGIvvczdUJc5HnFu/4qSC/O15NWicPFd+2fWvMaZX7mQ8m+8RijXVwF8d1KpOKJcqNfmUxEsnMiXk2fxyumCkPXvKs8tV7IUf4IDhj3cs/5yzLYu7U9iHorWckS/Yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=r/X7UDw9; arc=none smtp.client-ip=66.163.186.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731460814; bh=shmrktBCQXaesTtkMCJkfhQ0TWorayqU+05d82/clTw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=r/X7UDw9EPdKieAwpkE+twjX9vEW2I9Dj5FJAMKGTybBkteGPKI5UZB9iDQ4RP8OZBRCemO2JLK2ou6ySkU95+0BYuwLmZviM6jqDKjlSwwwPMW5X2Bdb9zlwCQWDbfuW0nqUvZU3x7+mFXMrhq2jrBWzhDbNkflNVHWxd5wiJurj9EcfuxdbwNg3VUN6JgotuXSDs5Bn8+VEPUci2NXJgDh4hB0UaDIIawcIK4e9QMKa/a/P71pRS/3fSF8TCyTBvoIU/3hEO/F0N3gM+BvmMtXJQ8Qde8czlrtPF+yYsFef+IO4dGSImyVqRTxiaZf2CLRWToLue+Q9KAizdpn8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731460814; bh=5evHjJGwNj35XBE/+5BjERcwk5ihkBFls/B4dg7YYJe=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=htQliPYugckK4f/9VhB3FYDRWjxXzUYzYRDs8W1ZgHIu9WaisCZEFO8Rcsuh4HFreSO4WTW98d9RQRjxusSm4p+6VlIAkhgUYl9JnTwfwQzXduFLgUWAHiKo+wpKCLGHWmW9B0/WzyTjzB2+CY0VoQRSMw/9BeEBhboliRYpLsR92H85G7gwoXjfZQPR6GwNyn2Jjyu0IohZlBQwOmAOIMScH6n5GFYw/DfbinE3XwoUcfndb79NNmP8PR+v93Nw6/zScNJyXRjIBY+hFHlKwpqdHKuf7nABcpomt0RggQiWxo5w5+y0nnlwzhqHrdNIw/rK8FgmvGqVWzsopAL2Ag==
X-YMail-OSG: 9qQwb9YVM1n3hctZOjGDZ1e9CJP4M7eHtuXaKtNMlwyKEl8vKzQkOliSWAiWAK2
 vM2FcfmtKXGQu0dwI2oXMJmxHbTYFRHQTBcJzdpJmRTttDHMtznIFDMo55sjBAMrzLf6Vn1J.P3V
 2wytM98bamqKz.Bms8GrSahWG85Q7G2vuldSuXgaVWxfKsqpD1bPM9_J_LHlgLXqZzsab5OtjFnc
 btunQFBzU_jzRXs2XiLqTnsTYERLN57WdAedu4kcie_xjlcLr.ITCJI3jqop7ALRQwZTa0Er2Jsv
 lmjuw.VY6qFRcMFkKpWis1YJnWyoZvjfaJD.Bx5w9PNsx4qAverbkWsZc2beSGU4g1pp9kk2TF7m
 2ZxifXqfeOddpY4DqdZAIO3RmhQde0VFGWo__zIM0wPCi1faHBxiXhQ77brbXqoH0.9i8gI.8VgS
 L13JAB.epqnKd9oi.toI7ejndOtqet_xyzJMNslvqq4ITPeO4i5DkGoZRwRJNAkDHXXkYpZ.WO45
 6UQgttt_celNg.72uEWUJnIqL6AY493s7j2B99iwzqBdO1YkKMwVmewia0NhFdvHuTewTknuM_Z0
 36fBkXjBm6qWGMb6415jnmowq48VwdIl4iTSaN81az9tHIDU_QsKmAHUMc5xxZGUfnqnfFNqxL_m
 nbr78WvU.rzlJmiqN8uqsCeVWvbHBFb_Ib5NdH3MS09_YfRGn0Dbhzcv8YaY6wuJQ1SPE3Eum7Rp
 9FYiXr0GM._bWfJXQaLfDe2a2lQJdEJ80n_lJDUh60TLS5dcI1v31OUN693NBgVLxiqNxk9wjJBl
 CssVRiocHA7knCVtNpdXNTqm5u45pnuDLjkriMYnkDnio5NsX0Gv014brX5G2koSy7D5mmxh9gUZ
 kc.tiA27whPDJ9TTomTfITPEKRw7RDW4orc2Esm4SqIqRS5sNtvStaSiUnfwMPqqIoc7Tnm7debJ
 vib14lLjxlWPE061_.BB6FQjQ5sNv4QOU20_OXs5mgNxjOeu5eBrN6VSUnH1QvVjIGWB3F4oEgwJ
 TO0noVeTTKHe21jt1Zw88.K7VnHxoF6jWXyCxQ3Jdy0u2WVBCNhJaLNSPuN3.QVpqNUg4tGaav9s
 IXfSIitCSVQtTjiNDeOEYNWPTTEF4ifKSrP.LZJ5LLF0NZ3QhBT_Zxm.TUju_qQorzyHT8.5Bwbw
 Tsrp6kQljJZtlGbdXpZTbCmR.CTxN99d7WQ6owtvB3S.zmApAl1sh98zVeU3PEIS6iBVs4u.qmbq
 Y3Xu9Y6v9DGLdYOEcwFdxPCan_WADSL6IVHJSyU.qbW4x24NWFUe3JenN8ibWO0lmozQPigys6NI
 SI9tn8rkKZoZdd5DzMlIMvfIHR8qnoSEn4gnMhjl2BiFlVH_P2Yt3NmDpnPB.tGAe.ZoeMzoF84O
 hDN5tYwjGpeeGHRc8ejS_Chf29zuySjRkR8QEYub00I7ulHwcsrSoSCO.KmQ2YTOBoqhzcMaEeAE
 Yp4855y8Jz.XLRdgb8.p5QiAkWwwL1gC2NbOwPXPz4lkJLXeJ2xVdSOPorMLgYRKvvqhTHUip1hn
 i3rZBiCaeA_CGQSmFS16BpAlA7W5f9GyaJpfmjhMJfaMf2nFYeQAz5y1Lucvpxmk8xsg76bSbr4c
 D3wg8hy9HX8AqCHmsr0PAwBnNi8vdhfsB6Bmsg6tsf17MoGVB4tXL1EQKPrgLSsgZGWX6G6Yp56T
 Eh62gzvg_ujBtn4pUd.TVdSV9EylsBYBM_ROKN7YE3ejvI7aHXXWQi_yRHtQzDmTL6jn5WLnjulb
 dNQXsI6survJsrB5jAi8EEzVisj1NnYfEVAPIVsxN4jqofjWp_ycnRQCpZaSSnqipo.2TX_vqGF8
 3O9lyC5w8D_WmG1dBpWV_9.zDx3j0yugfHk0z7vWH7cXdRhqgZk4noRcjBq9cRsHVGQGPCST7VsG
 skgrEWZhetI.kw3xoAozAT478JMbDmRPiS06iqK_GEgNFLQegGEbkd05aCvgUu2Utbmz9q0.RMar
 yRybM4u1fZseCzMLWlHSNP1XtLRpiHsZQCNHWFvYcE3E7rvLtSJ03c49nQGHki4oWgnqgUs3cE28
 wUm0NlWgTa1p1Wdk7x.mkJ0n8OJgH1U9tqggrF1m5PTHi4.6tAvnoia1DNhGOOe1PgXOQYV8JlXW
 zOqutjx5bh9LVhX833FctZTIoT5XdGnH.tpa6Vh1QpDz7Yvwx6wGYzIuaCyIhul7HBp4EIRJ77lN
 bWJgEsCkD3QeXKXLe42FK9FQag20jFflf1v9Jou3_GFBhyzwqAVyfa9TGi2l9Ciowrztdo10.Gw-
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 516c5a87-90ca-4dce-9f38-6a1b53fd3cec
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2024 01:20:14 +0000
Received: by hermes--production-gq1-5dd4b47f46-sx6k2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e9528446bd432b6a011384ccbc674449;
          Wed, 13 Nov 2024 01:10:06 +0000 (UTC)
Message-ID: <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
Date: Tue, 12 Nov 2024 17:10:03 -0800
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
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/12/2024 10:44 AM, Song Liu wrote:
> Hi Casey, 
>
> Thanks for your input. 
>
>> On Nov 12, 2024, at 10:09 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>
>> On 11/12/2024 12:25 AM, Song Liu wrote:
>>> bpf inode local storage can be useful beyond LSM programs. For example,
>>> bcc/libbpf-tools file* can use inode local storage to simplify the logic.
>>> This set makes inode local storage available to tracing program.
>> Mixing the storage and scope of LSM data and tracing data leaves all sorts
>> of opportunities for abuse. Add inode data for tracing if you can get the
>> patch accepted, but do not move the LSM data out of i_security. Moving
>> the LSM data would break the integrity (such that there is) of the LSM
>> model.
> I honestly don't see how this would cause any issues. Each bpf inode 
> storage maps are independent of each other, and the bpf local storage is 
> designed to handle multiple inode storage maps properly. Therefore, if
> the user decide to stick with only LSM hooks, there isn't any behavior 
> change. OTOH, if the user decides some tracing hooks (on tracepoints, 
> etc.) are needed, making a inode storage map available for both tracing 
> programs and LSM programs would help simplify the logic. (Alternatively,
> the tracing programs need to store per inode data in a hash map, and 
> the LSM program would read that instead of the inode storage map.)
>
> Does this answer the question and address the concerns?

First off, I had no question. No, this does not address my concern.
LSM data should be kept in and managed by the LSMs. We're making an
effort to make the LSM infrastructure more consistent. Moving some of
the LSM data into an LSM specific field in the inode structure goes
against this. What you're proposing is a one-off clever optimization
hack. We have too many of those already.



>
> Thanks,
> Song
>
>>> 1/4 is missing change for bpf task local storage. 2/4 move inode local
>>> storage from security blob to inode.
>>>
>>> Similar to task local storage in tracing program, it is necessary to add
>>> recursion prevention logic for inode local storage. Patch 3/4 adds such
>>> logic, and 4/4 add a test for the recursion prevention logic.
>>>
>>> Song Liu (4):
>>>  bpf: lsm: Remove hook to bpf_task_storage_free
>>>  bpf: Make bpf inode storage available to tracing program
>>>  bpf: Add recursion prevention logic for inode storage
>>>  selftest/bpf: Test inode local storage recursion prevention
> [...]
>

