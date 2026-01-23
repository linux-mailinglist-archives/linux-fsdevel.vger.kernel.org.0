Return-Path: <linux-fsdevel+bounces-75200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGBDLGLscmn7rAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 04:34:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C2670236
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 04:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96CED3004D01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 03:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E733B6D8;
	Fri, 23 Jan 2026 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aIBD1Eux"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic311-31.consmr.mail.ne1.yahoo.com (sonic311-31.consmr.mail.ne1.yahoo.com [66.163.188.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039432D0CE
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139284; cv=none; b=jTZ39ICM+7cz9gZdppPfN8v0qOjH0Y46QEl8qb7qZrgmosO4NV8xvwCgj8tFacfvp2JWRjK44wherfizkX7EtcT0mniU8eWir+ETmeFRr7CKIRwq3tjM5hFKK5OTUWVOk0HqLQBKO+dcn8sHn9rqpEjbT+JzPDLJ4Bm2L7yKkRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139284; c=relaxed/simple;
	bh=vqEXaVCi3RbcN0ysaBISMtJxr8iChdFz1yI6n7D3fU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1nVTM0SzZmPnz8CHc6dpig7Vzbuk8iW/olXlf4GhG2X+EUsIoXdaGdaQWE3DWIrMtJ/sUWpGmmCHT47LyPOJVdVzed5XvnWBH8MBzihZVHscfH8FsvLgENc9Q0gbe2yrWjOaEBhwAX0VKS2O9PF6+62atIH71nG5pMNtiawC8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=aIBD1Eux; arc=none smtp.client-ip=66.163.188.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769139270; bh=vqEXaVCi3RbcN0ysaBISMtJxr8iChdFz1yI6n7D3fU8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=aIBD1EuxXnCjTQoszFcucafd9a/xRt4IYEGkPjcqMIh+AZRwH85XtRNXOCaEOuXTUIhi6FQ6k9RWxopeUvrgMd6309vKYsuz9r7qZcr13n8B/BacHCBPDPrG18E1ktH/efM0gbSjnS6JevVQOd4dmozgnCa1Q+gV7XbIe5NluGQzVpZB168AfaEtzz91CYIgsmd+JwVeGh9gipPzZMOJHuk57IiZtKYgXZpfjKpFxXlEPcBzLxnC35Q916I1fsr/rdNHLFrZtL1QLihp5ikQJelhanHaMXIa+4GeOSF25HGRTTboiCO7U0x0hNv1NZVQTtRt0Wydx2HMqthCI/h+Hw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1769139270; bh=Xg/hXzqFVbnUMtC/B7XO/r08sWiv4BDUbi2R4wshJby=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=VJrIqKWshQKtBVtkxnMApeUBREVkbm9bKmCmpx3JHV1YEEj7SgARMlOVrZqhXY8Dh6gCSor4TOo9avz4jto/4VgAdjw6dtE5NCU4tPp7sJ9a2/mSP/ddAe0DjWRgkH3cg5EzafoMk9PqoSdtkoYsV76PoV/h+AIglv+vXdpTCiLPSuZm8QrSh1LnoPqVKR/+FBD+EJmkc/Aq/DD2TmcxY+vi7SGhncvseAE8Vc0hR0hkmouvKoi3IIgIbV2iq3w3JxwZur82U80PWP1LIqCljjBUK2jl8d8EQniZb82QCMAT6UCp9uWP8SPlOnhJJfsAJCmDuUyhJrDMrFMTdw94Tg==
X-YMail-OSG: 4pxd8c4VM1lTHo66rI3FqLspIrBDlZgKkVBAigZ9MY3GJWZNlooC.KIA6_sxNu.
 0nK_D_40PRrV9uK69zGdSTIjeXKQYM_b6xpeSQ7SMX5ZCVFOtOwFxujWOAB4QIoy.G10sPaSx9f8
 QwqzVChv4HOd2JIc5Um4dhC5DodgYJpSQ21aen.N7ekJppkJJIxdsEcI1FNvU30iIwL3rlKyeCR5
 JCHbTpFW5drebtTNZKf_ub6q.Q5ebOkExLuik3.RljZOiM_j_P1y8eIbvfzOTfHL7vVBtlyxhrG1
 6d4ZbojwOrvV06Xwuokp70uEgsALDANqSAJuotuW1Hhi6KU2iKlSH2vpXP_PW.2bt8c2guA.UYeo
 hSPGMuWzDbyCuf1jhEr5040gl8bL33r80UbSBT85fVzVgGgcVEQucHKHuiNPy2mBfhKFHDxshr4r
 krsDIMaGDyBaCXNKRoUlOyyiXg7f66ABaFS94Jm3BhYh_5MmZTYIQYuIM3a_GsEAUnevJvxtKmso
 ypfJWz4Z8XzkbnS4dHMuOGguPduUWr2K2fwD.mTd.S7RVYHsT5jInodGsoPPhSijXdPX7bHcCtML
 lubjedI2PeZOvpWZ5iyF7sf2wKmZLh9u2NUKFM69sWrEBLIqEQUQ78nOTIwp.5bf2TqtHbPBJhhE
 nPqCNrgG3WmR9eWPGgm3To5bF4VTyi0Al8.KHVg4eeUQtizSzpT6nG9XFLk8xWlIeB9vm1Fke2Ym
 xYnwISQFMi8qqZf94hkhVINKY.2bErH5lo431ZtAmMcBXQ.3hElDh8TW4ya_s_2YkqdZibA3zTWg
 gMICJdVtBSwNAvFiSxTA4LSRsv0eaeNT1MiBuhtjjbNPkNteenIH09QKsMYPYnFFsGWoKRfGXwHp
 VBgz6jFzh83djgiLGnheRBIelA1c.9lHZevo.wJ6I6gUQO9qWXcaLwmI2_AskF2EXNvw6lBRzU6u
 WFzCGIgWsyNDWgMlEhAQYCq4sOsyxijS..2eD4AVBWZz4PN6r1bGMVKbmRQfsx1yXjRmMSZCFY.C
 Q2VPItVQXYOY5TOfaGM1obA3bO6xvR5_zB60yidgw9NHHLIXshcWpjTsI2Qmx0F02qEi.2ngi5on
 FGQNF6aJdRwl61wvmUkGB6LsC3mYDHHfI5pTsZvVx8VjZlQg8C_MCqEMbJpYQrn1XoEpHmeHhwnc
 8EjvE45Bc4t1R01IuZ3mJbalTd.0ltMENBm7q_xuKdaHW4.kIop5H4PWjBTBZQx80fYRUd.uePa.
 X.nauHBi4LrjX41H_rjYDb5JOjNL4vOXshMHVMTdnxyfRM_O8t5meREhhURMFBaqvkRKOVjeq45v
 M.MlVT9oOBgfr_1MzdB7vNK4fBixlCuvNJKM2lwN0I2kyu.leWETEOPdS4xhMtn5rMyUPTp801od
 RvVVZcVsZHEix.a2OQN1DGbJ7sXFYEBuEqhI4MOlMDEi8WNGjCowt.H8v3Q9eY.h9nKAtNDDm6aH
 kCbAXuBBwG90aLd8yxgRkGBCnp65zD62rAdfp8rtj3hZZTDGYRjQwIyoZBnxXZohuGCiY0PqA4E8
 Y73oR1DxQc45wwMei4qFg1d5j6WgIIcqMfUglHh25Di0LB8kyiJVSd946lv1bvbvioBAnHRFMZUs
 FAvGSYyqQFq.SjwRsUPKa8qJ95lBnHK3vwZ4VI4GzcXYZId6Jx0Da6KyOg9ikvB8N0gWIFe6zxwz
 hAhYJv7tp0u4mALc79xSyz4E5akRlCNuofuuSXB2UfD_2ezstid5ug7GSJMSiRkhzDmHaRM86sur
 xtoYVA1MrT8rZClnA1UBhxYLqxSGPPkxkUsEfxoXt0Fp_am1ausnQ_.v_VO69WVz_D4p40OOx2ew
 wALJQIkrAC87gs6LSMKOBSSPbsYgWGHvlWhO__rqAuPG_2i4238hoAi3lOZKhEmx2T.APBTlScqc
 VN_6l.FXor7qiE1UeYClWBzAkmlrY9BLzUHKOlx.teJhuXnf33DcC5ByyTotawS6qamsJTWqFATW
 0HhC84DJfP4xpznmaXqFUyBsfMOQ6H9Y2hHiuCrJxNNqInBy51sxqspbiyLVSY3tQhs7iEQmmm3U
 Ig2ANeUX3apAGtH2D5hJt8kpju4Wzc3nGM8hxa7S3l6dUN_KLHMGyNMw74pe3XhBmi3.voNPhwHj
 1popd9NsF_Ca3gxnSJkFpjgk9jwu4UPtsSnriLNHKRvmgE7QyE3f8g.0i9IOLkUtaK_OA2pR1Gtv
 usjOvO1rDOrOgLcd3gvzUAzKYaDgrLpOxrZzpjBKfX2AWzRA0APvkHT7nS890k6i6K967a9iikk6
 FeRMZad1svtw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f6bd16f5-4ce5-45f8-bc24-63b96081a564
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 23 Jan 2026 03:34:30 +0000
Received: by hermes--production-gq1-86969b76cd-qmsdz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 26a1c629605e02226d9b5d383e0f6a08;
          Fri, 23 Jan 2026 02:29:04 +0000 (UTC)
Message-ID: <633aa038-4356-4db3-b61f-191cf56c73b4@schaufler-ca.com>
Date: Thu, 22 Jan 2026 18:29:05 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, bpf <bpf@vger.kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 lsf-pc@lists.linux-foundation.org,
 linux-security-module <linux-security-module@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com>
 <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
 <94bf50cb-cea7-48c1-9f88-073c969eb211@schaufler-ca.com>
 <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAPhsuW7xi+PP9OnkpBoh96aQyf3C82S1cZY4NJro-FKp0i719Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24987 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yahoo.com:+];
	TAGGED_FROM(0.00)[bounces-75200-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[schaufler-ca.com:mid,schaufler-ca.com:email,paul-moore.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37C2670236
X-Rspamd-Action: no action

On 1/22/2026 3:01 PM, Song Liu wrote:
> Hi Casey,
>
> Thanks for your comments!
>
> On Thu, Jan 22, 2026 at 9:16 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 1/21/2026 7:00 PM, Song Liu wrote:
>>> Hi Paul,
>>>
>>> On Wed, Jan 21, 2026 at 4:14 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Jan 21, 2026 at 4:18 PM Song Liu <song@kernel.org> wrote:
>>>>> Current LSM hooks do not have good coverage for VFS mount operations.
>>>>> Specifically, there are the following issues (and maybe more..):
>>>> I don't recall LSM folks normally being invited to LSFMMBPF so it
>>>> seems like this would be a poor forum to discuss LSM hooks.
>>> Agreed this might not be the best forum to discuss LSM hooks.
>>> However, I am not aware of a better forum for in person discussions.
>>>
>>> AFAICT, in-tree LSMs have straightforward logics around mount
>>> monitoring. As long as we get these logic translated properly, I
>>> don't expect much controversy with in-tree LSMs.
>> The existing mount hooks can't handle multiple LSMs that provide
>> mount options. Fixing this has proven non-trivial.
> Could you please share more information about this issue?

LSMs assume that any mount options passed to them are options
they provide. If an option isn't recognized, it's an error. If
two LSMs provide mount options the first will report an error for
a mount option recognized by the second. Since hook processing
uses a "bail on fail" model, the second LSM will never be called
to process its options and the mount operation will fail.

The option processing needs to change to allow option processing
in an LSM to differentiate between a failure in processing its
options from finding an unrecognized option. The infrastructure
needs to be changed to allow for multiple LSMs to look at the
options and only fail if none of them handle the options.

>
>> Changes to LSM
>> hooks have to be discussed on the LSM email list, regardless of how
>> little impact it seems they might have.
> I don't think we're gonna ship anything without thorough discussions in
> the mailing list.
>
> Thanks,
> Song

