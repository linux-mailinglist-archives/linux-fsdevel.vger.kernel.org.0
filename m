Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC20523C6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 20:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiEKS0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345708AbiEKS0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 14:26:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77B363BD3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 11:26:29 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id b20so2922478qkc.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oT5uWhlpLHEZBYxsV/eOdQuIeMF41dNQUujQp/51q/s=;
        b=lSsm8LwjIvciyx0w4hinAovGa4bhVdU30odOGvrAiwgmKeWrua4zSMnMR1wr3erOdZ
         y41fXjj1lXrLNXecJPErzHvlfm3jjtNgU6wZ9HwzcG9sk7iz5Jpgu4bJZ5W12FXrFSh8
         jX0oT6+IlgZGqwC1ZyFZ5DHpebgbc4AfNmouKL9A0Teyo0ThvRSTdksgkos6TkeBbZa/
         f5I4+2Z53hI18w60BekgM4MI//xRenkc4ewMirnG6NUFv6EKcpeBpqN6VvzgPoGE6HdQ
         bHEw3wARKmV3Z3vtbY6l/OXi/SoyHX7BXNY33nQkJnUDdHnRTqZa+ro5NXJTds4E0RuE
         eMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oT5uWhlpLHEZBYxsV/eOdQuIeMF41dNQUujQp/51q/s=;
        b=v51Jd/2YLboKJ7KqKPrSjsYwJ232ZdqEnRWIHU9OwfvAR0XIeaUBzvfkCCVE1wLXVu
         JGcJ+vGLHss/YcvyTor+qhRKwWbVixQa0DWpRhO0L1V4UWJakIPq60sM7lBZeHVzrAeq
         r12Hqqhih6NQIx1Hokiijg50gAQmRwLip1krEOXjYbH3rZ1oW4OdWA4BmRCJbCgNVtY0
         BHhmUjOeMHet8t2hv3MI+wnhEBZvyutS3HOL9DEb6IN2pcTDBMm6/iYOo5kDCUHvQgEr
         ki+KnazTx/mt82Nc/hNtpJetXGbaP32XYxxBk2PslvYRUgB0HrybgFOZ6JFi9Z3HnHX3
         5o9Q==
X-Gm-Message-State: AOAM53142BFqbI143Vj/K1x8BgPyTPEaENsMOrBCvU6awgYiCOHgEWID
        TYkI3UKiELHMPZ9xPx+bAWIOaa+gRETBPCP1tOM=
X-Google-Smtp-Source: ABdhPJzfIqwsl74IX37DPSZKEdazkEdVTWFz2oew3LHV+EVr/W/31msGYoxsKJmFBtKjFsDLZlui3E8+m6MofmCShCU=
X-Received: by 2002:a37:8846:0:b0:6a0:f6f1:a015 with SMTP id
 k67-20020a378846000000b006a0f6f1a015mr1127973qkd.386.1652293588429; Wed, 11
 May 2022 11:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220511092914.731897-1-amir73il@gmail.com> <20220511092914.731897-2-amir73il@gmail.com>
 <20220511125440.5zsuzn7eemdvfksi@quack3.lan>
In-Reply-To: <20220511125440.5zsuzn7eemdvfksi@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 11 May 2022 21:26:16 +0300
Message-ID: <CAOQ4uxjjfaU4xefu1-qK5MzGq+m0EChB9mK6TZo1Lp6bmBviUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fsnotify: introduce mark type iterator
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 3:54 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 11-05-22 12:29:13, Amir Goldstein wrote:
> > fsnotify_foreach_iter_mark_type() is used to reduce boilerplate code
> > of iteratating all marks of a specific group interested in an event
> > by consulting the iterator report_mask.
> >
> > Use an open coded version of that iterator in fsnotify_iter_next()
> > that collects all marks of the current iteration group without
> > consulting the iterator report_mask.
> >
> > At the moment, the two iterator variants are the same, but this
> > decoupling will allow us to exclude some of the group's marks from
> > reporting the event, for example for event on child and inode marks
> > on parent did not request to watch events on children.
> >
> > Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events on child and on dir")
> > Reported-by: Jan Kara <jack@suse.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Mostly looks good. Two nits below.
>
> >  /*
> > - * Pop from iter_info multi head queue, the marks that were iterated in the
> > + * Pop from iter_info multi head queue, the marks that belong to the group of
> >   * current iteration step.
> >   */
> >  static void fsnotify_iter_next(struct fsnotify_iter_info *iter_info)
> >  {
> > +     struct fsnotify_mark *mark;
> >       int type;
> >
> >       fsnotify_foreach_iter_type(type) {
> > -             if (fsnotify_iter_should_report_type(iter_info, type))
> > +             mark = iter_info->marks[type];
> > +             if (mark && mark->group == iter_info->current_group)
> >                       iter_info->marks[type] =
> >                               fsnotify_next_mark(iter_info->marks[type]);
>
> Wouldn't it be more natural here to use the new helper
> fsnotify_foreach_iter_mark_type()? In principle we want to advance mark
> types which were already reported...

Took me an embarrassing amount of time to figure out why this would be wrong
and I must have known this a few weeks ago when I wrote the patch, so
a comment is in order:

        /*
         * We cannot use fsnotify_foreach_iter_mark_type() here because we
         * may need to check if next group has a mark of type X even if current
         * group did not have a mark of type X.
         */

>
> > @@ -438,6 +438,9 @@ FSNOTIFY_ITER_FUNCS(sb, SB)
> >
> >  #define fsnotify_foreach_iter_type(type) \
> >       for (type = 0; type < FSNOTIFY_ITER_TYPE_COUNT; type++)
> > +#define fsnotify_foreach_iter_mark_type(iter, mark, type) \
> > +     for (type = 0; type < FSNOTIFY_ITER_TYPE_COUNT; type++) \
> > +             if (!(mark = fsnotify_iter_mark(iter, type))) {} else
>
> Hum, you're really inventive here ;) I'd rather go for something a bit more
> conservative and readable like:

It's good that you are here to restrain me ;-)

>
> static inline int fsnotify_iter_step(struct fsnotify_iter_info *iter, int type,
>                                      struct fsnotify_mark **markp)
> {
>         while (type < FSNOTIFY_ITER_TYPE_COUNT) {
>                 *markp = fsnotify_iter_mark(iter, type);
>                 if (*markp)
>                         break;
>                 type++;
>         }
>         return type;
> }
>
> #define fsnotify_foreach_iter_mark_type(iter, mark, type) \
>         for (type = 0; \
>              (type = fsnotify_iter_step(iter, type, &mark)) < FSNOTIFY_ITER_TYPE_COUNT; \
>              type++)
>
>

That looks nicer.

Thanks,
Amir.
