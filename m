Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5709D52DF95
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 23:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbiESVxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 17:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245238AbiESVxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 17:53:15 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4375E55379
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 14:53:14 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h5so7866249wrb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX5ubsOE693MmLyfmpEsKA9kTxG9wuZlKhY/Lmx1Dcg=;
        b=mMPPPEU4Yx+mtS5aVcwwgLsWwhqGNX6yCnKkNTj4avhRkEw8A6Uq0MGgn3uQNfBa4e
         vKCS7kRRTVqExk6sdIA7WNd2XVzEBGzO6kLyAOKv+b2hbCz6VpydFzHqeK97GrH1obED
         DUm111fatIa2ZI2LUM5nXCzufj0xA3ubSlq4VJ8aYUAJR0lPkN5DVMzKQ/gJrn6cj34F
         odcg+YbyZm37Rud7oZtAmoSRH9hQqreI+3js+Zc+mcbTKeS+u55W21Q2CbVCLpNx+ndK
         YqGwZpkbe4mSYOv1KvetzgMDp3pD3nmNNlapjgV5N81c47T4qaPui2JXENarJTeGL/Cw
         m0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX5ubsOE693MmLyfmpEsKA9kTxG9wuZlKhY/Lmx1Dcg=;
        b=RzhumSqh7HVXJJfuQxwfKgBW/4AaE7461UEZaNz7VpeR2YN9XogXtyNHTTKF7s0vKc
         a9VWpUGA+oiyxcd+J1j9Tr9UQ9kWwftXd2bLzcY/OC7EuBwGoEZR+Jws6KKNt4yPblCE
         cu2yDbJQLJLvoIl1tI1ja16HFHUT+f8oNWFGYaAm22AosJXjrsd12N3153t1AXHhZfEB
         olJYAYktt7n3Zy4YdxBnX5AZuLA+20Tr429mwFqoO6Z24Yq43glk30h5976M9a4qQ891
         d4dOtVRddvX4FsR2l5pGp8JsUMGD0dShntPBsnP1t6ezuIgFz/BOwrIbzb14jFuuF9vs
         jL2w==
X-Gm-Message-State: AOAM531a8+SluzDAlxvStTzKg62Il5dpTkQsIsVc8HRsYZquAU0OHMF4
        8t/rinYl/vtLtjLOZsIPZEP27LoPW1ieTAs1Uncvyw==
X-Google-Smtp-Source: ABdhPJwyK6HC08N5s3/SWMPE4w7rlvJoGjiBpOl0jarvJYl0fFzmbkJPfCqqscfznim8I5RGFl/dzkYSwMyaE/2gLhc=
X-Received: by 2002:a5d:6c68:0:b0:20c:b69f:cbd0 with SMTP id
 r8-20020a5d6c68000000b0020cb69fcbd0mr6016090wrz.500.1652997192512; Thu, 19
 May 2022 14:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220519214021.3572840-1-kaleshsingh@google.com> <01c1e280-eec4-4f04-553b-670ae1376c33@infradead.org>
In-Reply-To: <01c1e280-eec4-4f04-553b-670ae1376c33@infradead.org>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 19 May 2022 14:53:01 -0700
Message-ID: <CAC_TJvcA8CEG7M1KZpbdTz6_2jZHG0+Ui4Ug5qmbLYiemoLegw@mail.gmail.com>
Subject: Re: [RFC PATCH] procfs: Add file path and size to /proc/<pid>/fdinfo
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Ioannis Ilkos <ilkos@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        Colin Cross <ccross@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 2:47 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 5/19/22 14:40, Kalesh Singh wrote:
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 061744c436d9..ad66d78aca51 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -1922,13 +1922,16 @@ if precise results are needed.
> >  3.8  /proc/<pid>/fdinfo/<fd> - Information about opened file
> >  ---------------------------------------------------------------
> >  This file provides information associated with an opened file. The regular
> > -files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
> > +files have at least six fields -- 'pos', 'flags', 'mnt_id', 'ino', 'size',
> > +and 'path'.
> > +
> >  The 'pos' represents the current offset of the opened file in decimal
> >  form [see lseek(2) for details], 'flags' denotes the octal O_xxx mask the
> >  file has been created with [see open(2) for details] and 'mnt_id' represents
> >  mount ID of the file system containing the opened file [see 3.5
> >  /proc/<pid>/mountinfo for details]. 'ino' represents the inode number of
> > -the file.
> > +the file, 'size' represents the size of the file in bytes, and 'path'
> > +represents the file path.
> >
> >  A typical output is::
> >
> > @@ -1936,6 +1939,8 @@ A typical output is::
> >       flags:  0100002
> >       mnt_id: 19
> >       ino:    63107
> > +        size:   0
> > +        path:   /dev/null
> >
> >  All locks associated with a file descriptor are shown in its fdinfo too::
> >
> > @@ -1953,6 +1958,8 @@ Eventfd files
> >       flags:  04002
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[eventfd]
> >       eventfd-count:  5a
> >
> >  where 'eventfd-count' is hex value of a counter.
> > @@ -1966,6 +1973,8 @@ Signalfd files
> >       flags:  04002
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[signalfd]
> >       sigmask:        0000000000000200
> >
> >  where 'sigmask' is hex value of the signal mask associated
> > @@ -1980,6 +1989,8 @@ Epoll files
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[eventpoll]
> >       tfd:        5 events:       1d data: ffffffffffffffff pos:0 ino:61af sdev:7
> >
> >  where 'tfd' is a target file descriptor number in decimal form,
> > @@ -1998,6 +2009,8 @@ For inotify files the format is the following::
> >       flags:  02000000
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:inotify
> >       inotify wd:3 ino:9e7e sdev:800013 mask:800afce ignored_mask:0 fhandle-bytes:8 fhandle-type:1 f_handle:7e9e0000640d1b6d
> >
> >  where 'wd' is a watch descriptor in decimal form, i.e. a target file
> > @@ -2021,6 +2034,8 @@ For fanotify files the format is::
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[fanotify]
> >       fanotify flags:10 event-flags:0
> >       fanotify mnt_id:12 mflags:40 mask:38 ignored_mask:40000003
> >       fanotify ino:4f969 sdev:800013 mflags:0 mask:3b ignored_mask:40000000 fhandle-bytes:8 fhandle-type:1 f_handle:69f90400c275b5b4
> > @@ -2046,6 +2061,8 @@ Timerfd files
> >       flags:  02
> >       mnt_id: 9
> >       ino:    63107
> > +        size:   0
> > +        path:   anon_inode:[timerfd]
> >       clockid: 0
> >       ticks: 0
> >       settime flags: 01
> > @@ -2070,6 +2087,7 @@ DMA Buffer files
> >       mnt_id: 9
> >       ino:    63107
> >       size:   32768
> > +        path:   /dmabuf:
> >       count:  2
> >       exp_name:  system-heap
>
> All of these added lines should be indented with a tab instead of spaces.

Ahh. Thanks for catching it. WIll update in the next version.

-Kalesh

>
> thanks.
> --
> ~Randy
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
