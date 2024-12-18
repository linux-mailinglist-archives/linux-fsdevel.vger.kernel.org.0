Return-Path: <linux-fsdevel+bounces-37741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960B9F6BC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B959169692
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2B21F5426;
	Wed, 18 Dec 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="d36KUMYQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79121DED77
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541384; cv=none; b=UngnSenoipKLdrQ7BPwufNt9G7cLvtaGMZA5mnrc687gQQpq/9TlH6Pr1Z26VE/MpD4CTSbFrioYVtFgnhh+Rk5JmVYCdyT6rjjuPFLsq0rIQWqAiYLLEcVacjE5MOzKy/sEHULW66KEjwO/W0V1ET2XjSTkidFftnpiTKGg/m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541384; c=relaxed/simple;
	bh=P49RzAa9SdEPdNelbe0LpGG/WOml4l7jM/0SZCDOf3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VO0lQhZpiABLH3CX+7AisRvFBGUmolhxxAST+9SVIXlYRv4TZDojSbbre6/RO0XCsDi8yN2bysiVAnY62UfuZXPumElEJ3Az6wtNiqn+fSMzh8xuDKqDTOREHNkKK5+t5WpZSdJKbz26v34k1ATdD1NUaI7PmbBI9IiN5cZ4uTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=d36KUMYQ; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734541381; bh=U2Be5nyqR9PTDwMjbIWe2Cyum/Tkak+nQevNA+8z8kA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=d36KUMYQBmbO2XobQ5P4oJ8TqaD0g91FPdoy9F+Vf7zIQcIQQwVt7liUTCer4QW/rL30bXyqZN0ovBaZ7UrVkgc7/FHBQjTIRn5EUUIb0OuKu7CbO868jtNxBTaWTsnt8GxvdGhskpkQ5Y0endD5NJUdpl8J1IDoU1nHjdQ+g9Aj+FD71JhHH6T+UdFxpCg6NsJvSbLjII3pJkPNE25vgfNoDYrWD+EX3YOyh87G11Rx8stodFp7+f4lrwYVQN6dIdJlLk8CKS0Z6k62R2ThenbKAZi7SAXtiLjfRKKoK1m3lJWtPa/54I/4xWaEyZZ/aOo5iav52YzSEyZNdWUgLA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1734541381; bh=uof6lVjQypTum2OJF4xBQNI+h/bWVhCXSvQ4fKch/k5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=eUcPPk1Fy/68efZGtGQO/xMJISHQjFDrs0pqrfjRv9ctxevYVkUR5hmQNyMUPx328UDs0IkQR3Isin7wEF6eEaRpYN+1w8enDVZq+sazXa7ktMuMgaKfZ0ENsaPYFHjzFv/sZ6y89FOmUw6NgsAAM3w/RcnWgX5ICC6ltCSrmYo8JeShWhXEv/9Q7KjXyJiqC99cmyPYHgu0JWvnZIXLhdFfter3b+VnysG7S3gnQzPxk4o4hIpuUzAd7yBb527gNXlZzjOmM/hF1VvwcERleG0FEHzAZxCNCtoTG/8dmqM72B5OXmUWxQBcozRAAMfS0hhWz5Wzb3wzOl68+waLUQ==
X-YMail-OSG: yEUtj4gVM1n2m0tiudg5nFroB78rsxi2kr4MBuj_mY.MrvOYob4jZK4tEjNXhih
 EevAx7bCH9yf9Evfk0uuz8DU7IJihVwp_30hacgJ6VGobyGR_pAwqq6RaUEyn3a6Qu4wCAeoHfzP
 yqCBHbfHiT0YrXlB_ejvG3HVIKrMYGIxy163jPXax1JDzOLLdvVZCELKEJHIqM6rz0rCYWpDq21r
 pSctZLGxq.gosmWf7as8C1VhwRZGsZ_ye3SxnxnASursL_GzKxxwjH3x.GNjg.x0.1v3LkAWGaoW
 GtRHrxUAqBFIU33qQvZSAAdK5.u3JlasZOZcL8.86dEqIOtrsHmRfTrY88ig9OBsCTtncAIygvQy
 dSzZo5tov_EAG84O8oFUQd6fE6NpkTX80rDS6IOjwLCBAkUX9ZZxtDzAmOx6i22Rvbw6mXPjbpWg
 ebALhJ8_ppu1g_fz5H1uZtbH189bvvcT6A8Cd1cUPN4N5jq3jkHY8FO3ClaI21t6Mhjc.Tl5TmZZ
 VmWATeUJ6_iRprIXI3zM2S4unR2etoGr.NFVmJlW5EqZ5b_3wGUPMYPXQekELqXwvWFk2u1Y_4NS
 nL7Y3OHZm3WfnNPVEUKTm0WPSDBsLuuySMao5C5SeVUuhhMgF__JeVI4Ugycmkd5LoMmGwtvl5m_
 V43I4fH031gjZ0JVNnLMy_FHGAEYU2fpmMN.IBYwanRDoQ8lcQSh3WNcGlP7Z5D2B1TkSgLdE5AF
 Wcbapbzt_IbIj0Md25R1Mnk8h1vBzAzjDVsjsz8uHdVq15wT_YsSr0fQUue3M10glJqqe681aFp.
 nbniAGckjsSOv1iIWnFfpmxnZD2fRUOUzmracVejRYRoF7z761EmfIQ95Xn2craQGY8WZepnclL7
 EUg9WO7F1kr1BMIf9FznxfWL7NbXX3JRgSnsGuvq2laWqanDvZO4Dal8zpB1UrlPAYyrAE2LcHZo
 LCNeFPblfR.tQXhWB1YvUbYCUKQTtfglvsS8v9cjr1VWAY7C.nY6BLyN3c2ayCfTkdW_hirBG0j.
 JI_OhNrQPplgYZzyyfHxtrzRwHX45kyDdkee8aWL8ZmhgkZgEv8rZNUP.EoqhpJkfnijTeWMfhKQ
 CrUe.Sl68KiRVx9OuwfaWp82xYi9P5VQ9wzNsQCO102BQGf.XVWhJymtLxdHAMpXgfELyS1N1.RO
 G7qYYRVOtLRcCiINze2ZVAUNCB5GECbRirYzHhlyJTg2NaCf0ZzOnYTuBH4kV4foaHHYSSiTyK0W
 zUZd.OsC61oqTWj5B3oxWb7gT_RiKwpSnw5XBt1EjdLO6A.gONryYkFrPrLF8Ndd5mH.eDfwbz2n
 F2hSw5rTIvEdg7eSXmzhG.j3CRygbymGlDHW1wRmDSu7xKyhTWj1tigHiCL6OSf91T0KJzxMbJEL
 7g2FTpIr8uzyKxrBZwiIUUsNhYuL5JWzXjvpSuvGcNmq.K2a7L9Ky2cSRGKzVE7XmjHWBIeKP2R0
 w.etOs1IFhfwEAk4t9ch68rkUEuo8RnhRKd3Jl5ACu3DrFqXYnkhNthhUJxBNn_uFqHa1JJG3CJK
 Li_gkgBri1vTxGNsnS3iw55lYnOC6WNKWJQkwDAj0bY9NuCyDGuet9EYLXyZwMUjkwMiZXN_ftJS
 X4JFgTyq32Z5bb0PdBJ84LmuJdJU__mOtAxW3krqzQAeru__5W8wmUCQS4.i_IeYNNgcpqwZoOkK
 _SASdPE_JxiRy9VNp9Fn5hlhXCZUWg8l4ed00Xw1Ze4Yyq_mepgQ6rH0Jlx8DYPACNijhAFHhBRX
 k0_m1u_cglWN65XjWaT05C1B1JAOQg8vOEsdimaq1BgXZ1aowhOz9RqQ3nnSzz5L.UWONGi3ifCl
 CppLTpl3DDLsCCraEKerkLsEZkIcDLcxYa8ynA6HpEX79e4kS3cdQoXS9t1BiS_8zRZ7LrV3irtZ
 xatmCvTyNzC7pKJbg14mTuqVt.yuzZYsmeLZ271ZJjz_byaLVGrpT7wnReXZ4.W53nDnPrI4vezW
 HyJKUu_5eaT6OJoXA7WItKCy0NRaAxXcmfo1TGz5AgRBjxvCowWGy9U88oojPz34kVLGAM2Pyuwv
 wB8868D8nb.enbQ2HYbdeLmzjX0.4gRiw1kpyuDI_IokK1ketHScO7QIqB2uFhpbJLkhfljmMx0w
 oux2TDLWkT0WPN9aVpvVUvWAq1oUh.m3i1mxMRyzndLb6QqQo6yE8e68SPjREQ9BJL1mzehWKVYS
 s2Mvn_DOzTGg_LHbjp6gxLL58FT9s9jLdy_KLEubrC_yRuvJJKsEMS5lq8sJICdud4mmEHGDzGOy
 .dsyPT5C0JQYVTWbEXVveag_p9_6r9ILXyqZcYMx5efeZlqdMzw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: abe0c9a1-c56a-45eb-8240-8692074d8de5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 18 Dec 2024 17:03:01 +0000
Received: by hermes--production-gq1-5dd4b47f46-5xsmt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12f7b58890c13094f67761df9a4a1cf5;
          Wed, 18 Dec 2024 16:42:41 +0000 (UTC)
Message-ID: <518fdb73-8daf-4181-a8e6-528e4824d955@schaufler-ca.com>
Date: Wed, 18 Dec 2024 08:42:39 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] ima: evm: Add kernel cmdline options to disable IMA/EVM
To: Song Liu <songliubraving@meta.com>,
 "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Song Liu <song@kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
 "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>,
 "jmorris@namei.org" <jmorris@namei.org>, "serge@hallyn.com"
 <serge@hallyn.com>, Kernel Team <kernel-team@meta.com>,
 "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20241217202525.1802109-1-song@kernel.org>
 <fc60313a-67b3-4889-b1a6-ba2673b1a67d@schaufler-ca.com>
 <CAHC9VhTAJQJ1zh0EZY6aj2Pv=eMWJgTHm20sh_j9Z4NkX_ga=g@mail.gmail.com>
 <8FCA52F6-F9AB-473F-AC9E-73D2F74AA02E@fb.com>
 <B1D93B7E-7595-4B84-BC41-298067EAC8DC@fb.com>
 <CAHC9VhRWhbFbeM0aNhatFTxZ+q0qKVKgPGUUKq4GuZMOzR2aJw@mail.gmail.com>
 <6E598674-720E-40CE-B3F2-B480323C1926@fb.com>
 <191ABC6C-1F0C-4B12-8785-C0548251ADDD@fb.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <191ABC6C-1F0C-4B12-8785-C0548251ADDD@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23040 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 12/17/2024 10:41 PM, Song Liu wrote:
>> On Dec 17, 2024, at 3:33 PM, Song Liu <songliubraving@meta.com> wrote:
> [...]
>
>>>> +
>>>>                               found = true;
>>>>                       }
>>>>               }
>>>> @@ -386,7 +389,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
>>>>
>>>>       /* LSM_ORDER_LAST is always last. */
>>>>       for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
>>>> -               if (lsm->order == LSM_ORDER_LAST)
>>>> +               if (lsm->order == LSM_ORDER_LAST && is_enabled(lsm))
>>>>                       append_ordered_lsm(lsm, "   last");
>> Before this change, lsm with order==LSM_ORDER_LAST is always considered
>> enabled, which is a bug (if I understand you and Casey correctly).
> According to commit 42994ee3cd7298b27698daa6848ed7168e72d056, LSMs with 
> order LSM_ORDER_LAST is expected to be always enabled:
>
> "Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabled
> and put at the end of the LSM list, if selected in the kernel
> configuration. "
>
> Roberto, it feels weird to have two "last and always on" LSMs (ima and evm)
> I guess this is not the expected behavior? At least, it appears to be a
> surprise for Paul and Casey.

I can't speak for Paul, but having multiple "first" and "last" entries
comes as no surprise to me. We should probably have used LSM_ORDER_EARLY
and LSM_ORDER_LATE instead of LSM_ORDER_FIRST and LSM_ORDER_LAST. As for
"always on", I recall that being an artifact of compatibility for the
security= boot option.

> I will send patch that allow enable/disable ima and evm with lsm= cmdline.
> We can further discuss the topic with the patch. 
>
> Thanks,
> Song
>
>

