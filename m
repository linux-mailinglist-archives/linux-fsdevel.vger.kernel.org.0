Return-Path: <linux-fsdevel+bounces-2737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD867E83E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 21:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87182812D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 20:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C50A3B794;
	Fri, 10 Nov 2023 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oJPzby8P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F65F2CCDC;
	Fri, 10 Nov 2023 20:37:31 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA52255BB;
	Fri, 10 Nov 2023 12:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1699648624; x=1700253424; i=quwenruo.btrfs@gmx.com;
	bh=qvvS9IGzHxkGirdwRPiNhMStn206GjQsGeSNbw2pTFE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=oJPzby8PuPMHx8rs0WrqERpgeuV50PPyfvJ6Lxi35cQn1knNki3XDJeyrDKjy75k
	 7vO5fzkfPAlmXpVRU1LAlRCUAsGACkmKx2xdx/qn0PKzhegbwvtmzHSfqw3By81uQ
	 YBTyVvbNFwp8YlhqTQfD3ne8PWkiGTG8q+TLpnyflZpPpv3vL30r4XB8+HzahoCv1
	 GptYduIEZJkKlBQoFfqjc31aKh/skTX1XhD7qQ8h2R2TR9/v2QIEDJTC0UskeE9AO
	 z9Le4CIseRiWIWM80LJ9AG/8YyAAsl4A4geO5S1H51PeCydQ+z3yqZEPZhvThYF2d
	 q26RtmmNQHnA2zLURA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6DWi-1r3k6p2Mqu-006bUE; Fri, 10
 Nov 2023 21:37:04 +0100
Message-ID: <9e0559d3-c46f-4da6-8974-3790f1dfd3d8@gmx.com>
Date: Sat, 11 Nov 2023 07:06:56 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix warning in create_pending_snapshot
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>,
 syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000001959d30609bb5d94@google.com>
 <20231110114806.3366681-1-lizhi.xu@windriver.com>
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
In-Reply-To: <20231110114806.3366681-1-lizhi.xu@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:y2/rm13Ua/iLDSuSpKzd8tvhWZy3qsPtOAkEPNOr0ss1SrddNuP
 zRp1UWb+9NeAcgBbykLPcgXZy0BE4cYkvxM248nfjeFNIPQTLsGX37ggZHSwlpCaXM9yOnP
 JHjHVgXB5BYROQp6VbMLuZfIcFz4aexnDjM9E9rtVNMWrtaU7i8Dw+e/rElwye9eYG2uIru
 KjJGlZr7tuqWr1dnA6syw==
UI-OutboundReport: notjunk:1;M01:P0:yKHwl+8Myls=;VKpHpTtmbElCfvWtc7Id7vlTzuB
 UVgrkbIAXd8X+YKC63YSaAw+dhvKPTXnaGBEvX7+LzCa9w00OD1Aefgia2ODF1mYwFftOZNjA
 Wjwr3MdpK2x4uL5QgQ6Z2dAUn+pz3PssCAgc7grLoTsljjO7LIqw3T4Ubeslz4qFEHt4afJ45
 M/RPJYnHXlj0rUsmYHe396gmWPZkyWgwn8K57CtfTyjpnDwe2eto5cogn+sfaGwxrLBboQXI5
 7P0dKVnxgiSCNGqRi2nOJ6/v7j2bsj0hLDhRaZVUsy6arNrZ+PY378ji0hh6PqUz5qMsmSinL
 TSVWPDn2IV3MzoN+XX6W0V3HjmdNZ4KYmTNeEHtFo4h4iCdFl7kysfKYD2gEzxp8irR7p1U5a
 Q5SBHU5IS+V69id4BGFtGw3M6wH9lA38QAGPZS06AJW+dhT6DwXgGzZMOH14KggssZpI5retG
 XEoB/ze8Jejpu3qMeWQxt2+64h6oK6HQilXMP1flUT9W5Tv4ZRrooCYgMAyr44r1sfcgoSHrP
 8zU3pEDaEwyQ2hp5SQl6pwkc6GDRLz+kgNwavgS7QEGf+dSSu3LInnSADPQFiWD+0h0jAQDEI
 3bUaWIB4FwD7Qsr9eFg5Ff7PGhXMwA8AH6nR8nktNBG32AwcIKI5MmcAC72dgagO7qLtd60Gu
 rKsOBAiAb0HVEKnALzf7z/GG9/V6bXFXA3TzSHnM5C/CE7rXAK2YrRO8+dMiegm0ACuz5eUAJ
 aGDhVwDB/bQp3/ErIlmx+OmbR123cA/nFTO5XVrMS+7/4Ou52JDrI/Q0dNXO/fkdMngfqQl4G
 fGYJTl9dj+GNAHRrRM/joXQCf3HZV3EK9MRjN+ZJGOOcvVH6l4aid0UVaR2jK86k1F2zDxwGZ
 pYsVSXR2UfK+BMM5XeKWfSMkLPiHzen15xxV0aqMl0PbdjUetMtgGZtM6KIPcw4SMWpR9OT18
 Dy3RuxY9gm71aMLT5INQ8pg5KUY=



On 2023/11/10 22:18, Lizhi Xu wrote:
> r0 =3D open(&(0x7f0000000080)=3D'./file0\x00', 0x0, 0x0)
> ioctl$BTRFS_IOC_QUOTA_CTL(r0, 0xc0109428, &(0x7f0000000000)=3D{0x1})
> r1 =3D openat$cgroup_ro(0xffffffffffffff9c, &(0x7f0000000100)=3D'blkio.b=
fq.time_recursive\x00', 0x275a, 0x0)
> ioctl$BTRFS_IOC_QGROUP_CREATE(r1, 0x4010942a, &(0x7f0000000640)=3D{0x1, =
0x100})
> r2 =3D openat(0xffffffffffffff9c, &(0x7f0000000500)=3D'.\x00', 0x0, 0x0)
> ioctl$BTRFS_IOC_SNAP_CREATE(r0, 0x50009401, &(0x7f0000000a80)=3D{{r2},
>
>  From the logs, it can be seen that syz can execute to btrfs_ioctl_qgrou=
p_create()
> through two paths.
> Syz enters btrfs_ioctl_qgroup_create() by calling ioctl$BTRFS_IOC_QGROUP=
_CREATE(
> r1, 0x4010942a,&(0x7f000000 640)=3D{0x1, 0x100}) or ioctl$BTRFS_IOC_SNAP=
_CREATE(r0,
> 0x50009401,&(0x7f000000 a80)=3D{r2}," respectively;
>
> The most crucial thing is that when calling ioctl$BTRFS_IOC_QGROUP_CREAT=
E,
> the passed parameter qgroupid value is 256, while BTRFS_FIRST_FREE_OBJEC=
TID
> is also equal to 256, indicating that the passed parameter qgroupid is
> obviously incorrect.

This conclusion looks incorrect to me.

Subvolumes are allowed to have any id in the range
[BTRFS_FIRST_TREE_OBJECTID, BTRFS_LAST_TREE_OBJECTID].

In fact, you can easily create a subvolume with 256 as its subvolumeid.
Just create an empty fs, and create a new subvolume in it, then you got;

	item 11 key (256 ROOT_ITEM 0) itemoff 12961 itemsize 439
		generation 7 root_dirid 256 bytenr 30441472 byte_limit 0 bytes_used 1638=
4
         ...

So it's completely valid.


The root cause is just snapshot creation conflicts with an existing qgroup=
.

Thanks,
Qu
>
> Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmai=
l.com
> Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation"=
)
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> ---
>   fs/btrfs/ioctl.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 752acff2c734..21cf7a7f18ab 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -3799,6 +3799,11 @@ static long btrfs_ioctl_qgroup_create(struct file=
 *file, void __user *arg)
>   		goto out;
>   	}
>
> +	if (sa->create && sa->qgroupid =3D=3D BTRFS_FIRST_FREE_OBJECTID) { > +=
		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
>   	trans =3D btrfs_join_transaction(root);
>   	if (IS_ERR(trans)) {
>   		ret =3D PTR_ERR(trans);

