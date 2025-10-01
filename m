Return-Path: <linux-fsdevel+bounces-63137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE99BAEF43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 03:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7531C7428
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 01:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A8522D9ED;
	Wed,  1 Oct 2025 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lGVlSLnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC66BFCE;
	Wed,  1 Oct 2025 01:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759282165; cv=none; b=pC4rU7bD45pEwt2pcXbU5QhsfFprjzGQhrNl5BxvCKGTTAj/bRjFoKPd16eEMSMg6DNRC0dO9FhfhrhDrHREf5hMeX7UDSywVwpFQEo6CRxSPjJqUU3+g0/CEqhQycBgZltMPWtp+GOnbisWCOHqsfAXbGYjIfBG/RzwYIC/mGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759282165; c=relaxed/simple;
	bh=V18X70ClbSjN9MYCOGgEz4owxJw3clwrxRo7sguj73w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JGcIGM+HFW+Dj8DX2Dr5Icb/K52dmJsudSlRpGWJqTS/EPm8HvlEQszDPZkuEVTH3/lTm1d9y4nh1sJaVZZY5Ep3B1/AqgG7XXkC8eFtbMcrsaM7yvMw7e3x0tHNvREUjTrCJDc/R5cpHQgODaR4dehxYUf1/MYWgyrGlyoRVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=lGVlSLnz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759282161; x=1759886961; i=quwenruo.btrfs@gmx.com;
	bh=JYBQ4b2uGVpJ8VS/PqZwQZj8AXxTEB4o0zF9E49gpxM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lGVlSLnzBmdqDYpQQ9SP2vkrQK4ojAFr3jPljOGT1Rh1lTXRz3y817GhAZ71jamV
	 MpnO1deQQVfU5dBuiiKvpbD/E7tND+i6zYPiniQeLsy7H/KsJs+F602kqlxsygKfS
	 ZCxIlZFWywqOKxA110AZGkrkFSBHabgzhf9SZRtsf6BdADjlG0Tc4Um6cqbyxL3Wf
	 0xi/qqA4jydvolEXfcVnAv1MK8AR5taZt358yI06/F7iUAbbVGacMrJ31T3oapYzD
	 QbqvVYix4+5lD1VI9RuD5sIxt09wDb5nx6JygBZTvW77tJKc3UGQe618nYETiTquE
	 RETeNcpFGldEGBCsvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MVeI8-1utyWy3KwW-00Q6bB; Wed, 01
 Oct 2025 03:29:21 +0200
Message-ID: <048c3d9c-6cba-438a-a3a9-d24ac14feb62@gmx.com>
Date: Wed, 1 Oct 2025 10:59:18 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Direct IO reads being split unexpected at page boundary, but in the
 middle of a fs block (bs > ps cases)
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l/tqZwoY8J0lnU9GN1VYMKzcwnXAIcl7vx6FvACuu80c7E5aubA
 yueFPAqY7yk16Xw2RU+n4uBOAJVNMtrujNKaARxGvu99p4GlF9CxxtAXjbqNrq+EmtfS5kq
 ApCe/okjTYUZBm9xKCpm1g+H1ijs4XlHidwpQ9OnJ7wWiLiEWRYT5vngW3hFpiDYl4PqkZv
 4+ilv0PVsINOj+1tKKEIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3941wJxauIo=;nbYWafiYbkGTVwLmI8QssPMbK1R
 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

Hi,

Recently during the btrfs bs > ps direct IO enablement, I'm hitting a=20
case where:

- The direct IO iov is properly aligned to fs block size (8K, 2 pages)
   They do not need to be large folio backed, regular incontiguous pages
   are supported.

- The btrfs now can handle sub-block pages
   But still require the bi_size and (bi_sector << 9) to be block size
   aligned.

- The bio passed into iomap_dio_ops::submit_io is not block size
   aligned
   The bio only contains one page, not 2.

   This makes things like checksum verification impossible.


This can be worked around by falling direct IO read on inodes with=20
checksum to buffered IO.

However the fallback itself is very slow (around 1/5 of the storage=20
speed, something we will need to address in the future), I'm still=20
trying to implement the true zero-copy direct read support when possible.


Any way to force the minimal amount of pages for iomap_dio_bio_iter()?

Thanks,
Qu

