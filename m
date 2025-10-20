Return-Path: <linux-fsdevel+bounces-64674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723ABF085B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DF3188F03B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF992F6566;
	Mon, 20 Oct 2025 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="H9tW+QCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E051E9919;
	Mon, 20 Oct 2025 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955913; cv=none; b=pWxx9Xopzixbtg9gZxsUv7KUyJplgPXyhKoIts1krwEzi5O7B5h1iNFZPtoRoKT6ZRTrg3E2v77TMn6N4BFanTlXgjYclTz7CGCldH6GQSZJd7HedxsB9zHVC4dYMVDj61YlR5q5ZEgj8Xr8YnNORIWB2cTh4w9n8UxYqcgwsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955913; c=relaxed/simple;
	bh=/Zve6bkcgBEqvJoXtK/GZ/kkL0fvV8wBZmHN5u59lD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWQeDFnhUxgi1Xo8vEHdQ5N6PBpdLoIgEQ2Fo1jPiGkw/0DCugSSv/7MIn/Jqc5d2epLwRQ/3BI+YB1HttZ1JrRS0gBREwF/OmlXorBKQqMaw6w0kvHiWIyyaYsd8C//O8MonrXAT7uMCon5GvWjMSedzYUpDfWyHaUU55payAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=H9tW+QCq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1760955897; x=1761560697; i=quwenruo.btrfs@gmx.com;
	bh=kJm1dXRnyQhqp0w4Yx24tOrcduQ3lzKTJEVLYdoc2Ow=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=H9tW+QCqE+J6cbYAHZfeH+JGrQyFi398JrcK5SbMIO7DqSUbNe4ZZWrha/TC4UqR
	 EGpLgbRCGhEFrAP+/PMxt98IeOYLgxU+mHGmwPb19MfComE5sSKve4DQMi1feL/5G
	 f7IBZJBveD7jjgFdBID7mtPBLp5U8KJrkSw8JERktZcNR3wutaTU0sP81xfoo1yHP
	 WpE5XpIjQug6wchReuIV9KL7WUD1mwArHcwnxN//2WkMEkpG6nLByWyWz3tfaf6sr
	 iANyGGgA2Ex/1EMDgZJkRKgsvz3zbf6F+cURCoHkic3dd1LgA1jSkmq1DjMuBl34n
	 t2BILWqMovfhCt9MPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmGP-1uvj1d1MSn-00KvNn; Mon, 20
 Oct 2025 12:24:56 +0200
Message-ID: <acbb5680-ef7d-4908-94f4-b4edb8b3c48e@gmx.com>
Date: Mon, 20 Oct 2025 20:54:49 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, djwong@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, martin.petersen@oracle.com,
 jack@suse.com
References: <aPYIS5rDfXhNNDHP@infradead.org>
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
In-Reply-To: <aPYIS5rDfXhNNDHP@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vzcvH5TqdOAbk9lMJmiAfDz6mitYV+Q5c+q2VDll8LGohgAF72L
 sXd2mrlUvwWZN6iv4yeSIp1SFaA+dfSL7lJ8dNREv7Nsh5AB+VdGVCKaZlqVaY2RDp6BD8K
 WIw7RSiv2sBQQvOg4TG1Hl46JITrbbvxvvl9zR8G0nCFZX+JKFsIRXsSfIHzj3V2i7k2bwD
 oCB6PboRM0/mD3xdRLsRg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wqy/PC2uS/w=;pw7UyQpHT6LC+Se6tY1dg/2HwjW
 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



=E5=9C=A8 2025/10/20 20:30, Christoph Hellwig =E5=86=99=E9=81=93:
> On Mon, Oct 20, 2025 at 07:49:50PM +1030, Qu Wenruo wrote:
>> There is a bug report about that direct IO (and even concurrent buffere=
d
>> IO) can lead to different contents of md-raid.
>=20
> What concurrent buffered I/O?

filemap_get_folio(), for address spaces with STABEL_WRITES, there will=20
be a folio_wait_stable() call to wait for writeback.

But since almost no device (except md-raid56) set that flag, if a folio=20
is still under writeback, XFS/EXT4 can still modify that folio (since=20
it's not locked, just under writeback) for new incoming buffered writes.

>=20
>> It's exactly the situation we fixed for direct IO in commit 968f19c5b1b=
7
>> ("btrfs: always fallback to buffered write if the inode requires
>> checksum"), however we still leave a hole for nodatasum cases.
>>
>> For nodatasum cases we still reuse the bio from direct IO, making it to
>> cause the same problem for RAID1*/5/6 profiles, and results
>> unreliable data contents read from disk, depending on the load balance.
>>
>> Just do not trust any bio from direct IO, and never reuse those bios ev=
en
>> for nodatasum cases. Instead alloc our own bio with newly allocated
>> pages.
>>
>> For direct read, submit that new bio, and at end io time copy the
>> contents to the dio bio.
>> For direct write, copy the contents from the dio bio, then submit the
>> new one.
>=20
> This basically reinvents IOCB_DONTCACHE I/O with duplicate code?

This reminds me the problem that btrfs can not handle DONTCACHE due to=20
its async extents...

I definitely need to address it one day.

>=20
>> Considering the zero-copy direct IO (and the fact XFS/EXT4 even allows
>> modifying the page cache when it's still under writeback) can lead to
>> raid mirror contents mismatch, the 23% performance drop should still be
>> acceptable, and bcachefs is already doing this bouncing behavior.
>=20
> XFS (and EXT4 as well, but I've not tested it) wait for I/O to
> finish before allowing modifications when mapping_stable_writes returns
> true, i.e., when the block device sets BLK_FEAT_STABLE_WRITES, so that
> is fine.

But md-raid1 doesn't set STABLE_WRITES, thus XFS/EXT4 won't wait for=20
write to finish.

Wouldn't that cause two mirrors to differ from each other due to timing=20
difference?

>  Direct I/O is broken, and at least for XFS I have patches
> to force DONTCACHE instead of DIRECT I/O by default in that case, but
> allowing for an opt-out for known applications (e.g. file or storage
> servers).
>=20
> I'll need to rebase them, but I plan to send them out soon together
> with other T10 PI enabling patches.  Sorry, juggling a few too many
> things at the moment.
>=20
>> But still, such performance drop can be very obvious, and performance
>> oriented users (who are very happy running various benchmark tools) are
>> going to notice or even complain.
>=20
> I've unfortunately seen much bigger performance drops with direct I/O an=
d
> PI on fast SSDs, but we still should be safe by default.
>=20
>> Another question is, should we push this behavior to iomap layer so tha=
t other
>> fses can also benefit from it?
>=20
> The right place is above iomap to pick the buffered I/O path instead.

But falling back to buffered IO performance is so miserable that wiped=20
out almost one or more decades of storage performance improvement.

Thanks,
Qu

>=20
> The real question is if we can finally get a version of pin_user_pages
> that prevents user modifications entirely.

