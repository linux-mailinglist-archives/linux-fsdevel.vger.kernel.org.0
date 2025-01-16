Return-Path: <linux-fsdevel+bounces-39394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2921A1382D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92E81883304
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96DD1DC1A7;
	Thu, 16 Jan 2025 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="HHoZjXrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F41DE2C1;
	Thu, 16 Jan 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024155; cv=none; b=it1S6mWIwzBobfr3HGErZuJ0y6njxMZ4q7jqqlXeznSA6sr7GbF+zgs8SDz3ED7RHxdbhQAqtD6CpXkPeJuAQsQk0U6la1zVGBj1XyxZ3smOeK3DJsRIfCahAaAHYG9eSzDVC8dXzf0zId0K3WrU+XGVwmKO8/9POKbwRNfz4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024155; c=relaxed/simple;
	bh=ljXBir+tkLebuBt+s45VSYcoQpH6xDCBYRxZiTZ+OFc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LbTZR4lpkDAUopMwu6WVtRGHqFHl5CF5XfoBuE3Bvq96Jj+MNJAVmri9p1Bz2L9gnXYVNZ4l9CC1Ssuz7Pgy9vATQ4RZGEPMNmOYCfDVVO39IEu7LfwQfCY2eabcH60HXU+ls+HjnG30q5+vj/xyFnyhI5ybBXwmH6oA28CvYdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=HHoZjXrx; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1737024100;
	bh=AEphY/1E0HRc4k+GBMGTxIDD2L00khOeccwQ8JjbQSM=;
	h=Mime-Version:Subject:From:Date:Message-Id:To;
	b=HHoZjXrxYND4wG52vjCgfopMJa5TX4Z4tAVEf2WDcs4aZL+mxf6x4jHrdJp13v0WT
	 owEWm3HiNzRPD1iKd/l78y+cVq0WHYJ0KfmKsnOxk0CjU9OnoXm+HdqLg0vyPGgyjg
	 51UQCO51ccZM2pMH+ns0T7+8z2KLxqcJwqDiT7J0=
X-QQ-mid: bizesmtp86t1737024098t6lrccvf
X-QQ-Originating-IP: BgU6dV1YvkbvRUVkEBEfVQE+oNOxQGxdHvWGJ35CHcw=
Received: from smtpclient.apple ( [202.120.235.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Jan 2025 18:41:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8883258136914962534
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
From: Kun Hu <huk23@m.fudan.edu.cn>
In-Reply-To: <CAHc6FU63eqRqUnrPz0JHJdenfsCTWLgagX+2zywHNTcFoZA8XQ@mail.gmail.com>
Date: Thu, 16 Jan 2025 18:41:26 +0800
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 Andrew Price <anprice@redhat.com>,
 viro@zeniv.linux.org.uk,
 brauner@kernel.org,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 gfs2@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <A184824F-B892-46D3-B086-556E9ACF4EA0@m.fudan.edu.cn>
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn>
 <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn>
 <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
 <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn>
 <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
 <CAHc6FU63eqRqUnrPz0JHJdenfsCTWLgagX+2zywHNTcFoZA8XQ@mail.gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NKqGW3WLFcbJOFYTed2wCI7In8kFqDmSvnZFdINycmkc69HHDSurUUuP
	asbZz5wn5UQzqoC1rppVqE/5w9vzvbzNGKptP1qVZKQvO1qsULZ0ULvj5Z7OwsO10zUueSG
	fo0mj/Hr6xaIo1Jhb1pTKhM9qj3akCSFynut50y4LBiM3e3ogvcxgHJ1IEkc2AVeBRmofnw
	+qyIp7jstQehuT2QuTuZX3LMuVlimm2AoX9/vUbkKa8T3jjjIKoixo3uWRzrf76oUjOL/pT
	ZOW9Elv98ZjqxPFkVIc4cWUiaD7pM81/Y2HqvhZ4gBPtGCDz7RefeG9FlrQZhGxWkRdy3lM
	XRx3ERRzqCSomZfJR71lQuCMSuZ/6G3LLWJRopOe4C29Yg/HCMzi243vlGOOY+2oCyuHmHL
	v8lKHFlBr65TteYa52Jz5onzcKYc6E+ZHTZ2CCR6Rai1QpGn9EcgDaOIGOF3dEQw1kKSB04
	YIn9kPkdPLv0/od4lx4/s8ZLFKznIAi0chN1zH3OeVyXxrJCZSOexv6mKCk1VlTT33vDb/J
	49gPoPC0tUcHI/yl3PeoJDEELdGrbdRz00CqStMf6as4IKKdBUR6LNe1mSaQdSwqDvj5rAF
	4lLkQL/fZzCAp1OIbnoYQUa9sWinz5IE91XM2R7A78GJ1fkobYoOnp9t8eOWf2PIa5SNFj8
	2Vf6I5YneTmHNU+NywkM1YZPGbteO5CUi8dNfPTVPQdhHTvN8AU6Qw9d8SbN6bOlYBzlvw5
	IsYs3dTbGpUkJ3alxkfCXEawv4C8XfRQdB6RjIlJZz5re3+8XHItHHsBVuUNtcRXi29ZWBc
	tkdb01WGa2zOzL1F4qEOdR0cWwbDJrU3RQoXqfvEEaOOvwUegvr9IyENNpdq/bZBORnKWIY
	SYOsfJwPuaNb7FP84ygPYRfstX5cHu3C4umXcBEFDybC/RkvrOi8ljaqjng2Rtwr9/JZnVY
	/TqhLRnxtvT0sqvaiYCXKMkEy0azTl5duNpg0VxcvQoCEKv1Ivf5H6tPx
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B41=E6=9C=8815=E6=97=A5 02:05=EF=BC=8CAndreas Gruenbacher =
<agruenba@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, Jan 13, 2025 at 5:12=E2=80=AFPM Andrew Price =
<anprice@redhat.com> wrote:
>> On 13/01/2025 15:54, Kun Hu wrote:
>>>=20
>>>>=20
>>>> 32generated_program.c memory maps the filesystem image, mounts it, =
and
>>>> then modifies it through the memory map. It's those modifications =
that
>>>> cause gfs2 to crash, so the test case is invalid.
>>>>=20
>>>> Is disabling CONFIG_BLK_DEV_WRITE_MOUNTED supposed to prevent that? =
If
>>>> so, then it doesn't seem to be working.
>>>>=20
>>>> Thanks,
>>>> Andreas
>>>=20
>>>=20
>>>>  We have reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED =
disabled to obtain the same crash log. The new crash log, along with C =
and Syzlang reproducers are provided below:
>>>=20
>>>> Crash log: =
https://drive.google.com/file/d/1FiCgo05oPheAt4sDQzRYTQwl0-CY6rvi/view?usp=
=3Dsharing
>>>> C reproducer: =
https://drive.google.com/file/d/1TTR9cquaJcMYER6vtYUGh3gOn_mROME4/view?usp=
=3Dsharing
>>>> Syzlang reproducer: =
https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=
=3Dsharing
>>>=20
>>> Hi Andreas,
>>>=20
>>> As per Jan's suggestion, we=E2=80=99ve successfully reproduced the =
crash with CONFIG_BLK_DEV_WRITE_MOUNTED disabled. Should you require us =
to test this issue again, we are happy to do so.
>>>=20
>> FWIW the reproducer boils down to
>>=20
>>   #include <fcntl.h>
>>   #include <unistd.h>
>>   #include <sys/ioctl.h>
>>   #include <linux/fs.h>
>>=20
>>   /*
>>      mkfs.gfs2 -b 2048 -p lock_nolock $DEV
>>      mount $DEV $MNT
>>      cd $MNT
>>      /path/to/this_test
>>    */
>>   int main(void)
>>   {
>>           unsigned flag =3D FS_JOURNAL_DATA_FL;
>>           char buf[4102] =3D {0};
>>           int fd;
>>=20
>>           /* Error checking omitted for clarity */
>>           fd =3D open("f", O_CREAT|O_RDWR);
>>           write(fd, buf, sizeof(buf));
>>           ioctl(fd, FS_IOC_SETFLAGS, &flag);
>>           write(fd, buf, sizeof(buf)); /* boom */
>>           close(fd);
>>           return 0;
>>   }
>>=20
>> So it's switching the file to journaled data mode between two writes.
>>=20
>> The size of the writes seems to be relevant and the fs needs to be
>> created with a 2K block size (I'm guessing it could reproduce with =
other
>> combinations).

Hi Andy,

Thanks for the reporting. I was unable to run the C reproducer you =
provided. I still reproduced the issue using syscall reproducer provided =
by syzkaller.

Thanks,

>=20
> I've posted a fix and pushed it to for-next:
>=20
> =
https://lore.kernel.org/gfs2/20250114175949.1196275-1-agruenba@redhat.com/=

>=20
> Thanks for reporting!
>=20
> Andreas

> Syzlang reproducer: =
https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT_yn-tzm6NqmcEW-/view?usp=
=3Dsharing

Hi Andreas,

Thank you for the patch. I tested it using the syscall reproducer and =
was still able to reproduce the issue.

Crash log: Link: =
https://github.com/pghk13/Kernel-Bug/blob/main/0103_6.13rc5_%E6%9C%AA%E6%8=
A%A5%E5%91%8A/%E5%AE%8C%E5%85%A8%E6%97%A0%E8%AE%B0%E5%BD%95/32-KASAN_%20sl=
ab-out-of-bounds%20Write%20in%20__bh_read/crashlog_0116_rc7%2Bpatch.txt

Could you confirm if the patch is intended to fully resolve this issue, =
or if additional changes might be required?

=E2=80=94=E2=80=94=E2=80=94
Thanks,
Kun Hu



