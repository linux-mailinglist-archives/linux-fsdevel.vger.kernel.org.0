Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048422EED6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 07:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbhAHGWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 01:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbhAHGWo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:22:44 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B42FC0612F4;
        Thu,  7 Jan 2021 22:22:04 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id u26so8761313iof.3;
        Thu, 07 Jan 2021 22:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+BXqYuV606VS+I9TLOan9ji/x66HZzEGa+6VU8SPpto=;
        b=BnzjqYqeUviOOTXnVOHyxtQu5K2hQowAQMN86mArwBR65C8hvy4jsmIK1Vp41IZBQf
         UwXAOAgRJEezruGzjfp9DlA/vnbJCg6G5gUWVX1KPbmwCcAFNOKsINyqRzzXRCjCzYMC
         LIJs2cEvW+s3eY0YRjQ8t1+DA7pE16IoE2SAM8VvSVPlucHYbJuUHnW2qoA8HliTk/jl
         CzYgYgH6TJQ/MuDkx2OSqwIp+j614gHG1NAkeekT9wUB+uNvQt/uQE8zkQwbx1d+xUsH
         QW9nviA/LOnZMFi4T+KUCZpw3GECNrYWgAWlHgXZBEWgKKv8aWRWBIVEphcbWb80I5Ii
         H8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+BXqYuV606VS+I9TLOan9ji/x66HZzEGa+6VU8SPpto=;
        b=N0ITiqn9dG0SrtRGbUrf3AsTxsGWQvWwrCmyRLuKkKouRxm7pWzZ7LkbJRzWWRQE90
         HHdo1VqQbtVROX9XaoPFRejE1wWFU03HRwNw8mUy1y50WTpxW6stT4qsvunhazYCkK8Q
         qJpM9gE8h1nqHB2Aj2p0LtUCkV7zHEXR2sOybvr9B05Mx2vjbeGvU9nLEqdKnk31QrxW
         4ki30ATDyslyx/LRo137LTZGwB5h3QZOSBQTop8dw5PcbZ0peemsudxUIUtOo9+oyypD
         lXxKjt9AEEWbTQrrzkbirN4GOmEm+dx3Ygki6bhOW3ZWpTkN+qra0lHn8h17GvXtOunr
         K3RA==
X-Gm-Message-State: AOAM530B+Y/elCVD4Bcm3BKS/xY3hAeByfOYnyLm6RppWq+bdQH+cemQ
        RzAvSU0vXUs0ciqpwBLbl2OmHuiWtnQ2nxmbblU=
X-Google-Smtp-Source: ABdhPJzhG5uBfX9YM01tPrKI6tx1Oc4tW5oI9QlKp/FWFCbqz2f+3u21CqOrxcN0S5WFXEqOSnhZqnB8hCVFXrFIKw0=
X-Received: by 2002:a5e:d70e:: with SMTP id v14mr4316432iom.75.1610086924081;
 Thu, 07 Jan 2021 22:22:04 -0800 (PST)
MIME-Version: 1.0
References: <d6ddf6c2-3789-2e10-ba71-668cba03eb35@kernel.dk> <20210108052651.GM3579531@ZenIV.linux.org.uk>
In-Reply-To: <20210108052651.GM3579531@ZenIV.linux.org.uk>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 8 Jan 2021 07:21:52 +0100
Message-ID: <CA+icZUWZePRQ6h8TLekp3EMNvLG22o4stV7OaGVCnm9VeX6d=w@mail.gmail.com>
Subject: Re: [PATCH] fs: process fput task_work with TWA_SIGNAL
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 6:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Jan 05, 2021 at 11:29:11AM -0700, Jens Axboe wrote:
> > Song reported a boot regression in a kvm image with 5.11-rc, and bisected
> > it down to the below patch. Debugging this issue, turns out that the boot
> > stalled when a task is waiting on a pipe being released. As we no longer
> > run task_work from get_signal() unless it's queued with TWA_SIGNAL, the
> > task goes idle without running the task_work. This prevents ->release()
> > from being called on the pipe, which another boot task is waiting on.
> >
> > Use TWA_SIGNAL for the file fput work to ensure it's run before the task
> > goes idle.
> >
> > Fixes: 98b89b649fce ("signal: kill JOBCTL_TASK_WORK")
> > Reported-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >
> > ---
> >
> > The other alternative here is obviously to re-instate the:
> >
> > if (unlikely(current->task_works))
> >       task_work_run();
> >
> > in get_signal() that we had before this change. Might be safer in case
> > there are other cases that need to ensure the work is run in a timely
> > fashion, though I do think it's cleaner to long term to correctly mark
> > task_work with the needed notification type. Comments welcome...
>
> Interesting...  I think I've missed the discussion of that thing; could
> you forward the relevant thread my way or give an archive link to it?

See [1].

- Sedat -

[1] https://marc.info/?t=160987156600001&r=1&w=2
