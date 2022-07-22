Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E029E57D7DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 02:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiGVAuj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 20:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGVAuj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:50:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64F092866
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 17:50:35 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e69so5653446ybh.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 17:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzafuiEWylnPx+vzKxgPtVmce8F0KReTVjWI/YPyHU4=;
        b=VDmFdkvmYxaqlvK5pwCslq7qP+NaqIS5QHCjkUOh7CHWeqj4fQi9OrzxXZksoefj47
         S9mJ4sH1HdbNy5u427UWa41mdKjEAsAVsn8ZHCZVpwBQpro1XiWFFwyIsYtCV2kxujko
         7G5p1TtijJKUQMaqY4/W28x8FlJgKKLBL3+DY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzafuiEWylnPx+vzKxgPtVmce8F0KReTVjWI/YPyHU4=;
        b=QvUYV62AHvoEAPNS8qxVnv15PIKsmC6AK2jkISzY/LPDqozin+pN59yLlodAFDXSFf
         96ii24iWDZCsffoFZWnL+I5Y4+9S9kgxCCQsAHKvgeWXo5XBondt0pPpzoX+b9FJMZK5
         cDkAwOWNBz4fOYxJEPOaui1C9CBCaumymssnVAMQDW4/Wgz94Abl3hr4ynqDCNLMZxfQ
         1giX2si7imTSsB65cVTupRTc3RRzSRLZsPnUunGbIKx2t2ZurOvusbGBUmvJTxNXkF9Y
         H7KcF+8A6VqC4PHrOSkZuHb1AxVAMHqqO3FVEilBu8MG+p3C0MIp+ck+bSi8r2vIYvR3
         H1lw==
X-Gm-Message-State: AJIora9nFBBVKQSYKYH+u9MvjrLo0tRSv8AIlARMGHRVJwL47r61f2kA
        P5512yeY8iX5AfyOdICs4Q1qkGwjJ2hDt2/XqK4eZA==
X-Google-Smtp-Source: AGRyM1udZ5qtcw/r4xzG+6Sc8lGtz7Mu2n6yKFhhwNQ1sQXWuuhKwSZqqN6cQsHWoxMNJUMCUIqknf886+PDeeqUgjI=
X-Received: by 2002:a05:6902:56c:b0:66f:9fbd:243e with SMTP id
 a12-20020a056902056c00b0066f9fbd243emr1072599ybt.518.1658451035215; Thu, 21
 Jul 2022 17:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220601011103.12681-1-dlunev@google.com> <20220601111059.v4.1.I0e579520b03aa244906b8fe2ef1ec63f2ab7eecf@changeid>
 <CAJfpegv8-0_Jsf7wUOVsXkt69o4Xrq0TgvwUzZF+RHX4_nxMzw@mail.gmail.com>
In-Reply-To: <CAJfpegv8-0_Jsf7wUOVsXkt69o4Xrq0TgvwUzZF+RHX4_nxMzw@mail.gmail.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 22 Jul 2022 10:50:24 +1000
Message-ID: <CAONX=-ca1-Gh7LKP=kviDbCy8JsYHyBNXJpLXwdUeVgqX3K0+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fs/super: function to prevent super re-use
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniil Lunev <dlunev@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,
Thanks for your response and apologies for my delayed reply.  Do I understand
correctly that to cover non-block devices I would need to add the same check
to test_keyed_super and to test_single_super? Am I missing any other place?
--Daniil

On Mon, Jul 18, 2022 at 7:51 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 1 Jun 2022 at 03:11, Daniil Lunev <dlunev@chromium.org> wrote:
> >
> > From: Daniil Lunev <dlunev@chromium.org>
> >
> > The function is to be called from filesystem-specific code to mark a
> > superblock to be ignored by superblock test and thus never re-used. The
> > function also unregisters bdi if the bdi is per-superblock to avoid
> > collision if a new superblock is created to represent the filesystem.
> > generic_shutdown_super() skips unregistering bdi for a retired
> > superlock as it assumes retire function has already done it.
> >
> > Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> > Signed-off-by: Daniil Lunev <dlunev@google.com>
> > ---
> >
> > Changes in v4:
> > - Simplify condition according to Christoph Hellwig's comments.
> >
> > Changes in v3:
> > - Back to state tracking from v1
> > - Use s_iflag to mark superblocked ignored
> > - Only unregister private bdi in retire, without freeing
> >
> > Changes in v2:
> > - Remove super from list of superblocks instead of using a flag
> >
> >  fs/super.c         | 28 ++++++++++++++++++++++++++--
> >  include/linux/fs.h |  2 ++
> >  2 files changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/super.c b/fs/super.c
> > index f1d4a193602d6..3fb9fc8d61160 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -422,6 +422,30 @@ bool trylock_super(struct super_block *sb)
> >         return false;
> >  }
> >
> > +/**
> > + *     retire_super    -       prevernts superblock from being reused
>
> s/prevernts/prevents/
>
> > + *     @sb: superblock to retire
> > + *
> > + *     The function marks superblock to be ignored in superblock test, which
> > + *     prevents it from being reused for any new mounts.
>
> This works for block supers and nothing else, at least as this patch
> stands.  That might be okay, but should at least be documented.
>
> Thanks,
> Miklos
