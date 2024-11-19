Return-Path: <linux-fsdevel+bounces-35234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6419D2DB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A251F26FFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3FD1D27B3;
	Tue, 19 Nov 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="bmQ5uE2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic308-15.consmr.mail.ne1.yahoo.com (sonic308-15.consmr.mail.ne1.yahoo.com [66.163.187.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26F1D1F44
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Nov 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732040083; cv=none; b=TNqE5omuRIS+4+4b+24qbgAnVJkr+Wm5Ae6AGUFy4Nc4kJFXbfitHo5nUQqLBjy6IfVLu9U66FHjFfz1LZ1RpHSKvNGQzK3zMC4oEEywgMONqHTlBiDEN0KWEvpP2n7yn0rbxu1pUmHfk2soILUIxa3YBvrMm8MJIWLd8KvNQUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732040083; c=relaxed/simple;
	bh=YGrukaN8kCGJGHRiUBBNlloY3HIJBATms6xHILea7eU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/Hx+DxWyfuL3Dx25lxx7Y2KtvM1MFcIFj9vk5Ry11UkelMPSmRTdnLDQ+67W0Ob8KPUaoNZi2jXOOjvu4FygMKfGsEZZlBzx8QQwA4VbXD2dQ8JrzyfHrJ5/gY/D3MR9dK/SegmA6fMoZsaJZnIV5zFLIo26nrfLFksd34BPno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=bmQ5uE2O; arc=none smtp.client-ip=66.163.187.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732040074; bh=5MIDBio7RlI+gPVccsIcQjhlUCUhZSZMz/kKi+sUibY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bmQ5uE2O78KsM8XPxQLychbU4wMe9Nes7avYA5o2GlYxqA8v+6nM6bINUbsXsb0sDk6NQCoNkZwTJFsifybzfYRgmLzZEn/pYzoZAvEDI71XYR41a1treuog2gANxOXXrW4NXGOTw7ShIF7Vdz5CBqaOL2oxFcq6FgOhsESKxQUtkD9rDsDdqOWPz8dY2g9kGi3QL8+paG5GTEXN3j+whQyim1qTUEM+vnB4z6Nd/L2igU5Hstznypmb9iGd4e+ntaGA0EUTZ31etEoMuPucRNVc5A5M8PNclO/m44Vv9/hWox4QyWrzEdMgJT569efhuigZ/gCvGbZawbSi311PSA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1732040074; bh=XFdHigJ/GeFgQpVvuO65RIEAzhhWOiqFs8u/gTUjOTO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZuHZ/A1/R+b8F261h9LAuseVDaaKVrerTig2NtOBvWauwx6WGEkN6ymAWmbaZpgVb8KXexH1WGXbhmJnl2tT1T/pEKxjTKGrbhd5s+X04Hn8pjOjeqT2fwC7bgnr9+w5RhPyDdNpWlXWV/8yCscleJDLz/bW68B3ZyJk7TCQFjUkBUCkS7EbjZPq2yk4YsYEIvtIzBk1seBE3ctcHm8ZLnrNXaRqU4bSLK+rZutYcQfy6Np07c5HNOsF/I5b4KviSmXAEJPOQybVKUG6I1XvRhf4UuSpUufWlEjiQg/Myn0VG0k64y8crCfhb409oJt/F1Yf/rR6ivPWcWC8kwKBlQ==
X-YMail-OSG: 6rs14YgVM1mx3RJGgJzukNZGZIxrTZH9y6oalS0qyaY7C23ywG6p6vuGpvSRhRR
 wesKDlWegn8nioGj7agjHP0.lcJAgX7KcVXHAbL9cp0V.n.H2Zd0OeVCGKhP0Snj0twPPRC1ft5W
 RUztQ1XGzxdy1QcKzDCx61eIgD4vGVCey.aJqdTqKWOyMo2Nq2xYM_2Wew13zcm3WIe.seAXGdWE
 4xEry3RxBDQaPWAfErH0ibwMmDVmI7YK48MPzoMQyOHjD7D.k18wj6U3p_k3pSs5Uxte2814COzY
 UeZEQWrgnsld3MGn_vtyw5fgh5BqTUfj3m3BVsb4.rgbJ0VtBdQJa_6UjnECsFg1tkpnqUJaKO1o
 tt9jErAyp7JZciliWcbTeiLHeBHShgqMwFe4r1r.N44TuHl3XSEQUDwu2F9jB5jjxKV1JBA7aOab
 4k3t.ZoCIeKEA7X4KEfq.WqlBkKa5QgnJj5Q6Yrzz_kbwZ4xvAujWJoIPdFG3QI5AyRLhKGip9Sh
 hJIVSPuXMr2sREvUbL1OFUayNHa6lMKAdkxPhddpz4d.pIQbJPzltOfTJ8ERzirS8cfRZxivrtGv
 SpRDIabttsFeKJ6KCmXSrfyFqHXB_pdDhcLc9YpWnor_RArbOBdgyKe9dMc3D3MAFKRd7dhIbRBs
 WvD_B_IcbTPnyjqskzh4QETYNsrLi5Vd3dMvga4m5DvPPObTt3Qw68Svz7KEMFupc5HVgs22Jekv
 2PlVN5YKmN94yYKgc9ITjQUzP18M1clsdh0aY0MWubEa.n_prkMvMU4wcYCTju.inl9qrEh6zd9j
 iIgO.FJvn8kQX.voZ64dqaD0I0fPkD.KZr8QqyzBMab96J6JkKdmsoLV5oCCmpUcPFnhiTvseaIm
 N63wyLgn1XVogMGe6aDqBA9yhcXQjWgE751LIsvgPTKpE.F143TtQOfRDq.g7IkTwMiN.nEpf2Zd
 QNKaiR9Q6.X3LNFF4FuP98tqrg.yyXF9c4xBchkMicZwuPSSbnR9_hwxi6y3bt_Dme5FILnQOYL5
 .D_0RZ6PYFz9CqMfqvcZhpF60fwIGfPieetSW9GAnrExjFJh17yu2Py8wLcA9NUQFTU5HOTxrOWz
 31zVnapO7gfOO2R6VJ_3m7RfzQt4dwJz8Jfilx9mSBAB7inRt3_Vw2YqQ4g5Cwym0IG5f.BQf..z
 pxxzmv.GMAmNPwjvy2JJujOAamBmUFBF.lw4ArKO6oBkm.199JjVkkuFhGaYRzVKzSmluybIpK8v
 Os84Sj.8UfmEYpirH5x99fNI2avbgWCHTq8y1C9XrTE1ljQwAQberN5fOoCUcexbEhOsPDyAr8ip
 5gB77ctmNNdE03kTyO3KoSnUupdetL2UVNJT6knXOYaWX9Whz8I17lorS.ZWf6D2QFSXun00B1tf
 4oRY6gqSsls7XDELbpG7c7q3aDzCIpm1qnMXcm4wjgPJ1rhWdM1O0GF0h8P1bVwwC3Q120bro9z2
 cJtmZiv8BRZQAokxD_UvBcEeHrEdZWr2BPP0IJfzQqxHmE9JWDBsElKAD2f6TQvXFe8TiGmSIDJ1
 NFQudfwM8631OvqwkKbctOsB8k8tEP1AV4gWOLJE4w6dXj4_BbXbtd6p7NTVFzMjAw1hP7l2F1tG
 q3e33HW_5FTmYw3.wyRHWvE9s.aQmiWz34g1zlo9RuEqgmDAbPYyXw9u7HEmKzWf53L3Kxd1ao0C
 Pd042DZ1LiWgCXZldNkCqNwEGZUeQpAL2MuipTE8uKbC09yiKMxqaiAgJCkI9v1qw0EM2tkoUV6i
 zR7jCAafDyxvRfwx9ha6k.y4U4snN7pYA09DPDTOkRMO.i5FbnPRIDbi7_r9NMz.drhr1R5a9Lpp
 5gbY05nBR9hKGiQlfKE3dj3GzwloT_5TSLOTtsURTNvzKn7PkAPMfcWplc4T657Ur0kQp8vpopra
 xewnWeot2LNj1KR5g0XCFiD.YHD_uzvsQ4MRWmV3_SlVpZxEYek3aIH1qngDXm15AIF5DEhEihKy
 oJn5WptUjZYroub5JGuNu8EHnItWPnDkfq50Ne1mbBTb9VKtPo_j3FlENijnAZ_Nl3qLgT2SoM_k
 5cEks9v_WA.pBqwbkpOh._UpCHSaenlEIx9EwSl8A7PYBMQdGtdx6cdL5YFBSvFSL0abdjMxKhBy
 VL1XrrlVRDjAYq18m2XhxWdTtZ4oXyPVrmuqMRlIpR9UE7Yxpcke4.luhU5i.0CPr.5fDOC7Y0Ci
 aJ6KcuxnKUNfx2NUYUJD0g12NQ57NgGRlMUJpiL8SaKcJ_e5XQpdrJU12QBb9K1lXExdBufv6Lju
 71Dg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: aad1bbcc-f8f9-488f-987d-e0d77ab82508
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 19 Nov 2024 18:14:34 +0000
Received: by hermes--production-gq1-5dd4b47f46-fhdpd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0a7fa34da5b4eefb55e99d41ad7bb4d1;
          Tue, 19 Nov 2024 18:14:31 +0000 (UTC)
Message-ID: <561687f7-b7f3-4d56-a54c-944c52ed18b7@schaufler-ca.com>
Date: Tue, 19 Nov 2024 10:14:29 -0800
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
References: <ACCC67D1-E206-4D9B-98F7-B24A2A44A532@fb.com>
 <d7d23675-88e6-4f63-b04d-c732165133ba@schaufler-ca.com>
 <332BDB30-BCDC-4F24-BB8C-DD29D5003426@fb.com>
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
 <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
 <4BF6D271-51D5-4768-A460-0853ABC5602D@fb.com>
 <b1e82da8daa1c372e4678b1984ac942c98db998d.camel@HansenPartnership.com>
 <A7017094-1A0C-42C8-BE9D-7352D2200ECC@fb.com>
 <20241119122706.GA19220@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241119122706.GA19220@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22941 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/19/2024 4:27 AM, Dr. Greg wrote:
> On Sun, Nov 17, 2024 at 10:59:18PM +0000, Song Liu wrote:
>
>> Hi Christian, James and Jan, 
> Good morning, I hope the day is starting well for everyone.
>
>>> On Nov 14, 2024, at 1:49???PM, James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>> [...]
>>
>>>> We can address this with something like following:
>>>>
>>>> #ifdef CONFIG_SECURITY
>>>>         void                    *i_security;
>>>> #elif CONFIG_BPF_SYSCALL
>>>>         struct bpf_local_storage __rcu *i_bpf_storage;
>>>> #endif
>>>>
>>>> This will help catch all misuse of the i_bpf_storage at compile
>>>> time, as i_bpf_storage doesn't exist with CONFIG_SECURITY=y. 
>>>>
>>>> Does this make sense?
>>> Got to say I'm with Casey here, this will generate horrible and failure
>>> prone code.
>>>
>>> Since effectively you're making i_security always present anyway,
>>> simply do that and also pull the allocation code out of security.c in a
>>> way that it's always available?  That way you don't have to special
>>> case the code depending on whether CONFIG_SECURITY is defined. 
>>> Effectively this would give everyone a generic way to attach some
>>> memory area to an inode.  I know it's more complex than this because
>>> there are LSM hooks that run from security_inode_alloc() but if you can
>>> make it work generically, I'm sure everyone will benefit.
>> On a second thought, I think making i_security generic is not 
>> the right solution for "BPF inode storage in tracing use cases". 
>>
>> This is because i_security serves a very specific use case: it 
>> points to a piece of memory whose size is calculated at system 
>> boot time. If some of the supported LSMs is not enabled by the 
>> lsm= kernel arg, the kernel will not allocate memory in 
>> i_security for them. The only way to change lsm= is to reboot 
>> the system. BPF LSM programs can be disabled at the boot time, 
>> which fits well in i_security. However, BPF tracing programs 
>> cannot be disabled at boot time (even we change the code to 
>> make it possible, we are not likely to disable BPF tracing). 
>> IOW, as long as CONFIG_BPF_SYSCALL is enabled, we expect some 
>> BPF tracing programs to load at some point of time, and these 
>> programs may use BPF inode storage. 
>>
>> Therefore, with CONFIG_BPF_SYSCALL enabled, some extra memory 
>> always will be attached to i_security (maybe under a different 
>> name, say, i_generic) of every inode. In this case, we should 
>> really add i_bpf_storage directly to the inode, because another 
>> pointer jump via i_generic gives nothing but overhead. 
>>
>> Does this make sense? Or did I misunderstand the suggestion?
> There is a colloquialism that seems relevant here: "Pick your poison".
>
> In the greater interests of the kernel, it seems that a generic
> mechanism for attaching per inode information is the only realistic
> path forward, unless Christian changes his position on expanding
> the size of struct inode.
>
> There are two pathways forward.
>
> 1.) Attach a constant size 'blob' of storage to each inode.
>
> This is a similar approach to what the LSM uses where each blob is
> sized as follows:
>
> S = U * sizeof(void *)
>
> Where U is the number of sub-systems that have a desire to use inode
> specific storage.

I can't tell for sure, but it looks like you don't understand how
LSM i_security blobs are used. It is *not* the case that each LSM
gets a pointer in the i_security blob. Each LSM that wants storage
tells the infrastructure at initialization time how much space it
wants in the blob. That can be a pointer, but usually it's a struct
with flags, pointers and even lists.

> Each sub-system uses it's pointer slot to manage any additional
> storage that it desires to attach to the inode.

Again, an LSM may choose to do it that way, but most don't.
SELinux and Smack need data on every inode. It makes much more sense
to put it directly in the blob than to allocate a separate chunk
for every inode.

> This has the obvious advantage of O(1) cost complexity for any
> sub-system that wants to access its inode specific storage.
>
> The disadvantage, as you note, is that it wastes memory if a
> sub-system does not elect to attach per inode information, for example
> the tracing infrastructure.

To be clear, that disadvantage only comes up if the sub-system uses
inode data on an occasional basis. If it never uses inode data there
is no need to have a pointer to it.

> This disadvantage is parried by the fact that it reduces the size of
> the inode proper by 24 bytes (4 pointers down to 1) and allows future
> extensibility without colliding with the interests and desires of the
> VFS maintainers.

You're adding a level of indirection. Even I would object based on
the performance impact.

> 2.) Implement key/value mapping for inode specific storage.
>
> The key would be a sub-system specific numeric value that returns a
> pointer the sub-system uses to manage its inode specific memory for a
> particular inode.
>
> A participating sub-system in turn uses its identifier to register an
> inode specific pointer for its sub-system.
>
> This strategy loses O(1) lookup complexity but reduces total memory
> consumption and only imposes memory costs for inodes when a sub-system
> desires to use inode specific storage.

SELinux and Smack use an inode blob for every inode. The performance
regression boggles the mind. Not to mention the additional complexity
of managing the memory.

> Approach 2 requires the introduction of generic infrastructure that
> allows an inode's key/value mappings to be located, presumably based
> on the inode's pointer value.  We could probably just resurrect the
> old IMA iint code for this purpose.
>
> In the end it comes down to a rather standard trade-off in this
> business, memory vs. execution cost.
>
> We would posit that option 2 is the only viable scheme if the design
> metric is overall good for the Linux kernel eco-system.

No. Really, no. You need look no further than secmarks to understand
how a key based blob allocation scheme leads to tears. Keys are fine
in the case where use of data is sparse. They have no place when data
use is the norm.

>> Thanks,
>> Song
> Have a good day.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project
>

