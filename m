Return-Path: <linux-fsdevel+bounces-2929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5FD7EDA6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 04:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD9F1C20A08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 03:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D33C13B;
	Thu, 16 Nov 2023 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mAn8vrBe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC592;
	Wed, 15 Nov 2023 19:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700106066; x=1700710866; i=quwenruo.btrfs@gmx.com;
	bh=UkrNH5Uw952M64CQ9vQvRyb/hL41cq2JySdN8YWu7jk=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=mAn8vrBec3s9uYl/ckXkP3wXBb9nogLXNY38AzGHFd6stDTchAVvTGb6ez7dRLJm
	 +ZWFWk07S9n4U+sSeP0jL0qMqnzTCumJlcmgG8Zrhe4Sbf8t9r2gpyM06ZnKpcO4R
	 owYKl+LX+0Ep4f3WbMVOBwRd7ZNLd4P54Sq+WKvYYaoIbtrNhLYwc02VJLbdmAedR
	 57Cr5lvhgRuUfGykzPpH0h3aaUegQ38/BUkC2BjdmhPP3OLUeI2ceYd/Bw49fit/T
	 6cXZPP+O3wcGOJRCjw2X7yIdS2/bFlsJoiNn4Y9csLO8Uivee63tizHk2nid5K5Q5
	 UflIt0ldS6TbYsKQUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mof5H-1ritkO1yaP-00p7m1; Thu, 16
 Nov 2023 04:41:06 +0100
Message-ID: <ec608bc8-e07b-49e6-a01e-487e691220f5@gmx.com>
Date: Thu, 16 Nov 2023 14:11:00 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Mixed page compact code and (higher order) folios for filemap
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3CPIkdjItB0ds/VQJKDcaZzszsZslVZuBKebZPr7psRBBrp6nIo
 QPmW9bTJ9ZyTwtBGvEsC+WSaP92D31eMRAxvVf9SOELuq5Ev7I6X5W1kEnOHCGWUnymSTZe
 SZ//LbBkGLAqSva5083z2iHNwZe68edy2ZL0TW431P4VOIjEfWJmvlILBASc2nVqRGXug3E
 H/PxBQ6mD3XWCrDyMqXJQ==
UI-OutboundReport: notjunk:1;M01:P0:k/j83dEg+iQ=;SYuIA2+IEpT+GlhzKaqTl6G+SZU
 +T2KJN0hxRsUxxLvOwinnZ/+WWW2GNRJ0WgZNzJNzXlLylMRRbi+wbRIvm1kzX02ou5DQ7LlF
 4apO86/30MKmOrUqdJln4HuRBCHT2StgRMqghWT0mbZFE3WPCatYtyXlmzl9F+0AX1bf7tk7L
 yKoVO99v8L6HBrl8i9LSABkBnb2QVa3BENJ/WPAeYGiey0myE8OKuC+iRuc/r1Hv0npHZRYV2
 BbRA45VHd5QIuxJE++A+HcfJpW5eKnCkPtytXimm3hGZWyS9nd8WmASo2jbRRNo4wbvMkeUXF
 7DlDyMUWfiWfYjAczEr/xZ4uv493obXZgoUZBAXrR3uhyc2dmWbf3KjS/SpcdXTIA8ahmtgsp
 sfQZzmQ3JqoJXWSVvewEQC7DfFZs/bHClR55lrR3fdXUlWKI5QnbiujiMGwcotpkyRDEGaFzl
 LaBzE9IuF2kHp8vD92PuO0khXAMPKhOqkMypMJOZERz1K1p7MJ8/gP2RXcO4iYRtTrhmbjuhn
 jyj5utwNy3eUkbxb1gUvB6HMO8eu/+zbU7WtXlehg11aLaQ/5Ix/Yodh1qrY85ywQXexYzHlH
 /9MpVBo9cM9/GBGu0vhxLYsZYlFaRnucF9SO0K3W05TF+aowzdTVgsjdyfIVFM2URg24/enRz
 nBcPtcu99gqcDXUuY2eZS+glHNqzWU4Z96v0LM+tuuVWPq3TSMNAa2llECRa2do8Rlr6lByI4
 MCbld9MsVaHEmLbQN3jM6xnm/L/F274Mlim+zsNguP2QRn20980X+6rwJWxujzBa8+3heo+de
 XECyret8vYHguu7Nby/PuSKnTU96wK8Wcj3Lsc5xGdeKK3ugXMP4CliTetRtx6b2aUayEPVSi
 YUnyCcKTLdPu9D8HzkjM8IHexapfPpu/MsBBNus2OXNsVUClcuG6xbkRXS/XiJukotAPFwk9z
 +nXUmj7TLY6MEfVnAlnPH/oHQr4=

Hi guys,

I'm wondering if there is any pitfalls when mixing the legacy page based
code with higher order (order >=3D 1) folios.

E.g. if I allocated a folio with order 2, attached some private data to
the folio, then call filemap_add_folio().

Later some one called find_lock_page() and hit the 2nd page of that folio.

I believe the regular IO is totally fine, but what would happen for the
page->private of that folio?
Would them all share the same value of the folio_attach_private()? Or
some different values?

Thanks,
Qu

