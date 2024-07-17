Return-Path: <linux-fsdevel+bounces-23888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F39344DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 00:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 856B81C20FB2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC63537E9;
	Wed, 17 Jul 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="c7wzssSI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0218EBF;
	Wed, 17 Jul 2024 22:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255946; cv=none; b=hZxnVatYHokssO2zE4pWFYlnKBRuy/kmysBaGsVFdyd3H5esYBWjH3cqXaUIvFq4KUklOJJOEm9evqr6VmnsgvBzgVRe05Y2vLb1mW32fvUsbNz8/gzx1LEHkzNoB1bYaGmB+bJcG/xfTjxYUBV4qpmuKafeyWOlhFRHW48o9pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255946; c=relaxed/simple;
	bh=w48PPchZPTIIhTq4Pc4vB0tJRN0Ye+y8ILrpMAW65tU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCmMMKAPcWpQ5bfhdQ+tnBePDhpm+okM9xAqxQs7xuN3iD62NpfJROEOtK+Ri5kBrIv9rdxSmA+UjPPqQzVM78EJC3Qs+xGJXvq9DU9YWOlCfiNYuw4JM+InGF94C1E2M+mTdHlC8n1e7Zt89pfrD2QfMwy0V7stmc6QpSr/XIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=c7wzssSI; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721255917; x=1721860717; i=quwenruo.btrfs@gmx.com;
	bh=xPrZzVvNcdHdHnuGibZ5iF0WjkNUK2IMySL628CV+78=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c7wzssSI1DS/wbdDhHS0PRgf3EPYQ6ZKC4jA2UM5kZFkbfszqBwYsbd8Ua+x8Kee
	 ppmQnHQyE0v0m5ke/agYCW02UIIPIjsVSEUpPPjaYIvXqmQG6oPQYd/GXqXfAlHbU
	 S/TLKwYEDYXbJy1zNfz8TuG96uhy1PhDH1PZxX5Hss5cyBUigo/YXw+AEc38KW28U
	 3MHJnAQ9nG2lpa+eX28KmlHUK4ot/OspjOEXm99VNNeqx53ZMH8pu1qsmcUlKVCjK
	 bU+/7zeOGKNBIIr0KCu5sVZz+npZWhghA5Wtb0sPsKAQLKqJJE4/UjFM4b8x9pvDj
	 DRIJf09roiEcPnd1Yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MmULx-1s4GC52DhJ-00eQUd; Thu, 18
 Jul 2024 00:38:37 +0200
Message-ID: <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
Date: Thu, 18 Jul 2024 08:08:29 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
To: Michal Hocko <mhocko@suse.com>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Cgroups <cgroups@vger.kernel.org>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
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
In-Reply-To: <Zpft2A_gzfAYBFfZ@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+4QnQQP9BMboYyQs/2n6exd6SgObnrelKctk2B0hezSTPpkkRXq
 X5NZRZyQp3GTQdm+7/xScAWghDvDh2iaU4LspcflVEX0OU6Kk26U/ef1E6cFfvsZ+x0UQGk
 7n057tPnx3upVMzo+3NQIijTwA2XZjJNNZAU99QNgzfIKatR8O6aEwSkiRijIlDyR4HXvOj
 NZNPWmulF3N/aGIkgqDEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:E+pFkZCKcYg=;Ff5j60pZla+04l+O8uUjORN1zWX
 txyIEsMY1aKh7ptBLNi2luTljwmerzSR5nJuwYP/F7g/SXwC1Cys7offurMow9cThssabKNfV
 ieX4ILgEncc9BVSOMaO2F9hfn/Vf8i7i6KJNKCfr6onp6018D48+aHPx3UCdZcqdHhTxKHQ9G
 Wt4urgTFn6jlG0zVM7liRaxOui9lXZLpIeQINvygxcM4GPb0JNI+LqwEQ0nMrpG75aF2ccGm1
 hs1nXN8VwF097DY21oEHh/YWW2A1sdMVRQJR67vTtb6Kcz+ta1ynrIGcFYNQmH43hawdZDXnM
 RASirepRD65tUJkvSyQd4R3UUdw37XMUg0W8J24i+5zd2Yq3MVaPV3Q/WP4Zi4776di5PcmV1
 ctLl5d6KU7TBY83aUjHh+abDAxnzPqwLRluk+NXVZLXXpMjYzrYHW8QhCMG3DoKiRaO/M4Jus
 9jQKnwiy4eXgEdXweT26tpwlr3skDZMAK9Tx1lBLPdWmSr5/ptS2PJv2Qt7ZHvEOJjVZHedoh
 VjRupimWNMKtGyyr+KJ6112qep+vsW36f2h+6AsNmypcQRJhrc9IYstTceNyRY6wVZvH/Hb9a
 coHqiBya9b5ybn2W5YQ+8dvaOX7D875+YGYvk1O2vLffnIhZcfn0/6INr9icE3AVFt1EKJbxe
 rQc3MM1faGUqY46IHxIAJ/V7I0pDHz6Qdg7i0qayNmKfywtr/GufnKBxYSZF7b0kAmG+c00Ea
 doivp7GomWRR/sjUZQhO7CEQxMGwHigJOPJlfEwoQqukVcfOexujynxDsfPe1MMAsaCWmntcP
 D96vCUX/xUMwE6h0fzk5m5WA==



=E5=9C=A8 2024/7/18 01:44, Michal Hocko =E5=86=99=E9=81=93:
> On Wed 17-07-24 17:55:23, Vlastimil Babka (SUSE) wrote:
>> Hi,
>>
>> you should have Ccd people according to get_maintainers script to get a
>> reply faster. Let me Cc the MEMCG section.
>>
>> On 7/10/24 3:07 AM, Qu Wenruo wrote:
>>> Recently I'm hitting soft lockup if adding an order 2 folio to a
>>> filemap using GFP_NOFS | __GFP_NOFAIL. The softlockup happens at memcg
>>> charge code, and I guess that's exactly what __GFP_NOFAIL is expected =
to
>>> do, wait indefinitely until the request can be met.
>>
>> Seems like a bug to me, as the charging of __GFP_NOFAIL in
>> try_charge_memcg() should proceed to the force: part AFAICS and just go=
 over
>> the limit.
>>
>> I was suspecting mem_cgroup_oom() a bit earlier return true, causing th=
e
>> retry loop, due to GFP_NOFS. But it seems out_of_memory() should be
>> specifically proceeding for GFP_NOFS if it's memcg oom. But I might be
>> missing something else. Anyway we should know what exactly is going fir=
st.
>
> Correct. memcg oom code will invoke the memcg OOM killer for NOFS
> requests. See out_of_memory
>
>          /*
>           * The OOM killer does not compensate for IO-less reclaim.
>           * But mem_cgroup_oom() has to invoke the OOM killer even
>           * if it is a GFP_NOFS allocation.
>           */
>          if (!(oc->gfp_mask & __GFP_FS) && !is_memcg_oom(oc))
>                  return true;
>
> That means that there will be a victim killed, charges reclaimed and
> forward progress made. If there is no victim then the charging path will
> bail out and overcharge.
>
> Also the reclaim should have cond_rescheds in the reclaim path. If that
> is not sufficient it should be fixed rather than workaround.

Another question is, I only see this hang with larger folio (order 2 vs
the old order 0) when adding to the same address space.

Does the folio order has anything related to the problem or just a
higher order makes it more possible?


And finally, even without the hang problem, does it make any sense to
skip all the possible memcg charge completely, either to reduce latency
or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?

Thanks,
Qu

