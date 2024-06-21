Return-Path: <linux-fsdevel+bounces-22124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E91912B5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86791C21BD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18431607A1;
	Fri, 21 Jun 2024 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="dGyJ89S3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A07208C4;
	Fri, 21 Jun 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987433; cv=none; b=fFaD7wztPvbJWv9Bc3QWSkJl0NZSZ1Ex2/6kK5m5H/HXJcFv7qQ6Hkb2cr7Rgp8XXJCKRkXyppmbqmKNwJGFlrwHZHqLlKfR0rDJHOliuiuXnmRB0Ydyi7Df55+cmlht2+KxawOguZ6TVx4Tod5CNnatjJdituHvLOUG8zFnsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987433; c=relaxed/simple;
	bh=TaVSF8Wo6axT8++84WQ+MyVXhldB4MqulOKt1aiG610=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVEQZhqgc6AweIvkCDJCFyarbcmms7jWLTsNESDuPc5qlU4BjCNRBcM7gZxnXAy2lXugJE7Xyq4jv9seU1rmqLi+FhSFod+JWyIzK29hnhosaniGNUeOc6DrCeIzgfxTqn9jpHTLuxbRBmdAnFbxCXuMWIRM5YojOxvNbr2Dd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=dGyJ89S3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1718987346; x=1719592146; i=deller@gmx.de;
	bh=TaVSF8Wo6axT8++84WQ+MyVXhldB4MqulOKt1aiG610=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dGyJ89S3Mtnb3qCeqKQ7dNrV2AX+MBvXvpFOS5qdU5StBNeSfBhj3npOOzwCrL2I
	 OWu4Iw7nLS7C7FqGCqb9jP0mHnSAWNDp/B7oOpqNyH+7RhIwXCY7R/TwxqQG61hYm
	 /IvwIpeBjt0GepWOMNkDAIUg6eRs65R2+nmi0nxpCsYyDq2gK2tPySnYyWpVG8S43
	 ZvQEf501RrASQFyXuehQg5sXe2oBtvJ5uLn25WBdeSp2PKuSAq3KMcugDsB48Eqww
	 CywDG9/PCKvur0T1ok3M2r3j5b7JRp7HrudYWXhNrBq8o2LuvA8pkp74qNhDfJjtS
	 rCoZwjkgBr8NtnIQgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.63.133]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1srq1Z2d4N-00ddIK; Fri, 21
 Jun 2024 18:29:06 +0200
Message-ID: <cd7fdd76-8da0-4d43-9d1c-c93aed4c0f5d@gmx.de>
Date: Fri, 21 Jun 2024 18:28:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] parisc: use generic sys_fanotify_mark
 implementation
To: Arnd Bergmann <arnd@arndb.de>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Brian Cain <bcain@quicinc.com>, linux-hexagon@vger.kernel.org,
 guoren <guoren@kernel.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Xi Ruoyao <libc-alpha@sourceware.org>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 LTP List <ltp@lists.linux.it>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-8-arnd@kernel.org>
 <e80809ba-ee81-47a5-9b08-54b11f118a78@gmx.de>
 <1537113c4396cd043a08a72bdca80cccfa2d54d9.camel@physik.fu-berlin.de>
 <ba14c4fb-e6a7-46b3-a030-081482264a99@app.fastmail.com>
 <a623c1979ac494d01977abe6dfc22e8381dc6e4f.camel@physik.fu-berlin.de>
 <83613d85-53f9-4644-be68-4f438abe2e52@app.fastmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <83613d85-53f9-4644-be68-4f438abe2e52@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qzcGugqMcbMY+YWYJmVsNMJLSzXL1IFC+qPqRPEqwIjeHu1j8dW
 eKrd9zTKO8WqTBd1atZ9gk73fhgOsLFzmyt55jQz2EE0lv7OLTEi8eH1tERMhO+XealwSx1
 UGgBBAPSpMfKRXJChZsTA9t/N/bEd9WMNnHEwTU1TsTs3cyh1vRWNfUsERYHddYMxe16B2C
 4cE95QxNZt3dO/ZdT1fcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qkvA0SU8VBk=;7/QatZvg+BRxv1QkYdIagec8md0
 /gpUIUeNoh2h5Zc2DzrKSZAqUU/Uw+GnsiaAaeHEHI+myLKBBKPB0CZ4PI9GoNYcjlvRwC+Dt
 cj4SKrgECYJdrasgoF20T9r9P8F4BOUJuHY7LfSfBt6aBQXc93SxHPI1b2yssJl0RJaoaYxmY
 oLb2/KG/hDplIAs8CJ6xU8ciG5YfyKU1j1+jkWw1MQPFc3+e4aIxLiTSvFRncW/p38cwcMayq
 jza45P6I18yIb0lDFwYxfYx7JtvcYmz49tEM+mRNWRo0sqZOKrDutFk2bIfcxantsC9mqHxQs
 5a3j94hFYF0GycjrDV+oesj7qYVBuU6oYunEsd60beMeznHHR3ImzBXx0U+lZ1yg5DwK5B7CI
 QesCueVCEB/qYbWnjOn2wcuR9pB1PIHB4z/V43nmRFpwUH1vi3CFARq2AflaUsICu5nwLy9Xf
 Qkf/FIQ2HAWc3Nz8D7NpxmuEdmmXn1uUlfNkFMEIMvZS08xsLcvFw7HawfxyG3k0NSKzQBLpm
 ja62fYS6SAKuF+UBiwKzX5eFg26Sbjq3sh26tyiYHSDDdClW4X5tok+KvIYORgrjWs4GT9uCM
 6aaMHjRJ+tik9fPg2gVvQPbCJ7BZasXiujTtGovW47pMTNieoSrWh7Q3faXOlVgg6VgWPvFQn
 dRdHVRBA7/oVEYpoz4lYuxsnHQfksXpjaFITA0DK0Gs+syZDYB8Aqpcri4MPk01+eWrlM5X8c
 1YVFCGgstmmLXXu2b3Sj6ehNnDt85oZyT/Iy1bR4HWd48jJY/zu80u6vzoZmdVbwkKjEt+2ip
 ExQiXgsj0tPfrUnUe2j3FBUQbV3FxfoNfx2osTCe+13E8=

On 6/21/24 11:52, Arnd Bergmann wrote:
> On Fri, Jun 21, 2024, at 11:03, John Paul Adrian Glaubitz wrote:
>> On Fri, 2024-06-21 at 10:56 +0200, Arnd Bergmann wrote:
>>> Feel free to pick up the sh patch directly, I'll just merge whatever
>>> is left in the end. I mainly want to ensure we can get all the bugfixe=
s
>>> done for v6.10 so I can build my longer cleanup series on top of it
>>> for 6.11.
>>
>> This series is still for 6.10?
>
> Yes, these are all the bugfixes that I think we want to backport
> to stable kernels, so it makes sense to merge them as quickly as
> possible. The actual stuff I'm working on will come as soon as
> I have it in a state for public review and won't need to be
> backported.

Ah, OK.... in that case would you please keep the two parisc
patches in your git tree? I didn't plan to send a new pull
request during v6.10, so it's easier for me if you keep them
and send them together with your other remaining patches.
(I'll drop them now from the parisc tree)

I tested both patches, so you may add:
Tested-by: Helge Deller <deller@gmx.de>
Acked-by: Helge Deller <deller@gmx.de>

Thank you!
Helge

