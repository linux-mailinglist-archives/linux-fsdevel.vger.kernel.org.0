Return-Path: <linux-fsdevel+bounces-49552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2603ABE890
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 02:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF6D8A03AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 00:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45418834;
	Wed, 21 May 2025 00:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rFaV/nR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273417E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747787580; cv=none; b=Z9V4/9OSRTtAGT9ys/ra57KmLeJGWikoMxtdLYxZ77St4Izqe0Xib08mWioHI2+2Uca31kOaDQsxjCtj/Bsu6GUbcrO96rpgzH+oY0YXs+7zr4zmE83mygYtCLQvpq/wJRrBmKEMOFZXhZHzYiIdqohs1B/9muDgGG+3FcGRw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747787580; c=relaxed/simple;
	bh=T0RbOaBwczPSyR6MtoU31hIYUwk641zg+6X5zZah544=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIFVtTbt+4vaPZvQ2twkk4PYZtG0sHDUAz+dD2S27jFciPus+HW/fLa83SnAAnvOtfICrvSAfkd3ElS2DCGNagvawhfc9fbphF5GGvI7V9u6rZWe6XAieo0jKhjIhsLWUCkZF4mmLru+wnGkDUcaK/5mnvi3W/9vraQ1tjPTTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rFaV/nR/; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747787572; bh=cx3YGvuPA+vDPKU0fnjGtN1JBtOZiqAYEf/p/WyoWqc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rFaV/nR/9tR/VJ9dlBKmcXFaM+rBCHQm8As1ww2BcQa7HrmQeOJdYgOdduWEp+gVsrgyec4zlnC3yP7ArsuEsHdpJ5hbk+41W7DsQLsc8zpUEtMXjnOGqoTpxpSxY5LgtN+Xi96dhMkjU9KRtpaBHF6wHHdPaXSEdAlR2lc5kBk355N41Kk61npl1kClXco3jWV99KcO7ig8IzZChrDthICz3aH4PsKXUcZxwdKyKz1cnjUhesZ2iKHnJpa9jdg4LUZgRYJK0l3cWZzAWMPtsNTGjALUycKyfHFWao8ypxi/bqN83dk/XmgWb1PET+FBbLfjslO6mkWozQtYGhfuQQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747787572; bh=BISMLbuqcjYo16BQxoRqsu7qwAtrfLpKN+VzWKI+1Su=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gjRxp/VKr5UtMgW5h9fiVo6QXtmKZSaicIe2CzqiQlNgCnVYYED9dKFnx9oCGIhwNALMZytInyN+vBfNu3l98+1p6ZrVCeFmpZamGOp62/KeSoNmgF6PEYeF2PZG+pBlJ/qt+Y3R7BvjRbA2t22OOkouewisHO7NOhKHXO3lLg8TI0gYHxV8u/hzYI5cmT+myjD1/x6UGYXwpH64MJ9m41iBvsDe615/qHDdP1SVcEwPKNT+iCIwwY3p6YmYaZ+GgmzPnlkJW4pFq/xxcxucREpH0Y7cRFzJyxvMta2LPgP6XaqwNczpOEPvuMK5C/3vkl3CwmnTQzdWnKyXR7AuVw==
X-YMail-OSG: oJxqVeIVM1kG4i3jzx86a6TgdP.0sTad.diCSsPSpVtwno5YOcf4L8zlUdZEOX3
 8A0thCmq_VigcvCdJvgaCkckZOOYvUdKewrkAPP9aJk_p0xPyf.jgIizuH685NVoGGEsZXLdFdug
 KsfNyN6u27wSgiw3EA5NT7LiZYqzGRdq8MvhtXvWJH2GTrywTeQi5mpHSTIF9O4.lueZUO8G_yCB
 GimCgBre7Pq4hh.Tix3Db25Mz558v8DjALQKQPjYGb3y3bOObaQGrYhlQbd_YzYTOLHbffbFa1h.
 VdUS7oeb3_W4v7kW8uf3MMgikkLUPy5_N3NTcw.vXv.vcpoBno2jD6PC6pAArBx5LrniAONVF5NL
 DNZ0lbX8RFTB3abN4z.nTduuzKkvxe2l3BVnJRQNjJKTU1LFybufTbbMEDwu5baGKA958c_lo6jl
 Ki_Jyn0rD1.JYTtnoIx96NHid4bqeOGjoluxMzSGcOH4e2mF_eyHTOuHE.GVwW.MGjBGrL7Mn4OF
 EroLwnRvazI2LY23GfsrCi1PeEYCF8axRd.0_VRs9TTJpaaA4nYaxO4m9F19ZCezmQTdCrzLkKWR
 pHB5e53Uj_cUROztu93urkHbS3_YRBavUDhRgU0Ek7TPFMvHLQyXEaWP4e4Ws_RbFfREN93xNLos
 Kc9ZLb0PCg_u6eH99NHXjewZP2eUMo_86VIZpWX8NGQy7Lfk4YsbmFB5aUnIjyBq48PG_dTrKk5z
 AIcl72aBX1WgvRnc3a2sBEzK21PuEsJAw.fB27faktiFQjnVbeFuoMCHu0ILPa5_KBW1NaiTO8X8
 hkclaeaIGx.EQyLDm6mokUOUEjibE0RA2lb8hKRjkGd4mJZ1vFN5lCXmgcqv3CwxobcFqjXEQGGd
 eIFyISiS6t9k6_HDvzhqseZOZCOL_ZH78coh6bDqJRMDU1FLT1bYMsFJTSpgZZ_i72sY3Xt0wwzO
 ac9jVZzzRY_jHkMkZap.1.6sUZc_oQT7_Blgdr_XkwJF9CDdY08db7uqthjEdLm21rrPRpg.i02B
 9UCyw0rKb7uKTcpI7iay83Ra.S3FxdZxYfQ4MG.nqQXOBF5AmysxwGThRwU3Qs1.lB_EEXhVBhIf
 o0pQcQFJhk_0EeWe7n2XI9Asjm4opRYMi6kgSMOH0wyHCgHUgAd6jsdoGx2opwPzfDbNRS82kt5W
 8LLAwkv5aXfmymlYCEPSF5eIT8KjjGPuSKP8MZYrzCTyj.zICKHTcZz069JvMfHhuZfWUusHArIK
 F6faHelbx.nKw.w3hLLRGUw2bKZ_5jPcBiw4Rb8_Qp_CVrhX5GTTB0IhSrdtcvXrhXFf0QlQfZwH
 BPiiMFgERCzxMSPQcPMSN4Og7wB4eLnwwEvx2TLV9P5WFkHMbrveeHWcx1s2kEq4fmPdAnfzKFob
 UiD7eshjXza87WTGI1UQLG6JVAPIWUwx3B9iZgY2A.xc5GqLO6K4k.rA19yy5mL5v4xOq9P.C5WZ
 4DSMxHUoMsHAGwI6dozCO9.lpwHSuodsKl6Pr5r93iBJUALbm_3mJaXVD03SJ7TPS68w8gZfyFup
 pwVB2QxpPhaF6Yf1PB.ovCH9q73ez77wvnCe50bi7AQAATJNXC_KaA8WWq_4cwcfp7iCyD6RaOmz
 X5U297wVCeTgwGBnUfEktpe8TUMwVhXECIHtvrGKdEdynadWwxb3nzP2X_vYppH7m4R86zYxopFe
 cZIJ7R1cehKHgf4JFUBM5XpArdLOJ9twLQOkPDhsVlTQ0wOPVDnhh8tFpfvZ44VqL6PB_gDo4XpY
 ztEy7mqEY_apSmXbbR_7YqfponqTx11ZCR2UXG8V3UdlDp8sdyuHEtmxlp7RIsFF0eLr1EwA.sCX
 pHTuKxJrhEtg5tVLifxeNsc3KwO5m0Q8AfATYhuiN8XFAXU9umYuKmeX34YIVBcDUvmazY10a5.u
 YILlbIcdhEPqdXcmT5sf13Swx_mWqG_WyPJAUAETwQuMK3FDaYw22i11vFSdcwLRV94ShbChwy3j
 vnIFzE_eiqSUz947iwzHYTofvN.O5yQ8kTsYH0sX1O_6o26G11NgQ8QNS9Uq1qfn23DNEaJ7dtxo
 NQPhXykgxXpt41pz94MSknLke9XTiYFenqiICsMFPItuw.3g0by6b3piWRUpv44IPi0rueVKqVya
 7HhOBENFFJHsuaU0D8NRbui9XPywUHPkPofkB.UW20Df18q76w1jwNWVnrt574YMbGHpi22t01My
 ShhwmxybpA87YsB6Le3OIj8pKMxaCCxfzCCQ_W4s8TwbYjYk00qgdkk9Npz4tNAdJKHgEPsYtODB
 wjzcaWg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: fa6019c4-8c81-48f7-9087-f9292112f967
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 May 2025 00:32:52 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 22b51d61e1487a2ad2d4a72f676939f8;
          Wed, 21 May 2025 00:22:40 +0000 (UTC)
Message-ID: <f4842839-20e9-4ff3-8551-3e33d1c87e44@schaufler-ca.com>
Date: Tue, 20 May 2025 17:22:38 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] security,fs,nfs,net: update
 security_inode_listsecurity() interface
To: Paul Moore <paul@paul-moore.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 selinux@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20250428195022.24587-2-stephen.smalley.work@gmail.com>
 <CAHC9VhQfrMe7EY3_bvW6PcLdaW7tPMgv6WZuePxd1RrbhyZv-g@mail.gmail.com>
 <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQyDX+NgWipgm5DGMewfVTBe3DkLbe_AANRiuAj40bA1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23840 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/20/2025 2:31 PM, Paul Moore wrote:
> On Tue, Apr 29, 2025 at 7:34 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Mon, Apr 28, 2025 at 4:15 PM Stephen Smalley
>> <stephen.smalley.work@gmail.com> wrote:
>>> Update the security_inode_listsecurity() interface to allow
>>> use of the xattr_list_one() helper and update the hook
>>> implementations.
>>>
>>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/
>>>
>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

I haven't been able to test the change in Smack, but it appears reasonable.

>>> ---
>>> This patch is relative to the one linked above, which in theory is on
>>> vfs.fixes but doesn't appear to have been pushed when I looked.
>>>
>>>  fs/nfs/nfs4proc.c             | 10 ++++++----
>>>  fs/xattr.c                    | 19 +++++++------------
>>>  include/linux/lsm_hook_defs.h |  4 ++--
>>>  include/linux/security.h      |  5 +++--
>>>  net/socket.c                  | 17 +++++++----------
>>>  security/security.c           | 16 ++++++++--------
>>>  security/selinux/hooks.c      | 10 +++-------
>>>  security/smack/smack_lsm.c    | 13 ++++---------
>>>  8 files changed, 40 insertions(+), 54 deletions(-)
>> Thanks Stephen.  Once we get ACKs from the NFS, netdev, and Smack
>> folks I can pull this into the LSM tree.
> Gentle ping for Trond, Anna, Jakub, and Casey ... can I get some ACKs
> on this patch?  It's a little late for the upcoming merge window, but
> I'd like to merge this via the LSM tree after the merge window closes.
>
> Link to the patch if you can't find it in your inbox:
> https://lore.kernel.org/linux-security-module/20250428195022.24587-2-stephen.smalley.work@gmail.com/
>
> --
> paul-moore.com
>

