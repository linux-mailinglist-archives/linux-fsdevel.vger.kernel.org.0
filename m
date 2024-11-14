Return-Path: <linux-fsdevel+bounces-34832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480B09C9108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 18:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E00B32424
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9D518D637;
	Thu, 14 Nov 2024 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TmUYOHke"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D318BB9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731605995; cv=none; b=ZmhsIrwokkNwQ+FI7xSpePIQyrCpjRKjMIw5NVYJt31LMDbcCe4UToADfZKjbkjfFSMDlRHHDM/s3+zyNZHHieci4dyFpoauQlyL5W3GWqljEa0Ud3Z670M1yHs7Qgkz5s/0vCZpz7Mgim3DzgqX2iacdhZzcy8kUYEWZMuhPSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731605995; c=relaxed/simple;
	bh=0Ri26y6BNd727u8kMVaoNzmyXUjeTT1xZXrJxlQ7Tls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mKsS1agUOwbd2x/IfBe+GwMTbMxWRq5ShTm6C0JUaVsUE71HaebSlBllTiBP58hllWxCEt0BOPNLcMkmvBKhx6482gKCWcD76R6Wh9PE1QBEIDnFZGjL8uYAZjwnIvHPl0uoRnwbxquyX7YLMrxTU8+p4RmVskT6F5jCzPH65uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TmUYOHke; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731605992; bh=263+m7XTl10hNqcF/0th/BSfkHJbQiC6Xwiw+AsLuFk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TmUYOHkeH0yYuMyMxji65Z4pI8IroL+otfWphrilXrck9S//cv8BuY1jmGyOc+XvY51Ef+hhiWX8shcF3q2gbE3s8AsQkSaR8MNsbYDJ0wGqA2L/A73LPZqekzYKHfpvHtOq9GvrRAtTqlx7BRbbGGwjTkAlSrxkwwFMZbgNqPMnuWcxWHHUa1VXXlG1HlUZoSALPFfv0DIRYFH/psbhuJSFyd46/WO35Zl6iF2RqcvOLKyN+lFKswWW+5iy2psmAiZOY6s/fKMZQkORf1rexp2LZ2Sbexz5KI2PHnbkYhTiQ6wIexO1yHpzygUynWjK8lMOjjpXVi6sg94FIPHNMQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1731605992; bh=pfY43+rwxJt71iRbl9uQJxkc2OltBAzmjLkxF60YkzC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=foxNgHg5wxIWERW7GIiSB9g0UCOB/inY5gQXhBMlJ1VD0MGsoXHGRnNYob6moExh2ZUuog10LWb2TA3ePZP+WYobdn/ot3clzA5BE2Ld0w7UXlYwslo1z1HLP6j3skokbNQmKvO8udf4Jy2jgGEVGfwQH3CgaMzuq/2kvDOxIkvus3oG1T/np7UElWmSNV+R5iXcUi2iAz2zwZOGRmRlpH1Z7VJfc73NyDHkb25Qsk6P1IcJ6qseWOG1wfOTNKpRV4xrEjVt1RGt4Q3+7nzmDI31+MIZmUs+rKhPFJx2ZYVYYDwFH7lJ9mPPFVzXI1XV8xxaqnKgYyfDrKtm5YjlXg==
X-YMail-OSG: HeXyeTUVM1l145AB5nS_R73jMvyo1oKHYgE0ffzWIgs8pErH4mxLa6iSCn.o9HB
 _62O4EqDuxAvZaVN0Ls2vCRSYTjb5ea3FBe4oTjOBp_Ynak3wENXPEQ6L3ZSMXMzz2EdGayke6iy
 yuvm5PI1XEAUVuMzBlBrdvPKeWouAA3I4lkevvDO19Y9JpixgZ2sqjvyihZdkwmZqT2QDKChv..h
 63GyqoQQbeLcsONDXkQRdfk90vQFHHAiRn.9jBB0GFj2fCuueS3sNZ4Zg5iYAQGMBM8EoIw.jUrA
 eaKPm5QDvZjdUg00aDHmyABrVdjpTDMrQt6cwv_20vwlZgmF7sKr_pMVy3sSTffblb7BGZ59w.xZ
 FPRHXQbJdhj2kbA6vMofpdptNnIN5V1u4wYueT8BhkswqLLwf_1sKeqBTZ1yp0FEbC3rU91wMAVd
 CJqlqEUfWw78aXa39RNke32qFf3C05TLxmtz7ydFdN61Y7HPj6.myUByH4n_HcAldepqybW3Vtwn
 raAoGe8AzZYSicPn3Acg1MBqSkQXok.b6X89YGVCZB1GPntQhm0G3RwpLpHB4FByE4uXjTC9NvJm
 ORGfsX6y7b3mNE57dxCcVXvBf61pbkqPIoWMApSabDY0jqN7a8m5N16K8eENmjJjgNGE1YB2G7Gd
 t6JZAjB__qATXlpEYDxcF.wzx5HGQRFa.03vm2WONpfzL0KZMS.fKbRQlHXfjy8K4CVjUSfUvRze
 dFre8UfnQRIfc80d0JZUUlHXfwashIgvtCeHPVMvK7BIaoywXphB9BivXsWaJDPp3c6qji1SSv3V
 9pKOqyZJ0bYNEFSRpFIcoIhxx3SdpWBpkCpWhYQuloPVd.L1JPUvk5GrTePcepubdA4cnlkqfIXJ
 KpGJWyUX6uKl7EjYSY0S23AccKm5DCWBr21FCXh4kghR0Ly65nN4.G9XrCEPDhLV8x9Q.dTlXYFd
 I_CvBh3g1Qnv_YT4aYjNrL824TfWRdE22Or7kQrKwlP.B0vSiwSCJ0XjnWmtooqBWtbusMSw.szK
 F8lTxzVDNBGX9hW1ORzqLhM0Gd6ASK2cHTk7SdmhylRYmCwig05jt0IMFQ8FZVutuHJELUAW5Ulg
 Uvw8b524F4XRVSPmf0O6i.lC42hpXZzB076FAs_.Eszu5Az7Jde2tReW4iAh6CYOYPUJbYaXDsbI
 dUnQvdQaXfLhEb_Rf_wQtkOIT4mxFJAIwkLI_a9LnpiNQk1Fe0bsl0FQEHsWVP5455AjQLLSBvar
 uOKi_FcI_lVt0hXApRuCdsZvdfOh.zHumvaCeCwxsCty2OTBsSFZu4INOpvqqNN4rMcnQH8_BDHC
 RzJOQ1mLkul6ofhoEC8jhBLGFKbqPQMt_35VET9.znns6bPP47NIAgNMKakRQK3Aqvn4qo4KK7py
 NiZxmWMsacY3bwPayHSENEFmrT6ZLlqM1bJMNE5OH8IlDJ3wCSGt8_LgR2OFrhjFS.O8M5CIffsD
 8cks25e9BOVlwZSWWeOBtY09_F2biy8vDjl4VunPJvMKInA388k9VB4Vhf42NQ1jXunS.NM6QLGB
 SM3Aj7vvF0rol8WooiB8TZfALioEGZiy6ARV4F359fRJkflPVGhcVC1xCtLGpbJeVQ9B7eEhW6sF
 4TL75cZ.iiJ6DchYjGe6JrMMTSR08PtMAz8gbcqPSgvPZQU0orxsFvMcIisaIeShGk3PB5BxKjF6
 Ss5ugUd4yRnUiaI_YrOutnvobpA0ptMqtTX5HHM5Qls0V48f_2j5BzMeEpFVTuiB62Cn0s_8LVC_
 uR8cZQ.UIDDMMqZpV08rne.isV1F3H2BaOZyqlLEWu_6ZL2dIU_VAzbM95wQVp5HRB6cOObqLX98
 wYdp8HLM4KBO6BoZGl8oFCKjiwPyzbUNg97Glr4gvzjUz0tq5PhHtNunSiac9R7bZNrBtFVGsaiT
 MmNdAiSwvTI732oFOeVgZzb6zdGiYQL7o.UpgkWOP6SbnN.J1ER5OlUfpB4Eq26U.HnYtMypxiKg
 3RFJkZI1h__G7MXsgZumRfNQICYB94XKzxItbBDaNr_Oxguy5VIV5xpJXavAXtFpcgn3V72cxx7y
 nXq0dOw9j.sznePAmPUu8lEJAamyiIVAcMRBgVyxgVbvLrtefhObrjX8QcWF2nQ7BdpcEViVz3EM
 0iWWC9G7me6esynGFjuuZSdpgWXfUTQPS2J12QJos5adC5xMrK6b48XSoY9QrP.BQOMZx9VM5x_B
 Qae4RVmJeuKYdFKWfryEe6iDQP_9Nn7XtY4caGJkQr6VrgExhnVryKgLANl2r2f2x_gsWMI0FhMV
 jxNEM.FE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 81d03b63-939c-4e86-a69f-4777cd396e25
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 14 Nov 2024 17:39:52 +0000
Received: by hermes--production-gq1-5dd4b47f46-9j75b (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID debdf0be1d06a72001b6043acb052466;
          Thu, 14 Nov 2024 17:29:40 +0000 (UTC)
Message-ID: <53a3601e-0999-4603-b69f-7bed39d4d89a@schaufler-ca.com>
Date: Thu, 14 Nov 2024 09:29:39 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] Make inode storage available to tracing prog
To: "Dr. Greg" <greg@enjellic.com>, Song Liu <song@kernel.org>
Cc: Song Liu <songliubraving@meta.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
 <8c86c2b4-cd23-42e0-9eb6-2c8f7a4cbcd4@schaufler-ca.com>
 <CAPhsuW5zDzUp7eSut9vekzH7WZHpk38fKHmFVRTMiBbeW10_SQ@mail.gmail.com>
 <20241114163641.GA8697@wind.enjellic.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241114163641.GA8697@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22876 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 11/14/2024 8:36 AM, Dr. Greg wrote:
> On Wed, Nov 13, 2024 at 10:57:05AM -0800, Song Liu wrote:
>
> Good morning, I hope the week is going well for everyone.
>
>> On Wed, Nov 13, 2024 at 10:06???AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 11/12/2024 5:37 PM, Song Liu wrote:
>> [...]
>>>> Could you provide more information on the definition of "more
>>>> consistent" LSM infrastructure?
>>> We're doing several things. The management of security blobs
>>> (e.g. inode->i_security) has been moved out of the individual
>>> modules and into the infrastructure. The use of a u32 secid is
>>> being replaced with a more general lsm_prop structure, except
>>> where networking code won't allow it. A good deal of work has
>>> gone into making the return values of LSM hooks consistent.
>> Thanks for the information. Unifying per-object memory usage of
>> different LSMs makes sense. However, I don't think we are limiting
>> any LSM to only use memory from the lsm_blobs. The LSMs still
>> have the freedom to use other memory allocators. BPF inode
>> local storage, just like other BPF maps, is a way to manage
>> memory. BPF LSM programs have full access to BPF maps. So
>> I don't think it makes sense to say this BPF map is used by tracing,
>> so we should not allow LSM to use it.
>>
>> Does this make sense?
> As involved bystanders, some questions and thoughts that may help
> further the discussion.
>
> With respect to inode specific storage, the currently accepted pattern
> in the LSM world is roughly as follows:
>
> The LSM initialization code, at boot, computes the total amount of
> storage needed by all of the LSM's that are requesting inode specific
> storage.  A single pointer to that 'blob' of storage is included in
> the inode structure.
>
> In an include file, an inline function similar to the following is
> declared, whose purpose is to return the location inside of the
> allocated storage or 'LSM inode blob' where a particular LSM's inode
> specific data structure is located:
>
> static inline struct tsem_inode *tsem_inode(struct inode *inode)
> {
> 	return inode->i_security + tsem_blob_sizes.lbs_inode;
> }
>
> In an LSM's implementation code, the function gets used in something
> like the following manner:
>
> static int tsem_inode_alloc_security(struct inode *inode)
> {
> 	struct tsem_inode *tsip = tsem_inode(inode);
>
> 	/* Do something with the structure pointed to by tsip. */
> }
>
> Christian appears to have already chimed in and indicated that there
> is no appetite to add another pointer member to the inode structure.
>
> So, if this were to proceed forward, is it proposed that there will be
> a 'flag day' requirement to have each LSM that uses inode specific
> storage implement a security_inode_alloc() event handler that creates
> an LSM specific BPF map key/value pair for that inode?
>
> Which, in turn, would require that the accessor functions be converted
> to use a bpf key request to return the LSM specific information for
> that inode?
>
> A flag day event is always somewhat of a concern, but the larger
> concern may be the substitution of simple pointer arithmetic for a
> body of more complex code.  One would assume with something like this,
> that there may be a need for a shake-out period to determine what type
> of potential regressions the more complex implementation may generate,
> with regressions in security sensitive code always a concern.
>
> In a larger context.  Given that the current implementation works on
> simple pointer arithmetic over a common block of storage, there is not
> much of a safety guarantee that one LSM couldn't interfere with the
> inode storage of another LSM.  However, using a generic BPF construct
> such as a map, would presumably open the level of influence over LSM
> specific inode storage to a much larger audience, presumably any BPF
> program that would be loaded.
>
> The LSM inode information is obviously security sensitive, which I
> presume would be be the motivation for Casey's concern that a 'mistake
> by a BPF programmer could cause the whole system to blow up', which in
> full disclosure is only a rough approximation of his statement.
>
> We obviously can't speak directly to Casey's concerns.  Casey, any
> specific technical comments on the challenges of using a common inode
> specific storage architecture?

My objection to using a union for the BPF and LSM pointer is based
on the observation that a lot of modern programmers don't know what
a union does. The BPF programmer would see that there are two ways
to accomplish their task, one for CONFIG_SECURITY=y and the other
for when it isn't. The second is much simpler. Not understanding
how kernel configuration works, nor being "real" C language savvy,
the programmer installs code using the simpler interfaces on a
Redhat system. The SELinux inode data is compromised by the BPF
code, which thinks the data is its own. Hilarity ensues.

>
> Song, FWIW going forward.  I don't know how closely you follow LSM
> development, but we believe an unbiased observer would conclude that
> there is some degree of reticence about BPF's involvement with the LSM
> infrastructure by some of the core LSM maintainers, that in turn makes
> these types of conversations technically sensitive.
>
>> Song
> We will look forward to your thoughts on the above.
>
> Have a good week.
>
> As always,
> Dr. Greg
>
> The Quixote Project - Flailing at the Travails of Cybersecurity
>               https://github.com/Quixote-Project

