Return-Path: <linux-fsdevel+bounces-34687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED779C7B3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F815286FF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 18:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553BA206951;
	Wed, 13 Nov 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IOZR70XK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CEC206072
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522606; cv=none; b=RyDm9CuNL//TU5iHMpCcZ0IGNDt+skzprLztksa6ZdEfWEmkSQ7DHABVylEqZ/lt0De9Q0neKsNudk8Lc3Ym0Ra2pAVlhlF1dlZWpz1t/ZOTzvI8Wr+9xamGL4f9onzOttpBw+f8U2MIQyPftGe2voQwhj3Lv4q++kSsSSWwFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522606; c=relaxed/simple;
	bh=TqQVBVCHriEkNKCOfkPbxVbxF9alnSjCgNiwvehYleg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckOOeKmIjNgc7ywiskYfbMMysUP5Iq3tUA2s60Ps6+h5JlaJC1uUxeAOAjQuwsvGOfu9WQqE5yevQg6ebxGYkwutSj47BpSHXiVmcwnEyucQwZYVdsDaiVeh0qcIJLzZtNrCcbCseDyxCLCTQdEt8ommyMlt3yLxJOA+02Obp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IOZR70XK; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731522603; bh=92DLNUHxdjAQlOdpMMs4zu56cp+QoRjiOMbtt8PhTVs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IOZR70XKERAbRc7Ad4k8KHZy3hqft+X8K+5W7mL4lkJoXMSYpXHMSzdSgIQwcMiUjtbQqG5IHbJs6q9xeR/dSIwzItUhDCotZ+ghoLpafRfFc6rVZcIVhsaNvXmZr/J3YKRd+6NqjcHmVE96jHHWGRzoIWe4+Wks/G4cy34+k6pcx06DgG3S2+Ks2W3IOKgk8LALP6B3W3/nC24uhOMeWRYATb32FQIKRWagcTbEvNbqhUvx2loRuG3H50CmevLI8Xd5wOAffGZI11o3W8STEcIwLkQ9hjSh6rCGTuqnTHuUVlj4VMBb8WKz8doouEJzTXEPuBiggnayo1adYFcNWg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731522603; bh=1n8VMNSw0sJ5ajfb3bl7mepzHnc4yw9UbJ3joUZtj8m=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=CQN2AEFCbE83CtSsGg3JSnOUmQbiON7P+yeMpiI280C4RGWM0waZ6x0XsPj+KmaeQvJRF9xYdTIGermLCkgB/x4iXdbzbEheAXXcOi0D/BlQobWwQCa8aUiT04NiAQPPH6I/YF2FYVYcFcoUeBCqYrS0SXm6LNCJsRp4tfJKXm+uvIl73HUtzDSg3OdUsbGaG+tIKqzyBHLnvFaVcvNgKULsUtN1IzU1VThBXJg02nXRfQsjpu7+fEiGirSood89pc9Gqw/51j5j8wJwGswGuG95fV1n3Y4gOPClq/7OCEg/u2rWudTp7MRXAj6RmbCBa91IfvahRIWs/6jEAZKmLg==
X-YMail-OSG: eTtnwqAVM1lwPsF1g4WBXIx7I4w3UFTjNnvsNbFcZXCXQgdrxU5_t3veDbyLpc_
 NkftLcx7faGCM3JfrOFZs1..p1rlCY8KcjzkJ9RVDGjrx_vxkqn317m3rE1jzTtgrxeQQhIRfSMj
 Gqg_qHQ778FX01aij9KargNRah55yak47ngtKCGCTBbyHnI2JJ2.ykKtmq8FBQLYJy_sFI4bDRdz
 25c7J3.kXA5YgmkHH2h1py2fqlMER07Is4UUD1kVabdbrg_HVNEjYvLTe3WcBO9nUyJPc.PQRemy
 pQiBsHtCKnNMYmLgH8aTrh1Aa3w8j2iN.LFDuzsVWm3NHwyTp3D_a2s9K3dnH8lswIv7qpjg9..e
 W8jrsfghME5ez0boJaNLHHZipw8bOfoMpyJ0k6DCKqwPBBj4YPKdzKXSq69LbE2mtb24nKlx0_fo
 OCCQOE3BRj2NoUTMGkB7pBSq9OnS.1M9pOKd.wawJtzqJio8EK_61PpM_8UKvmQNFCfGplyEtydc
 T8wMWTUUJ26hJw9b_A8BhlBbNDt03NcUIDie_SwoUiTC79jl5RO0NKM762_N8NNiqkC1SMq_mOLG
 llhWrZs5hsMeRQaZ5yiO8QN6hyNu9puv2GCxjePFbrjtQJVnhJ21_z0UdxPpEzuWM7MsWd.VGaA5
 FoyW.EvbxGTBnQDHngHKodW014ThaSaHI01jg1N2aF5XPJZzAOyRFsQlKJ7ddRthCBaBhzqc_h5T
 ohv82JzNCi1igpaH5a6p63t15sU0GByOOXn_V6vae0VXkFi.suMloNFPKHg2u1rKUXsDblbI9nkz
 dhIuvvEFDZlGcwXpH7Z7l_gtorCYw1CyXuz8Nk9UXGGZVCXI2m0dwQhi_2MITv9.tyxaJgwXNwZu
 rjRG764eoytSPqLzbh07z74z3W9lo3IADZ7xr7xI.GCtsnJ_Bg1.rp.PcKcRIy0wQ42SZLs5nDNx
 WYmHJAk61ZvHOIFCEDX8rVH_Tpw8649tYuOEKw.gfPKoUUqUzgygfE0qFl89kltg8PJWR1AiMnuf
 mxvGned3Je9ncmqWvFntjjLnYbpM1icGAO5QEjny_TnTN.NTH3TQoP4l6Af6_HV3nUUSfm3jneBM
 UJrkNAB5JfRc0wTI76aehlqUnmM1n9PWznPCrGIkX_Mzgj80yzUlBqUU3QQk84O4z65qRjanar3y
 K_ybOu7oqVSgXhZOSSOTx0mpsESe_t8LdkkHprQ4d3Do2UmlCpaBOBJYxA8PljGVXlN7TU5lrI9w
 B24atAyjFRXw5vNuSzLLPEzGrNLkKIY3PiA.Lxmj0c9RgdSK0Og4grfmtWS7KRU8nfqobDb4q9BZ
 pP45PxIAXkXuaxrR0ZSz3h5hwYuig0kJLwNw_7ygB7WLHgvE_.Z1qLKLYIsrYmWkLG2QEowrG_Hd
 TofH1DY6BvXXDg4rF8jc5G3oE8ANO5Wz.XbO.tulY6Cyf6yHgNKHLj99law_HMooEfUw7wzr2wmK
 FekmQtLresU773IimLyXpKSU0sNh71cWmfBwNETiUnXenmuJp6oyqPPxDyn1k3.77r9j4wqi232E
 RB9raIuFXArCP9d2E_CInHC2ZzI32DPFL0IrtjtSS8lsY7zRDfUIFwB88mLI6Lu1oYYFaDJYzfHs
 v9bMhOTkYvyp6Ou6xIrN94ghqu1fHPuh.7eZ4cAttYcEfy8RD_RS.ky8ZpPitr_rPi39YZCiiDed
 4PbPI4JnY8rsZYMPUe1oXSaFybtesnWNTVXsUYDUnyzS88PXXwfvf4UqPXigR34SyUytSn0Hb9p8
 5pe0oQMjIq0phWpeWThkLrcHyrjmTJs0BpN5U0ueiLP_i34mldwSkbyhcm55VlzzF.fDmFxiGI9r
 WUSMk1GxTlKy6T.6PeS45cX3OdYZYEkI6iZWEzoN7cylnEt5eMSb9Yl1_bLkqpCrWVlppcKmUMf4
 itPAtdGiw_YFcyge2jD1mhpaBDiHVJ.DWj7_SrayhglJq.i9m0z7AJGY1KSQfWRCjsobC_UBGeDr
 qQYlDfAVdTj_jVAtb7cd1h2_RdbA4IjkUs8LS06YO8.4Ge2txPCVHmEYZz0VSRCZBBd07mvKULVZ
 v61eN465NT.qNBJmoVdRkJVhIs1s9u0F7n3Fk3uoGdqkY_C0NTFLNvtfshMxnMf_Dh21fLdngZQe
 QGx4UHVlSgzNFFkaj_P1SVudL0lgKsN1.r0qOwy4UQ70r0ZYvbdjFpkSkLQYzuNW0xRkhed2MF0L
 NiOP_9gVdhkxO4SY_JFPgxiK30X_NO7X.3du5kM3gaEIa.NYgwDPxjjrA2jRrguqmiMWyxsiU61y
 HHhc.bKs-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 71e488c6-e823-4e79-9756-32b77378fd19
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Wed, 13 Nov 2024 18:30:03 +0000
Received: by hermes--production-gq1-5dd4b47f46-5kxd4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID af2e520e4fc25b996d153d4d132eb18f;
          Wed, 13 Nov 2024 18:29:59 +0000 (UTC)
Message-ID: <1cd17944-8c1f-4b13-9ac5-912086fbead6@schaufler-ca.com>
Date: Wed, 13 Nov 2024 10:29:57 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Song Liu <songliubraving@meta.com>, Christian Brauner <brauner@kernel.org>
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
 "jack@suse.cz" <jack@suse.cz>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 "amir73il@gmail.com" <amir73il@gmail.com>,
 "repnop@google.com" <repnop@google.com>,
 "jlayton@kernel.org" <jlayton@kernel.org>, Josef Bacik
 <josef@toxicpanda.com>, "mic@digikod.net" <mic@digikod.net>,
 "gnoack@google.com" <gnoack@google.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241112082600.298035-1-song@kernel.org>
 <20241112082600.298035-3-song@kernel.org>
 <20241113-sensation-morgen-852f49484fd8@brauner>
 <2621E9B1-D3F7-47D5-A185-7EA47AF750B3@fb.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <2621E9B1-D3F7-47D5-A185-7EA47AF750B3@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/13/2024 6:15 AM, Song Liu wrote:
> Hi Christian, 
>
> Thanks for your review. 
>
>> On Nov 13, 2024, at 2:19 AM, Christian Brauner <brauner@kernel.org> wrote:
> [...]
>
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 3559446279c1..479097e4dd5b 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -79,6 +79,7 @@ struct fs_context;
>>> struct fs_parameter_spec;
>>> struct fileattr;
>>> struct iomap_ops;
>>> +struct bpf_local_storage;
>>>
>>> extern void __init inode_init(void);
>>> extern void __init inode_init_early(void);
>>> @@ -648,6 +649,9 @@ struct inode {
>>> #ifdef CONFIG_SECURITY
>>> void *i_security;
>>> #endif
>>> +#ifdef CONFIG_BPF_SYSCALL
>>> + struct bpf_local_storage __rcu *i_bpf_storage;
>>> +#endif
>> Sorry, we're not growing struct inode for this. It just keeps getting
>> bigger. Last cycle we freed up 8 bytes to shrink it and we're not going
>> to waste them on special-purpose stuff. We already NAKed someone else's
>> pet field here.
> Would it be acceptable if we union i_bpf_storage with i_security?

No!

> IOW, if CONFIG_SECURITY is enabled, we will use existing logic. 
> If CONFIG_SECURITY is not enabled, we will use i_bpf_storage. 
> Given majority of default configs have CONFIG_SECURITY=y, this 
> will not grow inode for most users. OTOH, users with 
> CONFIG_SECURITY=n && CONFIG_BPF_SYSCALL=y combination can still 
> use inode local storage in the tracing BPF programs. 
>
> Does this make sense?

All it would take is one BPF programmer assuming that CONFIG_SECURITY=n
is the norm for this to blow up spectacularly.

>
> Thanks,
> Song 
>

