Return-Path: <linux-fsdevel+bounces-24575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE4940811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 08:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89EBB1C22BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 06:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1AC18E769;
	Tue, 30 Jul 2024 06:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="CzjRDT8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEBD16C440;
	Tue, 30 Jul 2024 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722319544; cv=none; b=LW5vocy1ViyiYCjJxKwdbhx0qjmTNIBhS07k9HmHa5CZIsm7B8+ygkrtvZO1PsjXbhVQtBkDgYMMzDxxa0r9jx6HS/t51blJ4Ep9NzLudYxVhrAxQA2evkwCjwoAZDb5kUX1bctmqUY6sLn32/5BOB9TC+GyRv78fUXo0tjoEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722319544; c=relaxed/simple;
	bh=GgYyxkWcF1mrKR4Z+Wk11sI1YCzVyFQBFEit2LRysqo=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j81XDBhH8vx/8pmVnbzFeZb5uwwV7uGETqcPV8R9VCMoLjXGAsCYnc4VG7EmlelfC2/nvldsHNI3cmUMIk2h4aqWBUYXUWE2Gu1PDq7kFFiak2uRDq7qu5ipwdeIBndUK/bVsHbwrVgXPn4pqqGDVT+n/9WfhYIOEpS5gc9Gi4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=CzjRDT8K; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1722319536; x=1722924336; i=quwenruo.btrfs@gmx.com;
	bh=gLqh9GViikHSPInlzQR0jiEJOHrEk7YyPNsybyNY8+Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CzjRDT8KV6LDDbjtIHWJycfJz5JUGdkzUVaOlE/E5C88ChkQeu9c9iqOsyXPrfHd
	 +kO8bzKTcyz3t7BMGrGH8f4cxXWXTi1FZtzFR8Wl/KxDZasSQEnGEKlncqaSh1A/6
	 iJVBxp4mjzMxnOarAJcwmHd3jurp9jztnpvH+inDLnDwCwE+fc1LyySGQt5R8LNY8
	 qOgiiB9LJSeDuFGn9rW5mokZQ0B+owLKkRVRBB3guuO7Z/Jw1/JIUgF70zLMX7ej4
	 Xjd5N+V+uNNixSpF+WCl0Mo3Ms6s8HkKvarMxXfE04BuVC0pGNqVkw1pDKAphMztM
	 Yqte0GGq4VJvw56oyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE27-1soycG2K8R-00So7J; Tue, 30
 Jul 2024 08:05:36 +0200
Message-ID: <7e68a0b2-0bee-4562-a29f-4dd7d8713cd9@gmx.com>
Date: Tue, 30 Jul 2024 15:35:31 +0930
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 linux-fsdevel@vger.kernel.org,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Forcing vmscan to drop more (related) pages?
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
X-Provags-ID: V03:K1:f/RqNqqnxi/jMSu/SZrfVGkIv6NDnI3MVakn7sE8tdMIkF/6mAc
 PPfWFLXmxTXrBwCjXyJD9VHyus96oo7fkINefTLWsPaGWPDuR2m1lkNd6wkZ9TAGI7tZYUP
 U9g32RqNUoQGgDnm74PuJAglGoWOrntSF/yejHogaCiu1hwZ8a0AHmqBRknVAjvUPCb+2hd
 UgFKAMY0QFeySpS9RcQnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KGDQK2MeDU4=;D5x3683VsSKkNcQiwZzjgA4QYIL
 WH84rY60k7hqwBeughkMHoxeOuJ7cvkRu0byJ85ly+DjQLRP4EzxRJwqPngMG3X43vYle5pFW
 +hh1kofm7SkXDBHOmuM6a8lzaMZ4jP3XmuEFb3HV7PaF6luOTGBQx3ODFZZ007ZK5vTAmb+xN
 bb+NbGFmx8aGagymfW9fqua6pLup624C1LevqDiafcIFui+ZBivKaONNw6hMFEXXTFpkMJ1Jl
 67ok/r4Ib+hvqh/Hd+rFO8pNzPit8dObOrWS0GOCzXeHLeDS360Dk5oaeB411hKzgo8z/uIQ0
 KAEhuW9rkjDgdol5iQnZci5GlG6+y1HhMKxH1zi3UoHYPwU8E9SnQSj9jx4OgznmrJpKJkCYR
 uNZWr3HXIhTaE3SOyd7UO5u7nE/VgE9mJ1TsFpq4Dx35jGxHH2bhXZRjrHwBtu758uvdvHZ3P
 ENXWwWKb+qxY/iE4s+RM7dvpVcKzZs3S9Riv623euJge7EufJTZiH0EhECosLbMaIu4+y4Ny5
 k2l8n2ln3QE/foQvIgdaTZ9fBVIfXV5z2nVv0DBSS/uJbVhml+xoqc/qj4qYxBhvq0BV/0W00
 b4u1iX0JVRm16eiZ8Pi/19lfDDDRlN3K3HMsxUo5i3is4nq/Mu6n0MdP19pLbRTgOoFauCZrG
 KGER7VDuvVP9kqyyTNJWurYS/vi8nCPGlyMPLBrATT55p5zN2gRdgYQkNxA6HOcr1wuq5tvmj
 FRQ39VdGL4fRPAVcB8OlbvbH6SW7poY68XMyDhKG0Leqw+ZoXOrTd+3m4IhSdN75cxshuO1dN
 Ii8s2uxKRiX/Objtmg6YAlzg==

Hi,

With recent btrfs attempt to utilize larger folios (for its metadata), I
am hitting a case like this:

- Btrfs allocated an order 2 folio for metadata X

- Btrfs tries to add the order 2 folio at filepos X
   Then filemap_add_folio() returns -EEXIST for filepos X.

- Btrfs tries to grab the existing metadata
   Then filemap_lock_folio() returns -ENOENT for filepos X.

The above case can have two causes:

a) The folio at filepos X is released between add and lock
    This is pretty rare, but still possible

b) Some folios exist at range [X+4K, X+16K)
    In my observation, this is way more common than case a).

Case b) can be caused by the following situation:

- There is an extent buffer at filepos X
   And it is consisted of 4 order 0 folios.

- vmscan wants to free folio at filepos X
   It calls into the btrfs callback, btree_release_folio().
   And btrfs did all the checks, release the metadata.

   Now all the 4 folios at file pos [X, X+16K) have their private
   flags cleared.

- vmscan freed folio at filepos X
   However the remaining 3 folios X+4K, X+8K, X+12K are still attached
   to the filemap, and in theory we should free all 4 folios in one go.

   And later cause the conflicts with the larger folio we want to insert.

I'm wondering if there is anyway to make sure we can release all
involved folios in one go?
I guess it will need a new callback, and return a list of folios to be
released?

Thanks,
Qu

