Return-Path: <linux-fsdevel+bounces-21300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C616901844
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 23:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350B21F212A5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 21:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9144E1DD;
	Sun,  9 Jun 2024 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cOC6iF44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8610718C22;
	Sun,  9 Jun 2024 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717968024; cv=none; b=pnXrps0RUyu206PEU8R/putQ4nrnXV5XNJrP/nV91VxqeNKK5lnWUHhCWLiiaI5jfg8nffvg8lVg3ghOw4rLsZvEkcAqSG3QPbUnmK8/wkGOln57zj/oHeYdRb8nLevYBGdBQMeGMfEk3yBMqzf+M3BAWpsDaCPp4n+A9DP7tmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717968024; c=relaxed/simple;
	bh=BuBxWK6zUA+6c3zugRmfDYEDY4Qkmac/nkrzIbKU8ZY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bTsQYRCo++p+1YTimVriKLIjFp5RXRTXeQjw5mig2crbw3pAq6L1FcR2rvSzaFOEZ1xXyUb8eKR3mJBaUQLTRViTLLeJOGwL0bX3/u5UHKGADjaXVNBs/++Jpbx5wzGsPkxEjLokxJAFPOGkc0q9mpBkgvXKwNFe9EAJ67QnK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cOC6iF44; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717968016; x=1718572816; i=quwenruo.btrfs@gmx.com;
	bh=BuBxWK6zUA+6c3zugRmfDYEDY4Qkmac/nkrzIbKU8ZY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cOC6iF44Sg14vS0PtNPqR/GoNAZuyDTJ0hdDUFiNfdat9jtYtTBb6oJDEqojb7Wm
	 qPux8PKmB/NhjHJUDQd6hVMliUQ89NFsWOOMtk9Ssy59FCxgYfYw37Rv6hfrXDgFd
	 e69rm487cCb32gRRKHIgZSjxpIBm1Gt5otrclsTCfgIAPfPrLTXK2UOX111G0tKBT
	 R/Za8Btt/WseMx/3FF1i0Gi7brwT+UeizCCkbXXj12qODovaZMFljDRvCQij5jPjp
	 AwB9SHYCM+zzEAIMdt79Bf0T0oU/jj006rpEUPHKX4wwdiebw2MIa1NLLL4t5Xd+6
	 BxgHqjdI1Iy3l1rQjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MStCY-1rqf6v1imc-00MGxT; Sun, 09
 Jun 2024 23:20:16 +0200
Message-ID: <960aa841-8d7c-413f-9a1b-0364ae3b9493@gmx.com>
Date: Mon, 10 Jun 2024 06:50:11 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org,
 Linux Memory Management List <linux-mm@kvack.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: The proper handling of failed IO error?
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
X-Provags-ID: V03:K1:WQvn05ZDkwcI1DIt7MwycALGo25CsUb79JLfOSucQTxG19MNLF5
 1rqjDrrolzNg3fYUxsclZidg5YEhPfm47Zf4kaH0USzLlJs2w9MzqNiZEIhyP/+eA/phaBe
 Z/G6drGUEayBSCOWDY3iew3T8ni72terxPuwutZQkz9awz3qp/vIi4BdKU6wWVokYOaheId
 dPId93kG42UxY/PpjSeVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g3LRJgwpr88=;NcJSxFNN8Qu+cz/qeR6Ox2TQy2L
 2PTX9Z7maYQ1kc42tTLfVczL/bS/t7J23FRXmzWt9AwuFn9loWFKEaZM3RC6wwRU86raseDg3
 iB8G9UAVTExayG1PKvxf+pkKdPBiWWqJHFrs5lTfqvY45t6bYbY7p132b5PStOJZMHw+mId81
 aqQcuifnrnj49zyqrb3gsODCc2YFzFw/cQ2wzYCh7rceaTJRKxPhgnaLCq3HUyIMcMh+gCDLH
 Zgk/p2kJ/v0zGEwJnONkFuP52pKJETM6RAV1gMaG5grsQodL7SWKkU/+7YC09yzzysYOEgZTu
 pVbjX8XdZcY2vdZR9Nfdf8khdVCDw5y1VdJS6PHx/GHsDYx+wu/5Dw49yTWMENAl9el/XWtrB
 TVUB1UypFPYbWCemseIampB3sS/teudZQKtTgXyRZKwowfgaz9SABc+2deSz+JpQO3J1R2noz
 EPkgQXWKM0Bfv9mt10qIHEeGW4eJxk29o0WXsFs89cpMrXg9/QisIj2OfGUXUVjlMypZtoJ/u
 KX22Q24K/scLaOcQR3R8vjWATy+GPn+FHwMYbkkl8VzttWsj98PrvqjOZ+6MgeZcqps7Ll1VW
 jUYeIUDemOvtjuT52OPGPrX2uZO0r7eWbEOOorVJDzwnbjqD3Xby6/qOxoYD7t9jVYRBOvLYl
 l/6iWku4AUQOQnMyAYC2QVlreDqXWXLlz8D8H1LU7zmiNnQzuO1tMHuYwOEYmykOIZkHqt6MH
 UOHfAA55qt+sK50EqYVqKdofLB//jBUDmMPtHUafpFr2BPkFKoiim9giE4lqAnoXep512SJxp
 ANCw/vMbtFirWxdEa5M96hRfpNIGJuA59OTQsbIP5KXn4=

Hi,

There is a recent (well a year ago) change in btrfs to remove the usage
of page/folio error, which gets me wondering what would happen if we got
a lot of write errors and high memory pressure?

Yes, all file systems calls mapping_set_error() so that fsync call would
return error, but I'm wondering what would happen to those folios that
failed to be written?

Those folios has their DIRTY flag cleared before submission, and and
their endio functions, the WRITEBACK flags is also cleared.

Meaning after such write failure, the page/folio has UPTODATE flag, and
no DIRTY/ERROR/WRITEBACK flags (at least for btrfs and ext4, meanwhile
iomap still set the ERROR flag).

Would any memory pressure just reclaim those pages/folios without them
really reaching the disk?

Thanks,
Qu

