Return-Path: <linux-fsdevel+bounces-71021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AF3CB0B1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 18:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8D23095261
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 17:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC232AAA2;
	Tue,  9 Dec 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHqtcPfi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206082FE566
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765300602; cv=none; b=lBw+PJ3JFi4wxvf3fAXRTPwFgxY81EhY3DU5KVRJkV2EX4K+0yAygowjIue6YvEtNzm1ObMNIqeSKQbVOYq+JF75Y+/dRFfEU5Lk9Pa7K0jxMYOINETuPRDTW5If+RSf+kylt/iFGsYS/LWPxO6PDJZyCFtC50bQT5wcS3q2MkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765300602; c=relaxed/simple;
	bh=KZn3x6mwN/HR4tiyZjY6go/uZcFd+tJVGffsUJ6Aa5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfCrzCqfttLgm6bxgvtOuT8xseKqxZnL5F+phttZFQecaFrdDW6li0dvRli0QCLa8+mdFMiUrxf0kut2J5hKEqWrQjrKGoa1Qvq5hx5YN1L0SAI2+slxuloWd1FtoaEXyseLeBu4hxCK1n2q741pnyRuFnjmOf9KdTY+xD49J6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XHqtcPfi; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4edb8d6e98aso711171cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 09:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765300600; x=1765905400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Dd2YJfhVUNcnSyY/1ATktA1yARrWNRNvhpNKoydoYs=;
        b=XHqtcPfiwiWG9q7/inK+K9qr8aA6tShF1yJEfFDrx7A6TgCyX8jPX4aDwcjgo0nedq
         pHnTXMmdqJ4SzNYaDDKY5T2UugyxqP4jgqtV/RzqXkJD+98kulmZv6YszAu6MUrgpZqq
         ndJEjSIZz8neWVkIr3kwP4dqZQuqG1UCjcM2pn5FDkh4kQ9FqqwwVCU/4tv+PIV6YxxA
         tY+PI9DDDibYev0YPkFVZb2vtO74pe1Mygf5o8l/cdynCnG1ek/5RXaOUZN9bUE1s9zz
         nBP3XGmDmYy26nkS9K4e7SL6B7SNkML5tNbvzhE60vGUg+hiPi6e4+Fl5lKZ29mCH/u4
         vFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765300600; x=1765905400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Dd2YJfhVUNcnSyY/1ATktA1yARrWNRNvhpNKoydoYs=;
        b=a5xn8a6i9pjVmZNg4SvlPctBoXMBLMQIDZB85M4s5V2vJw5v2U2Co9AkLdZs0lTFMA
         PU0jgCKAc4QAe91T7uxIsO9kT17/TUaw/9Je5Y/EPXn06/4XB9mfkv7QETjmVnCj3VIZ
         is09i3b6CDAIT9oYziV/Fce1i07eY9/Hx7z5ke3l+o4wrclFe+gKVmlx2PuW3tv6sZra
         ywQ2X5+50ROdHHRng6WI49STxFbkypUl+JgY0YYdFlWOwukakfFd7KfeU9QHKS5aCZJM
         qs7wiczk0W52kjCQKeOihD4cUWymmQRrZJlMEOb8J86bGvvWNB6YVX36+/aqgUzmTbfa
         82Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUuVRh0Q38yU+IxSLotUZFE5YF8VVu0tDypKFgogBLqdcT7APdg+NYyBB69hWEtm1GvXIic7FiylbJVaZDv@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuqsiZZJKAGOE4lZCP2RGJIYqP1Jlw3guEkj4tbewFT/HlrrK
	1QaqY1Bz7HSH0YOPR66fNzsVu83os8INgo8O5pXshZyFp+MVJseDEmahQou2GYcspFTKzNXpUxu
	hsx9Pes7JtDCmEJjzuAIgrT9br+hNiSaDJ80hfBYN
X-Gm-Gg: ASbGncsaiFXR5G42fuRVjiDlywOg76/MXl1QLC07oQiovPVxwhBnoJQt9fgVlLp7xqo
	kyUrjELwfiBwWa7N1iQ8kxQBIJJI6WD5M4U3zEts748SvhSEIAa+NDrE6cr0NvlA6OLHSvdLpE6
	EvvWW83u9umCObtwmpSSooNq7oTICuHRsEVfDNJSsZtub3pE8BJG443LOWAv5XqRemNvjRVdDUK
	zyOGUu5kEwOdVzhKk3838WdP38hici8PH1QqDooEkCUw66SQ+Rbc30NY4zPG+YwFeI6SwBJPiB3
	19X8S+mB94b1O10AFO4JRaJuy6zYTjEQE03Pxw==
X-Google-Smtp-Source: AGHT+IE13r6whZ0Sx5lei1AbgxOHbxjw5tzyFRmkegXpw9GlsVAQI6TznJ6occX4HWMxgfICZqJ2/FsQEDhKGEVLs5Y=
X-Received: by 2002:a05:622a:1aaa:b0:4b7:aa51:116a with SMTP id
 d75a77b69052e-4f1a4e68874mr13720321cf.4.1765300599320; Tue, 09 Dec 2025
 09:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com> <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com> <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
 <CAPr64AKYisa=_X5fAB1ozgb3SoarKm19TD3hgwhX9csD92iBzA@mail.gmail.com>
 <bcb930c5-d526-42c9-a538-e645510bb944@ddn.com> <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
In-Reply-To: <06ab8a37-530d-488f-abaf-6f0b636b3322@bsbernd.com>
From: Abhishek Gupta <abhishekmgupta@google.com>
Date: Tue, 9 Dec 2025 22:46:27 +0530
X-Gm-Features: AQt7F2pLMxePeLs7Vqk_24OW7RzqC9-SsKVob90_DqnwJgdkq2hRmkBGV_r0JWg
Message-ID: <CAPr64A+HkRX+b=CozFgnVfjQaprx2mggf4wrhCGQhZdvYeQVcA@mail.gmail.com>
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	Swetha Vadlakonda <swethv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

No worries. Thanks for the update. I look forward to hearing your findings.

Thanks,
Abhishek


On Tue, Dec 9, 2025 at 4:27=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
> Hi Abishek,
>
> really sorry for the delay. I can see the same as you do, no improvement
> with --iodepth. Although increasing the number of fio threads/jobs helps.
>
> Interesting is that this is not what I'm seeing with passthrough_hp,
> at least I think so
>
> I had run quite some tests here
> https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3-v2-6-742ff1a8=
fc58@ddn.com
> focused on io-uring, but I had also done some tests with legacy
> fuse. I was hoping I would managed to re-run today before sending
> the mail, but much too late right. Will try in the morning.
>
>
>
> Thanks,
> Bernd
>
>
> On 12/8/25 18:52, Bernd Schubert wrote:
> > Hi Abhishek,
> >
> > yes I was able to run it today, will send out a mail later. Sorry,
> > rather busy with other work.
> >
> >
> > Best,
> > Bernd
> >
> > On 12/8/25 18:43, Abhishek Gupta wrote:
> >> Hi Bernd,
> >>
> >> Were you able to reproduce the issue locally using the steps I provide=
d?
> >> Please let me know if you require any further information or assistanc=
e.
> >>
> >> Thanks,
> >> Abhishek
> >>
> >>
> >> On Tue, Dec 2, 2025 at 4:12=E2=80=AFPM Abhishek Gupta <abhishekmgupta@=
google.com
> >> <mailto:abhishekmgupta@google.com>> wrote:
> >>
> >>     Hi Bernd,
> >>
> >>     Apologies for the delay in responding.
> >>
> >>     Here are the steps to reproduce the FUSE performance issue locally
> >>     using a simple read-bench FUSE filesystem:
> >>
> >>     1. Set up the FUSE Filesystem:
> >>     git clone https://github.com/jacobsa/fuse.git <https://github.com/
> >>     jacobsa/fuse.git> jacobsa-fuse
> >>     cd jacobsa-fuse/samples/mount_readbenchfs
> >>     # Replace <mnt_dir> with your desired mount point
> >>     go run mount.go --mount_point <mnt_dir>
> >>
> >>     2. Run Fio Benchmark (iodepth 1):
> >>     fio  --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thr=
ead
> >>     --filename=3D<mnt_dir>/test --filesize=3D1G --time_based=3D1 --run=
time=3D5s
> >>     --bs=3D4K --numjobs=3D1 --iodepth=3D1 --direct=3D1 --group_reporti=
ng=3D1
> >>
> >>     3. Run Fio Benchmark (iodepth 4):
> >>     fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thre=
ad
> >>     --filename=3D<mnt_dir>/test --filesize=3D1G --time_based=3D1 --run=
time=3D5s
> >>     --bs=3D4K --numjobs=3D1 --iodepth=3D4 --direct=3D1 --group_reporti=
ng=3D1
> >>
> >>
> >>     Example Results on Kernel 6.14 (Regression Observed)
> >>
> >>     The following output shows the lack of scaling on my machine with
> >>     Kernel 6.14:
> >>
> >>     Kernel:
> >>     Linux abhishek-west4a-2504 6.14.0-1019-gcp #20-Ubuntu SMP Wed Oct =
15
> >>     00:41:12 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> >>
> >>     Iodepth =3D 1:
> >>     READ: bw=3D74.3MiB/s (77.9MB/s), ... io=3D372MiB (390MB), run=3D50=
01-5001msec
> >>
> >>     Iodepth =3D 4:
> >>     READ: bw=3D87.6MiB/s (91.9MB/s), ... io=3D438MiB (459MB), run=3D50=
00-5000msec
> >>
> >>     Thanks,
> >>     Abhishek
> >>
> >>
> >>     On Fri, Nov 28, 2025 at 4:35=E2=80=AFAM Bernd Schubert <bernd@bsbe=
rnd.com
> >>     <mailto:bernd@bsbernd.com>> wrote:
> >>     >
> >>     > Hi Abhishek,
> >>     >
> >>     > On 11/27/25 14:37, Abhishek Gupta wrote:
> >>     > > Hi Bernd,
> >>     > >
> >>     > > Thanks for looking into this.
> >>     > > Please find below the fio output on 6.11 & 6.14 kernel version=
s.
> >>     > >
> >>     > >
> >>     > > On kernel 6.11
> >>     > >
> >>     > > ~/gcsfuse$ uname -a
> >>     > > Linux abhishek-c4-192-west4a 6.11.0-1016-gcp #16~24.04.1-Ubunt=
u SMP
> >>     > > Wed May 28 02:40:52 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> >>     > >
> >>     > > iodepth =3D 1
> >>     > > :~/fio-fio-3.38$ ./fio --name=3Drandread --rw=3Drandread
> >>     > > --ioengine=3Dio_uring --thread
> >>     > > --filename_format=3D'/home/abhishekmgupta_google_com/bucket/$j=
obnum'
> >>     > > --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --n=
umjobs=3D1
> >>     > > --iodepth=3D1 --group_reporting=3D1 --direct=3D1
> >>     > > randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W)
> >>     4096B-4096B, (T)
> >>     > > 4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
> >>     > > fio-3.38
> >>     > > Starting 1 thread
> >>     > > ...
> >>     > > Run status group 0 (all jobs):
> >>     > >    READ: bw=3D3311KiB/s (3391kB/s), 3311KiB/s-3311KiB/s
> >>     > > (3391kB/s-3391kB/s), io=3D48.5MiB (50.9MB), run=3D15001-15001m=
sec
> >>     > >
> >>     > > iodepth=3D4
> >>     > > :~/fio-fio-3.38$ ./fio --name=3Drandread --rw=3Drandread
> >>     > > --ioengine=3Dio_uring --thread
> >>     > > --filename_format=3D'/home/abhishekmgupta_google_com/bucket/$j=
obnum'
> >>     > > --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --n=
umjobs=3D1
> >>     > > --iodepth=3D4 --group_reporting=3D1 --direct=3D1
> >>     > > randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W)
> >>     4096B-4096B, (T)
> >>     > > 4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
> >>     > > fio-3.38
> >>     > > Starting 1 thread
> >>     > > ...
> >>     > > Run status group 0 (all jobs):
> >>     > >    READ: bw=3D11.0MiB/s (11.6MB/s), 11.0MiB/s-11.0MiB/s
> >>     > > (11.6MB/s-11.6MB/s), io=3D166MiB (174MB), run=3D15002-15002mse=
c
> >>     > >
> >>     > >
> >>     > > On kernel 6.14
> >>     > >
> >>     > > :~$ uname -a
> >>     > > Linux abhishek-west4a-2504 6.14.0-1019-gcp #20-Ubuntu SMP Wed =
Oct 15
> >>     > > 00:41:12 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> >>     > >
> >>     > > iodepth=3D1
> >>     > > :~$ fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_urin=
g --thread
> >>     > > --filename_format=3D'/home/abhishekmgupta_google_com/bucket/$j=
obnum'
> >>     > > --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --n=
umjobs=3D1
> >>     > > --iodepth=3D1 --group_reporting=3D1 --direct=3D1
> >>     > > randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W)
> >>     4096B-4096B, (T)
> >>     > > 4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
> >>     > > fio-3.38
> >>     > > Starting 1 thread
> >>     > > ...
> >>     > > Run status group 0 (all jobs):
> >>     > >    READ: bw=3D3576KiB/s (3662kB/s), 3576KiB/s-3576KiB/s
> >>     > > (3662kB/s-3662kB/s), io=3D52.4MiB (54.9MB), run=3D15001-15001m=
sec
> >>     > >
> >>     > > iodepth=3D4
> >>     > > :~$ fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_urin=
g --thread
> >>     > > --filename_format=3D'/home/abhishekmgupta_google_com/bucket/$j=
obnum'
> >>     > > --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --n=
umjobs=3D1
> >>     > > --iodepth=3D4 --group_reporting=3D1 --direct=3D1
> >>     > > randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W)
> >>     4096B-4096B, (T)
> >>     > > 4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
> >>     > > fio-3.38
> >>     > > ...
> >>     > > Run status group 0 (all jobs):
> >>     > >    READ: bw=3D3863KiB/s (3956kB/s), 3863KiB/s-3863KiB/s
> >>     > > (3956kB/s-3956kB/s), io=3D56.6MiB (59.3MB), run=3D15001-15001m=
sec
> >>     >
> >>     > assuming I would find some time over the weekend and with the fa=
ct
> >>     that
> >>     > I don't know anything about google cloud, how can I reproduce th=
is?
> >>     >
> >>     >
> >>     > Thanks,
> >>     > Bernd
> >>
> >
>

