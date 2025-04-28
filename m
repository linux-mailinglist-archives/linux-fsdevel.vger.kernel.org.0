Return-Path: <linux-fsdevel+bounces-47529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426F6A9F60F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 18:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7033BD0F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 16:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B4B26461D;
	Mon, 28 Apr 2025 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="sy8McH2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38E27A93B
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745858565; cv=none; b=jOS9TcwS1B4oB80QK6k6goCFfK2zdKIvPjmia0+VLwACaFgMOe7O1PN6STtGmIco8wSWE+RvKW/e3cZJhr+6mpz8aB7blyrLwIO3wFKwAkX8vJ52wN7rbMJpvlpHAhrMGQGfSW49V8g/Oom6VlTZSn/YxThSkXcEpcp5JScdCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745858565; c=relaxed/simple;
	bh=6xY2nc0RaB26C8Wx9+EpDD+pS50ZQFFzgqmN0vDJVM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QRBFsJclN42hLCTnyViss8fhqBO2VsMNr6/vTmT4WC9Gnlq0TkVhWSTdlDZmpNnMGzkG6YpWVBjSHYgUiMYKge0Ujv3oO6NEZUofKl0lINiHbIa4e9m0KuNBUyUDcKNGzbfZ3XCIPmWIIbv2ualYT49o23scB7KzRgRlbAfqbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=sy8McH2D; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745858557; bh=sqVT6q/gS2IO11mPSx1zGKMYT49soEThtm+blh315uA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sy8McH2Dg0hZ+KIcGa9BrMAEbFL9dd9DzyuowdMBJ42kmfJcNKcRZt20kBLnpBWxnK9oHCEjqL0jIJGw6Jtq9jNNR1eViSzRtfYWXdrphC7qiDYYCq7VhgXBFs9qjXquZSKbKMyErHKPEa2LGXGEF8YWq0m/sLcR5SdRe4bI7Z+ROhYVWxG3U0UsFAP3fTJ5iliwOxPfW8UYP3DASScj5Leb+0OPP/WjnHmcrg6DBqyAyw7C7qcZ/8Ls94zH6DAttq/h6ta/MaKruY0dIPBVund0sWCwcbBAVjeFyVvuoXFNVjwwZYmODAJu7sNtM5CymBG0SLzj+HeBFrGOshz67Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1745858557; bh=AaB+4b8R6aK9GpofH2aLyUTW2SGOUbvNypMJJvMPNSK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ksZjKFQUg7ed8L28KAyveI004hSn4tNZesU/IxyNMpw4OmJTaffC+5J1e8Te+vkl1U8j8Zd+CvS/SNU8YOPC3xWBkfh+2ZSdfebMFGrEgxP4GPvCJdpQceWg+MWRBRCYjr/pmdqW+vGTcdy306o1SRe1uT7BFpnvACK+iV/9h2Zr1xNK8Zfur85ENlx0/N9+2s/hPhOk47PVUXDiODRD9T+BmC3Echc67A9Iyw80Q8bfREy3ESHeBTm15puTg+7LqYUmgVRivo4z4aN3IlCdDppjlAA4808sgzbPtvsDvBwAB5Yci1WL/whwEQ8/AjzZljPSQkH4Kcyw+M4V07kp4w==
X-YMail-OSG: UYxsJJYVM1nve9Q1xFVLkeERBzVnVqyeHNPd50KUB7jgbH3qnYdOeQSyfMHuvbW
 qdxenoAyQY4kfeXtpWqZncnvV4pEA65QrNlhYkSBm5eHxEzqJaN_MrUWFi4HLAdU3NTv9ONO8gLT
 cLAu_MOBPS_LgVGCglF1z0Y3_8ytqhiuFo_TP8MCy0UFNM6a1IbxYWDG86Cox61EjEcmypBIvpe1
 uWuUd4TD4tK.3ul8yWMxqrd25_WVjmqzIPeI2kQxA80v8bDSvAvS9fRfgBQie1dFmB7b.lMgWFOP
 ZilW7mYqGAUAEd5sIHhRbM5sX06GQSi1mpsVcYkc8PJknupzijLUWFVZter12xVOFjb0BA55oSAH
 77H4.ISHRjuvqylanW3b5ADWiS95coLks.f8xOjtuxNenvVMAg8nqxpdtyEdsA_UdRr4ecIQECqE
 bmgJN.bhYwx3oMX6z3Jz1bkOJklFDEYmnAKw3D3str.Nht9hC_xVNgrbLJZ9.rNr.mOFSxqa6jfR
 NzTWQm.Ytw63L55tA06hyzHHdrjVR2OXcgnBOkat708FMl_IPur7I3GO7c4xZx1cLwYxLsVyQlM2
 vLwoPcqv2JNGJlx.k_S6poZ78DMhnZPo1Fi5UANnyldKm0qx2nvSkgFeSxH_dSA2oUxF38Jv05Ex
 uPnh4LNRt2ILoAAhOXhYaQBMOFAHUmDPQjBMyjx8eZA84SDu2cVeBZrZdVN01GhuztLQNAVp294G
 ULILjvCOs.54DRfxU1wtH17Sk79MRyUWr7F2m1MfzeT0xDCQ2oSEuRMV9JWeS7rkBFeYtUEFcUW.
 Ps03SFKOZwHHSe7i1CUN1AQL79JqCpL2D2vGFmZElBKd654KIWGglrDvQzz9go6t_dnC_0XNuFFz
 Wqfs7cwGDr1KAQbGHT1tMMN62xIPoyd_lYLpXpPLS6T.i1PVqtCeHq0agMU62JEcFBVVHeNq0Q5y
 mMIR8R_58uuJGV80TTO8N1InesdhPtkZG17KfzZZvINBYepDdFtaqqkiiBMdwmDvIJnUKUTq8RqS
 x80QqukyMnMk8ThsUJYJh7MuGF59h2T8N7GxnM7K9zgIZvCApcvG2ecW.Hagm535fBKgeZ0GuN6T
 wiN7fj8CSnxIEf_0tjTs2hd_CtNjs8SOo.FceppCmCHalLAesziEagVow2DCsId4mAsLZ71.1NYv
 UM92W_x6lVQ2vZW8fpmNtXDjV6DeZgshzQGWrjWc5lF9TmZ55DoTsPTGyMcqDW8Mhi8Y4z9i5EMw
 CWoPC1chtCz9ZdvpDp4qoHVc_j3gH9PNFj8xOBHxZOnW6EAV76Srgpn_yfaAL6R1qRitIkQ3zVba
 se2GMNKCv42Z4LlEa6TVZnzW7d.s1xmc4I5nEbAM6as4EXDBMCURXjgZkS8G2BpYfHRXrvrLN9An
 Plqi._0rEVZ2rLX5T9oTpcEATS9cFX7LHkTPtZQDEEDSiq5419tp0MLu0nUE0Mzc_BaWFqe7j6MV
 lJUinby15mI.gtJVB88ANtxOgY0xa4bjspGMx0ECpJNHzOzwvRhcjz6fru4tXGfll_EI0ippPIKM
 W8anfa3hFd3u5KeQF0v38m8BShW4c229uA06WOCdxy16JBMDZNRX6wC8iiwbUX6O8zmrAjhjzGCq
 8DBAN9gSguBrMmyQfB9o1y_vYNPbiRJhNk5BckAjmHuytY.ZPhAU6RKnJsxHUkntiUL3Yj_vuUv0
 ZApsmGak9pq3qlG5QUcnQvs6v0DMvfgq50PynoFhABZkdJVH0q9P8DdveQcOMI7OKHSgrLik59kD
 zaAPDwdXDMgvaHXZGiHD_O7bBbCYplhKf2VkM9JNis2_GH.mGmPc0wDqk2xNoJsy_iRm4YJQmnZ1
 Jw2c_L2ut7ybkHC9Psxxp_7UnGIAXvGz0NIIJuf8qh4T._FjQXNr69vuYWFV7T76pOB8boFnM5ja
 l7YhKZuFRVmZ5L9nsUvkc.gHXv1JPVQofrP2YOb4NQ0c2zJhGP9RqrTDcMjCUxhYdYydxislMlC9
 5h9hTDI2E0ppdVWQHyCCtUufdASICa2N11Z._oEMpPJA4daZpCA_mE.C2jtNPkKssc5BJ9BN9lrt
 nLrLJj3TroWEET.3j7WUAXcboQKa9astOlpVySbvvahbPdIInXS0_eNLewaYQdPs9jgfKzFjlmfK
 T1srwHLociI00t176XO8hSn3oi0EoSBcwNnUUgDQU6Y_pXmS753OvERIzjlzBKsc_l58.0hGdfjW
 a2f_2_EOabiLHJtwbquFCYOboie.Js47cjFkCbFEceb5TxLWGaqgqoGFms5rdJF23KIRecTSMtda
 VUg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: dc9f098f-28ea-41ed-87ec-fab9cfeed3e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 28 Apr 2025 16:42:37 +0000
Received: by hermes--production-gq1-74d64bb7d7-4ndhm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0d3d3196c6fbd5ff60aed6348ba5f11a;
          Mon, 28 Apr 2025 16:32:29 +0000 (UTC)
Message-ID: <f24142d4-e0eb-4d35-b230-80dff1e58331@schaufler-ca.com>
Date: Mon, 28 Apr 2025 09:32:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] security,fs,nfs,net: update security_inode_listsecurity()
 interface
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: paul@paul-moore.com, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, selinux@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250428155535.6577-2-stephen.smalley.work@gmail.com>
 <988adabb-4236-4401-9db1-130687b0d84f@schaufler-ca.com>
 <CAEjxPJ66vErSdqaMkdx8H2xcYXQ1hrscLpkWDSQ906q8c2VTFQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAEjxPJ66vErSdqaMkdx8H2xcYXQ1hrscLpkWDSQ906q8c2VTFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23737 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/28/2025 9:23 AM, Stephen Smalley wrote:
> On Mon, Apr 28, 2025 at 12:17 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 4/28/2025 8:55 AM, Stephen Smalley wrote:
>>> Update the security_inode_listsecurity() interface to allow
>>> use of the xattr_list_one() helper and update the hook
>>> implementations.
>>>
>>> Link: https://lore.kernel.org/selinux/20250424152822.2719-1-stephen.smalley.work@gmail.com/
>>>
>>> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>> ---
>>> This patch is relative to the one linked above, which in theory is on
>>> vfs.fixes but doesn't appear to have been pushed when I looked.
>>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>>> index bf3bbac4e02a..3c3919dcdebc 100644
>>> --- a/include/linux/lsm_hook_defs.h
>>> +++ b/include/linux/lsm_hook_defs.h
>>> @@ -174,8 +174,8 @@ LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct mnt_idmap *idmap,
>>>        struct inode *inode, const char *name, void **buffer, bool alloc)
>>>  LSM_HOOK(int, -EOPNOTSUPP, inode_setsecurity, struct inode *inode,
>>>        const char *name, const void *value, size_t size, int flags)
>>> -LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
>>> -      size_t buffer_size)
>>> +LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char **buffer,
>>> +      ssize_t *remaining_size)
>> How about "rem", "rsize" or some other name instead of the overly long
>> "remaining_size_"?
> I don't especially care either way but was just being consistent with
> the xattr_list_one() code.

Sigh. Then I'd leave it as is.


