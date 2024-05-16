Return-Path: <linux-fsdevel+bounces-19619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A598C7CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69905287588
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0845156F57;
	Thu, 16 May 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="asqs+wVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE90157467
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715886439; cv=none; b=Y6zIVvIwDHWTxpHoVZZQ1UIgF4EyLVElq1A970xhP+BUSNHT4HLfJSKkO9f7wtmTGTQRJDl+CMf1+33YC3Gzskbod/1DC6ZTDGMmRIVp6yuBHGap+YO9iORjLi679x/cQWLaZvsJFg1fJU3BajiB6SJXFwIp1TWSV9XkfThonTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715886439; c=relaxed/simple;
	bh=wxXjpMQ3CVgL6XhPOBwVDZJdQ+2ElLYlyyUvbGIHuVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HszpXGW+9NV38iluRRP0T1wf2uDn+yO8xMKWk2ZMHTKwgGJ1J0WuX3JQxx/ZuZomzcbHOet/uWBjIOROF4ygj6+mOMkr+AboeCybm7IcluEcLKnKc2fbX7iiF1xVX3hTgxiynukmD46V+W9qmde6Ij7KtdkDDWKwLFXpTw3Ril4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=asqs+wVl; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715886430; bh=yNlZ6SD8AV4L2IiFccQWOEbwRuaVS5TqhgBGaRz5hS0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=asqs+wVlFKgk77FMOf8o18CsUL3aYTBEr8Vd2ExIMeEDlhUtTyVn6FpEax04DGIBxTM4FiRhBrBrKrod2qCpcRLQMH5Xik6+nvOo8VeUnkao2MdyeZSpPRAvEY+DnjOE19g5Z09M26OMo6cE4WhQM++b+zCf3lS4P0wx7xPy2Z2axd8LV9k8Es7U5ybr8t4PjYzdEKwBjK137knuIXtN37YbqXOYn70zGyGn1LH1Mxd+f9p6P8pfQ0DKNT5YytvWxc9PgFCbPqn4p/cq4bE4b8KMki8VVX2BBqF1TzUCkvfKGgyO5M8Xmj3ykQo+S4EzhA/wXZPnQOiThxYXYdWg9A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1715886430; bh=xs+KbK7iZ6xb8mK5Dh8mGIcifqdDvmM0US8FwFZWRhp=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Jvvobh+sWltZLAmlyjFixKR9nDEbO65QdDjVDUTGfMzFheEcUgvTbJAGlkDWRpOcMbJurZ6TZ3klHhucFvCGdjrfD+TecXaZL/e1c8t84szXs6QX3AIQFiN/YriJe5dzeoxPKoEn0YdreICy965aWGPELwizkcB9A028DefgEVsxfp00zeTCSUfESNKfHIR1OJVvFLaBxkSdyd/LP2mJjNY1tasn7pdM9wKXU03+TeRqYOshOkq7yIBhNRol41OUnEWFAhe1zlfdYA7q7JwPiXGZGvS8U1K4wDAyoSKjqgSP5BMFPNU69Z5D70YxvqMLQHG64coP1JC2maU86x5GOQ==
X-YMail-OSG: pZBMlF8VM1k2zM2XHcCduB696.Z_YU2fsX5EmVOh6R0JnHnJI8PWMIznjX5mEQf
 Z7KMY55FzxPakQobR1lVZHHHQIJMqULL.t6gufmJ3RF.AxcHnD6yfDQcnTUvcXMXOCzClqORm3nE
 qXIHnF3GPVG9vlAUMjqMyPvyeSQ32pD89D8Xwb3CeLnpvFETG38Hkz197lc2gXbD8LX1nmLBpz3s
 xT5kAkiDVxum841pNFUhyTp5zijzlkLe7oq29Lty0y2zpZDR0anxz5d7Yhz6p0t7bul7wCvCEaH4
 A05.R2OdXdTL0u2vIAHCVxmiseZZ2GuT91bBB04hZg_OK0Xv_Iptps9AseR4Z4lkulMSEMmagfAY
 cSMJaiUxYJtG13KQzJYWaXs2jXDdR51dQLCIeRJh.GxIuMhXHuSjlA5QuZpmS_C_x6ntBfB.sVBh
 t_qizro1_UYBlAJsEhIg9.mk9P6mqG665_DwmLzltxj8Dmj_wXSTH_l_dRvdmH8ZYbRg4kqMD4SC
 5s_OXQ8afqu0BTxo8s2DF_RlXtKROPwX.cvEikrOEi6vpOdN2sz6379Jr9.jdPlmBBMPOiaG4g1w
 z6qNztXrLZyhrPJ6LF.mRrJluHf4eCte3M6qgG7rEvh86RBbvbzJLheb_0aoKr9QPkl59ISiwMQg
 xO0ZXT2HDmW28eqbbqzL0CyzEmmyrCibk.KmRrObawRwrrwx8GstXlpb3M7JJDCE74rQtjY377GS
 hjrO2B2lB1fLWscC_KUC7ktCdTMYhF6AyYGBr9k_pEZlxOrjggZ0Nvb0xFc_KjMifHLmRI7I75p.
 xB_zEdlvr9typvSIIEFn_dPc3gJSHsFw6lnjCbofx3tMGUDSE2PqCJNLe7LPdBX908ITsQpw2xwy
 pM9h.GYqw1HRkYiXaCB7siZmWx.w.mTSPADNytEBh3VFOl4nxOcvgSZycUuu6fsf3jEMqoH52Kgz
 w45fCrQn_FP6PeOxWIs7ChQkHY7tydT0T5d_s1wsDfwsyvwzI.NArkFRgkFt_ai5eSssQ0aGPGEf
 eTWKmGi3UUrjVTSsZAjDqN8wqpX1FzR_wjGeIQLtS76iUbkbDZfXQy6EBjeBW88SseUSTcNCE.b_
 K5tRJkcq9tgFUmk7WRkFoGGQyrZ5g6r0mGt1RqqeqZkpxED85coDid8UCFXJGRDb9FyBsBjGsoQN
 x3_5nXXcp3ZH64pfQCI7qy4wSEeuiuP36jxYhJO2M52yooM19CBMUR3pBhdw.mj7VeZWbVLNNDzL
 9qIvhALHLYMs4cuz6ILakLYRkVGiwMuD5IB4_as7DI1WMoMKQAZQAeUxllqsr2w_YRKlUueaBWr3
 Rs9gNMDDcY3xZ0Vg_.j_hKZwen3JQw_XX7V0I01PGziLVP5o04Ec5SUj83.n24ivjg5qzcatSJn0
 g1mpqL4qubfa0.yWBrcya.DOfbEy7gic3987u2YnV.3HzsYMTRw2Vnbm0d9OZV7oxRIDGLyoPWuq
 bh8eBW4JO495aOJdUDOHykA240F2BHnpTN7fMs5d8WVF8oetz1SP9AwHZ0Oaqrw6ldxEsYLMsIC5
 rTgTBt.XW6AH1TuzhNQ.N.QaK4aBsJgQTeHh2OlenGki1rx5o7lHBsHHYQjec50U0f0GCVJNw5N_
 KwC9NqQmVFbnWgR5wvNrBLJ9Dn9DfqG0ygycdY7IXlph_csrhAwSW88CPA2KQ0Z9BHcU2aVzXQpa
 ZodEMiLGQWfUWDYkOLCV2Fh7iJ0hIpxNCAOzX9KZbm.nKWi5LEncuAx1jMVtbMkSyYOVozma6Cw3
 6h.7UqmnD9kQZoLTThG2Br59eiaDyQPXTQvY5BlZRBXrtJ_GotWzuYiOp7SjvtV2F6A9jRda2IhW
 x1JkE7n2AqqEo8mnE9hfaz686.PskkbnVK_4DIiuMgbHh8Q0G1R.1fgwlhkwzicxChyFh6APhA7v
 hkDMBNiPSKl5u5SnrUrCYGUjKgLgCPTxpLPUkvpfU11YEhtLwDauceqASXpsF_FyEkzqLZhtCk.g
 U2jrkSz43B4x9S6.AzXGQ9oJId195N7nTp_FmLe6kZkc1C.PfgsxMyXrDxBXjX0Ndg9rOTpMYZsK
 TvLxMfChMzyr7o6zSoAZi4ylavGxrRaWz8Lo.KF8M1n6hCrAvn51JAng9DefzfNq3hIgyFV5LAyW
 eAVF0Fq8shIwp6lfBaf_QCU8q1IH0mQIWRIkjqrLWH1lPP96E3X0XJYggw9G56RiDhVsEukEctkx
 IWFGAOotXkWo1G6smNegb0DDYRoC7TPvsBpcehz3En506hKJloY67PpFivSixL1q5FWZUUw0hgMV
 AiyASE4Mos9fT
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cc1a172b-e4e9-4422-891f-00a5a4d558f7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 May 2024 19:07:10 +0000
Received: by hermes--production-gq1-59c575df44-94tst (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8763c159b28ba26d1fa19a878a48be67;
          Thu, 16 May 2024 19:07:08 +0000 (UTC)
Message-ID: <2804dd75-50fd-481c-8867-bc6cea7ab986@schaufler-ca.com>
Date: Thu, 16 May 2024 12:07:07 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce user namespace capabilities
To: Jonathan Calmels <jcalmels@3xx0.net>, brauner@kernel.org,
 ebiederm@xmission.com, Luis Chamberlain <mcgrof@kernel.org>,
 Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>,
 Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>
Cc: containers@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 keyrings@vger.kernel.org
References: <20240516092213.6799-1-jcalmels@3xx0.net>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240516092213.6799-1-jcalmels@3xx0.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22356 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/16/2024 2:22 AM, Jonathan Calmels wrote:
> It's that time of the year again where we debate security settings for user
> namespaces ;)
>
> I’ve been experimenting with different approaches to address the gripe
> around user namespaces being used as attack vectors.
> After invaluable feedback from Serge and Christian offline, this is what I
> came up with.
>
> There are obviously a lot of things we could do differently but I feel this
> is the right balance between functionality, simplicity and security. This
> also serves as a good foundation and could always be extended if the need
> arises in the future.
>
> Notes:
>
> - Adding a new capability set is far from ideal, but trying to reuse the
>   existing capability framework was deemed both impractical and
>   questionable security-wise, so here we are.

I suggest that adding a capability set for user namespaces is a bad idea:
	- It is in no way obvious what problem it solves
	- It is not obvious how it solves any problem
	- The capability mechanism has not been popular, and relying on a
	  community (e.g. container developers) to embrace it based on this
	  enhancement is a recipe for failure
	- Capabilities are already more complicated than modern developers
	  want to deal with. Adding another, special purpose set, is going
	  to make them even more difficult to use.

> - We might want to add new capabilities for some of the checks instead of
>   reusing CAP_SETPCAP every time. Serge mentioned something like
>   CAP_SYS_LIMIT?
>
> - In the last patch, we could decide to have stronger requirements and
>   perform checks inside cap_capable() in case we want to retroactively
>   prevent capabilities in old namespaces, this might be an overreach though
>   so I left it out.
>
>   I'm also not fond of the ulong logic for setting the sysctl parameter, on
>   the other hand, the usermodhelper code always uses two u32s which makes it
>   very confusing to set in userspace.
>
>
> Jonathan Calmels (3):
>   capabilities: user namespace capabilities
>   capabilities: add securebit for strict userns caps
>   capabilities: add cap userns sysctl mask
>
>  fs/proc/array.c                 |  9 ++++
>  include/linux/cred.h            |  3 ++
>  include/linux/securebits.h      |  1 +
>  include/linux/user_namespace.h  |  7 +++
>  include/uapi/linux/prctl.h      |  7 +++
>  include/uapi/linux/securebits.h | 11 ++++-
>  kernel/cred.c                   |  3 ++
>  kernel/sysctl.c                 | 10 ++++
>  kernel/umh.c                    | 16 +++++++
>  kernel/user_namespace.c         | 83 ++++++++++++++++++++++++++++++---
>  security/commoncap.c            | 59 +++++++++++++++++++++++
>  security/keys/process_keys.c    |  3 ++
>  12 files changed, 204 insertions(+), 8 deletions(-)
>

