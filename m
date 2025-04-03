Return-Path: <linux-fsdevel+bounces-45622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A81A7A029
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73E03A8F9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410D22475C8;
	Thu,  3 Apr 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JCKANCoH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3CD241693;
	Thu,  3 Apr 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673026; cv=none; b=BjMVyFtfbunlTn2V+pEnGQpDndJaQSQR01Zy1u3ObjyKVcQfTMAifSYmxD2B7Di863bKFDZxcN31h1YhTGs4Mj+zfklsb3quKyyTueEjqI2y7CSL+QnVNx+pkul4U9V81hgutzPGBWm1MRC4DfQVBT07yp2EPRjIW+JaRZPvlss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673026; c=relaxed/simple;
	bh=FowseTNKm1Rf50n9OBGGpoUltNQ9BNFQ15Jybp6GZS0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=TnYlWrFUT5D3j6FuZrsbUuHftKzfC1Uljza64CWX3nf1cJ4IUjQD7k55w26OPMKQ+DsQWgHzcJFnWgmIuahYby9rC6NYv50FzdPZFM+u1cr3VlpXvS6vch6rjQ+OXtTVQ5amyTElBPiQIdT+7YY0p6AFVqY/dfh4E6aVonejeTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JCKANCoH; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743673018; x=1744277818; i=quwenruo.btrfs@gmx.com;
	bh=FowseTNKm1Rf50n9OBGGpoUltNQ9BNFQ15Jybp6GZS0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Cc:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JCKANCoHPPLtuiw3G5m5nWQZp4gbMJ4gcyylL6yqdcv73Bz0296zUHH5ZVWSF3LQ
	 kzFIggL+40k2N1c/UuNsnnK0ll0sE3gx3QXeUMC/IIoI18lW4QzUhm7rHIws4XaYH
	 DGtxA10/vHX3z99jPP1B+zu6AUeWuvdlQizYLTwcmo1IfdUMzc5zXLUasWdmYgLX5
	 sQQLCHk6TZxu36t8qpPW9R6BuTsHvtlo0gYQw/N7NaPohXoGUhXx0Ni3oA9iIfKhM
	 ReHOay+g5Olu5f7JWylnqGgtNxrq5EUvmhW0KnpvuegVwGJVkNx3N2OQE+zNzBHl8
	 CTgC/NuNiqbW4gmqAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJhU-1tHLKf3oGK-00jClG; Thu, 03
 Apr 2025 11:36:58 +0200
Message-ID: <b714e4de-2583-4035-b829-72cfb5eb6fc6@gmx.com>
Date: Thu, 3 Apr 2025 20:06:53 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linux Memory Management List <linux-mm@kvack.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Large folios and filemap_get_folios_contig()
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
Cc: vivek.kasireddy@intel.com, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qJB/sKShH+0bNXSIlI6Q/N4tTfHmVL4W2blVYDqEQzW4Radz3W2
 eT9K/R5IfOQ+sdXOfteMkFIxJ0+LOsFklarlr1AF7zaAPPfRW5bPKKF/7jVF49sG6Z7tXWh
 oG330PwyXIbACcTv/iZFI++GNU7lcejr0jvYHhglqNgJTiyXuKaG/vfs7oEC35vBkuNpzWJ
 7EFXMGjAX2o7YvpAUVpkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wsaRdeIBf5E=;gv/9/d3G1MuzaZaq7T60G4kXQ68
 DNEPKHcsEHH5BhiT/2vykl2TFWp2n/OwKD17axvNOYJxKOYcofKkbxRFBmCCaZdVZuwka773B
 CgzgJzwXIACl+UydpUq6uYwkDnxoBQ183ixGi8GIeCRoy93yqTdVJuEZxh9VE4eQD1SPxOgXs
 tepZ9AjCyJmgLPyDvlwrXIe4NE9i0zSPotuDieZ0B20Hc5GihSHnTpWaS5Dd4Or7l9m/E1w+b
 QmRViSog1xIvtu4hcQFYAcFD9MBe9VXyrJJurLXfoWvESc+YV06u+35CkpEIHg4FaL0L3f06e
 vSyYN/k45oR9rtXAUmjazlGGr4B6Q/ajR3ougpY6caJi4n2N1jooFJYqIgVbzOachvQWOsWku
 1EhGFaLLIN6IR7Rd8967L54cWoOk2ruoTdwn/YI9IaXEsHtzTzR4XudW3VxJzV+VVUjcm7h35
 iR3O1SQe9h6ZrsA6vJtr0XxIpVzKhDkUyDSSQEwzfZbmjQkcuLs293VC8NqPGKRmOtuzBzzsH
 FtknuN3x2xa4i//LoiFDu6YvxSayMdKJtCyz0U4BRYti7+gX/amfqZyIJXHgwSC/XF2dUNaNd
 LE2HRmYfTXL0LcLiFJJsjNd4ezTFo+M645/BmaixjVEBaQ2hHPFdD0gGn1aqs+GGf6OlUm6GA
 Cjsj2PGg8g3BTe5RWrVlJT9jSIIXQXXc3rvrSDKm5PkFAberzuactGQv0p9Cm9kFaGC/pN5J7
 +Bl07+OhT+lV1fmhC8jxSurWLndYhc68mfuf9A7CJ4+Oys7C7fCw8ESBYkW3z5yzZ5GVnrljS
 /VrP/RQ72ujKBnDKafY4UHMf7PVCBg8FIVDw17WzJN6Rv+zRINL/uG04Hn+VaAiiwex+KUEYl
 5xLRi6tsbKQYKoKiBtXFEWve6h5Tk8nCtss3HJV9o+U/aCUsvk+p+5Bh/layDPwHLnqeCgply
 U/2YfqRS8N4CzxJVQSgdjsD7N3bpo25CI4hnV0Rr/pdUk0j1WDsR3MzKtItF1TVPJPpWoT7bV
 j13QbbPQpLpMqykwDlyR3/jXxbSslmtHfsjN0CYlIqDxvW8VLhdQmDZUUT6nSJ0bwBSM7P0FW
 Lxnd2HETEfvF+VyA988gHgfvH7gglVBhHKGMdq0Xs3Kx3xy0KCeaRnn0caGanAX/63kRdjNBV
 7hqSNJ4pR3UbNj87Xj+vJ5Yre/wtO7D07SFZWhMbMzrjAsOx1Krxg6RyVv5ajygRD3uvN9tvM
 cL9KqAI63qjjzwOOWNCSTohkD9gziXRW48D/IKz+Cg51+SluNCAMSBFulgjvKZBoVm50LtXAN
 2Lfxtp0OeNV2wNAFxLYLZ5wQDHXRUMdUKjqCaqjNyb/Ih/ywotWYSVcFoHDM0nPqcKI8r20TY
 D1bxvonCK+1oPxbzlNINIM7F0OAR3AHh7ZXXAXoXYdyVqYEeIE7nfwttJ4aiH4CwC6pE2hW58
 U4FysDKKURRe3okLwh8FqaxPoc0M=

Hi,

Recently I hit a bug when developing the large folios support for btrfs.

That we call filemap_get_folios_contig(), then lock each returned folio.
(We also have a case where we unlock each returned folio)

However since a large folio can be returned several times in the batch,
this obviously makes a deadlock, as btrfs is trying to lock the same
folio more than once.

Then I looked into the caller of filemap_get_folios_contig() inside
mm/gup, and it indeed does the correct skip.


This makes me wonder, since we have large folios, why we still go
filemap_get_folios_contig() and skip duplicated large folios?

Isn't the purpose of large folios to handle a much large range in just
one go, without going through multiple pages?


And there are only 3 call sites, two of them are nilfs and ramfs,
neither support large folios, the only caller with large folio support
is the memfd_pin_folios(), which skip duplicated folios manually.

I'm wondering if it's possible to make filemap_get_folios_contig() to
avoid filling the batch with duplicated folios completely?

Thanks,
Qu

