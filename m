Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F8C30305E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 00:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbhAYXmw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 18:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732686AbhAYXkk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:40:40 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6E8C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 15:39:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m22so20321209lfg.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 15:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PiYaXaNdLHDYRJIbb9dUizilUpJDQTQluxxh3E1CnUc=;
        b=I+ueePi/OTkpWkk3KvHO4ZUfd6VE8k+je/vIAF65q7O3aMJcrFow5YJqnHJBaBSla2
         /YqaTgrY5SoI4BHMFfm1roUMjae9/AzbH7iC2wuoP59BeVDx+fpq6rWrz+k72DnJZYev
         RMcAs8hXJNDPHbhiLGY2VDo2p1YXfL/n1he3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PiYaXaNdLHDYRJIbb9dUizilUpJDQTQluxxh3E1CnUc=;
        b=hbjnybPgfuo3OmMbZ5xH0q5P6qm72NBmouxN7tNBrw1HhuqS6zM2+F19scw42EKMQ6
         Snxs6IppxqeV5jGDephNlDwq0d+JjcRhzOdkm0mMdTg1RoYy4nsSjQ22jT+1oGob4NzO
         CQqKbxLYvGzjOfRzQMN3TkSOP4iH1jlVX9+x99S0H0LVVTtPBhgsLXtQGUxbMSjPvjS6
         0q75sZRhqdJoHtG/s3H9R31rooyN3U9I5QMmm7Mn6ZN5BrGE8B/1vVkAjGd7WxwHjqcl
         mzA/p1eJ4cweUONRiq1vJZBV6JteFC5fXyAFIVPnstK8jx8OptLKOpqtFK7EZm3bQE7s
         0tkw==
X-Gm-Message-State: AOAM5324njeLls3Qor+391edb5qmn/f9DzS7oQw/1CEuFZAGgoMOgvqb
        Vuhag3cv8sHRh0lRxtTTw57CWjk1RgkKHA==
X-Google-Smtp-Source: ABdhPJw0ebo22vGl3DwIADqORKD1UbFllTnlyquiyx7bwinc8B9ArjfaOO7ytQzanViMZ6PEzIH3TA==
X-Received: by 2002:a05:6512:22c3:: with SMTP id g3mr1209941lfu.376.1611617997998;
        Mon, 25 Jan 2021 15:39:57 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e1sm2175852lfs.279.2021.01.25.15.39.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 15:39:57 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id v24so20330811lfr.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 15:39:56 -0800 (PST)
X-Received: by 2002:ac2:4436:: with SMTP id w22mr1249767lfl.41.1611617996447;
 Mon, 25 Jan 2021 15:39:56 -0800 (PST)
MIME-Version: 1.0
References: <20210125213614.24001-1-axboe@kernel.dk>
In-Reply-To: <20210125213614.24001-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Jan 2021 15:39:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=whh=+nkoZFqb1zztY9kUo-Ua75+zY16HeU_3j1RV4JR0Q@mail.gmail.com>
Message-ID: <CAHk-=whh=+nkoZFqb1zztY9kUo-Ua75+zY16HeU_3j1RV4JR0Q@mail.gmail.com>
Subject: Re: [PATCHSET RFC] support RESOLVE_CACHED for statx
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 25, 2021 at 1:36 PM Jens Axboe <axboe@kernel.dk> wrote:
>
>     Patch 2 is the
> mostly ugly part, but not sure how we can do this any better - we need
> to ensure that any sort of revalidation or sync in ->getattr() honors
> it too.

Yeah, that's not pretty, but I agree - it looks like this just
requires the filesystem to check whether it needs to revalidate or
not.

But I think that patch could do better than what your patch does. Some
of them are "filesystems could decide to be more finegrained") -  your
cifs patch comes to mind - but some of your "return -EAGAIN if cached"
seem to be just plain pointless.

In afs, for example, you return -EAGAIN instead of just doing the
read-seqlock thing. That's a really cheap CPU-only operation. We're
talking "cheaper than a spinlock" sequence.

           Linus
