Return-Path: <linux-fsdevel+bounces-70448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD66C9B341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 11:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F19034688F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 10:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB212F6184;
	Tue,  2 Dec 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5VE53nh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB028727A
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672183; cv=none; b=rdzNDV000XqYbFqyxHKVVI+cqGXiaHb/ELIk/k/NF3udXaTxk08C2KQokQEL10gCN9H7KCvXrqN6fGEzwbhi5KMz4HikO6I7Khbdh4JvvVK/mPBnZB89BFLmUcM8tjRuJedhTu5TZX/S+cKI9jKSsFa5CcZfCK2q1kzLLXm0CAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672183; c=relaxed/simple;
	bh=XAfSviH/8M5ca5xnlXx+NQbKe4N/WpODN8UTvtSdcvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWQrivzszWzVyryh3QCfNHfApa7OA7mpb4hRezp/TnD/OwGUb54seogPjSmhlR87ZCL+uQ0zbDARBzypmpYQqGYe9jgyUvZYucv8gpwYyPyxQNVhLMCnWP4ygaqbcYBHRoRjV8VIIyut7wXRpzZyrR7PYqpQ+myFw2fnHUqCC0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5VE53nh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ee243b98caso1581571cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 02:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764672179; x=1765276979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geIv1H4S6ui74XSinGSoyQJqU6R5fDTB/w8lp3AZfic=;
        b=g5VE53nhJHpIosI45/pyjbMgEO28yYc9s4PTvK+C0YVDE/PSlAjnFHHjdwCOVKc4Am
         t8MC9rhCbDImcaxtV7MgxhijPCWtebZNazwlXJRLPDOvA2mRPq3J/Z+9XTtja9uAlqZ8
         BV8UCOGtZVkKofIkoFBK3iW6LB1kSwV1s77JBXZBZo74Sg0ZpMeSjwQmtSCeOgKq/0yd
         T7QTl1cRg5m1F1B4+REMc6pJlHeSfPnqtmwNl2RWNc9POOhRdUpyA7TY5lHHeJ6naB+B
         cgH2TmJaBJi2bl649g20F+VXdvLsyTXqLT0kJZOnLVAxiIyjOq3lmySkTdr0P05tXVYi
         CE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764672179; x=1765276979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=geIv1H4S6ui74XSinGSoyQJqU6R5fDTB/w8lp3AZfic=;
        b=iKSq3VdgrOREoVVgMgvWaLmq0jGPduBiptST6iZW6ztkOqPoVeBTJ3eirKLzdgI53J
         oCFgPZCgddznT1Qon9MI+DgEdn8Mejwzw8Pn03spH2dWz8jJydW4HwvIlvnoDVUApGw3
         IvYWnmjuoJnD5kBRTSGSK8p1/PBM/IRmqAWrkG4m3t+JwMGItKXZwh4GfrTO/zbqdORc
         ljEvrH8FEUGFBMCkVY8MtAarH1NmPsuJLrgupy5BSSCjs4001S1+ctMTcIAOX9ahH0GT
         KXwXyPnCUxz8qXqIbaPi1P2tUnlgFMSNQDArHSlxDjI8vonUotkSskthoyw2cxVB9UUs
         79+w==
X-Forwarded-Encrypted: i=1; AJvYcCU3wz/62GXsyebgYqfqqWDks3JAACrZnO68nK5Me9MHVbbnQf1J/P6dJGJe0w2OLumYfcytkFZQz4Y22PW7@vger.kernel.org
X-Gm-Message-State: AOJu0YxTnRgDjgN4B991DGqOz/4G0nX2LllhAg/6sX9JTghTafqtlTdb
	3PwuYdF1cCjU2u0zYwCBuT8nfINyjx1lZmkyFkkNQHnusWnJACf9GHY4V+d3YFLDGEChup/28nH
	DxowAOkURJHdjmqXTWYSJWlgia+hlaHDuYkCW1lZr
X-Gm-Gg: ASbGnctTUiqGUg19NlA/apjH7aJPZyQBydf+OBDbM+sifJOpaBnOeGHO5rOb2fbA9wv
	tTNhz65aok9mqj2WtbtuDCDDtsjHNLWK+abhjl97Jg3RwABGuu6pNGpUKJLXtOqK/xNJcCQVaGx
	+AeRZ0WirRxkGR8uOp2gmX7POvcR/WiZ7gq+7k9P0b7SaY4JmfAl9F3pctafv0s40AwmHKkoOtk
	d/5/mqH8RJQmws/l94jvK2ExTCieRhtTLT5Av/VnGqsSld7SJzcZLMB6EcXo8Tz3OGJpYFRTmvN
	qb2ENKvyFsPr5LRnfFeUDm9JBQ==
X-Google-Smtp-Source: AGHT+IHl1cHJx/KU3xFNU6b10ypvRVdNIHcijI3R41lBNf4UuVlQ8+lpIBlw7K8FpLJzmrxC4149b3SeGDryw/OLuWc=
X-Received: by 2002:ac8:5f53:0:b0:4e6:eaea:af3f with SMTP id
 d75a77b69052e-4f008be54c4mr2746591cf.3.1764672179046; Tue, 02 Dec 2025
 02:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
 <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com> <CAPr64AJXg9nr_xG_wpy3sDtWmy2cR+HhqphCGgWSoYs2+OjQUQ@mail.gmail.com>
 <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com>
In-Reply-To: <ea9193cd-dbff-4398-8f6a-2b5be89b1fa4@bsbernd.com>
From: Abhishek Gupta <abhishekmgupta@google.com>
Date: Tue, 2 Dec 2025 16:12:47 +0530
X-Gm-Features: AWmQ_bmp61Cfg5bQnfStJwx8viaXdnFLH7GAvRyo_2KwKoL8tBW5_inZ0J3QG20
Message-ID: <CAPr64A+=63MQoa6RR4SeVOb49Pqqpr8enP7NmXeZ=8YtF8D1Pg@mail.gmail.com>
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	Swetha Vadlakonda <swethv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bernd,

Apologies for the delay in responding.

Here are the steps to reproduce the FUSE performance issue locally
using a simple read-bench FUSE filesystem:

1. Set up the FUSE Filesystem:
git clone https://github.com/jacobsa/fuse.git jacobsa-fuse
cd jacobsa-fuse/samples/mount_readbenchfs
# Replace <mnt_dir> with your desired mount point
go run mount.go --mount_point <mnt_dir>

2. Run Fio Benchmark (iodepth 1):
fio  --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thread
--filename=3D<mnt_dir>/test --filesize=3D1G --time_based=3D1 --runtime=3D5s
--bs=3D4K --numjobs=3D1 --iodepth=3D1 --direct=3D1 --group_reporting=3D1

3. Run Fio Benchmark (iodepth 4):
fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --thread
--filename=3D<mnt_dir>/test --filesize=3D1G --time_based=3D1 --runtime=3D5s
--bs=3D4K --numjobs=3D1 --iodepth=3D4 --direct=3D1 --group_reporting=3D1


Example Results on Kernel 6.14 (Regression Observed)

The following output shows the lack of scaling on my machine with Kernel 6.=
14:

Kernel:
Linux abhishek-west4a-2504 6.14.0-1019-gcp #20-Ubuntu SMP Wed Oct 15
00:41:12 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux

Iodepth =3D 1:
READ: bw=3D74.3MiB/s (77.9MB/s), ... io=3D372MiB (390MB), run=3D5001-5001ms=
ec

Iodepth =3D 4:
READ: bw=3D87.6MiB/s (91.9MB/s), ... io=3D438MiB (459MB), run=3D5000-5000ms=
ec

Thanks,
Abhishek


On Fri, Nov 28, 2025 at 4:35=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> Hi Abhishek,
>
> On 11/27/25 14:37, Abhishek Gupta wrote:
> > Hi Bernd,
> >
> > Thanks for looking into this.
> > Please find below the fio output on 6.11 & 6.14 kernel versions.
> >
> >
> > On kernel 6.11
> >
> > ~/gcsfuse$ uname -a
> > Linux abhishek-c4-192-west4a 6.11.0-1016-gcp #16~24.04.1-Ubuntu SMP
> > Wed May 28 02:40:52 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> >
> > iodepth =3D 1
> > :~/fio-fio-3.38$ ./fio --name=3Drandread --rw=3Drandread
> > --ioengine=3Dio_uring --thread
> > --filename_format=3D'/home/abhishekmgupta_google_com/bucket/$jobnum'
> > --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D=
1
> > --iodepth=3D1 --group_reporting=3D1 --direct=3D1
> > randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B=
, (T)
> > 4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
> > fio-3.38
> > Starting 1 thread
> > ...
> > Run status group 0 (all jobs):
> >    READ: bw=3D3311KiB/s (3391kB/s), 3311KiB/s-3311KiB/s
> > (3391kB/s-3391kB/s), io=3D48.5MiB (50.9MB), run=3D15001-15001msec
> >
> > iodepth=3D4
> > :~/fio-fio-3.38$ ./fio --name=3Drandread --rw=3Drandread
> > --ioengine=3Dio_uring --thread
> > --filename_format=3D'/home/abhishekmgupta_google_com/bucket/$jobnum'
> > --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D=
1
> > --iodepth=3D4 --group_reporting=3D1 --direct=3D1
> > randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B=
, (T)
> > 4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
> > fio-3.38
> > Starting 1 thread
> > ...
> > Run status group 0 (all jobs):
> >    READ: bw=3D11.0MiB/s (11.6MB/s), 11.0MiB/s-11.0MiB/s
> > (11.6MB/s-11.6MB/s), io=3D166MiB (174MB), run=3D15002-15002msec
> >
> >
> > On kernel 6.14
> >
> > :~$ uname -a
> > Linux abhishek-west4a-2504 6.14.0-1019-gcp #20-Ubuntu SMP Wed Oct 15
> > 00:41:12 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
> >
> > iodepth=3D1
> > :~$ fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --threa=
d
> > --filename_format=3D'/home/abhishekmgupta_google_com/bucket/$jobnum'
> > --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D=
1
> > --iodepth=3D1 --group_reporting=3D1 --direct=3D1
> > randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B=
, (T)
> > 4096B-4096B, ioengine=3Dio_uring, iodepth=3D1
> > fio-3.38
> > Starting 1 thread
> > ...
> > Run status group 0 (all jobs):
> >    READ: bw=3D3576KiB/s (3662kB/s), 3576KiB/s-3576KiB/s
> > (3662kB/s-3662kB/s), io=3D52.4MiB (54.9MB), run=3D15001-15001msec
> >
> > iodepth=3D4
> > :~$ fio --name=3Drandread --rw=3Drandread --ioengine=3Dio_uring --threa=
d
> > --filename_format=3D'/home/abhishekmgupta_google_com/bucket/$jobnum'
> > --filesize=3D1G --time_based=3D1 --runtime=3D15s --bs=3D4K --numjobs=3D=
1
> > --iodepth=3D4 --group_reporting=3D1 --direct=3D1
> > randread: (g=3D0): rw=3Drandread, bs=3D(R) 4096B-4096B, (W) 4096B-4096B=
, (T)
> > 4096B-4096B, ioengine=3Dio_uring, iodepth=3D4
> > fio-3.38
> > ...
> > Run status group 0 (all jobs):
> >    READ: bw=3D3863KiB/s (3956kB/s), 3863KiB/s-3863KiB/s
> > (3956kB/s-3956kB/s), io=3D56.6MiB (59.3MB), run=3D15001-15001msec
>
> assuming I would find some time over the weekend and with the fact that
> I don't know anything about google cloud, how can I reproduce this?
>
>
> Thanks,
> Bernd

