Return-Path: <linux-fsdevel+bounces-34392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B29C4E80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 07:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED441F24256
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3D209F42;
	Tue, 12 Nov 2024 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="p/OYad5q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B511A0AF1;
	Tue, 12 Nov 2024 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731391451; cv=none; b=eBx/VcyJ17n2NQvBsmFAeRUMbzrwE3tTOMZ5qdzFCfgmZ+AIeZtQh31BnVp94GMsME7w4D5XZqfFh8bdV02dMtWB2TXHi1g5CieAitFmh0aSk5hiZJW/KF/3TxNXnVb7GWHCDCTcsgoAB+wFKBDJHMNWpMP5M3MPzIlvEmijbi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731391451; c=relaxed/simple;
	bh=R6wEQP8V3yb6+4kF2i4JRr2MREUqISrEbK0Yb0PmcsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OfLGOsrKrE8GhNB0W/sYR+5kBrgNvKLLQUj4ZraVI1iH+ra82G5pLRppLY4We/aq/7OpRSeUqjyJ6cb5ycW+tXRxMB7PfcN11EqlNpcNt1U97ukWsO9ajRgdzFjkVkIioGcpfrll3MyTAH0Uq/SDuNEWm21kazzgLNtX8TocyRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=p/OYad5q; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731391439; x=1731996239; i=quwenruo.btrfs@gmx.com;
	bh=R6wEQP8V3yb6+4kF2i4JRr2MREUqISrEbK0Yb0PmcsM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p/OYad5qOMkO33DIZFe1aLzkO5DHP1xTHGBznUTym9x7YgUNa2IBXXbYRFOdkmTZ
	 eDSeNsabPTxj8k7eoeIXJS3JkTXxTowIUvIvC3qjpGy4NpMGUDeK+jbWUfLlRqL9X
	 YhOALtECUyXtsaoITnAzrzhLKBIBjSHyj+bAK5pL9DkK8Lknlngh+mNIclbR1iG7l
	 Ocm4ZCU6ZVQVqghnSz+6kNcmTNWJ9MOmFylLFquXvosB5+zdQoI8RMF8Zh8A1B0av
	 yZp280Qk7jf8SjYfyO/j2WTu7/j7s+Zi0cP9cgzUvtA1c0x/VLIaDRGJoxIe6TpeF
	 Q0s1b0xGHVYsvhgZLA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mbir8-1tmXGC482I-00bGF4; Tue, 12
 Nov 2024 07:03:59 +0100
Message-ID: <03f86d46-0de3-4c7b-901f-1ae16b554186@gmx.com>
Date: Tue, 12 Nov 2024 16:33:56 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About using on-stack fsdata pointer for write_begin() and
 write_end() callbacks
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
 <ZzGbioLSB3m7ozq1@infradead.org>
 <d5dca4eb-2294-4d24-9e36-dac8be852622@suse.com>
 <ZzLiBEA6Sp-P7xoB@infradead.org>
 <b595203e-c299-46f8-b79a-185276d53d89@suse.com>
 <ZzLqb5o8JsUdBGUu@infradead.org>
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
In-Reply-To: <ZzLqb5o8JsUdBGUu@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GabA2sX7aew1jnKLiU/6N6oQTJpMwUbcJcb9suhRHeNby2LXKtG
 dGhP1wxh0tIYZ/up8m+Ss3AIBhCK54APyIRFchYF3y/rt7iooI/AtU2FVDBOV7eeMtC6N10
 Mk+pNEErzEwclv31+mcMT3ZIZJFVFgN72qZtZ6Ok2Gyel39yhJfuUQMA+kSy+1rki7CWFcY
 qOTE8pD1+EgWGP8pQAcIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HbGF3kAG7dw=;ALPD8L39ISB8CDa4xd9KJygyPVR
 by+afQs7zDtLbourQr50qwjcBtVHeOm336y9E1dQA+dNWz7Pl9K0HIvF9rTMN2Mmv+/bAKGa8
 a3Xq1ipMNSv8jC3lJSYHJGTCZSYTzlevtnsy5wTfXM9A8EjK7vajfUv0nA8fFeNZ5ieAn0q1/
 eZ1WzcLlVv+g7Ug/cfanqeKbV0kPaV2LZ9mY8atOTQTrZqTDEzNveFVNTwz2FThE/bevzVf0i
 aTn4hdp0SBOParJJsNfTB5Zgb6mWl01ZprXestwoTamEnPE147a85BmdLAJzdCCIA3kxgBCT3
 dmdzf+mpQZUH9BF4iOLb/6F64TpMbikyfq72KJTVbAdc+wCB0dKqwPCdsspa4X739FzVoWbiY
 KA2ntbKNY6saP9Ng8y7aEh6/tKQq5UWqtlYbjxMJWM/23naJkH3QDolFYiVjV2gOe4f7ms1tY
 Of3xy1Hw8tZGVoamXy63BhWw7jyVyUyw9sphUhs8Y8/Lfv4wGLNcmQpKecuOt3CVDhBHExCon
 8NGxEUB4S31XkgvzvPcGgC4hij7cajop6cIv0WLIr/VFR6oOGaziuPZV0pHpajDEDKO4OnoTF
 PpPlMMYFd7HQI6rKTREEiPCdg/GDwvZltG0KQZ9x5YXtfuEe34ZQUTs13lJTEfvxI6VvwwtrN
 O6OiQ1DuuSZugS4gBt6NILs6TiirYwfW4GjduEcHtJbS45cATASonvat78Kv/ERjXugwTo03o
 KZgRdZiGbNN6KTracixDWfs+vFUIsZi3S2DRVUDHELpGiAsU9YwsILI9yiixcZYPRgVopiHFt
 OJHWrg8mkraYIWB6meFMb+Nu3nGkT2AJxJuReQTPBx10I0PQVua8YqyclbeSHxgw/ONVaeMO9
 8M5lAKVxkZ9irIh34Q8HOZhxrtfRx+NmeeV1RvM1uqgcW5tu1HwwM4das



=E5=9C=A8 2024/11/12 16:11, Christoph Hellwig =E5=86=99=E9=81=93:
> On Tue, Nov 12, 2024 at 04:01:42PM +1030, Qu Wenruo wrote:
>> Although I'm still struggling on the out-of-band dirty folio (someone m=
arked
>> a folio dirty without notifying the fs) handling.
>
> No one is allowed to mark pages dirty without file system involvement.

Then iomap should go the ext4 way, warning and error out.
(the ext4_warning_inode() inside mpage_prepare_extent_to_map())

But it's not.

IIRC it's related to the get_user_page() shenanigans but not 100% sure.

>
>> The iomap writepages implementation will just mark all the folio range =
dirty
>> and start mapping.
>
> iomap writepages (just like any other writepages) never marks folios
> dirty, it clears the dirty bit.
>

I'm talking about the iomap_set_range_dirty() call inside
iomap_writepage_map(), for the "if (i_blocks_per_folio() > 1)" branch.

If every dirty page is going through the fs interfaces, we should not
have a dirty folio without that iomap_folio_state attached.

But iomap just ignores such case and try writeback the whole folio
range. In that case, it can cause problems like the range doesn't have
space properly reserved.

Thanks,
Qu


