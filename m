Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF0BA051C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfH1OiM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 10:38:12 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45467 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1OiM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:38:12 -0400
Received: by mail-io1-f66.google.com with SMTP id t3so6221373ioj.12;
        Wed, 28 Aug 2019 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G5udQkW/CM2lxlViX/26GN8cs4HunMByYhQD6+dx7mc=;
        b=pdLrAkH/k8QFoMQhZgs8HaZrHnvCDVfywCMzjjARVmam2Vm+uBgdLIVgLodKWzC7jZ
         bjLaH5cjyLKVzTNzk3Svzo0X5H69V5ZA3cjYNPVD+9U3hfi2RiOi2ucZYMJSbJGtK0QJ
         CnUYMK9/2JFUx14RVA4dEHe/sEY1gUCBrasd2O0O08OEgBKDZovxe9+iaQUkv29Cq1Kp
         Y4YAqdATkcpbvfqSu7gbWD0br+VHyJNsydRy6WKTimt7Da0bI56m5wa0fo2yrKPMZZ5G
         PxITZ+g0J10gA7PyL72B89p55jebyF6AEvETm3C1OvAoFQy/nsUIfm49nSvAORfdpkJa
         vUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G5udQkW/CM2lxlViX/26GN8cs4HunMByYhQD6+dx7mc=;
        b=TPQrG7AdlvzQFDnBLStFL8eG4/Fq0yHpvGJLhDRnK0WJXgtJ7a1dt0lVuAet8oKkdL
         NMuacuCHphfd0aVi9m4PMVnEbSsXCCnKYyMEi2wsZNoRDLq2wOS0oOOmiiNYJKukrGEf
         e6ZKp9sUQXYOtW0KFuySkNlLVBLKigSbq092uHBX8o4dUQF3zNnLdT6Tf9zeO6zfZCB3
         YkyAFLQ282GEV3Z1ATPbzyds4seCWsI8oXlpTwjHN4nV2PbCQXC8Hi0OvVE5eu6EAZJg
         HU+vdAklJuaWndeTtkhTc8dkwBE7NDyzqM4gZ91P7anAwa0wziHfP26Hfe+qdZ3NZRIc
         V6/g==
X-Gm-Message-State: APjAAAXA6uzZ7JWvddC7lBKpi4zlZR5D6/QUcs2QMKdmL2AYQIkZGlEq
        k/AroYgGaN9PTnv3+G1MMojb0UZmBvqRBfdxlhY=
X-Google-Smtp-Source: APXvYqy0VFM3NLgaj2QrNG/mcXAuZZBb3xoVXU7zi5NXBF72Oi/AEK00tMZIlYBogfH8+OAXIqqwPP+N7gdbE/5bnJc=
X-Received: by 2002:a5e:9314:: with SMTP id k20mr4661621iom.245.1567003090860;
 Wed, 28 Aug 2019 07:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181202180832.GR8125@magnolia> <20181202181045.GS8125@magnolia>
 <CAHpGcM+WQYFHOOC8SzKq+=DuHVZ4fw4RHLTMUDN-o6GX3YtGvQ@mail.gmail.com> <20190828142332.GT1037422@magnolia>
In-Reply-To: <20190828142332.GT1037422@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Wed, 28 Aug 2019 16:37:59 +0200
Message-ID: <CAHpGcMLGWVssWAC1PqBJevr1+1rE_hj4QN27D26j7-Fp_Kzpsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iomap: partially revert 4721a601099 (simulated
 directio short read on EFAULT)
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, jencce.kernel@gmail.com,
        linux-xfs <linux-xfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Mi., 28. Aug. 2019 um 16:23 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> On Wed, Aug 21, 2019 at 10:23:49PM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Hi Darrick,
> >
> > Am So., 2. Dez. 2018 um 19:13 Uhr schrieb Darrick J. Wong
> > <darrick.wong@oracle.com>:
> > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > >
> > > In commit 4721a601099, we tried to fix a problem wherein directio rea=
ds
> > > into a splice pipe will bounce EFAULT/EAGAIN all the way out to
> > > userspace by simulating a zero-byte short read.  This happens because
> > > some directio read implementations (xfs) will call
> > > bio_iov_iter_get_pages to grab pipe buffer pages and issue asynchrono=
us
> > > reads, but as soon as we run out of pipe buffers that _get_pages call
> > > returns EFAULT, which the splice code translates to EAGAIN and bounce=
s
> > > out to userspace.
> > >
> > > In that commit, the iomap code catches the EFAULT and simulates a
> > > zero-byte read, but that causes assertion errors on regular splice re=
ads
> > > because xfs doesn't allow short directio reads.  This causes infinite
> > > splice() loops and assertion failures on generic/095 on overlayfs
> > > because xfs only permit total success or total failure of a directio
> > > operation.  The underlying issue in the pipe splice code has now been
> > > fixed by changing the pipe splice loop to avoid avoid reading more da=
ta
> > > than there is space in the pipe.
> > >
> > > Therefore, it's no longer necessary to simulate the short directio, s=
o
> > > remove the hack from iomap.
> > >
> > > Fixes: 4721a601099 ("iomap: dio data corruption and spurious errors w=
hen pipes fill")
> > > Reported-by: Amir Goldstein <amir73il@gmail.com>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > ---
> > > v2: split into two patches per hch request
> > > ---
> > >  fs/iomap.c |    9 ---------
> > >  1 file changed, 9 deletions(-)
> > >
> > > diff --git a/fs/iomap.c b/fs/iomap.c
> > > index 3ffb776fbebe..d6bc98ae8d35 100644
> > > --- a/fs/iomap.c
> > > +++ b/fs/iomap.c
> > > @@ -1877,15 +1877,6 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_it=
er *iter,
> > >                                 dio->wait_for_completion =3D true;
> > >                                 ret =3D 0;
> > >                         }
> > > -
> > > -                       /*
> > > -                        * Splicing to pipes can fail on a full pipe.=
 We have to
> > > -                        * swallow this to make it look like a short =
IO
> > > -                        * otherwise the higher splice layers will co=
mpletely
> > > -                        * mishandle the error and stop moving data.
> > > -                        */
> > > -                       if (ret =3D=3D -EFAULT)
> > > -                               ret =3D 0;
> > >                         break;
> > >                 }
> > >                 pos +=3D ret;
> >
> > I'm afraid this breaks the following test case on xfs and gfs2, the
> > two current users of iomap_dio_rw.
>
> Hmm, I had kinda wondered if regular pipes still needed this help.
> Evidently we don't have a lot of splice tests in fstests. :(

So what do you suggest as a fix?

> > Here, the splice system call fails with errno =3D EAGAIN when trying to
> > "move data" from a file opened with O_DIRECT into a pipe.
> >
> > The test case can be run with option -d to not use O_DIRECT, which
> > makes the test succeed.
> >
> > The -r option switches from reading from the pipe sequentially to
> > reading concurrently with the splice, which doesn't change the
> > behavior.
> >
> > Any thoughts?
>
> This would be great as an xfstest! :)

Or perhaps something generalized from it.

> Do you have one ready to go, or should I just make one from the source
> code?

The bug originally triggered in our internal cluster test system and
I've recreated the test case I've included from the strace. That's all
I have for now; feel free to take it, of course.

It could be that the same condition can be triggered with one of the
existing utilities (fio/fsstress/...).

Thanks,
Andreas
