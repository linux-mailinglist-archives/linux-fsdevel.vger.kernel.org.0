Return-Path: <linux-fsdevel+bounces-24234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290C93BE49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 11:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0297CB21092
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 09:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F571974FE;
	Thu, 25 Jul 2024 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZmLEaNnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04D15FA60;
	Thu, 25 Jul 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898076; cv=none; b=J+4owtk4jM2s9xVmy5nT3rajDXndGqEsJIx9efC8qqBsyzCmufP5bNt6nN7yhcApqTU2ic2iPpy3mKpGswkyDyESfbHi8j3PrsRYHqzNgdkR/9AfuQplkwWLiPOL87eISOZJoZTiv91ZwHLSwnmZnQCgOc+pwQp0L1/gIYb2eXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898076; c=relaxed/simple;
	bh=Q33MnF/0z7eUk0kHJL5c0f67TSMjk+zcMLo2cyr9nyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P121I6OKO9BQmt7mHCu44otK/P5e/UQh39NwzrLD2wVPMOLxGKKJmAkUeRJQaCgyLt/gfJkq5byLqSt1q5Fl+YHpeMCQ8FPP2lg1OAOUK4xMetl+CzZ6hN/TkF/YHB/lr6i6bCsJLvySIim0rlfTviwfvnmFx42Tg6eILXgRjJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZmLEaNnC; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721898059; x=1722502859; i=quwenruo.btrfs@gmx.com;
	bh=PTgi0kJLeNOW/y4L9y9OkM4VfBHNqvEet/Oc6GkMyq8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZmLEaNnCQNFhgzeQGfR4vkV4Xt/QCitGYOwFqcvqgQpAHurJssLotJql29FowIjl
	 0cN8ehgjBLHoHFlVzKso5sAcyMl/D46bAYBdrOFmn2SHEIa9Lt4jooGXw3CVEQ58e
	 LKjyYuiyv7R0GFA5SGLOk3EELO1bBWdlHT9P53+58a0Toithl/eTr1X66got6Quli
	 0B1Zd96QQkD1/O98xnAZqs5a2aB2eLcC8dGynX4t+vBeWNuAkcHGRghBxCViNf8Kn
	 /iQneaOUyuu9iwtfXZnFPSg2rpAUSQxWSSl3JdR+uRDdLR1ssqjtbYEh3g66qmYca
	 PIJ9s0wPGGodDnUeFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpex-1rs7DY0XHD-00hBhq; Thu, 25
 Jul 2024 11:00:59 +0200
Message-ID: <f84a9639-fbc4-466f-822a-d151ac4db8e6@gmx.com>
Date: Thu, 25 Jul 2024 18:30:53 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qxWh8oiyQcVLC0FSmg4GNGhlZ31zfEUh/cWHcX8XIWKWF2aTdYw
 on7vrejKJPEl3RHecZg6f58vnLHUtXdUHPCtsvKem3nnLCOlI0lgnMZXBHTovPsHXAeXam1
 v3lAA23Q1DKBQNPgFih2g/KwvBx60KRrM7VdmwXEDAVDzEQILYUueFSgnSgSlMEvq//H5bU
 8Qw3Wt3oYv18KAZjIK9FQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YRi0ivA3tHk=;z2zjEQtaE8ECvUGmr76AeH/URve
 BApBcknMny7lLNOk+wbmKSXQ22bfTgwsX7Z+zL8yzFMCBDcJaTZraKo1N1eHDj44bXT1VCIsy
 w760NSn8GNdnnmxj2Pv7CkKJ60gRM4GM0uEX4KQbBtu6ZPWBg9UG1mkD4dFrCFyeV1geMXNXa
 d9KA8XUw5GHz3O7qr7bC+5RmFqdDisVPc7U+XsIRlIzvPzOPvepCt0ekygQtrNVv5E+m3AUo5
 n6S0IxxtgZ77CySvcBzX2OR1uVrIfLo5GMs7sQVnsaMTKAhZLP40bLRBtVpRiaIuGHEmtQY1r
 VJkTQy5f6/E8fosy7X0bbt/4cMVHiZy3jj0d8SD6neccDe4kuCAqk2JhgTUxPmfhdrCC81KZR
 FPBsc/uu+9vXQLdU9mDKA9gjdaaHueBJAi8QBLjjH8t2lQaP1hjKf20Zn+2y4XDyXcDIJffow
 xaAWRs2IarVMFZyHkbQw3hQ//nzW5gvRHfthCowxmP+FT6RiS379hvc/bjrthl0wGqvurohlL
 x3p6TGyG73/vdHQUwhCd7xnaVU1i2V4IxIuCiUmLEQghjYeCoNghszyaZKzNSvNBY+tlGKqDj
 5MVytZqlB6vIakVur62PtQqZoLVzjzNvA1VbXnsTr3VVEDOUgp5sPHRSkjkj1AH5XIqkvDU2x
 QM/hurZfNuwh3ITb2QDvz9fOqQQt7lqJv91n2JZTYloh4b83SzwxDGaJdOWxpPCZVYd+Nn7TF
 dHai26HvSpxvJ34XVIjieDZH5mN8Q0lG8uiY5kbvFy9XTPdJrUiHVSIGSK6BmjWauMEyYM88H
 qek9pJKv3Y0OJU4ZxZYRfY5w==



=E5=9C=A8 2024/7/18 01:25, Vlastimil Babka (SUSE) =E5=86=99=E9=81=93:
> Hi,
>
> you should have Ccd people according to get_maintainers script to get a
> reply faster. Let me Cc the MEMCG section.
>
> On 7/10/24 3:07 AM, Qu Wenruo wrote:
>> Recently I'm hitting soft lockup if adding an order 2 folio to a
>> filemap using GFP_NOFS | __GFP_NOFAIL. The softlockup happens at memcg
>> charge code, and I guess that's exactly what __GFP_NOFAIL is expected t=
o
>> do, wait indefinitely until the request can be met.
>
> Seems like a bug to me, as the charging of __GFP_NOFAIL in
> try_charge_memcg() should proceed to the force: part AFAICS and just go =
over
> the limit.

After more reproduces of the bug (thus more logs), it turns out to be a
corner case that is specific to the different folio sizes, not the mem
cgroup.

We have something like this:

retry:
	ret =3D filemap_add_folio();
	if (!ret)
		goto out;
	existing_folio =3D filemap_lock_folio();
	if (IS_ERROR(existing_folio))
		goto retry;

This is causing a dead loop, if we have the following filemap layout:

	|<-  folio range  ->|
	|    |    |////|////|

Where |//| is the range that we have an exiting page.

In above case, filemap_add_folio() will return -EEXIST due to the
conflicting two pages.
Meanwhile filemap_lock_folio() will always return -ENOENT, as at the
folio index, there is no page at all.

The symptom looks like cgroup related just because we're spending a lot
of time inside cgroup code, but the cause is not cgroup at all.

This is not causing problem for now because the existing code is always
using order 0 folios, thus above case won't happen.

Upon larger folios support is enabled, and we're allowing mixed folio
sizes, it will lead to the above problem sooner or later.

I'll still push the opt-out of mem cgroup as an optimization, but since
the root cause is pinned down, I'll no longer include this optimization
in the larger folio enablement.

Thanks for all the help, and sorry for the extra noise.
Qu

>
> I was suspecting mem_cgroup_oom() a bit earlier return true, causing the
> retry loop, due to GFP_NOFS. But it seems out_of_memory() should be
> specifically proceeding for GFP_NOFS if it's memcg oom. But I might be
> missing something else. Anyway we should know what exactly is going firs=
t.
>
>> On the other hand, if we do not use __GFP_NOFAIL, we can be limited by
>> memcg at a lot of critical location, and lead to unnecessary transactio=
n
>> abort just due to memcg limit.
>>
>> However for that specific btrfs call site, there is really no need char=
ge
>> the memcg, as that address space belongs to btree inode, which is not
>> accessible to any end user, and that btree inode is a shared pool for
>> all metadata of a btrfs.
>>
>> So this patchset introduces a new address space flag, AS_NO_MEMCG, so
>> that folios added to that address space will not trigger any memcg
>> charge.
>>
>> This would be the basis for future btrfs changes, like removing
>> __GFP_NOFAIL completely and larger metadata folios.
>>
>> Qu Wenruo (2):
>>    mm: make lru_gen_eviction() to handle folios without memcg info
>>    mm: allow certain address space to be not accounted by memcg
>>
>>   fs/btrfs/disk-io.c      |  1 +
>>   include/linux/pagemap.h |  1 +
>>   mm/filemap.c            | 12 +++++++++---
>>   mm/workingset.c         |  2 +-
>>   4 files changed, 12 insertions(+), 4 deletions(-)
>>
>
>

