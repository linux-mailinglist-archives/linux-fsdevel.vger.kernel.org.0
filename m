Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119711EC422
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jun 2020 23:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgFBVDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jun 2020 17:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBVDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:03:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310CEC08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2020 14:03:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so3688776ljh.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2020 14:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bJlmus5XHXjv1rw00vbaJw33tmb8qsAo8E9SyQVB5o=;
        b=c3OO9Eib+9QFWyiyGkaP3OWFMYITgu0SqFYiihv1nDFfvPl5LG+QGROmQ0W2vvF9TH
         xFPPXbu1d1Ijk8yKx1L8kgzVX4/QMqVlDd/+mMyGn+W6nAmAlpRGjtWXYEvN82lx37MV
         fur6Zc96Tv4VAr6lx2n2EUxpsK34AWMPsgGCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bJlmus5XHXjv1rw00vbaJw33tmb8qsAo8E9SyQVB5o=;
        b=NVZEf6AWL8dC65a10kmIazMWkbJfPNeBr8EcIDMjc5DgXl2bR/a6IuEW1StWoqoFSv
         d80K8iXbWg0te89vUFjAim3uTVoIjDtVPovpXx/6HnQYZUPwVpXT99ASksxqrcCodgNf
         ThmBpGeF9ZiDs6qtAe6vA++qXPdz43l3PaQMfFYXE2W1tZh9kvqVi7noKYBQ4X1hZXVn
         bVjBH8OnhOz+9yHMf1vDUC1sdO/MrsRFDKgpLBdyX/v0alCMBFYdFaRC8YnnBqOJFJ0d
         R7WaDvSG/PW38ptUfeuAuAygWzUc8zxLmHJEAN7Rjb6FGsrOCh8+9vfG6OVjmxv9A5tX
         mgFQ==
X-Gm-Message-State: AOAM532QWVfsBIsqFZg3ZA6QITeeuv/0ysCwxIQkdUfNLer67GQ6LajI
        11mCIu4k5MUNLcDuDz/dZ3gLw4fPb/I=
X-Google-Smtp-Source: ABdhPJx4/AifHSIXFKS63mQKjuyglz/sfkpMPd4pnqSXhr71gENZ9iHnQ3XURuQHEHi+unDfXD6BBA==
X-Received: by 2002:a2e:9b8f:: with SMTP id z15mr429805lji.59.1591131806864;
        Tue, 02 Jun 2020 14:03:26 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id j13sm8758ljo.101.2020.06.02.14.03.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id z9so3688580ljh.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr460164ljc.314.1591131805045;
 Tue, 02 Jun 2020 14:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200602204219.186620-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 14:03:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
Message-ID: <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 2, 2020 at 1:42 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This is a resend of the close_range() syscall, as discussed in [1]. There weren't any outstanding
> discussions anymore and this was in mergeable shape. I simply hadn't gotten around to moving this
> into my for-next the last few cycles and then forgot about it. Thanks to Kyle and the Python people,
> and others for consistenly reminding me before every merge window and mea culpa for not moving on
> this sooner. I plan on moving this into for-next after v5.8-rc1 has been released and targeting the
> v5.9 merge window.

Btw, I did have one reaction that I can't find in the original thread,
which probably means that it got lost.

If one of the designed uses for this is for dropping file descriptors
just before execve(), it's possible that we'd want to have the option
to say "unshare my fd array" as part of close_range().

Yes, yes, you can do

        unshare(CLONE_FILES);
        close_range(3,~0u);

to do it as two operations (and you had that as the example typical
use), but it would actually be better to be able to do

        close_range(3, ~0ul, CLOSE_RANGE_UNSHARE);

instead. Because otherwise we just waste time copying the file
descriptors first in the unshare, and then closing them after.. Double
the work..

And maybe this _did_ get mentioned last time, and I just don't find
it. I also don't see anything like that in the patches, although the
flags argument is there.

            Linus
