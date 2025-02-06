Return-Path: <linux-fsdevel+bounces-41119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75DA2B36A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 21:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA62F3A56D0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 20:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CBE1D6DA8;
	Thu,  6 Feb 2025 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="cqoeUZtX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4263155757;
	Thu,  6 Feb 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873968; cv=none; b=OnraD3saxjMHIRJl+sdoLRdjui/fu5VRW0MVh94VQnXgOFVHR+jNQCNw3rKmIDrGySp1QRajzhjnfMKPxWBMg57k8U+ELroB+hMOq8jPeGT1H5C4FFQeCgEL+bgZwxJ6Pi6GrZndD6Z/Q9BSpYLUTATXzqxPpNSxzDhoBEq+oog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873968; c=relaxed/simple;
	bh=jYRWPJl3vxi1pMnmu7IOIQOUwElB6wg+kD4zTfe6PWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQLGfmc/LfC2FCQXMkeojnWc+MZ986b/UvvzXLiKVR4YnyN8QyK+USV6I2cnx2TNndm8SjhimC1AGAu1IYnlut0NUykPegG0esCjLlWHl1DuxuTWNUPeijzLb5eyxAVIMbeyzIfIbv8tpcb3ldZPFTrf1qcaj6YdUhv86wb7R9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=cqoeUZtX; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738873964; x=1739478764; i=quwenruo.btrfs@gmx.com;
	bh=9R+2vquaROtNZYSPIBsKoJzoSsjO0LkDiuYj8vkxDSk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cqoeUZtXVpxRRmmPEFKsm7Vq8LoLsMZOl+AxSQGsUgFyIpdlq7jQzb8dBqeZ+LJW
	 2rsbAEnH16aX7R5oZAL/mH5qYF97U0W/rrkFIhnL42M5Pv+IPxUObFCq3no7i6BqL
	 Rnr93Eh3Qlf4u1ScK0a2bB/nly/T2iK+71v/ifAFrwdx5MmZ3kbsZKgXCCzjcd4+l
	 NvGwQyIeQ3Syei29l9836sFUnrtIfd8dV/iwF8VzTf9YPI8zHn0Mvc1ozE4Jhr73G
	 fhgETjenruwUL+GSKg124Tm4VMhAsZPQO9uzTA7QrtgfXUE4wUAnD29n3eNLPHiIR
	 DZGYJCMj8IHeKIrWYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzhjF-1tSqxm2IyH-00zywp; Thu, 06
 Feb 2025 21:32:44 +0100
Message-ID: <cb330b95-b995-429e-aa4c-9fbb75b6c16b@gmx.com>
Date: Fri, 7 Feb 2025 07:02:38 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: always fallback to buffered write if the inode
 requires checksum
To: "hch@infradead.org" <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <e9b8716e2d613cac27e59ceb141f973540f40eef.1738639778.git.wqu@suse.com>
 <Z6TDpRo8ijZUt29d@infradead.org>
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
In-Reply-To: <Z6TDpRo8ijZUt29d@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cRQTi1qJo2eAixYQuee6+vk0gajfHyEYgIXNP1vsdNHKU3ytq8a
 uuB9xsRxXiuELi3fSA5fzYKr7Hx6rM+5u4OJ94Wl93muZSrI9UA0A+iJwlIR0BXkuXBvGnM
 PZbrPlHx62X6f3DrWbj2j/yE3B6HlbEtWzfGoF3GPWbM3IfJDjVaOrvdj9bhTuW7Fp76Lm9
 LonIg80uwC4+gVY29qojA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bAPSaGPjSMM=;A40M8/XugEnMLhwIE8apqxS8O5N
 3QBTqotDk/4kZeHFO5Wm5oBaxOIEjAlGHtKD0mP6XaGeOGE23SWTrUgvJf2MpAGMuTqcXtw/L
 5FhwxZAVsr84W4BekxEfN8yITFXPVi/ZfdD13NvGdZsH1C1TmG8k02uwnFDvh4gab6cct0Fea
 7WQagvc9G2IAjm5AA1kUgEb/p9vq/CVQpAB1jq4w4gZm1HqeRudllErZUMucdHIJHziM9etB/
 rwfTZVQ4kqOXuc0lW5qnVhkIX9zbY5a+gdb9sUaB9at/fpVUt+BtLfgdoPz7qcKL7JZvdnf7N
 J/LjpMES3Am+2x/VVYGsyO67WeS5V6fdX4Iy97hv873jr1aYmHjMM/0pjVoFHyyyvMfJytVMp
 P7T1GeJpaFCJLfTqK04fjJLa1KBinvdLKX2G75qWK72aUc7f2VltyaqYxBhfi0lKvP9sQ6ElP
 NN0x5wtphx0MrB7poE9mMK1lkLerGZR78zEt8iO92SkzUiZG4uQWazuuQyntWAQl8pvhk4UOq
 2nfIePDWsjxRfa4QpaBh9QHUA09Nx4pVRlCNyI3sSlNPw3EFazpmrV/17DmG9HvfTxt7rUKEd
 UlL620vp/g3FmZyuluyGomP5Zm6N6K3Qku+mwpsG7mW8t5DtjEbLQxtRQvtmLZ6nea+FwHfHJ
 lc1BSUrhYvq/khQokQyZ+YEfjkMoSZOLR9p7k0cW/DBGndkflKapZh4cpjjcH1eLzPcJeJjLR
 fTyTkNKlbTMWQ1Uluyb1CxbC1yT4Gs+HJ5tzhKlZJTBXbUUwteb2ehxWLCDb0G5z0J5Y53ZXe
 USfi/FGOHQajFX5iQa2H42vVD+yZhK07XWlv5duCLGGO3ZSOxanlVso3bkCNDDOzAEVnrjEo5
 PKJEzXvsAVmc4dBiI9M4GHzGQFleRHy3MbRlu1nVVD/EF/VcMZmZTjRiO21uQ9IrwHgltCEt7
 ZGe0i5syO+Qh1Q7J9VszAYgb5OOZg/bQmHNQSfLiiRGjSMaxfjqJZvGnwoxhqFA9Y7xko++9B
 7eFySf6XXsOM0g1s22Z9PRwDntHe9oHRLULw44L5xqCDD/XOY4oaOHxu07ShIZ7xTtwLqfxMu
 x/kEC14LL3ePzLZeOjqDDAwjejk8ailB/BL5RClg9/oqo/8am9dAxxeppwmmmsCGtBGY/Addz
 EL60dmVazcyERelHgmdt/7zzZSaGThsxAbBrynlJY8XvlFLrJkH7XL7SMFAuJeWVi2CGVyVgj
 fwYUOZGr2HZl/rsPxXtmCbK9O19T9iIjFhqLv2PQpQwXE0Jq8PSKJ9gZN6Lid3r12HKXrMzpU
 Pm7G0VoJ9nB1ia/HFDDSW+6hPSk80qFxJvdxovdXVK8wmLXFRxMiq4Fvo4Jv3aD7LPYhZC9bC
 lLFUrg6jLFzO7n+d0NQz/tviVloArlFSni+8AbE3IBN4z1exj3mEwgjLwS



=E5=9C=A8 2025/2/7 00:43, hch@infradead.org =E5=86=99=E9=81=93:
> On Tue, Feb 04, 2025 at 02:00:23PM +1030, Qu Wenruo wrote:
>> [BUG]
>> It is a long known bug that VM image on btrfs can lead to data csum
>> mismatch, if the qemu is using direct-io for the image (this is commonl=
y
>> known as cache mode none).
>>
>> [CAUSE]
>> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
>> fs is allowed to dirty/modify the folio even the folio is under
>> writeback (as long as the address space doesn't have AS_STABLE_WRITES
>> flag inherited from the block device).
>
> Btw, can you add an xfstests that reproduces this by modifying pages
> under direct I/O?  That would be really helpful to verify the code when
> we want to turn back on real direct I/O eventually when the VM is fixed
> to prevent the modifications.

Sure, although I'm afraid it will need to be a C program instead.

Thanks,
Qu

