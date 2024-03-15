Return-Path: <linux-fsdevel+bounces-14527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1287D3CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAC41C2142E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EBC1EB48;
	Fri, 15 Mar 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="dLzjU0lc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722A1DA5E
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710528081; cv=none; b=ff1PqjrTCdYEnng6valweS2nenIcUueXDu0jCNYc6w7zaKbm0E6B1JbutYtzZeUpF0iSmYuH9XOmdE1BJkmdtCS5mbX/FK+ux4pPEfg0RyHTL0Xq50s8P7fRt++nnH+CrCpIK+5FBPQi3I2a9g5kLRNRxmmlph6PAEiwcTiM5hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710528081; c=relaxed/simple;
	bh=3JUDidsPI2I07O88Io1W5tofObKDs7i4RRBrmaVp6fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J68BTVfI2toXLJ81OplVuol+Cs8AMe32v/koaln2Il47RHEY0mzP5vHAsH9bAmI6JSa/z9H31WHg/rw+16D39Z4VO9nsgRUrf+Dk/WST2OyO58mAr4owxwMZKh0Znvs/xcclfJS+kv+RPVF99l0FrOcxe/XFqjJSOLnY5nnCx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=dLzjU0lc; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710528073; bh=5dg50whhCpNYd8powoftqWuabRQ7BLUbj9Wpvo0+anU=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=dLzjU0lcnFGqim8QnU29nIrset/0LhACQlZoJybgp47FvnCpD5PSyiceU4onihGVQtm0q3IvkReDhcm19dbW8l7Jiv42MpbI9KORsccuwxKFJqk434ob+IUt5LRarw+r8MMs/HtXkx62CREvW/XinJvPNNHiYdAjEprLgc0dtcsNz9Z3JiHNBG1cNAO6exSHr0S7E3SkYDXbCSgtmjXFhPPHudHt0nAP+2Nqj3Ov5q3GHrviPwqCrLd4BPnUVXo9jSTSDOetWFd4f0U8LHWZcj92B7N4akEov8Brxq6wpgz7JYFlcfBKG8TWJfVhqenR1MRVsPE0IFSyxT75vHPm0Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710528073; bh=/hv5mS/xEK9QM+5mVeuFHn3sgoRzf9EmkQBbXvr4j2I=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=GQwUnDXAnJeIDNz3A2XShRu6N8Ww926pfFCWbwdqpJj/CdEO1EVDCE1QTk0a+3ViGeBTsa1fBZNgMkLecaGS33NPvKt+dkxXsqgdy8MNhO/W3j6XfI4Hm6gpI/+1yiEhERWDbR5KWu+R8E549dPEfusrZpqgv5zI6n2cjkMQLw4fDoM3eOCe0ywTaPEezN59uPi2CUfOTbl9DShDCVLbMwOpr3KeD2qIFU/zvQmWbP1d2615k1/lX04Dp7RJWj6iLQdJuj9APqDGinK53VVty5YPyOTQOF6ncPwFHSqcIjUb6zMWFjbWlVUj4yh1rBEOhgIVAfGGlGJaqR5PdVkYJQ==
X-YMail-OSG: y7eE3tIVM1nvO0dOXLvwbUbQBqJJm0nkAmnbMwC62s99HZGhGEAk_i.LpGfSxKj
 JxWNR7_Gx4PtbLZeSYx4Dm4HmJ4hJarEOpYkp_Hk5RZuQN07Qy2yzUCOpeNQt1FZS8eJxXddaeVw
 0jLzJ7NP7zFOKYBOQ3TPd6HQaX7aRo1EqjRFJvvO5hiXIoJn3ZtZfCcl.L_lxkI8ELetA_9qaAJb
 FC5wnQf7NUox6ppQ_OCVFKGEVh9w6WkVNhrCizXDS.iu3KGVxcCWZCqCy8q8ApWZ7IXu9vOTF32d
 lUGlR9W_ibFbOMo7D782cnnk2TKJh_.TLvH25ONRNeYnHYwiKwAJHsrF.NoDa3IY1X7jmCOFL1sC
 KGNSXrNaDsSkR3DBjN3Ft5TMcFt6g2BLGIytIEc2ohTDV9PMuzVl8RmqJ16RnVSxsZAVvPIO...W
 2jDSD9Z4UC5XKvpAJrZFVBvdinyzpOZjOpedhdItIQOSHhlp.gp.szvb9IgUkNIaeNkCTP9tJfqk
 WH9W2QIB_mMIZ0z7v.GHOqNYwNauV7RtLHsNkZEE_wgwOBZWrK_6UadWFh1HC8wEXs9HlHQxnxa2
 IwLlePJd0UQCc1kV3BppzN1Y0dXanJFLXjZSeWOmbxXcJTU83EuVVGB55HDIVmaEisOZ5Jqr6Csp
 ZOqMuv_iZGzCaabUvldGzeI6U0M0zUqIule4OPKtToKh_297tBam3EBWWc.q3AbseICCJ0iQQMVq
 ov7Rb7JUl91LcL9gqK5ib1_eu4egKYlyP6cNfeikkykpQZ2fTQnKLp5sdqJxcQ.8wd4._wVbjOYc
 mFEI8wQnHpSWc1TkJZX_Dr2b7T0CGVCLkd8q0qFX5zrgkuQGFjjPuRc05BQE8yr3mcrhGJclmeX9
 TvVfWWxbySv.cr7iXr931.kid9AunOt6ussj15zdXPeEiR3gZat_YT0RcnWhtVy7DRNPZmYlOU4y
 EEiBx8CqtlB2VCP9gTKDm9cnEZLCI1oXlOeLLZ9f6TqR.zwaquRb9Jceirl3M8lgZbLed1PHXxay
 cQKCK7Zm9TkqP0_cAODGu6mY4xSFurkNXy0N9waI8hHIdpqNQQ3ZHyBTJOO.ACBvD1ziZ9Ya6uH7
 msrFgkK4pSq3SsDXhAhBAYBPtJcHBnoyiR4_MAJmLnwp7.EEmTJbmN.xweNRMLmAiKak4kh_S.Ze
 FN9VNVKQUFXfUjuvOTiqD5yc99njWGKyk4ZPVrTRuTQ3bRdsfZJwncfC50Jjcp9pg9EYi1EQURC_
 f8rx9.MLZ_VeXapPwu__iaNRgYUlrGRD1f7thwRPHSwBhVp8oCDctOU3Cxg4X9dFFQRdZUuQhIjK
 o5zdln5unjl2Q5nUtAyDVX15G_S424kRtOMZzmNbK.2t4LXbUHWzIDPeMSqzdC.eJo7m.hfMdRkN
 H63_dpPO9h6LeIyhFTrEkvtuQIMGG9KEzHv0Ny6XSOMgD95QkcDeU66US__SVcQy287LJqRnquxw
 NI6HxSCPbTdT7Y7b3kgWzDntd2c9CLjRW40gNwN6NoInDALSzevqwS9tbBOtwGVLYTNWFp47.zu9
 I0Nnm7d.EZuqW0S1rs_ifKDYPDE28OyNw.nvU2kcXzhjNy4WhyJ0eREGQvom04cQK488_G1tEf.l
 lLzJ0QF3HLbxOUh1uDypt8nNB4OH425Fk3OrGIZKKxtC7xF8BjLVWOumDFBy_Ur0xsTGnMTwJEm5
 mL1dacq4E9ymjHt1oxUgYE76Ydy4m4TFKTju2gAucgrwz5LDz7qIsKvkog4Y3FwxMRRHoSbFHd7K
 Fu7Oyd3uXZilkRESXbYou7duKonFWgl25_WqA.roBRdqR3W3zuLC2RoCDkGEOnF_QR0fuHh.2VTc
 n3QUB8NBksssZUiMrOADkuSwneGLdvk.zs2tD35petOf3Z9jPZ6izhnGS5KoRWO7HdVW.BGgf37y
 q1rtZ7pnlJSvu0eGJ817ZgfHySDqN1MQIBWrDDcUhMhMcgyTN2Raj6.in.LMV1T0U3s9t3pL5zfX
 K4.ABBzYB49p3R.QBkxtMKWjtNTNCjlBY7xwZs_dswmHt4G.cEb5_zouovzSkN7oQ983WXmR2ZNJ
 XgmpWu7J8TRr3Ay5uq_HmumWfJova_6NovRg.JoN9AQV0tdRmJgmUcCagd2Up7meV9Lxvy7N19Bq
 PnWGtPyXmnLc79ZYAgwQhsNU9PLnuFZsiUtiXEccg4gAJf62vlKPorZDZSo2PmFNrZzcplhUbAmv
 W9FC3q.X9WkDahSiBxSgqnouY0i0i_Fry
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 6fbaec12-0bce-4c2c-abeb-e4ce840aa43c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 15 Mar 2024 18:41:13 +0000
Received: by hermes--production-gq1-5c57879fdf-hjdnf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 58d9bbffc15b6d7ac17b262fc3b9fc21;
          Fri, 15 Mar 2024 18:41:08 +0000 (UTC)
Message-ID: <8a2dc0a2-12c0-4389-a36d-8e8db0653fae@schaufler-ca.com>
Date: Fri, 15 Mar 2024 11:41:06 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
Content-Language: en-US
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Khadija Kamran <kamrankhadijadj@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Ondrej Mosnacek <omosnace@redhat.com>,
 Roberto Sassu <roberto.sassu@huawei.com>, Alfred Piccioni
 <alpic@google.com>, John Johansen <john.johansen@canonical.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20240315181032.645161-1-cgzones@googlemail.com>
 <20240315181032.645161-2-cgzones@googlemail.com>
 <f6d1b9fc-dfb1-4fd8-bfa0-bd1349c4a1c1@schaufler-ca.com>
 <CAJ2a_DfGHBuVBLTWniNektRsY_6P=x37XT-31+P6mV9dgJvt0Q@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAJ2a_DfGHBuVBLTWniNektRsY_6P=x37XT-31+P6mV9dgJvt0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/15/2024 11:30 AM, Christian Göttsche wrote:
> On Fri, 15 Mar 2024 at 19:22, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 3/15/2024 11:08 AM, Christian Göttsche wrote:
>>> Add a new hook guarding instantiations of programs with executable
>>> stack.  They are being warned about since commit 47a2ebb7f505 ("execve:
>>> warn if process starts with executable stack").  Lets give LSMs the
>>> ability to control their presence on a per application basis.
>> This seems like a hideously expensive way to implement a flag
>> disallowing execution of programs with executable stacks. What's
>> wrong with adding a flag VM_NO_EXECUTABLE_STACK?
> That would be global and not on a per application basis.
> One might want to exempt known legacy programs.

OK, I can see that.

> Also is performance a concern for this today's rare occurrence?

Performance is *always* a concern. You're adding a new hook list
for a "rare" case. You're extended SELinux policy to include the
case. This really should be a hardening feature, not an SELinux policy
feature. The hook makes no sense for an LSM like Smack, which only
implements subject+object controls. You could implement a stand alone
LSM that implements only this hook, but again, it's not really access
control, it's hardening.


