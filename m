Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081223BF03E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 21:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhGGT32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhGGT31 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 15:29:27 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA37C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jul 2021 12:26:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n14so6936444lfu.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 12:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gurR/owSQDFNH0OSkKWy8rQ2chdbL863tihhAYffiok=;
        b=O4/ZeTQT6f+jFfZaJgO+nGN0TZllql6sOHLJC1MBLS2yfZlJJcV/LJ42OCqfaRFj+7
         xHL/olvJE3nX1wrc1P0N+TbWFBWePWgpKUGg4WF51rybJYdE0TI6byFY3xd+e93K9VNS
         CWTXY/c3bxrDm3ItM0cXM5enPAWo3dakT/0VA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gurR/owSQDFNH0OSkKWy8rQ2chdbL863tihhAYffiok=;
        b=bCFQIFTz30TjHHW1WMH8zwneU3rWl6zvFkudWRmsn/CJLN7IZw3tG6y+zf4VfQewlt
         4Pmyx89Q+zjFjjXDSW/3oq8Raz4isZrH6KM9lDn9ozKxKKPEfk5yET7lBV+fFp/Lr04q
         ylvB9iGRmceZ4j1CrTb1fB7rXUeLY3TBmozUxep+DjPtl5FV6/tOo6BrZmA6er2g6yGy
         YiDJcvnkVtZopDRmtJpT6Nts04nVNqG6//1dRADvjtB3vOUCv8aUP69Ro/3zSc+VJ4oD
         G7GqpLURI2Yz286UKrNCkwHaJxPAsoflEpYr3+gU2wk6FluNTkYUQAHC80XTq2+p8OE9
         XMZw==
X-Gm-Message-State: AOAM530GWPsYOeUcAs/WphekI/0orFF4KsTYI5WeAbV1XIHFDNeWnGCH
        elMXJKvduFzI2bEvq4Fz7DxK3Hw8zh5I+udfvGA=
X-Google-Smtp-Source: ABdhPJzS8JBCMhFVQ2graCNqBlgMHOYWfzyS9Q4Fj50l8Po7V/aojrre5p1YYcko7NY8qgdptwPS0Q==
X-Received: by 2002:a2e:9e04:: with SMTP id e4mr20193374ljk.431.1625686004612;
        Wed, 07 Jul 2021 12:26:44 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o7sm1790322lfo.196.2021.07.07.12.26.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 12:26:44 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id y42so7007184lfa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 12:26:43 -0700 (PDT)
X-Received: by 2002:a2e:9c58:: with SMTP id t24mr19950330ljj.411.1625686003546;
 Wed, 07 Jul 2021 12:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210707122747.3292388-1-dkadashev@gmail.com>
In-Reply-To: <20210707122747.3292388-1-dkadashev@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 7 Jul 2021 12:26:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTyxUt61NxeMXb2Zn2stDBC7eG82RKj+3jXUORdYQtpg@mail.gmail.com>
Message-ID: <CAHk-=wiTyxUt61NxeMXb2Zn2stDBC7eG82RKj+3jXUORdYQtpg@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] io_uring: add mkdir and [sym]linkat support
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 7, 2021 at 5:28 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> This started out as an attempt to add mkdirat support to io_uring which
> is heavily based on renameat() / unlinkat() support.

Ok, sorry for having made you go through all the different versions,
but I like the new series and think it's a marked improvement.

I did send out a few comments to the individual patches that I think
it can all now be made to be even more legible by avoiding some of the
goto spaghetti, but I think that would be a series on top.

(And I'd like to note again that I based all that on just reading the
patches, so there may be something there that makes it not work well).

One final request: can you keep the fs/namei.c patches as one entirely
separate series, and then do the io_uring parts at the end, rather
than intermixing them?

But at least I am generally happy with this version.

Al - please holler now if you see any issues.

               Linus
