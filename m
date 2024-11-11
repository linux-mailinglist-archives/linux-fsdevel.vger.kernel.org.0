Return-Path: <linux-fsdevel+bounces-34179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9E69C377E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 05:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F37E281571
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 04:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F0F14A630;
	Mon, 11 Nov 2024 04:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bLoQ9ZzN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1F32C8E;
	Mon, 11 Nov 2024 04:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731299234; cv=none; b=Epi24Bjxbb1aexGnpqnGcr+AvAcm0+HmKs6S4UDTnRqnMEjvhPQr55ujzsMIl30ZtBJ6NUu99R0qlw38xDpAGz5R5Lk8GJBaaYRPTD8HjvSIx11w0/ro6YnscrUY6Bfeiq/Gzd+BwDTbfgRwO4HmrxCIoD0sPJvz8yRlUnB8srI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731299234; c=relaxed/simple;
	bh=jWJseAgdkVsRV45N5IT9+z7BLfZgg+UOTOPUDONmzEs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=FY5WBePFVwTLIwtwmiwkJERsAHhaO+0pYA8HbEQSjgrStNYcel64zJ9l9WfT/x1BKCjrq2TeFVdRwHcetz7AHUeOQ3OpHaOOhTKujwekU5pmXtvblTkHKK1JYzHRI9KHLnJWb+FDrry+HG71lBmKH1xP5S9EWcMvUFxA5CjHv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=bLoQ9ZzN; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731299229; x=1731904029; i=quwenruo.btrfs@gmx.com;
	bh=87IPDM0rzH9w7Vyj/nCxfWfodIkyFfirQkRrjE1gcM8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bLoQ9ZzNhlU16L3GzY+P9AIPqWde31bjsyOUPFDpN446lO5KDjBpHimhdWd2VcxR
	 vIo8iuGqkvL9WESq5AhIbA/hdry8cL/wCKALDSuI9vcZDMthVEMDtDpjJCKOQ/8ZJ
	 6NUVfCD8dzx6CodOawq+/tbSmV+WaEpOCh4MAGUkuDSeQuyJpDQhCLjTYDSdOkMQ9
	 AkRgn/8JAN//xmweAkjuOsOyvsz4xu86aEQAf1TgFXVv1jcCN+IwK0zjnEtzBC+Qw
	 z4H9RvZtxCWJQJN/j8pu4nyWXwbVootzjjty9yuipkR7pSvkfxNkfg4cE4KN6nciK
	 yq1g/hrZn5Bd+WCwBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MbivM-1tnGXD0qVy-00eG29; Mon, 11
 Nov 2024 05:27:09 +0100
Message-ID: <561428e6-3f71-48cb-bd73-46cc21789f6f@gmx.com>
Date: Mon, 11 Nov 2024 14:57:06 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: About using on-stack fsdata pointer for write_begin() and write_end()
 callbacks
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
X-Provags-ID: V03:K1:POIEgZS+MNLrselfk0m6ffNoOmih8NOsWgCslejF/lBkWd9EckR
 sFGHJi+9LpeSpW+XY2CJX03UyxaadeyYb7evN/b33Ym5sI80orwgjzfADVG81LJ68V7m5V7
 aQwuG2qkWP5rAUdd1ikhqRIH8af1odOrz3syvp+OksMc/9FNUlYY/H10bPvM/d8lp9x6OAp
 WDlwaoLwoMG3r6nZjzd2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ngmt3Z+Uk/Y=;GjJj06/tOybXrmbkXQQD9GuRqhT
 sO2qdt49kd0pj0B3UqF3qXMUnZlt9FdmsO0/YAvW3nJhdtqdpAVrWmIsYepx+UYqJKqQb4ncQ
 scrTjT1id0MRN+kXuiXcT6yWv/FQgJ97nWALHejHnaLxYpF03mMqMvCemqspmYdwHgv4njNH4
 XGaFH2LGhL4HLsmnO3GCYZhe+4Fpr5tKsulq4uMjf8yxAsDXILwnNcqOlBuRCX1U6BPCfuofZ
 kHpUifiZDfAeTbYK2vkpt3d2/+wSpjOxYvlNNYbjzF1sMrViKUYOnKB6r6QjF3wkZSUN2S/mJ
 hfCH3W2gaLyxdaNe/OyA54S2Pgh9NV+UnJLur0BTJ44zzp+E0TCKdy69fMq5FsNl755+0XNmp
 BA7jheT7dNGOqf/VSSomHAQ2LqM7BlJHEkhZaAnIj61jvH2Fab5GmzOPpumvnrLImiyMBUAlL
 hkCJR+gAl9aO4JScPPtOeeTKjBJ0Cd1YSSLOdmF7mwDXfQWJzS+eXR5KGlG02zCesz3LHqyzV
 N8EgbGM7u06pQzpwil0FaEWeYvZPO4ELxsrB5iKrnaDAbFCKHX+qG0bD+xCk2JAVaTPxm0vMI
 y/C90sP3IqGx4/ag7XI1vGJnUuTh3T7Y1JhqwdIk6+ltSUzl+bdW1vVK3NlUglo/BXIahRPnR
 fYRYV1c+8H0284K4DpoqblGSN3NpMghUNom2a9shPtoAfAZdia7Bz3QnvLM6DfhxUJyrThNmV
 VqohG1TzKjet+Tc562jFdULsNtJ3Cr57naTu0xroS30eQBHBEkKPmCH5HaeYf+ktG6QejgSLH
 f6qj1sppuq+67bhEZfiCpcyQ==

Hi,

Recently I'm working on migrating btrfs_buffered_write() to utilize
write_begin() and write_end() callbacks.

Currently only the following filesystems really utilizing that pointer:

- bcachefs
   Which is a structure of 24 bytes without any extra pointer.

- f2fs (for compression)
   Which is holding a pointer to an array of pages.

- ext4
   Only utilize that pointer as a flag for ext4_da_write_begin()

- ocfs2
   This a large structure holding a lot of things

- (Future) btrfs
   Only holds a pointer and a bool.
   (Also needs a way to pass ki_flags to support IOCB_NOWAIT though)

Thus I'm wondering should we make perform_generic_write() to accept a
*fsdata pointer, other than making write_begin() to allocate one.
So that we only need to allocate the memory (or use the on-stack one)
once per write, other than once per folio.

This will cause no change to f2fs/ext4, but should benefit
ocfs2/bcachefs and of-course btrfs.

Or is there some special corner case that relies on the current behavior?

Thanks,
Qu

