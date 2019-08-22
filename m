Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACF99478
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732412AbfHVNHb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 09:07:31 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:35243 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfHVNHa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:07:30 -0400
Received: by mail-io1-f44.google.com with SMTP id b10so2589534ioj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UU9SQ34gGkQXgmf2SemOA6HtI5mrNhrFcQkyd5D8SMg=;
        b=imZQ/lEMvuyYOJiH2l3PvBzEEtdFxbOeq0YuIvqUjoeuiF0KlT3vr8gJUCbc03vAwC
         5JUlj8GTCzkUvQH9KRJ8ykRfwN0QVJyFG7aezy2pTGOcrOu+pN2VVdzpcZbSKtmDsRiZ
         1DbhF8xwgDw0tZgsegHzpb6MmdyOkw4maf6gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UU9SQ34gGkQXgmf2SemOA6HtI5mrNhrFcQkyd5D8SMg=;
        b=dPmRUIxfEIqQGKgNtVj/z/4xFzGr3reEpVM5MoAblo1U+h9VzjnRV0gW/Qzh24U4pC
         00Z0Fv7Zm/0KoMn+Zkr2jS1hvY1D2v26IVlEgsYpblu+ToR7SNAJZUb4rLcO6uIkY5tt
         mTPOh7isqNfHb/PU8xZHvxsN0F0oacuoN5gIR3RtjNLqsuk3jSA9XgpzzsZT6gaNFR4G
         VgjqpC0qLewN+cLtGXe4vdRl6V9vMg8q25cxp2l8VyfeccyjOIzqB22fjP0PKnOLmYG/
         vb2rigf8V+CMxJyTMVLR1OMJ7EPHF2ZrhPMrpEVK0qmFZqY1ayvq1kMs25VstLGvZWMz
         bSfg==
X-Gm-Message-State: APjAAAWK8SjUXu/DodW3ZgHF6yrJwZD8f778GDjJgcedLv7FhlIouV8r
        UOiAFFhiWJioLFc1ZIjAZtNGuagOdMv8dD2EcAM6VQ==
X-Google-Smtp-Source: APXvYqzWHf/i+MvQM+UU9SmV1/dfIsdG1OwfZ4elb80GurgeFrjh/PITJde44x/inGuEC9VDXM+5Kelmvu6XhTMYAhQ=
X-Received: by 2002:a02:b604:: with SMTP id h4mr15494615jam.78.1566479249879;
 Thu, 22 Aug 2019 06:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <5abd7616-5351-761c-0c14-21d511251006@huawei.com>
 <20190820091650.GE9855@stefanha-x1.localdomain> <CAJfpegs8fSLoUaWKhC1543Hoy9821vq8=nYZy-pw1+95+Yv4gQ@mail.gmail.com>
 <20190821160551.GD9095@stefanha-x1.localdomain> <954b5f8a-4007-f29c-f38e-dd5585879541@huawei.com>
 <CAJfpegtBYLJLWM8GJ1h66PMf2J9o38FG6udcd2hmamEEQddf5w@mail.gmail.com> <0e8090c7-0c7c-bcbe-af75-33054d3a3efb@huawei.com>
In-Reply-To: <0e8090c7-0c7c-bcbe-af75-33054d3a3efb@huawei.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 22 Aug 2019 15:07:18 +0200
Message-ID: <CAJfpegurYLAApon5Ai6Q33vEy+GPxtOTUwDCCbJ2JAbg4csDSg@mail.gmail.com>
Subject: Re: [Virtio-fs] [QUESTION] A performance problem for buffer write
 compared with 9p
To:     wangyan <wangyan122@huawei.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 2:48 PM wangyan <wangyan122@huawei.com> wrote:
>
> On 2019/8/22 19:43, Miklos Szeredi wrote:
> > On Thu, Aug 22, 2019 at 2:59 AM wangyan <wangyan122@huawei.com> wrote:
> >> I will test it when I get the patch, and post the compared result with
> >> 9p.
> >
> > Could you please try the attached patch?  My guess is that it should
> > improve the performance, perhaps by a big margin.
> >
> > Further improvement is possible by eliminating page copies, but that
> > is less trivial.
> >
> > Thanks,
> > Miklos
> >
> Using the same test model. And the test result is:
>         1. Latency
>                 virtiofs: avg-lat is 15.40 usec, bigger than before(6.64 usec).
>                 4K: (g=0): rw=write, bs=4K-4K/4K-4K/4K-4K, ioengine=psync, iodepth=1
>                 fio-2.13
>                 Starting 1 process
>                 Jobs: 1 (f=1): [W(1)] [100.0% done] [0KB/142.4MB/0KB /s] [0/36.5K/0
> iops] [eta 00m:00s]
>                 4K: (groupid=0, jobs=1): err= 0: pid=5528: Thu Aug 22 20:39:07 2019
>                   write: io=6633.2MB, bw=226404KB/s, iops=56600, runt= 30001msec
>                         clat (usec): min=2, max=40403, avg=14.77, stdev=33.71
>                          lat (usec): min=3, max=40404, avg=15.40, stdev=33.74
>
>         2. Bandwidth
>                 virtiofs: bandwidth is 280840KB/s, lower than before(691894KB/s).
>                 1M: (g=0): rw=write, bs=1M-1M/1M-1M/1M-1M, ioengine=psync, iodepth=1
>                 fio-2.13
>                 Starting 1 process
>                 Jobs: 1 (f=1): [f(1)] [100.0% done] [0KB/29755KB/0KB /s] [0/29/0 iops]
> [eta 00m:00s]
>                 1M: (groupid=0, jobs=1): err= 0: pid=5550: Thu Aug 22 20:41:28 2019
>                   write: io=8228.0MB, bw=280840KB/s, iops=274, runt= 30001msec
>                         clat (usec): min=362, max=11038, avg=3571.33, stdev=1062.72
>                          lat (usec): min=411, max=11093, avg=3628.39, stdev=1064.53
>
> According to the result, the patch doesn't work and make it worse than
> before.

Is server started with "-owriteback"?

Thanks,
Miklos
