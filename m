Return-Path: <linux-fsdevel+bounces-72227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E54ACE87ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 02:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F49C3002D12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Dec 2025 01:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6329B777;
	Tue, 30 Dec 2025 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAbOmbaY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA183A14
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767058831; cv=none; b=Qm7WXy53cEB/8wMPhLgmIzLWCaQ1iG1NpGLt4rfr6B1j+1wVdoi3HZUORmKjHB/QMm3uy8z1IkPEVStXs/6oDJIShnQj1dfSR35C8HqFF6nkc++GZhTRLSbBE6JYubmQFBspMG5congX2xJu2r82IDgndTuZpgfabZ2zw7XsJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767058831; c=relaxed/simple;
	bh=cu2+rxubfA0kEr9nGwBLqnzUtrW14DV8+NiV37PKSn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVamxyyUmDyjdE08E0P2qyKqEosLdOYIxM4fIV1qotiQp7KUD4uvEGbnjpGHbfz9dE5d075esgWmOADKMMe3ruWRp/fMnW3OuuNAy1qX/80gGTfYOtfTFVMjTI426gciS/EvZDl1waiO0Guyw0+2rG+TvRXXKR1DTAkuOgXdnb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAbOmbaY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8010b8f078so1364003966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 17:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767058828; x=1767663628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lcHl0LI6VBylgpNheuMX14+DiS2VnKD9duDhs1UabJQ=;
        b=DAbOmbaYErLwaHwy7g/vkcWax8kHB5aI6klItW14eHszdUEYrmVYOXyg86VK0i258X
         p5lHGC8W6JGydW5wsN5YoY+XJcoaZwGm+v6NuygYHu/rJ2EHK1qR7NErhQjIIFnA61Qu
         uR4TT642OY+Xj/quZEoB62pycBgMkQ1WL0ihknxDmNgYJGCLRzdcxMhXf+lHMlFez5Zf
         RatYmrgfsaWNrxLbjxfhf2hvff25V96sU1tBSK3e9iZvRWGAc/iNIOLaMO/4ZQafSS3t
         +FGcAYVJ4gju2BnCWERzoI4eMWgs9DaiRJajHQyywksSY5kbtULtGcGKYe5ioyLyvgxO
         qflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767058828; x=1767663628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lcHl0LI6VBylgpNheuMX14+DiS2VnKD9duDhs1UabJQ=;
        b=lbaxY9nRS63TgeE+3sdXBScKfCExegGdpt7TcI/DzEj3bi1loETd2R/wHhcA+8TWJz
         H+VQQ48/VguJD5lP3nHAfiDeU1MrHwuITfEGBb/RL/VYqfr+xdfaH3M5q7TAes4ndOk8
         MOgL1TI3AoRsCeXZa2BWIA+Cf6ou4sbm4Dztg8vdaysDkH1bND3OUF4c27frzK04x1T1
         YTJA6Wm1SMG1nrJBR7P6CaAp969A4RpFuHdLjjY2h2kqgJTWnLroZ1WnHgSx/fuz+SU1
         cpBuJ7sGh3O6L/xIlnjWdhI3dYSXS7B0OKkQXP16b87jaexeSCFlXEv38qt62Lb48/C1
         HBPw==
X-Gm-Message-State: AOJu0YzeU94n56S2QLrHEQuDYNer8xHc6L6Fc5C2f3B9UOuElVYtENQR
	i7QGQnM8oygAfvHsnhCAMQy2O713jZbe9Q7D3nWPMde8Ewje/QHQQTyRjUHbgl8g83hFM/C0E49
	c2NsUHiBf705/PLcEjirCHshQjcM1IJQPoZiXzaY=
X-Gm-Gg: AY/fxX6+rcalWFJkTFCxaTlQfPV7aup2/DgcNF7KDRGIQn3U7mvsbjgtU3U48zoUaNU
	Swn2MmGlWN9UcWJ2HYFaMS/ioY7oaSgSfNqf+nlkvW6g6AwdJN1WVMWJ2NIUo40G5foSrK0X9AY
	T+fdHjucLctNEkbv888cN7pEwb+c9WlPG7eHOfmAgPV1uihObVrnITOEqHSAnTt0X7YdUg8Dckg
	Y/+6kjr3ojfwp+RXkKE4aHfqyl4BSnC98Ml2xfkHJ6Sk+tn1ODX0Ibi74vO9CqLeo3U
X-Google-Smtp-Source: AGHT+IECv0bjJWM9gyLXeAWKan6FtvkmjkmopVlvwjNGwjXq8PlQb6UvsavkP8o5CcfG6pg8ylvZ6i0dKFKQm8Xk9dg=
X-Received: by 2002:a17:907:972a:b0:b83:1326:62e6 with SMTP id
 a640c23a62f3a-b8313266fffmr1873315266b.35.1767058827551; Mon, 29 Dec 2025
 17:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
 <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com>
In-Reply-To: <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com>
From: Gang He <dchg2000@gmail.com>
Date: Tue, 30 Dec 2025 09:40:16 +0800
X-Gm-Features: AQt7F2pUPyP5XR7rEkiHqR8by99jiXFc4mDLRLT1dx1EspCBal5U1P0lSfyj-sI
Message-ID: <CAGmFzSdQ2Js5xUjb-s2vQkNB75Y5poOr_kTf4_8wqzeSgA6mJg@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

I used passthrough_hp, the startup command is as below,
cd libfuse/build/example
./passthrough_hp -o io_uring /mnt/xfs/ /mnt/fusemnt/
then,
cd /mnt/fusemnt/
run some fio commands, e.g.,
fio -direct=3D0 --filename=3Dsingfile --rw=3Dwrite -iodepth=3D1
--ioengine=3Dlibaio --bs=3D1M --size=3D16G --runtime=3D60 --numjobs=3D1
-name=3Dtest_fuse1

All the testing is executed in a virtual machine on x86_64(6cpu, 4G
memory, 60G disk).

Thanks
Gang


Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=8830=
=E6=97=A5=E5=91=A8=E4=BA=8C 02:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Dec 24, 2025 at 12:13=E2=80=AFAM Gang He <dchg2000@gmail.com> wro=
te:
> >
> > Hi Joanne Koong,
> >
> > I tested your v3 patch set about fuse/io-uring: add kernel-managed
> > buffer rings and zero-copy. There are some feedbacks for your
> > reference.
> > 1) the fuse file system looks workable after your 25 patches are
> > applied in the latest Linux kernel source.
> > 2)I did not see any performance improvement with your patch set. I
> > also used my fio commands to do some testing, e.g.,
> >  fio -direct=3D0 --filename=3Dsingfile --rw=3Dwrite -iodepth=3D1
> > --ioengine=3Dlibaio --bs=3D1M --size=3D16G --runtime=3D60 --numjobs=3D1
> > -name=3Dtest_fuse1
> >  fio -direct=3D0 --filename=3Dsingfile --rw=3Dread  -iodepth=3D1
> > --ioengine=3Dlibaio --bs=3D1M --size=3D16G --runtime=3D60 --numjobs=3D1
> > -name=3Dtest_fuse2
> >
> > Anyway, I am very glad to see your commits, but can you tell us how to
> > show your patch set really change the fuse rw performance?
>
> Hi Gang,
>
> Which server are you using? passthrough_hp? If you're using
> passthrough_hp, can you paste the command you're using to start up the
> server?
>
> I tried out the fio command you listed above (except using size=3D1G
> instead of size=3D16G to make it fit on my VM, but that shouldn't make
> any difference). I'm still seeing for reads a noticeable difference
> where the baseline throughput is about 2100 MiB/s and with zero-copy
> I'm seeing about 2700 MiB/s. The server I'm using is passthrough_hp.
>
> Thanks,
> Joanne
> >
> > Thanks
> > Gang

