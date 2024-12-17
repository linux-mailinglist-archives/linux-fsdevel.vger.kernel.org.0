Return-Path: <linux-fsdevel+bounces-37665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D369F5910
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 22:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6457A3801
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 21:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD11F9AAC;
	Tue, 17 Dec 2024 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="N4D7zIa5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC514A0A3
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472177; cv=none; b=NyrD0vAqOZ6oIubw4SOuFH5Os1LojMLOev+XpX80/MiT5Ehh1E+Si1etZ9OStdoFcB47nkNjowMOvTCJgOp9jAIhspwgfU/+dQcvU96II8AsM1XBun/gbBQvOhLQ9X24Hx5x7K38Ybo3uuIAMaO/59FsT761fzBqCu56lJgu3aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472177; c=relaxed/simple;
	bh=EpJAESYstREUkUwzWHiD+ccRjjVprfi+ihxLTuTqk3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nYWf9eOA3lRs4vjmTl8Lk9E7eYm4TCbF+RGKE7hGPLlPd0tpS6YCxSG0ysJR0nrVSw2re0ts9NcGgbR7zT0sRxAWWnnfFMQ06YpaOhDTGn8yjsmwenrzRNpTYp2UMMGe/p5hMyO7CHoBBPUruJ650c3xwJU2qdtgTFkhTcur3xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=N4D7zIa5; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734472174; bh=MFZnnZvpOi5fa2Z3TyuZYvU1E7VYj06cS2HrX4jXJ4s=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=N4D7zIa5XFSgE0PW2MvMZcah1+iZtHV0dbLJMnwfsiX+6JDbBEgkOVF/DAtiTxQuqKGVJLj4WplSr+ZmsjJWOZhbnv+z1i9r+G41dXCE2B+LYXDWjkWA2nMhH6iNOLbibErz0wwK6EWIOr3VcVlH6EPRs9V6edEZsWXzFz7tARj8Y9pbzIEA4jZL5Ce2yNW6yE5U4hRpzAd/oL0laOtfRvHfM7M4mM4CiCQAeAtM5QxiA4T6K3+dHQ44H76J63zXnt7Ru+VdspEHeMuDC4dZ5IWkpdJdnwfptkiOJT/2hsErtBniE7gaygoZwWqv7WdjUJtwPmw+oF0vgVydjtvrwg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734472174; bh=eIw+tf1Q7HnCZT6euRahzMN768QkpMlzFzRYqZKpwdO=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=rHmnUp7hLkvvPEJpptNivT4a0vodtW/SWblU9PsNXD6me74hrTZqYNOyAeVCFftFTHmC3VOU/GXtCZ9OsD6gRs3Y3pNcmdDCBCRicLA1iTDUrPLM/uKYgcnmPmuS7l5ZZPD3WN3DMZsmUXJHHCj05HJ6FN1AhWf1mY/aNMzgRHp2QupNhhBCBnNc1e3SjobL/z+fJNLUJIQLUNb0Zs3iaL2AfyXNlIIZz59WU/HC2JoWhgyddRBm+KengXZs216YqPdmiQyZVIv4+uwuFNI6eHfSflaz5ps7Xx1pe2nzBL8bS8TiGVwxybwZdk6BPifyAWEZuwDO4sYnmwzgmGmoFQ==
X-YMail-OSG: QViyLlAVM1lqRfNBRuqD07fIT8i75AiBHNyy9FcnQQCpVFz06OPPYNWXIe_G.7x
 p6CB371qA2g4xtGVOF7tAMSnFL4Jb1STwdp7HX7NEjqS1MciGwg.ZSZsqBAeHLigPPhPdq5QEFyy
 Qkls.lpdRfouSH_xy9_.z2AuMJUxb6ncK7S1dPuWyMr6jFrmvXqjtccKSQfe0laDWbFeAadPzhmK
 VArGGxWIXpd35cYl60NPjxmJhcJ3l67TLJZZ_0ueR4NnVItA0U3GqOsFkooirayg7xVhRxhy50HZ
 RHK7i8FFO_RWITDopFsiKlv2lV7WEyi6MB7zHsJ5TlNa3wFWF_jiqOFtPAmpOv8E3gxnWTWmPBPI
 Vp7FzMGMVDs3JDvZVS0BfLCnAYKXcppf7yWxBNrVyJv4ZCMJGl0nEUvZryly._YZ8KELz7LrLF87
 rNrjpJ4aS.HevsykZ0zNoLBNBUvMRIGuX.x.2cPc4i08xajKuvcxUV8emhSRAacLtaD8sldKDokA
 tZ_pgG7hCdbPW2t8nwnP8xhHsf6f.WjyjUJgt6wr2lDeGNeS2XUuEgqyr0DEevb3GXfPFRDq8Y1c
 DDMEEB.F3HUEKHciTsLMF0D_VsyPG2obMHvmY6rsi7Om3hh3.1t9dqu1yLKIbiz0oU3dmzvvDNmf
 .diAzTbtGqeL5NTwUr7rePTXmUQ8NSAcq_naO7U8ievh49Uv26Fv6Bhki.8Ltum7kl4kwig5F5XC
 FLrXzagAOOq5VUpP1wvQJNBOv2WGSny.Mn0DS2NYBdNUA5NcvGefgAYQMH6jdpzYnpvSVkLfDV3C
 byz5xVnInBA72JMzyEsfigFMCh4vVs3v4BDZL3lvVb2vobBIb73cRKBMe6o6Wt7FFaSjx6LpRP9z
 XzOs3IYBvqm41_ebO5jgrXwHAJPYkcBtpfDUTpwd3apOYKQrrvikrZ86_UDQJGOfLwsZjeENQVF9
 VQCXJlCyJVUfZ8htUL8B5aDZItS8tmeLhVzWzUkrMqrtu2po3vNSHceepqSqCTxqTs9po.PmU4LO
 axee3KxuXR9vfPWL1SdZHt6DC.rl5qU4tTG1zOPBWhZrDAlZVugXgFVPdmnMpjLP0wGbt8492uTd
 H1STJby_Sbm2.qGYykC.FJkMbp6lQi_..aLfdYNMH.sWnzV1aoQRTcwJgveLal5XxES0y3HnGUYS
 RWIpbKYCtSk82OkDLMKAYI3JBmzHYYpvm.JYbzr2mtJ3rtFG_DrAOaqwW5EWKz4damNKRj01nf22
 RvgH9UuqzUUzYH4.CEnCUy3WQk2TYAhF5.Z3FfTS75YvRU4j3j.3LbFi4n.M_CJ6nnWSWYDN9WTw
 2MrSzbgU1lKJ3AXzFEs2UXtd6InzfHtsjtkY5rO3ZNVu5qSaJyPqWrqKLASuNLp8540ZKnK.79QV
 Sr6gUMcKqIPi8YSNOIhLnO5Dj1NlZ4bH4pvBxpNSAts6FZD0EDtgY6tRCrwy4TUiofD_Vvf8NHA3
 xjV8CMEzmYldEfL2TaVxRQ2bmCMzL9qU_g6Os41Dyiek5bXDlhSvvPZIoZxPclmxRZXXsZap.NET
 jZOHJJpk8D_nSvacYWyhw1gSfR3kykbygFJl6by76jQkpZR7hIiDPPiWV0zf2KeSbHoGlaPDnOBK
 ep6Bo2rnnDAyjdGOLaLawVp0U2IHbDdwh5PiXUZHrgKQ0gw576S4.ICA9gjXzaRjobweipFouQqp
 VKOlxILgPRauXeU8Kl0mcuwsNL1nzoyuwSF1HqpRrThos4pvSEUL1h0M7qIVNLTAAxj6rMlKakor
 2dCOalysWJRCF9jI9x8o0flw6zAr9sfyGh0aeL16e_c.UwXs6RSfdbq5z13WRVplFvbcmmBT2AMg
 beteEiamPHFB08geRuzCFDU6Guw9NBm1VqSY4A7wMZVbjwlggaC_N3UB70uy8xIDXBjp.Xqh1DRT
 cPptzRUU3gJupoygdhm7BY64GjxW8H80znYV9HDJ2WiBV1ftkFGKosoAJtmYcKl41ybgZlxmmz0U
 hRurcqBebQtmmnKzKISBz5k_jfpbb7aPYV0E744XQtgjATZl_etMQwnNs.B1SgGBEcsfm51Vsg..
 Tx._eAxwsFALqxPh6YlfVrMKxJW5BCBs.99gdoJWwOoOGd0eX16Wa0XjtD.S173kLu6yHORyjvDM
 .E900in7mtHnKDdEQFk7rEmPq_yGtYLWW7V3PCSTwx5AatUjIJccwVDquhu5TBOAL6uTml9FhAJ2
 J8PrrDJTO2QeZ3jvhJWHVp.P_VrCz9XryZYIMEp.9ZGuuhA4-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 40b94c5c-efe7-4bb5-8b7f-63e1369507de
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Tue, 17 Dec 2024 21:49:34 +0000
Received: by hermes--production-gq1-5dd4b47f46-wrqn7 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 82894e06ce5306d6207d6522cf15808a;
          Tue, 17 Dec 2024 21:29:17 +0000 (UTC)
Message-ID: <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
Date: Tue, 17 Dec 2024 13:29:15 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
To: Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, kernel-team@meta.com, brauner@kernel.org, jack@suse.cz,
 viro@zeniv.linux.org.uk, Casey Schaufler <casey@schaufler-ca.com>
References: <20241217202525.1802109-1-song@kernel.org>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20241217202525.1802109-1-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/17/2024 12:25 PM, Song Liu wrote:
> While reading and testing LSM code, I found IMA/EVM consume per inode
> storage even when they are not in use. Add options to diable them in
> kernel command line. The logic and syntax is mostly borrowed from an
> old serious [1].

Why not omit ima and evm from the lsm= parameter?

>
> [1] https://lore.kernel.org/lkml/cover.1398259638.git.d.kasatkin@samsung.com/
>
> Song Liu (2):
>   ima: Add kernel parameter to disable IMA
>   evm: Add kernel parameter to disable EVM
>
>  security/integrity/evm/evm.h       |  6 ++++++
>  security/integrity/evm/evm_main.c  | 22 ++++++++++++++--------
>  security/integrity/evm/evm_secfs.c |  3 ++-
>  security/integrity/ima/ima_main.c  | 13 +++++++++++++
>  4 files changed, 35 insertions(+), 9 deletions(-)
>
> --
> 2.43.5
>

