Return-Path: <linux-fsdevel+bounces-72268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF47CEB69F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 07:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40677301FC1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 06:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCE29BDA5;
	Wed, 31 Dec 2025 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huIDvVPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C342B67A
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Dec 2025 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767164127; cv=none; b=rWKmosoKEO7gWiPa2gAG9BhgYYKOeA8Md55laLUK7Am0w0KATRRs81eVYeDIAAlMgMi9RtnChHNcVuGJUGznOly+ZOmP4QoV0dXkgrFArs5J3ZSt9MBeKksyVPGaWaMwLxpsFlca1cy3b9Kv9HwBnQ9fL95IglqpJ0ndNXW9Hec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767164127; c=relaxed/simple;
	bh=WUZTwGZalYCJ1V1zbsxYD6+s50fxNEYerA0/9hR8HBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fc9AikIYBiJ6graOiWl5aCrVVo13ADjmxKsJN9oqFrO8DJm7+zTrdKLrrLthmxBHtoSYg9Pn+ZmRpLpwWChK0D1LZEw1qSbcg5Fg6CPhqH2hnZrvJcYgZmHMKmx2xCf0B+3IP26/Q288yYuzBr5BAQFZcawcbVUQkTouh8nj1P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huIDvVPA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b736ffc531fso1919660866b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Dec 2025 22:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767164124; x=1767768924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TojBDkSSvLlQo8f3SKablykWIFd/usbAg5L0zVyv3yk=;
        b=huIDvVPA0IG8v2XkRLJfLB2v/wzZVP1o3jQ+mS04aL6b+dKyvBCE1APw3mQjwzkkQ1
         C32y+USV33gwVDPPIa0V2hp6ptZ/LYwlGGNKkau1Rh9lF+jg+I7JpfwXOOvkxESnD2Tu
         AbCc8QiWestXpKjNfsE+aAnhHFamEGCXS3j4MbbiF0tV3h+PnSCyP9SfnclWGUSlQ6uN
         /mWYpjCT480cyVb3V3JSy9RPHM1EU7bY4j8Gxzp2xD4OTxwt202GTWL2+6adseMhc1E+
         hAS1RozZw5C3z/oAakyQGMaiHmeVA0WhyS9MZIkRqPPpfm9hKAPIjAkjp23QFoDxUAPS
         kQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767164124; x=1767768924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TojBDkSSvLlQo8f3SKablykWIFd/usbAg5L0zVyv3yk=;
        b=t2+ZIz8Nvku5VjZ+EKQnus5sLxcqN+LWTX37NG5kbFguslly33eSIpNqJVOB7+cmoJ
         TzT7HM1xaw2DI/UrjeXju/UQJLAotmKy9wDyCVO4piwTi3F2r5PcMKFsX5ABNeQeECKw
         nSOFQafBn9XCnxxITGLGe9H7P4ldbxHZCh9aeDNHH4xhLPRbVJgyg96+Ln3RVav38ey6
         Rvq4JkbloeAftRYLrp0wJf7cV0o7ZOm+ekqKD8wf2M9nAeLQ5UDsJPykHx9g2aP2EWF9
         DLqoVmFgBBryLfcOIYd+2m3hsgW0NcQUJRH5ATuthfMMMOKTVDqGQLijDgRhu13EJko0
         qEag==
X-Gm-Message-State: AOJu0YwTzNheoxSElXKvLi19+QZ7IB1vTXcpiu2csWkio7qHwJwxW1XH
	EikAvJn5RSefqz+QFBXzYlLDODv5eXCrlNIlzeD4L6LvsNQ+67TB3EZV2mMBOa/QtxOhCaCmtWq
	aMns3Fx/VbFtCqp3dvfU4qJzhgV12LbN55wqHZGaTnj1/
X-Gm-Gg: AY/fxX7R1AQInjnRm1JOWDABuzWndGd8MvllMN2PUTx/MaZy0GUqHxCUzr2gqxy7m1Q
	rOnPBF11XH+RUKa+cYWcGlcwP/HroVmmlRluMU1isr75A765+Ks8M0y7ghfBYjRqqKk3BjXKlIi
	tgWRiv3mj9l/VltLKlm6r4ukIh8o2wejFALRuwoDDYWBk4iOwOjg3lvRCo4HyJg9BpDqROk9Zoj
	pMVC2T3BKxD8EdA5knjiSRQQEJLXE9EhGyPlIHmowjJ0JCNtvxsG4zs+ob7DHssi95u2Q==
X-Google-Smtp-Source: AGHT+IEqqxigcKSs6rC07IaHRI8I4qHi+Dk3FCpxiO/Ys8emp9q0bZSfFaEn5Ckj2yQXVaLLpqf5x+LLjuc6FjSlhIM=
X-Received: by 2002:a17:907:7f16:b0:b76:7fe7:ff37 with SMTP id
 a640c23a62f3a-b8036f1424dmr3796210466b.18.1767164123658; Tue, 30 Dec 2025
 22:55:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
 <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com>
 <CAGmFzSdQ2Js5xUjb-s2vQkNB75Y5poOr_kTf4_8wqzeSgA6mJg@mail.gmail.com> <CAJnrk1Z=kqQc5SM2Z1ObgEMeCttT8J83LjeX19Ysc1jCjvA79A@mail.gmail.com>
In-Reply-To: <CAJnrk1Z=kqQc5SM2Z1ObgEMeCttT8J83LjeX19Ysc1jCjvA79A@mail.gmail.com>
From: Gang He <dchg2000@gmail.com>
Date: Wed, 31 Dec 2025 14:55:11 +0800
X-Gm-Features: AQt7F2rJUOgyYSx9FjTCCF5_G-qsnT5245hONwCv6ej_RHQhNasQWpbXoXYzty8
Message-ID: <CAGmFzSe3P3=daObU5tOWxzTQ3jgo_-XTsGE3UN5Z19djhYwhfg@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

I used the latest kernel(v6.19-rc2) + your 25 patches, removed the
original liburing2,  installed your liburing(kmbuf branch).
Then, built you libfuse code(zero_copy branch).
I ran the mount commands like "./passthrough_hp --nopassthrough -o
io_uring -o io_uring_bufring -o io_uring_zero_copy /mnt/xfs/
/mnt/fusemnt/"
or "./passthrough_hp -o io_uring -o io_uring_bufring -o
io_uring_zero_copy /mnt/xfs/ /mnt/fusemnt/".

But, I encountered a hang problem when I tried to list /mnt directory.
it looks there are still some problems for this feature, or I missed
any important steps?

Thanks
Gang

Joanne Koong <joannelkoong@gmail.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=B8=89 02:54=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 29, 2025 at 5:40=E2=80=AFPM Gang He <dchg2000@gmail.com> wrot=
e:
> >
> > Hi Joanne,
> >
> > I used passthrough_hp, the startup command is as below,
> > cd libfuse/build/example
> > ./passthrough_hp -o io_uring /mnt/xfs/ /mnt/fusemnt/
> > then,
> > cd /mnt/fusemnt/
> > run some fio commands, e.g.,
> > fio -direct=3D0 --filename=3Dsingfile --rw=3Dwrite -iodepth=3D1
> > --ioengine=3Dlibaio --bs=3D1M --size=3D16G --runtime=3D60 --numjobs=3D1
> > -name=3Dtest_fuse1
>
> Hi Gang,
>
> This requires the libfuse changes in [1] (which has a dependency on
> the liburing changes in [2]). After building and installing liburing
> and then building libfuse, you can then launch passthrough_hp with
> something like: "sudo ./passthrough_hp ~/src/ ~/mnts/fuse
> --nopassthrough -o io_uring -o io_uring_bufring -o io_uring_zero_copy"
> (in the future, just "-o io_uring_zero_copy" will be enough). This was
> (briefly) mentioned in the cover letter in [3] but it probably would
> have been helpful if I had been more explicit about it, so I'll
> emphasize this more in the next cover letter.
>
> Thanks,
> Joanne
>
> [1] https://github.com/joannekoong/libfuse/commit/f15094b1881f9488b45026a=
e51f18d13ced4a554
> [2] https://github.com/joannekoong/liburing/tree/kmbuf
> [3] https://lore.kernel.org/linux-fsdevel/20251223003522.3055912-1-joanne=
lkoong@gmail.com/
>
> >
> > All the testing is executed in a virtual machine on x86_64(6cpu, 4G
> > memory, 60G disk).
> >
> > Thanks
> > Gang
> >

