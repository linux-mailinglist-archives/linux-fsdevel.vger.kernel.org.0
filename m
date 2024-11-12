Return-Path: <linux-fsdevel+bounces-34394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E719C4E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 07:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F9CB2294B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209120A5D1;
	Tue, 12 Nov 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Xn1edXhx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6402209F2C;
	Tue, 12 Nov 2024 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391996; cv=none; b=Auk0qH9Y4pm2m4aiq/RWxmQofQnyhkT1XUIvRrgdzSdF8DzUzskYC5d1Vu2PgWjR04HVLkwangq5HCNdDeYZWm0z84U9y0PjVmsZ1FgsVND/oDtIS/kKQ00JiWyjR4e1aoR/46UwcWA3EvwxaTVSsWWN/pRiMVDJWFuoxO5eY7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391996; c=relaxed/simple;
	bh=J+qbgf0dMt94M+MiLZutoXTHrbW79frIXv1/opOsVyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Igr+uOYT2dFKSlpTmgkdQfRxbGHPAbZSZqZ1goYQ8CExm7bLwgRVNFu6iun/V7kZY40MTr4wcxfPNn45eL5yJ4KvHc6/v1rhCCErPei5MQx7geeflWb0xb46GAJKsZEuRA9mXDNZchkzwT7YhYCn00SmgvXAQqT7DDp5sx2IXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Xn1edXhx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731391987; x=1731996787; i=quwenruo.btrfs@gmx.com;
	bh=j9WFYQ6rdIAQyK/nScUqreRtvAii8kdgykzGptsKuNo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xn1edXhxhyc+F/EG9D/0vMwG8iwld8V+4CWezEefOudQIpTJocw+YL1sP+H+EbDI
	 H4KN9AmOaBdf60VrgblpzhvTaBz1m1f6BcHyTgwawI3eIt3WRKs8FkafTdeLEwrdQ
	 rfLSAL4El1gMMOsai6JtqvHlkXHd6ej3uzcoGAhH5QkxNnRpaOz3Ln/2FB1slvkfi
	 YfthWLJPItybcZGqilkwkG0x3VtlcTufis28bZdFrgQfSKO0EvFItn7QxJf5Q/AYO
	 C9HsWzU6vNGBR2QmETWFg7ABpFcnkU3J27S/MLimZ5cjI0wksjw3XKrR/wd0tj9V4
	 8UlHBVokEV+sPF1nOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXXyJ-1tI3qf2X0B-00WZES; Tue, 12
 Nov 2024 07:13:07 +0100
Message-ID: <5afdbcb2-99ee-48de-88a6-afe910329a04@gmx.com>
Date: Tue, 12 Nov 2024 16:43:03 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About using on-stack fsdata pointer for write_begin() and
 write_end() callbacks
To: Christoph Hellwig <hch@infradead.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-fsdevel@vger.kernel.org,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
 <ZzGbioLSB3m7ozq1@infradead.org>
 <d5dca4eb-2294-4d24-9e36-dac8be852622@suse.com>
 <ZzLiBEA6Sp-P7xoB@infradead.org>
 <b595203e-c299-46f8-b79a-185276d53d89@suse.com>
 <ZzLqb5o8JsUdBGUu@infradead.org>
 <03f86d46-0de3-4c7b-901f-1ae16b554186@gmx.com>
 <ZzLwYZqwf7k5GlRV@infradead.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
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
In-Reply-To: <ZzLwYZqwf7k5GlRV@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XbzuunYOiECzoD6U/Ln2CEUBWH6EPDnjWB9SAbG+Hb722uZ3tlK
 wbhK5vjElCEXzFgZ9wCNwSB/bDSbqm5YUBbrUaxkieOjbgjhb7pUtCllufjmLYtC7KLhfOx
 RVX/HT01wScWTHMuSv8TWAMFf1ybktuZ+gyU9nNAFDvkuxD7xhW77pP/OBWwusS3ZNrJNJB
 JahoAMQqwcUEMfwAOOB5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9HYwuqvUoLI=;53WFSLChFmWPMiBYpPARAg1IhiB
 Yw88J3o1lY0E7XXj/lvyndujFmVlDcE/Ggw6Ck8ZtarPY6ox4GDbnINN5HM80HgjX+eEdI77s
 gzgp1CjdY9aOpFe/gpyx3ZQTHr1IsO719r8Aq+/3P2ndJZtUuNTUYkv9dpEwlf6l6/zXjithJ
 HEQ/qxJUwiJyQ8erz2Hp4lMEPS9bxfW0BSIvb1dsja0LwZ7EJAZbHdKvPe8aXxtc5SE8ZUXXF
 9+bqBFZiNMqMxD5Xmcht2ihWPQyTpNNTd06M7ZXdPrFBX2FyA9c9Y8TUznpE1bCdeK0zbyRI6
 36cTAcrYaP8TijHPE8WtavAfSJrIQImGulSJHlo4w8S+DX4eK2ewh6n7wFNlsV5OlbxYXGuTv
 HrAnGRyLyG10Aq8wNS/Np/qBFcCiB+TsW5mEknEsUe4DaeBuqBb8V7Bry3FO1SyDs95mEq+aB
 YnDYfiYO0h9uUzHHh24myQRnaj8UisrHuTLER8WydsAaA2WOQQ5hMCEhFvFxU++Hi2PpTY+9q
 YDFiZbX6za9P+8BG4FR3fBo+6ea0Z1982/gSTkzdh4Ms8eWC0JZt/6hElAiu1P6u/IrWwlKNo
 Bv05ahoN03VlNNFu1eBzABI5YUOKc0iPnNPWY2PmlzpTCZWIVdlPsswBGIPgLtTgYI3bgpREz
 xSZE4S5aIxXw9Vo5pQ3+uzY2cCZF7YIoc+2G6a52fVvwlDKuWOejLJnHhTb6sDrESaOEvn4Nf
 nDUe5uZZ1QJwkwXE2svoXEQnqwQXWzNv9PEjCFeaersRrFQze0VGQyZjwLuXZuNg7ZGLP6t2V
 pTwwLcisytAZlW7kOrdQZz+VIFcOJobqRqM8/h1zHz62ptiCdJi5QFYuaZRyAput+p9YkZI6o
 vmBJBe7URf7uHCugDxldkVYsg8qhfMkY7d5dNuU8J+MgRPUlCLKog2Hmj



=E5=9C=A8 2024/11/12 16:36, Christoph Hellwig =E5=86=99=E9=81=93:
> On Tue, Nov 12, 2024 at 04:33:56PM +1030, Qu Wenruo wrote:
>> IIRC it's related to the get_user_page() shenanigans but not 100% sure.
>
> While there might be a few stragglers left, everyone should be using
> pin_user_pages when manipulating page contents.  The long tolerated
> just pin and mark dirty is officially a bug now.

Great to know that.

>
>> I'm talking about the iomap_set_range_dirty() call inside
>> iomap_writepage_map(), for the "if (i_blocks_per_folio() > 1)" branch.
>
> That does not set the page dirty.  It propagatates the per-folio
> dirty state into the per-block dirty bitmap allocated in the line
> above.

I know, I just want to say it's marking the whole folio to be written back=
.

And in that out-of-band case, shouldn't we error out now instead of
marking the range to be written back?
Especially such out-of-band folio is unstable and can lead to other
problems, like content change halfway and causing csum mismatch.

And if that's the case, I think it will be much easier for btrfs to get
rid of its cow fixup workaround.

Thanks,
Qu

