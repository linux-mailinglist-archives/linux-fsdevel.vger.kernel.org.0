Return-Path: <linux-fsdevel+bounces-2942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F57EDB3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 06:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C41C209FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 05:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AACA75;
	Thu, 16 Nov 2023 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="gyK60bdB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FA8192;
	Wed, 15 Nov 2023 21:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1700112645; x=1700717445; i=quwenruo.btrfs@gmx.com;
	bh=zQw6AOP7elWK4IMv8HNJSBRADYXZAlVWj1ySdu5STTA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=gyK60bdB8UL2KqH4/G6kjTxzSze8tX9R8usZytsawqVdxUOebju3zlPVjywDBjtP
	 K2KuFe6HprNoQzHsB5c7LgUzesIBC5tpN75wnUctdi3txx9r3H9E9E7Jomq1pTaGm
	 W0rOhhrj6VxZ93BLU0CaiK4cjxGJw0645pvhvph4DgQZvE4wdbweK8lzlc3lakwql
	 G96Mmhr81OQUk71qfmKRXnsf0G2TBH0a3hhfMu6p8cFSeOY0WQ9UG3eo5FtqLgntv
	 A/owQT+OfSWaWetohHimCKYwztSXsTG5tOm/Go5d/6TyaqD/X2ZoUm8hWy1z9wqmx
	 dMUQZKp4kMNRtzq/Lw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N7zFZ-1rPgj12JFL-014yKT; Thu, 16
 Nov 2023 06:30:45 +0100
Message-ID: <0e995d32-a984-4b65-b9e3-67fc62cc2596@gmx.com>
Date: Thu, 16 Nov 2023 16:00:40 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mixed page compact code and (higher order) folios for filemap
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <ec608bc8-e07b-49e6-a01e-487e691220f5@gmx.com>
 <ZVWjBVISMbP/UvGY@casper.infradead.org>
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
In-Reply-To: <ZVWjBVISMbP/UvGY@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LdqkW1uFCwxASREPu6BpsAt+z+8+f/DwgLg+hqmiLwfUrtSt+5Z
 iJfb9lRmnQlGZutI7qJu3S1M3lzJ7iefXWlsz2vm6ZuvYI+9psQJ9xa4VByKJjjRz9+D4X+
 kOiuBurEs9skSbo760cFrjobMw/hhDFv8F3OwVvjTb+WNLvAW46pbgDn/sdspTHzZxb7ClC
 XW8IRGwL2vyvSoo/S3Qfw==
UI-OutboundReport: notjunk:1;M01:P0:4VMy7aLTtwE=;rWKNSIckSrF7UN1Q9Q+dkccCadn
 y+AjbRXelodZJLBBR1bVxZQJQ5ynk/0aIyjE2IctaUjgQJOa4ZnsT5KTQI81TsQaT2BvCHBSX
 MX9e4D/VtpS0Iqe1VuDP9+IYDmAGIB3jdHPOZHl9hJg7YxcCQ745gLPHTIRwrgGqhVIPUiDhG
 CvK7fMzbsM56FbsTEmMHeqRpA7l9Um4lBEugfn9etO+KcoSLCTGSUfXt/ltNgFLbPVZYq4Dr3
 f64TpR7Ns0hzrKWSJ3/4j5lSpjN+t4107J2n3k8RqJuLGE5SE9gKW4Dc+fm+I80PvTST9sYRB
 FdmgipaizZTZnOdplRm5riJW+H/xFgT68jKHa8Gj1GTwpQfo89UvZJs0MOZOcDs+fOYMtV0+W
 64HH1FZZuRFjOHT14k7Hds0rxu//2+gKRTb0KT8kQ2fSTGmdmCqA1FqL3zp2Qon2m0j93hLzf
 jCVglMXkG3g1kRuIIUKFp67WDkZ77eKzvcv72LCds7neQ9eyeM1HjNJ921eb2mZesVQGsVrBf
 FxQFdYq9xJCOxYLT0IPDpSfrhjnBCczCe1fUZjaZGAvgaORodPvFipOxHal62/SFKrShcOQ51
 vg3Oq9MLolpyY0CQ02KiMuDUXbH2dm9EuD/Z2Wu+tks+TG1r9RUG2YHCxgeoXIzPpj0+v9zIx
 jLefUhszZPUiwlfEzMaF/XC5NWHQk6DmoWhTVvNQUdH5I1/sOlewwLZOe/e7NHpeZaINhXpY+
 /AQQ1kGcAQ7Dq62yw43Zxa9L3lakOkPNzbWOK4C+ENCsE4UjZsMQacnPNfH5HPXBoN3g6GSlH
 pRrWnd1RcYDhC3s2VLlYxPGE7SjfRxxK6gP5Nh+3gRm5dj/fHeUyrVGg3vvm7lycL2HNT34lv
 DciZ8rbALg0l9dVrvBeUgfHRid+oeghCwb9vlAzDzWmS4gtjlNKN4aiinzqn2p1hSTt8bJv43
 S0BQsoupAFD1oL72I6xKEUFie7g=



On 2023/11/16 15:35, Matthew Wilcox wrote:
> On Thu, Nov 16, 2023 at 02:11:00PM +1030, Qu Wenruo wrote:
>> E.g. if I allocated a folio with order 2, attached some private data to
>> the folio, then call filemap_add_folio().
>>
>> Later some one called find_lock_page() and hit the 2nd page of that fol=
io.
>>
>> I believe the regular IO is totally fine, but what would happen for the
>> page->private of that folio?
>> Would them all share the same value of the folio_attach_private()? Or
>> some different values?
>
> Well, there's no magic ...
>
> If you call find_lock_page(), you get back the precise page.  If you
> call page_folio() on that page, you get back the folio that you stored.
> If you then dereference folio->private, you get the pointer that you
> passed to folio_attach_private().
>
> If you dereference page->private, *that is a bug*.  You might get
> NULL, you might get garbage.  Just like dereferencing page->index or
> page->mapping on tail pages.  page_private() will also do the wrong thin=
g
> (we could fix that to embed a call to page_folio() ... it hasn't been
> necessary before now, but if it'll help convert btrfs, then let's do it)=
.

That would be great. The biggest problem I'm hitting so far is the page
cache for metadata.

We're using __GFP_NOFAIL for the current per-page allocation, but IIRC
__GFP_NOFAIL is ignored for higher order (>2 ?) folio allocation.
And we may want that per-page allocation as the last resort effort
allocation anyway.

Thus I'm checking if there is something we can do here.

But I guess we can always go folio_private() instead as a workaround for
now?

Thanks,
Qu

