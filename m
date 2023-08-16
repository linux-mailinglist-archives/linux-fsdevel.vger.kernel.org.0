Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1243277E92B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 21:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbjHPS7a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345588AbjHPS7C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:59:02 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79FB26BE
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 11:59:01 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-78f1210e27fso1941772241.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692212341; x=1692817141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6GV2HPc32HlYLalU5njQK2neKHZGDPxPt2xNFyTPC4=;
        b=LE9xmfkkKAvCJk5hFfVz9rI/GeNG9potMNr1LhIggodbpwjEFrn9JIpv4po8phBZqW
         OW8xuUir79O9td9VTwWX4Xqc8GY6eS5/r0hlMj1TkHTX6OAwLVNxlvnSwp6ztbNpG+ds
         R+IJmKpqnk/TMCLqGMfFO2wI6v+YBJPVw16NUUT4qb9ucbgBHW5wl/JX2tjFNLM8aaYy
         HuMHv17JWTWjrA+LvAee2/r6k3CsvwdpVSfnND9sNwPdd6hPNrQBzQEJ8t59g5XbLsTa
         ZLZ1PrSUquFmTfm17qvzNoIo4+JiH/pvAqau5rObfeQjB3nrn3MHXzHokQv4y5hiZF/c
         KDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692212341; x=1692817141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6GV2HPc32HlYLalU5njQK2neKHZGDPxPt2xNFyTPC4=;
        b=aOoAMPsOG9P05qiXZ0QeHl517XHsO8g9P7vHDdtvkPGXSFgnoLNz8ijMwJEydSKwut
         EVyLZKZTQvR7BstTRDt8+Rxs5njMeRhIm6rhuvtWAQjgtnY5YF9r2hxqGCOTlppQaL0P
         4rgJyI3BH1VY3fKKKgoTuGq6rswHaFCbmt9lTWy+XonlKFFw9YzxcN9eTmgFy0IQBGr7
         bZDPIRd8V3AjFYwvrb5wr+zISafAShrTvFOam/8FmiVqDzi4QNR65aEOqd7zpGIjDFwU
         t2uiS5r5dj4M7aS6/ORuFp3cL986Vuw0juWydZsnQ21GTCYPlHqBJ50mHJbW5aR/xJTL
         lPZQ==
X-Gm-Message-State: AOJu0YwhhVwgmdCTaK46MEASzMyT67YkWWzoOso3CNrAwX3IC2FPFqO1
        tyvmUV5oMYBleT4DxUTMAj2eLKKiPrtLB01fHok=
X-Google-Smtp-Source: AGHT+IEuHxOjufz2uich5VVCR2tfOKy54w/JSnqsMmsKi8Gyi3FEYM2B7ZBmlljgCbQyJDqRv4MPA9MP8mfriYdFHcY=
X-Received: by 2002:a05:6102:396:b0:443:8ca0:87a7 with SMTP id
 m22-20020a056102039600b004438ca087a7mr2442129vsq.7.1692212340718; Wed, 16 Aug
 2023 11:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230816085439.894112-1-amir73il@gmail.com> <7725feff-8d9d-4b54-9910-951b79f67596@kernel.dk>
In-Reply-To: <7725feff-8d9d-4b54-9910-951b79f67596@kernel.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 16 Aug 2023 21:58:49 +0300
Message-ID: <CAOQ4uxggGRdhyRL15b_nVuf9PHejfXmF+auxY7HPkhJVYmsnCg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: create kiocb_{start,end}_write() helpers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 16, 2023 at 6:28=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/16/23 2:54 AM, Amir Goldstein wrote:
> > aio, io_uring, cachefiles and overlayfs, all open code an ugly variant
> > of file_{start,end}_write() to silence lockdep warnings.
> >
> > Create helpers for this lockdep dance and use the helpers in all the
> > callers.
> >
> > Use a new iocb flag IOCB_WRITE_STARTED to indicate if sb_start_write()
> > was called.
>
> Looks better now, but I think you should split this into a prep patch
> that adds the helpers, and then one for each conversion. We've had bugs
> with this accounting before which causes fs freeze issues, would be
> prudent to have it split because of that.
>

Sure, no problem.

> > diff --git a/fs/aio.c b/fs/aio.c
> > index 77e33619de40..16fb3ac2093b 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -1444,17 +1444,8 @@ static void aio_complete_rw(struct kiocb *kiocb,=
 long res)
> >       if (!list_empty_careful(&iocb->ki_list))
> >               aio_remove_iocb(iocb);
> >
> > -     if (kiocb->ki_flags & IOCB_WRITE) {
> > -             struct inode *inode =3D file_inode(kiocb->ki_filp);
> > -
> > -             /*
> > -              * Tell lockdep we inherited freeze protection from submi=
ssion
> > -              * thread.
> > -              */
> > -             if (S_ISREG(inode->i_mode))
> > -                     __sb_writers_acquired(inode->i_sb, SB_FREEZE_WRIT=
E);
> > -             file_end_write(kiocb->ki_filp);
> > -     }
> > +     if (kiocb->ki_flags & IOCB_WRITE)
> > +             kiocb_end_write(kiocb);
>
> Can't we just call kiocb_end_write() here, it checks WRITE_STARTED
> anyway? Not a big deal, and honestly I'd rather just get rid of
> WRITE_STARTED if we're not using it like that. It doesn't serve much of
> a purpose, if we're gating this one IOCB_WRITE anyway (which I do like
> better than WRITE_STARTED). And it avoids writing to the kiocb at the
> end too, which is a nice win.
>

What I don't like about it is that kiocb_{start,end}_write() calls will
not be balanced, so it is harder for a code reviewer to realize that the
code is correct (as opposed to have excess end_write calls).
That's the reason I had ISREG check inside the helpers in v1, so like
file_{start,end}_write(), the calls will be balanced and easy to review.

I am not sure, but I think that getting rid of WRITE_STARTED will
make the code more subtle, because right now, IOCB_WRITE is
not set by kiocb_start_write() and many times it is set much sooner.
So I'd rather keep the WRITE_STARTED flag for a more roust code
if that's ok with you.

> > index b2adee67f9b2..8e5d410a1be5 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -338,6 +338,8 @@ enum rw_hint {
> >  #define IOCB_NOIO            (1 << 20)
> >  /* can use bio alloc cache */
> >  #define IOCB_ALLOC_CACHE     (1 << 21)
> > +/* file_start_write() was called */
> > +#define IOCB_WRITE_STARTED   (1 << 22)
> >
> >  /* for use in trace events */
> >  #define TRACE_IOCB_STRINGS \
> > @@ -351,7 +353,8 @@ enum rw_hint {
> >       { IOCB_WRITE,           "WRITE" }, \
> >       { IOCB_WAITQ,           "WAITQ" }, \
> >       { IOCB_NOIO,            "NOIO" }, \
> > -     { IOCB_ALLOC_CACHE,     "ALLOC_CACHE" }
> > +     { IOCB_ALLOC_CACHE,     "ALLOC_CACHE" }, \
> > +     { IOCB_WRITE_STARTED,   "WRITE_STARTED" }
> >
> >  struct kiocb {
> >       struct file             *ki_filp;
>
> These changes will conflict with other changes in linux-next that are
> going upstream. I'd prefer to stage this one after those changes, once
> we get to a version that looks good to everybody.

Changes coming to linux-next from your tree?
I was basing my patches on Christian's vfs.all branch.
Do you mean that you would like to stage this cleanup?
It's fine by me.

Thanks,
Amir.
