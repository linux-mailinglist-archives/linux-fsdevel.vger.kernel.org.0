Return-Path: <linux-fsdevel+bounces-29950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4EA98413A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 10:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DD8B22552
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC59A155325;
	Tue, 24 Sep 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWetKtRI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DD8154BE2
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168224; cv=none; b=iwZXlNFnCLqDNmMinLuUMK4ONyxOqQnekK2pkgK1n05HVX+FYS5C/tlaN828iOYUskMvFlJSWel+EIEH7/4lxPJoqP7T+W7p4rW7SLggrIPxgcJTImCb3/x8O/JmoFBUx3t5mFjPi6WJvBsCsjjTMXiQnkrAVpNe5nfMyCJmK7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168224; c=relaxed/simple;
	bh=U4cFy45YDIl6pWBrlXDbdKCq++90HzWPnnLRQ2Tmpps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oTyl3Nro80oMi+xPkHr9hRXAvi2/6ACS1FuUEvHsXKrQVnM/qm+1Y0nzXVLQ7uXe9dAqTMf0eETsdtIZ75AYbH6uJsBsFFM2BKqEb8xOSfjyISASIZSLAgUcigvKf7Mrh+h4atEdnM3BbBrJqw0ZTDJktzeIYKiHFAJB6qybvb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWetKtRI; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a99de9beb2so333724885a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727168221; x=1727773021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4cFy45YDIl6pWBrlXDbdKCq++90HzWPnnLRQ2Tmpps=;
        b=DWetKtRIoMlu96HhhB/gT9qxf4HuHJLYgsfsFxwKJYo9AsyOmrxHyBpkQA2Js0W9Kh
         PR4h7g74UJa1gfweMVP4vvfZnAXPG783nbgFJdV8+7s1hLS+kLgpCAYIzInzaowZDCax
         ZRAWW1jOn5/vFHXT7OasrRk8Krr3CZ0vXsL3t2xSObJafW0YikHUjlPrGMyazwyFi9i6
         9w/kZRGLnrM/hf0Ud+Ox3n51zHeDCR2fvhN6BkRcd91AOyMO+Mq12TVIUCSnkhlZQ98z
         NVYto/YRZXAwKApZhHduEVmYrMrIuHA9ZS7LfnZ8zmLTx2mH0QNsVXJasWVnsHTpZLwh
         0OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727168221; x=1727773021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4cFy45YDIl6pWBrlXDbdKCq++90HzWPnnLRQ2Tmpps=;
        b=X13ShVfB3LYmVEYPgP/RyV9bIxGiqmH1JRszWerFrZWKGaFv0S1J1yjhXjV5qbT1Uc
         sEs6zqDkFyFPYtUgjsrr+wLPcv0++gwGvcFVJ7ElhoRn7YUtE1xCpxa0ExL7bcwsb00G
         XiQ8wmKTzR8R7wLpwhgi3R1i/EFKVrr5bdbAOzsHG72GyAYB84E5fwp61JgdH/kGQMvd
         O4Ha4o6h5FGuNk57Tp/2wqY+E8IwCCPVNoCvwiS0xLy3Ni4IQdxeO8ssdfk0Z2CwZxrY
         CqrlQKfkDF/lhvBsd3V7iXMx0/9W/wXCnrQSGUlVi9bznY77mgdYG5yqVhoJsHu4SBSL
         Gtlg==
X-Gm-Message-State: AOJu0Ywypbuv+rY0rOCTv9M5dCBtROT0NiYW3/5hH1b19Nwgg5lgWkvT
	emhmdzd4/zR2mMZnIjkwnvTHtdt+geDLI7F52ehiKoyMslf2RPKh4YZAXbheNPQCFnPGRjKnssi
	EEo/4B9/6EKdEI6CGEF9choEbL9ieYisVMFw=
X-Google-Smtp-Source: AGHT+IFntdEO9jtdgubdDTdntjIHBmD9jyU7v+fwjTwKfEWsKCQIPoFntHxlTBovJjH7s7GAFgzac4l90f3S2rEoqvY=
X-Received: by 2002:a05:620a:28cd:b0:7a9:b744:fc38 with SMTP id
 af79cd13be357-7acb8d8c7admr2521749285a.15.1727168221425; Tue, 24 Sep 2024
 01:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com> <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 24 Sep 2024 10:56:49 +0200
Message-ID: <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jack@suse.cz" <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 7:25=E2=80=AFAM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Hi Amir
>
> Thanks for the reply.
>
> We have another image with kernel version: 6.6.36.3. git clone operation =
fails there as well. Do we need to still try with 5.15.154 kernel version ?

No need.

>
> Currently, we are marking the mount points with mask(FAN_CLOSE_WRITE) to =
handle only close_write events. Do we need to add any other flag in mask an=
d check ?

No need.

>
> Following is the mount entry in /proc/mounts file:
> C:\134 /mnt/c 9p rw,noatime,aname=3Ddrvfs;path=3DC:\;uid=3D0;gid=3D0;syml=
inkroot=3D/mnt/,cache=3D5,access=3Dclient,msize=3D65536,trans=3Dfd,rfd=3D4,=
wfd=3D4 0 0

I don't know this symlinkroot feature.
It looks like a WSL2 feature (?) and my guess is that the failure
might be related.
Not sure how fanotify mount mark affects this, maybe because the
close_write events
open the file for reporting the event, but maybe you should try to ask
your question
also the WSL2 kernel maintainers.

I have tried to reproduce your test case on the 9p mount on my test box:
v_tmp on /vtmp type 9p (rw,relatime,access=3Dclient,msize=3D262144,trans=3D=
virtio)

with fanotify examples program:
https://manpages.debian.org/unstable/manpages/fanotify.7.en.html#Example_pr=
ogram:_fanotify_example.c

and could not reproduce the issue with plain:
echo 123 > x && mv x y && cat y

>
> Attached is the strace for failed git clone operation(line: 419, 420).

All the failures are ENOENT, which is why I suspect maybe related to
the symlinkroot thing.

> Even I wrote a small program to invoke rename, followed with open.
> The open fails immediately and succeeds after 3-4 iterations.
> This exercise was performed on p9 file system marked with fanotify.

Please share your reproducer program.
The difference could be in the details.
Can you test in a 9p mount without those WSL options?
Can you test on upstream or LTS kernel?
Can you test with the fanotify example?

>
> Am not reporting this as regression. We havent checked this behavior befo=
re.
>

Ok. patience, we will try to get to the bottom of this.

Thanks,
Amir.

