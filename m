Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B29D35137F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 12:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhDAK2K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 06:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbhDAK1u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F2C061788
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Apr 2021 03:24:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id b7so2131954ejv.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Apr 2021 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7YrrrhPr6H4+aJ1lkG34rMuFAOACvVaQCsE3shxThk=;
        b=RwfJgvCkIljryl8uo0Vmwy2NZSGlqehWXjl1ezB3NnMbhUVMtz7Imp6cJmjHiV4c4u
         MOCSZbF5KXM0BPkLoo8ln+fo9T/lLzR9fzRy6KS8Q9OZ5ddViqvPoqp/FlqF29SEobts
         xvEBdEfRoyqb1GShptdxvCBIr5dG45kwTRF0enf0UE66rXgR0yEqI7Ijd22l0QnFpOGN
         6B2abN4aaqhtSo4CJwJtTL84Va2BROJEi7VJg3gaQRP1rr3BjpaJK547ghRrBwijc8bl
         lE16Qfqg/02+MSmoLwK7r+yDtF98UhWQ7qLtgbsXr4fCCdxmDBZeKulHdOUR1//IF5sz
         K8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7YrrrhPr6H4+aJ1lkG34rMuFAOACvVaQCsE3shxThk=;
        b=Rt3/KPSCfkr83gQk+QRsVshqFS2YWo0FkzZWY8JGTVeTadKi799GNjOrvMRzY+nGXp
         hdjzf+UQbfprgJWTsNSELjH2oxvd7oLAwfD9j12Fw8G1a6ytzvk7x9b1qSx1GiaA0O5w
         NjMmgh1EkvWAwpZIYbPDisHV1KAjdgUK7zwlQ+igrOlIi0mRNdY6zfyC9Pg2/7Qx7mdl
         QiA7I9Qch48yYfvusqIjBiucnLF1I7KYXNwxJ1A5f1MPFm3AdO/oNtpxF0I4ErV/1Ef6
         wU/Xv4NsJ3j/c9TpcX+KU604vU3rb5t1ld/Uop4G5OQPQLOib7cp0S9fhiicROZf8OkG
         O1hg==
X-Gm-Message-State: AOAM532+QA96adbd27XxkcsRqwvvR6TSpUoI9m+hQ4rXaNB56vq9J5Fo
        ZE5Apr9OhYmIR0MTjcMHvhdpVHKrdWxCH82qfPsh
X-Google-Smtp-Source: ABdhPJy9oPfEuG5lV875yMF7Gj8RMK+uoG/+oS6kYgJYXI10oZOQ1GgD81mnM9ZocBNO5F2BWGpmbruurhnPMXIWJWE=
X-Received: by 2002:a17:906:311a:: with SMTP id 26mr8276109ejx.395.1617272688184;
 Thu, 01 Apr 2021 03:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210401090932.121-1-xieyongji@bytedance.com> <20210401090932.121-2-xieyongji@bytedance.com>
 <YGWX4aIE5QNxsJQ9@kroah.com>
In-Reply-To: <YGWX4aIE5QNxsJQ9@kroah.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Thu, 1 Apr 2021 18:24:37 +0800
Message-ID: <CACycT3tESHmWUS6qrBpoOHGQKrJt7Qb8Xh1aawhDBHMPBb0Eag@mail.gmail.com>
Subject: Re: Re: [PATCH 1/2] file: Export receive_fd() to modules
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        viro@zeniv.linux.org.uk, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Jason Wang <jasowang@redhat.com>, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 1, 2021 at 5:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 01, 2021 at 05:09:31PM +0800, Xie Yongji wrote:
> > Export receive_fd() so that some modules can use
> > it to pass file descriptor across processes without
> > missing any security stuffs.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  fs/file.c            | 6 ++++++
> >  include/linux/file.h | 7 +++----
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index 56986e55befa..2a80c6c3e147 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -1107,6 +1107,12 @@ int receive_fd_replace(int new_fd, struct file *file, unsigned int o_flags)
> >       return new_fd;
> >  }
> >
> > +int receive_fd(struct file *file, unsigned int o_flags)
> > +{
> > +     return __receive_fd(file, NULL, o_flags);
> > +}
> > +EXPORT_SYMBOL(receive_fd);
>
> What module uses this?
>

Looks like now it will be only used by the module in my proposal:

https://lore.kernel.org/linux-fsdevel/20210331080519.172-1-xieyongji@bytedance.com/

> And why not EXPORT_SYMBOL_GPL()?
>

My fault, sorry.

Thanks,
Yongji
