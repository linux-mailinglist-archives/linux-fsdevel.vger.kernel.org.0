Return-Path: <linux-fsdevel+bounces-8085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E6C82F40D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 19:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BBD1F24AB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBBE1CAA2;
	Tue, 16 Jan 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="IwgP87Q/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic315-26.consmr.mail.ne1.yahoo.com (sonic315-26.consmr.mail.ne1.yahoo.com [66.163.190.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811C81CD2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jan 2024 18:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429142; cv=none; b=lNW27nKER73KfYYb7I768BXt6QpDTjUnCB+dmjoVTL85IsqM74MBRPTMthceCaFMpDxzoypv1FWYZlpwFAk2foD7k8peb4QQ7flz4SOIRRWJ8skHd67/87pl2kYatBafk9D9WXKPgQrZ/SWJQfKOTcLfkErS0b9z9vPttAD54J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429142; c=relaxed/simple;
	bh=F7q4ZP/MRKyfHpb0vi0aGTL0X6ai4KkqASOWeD+bmRI=;
	h=DKIM-Signature:X-SONIC-DKIM-SIGN:X-YMail-OSG:X-Sonic-MF:
	 X-Sonic-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Mailer; b=SchDgEccoMaAjkMcdYgf1I/vt2Q237yDtbaSCaqGH41Ybr9tLjxFcc+RrhPEhs3UcxmndFulAQ/NVXRi+OzsVTYHKrbv4cj+/pAVO1Wo5zm59ZsVgjuueH84bbNcA6KNEkQMZXctsBL7fNq/7kvD8nbAy90cbvRolCCAP7R5lrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=IwgP87Q/; arc=none smtp.client-ip=66.163.190.152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705429140; bh=pLDNYMdTb60w9Q1uXsgtDogsruwrkcyqNOIoJ29AjWg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IwgP87Q/BWlbJU8d3jdNYVwmzyInSBB47uhwpzDUBzY4hFNsZrXLYbczPyZc05awjmJDdZG5I5FnmHuV2i3ohTYIRVFAaIajQ+bP8+9xgamc4Ls3WbaUKJdWx8yMp6ILQE9dbLDzmkYyhYIzByBWCv+tuz9yUNRc5MKwVt/O9hGnKgbSsXK/RdG+NQwTWa3N9FYTJmcNCJr7HkQy5jmYoldpDSgP1LCA63aw6RX2eR0I3CVxkRnu4pYUQIP0olg/7Lbb2hMgBKzpMzbzlfXgPjsdscNr+ydVYEviDzLmsAdbUi4HIogkCO75ev5RPVK7PGJ0IpqNUl0mq+6lE6iiaQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1705429140; bh=3xrX83+s0Yjd98YZ7p5dUIjo+/C3bCwmpou0HSoTRV0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SbobfcnipFgMSL3OtEUbE0OJJeGDfDnsqUXk4iO31amgN8Riyp8cUlhYhT3F/i5qOgob7MNQRNMOraFyZvg15tRuhW6fUVWUHYDzGLcblrMJ8hlJ56t3qgZBdwMIiRNAeBFRMF89XiSHQm7Uo1yjHGM8z9G9xQ+NVZvbIPW3g9UvRRQ6gYEpR3kt+sainYjnGf0MrxocxNle1fW2gVHe9fF+WqFT3cy453DvdgQI8AwXHfLyosNqE665UbmbFoRLNQb4p0K4MFmVo0/6IWpVQZaAx5Ee56e0onmo0c2NenegkEpYarZq/2Tn12nJK83DRYIM/thRovLW1PdEGNCojQ==
X-YMail-OSG: lFNaHA8VM1kitjUzwrZIhug6F0BoBTCyXQnDhwkNA10WNSzv58u1lhDnUUItQkw
 .r5L1cGp_u2XFSjICkI8BMke85FpaUYMLXzietraT_ru5rXskSpICECNr71TLYxmgQKLfmYC425m
 rdgljH5wvTxERoUSRpopCPtwf59dQceL_H7_SUXfDMV2ciEKTKI.mfsaCj2RJpb1NF8_FGb3wj5I
 36njemwBk4E85P9IkWJ7c4masL30AH08qVl8TuqtQh9qlLHqsDT1ApHlIfOlnxOEcKBOn4T7FBOo
 WT7nAOg1MpYBSx9_VQh4w99IQzX39DSu2xq8_GIkFkDnYUZ7mZgLvyLgboqubnjvtJ9SxkiofZV1
 .RD9RaPAJC75fLzMoICT4jiueytzpqUh819osAGTar.KOehBQTBcTiLMz48pTsrD0vCZj1E0SvvQ
 xch_5E38N3qtlWdV2U2drXD7Io.XloN5TdBqd6kALWZJ.87vIBQ3wEieXEPP.20fS68yKW37dSnr
 DsG30YXC2wWfpR34Eqe1SNjqlVXwPFueMhMeJfc0IHg00Gm7x9o1E3U3WK83.QhfE_d3CY5LhniJ
 1v74M2m1LSbz8H4pniJXpDQ6GMhf4lhEo5Uf7cm_BQkSDqbw8NSjfKZR_VL_Gqif_R5p6cxg_w4h
 ue9eKJn6vRKN6nlk9.DdgfAUbAewfJcZI8I_Y93GeM3daqnJl20gv93X4BsTf6NJoj.DQeCR4XYH
 r9VrUx5VXa4HOROB_qIYreECt8UobbH1Dahcq8lTPHsHROyLvoqAbEUwyOYrMEu9Im_yMuF4_597
 VBpohLLKQbHIZGAXQi480oRKQxfsulHytgxDnX2VoQtiyzKj.qd9.tR0M.m.fLrdzpr9cIk3_FYk
 ._ucrAplYgtgOXrT6fG0n61JFr_hz2rc0mBXk5M8LyxBnnATdkuODLeh8tU_vKDXkZw5X9oisrHi
 UzPsM1u3yVaQvM9IfzAoayfPuxKGXaIk6p7SHT2UZm_Q0bBv6YvdvJN5Gbb9H8._LoXD7a5WJyxa
 4t0BK6ajw7_dpO3nDXtJEmVs6csN4Q92GlrT47GHjT663rnh85V.LnzJlz.WjJjttOr8yy.2zocO
 MfUVibhN57PjU7gnbwVozTATgiRnkNjzbIaDdAPjzrFJCswNjc0lePB2aA7zF3ko_UW1j4PY8Upv
 1fSScLr7jNHOU2oYip0QgYmqlRQuoFcIbvA3XqfsLojhkQQmO_yw6njjlsFxoWbSSd9d0cZv4OYH
 2zeS46etOQuyHHoIr8ZPUpe_pQxmtVHaO_wqchVxFURf9tyXENLX.H1.YV8d_NEOryM1h9QUz76o
 foAUBuSCDZSa18_RBt2CcVMezlEFQGt1jtJ8lzIR8hbLnLziUWOVvg6X5qqxPd0aCX7hijaCy.Fi
 wGseHt4wrsCokKk18dIB5.DT1TxWAVu2FeU4f1lemE0HdIE4F7ygi1OZ1kQHSc.QcpEogquuFpOT
 12NeoC9VXQpfPM8osCv4wI4jO42dfmoZ2qrmwf8Vu8ikXupO7w3lJ5xbQbl_sF4NL.lSgJrpUXzn
 QUhk7zcNpH_pjS8_7NKo1UCtkz8J.ExH3VBXygaqEXWQe_nye4i9hFk3lbN5OVMTd498dDqgmDu0
 p_LzCv9NnSLqo1G8rnE90RS.Raa4hJXZ6LW_BCw4dmfO44mpIzaXb63mgjN7wsLdu4JqG3kw.HhN
 Cmjv4udggO5pS6qAFyoHuWT.RjC5mRFAnUh.FFt9357ousobQRZoDkIrDBAwj9xiITaMmqSe.XDt
 Ky4hO8tOg9fi13z0YjQ0sRNY5AP4Dt4QejFnsA7NpbL5ky_dA8q1ULBDDDX9YhbM6a3aucYdjz7c
 PwknJhMX0jSAOhFAubjx94hjcI_roYERH3CGlQ6Z4FMKRN6m9gzRMcEVKDXWW9tpoBl_V6jmfkOO
 bKAj4dI5qpA1RvCU8wQk7pvuOh59DmqqJ6egBuS9myARbUYzPigyZmQsuekHIECHhuUf4IYerih4
 iUxrJBfkdPIFyGdjMQzm2gm.G6qxnU86Rsheg.LjBaU.qaZvf__DySTpygQEt1PB6HSdGA8Q266u
 PHSYDa_.QIpc_mBxkEYPT6jS0RgW16NRZyx97vXJe9KIkeaE9b8ovmSasHKraK1dFCzgVIJYRgt7
 o.Y0KIEFgo3R.6MhyX4dbfuaUAApn3D3.9lkPBhaG6iw5ssLZa6eeJSMGk0QdmY_e.pg6DXMoA3Q
 q_glrEvf72vMLVsIC_8fc6zQ65NYueoL3luZccjyNc4nxvZLmZRDwV7k8RSj7
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9c2d3862-3f51-4506-a7e1-94812c7b8302
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jan 2024 18:19:00 +0000
Received: by hermes--production-gq1-78d49cd6df-szbbq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1427ccedf0a387ddf6c3f26cd39e2f5e;
          Tue, 16 Jan 2024 18:18:56 +0000 (UTC)
Message-ID: <5060b314-dc45-48c4-8c21-157219e4b6ee@schaufler-ca.com>
Date: Tue, 16 Jan 2024 10:18:52 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
Content-Language: en-US
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, brauner@kernel.org,
 chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
 Dai.Ngo@oracle.com, tom@talpey.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
 stephen.smalley.work@gmail.com, eparis@parisplace.org, shuah@kernel.org,
 mic@digikod.net, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 keyrings@vger.kernel.org, selinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
 <20240115191508.GG1674809@ZenIV>
 <3b440f064a1ae04d69f7e85f4077f8406c0eac67.camel@huaweicloud.com>
 <00b7ff22-f213-471a-a604-658a9af80d59@schaufler-ca.com>
 <20240116173317.GL1674809@ZenIV>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20240116173317.GL1674809@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22010 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 1/16/2024 9:33 AM, Al Viro wrote:
> On Tue, Jan 16, 2024 at 08:51:11AM -0800, Casey Schaufler wrote:
>> On 1/16/2024 12:47 AM, Roberto Sassu wrote:
>>> On Mon, 2024-01-15 at 19:15 +0000, Al Viro wrote:
>>>> On Mon, Jan 15, 2024 at 07:17:57PM +0100, Roberto Sassu wrote:
>>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>>
>>>>> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
>>>>> the file_release hook.
>>>>>
>>>>> IMA calculates at file close the new digest of the file content and writes
>>>>> it to security.ima, so that appraisal at next file access succeeds.
>>>>>
>>>>> An LSM could implement an exclusive access scheme for files, only allowing
>>>>> access to files that have no references.
>>>> Elaborate that last part, please.
>>> Apologies, I didn't understand that either. Casey?
>> Just a hypothetical notion that if an LSM wanted to implement an
>> exclusive access scheme it might find the proposed hook helpful.
>> I don't have any plan to create such a scheme, nor do I think that
>> a file_release hook would be the only thing you'd need.
> Exclusive access to what?  "No more than one opened file with this
> inode at a time"?  It won't serialize IO operations, obviously...
> Details, please.

Once a file is opened it can't be opened again until it is closed.
That's the simple description, which ignores all sorts of cases.
I wouldn't want my system to behave that way, but I have heard
arguments that multiple concurrent opens can be a security issue.
In the context of my review of the code in question I included
the comment solely for the purpose of acknowledging the potential
for additional uses of the proposed hook. It's entirely possible
someone (not me!) would use the hook in this or some other "clever"
way.


