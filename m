Return-Path: <linux-fsdevel+bounces-3876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C37F988F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4486A280E85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 05:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA32A5663;
	Mon, 27 Nov 2023 05:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JBZAqiCR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3213A131;
	Sun, 26 Nov 2023 21:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701061846; x=1701666646; i=quwenruo.btrfs@gmx.com;
	bh=XcdFJcpkxmmR77v6KlNlZpmMrmuNub8Ji5+Dg+2spRE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JBZAqiCRHHCnrNHD56nMu5C2jK4QjCcYIHXOdEttdcuKOxQmQiVWlgxaZM60iRm6
	 i/cA3QOCnNFkt4+OuveECvi39zYmMRoz8ZSowjjc6qzAUY98oQnLZSE9vRapFNEi2
	 MQXLoOgmaiRL9WPw1sQthAmzphlrZMDnBbIoCKZxPVdMiik2B541yOu2B9NCWhzA8
	 InA0PE8SNk5NnffgOE6kv4bwrriR6F2oVMuVm4joLg3jHftFa/xTcrcvYkV5lxQN0
	 ZWGHrT5UXMgQk023oQoAOq+wU+66ItAl8LbEcg79bv5kDHGO+lubiRSAUTtAdZxlo
	 c/VdKQsipJinOBRqjw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXQF-1qpftK1QrH-00JXUP; Mon, 27
 Nov 2023 06:10:45 +0100
Message-ID: <793cd840-49cb-4458-9137-30f899100870@gmx.com>
Date: Mon, 27 Nov 2023 15:40:41 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Should we still go __GFP_NOFAIL? (Was Re: [PATCH] btrfs: refactor
 alloc_extent_buffer() to allocate-then-attach method)
Content-Language: en-US
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <ffeb6b667a9ff0cf161f7dcd82899114782c0834.1700609426.git.wqu@suse.com>
 <20231122143815.GD11264@twin.jikos.cz>
 <71d723c9-8f36-4fd1-bea7-7d962da465e2@gmx.com>
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
In-Reply-To: <71d723c9-8f36-4fd1-bea7-7d962da465e2@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HA71Waw9i/Kr/7bDfxY3jfGsB3LMGT6HC5tBFOCNG/0iKKowOMc
 xL9EGL6tjpkghIUxxGTOq9pGVPBrOFkNFVpCypmO2BXX1S1v+M/WfUzHr371AgPu91/t5Mp
 w8GRG01lhX0uXn5prfqcC0c1EH1dDSuKW2a/YVqBqaN13/py4u3FNbiiuCF5akz2Bo3yydv
 I/yV/iRtjEv8cgSnjxyyw==
UI-OutboundReport: notjunk:1;M01:P0:jt0p9G6uRFM=;KmKkmfu+f3CvqRP+2bKHm7D6YRv
 nTg7fk5x7igfzt+4juNLbOyewDtYQu9HPFXlr611cy8mz2vh5OgQ34uZVEW6rpPr0Ul3dqRgq
 QD5M4w5CoLckY9Bs7NGO83qddDZLiD5CoioJ++C8Faf9lGfHZMmRX3if8glSmA7gdarCaPQq1
 ZsxJ4AN+4e8HqIpxXVF1GD9VE4XpTyS8yQcagIKdDSofdFmLCp9ql37OzLxmi4pmRtlrEenRU
 lGT9hBPi2XeO6IZ/AX55t4NB65Lnb2k5VoeFJA7icBVWX8UTrV5/APjz1kTKFrX2ygDwplBWk
 BnM4znjLpJrhFuRDnLdpjiOS3vK1YDwO7tlXxhr2rTThVAg+ge/9qv1GOYYOaPF++vQxZ08I8
 ocUGjJth8ZmaSQW7h/R2YtoLFJBwmSqcFE6lI27S/90J0Lrx4BmC/JBkBjK2sfUgFlAoBnBKW
 KJXXwn2S4E4yF+l088BhJfS3D0bY2+nIv4RXiPPwwKfQtpR/HgxgYs2dcDPa78XlBOqu/h7LR
 nx+7NwSjcLBJMgjx+1+gMjNc07t9p0/0HiY6OwJijtup9jQNyOB8q6T8qb2LcBP4SIEZ21LaM
 +0P0HBZkEI8zOg9j0Ai7jorZSqJ+CxKUwlo2C/qG2w+w+YCDmcBG/+No2+Z/PCcVW2ss5xKrA
 dWGaaYuv1DOLTAdRjKTJkFAMD1YeMeKKfsrguXhiO8lrGmf6f7jxDGvZ+fejo3vg7ARTuxs1Q
 cOp7FBr5JAhyW2zSMJThOwEkaqL2mCUmYkEbT63astubfem+sRT0R9GT9G6gbR/lzCaRzhmdi
 6pD77EV4WsNGF82D2796lrfwMTS6bG0MZzG7IiPSN8pMu9rX92mxXC7eIoBDNTE8Ybbyppu+L
 5M4z25wzTDSDXI9m5ioaane/f87f7vDQ/BvOmU0cq1oCq2YqAbr1aNXoyWNtXTyX7CQtQ6rfB
 XfQUZj30cgmKYqu1lRW2c9Ln9D4=

On 2023/11/23 06:33, Qu Wenruo wrote:
[...]
>> I wonder if we still can keep the __GFP_NOFAIL for the fallback
>> allocation, it's there right now and seems to work on sysmtems under
>> stress and does not cause random failures due to ENOMEM.
>>
> Oh, I forgot the __NOFAIL gfp flags, that's not hard to fix, just
> re-introduce the gfp flags to btrfs_alloc_page_array().

BTW, I think it's a good time to start a new discussion on whether we
should go __GFP_NOFAIL.
(Although I have updated the patch to keep the GFP_NOFAIL behavior)

I totally understand that we need some memory for tree block during
transaction commitment and other critical sections.

And it's not that uncommon to see __GFP_NOFAIL usage in other mainstream
filesystems.

But my concern is, we also have a lot of memory allocation which can
lead to a lot of problems either, like btrfs_csum_one_bio() or even
join_transaction().

I doubt if btrfs (or any other filesystems) would be to blamed if we're
really running out of memory.
Should the memory hungry user space programs to be firstly killed far
before we failed to allocate memory?


Furthermore, at least for btrfs, I don't think we would hit a situation
where memory allocation failure for metadata would lead to any data
corruption.
The worst case is we hit transaction abort, and the fs flips RO.

Thus I'm wondering if we really need __NOFAIL for btrfs?

Thanks,
Qu
>
> Thanks,
> Qu
>

