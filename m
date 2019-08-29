Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A63A1956
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfH2Ltm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 07:49:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44999 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfH2Ltl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:49:41 -0400
Received: by mail-io1-f68.google.com with SMTP id j4so6197035iog.11;
        Thu, 29 Aug 2019 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebi6DvryipDbJMt7Vs5Y6UzNPCCfjozPAm+m3gRZ1cY=;
        b=HnQVcABTef4wmDs+EEBqAROiuUJ/fDy5haGSBWNMqg0NyQEcuu3kMeOtyJK3LLYX87
         97PGFzvGKf5em+PrI8Q4mUkHKPD3A6Wps0Wb6HJM5OpKbp8tlsekl5obLa6vti/pUQv8
         k4rwFFOJcg5+v/GQUbRaOXaQcTwfidXLu8zkeLfERuauyWsazilRoiBkD1RrercIaaU+
         IsgvbSbifqYV70hFWGZP7QXrGk3GBSTON+oM6ft4TQM63fOm7IYqOL6X3iSGQ9oCHdE7
         JAuoLdWYFiS4VQgFsP2lDQbZza3261q60moRPMIsTdBCAW6LRqrvYOB0mC683lLWiiNu
         ZTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebi6DvryipDbJMt7Vs5Y6UzNPCCfjozPAm+m3gRZ1cY=;
        b=uV1coI3ZnELNVqwW6qLAov4HxfoN8rWneufAyDsFxJxvcORFnxnE7L8EfGrCkomT8l
         egmsuIUukfI6icdvo3gDEwHjw7wkTOm3N8isxz3hjhMrETIDOzfdYqJM/BJkqg5lTHAA
         T/R9Nsz2JboeXElMctj/xcph/UA5XUaRS8c4WjwTdK1FZalRVQCVvrxqeddopjX7JVzs
         NSLnFPZUytZzZvWJBPAFboRcA5/+vyGIN8aXHojXmfOmbWfbFvEjJQoSf58hKDcdlGDO
         3Kh6i2lQ+FaqRpNeWXEgKQEBKl2kdIjNSbXSlUzTBWWQoq1zmPexZBGGjXOBwS0zoVQv
         DTpw==
X-Gm-Message-State: APjAAAVExV0hzGS50yxOeAGlV3398O11bvN89A+C7dh4KIAs5sCdUoDS
        RXXLQ+f+C7ymXBXg619+ek0e9zk7Kjl1G1DnXmw=
X-Google-Smtp-Source: APXvYqwENsRASBmSEOl6YE44hcCuRaYScqwow/qESu/tkVMsG2dt16pzNKaq9E5EKUIWbFl1OAlxQl2yEGWsVIScfz8=
X-Received: by 2002:a6b:7002:: with SMTP id l2mr2304538ioc.300.1567079380885;
 Thu, 29 Aug 2019 04:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20181202180832.GR8125@magnolia> <20181202181045.GS8125@magnolia>
 <CAHpGcM+WQYFHOOC8SzKq+=DuHVZ4fw4RHLTMUDN-o6GX3YtGvQ@mail.gmail.com>
 <20190828142332.GT1037422@magnolia> <CAHpGcMLGWVssWAC1PqBJevr1+1rE_hj4QN27D26j7-Fp_Kzpsg@mail.gmail.com>
 <20190829031216.GW1037422@magnolia>
In-Reply-To: <20190829031216.GW1037422@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Thu, 29 Aug 2019 13:49:29 +0200
Message-ID: <CAHpGcM+Aq+BxD0_TPx9sqTCt8N6X3Q+UO6CkyfV3NZMaN8AU8w@mail.gmail.com>
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
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

Am Do., 29. Aug. 2019 um 05:12 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> Hm, so I made an xfstest out of the program you sent me, and indeed
> reverting that chunk makes the failure go away, but that got me
> wondering -- that iomap kludge was a workaround for the splice code
> telling iomap to try to stuff XXXX bytes into a pipe that only has X
> bytes of free buffer space.  We fixed splice_direct_to_actor to clamp
> the length parameter to the available pipe space, but we never did the
> same to do_splice:
>
>         /* Don't try to read more the pipe has space for. */
>         read_len = min_t(size_t, len,
>                          (pipe->buffers - pipe->nrbufs) << PAGE_SHIFT);
>         ret = do_splice_to(in, &pos, pipe, read_len, flags);
>
> Applying similar logic to the two (opipe != NULL) cases of do_splice()
> seem to make the EAGAIN problem go away too.  So why don't we teach
> do_splice to only ask for as many bytes as the pipe has space here too?
>
> Does the following patch fix it for you?

Yes, that works, thank you.

> From: Darrick J. Wong <darrick.wong@oracle.com>
> Subject: [PATCH] splice: only read in as much information as there is pipe buffer space
>
> Andreas Gruenbacher reports that on the two filesystems that support
> iomap directio, it's possible for splice() to return -EAGAIN (instead of
> a short splice) if the pipe being written to has less space available in
> its pipe buffers than the length supplied by the calling process.
>
> Months ago we fixed splice_direct_to_actor to clamp the length of the
> read request to the size of the splice pipe.  Do the same to do_splice.

Can you add a reference to that commit here (17614445576b6)?

> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>  fs/splice.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 98412721f056..50335515d7c1 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1101,6 +1101,7 @@ static long do_splice(struct file *in, loff_t __user *off_in,
>         struct pipe_inode_info *ipipe;
>         struct pipe_inode_info *opipe;
>         loff_t offset;
> +       unsigned int pipe_pages;
>         long ret;
>
>         ipipe = get_pipe_info(in);
> @@ -1123,6 +1124,10 @@ static long do_splice(struct file *in, loff_t __user *off_in,
>                 if ((in->f_flags | out->f_flags) & O_NONBLOCK)
>                         flags |= SPLICE_F_NONBLOCK;
>
> +               /* Don't try to read more the pipe has space for. */
> +               pipe_pages = opipe->buffers - opipe->nrbufs;
> +               len = min_t(size_t, len, pipe_pages << PAGE_SHIFT);

This should probably be min(len, (size_t)pipe_pages << PAGE_SHIFT).
Same for the second min_t here and the one added by commit
17614445576b6.

> +
>                 return splice_pipe_to_pipe(ipipe, opipe, len, flags);
>         }
>
> @@ -1180,8 +1185,13 @@ static long do_splice(struct file *in, loff_t __user *off_in,
>
>                 pipe_lock(opipe);
>                 ret = wait_for_space(opipe, flags);
> -               if (!ret)
> +               if (!ret) {
> +                       /* Don't try to read more the pipe has space for. */
> +                       pipe_pages = opipe->buffers - opipe->nrbufs;
> +                       len = min_t(size_t, len, pipe_pages << PAGE_SHIFT);
> +
>                         ret = do_splice_to(in, &offset, opipe, len, flags);
> +               }
>                 pipe_unlock(opipe);
>                 if (ret > 0)
>                         wakeup_pipe_readers(opipe);

Thanks,
Andreas
