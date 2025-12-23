Return-Path: <linux-fsdevel+bounces-71985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E700CD9B7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 15:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E0FC3026B2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17C82737FC;
	Tue, 23 Dec 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtcTCvEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AEF258EC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766501345; cv=none; b=iqOD47/tuTXyXQmZtXj+0FI4IAxh3E/qNi/9ce/ZmKcuEbGS2c0gMRhvhoJJRgUsj42Y383A9ZLIBPK47l4+UPP/nwKuEHRWVUCWBBZYWaeE9p/WXv02MY14Ws1z2LA8QnolSTXC/6+m51iLRkhZtJX8whVPMe2KgIBeRnn2jT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766501345; c=relaxed/simple;
	bh=ufSnxcyP8EQ3M5HUHlTgXBfSdwRRBuJgHdT4xDWQ/W0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXn56RhQJJIuMZ1e2FBR2fqwjDAnyimVny0+hf/tY3qDYcueqULHgPkRIcvTETzylEsor0VwCrwORMhjGnWf1gRm2WSSMt3rllp7R/c7bRx5/ivQKey6oo0ZWQBVE/iY674rrASZx8BeSVmRa3dra/9RV8c4OfIhdTDJctgXybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtcTCvEJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so6869349a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 06:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766501342; x=1767106142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFfROU2c7Qq+368iXNodvvI4Bi1Q7qmgRcOhzYiDkmE=;
        b=YtcTCvEJkrCE8TYS+tQS2AeHaz3/GxJzL+jeCaqsMgZ3WBlA1g6bIM1BpTQ6POzQJs
         /iqp3teHvI6KDdDixBhKSgW9b9O+H0Lu/rAci6fLa4SWWrY8KUIRnlIX4mdfX8UXUXuY
         J+GpimC21/7KVD6mJZO61C9AOsoZ7hOpb2Q9d+f80v28yHtVJmLuhag0ysubs0fK7tw5
         86jR+IzeUHShh+xV54MjEvzVasplY4PzqNDI59GGAwuBXkmbdJED5eDFWaO0UpphzP39
         XgdJISJudS7tWlV2VJS5szsoKHoQmMaRO8minL3fPBFj/eJ0Yo3pZAKMm0lBJcvbCkBt
         D8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766501342; x=1767106142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JFfROU2c7Qq+368iXNodvvI4Bi1Q7qmgRcOhzYiDkmE=;
        b=kClWngiIqo7pHA5lYtiyIKDHnMWKQgZCT+cQz6zteAPZxExbWSHrxBUUvPW6d8JNms
         Obx7Jql+xg/lw8B9ifFW4vol/s+uFQkk2IpuX9c51OyNT4w178OdUPc7tiIem2wOl28K
         655OR18XehHihJ5u8Q/xJSJEBqcUouM/qO1aa3wQAQ7NOQJmXVkpqmDqae3E/RitqcDs
         5lcmy8lmmgC2jvJQlLfwiLAyL0Rt1Q3qKKtl5HSWyLY4VlQdvDPJr37DQiTrZcV35Odj
         Yjp0y3OK4skUjFA0p1KsyFyx+4JrzAyF+u+xqyxCWxemjFeGcMRhn7Pi+iuwBr1+t9n8
         XCpg==
X-Forwarded-Encrypted: i=1; AJvYcCXzHxT1uWs8I+/dVdsmWdpzkFhJK9JrqKY/LMCtC+KTL6Cewe9zLbRM1E67V39xzX8PCFdKBzVktcOjm0b4@vger.kernel.org
X-Gm-Message-State: AOJu0YyV80T8f/9LY5HtG2dYA2+pypPM6yW+aCC4Y113RQejGTv9NnrL
	Q9/jM/kjOKu3yH/mwnnLdTED0D33ZhQnUmhgiIOOkSQELEnxspC9S7xJjuvfIcyRx9AgC3ye8FI
	rhd38QaxETGZxeps7uB8oKAS8LKUM/VY=
X-Gm-Gg: AY/fxX6xCa/AJ08oyD9l06+zBnSHyEGAIdid+vN6ZVwgdN8vn8PHQ3Yx2auXI81qPEk
	qIt7ML610duLwn2aMhw+VhBP6bm+0ZoKDVqMx8Zty6sAEOeYRTpNHotBI0BITolu5kb5mmzAYPV
	x+fmDGrqg6bMKaRlr17RoClrFVr8OFVfebPQp1rCFqGa2094w+s7jsqDvHKn2Wuwe3juGpXoC56
	JKz0wWJ+H7GgA5dWOIgxtH/LMb51dGLOcq0ITUuEAVmY6KR/hvDSp1z1qMDaLDQ4IVDbT+BE69T
	9yh1m2yhIa3mCqGzxQqVs61I5DBF76Rc40iSZpXb
X-Google-Smtp-Source: AGHT+IHuG4Zlty0EBY8cSlYcxfsFprBgXJUV1JABoiLxrZSBt9aqmgn78+Moy6YnKpfKdeTiIVEtCIBURTefrpkDT6c=
X-Received: by 2002:a05:6402:350e:b0:64b:6271:4e1e with SMTP id
 4fb4d7f45d1cf-64b8ec6a5abmr14975028a12.17.1766501341335; Tue, 23 Dec 2025
 06:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGzaKqnw+218VAa_L-XfzcrzivV31R-OdAO1xjAT1p_Boi94dg@mail.gmail.com>
In-Reply-To: <CAGzaKqnw+218VAa_L-XfzcrzivV31R-OdAO1xjAT1p_Boi94dg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Dec 2025 15:48:50 +0100
X-Gm-Features: AQt7F2rgYvQriINDbMIOLXV5v6UkW93ByYRMm5lGx4qb6_3NEkWXdvCpPojfviY
Message-ID: <CAOQ4uxi505WQB1E1dSYXcVGf9b5=HT-Cz55FMNw5RxnE=ww2yA@mail.gmail.com>
Subject: Re: overlay unionmount failed when a long path is set
To: Kun Wang <kunwan@redhat.com>, Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Zirong Lang <zlang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 3:25=E2=80=AFPM Kun Wang <kunwan@redhat.com> wrote:
>
> Hi,
>
> This issue was found when I was doing overlayfs test on RHEL10 using unio=
nmount-test-suite. Confirmed upstream kernel got the same problem after doi=
ng the same test on the latest version with latest xfstests and unionmount-=
testsuite.
> [root@dell-per660-12-vm-01 xfstests]# uname -r
> 6.19.0-rc2+
>
> This issue only occurs when new mount API is on, some test cases in union=
mount test-suite start to fail like below after I set a long-name(longer th=
an 12 characters)  test dir:
>
> [root@dell-per660 xfstests]# ./check -overlay overlay/103
> FSTYP         -- overlay
> PLATFORM      -- Linux/x86_64 dell-per660-12-vm-01 6.19.0-rc2+ #1 SMP PRE=
EMPT_DYNAMIC Tue Dec 23 03:56:43 EST 2025
> MKFS_OPTIONS  -- /123456789abc
> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /123456789abc /=
123456789abc/ovl-mnt
>
> overlay/103        - output mismatch (see /root/xfstests/results//overlay=
/103.out.bad)
>     --- tests/overlay/103.out   2025-12-23 05:30:37.467387962 -0500
>     +++ /root/xfstests/results//overlay/103.out.bad     2025-12-23 05:44:=
53.414195538 -0500
>     @@ -1,2 +1,17 @@
>      QA output created by 103
>     +mount: /123456789abc/union/m: wrong fs type, bad option, bad superbl=
ock on overlay, missing codepage or helper program, or other error.
>     +       dmesg(1) may have more information after failed mount system =
call.
>     +Traceback (most recent call last):
>     +  File "/root/unionmount-testsuite/./run", line 362, in <module>
>     +    func(ctx)
>     +  File "/root/unionmount-testsuite/tests/rename-file.py", line 96, i=
n subtest_7
>     ...
>     (Run 'diff -u /root/xfstests/tests/overlay/103.out /root/xfstests/res=
ults//overlay/103.out.bad'  to see the entire diff)
> Ran: overlay/103
> Failures: overlay/103
> Failed 1 of 1 tests
>
> So I looked into unionmount-testsuite, and picked out the cmdline reprodu=
cer for this issue:
>
> //make a long name test dir and multiple lower later dir init//
> [root@dell-per660 xfstests]# mkdir -p /123456789abcdefgh/l{0..11}
> [root@dell-per660 xfstests]# mkdir /123456789abcdefgh/u /123456789abcdefg=
h/m /123456789abcdefgh/w
> [root@dell-per660 xfstests]# ls /123456789abcdefgh/
> l0  l1  l10  l11   l2  l3  l4  l5  l6  l7  l8  l9  m  u  w
>
> //do overlay unionmount with below cmd will tigger the issue://
> [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcdefgh/=
m -orw,index=3Don,redirect_dir=3Don -olowerdir=3D/123456789abcdefgh/l1:/123=
456789abcdefgh/l2:/123456789abcdefgh/l3:/123456789abcdefgh/l4:/123456789abc=
defgh/l5:/123456789abcdefgh/l6:/123456789abcdefgh/l7:/123456789abcdefgh/l8:=
/123456789abcdefgh/l9:/123456789abcdefgh/l10:/123456789abcdefgh/l11:/123456=
789abcdefgh/l0,upperdir=3D/123456789abcdefgh/u,workdir=3D/123456789abcdefgh=
/w
>
> mount: /123456789abcdefgh/m: wrong fs type, bad option, bad superblock on=
 overlay, missing codepage or helper program, or other error.
>        dmesg(1) may have more information after failed mount system call.
>
> //If I reduce the length of test dir name by 1 character, the mount will =
success://
> [root@dell-per660 xfstests]# cp /123456789abcdefgh /123456789abcdefg -r
> [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcdefg/m=
 -orw,index=3Don,redirect_dir=3Don -olowerdir=3D/123456789abcdefg/l1:/12345=
6789abcdefg/l2:/123456789abcdefg/l3:/123456789abcdefg/l4:/123456789abcdefg/=
l5:/123456789abcdefg/l6:/123456789abcdefg/l7:/123456789abcdefg/l8:/12345678=
9abcdefg/l9:/123456789abcdefg/l10:/123456789abcdefg/l11:/123456789abcdefg/l=
0,upperdir=3D/123456789abcdefg/u,workdir=3D/123456789abcdefg/w
> [root@dell-per660 xfstests]# df -h | grep overlay
> overlay          57G   29G   28G  52% /123456789abcdefg/m
>
>  //If force using mount2 api, the mount will be good too://
> [root@dell-per660 xfstests]# export LIBMOUNT_FORCE_MOUNT2=3Dalways
> [root@dell-per660 xfstests]# mount -t overlay overlay /123456789abcdefgh/=
m -orw,index=3Don,redirect_dir=3Don -olowerdir=3D/123456789abcdefgh/l1:/123=
456789abcdefgh/l2:/123456789abcdefgh/l3:/123456789abcdefgh/l4:/123456789abc=
defgh/l5:/123456789abcdefgh/l6:/123456789abcdefgh/l7:/123456789abcdefgh/l8:=
/123456789abcdefgh/l9:/123456789abcdefgh/l10:/123456789abcdefgh/l11:/123456=
789abcdefgh/l0,upperdir=3D/123456789abcdefgh/u,workdir=3D/123456789abcdefgh=
/w
> [root@dell-per660 xfstests]# df -h | grep overlay
> overlay          57G   29G   28G  52% /123456789abcdefg/m
> overlay          57G   29G   28G  52% /123456789abcdefgh/m
>
> So I don't think this unionmount cmd had reached the limit of param lengt=
h, since it's working with the old mount API.
> Then maybe a kernel bug needs to be fixed..

Hi Kun,

Thanks for reporting this issue.

We've had several issues with systems that are upgraded to linmount
that uses new mount API by default.

FYI, the lowerdir+ mount option was added exactly to avoid these sorts
of limits, but that will require changing applications (like unionmount
testsuite) to use this more scalable mount options or require libmount
to automatically parse and convert a long lowerdir=3D mount option to
smaller lowerdir+=3D mount options.

Christian,

Do you remember seeing this phenomenon when working on the new mount API?
I might have known about it and forgot...

Thanks,
Amir.

