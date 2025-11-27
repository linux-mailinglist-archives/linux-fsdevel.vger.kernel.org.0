Return-Path: <linux-fsdevel+bounces-70021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C88C8E80F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660F33A9F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0FB2765C3;
	Thu, 27 Nov 2025 13:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fcldpjNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91580242D83
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764250692; cv=none; b=up3IF/GnVSkufgnsbyahOY1wgZjw9vVg0RK9BiVEa/Gwchox0zJOPIinK3Hhforq9ZGZQNz7BVPCrSu8MYTEDszJUbPY8q6r0RVe/TDBCdYjnPAH4dM+NNIMA6qJO+RmtVPMZiqa4N8vi4qnie0ObVqW6wUXVproCted2na7skk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764250692; c=relaxed/simple;
	bh=qLdS25fkcgesmdhV6o078wIpV4fFC3adFgIMcIun2Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAqr6WauEF0GK14e0cR7KJMW1/ZgOhn6WQklpIyj0j3RO2v+KjXId1Xe+4RL0/ToI7DuV6+7I0RbCjxsZw3t3gpvk5AWjOGCeosgTY2eZeXMSBNoN5ODLQU0fj85Z0lViUKj0SRuzEyhTREyQCwKq+wjJ/E53cVxNicuUPfbtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fcldpjNm; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ed67a143c5so330451cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 05:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764250689; x=1764855489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaDGo58AHLarY0ifMN430Dsr8/qGthe+K2kKccI1K14=;
        b=fcldpjNmnVbnHtDdhD6NYWJgFMVBrpDdLxCpNrcB2EttrhkO7y1T4Efaum3eJZgOYG
         ddFDP6tG0mk/JF/CEnwpvjT/cBHXEink5vUbiB9c+RsYIbEbFDgHu6cjJ/gul2lK18es
         29YvN5O9qNOpIJjVO3oPBfLfqUUV+PPXJ/Yi/1FqC9M06O2QsHJxPj9GAXtDsjVUAbwY
         /LcYzAkr0kxU3mvHh7MVTlbguhj9ITMrPalHZzMDqMuNou2ieDQsfH0YZwQH4jy2JJAT
         4v97qRBqEqTPZ+UuAXnplgbaXUn2cf+Clwst8glJoawrZBNA5Owc1RjOEo6Ok/lGsrv1
         vFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764250689; x=1764855489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iaDGo58AHLarY0ifMN430Dsr8/qGthe+K2kKccI1K14=;
        b=gsI7bJNWX3mDA21n4IV7V+dEPHfMY5Rnj2VDN4QN1XsxV1toXluPclFUffBFJehF50
         RZE1ba7cvOkE4bzoc6B9xabFskrtX3mAv2owrQJ0Lzc7C20NzMfSRzGYwA9XdUVPzKmg
         eXlxIOPjuGeigoVDjLO8SdDL3cL+A6DLz1pFl9RIK2N/Rslb6FiIQGBlULGVATFsRch9
         RAtghQRzJjjQT0Qvjrf6/8Xg9QfaXndDxtARYG4I1v93h3efNdjvztHpwCGDRIa9ChEM
         b2wP/sTDaqvmYUfwpS7C51xBwY8NSc9ZxlV8XEOVYMxy79Uccwo2FRp2JkcN9L1JpAdp
         LTuQ==
X-Gm-Message-State: AOJu0Yw09GXfPrHAWgi4nQmHEJUNm/r/1NLj7NZE8rztFiaUupef0OtW
	AJebue1vBdyhbPuz0K5rzvpAuPG/xcdd+09QAV92roqC/9E1hiEEj4zOcMGp9wJVjGW3I0i0eZK
	d5zZoEJXmjpfOVESZc4w5ZrhscrUqRU/Uyi2XceFwvFW3tdjziOF/Gepe47LSWg==
X-Gm-Gg: ASbGncsjC7/aoJZK2UPmcP9x235jHyIYEGkx/SJJCb1qTEYUyAesUnnQe8P5olJkpYN
	cBVFSFvZh5LmQDENL0lJHtyKkr4eVX8sTzQNiK29CJJJTQ/1gcRBtu1fTVzyzLv05FUS04EjuO9
	1onDl1oUccsxrjUqSdSZRu1E0xcggSJ7lM1e3ngMBZ2bCpV0J9mr7ZG1914F7DTjZOlg84Y2n9Y
	kZ+ayQ3hCJyOm0vEVfDrqE1EoKtyvC3Y3v5UJgIrchLiXEzEvTVTKWubhtaEhA501QdZuBwvw==
X-Google-Smtp-Source: AGHT+IGh+O0eXY0a5iTqMDEZtQ2YaKvnG5fKV6LQSHoQdZ+Lp3hLkKcANkI1CFen6ySi3j+qSVAQH+Qa8E3lAaM5BAg=
X-Received: by 2002:a05:622a:134c:b0:4e4:f2b9:55aa with SMTP id
 d75a77b69052e-4efd1a6f45cmr4083881cf.17.1764250689168; Thu, 27 Nov 2025
 05:38:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com>
In-Reply-To: <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com>
From: Abhishek Gupta <abhishekmgupta@google.com>
Date: Thu, 27 Nov 2025 19:07:57 +0530
X-Gm-Features: AWmQ_bnaNSGrO8--fBMMmlNpIjjWU4KGLfBbcUSJpC9LkBpAdnLL7bvDkU7eQZQ
Message-ID: <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Bernd Schubert <bschubert@ddn.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	Swetha Vadlakonda <swethv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

Thanks for looking into this.
Please find below the fio output on 6.11 & 6.14 kernel versions.


On kernel 6.11

~/gcsfuse$ uname -a
Linux abhishek-c4-192-west4a 6.11.0-1016-gcp #16~24.04.1-Ubuntu SMP
Wed May 28 02:40:52 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

iodepth =3D 1
:~/fio-fio-3.38$ ./fio --name=3Drandread --rw=3Drandread
--ioengine=3Dio_uring --thread
--filename_format=3D'/home/abhishekmgupta_google_com/bucket/$jobnum'
--filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1
--iodepth=3D1 --group_reporting=3D1 --direct=3D1
randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T=
)
4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
fio-3.38
Starting 1 thread
...
Run status group 0 (all jobs):
   READ: bw=3D3311KiB/s (3391kB/s), 3311KiB/s-3311KiB/s
(3391kB/s-3391kB/s), io=3D48.5MiB (50.9MB), run=3D15001-15001msec

iodepth=3D4
:~/fio-fio-3.38$ ./fio --name=3Drandread --rw=3Drandread
--ioengine=3Dio_uring --thread
--filename_format=3D'/home/abhishekmgupta_google_com/bucket/$jobnum'
--filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1
--iodepth=3D4 --group_reporting=3D1 --direct=3D1
randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T=
)
4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
fio-3.38
Starting 1 thread
...
Run status group 0 (all jobs):
   READ: bw=3D11.0MiB/s (11.6MB/s), 11.0MiB/s-11.0MiB/s
(11.6MB/s-11.6MB/s), io=3D166MiB (174MB), run=3D15002-15002msec


On kernel 6.14

:~$ uname -a
Linux abhishek-west4a-2504 6.14.0-1019-gcp #20-Ubuntu SMP Wed Oct 15
00:41:12 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

iodepth=3D1
:~$ fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thread
--filename_format=3D'/home/abhishekmgupta_google_com/bucket/$jobnum'
--filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1
--iodepth=3D1 --group_reporting=3D1 --direct=3D1
randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T=
)
4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
fio-3.38
Starting 1 thread
...
Run status group 0 (all jobs):
   READ: bw=3D3576KiB/s (3662kB/s), 3576KiB/s-3576KiB/s
(3662kB/s-3662kB/s), io=3D52.4MiB (54.9MB), run=3D15001-15001msec

iodepth=3D4
:~$ fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thread
--filename_format=3D'/home/abhishekmgupta_google_com/bucket/$jobnum'
--filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D1
--iodepth=3D4 --group_reporting=3D1 --direct=3D1
randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B, (T=
)
4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
fio-3.38
...
Run status group 0 (all jobs):
   READ: bw=3D3863KiB/s (3956kB/s), 3863KiB/s-3863KiB/s
(3956kB/s-3956kB/s), io=3D56.6MiB (59.3MB), run=3D15001-15001msec

Thanks,
Abhishek


On Thu, Nov 27, 2025 at 12:41=E2=80=AFAM Bernd Schubert <bschubert@ddn.com>=
 wrote:
>
> Hi Abhishek,
>
> On 11/26/25 16:07, Abhishek Gupta wrote:
> > [You don't often get email from abhishekmgupta@google.com. Learn why th=
is is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hello Team,
> >
> > I am observing a performance regression in the FUSE subsystem on
> > Kernel 6.14 compared to 6.8/6.11 when using the legacy/standard FUSE
> > interface (userspace daemon using standard read on /dev/fuse).
> >
> > Summary of Issue: On Kernel 6.8 & 6.11, increasing iodepth in fio
> > (using ioengine=3Dio_uring) results in near-linear performance scaling.
> > On Kernel 6.14, using the exact same userspace binary, increasing
> > iodepth yields no performance improvement (behavior resembles
> > iodepth=3D1).
> >
> > Environment:
> > - Workload: GCSFuse (userspace daemon) + Fio
> > - Fio Config: Random Read, ioengine=3Dio_uring, direct=3D1, iodepth=3D4=
.
> > - CPU: Intel.
> > - Daemon: Go-based. It uses a serialized reader loop on /dev/fuse that
> > immediately spawns a Go routine per request. So, it can serve requests
> > in parallel.
> > - Kernel Config: CONFIG_FUSE_IO_URING=3Dy is enabled, but the daemon is
> > not registering for the ring (legacy mode).
> >
> > Benchmark Observations:
> > - Kernel 6.8/6.11: With iodepth=3D4, we observe ~3.5-4x throughput
> > compared to iodepth=3D1.
> > - Kernel 6.14: With iodepth=3D4, throughput is identical to iodepth=3D1=
.
> > Parallelism is effectively lost.
> >
> > Is this a known issue? I would appreciate any insights or pointers on
> > this issue.
>
> Could you give your exact fio line? I'm not aware of such a regression.
>
> bschubert2@imesrv3 ~>fio --directory=3D/tmp/dest --name=3Diops.\$jobnum -=
-rw=3Drandread --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D1 --time_bas=
ed --runtime=3D30s --group_reporting --ioengine=3Dio_uring  --direct=3D1
> iops.$jobnum: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-409=
6B, (T) 4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
> fio-3.36
> Starting 1 process
> iops.$jobnum: Laying out IO file (1 file / 1024MiB)
> ...
> Run status group 0 (all jobs):
>     READ: bw=3D178MiB/s (186MB/s), 178MiB/s-178MiB/s (186MB/s-186MB/s), i=
o=3D5331MiB (5590MB), run=3D30001-30001msec
>
> bschubert2@imesrv3 ~>fio --directory=3D/tmp/dest --name=3Diops.\$jobnum -=
-rw=3Drandread --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_bas=
ed --runtime=3D30s --group_reporting --ioengine=3Dio_uring  --direct=3D1
> iops.$jobnum: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-409=
6B, (T) 4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
> fio-3.36
> Starting 1 process
> Jobs: 1 (f=3D1): [r(1)][100.0%][r=3D673MiB/s][r=3D172k IOPS][eta 00m:00s]
> iops.$jobnum: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D52012: Wed Nov 26 =
20:08:17 2025
> ...
> Run status group 0 (all jobs):
>    READ: bw=3D673MiB/s (706MB/s), 673MiB/s-673MiB/s (706MB/s-706MB/s), io=
=3D19.7GiB (21.2GB), run=3D30001-30001msec
>
>
> This is with libfuse `example/passthrough_hp -o allow_other --nopassthrou=
gh --foreground /tmp/source /tmp/dest`
>
>
> Thanks,
> Bernd

