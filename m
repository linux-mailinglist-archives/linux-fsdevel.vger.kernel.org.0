Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C302F2D8590
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 11:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438478AbgLLJ6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Dec 2020 04:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbgLLJ6o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Dec 2020 04:58:44 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC57C0613CF;
        Sat, 12 Dec 2020 01:58:03 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z5so12072161iob.11;
        Sat, 12 Dec 2020 01:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VfC8U3+9RgAipJV6RtcOXOTncWoLx+pvsz+FVUtT+WM=;
        b=ru8KqwZkrp8biP002XsKcZ7D9aatn+KC/DegPBreXXE6ZS1KMc/Z2M2WmwW/rQAwED
         ySiXaA+fHXKjtOEjXJFmS2KxBd+ec+Y70LX4Pk7z9M8MhCoAVz4j/WRJOSNINxfivoGy
         GDqSbNVGtCAdz19ntqGL4YhucICczEsvnsIK1IohMq8G/GJvv7igdgtJbHYr5c2VYy50
         OVHwhsUVdRTzwCd+58mvjJX/NG+vDKlZIGZkYZRHzLMx6CAQnUEtILIwzXg1Uq3RjVYE
         qDu5NyFAlIQqGmdLaQeJVLB+LvzOD2Jaeq5oZt8QOdSM+BuYHHZiYGISF9bV2y0Udiqd
         iKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VfC8U3+9RgAipJV6RtcOXOTncWoLx+pvsz+FVUtT+WM=;
        b=B+j3aapKDBcQwzc9Au/qebRV0Q+pO36JCQfq9iMz/+OAs5FTQFwpI1RQTCz7ZZmT3V
         i759zfNoPOs4d1WBG1pkP2lsRbel+NORW37uDkyNDrKu+wE6qPvtpqU5/tt0PiYro39S
         s/OTgMDBMOyDT1Z4x8bJpX16Z7pxYNqv67PJLuPjijQls1FBbhVrwQVFa6Mjycqqr+E0
         jVl56+AvQuoEUk7o63/htXDvE7g7NhdaptFnoHVguofJTFtLLN9wyONcgc2ATGc0/pH7
         aqDKPXDkl2sv64Q91P4S7rY48uocnNnyW5qZ8HOcWpgvNqdznucZHndDc4oCD7t3pAGZ
         vF4g==
X-Gm-Message-State: AOAM533T2u9A/ir2n+U6DrAmFOpAN6leUROQyzXEwE7OH7vj04Ip1C92
        BuwKm2w5gbPdHtJQzJlqvT0JCqGLcoDjbg4XCQI=
X-Google-Smtp-Source: ABdhPJzmJSTtlvPRlby9CqpfmwXRf7R6w5YTMgILXhIqKEo4qqH4jQyqzvvTqqn3shcnX3rL3DHEDwbVItsF8VIsmMw=
X-Received: by 2002:a02:b607:: with SMTP id h7mr21485997jam.120.1607767083180;
 Sat, 12 Dec 2020 01:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20201211235002.4195-1-sargun@sargun.me> <20201211235002.4195-3-sargun@sargun.me>
In-Reply-To: <20201211235002.4195-3-sargun@sargun.me>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 12 Dec 2020 11:57:52 +0200
Message-ID: <CAOQ4uxgj8LztnH3vD7M=Lp_FoNhoLwaD4CcWQR0T1pd=pe2kgA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] errseq: Add mechanism to snapshot errseq_counter
 and check snapshot
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Forgot to CC Jeff?

On Sat, Dec 12, 2020 at 1:50 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This adds the function errseq_counter_sample to allow for "subscribers"
> to take point-in-time snapshots of the errseq_counter, and store the
> counter + errseq_t.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/linux/errseq.h |  4 ++++
>  lib/errseq.c           | 51 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/include/linux/errseq.h b/include/linux/errseq.h
> index 35818c484290..8998df499a3b 100644
> --- a/include/linux/errseq.h
> +++ b/include/linux/errseq.h
> @@ -25,4 +25,8 @@ errseq_t errseq_set(errseq_t *eseq, int err);
>  errseq_t errseq_sample(errseq_t *eseq);
>  int errseq_check(errseq_t *eseq, errseq_t since);
>  int errseq_check_and_advance(errseq_t *eseq, errseq_t *since);
> +void errseq_counter_sample(errseq_t *dst_errseq, int *dst_errors,
> +                          struct errseq_counter *counter);
> +int errseq_counter_check(struct errseq_counter *counter, errseq_t errseq_since,
> +                        int errors_since);
>  #endif
> diff --git a/lib/errseq.c b/lib/errseq.c
> index d555e7fc18d2..98fcfafa3d97 100644
> --- a/lib/errseq.c
> +++ b/lib/errseq.c
> @@ -246,3 +246,54 @@ int errseq_check_and_advance(errseq_t *eseq, errseq_t *since)
>         return err;
>  }
>  EXPORT_SYMBOL(errseq_check_and_advance);
> +
> +/**
> + * errseq_counter_sample() - Grab the current errseq_counter value
> + * @dst_errseq: The errseq_t to copy to
> + * @dst_errors: The destination overflow to copy to
> + * @counter: The errseq_counter to copy from
> + *
> + * Grabs a point in time sample of the errseq_counter for latter comparison
> + */
> +void errseq_counter_sample(errseq_t *dst_errseq, int *dst_errors,

Why 2 arguments and not struct errseq_counter *dst_counter?

> +                          struct errseq_counter *counter)
> +{
> +       errseq_t cur;
> +
> +       do {
> +               cur = READ_ONCE(counter->errseq);
> +               *dst_errors = atomic_read(&counter->errors);
> +       } while (cur != READ_ONCE(counter->errseq));

This loop seems odd. I think the return value should reflect the fact that
the snapshot failed and let the caller decide if it wants to loop.

And about the one and only introduced caller, I think the answer is that
it shouldn't loop. If volatile overlayfs mount tries to sample the upper sb
error counter and an unseen error exists, I argued before that I think
mount should fail, so that the container orchestrator can decide what to do.
Failure to take an errseq_counter sample means than an unseen error
has been observed at least in the first or second check.

> +
> +       /* Clear the seen bit to make checking later easier */
> +       *dst_errseq = cur & ~ERRSEQ_SEEN;
> +}
> +EXPORT_SYMBOL(errseq_counter_sample);
> +
> +/**
> + * errseq_counter_check() - Has an error occurred since the sample
> + * @counter: The errseq_counter from which to check.
> + * @errseq_since: The errseq_t sampled with errseq_counter_sample to check
> + * @errors_since: The errors sampled with errseq_counter_sample to check
> + *
> + * Returns: The latest error set in the errseq_t or 0 if there have been none.
> + */
> +int errseq_counter_check(struct errseq_counter *counter, errseq_t errseq_since,
> +                        int errors_since)
> +{
> +       errseq_t cur_errseq;
> +       int cur_errors;
> +
> +       cur_errors = atomic_read(&counter->errors);
> +       /* To match the barrier in errseq_counter_set */
> +       smp_rmb();
> +
> +       /* Clear / ignore the seen bit as we do at sample time */
> +       cur_errseq = READ_ONCE(counter->errseq) & ~ERRSEQ_SEEN;
> +
> +       if (cur_errseq == errseq_since && errors_since == cur_errors)
> +               return 0;
> +
> +       return -(cur_errseq & MAX_ERRNO);
> +}


Same here. Why not pass an errseq_counter_since argument?

Thanks,
Amir.
