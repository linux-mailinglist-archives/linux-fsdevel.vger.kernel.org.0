Return-Path: <linux-fsdevel+bounces-30149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6373986FF0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 11:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D8C1F21E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154461AAE2A;
	Thu, 26 Sep 2024 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UD2q5To1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117241A76C3
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 09:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342524; cv=none; b=m1uN6byMJ2gQDvp8sR+aGS/P1qzpRwl9IiOKSQ2aJHaeIIXuVInnvhelmtQCdOhBOVF/HWxmaLfjPpjn0WoISbrCCP5ZGoU9UOnJMq0MVIRzn5Z0ThqBU4ScKCfljLAsdQwjgf+MIF8iY1+IjXQ+ucmbsb5eYb194DwnuBK3m2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342524; c=relaxed/simple;
	bh=LKhIHj0ETErbxJjj4kRd9VJZWUNKiGMYPOeFWmMcE6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebDRZpq0E5KTvhTEUJM7myEJbCm7PnJ0SZMRUKsSFZWBkNgiRKILg8B2N2ouj4tRhqoBYxg9f89Z4GPQpz+krd1Yfm4Y7updVY4QXrawNVVcI04zLVh6oKX+7xZ+l6zuXoSzhE6t5hflJNeBur0lPdogIq6MA3NHJaR5WxhqV9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UD2q5To1; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6c3f12d3930so5737366d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 02:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727342522; x=1727947322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKhIHj0ETErbxJjj4kRd9VJZWUNKiGMYPOeFWmMcE6U=;
        b=UD2q5To12LvTvQTynz3z4JRZrA85EYrj9sONmJx+UruQ3g37m/dFNN5OnFHHYqTtF7
         V6bkp1KWokNv0XIklqZob3H0ioce9s6VSOLHgSAt6OWtAbs3to/5l7jwhZncBK+4Fznx
         VX4hsu4ktOFHZeSt74rp/2tBUHmYq3bgc+u3a/k9tgxxESDDe56EUzPL+Qf6made7G55
         8d4ySPdGEvqjy/IhvRZSIieuQJf4feDMkwjy8wIa+6wMht/Lp4VWNlosjckPvr0X9sfC
         zehjfcLdoEYhkx7Ir3ZnQ0ItvI6ps2RoJ44JsDuPMLm+jYC5FiArflsRXan+npzD8Sz9
         lZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342522; x=1727947322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKhIHj0ETErbxJjj4kRd9VJZWUNKiGMYPOeFWmMcE6U=;
        b=KJr5BeicIfolRbBjlvxXWC5/jAU18xjfj0v+5j8iclljbm1c2CzZSKGDj0kkDut7dD
         Izwp+SVnFixVX5RNXQ2T8UrnAjfb6MAz5mS0gAoD8PfcORCZ24j+qFawSYjlsO/Zw4TS
         AhhJgW87AOBnJv3tabh7p661TiIlCl6r3xtuE0WOnMyyzNHjUUMjeOswy4v4G+IWD2l8
         QTLeIxQbJRRHXY17IoNyEnJ0o6LFZQvpVZFG7giM+AgZleJnsORs/X4Czxlcs/lzG0Kj
         M+1d0KI4BAoxYyCcOxCDg1LqR7ZsWfQUKVapZAtfpRtMtj4ZKMZ1IZUjjb/j7Jo9Dq1O
         c9Og==
X-Forwarded-Encrypted: i=1; AJvYcCVJp7jNDPWYvZyxO3O1/CW1VYoVfJNMcku74BbcF9uM7J++Jn2XRcl+/Au1WJYqaLU7/g3PmIE44ydfGe+T@vger.kernel.org
X-Gm-Message-State: AOJu0YzfXUnp4kHEJQXLKadXXZIguQNG6f5wFJ31GMb64ij/AjwbAsxA
	C+XNM2RgS1ccJk7pLSXgQhokfAJ9NqsdePjiqUtJc02BNxF90FEKtj/jJ/hRW+T39FDMjzjPdNE
	FM3bKQsYnnRgsknu7kyuWlnh2ajs=
X-Google-Smtp-Source: AGHT+IGTGQbxnPkrcXwhC0RHu9JpOHoGPstrY7a/0JZjUnO55Bki5ImivLgmBuODE3d4woKLswJJJ0MSPaMokpOB0Rg=
X-Received: by 2002:a05:6214:3a83:b0:6cb:1b71:9446 with SMTP id
 6a1803df08f44-6cb1dd15bdcmr79793016d6.9.1727342521749; Thu, 26 Sep 2024
 02:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com> <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2024 11:21:50 +0200
Message-ID: <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 9:44=E2=80=AFAM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Hi Amir
>
> Thanks for the outputs. From your analysis, it is found that there are so=
me dentry references that are causing issues in p9 to report ENOENT error.

Yes, and my guess is that the MDE software running on your machine had reac=
ted
fanotify_read() error as a threat and removed the .config file, that is why
it could not be found by the open syscall??

>
> Few questions:
> 1.) What is the kernel version of your setup ?

Latest upstream master.

> 2.) Is there any command/tool to check the marked mount points ?
>

Yes and no.
No "tool" that I know of, but the information is usually available.

There is a way to list all the fanotify group fds of a process or processes=
:

root@kvm-xfstests:~# ls -l /proc/*/fd/* 2>/dev/null |grep fanotify
lrwx------ 1 root root 64 Sep 26 09:02 /proc/1928/fd/3 -> anon_inode:[fanot=
ify]

and there is a way to list the marks set by this group:

root@kvm-xfstests:~# cat /proc/1928/fdinfo/3
pos: 0
flags: 02004002
mnt_id: 16
ino: 2058
fanotify flags:7 event-flags:8000
fanotify mnt_id:58 mflags:0 mask:40010008 ignored_mask:0

mnt_id is in hex (0x58), so it needs to be translated to mount point like t=
his:

root@kvm-xfstests:~# cat /proc/self/mountinfo |grep ^$((0x58))
88 21 0:34 / /vtmp rw,relatime shared:46 - 9p v_tmp
rw,access=3Dclient,msize=3D262144,trans=3Dvirtio

For inode and super_block marks, the identifier is the st_dev (also in hex)
so some more conversions are needed to map it to device number as 0:34.

lsof does come to mind as a tool that could be enhanced to provide
this information,
but perhaps a specialized fsnotify tool is in order.

I created https://github.com/amir73il/fsnotify-utils a long time ago
with the intention of writing some useful tools, but that never happened...

> What would be the next steps for this investigation ?
>

I need to find some time and to debug the reason for 9p open failure
so we can make sure the problem is in 9p code and report more details
of the bug to 9p maintainers, but since a simple reproducer exists,
they can also try to reproduce the issue right now.

Thanks,
Amir.

