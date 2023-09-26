Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEBC7AF165
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 18:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbjIZQ4a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233879AbjIZQ43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:56:29 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EFCDE
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 09:56:22 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so2889175241.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 09:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695747382; x=1696352182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK+EbhQiFd3Of5u9BEitb4yBuyy8eNTwq30yPlpLJDg=;
        b=nDNPV72MbpiJbzm4PU2QY8fsyvWMEBhzjcYICgOoXFt1gD6h9vyxYlHJfLnVP8Mp6S
         u5+KM/kxqs1tCrnJj3xXCVKa38dHje1iv+jy84hd4qQ+idsd14eNWyjISApqBrRjibme
         W9Yfu62hCs1A7C9CSl/tRDI6OfiLsiEe1hZYAUIx0ukXeV3GCTp3a69CIY+rNNbL8OiH
         c8Z6RtjvflM2mcxuY5WO7srg08PuVF0eWKDkCQz4COjN4X101tTEnakFvexPG8SCCh5K
         hcS9exM2+jX6AbuVn8YV3vZ4vjmCozb7HMOQTJtybN5Q9M9KZgtCthDGMeRNh+i1axcX
         6FaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695747382; x=1696352182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yK+EbhQiFd3Of5u9BEitb4yBuyy8eNTwq30yPlpLJDg=;
        b=OxTs9IxufVEYsP/+VL8SgnOo0UwK4q7tzduCfiS7K/ZANfVJIZHuboJvPB8ZSQiBKI
         UnJ3pxv2/pKq98Bfj2fJa7rBaXQn8vGyxSdQqCHv5LOQJLTzcfWbLyF7pTLs5ikE7h0w
         /o4XlpSIFiougLipC/VUHEpjmPEWFXHJJ76a+OmYLaIfCrZjnpjJgdhemtXXZucP5IWH
         t/j9Vpi1Mtr53v/4irmKdRQnqcyrV8v+qWIw7uyG0kK5hERMoz5KKAQ12ANFTroDSWvi
         syMMZcY8NEDvExwBwCyus63fkBaLuXGYlx3RQB1cW+mY5by6bx10eppw27KZOMVfdLSd
         0/kg==
X-Gm-Message-State: AOJu0YykRddtJvR19e7qgiPuIZtjLbFP6Dvpuebfu+YFW9A7/0W37APK
        qcAmx2A2BJ+77j6tf5LeA91AU94nYf76GVDSVZE=
X-Google-Smtp-Source: AGHT+IFSiu8q6wt1fT+nlL/NG4T0Li46I4mSwfh1LiWHuToXQaY8bELEHmaFKzL4RtG2I4nW/Mw+B0po8BfjlO5Hr8g=
X-Received: by 2002:a05:6102:e4b:b0:451:560:899e with SMTP id
 p11-20020a0561020e4b00b004510560899emr7611670vst.22.1695747381695; Tue, 26
 Sep 2023 09:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <20230519125705.598234-9-amir73il@gmail.com>
 <CAP4dvsdpJFrEJRdUQqT-0bAX3FjSVg75-07Q0qac7XCtL63F8g@mail.gmail.com>
 <CAOQ4uxh5EFz-50vBLnfd0_+4uzg6v7Vd_6Wg4yE7uYn3+i3uoQ@mail.gmail.com>
 <1dea57e7-87d0-4ed7-9142-3a46dab73805@kernel.dk> <CAOQ4uxgdUjr7JLDViyf_c3is69KCuTg46WS+pkJXxgqCH5_=Bg@mail.gmail.com>
 <8620dfd3-372d-4ae0-aa3f-2fe97dda1bca@kernel.dk>
In-Reply-To: <8620dfd3-372d-4ae0-aa3f-2fe97dda1bca@kernel.dk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 26 Sep 2023 19:56:10 +0300
Message-ID: <CAOQ4uxh6iBEik33TxBy-AewqN+hyps-a3P8qVb6nrL_cmQA9Kw@mail.gmail.com>
Subject: Re: [External] [PATCH v13 08/10] fuse: update inode size/mtime after
 passthrough write
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
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

On Tue, Sep 26, 2023 at 7:19=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/26/23 9:48 AM, Amir Goldstein wrote:
> > On Tue, Sep 26, 2023 at 6:31?PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 9/25/23 4:43 AM, Amir Goldstein wrote:
> >>> Jens,
> >>>
> >>> Are there any IOCB flags that overlayfs (or backing_aio) need
> >>> to set or clear, besides IOCB_DIO_CALLER_COMP, that
> >>> would prevent calling completion from interrupt context?
> >>
> >> There are a few flags that may get set (like WAITQ or ALLOC_CACHE), bu=
t
> >> I think that should all work ok as-is as the former is just state in
> >> that iocb and that is persistent (and only for the read path), and
> >> ALLOC_CACHE should just be propagated.
> >>
> >>> Or is the proper way to deal with this is to defer completion
> >>> to workqueue in the common backing_aio helpers that
> >>> I am re-factoring from overlayfs?
> >>
> >> No, deferring to a workqueue would defeat the purpose of the flag, whi=
ch
> >> is telling you that the caller will ensure that the end_io callback wi=
ll
> >> happen from task context and need not be deferred to a workqueue. I ca=
n
> >> take a peek at how to wire it up properly for overlayfs, have some
> >> travel coming up in a few days.
> >>
> >
> > No worries, this is not urgent.
> > I queued a change to overlayfs to take a spin lock on completion
> > for the 6.7 merge window, so if I can get a ACK/NACK until then
> > It would be nice.
> >
> > https://lore.kernel.org/linux-unionfs/20230912173653.3317828-2-amir73il=
@gmail.com/
>
> That's not going to work for ovl_copyattr(), as ->ki_complete() may very
> well be called from interrupt context in general.
>
> >>> IIUC, that could also help overlayfs support
> >>> IOCB_DIO_CALLER_COMP?
> >>>
> >>> Is my understanding correct?
> >>
> >> If you peek at fs.h and find the CALLER_COMP references, it'll tell yo=
u
> >> a bit about how it works. This is new with the 6.6-rc kernel, there's =
a
> >> series of patches from me that went in through the iomap tree that
> >> hooked that up. Those commits have an explanation as well.
> >>
> >
> > Sorry, I think my question wasn't clear.
> > I wasn't asking specifically about CALLER_COMP.
> >
> > Zhang Tianci commented in review (above) that I am not allowed
> > to take the inode spinlock in the ovl io completion context, because
> > it may be called from interrupt.
>
> That is correct, the inode spinlock is not IRQ safe.
>
> > I wasn't sure if his statement was correct, so this is what I am
> > asking - whether overlayfs can set any IOCB flags that will force
> > the completion to be called from task context - this is kind of the
> > opposite of CALLER_COMP.
> >
> > Let me know if I wasn't able to explain myself.
> > I am not that fluent in aio jargon.
>
> Ah gotcha. I don't think that'd really work for your case as you don't
> need to propagate it, you can just punt your completion handling to a
> context that is sane for you, like a workqueue. That is provided that
> you don't need any task context there, which presumably you don't since
> eg copyattr is already called from IRQ context.
>
> From that context you could then grab the inode lock.
>

Yes, that's what I thought.
Thanks for confirming!
Amir.
