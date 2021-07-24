Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B8B3D49E8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhGXT5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 15:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhGXT47 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 15:56:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E57C061575
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 13:37:29 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l17so6232761ljn.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ho2aOvJzVUGxbigA5Ok8jwjbjidvHRLuevL3w0ehES8=;
        b=RYJdn54XZvqgDpdCoHMx7X/1qdNndwkSiwPLlTPxcMWweYY3UpjJeM3vyKj+NX7+9Q
         cWCj7Nl9Y+araWN9VJGCF1HNiqElOH2DLKWtSDySUgro0NqFzvf69OLHIXVIRFhQlf1q
         ehxcrzIzzq3rOn8v+Y3XavxPhUhKvOx9U+xKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ho2aOvJzVUGxbigA5Ok8jwjbjidvHRLuevL3w0ehES8=;
        b=TMiP9ybIkC5TTgj+AmV3nwe2z9WOh4qS2qJh6Yq9RbPM8MmzeJLmQ8Bf2Ah+Y6amZH
         rug+6cXFJtH3szscAwD5mh/ebcI9zJ3kV6ztIx30MlHBo7V7K2JbwbbsWeUEAePAPzFX
         D73rKaAg+YHmGWNi936xAtAyD9SelNkW/+PmMWvoSbUeDd/dqGliHYCvxITw+EhME5SY
         dDLsgXdtU/nTRQ3zE+djP8BGrLn4L5kFYJKe6CsjpnECHsoAQuUwZEQbOe20e0NqDeIW
         HMCz5YNgGyNsdT5NFek9A1+8xFpGFdxTIsJ+FzUrz2ZIRg8ps4rTbdiD1t4wBZYbqZKF
         qXNA==
X-Gm-Message-State: AOAM531mNIXchES9LNZfcecHvVEVwLydVU8dKYb3YtVOfIXnArScmf/c
        zBbwd6qGgaocCZO7Wa6G0lMX6C/MYrSePIgZ
X-Google-Smtp-Source: ABdhPJyRDTOSSToTcGA5qL8uDznTUNgwuGWI/gn8EQVmzKKKPUuu9QkCo8Zu/5kyfeHRWCR99PDVMw==
X-Received: by 2002:a05:651c:33a:: with SMTP id b26mr7362071ljp.409.1627159047587;
        Sat, 24 Jul 2021 13:37:27 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p8sm775766lfu.163.2021.07.24.13.37.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jul 2021 13:37:26 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id d17so8228497lfv.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jul 2021 13:37:26 -0700 (PDT)
X-Received: by 2002:ac2:44ad:: with SMTP id c13mr7135571lfm.377.1627159045780;
 Sat, 24 Jul 2021 13:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210724193449.361667-1-agruenba@redhat.com> <20210724193449.361667-2-agruenba@redhat.com>
 <CAHk-=whodi=ZPhoJy_a47VD+-aFtz385B4_GHvQp8Bp9NdTKUg@mail.gmail.com> <YPx28cEvrVl6YrDk@zeniv-ca.linux.org.uk>
In-Reply-To: <YPx28cEvrVl6YrDk@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 24 Jul 2021 13:37:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1d2ELuN-Qtf59dsJ4OG-YRqAk2YrLS3=PRMTc2trZvA@mail.gmail.com>
Message-ID: <CAHk-=wj1d2ELuN-Qtf59dsJ4OG-YRqAk2YrLS3=PRMTc2trZvA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] iov_iter: Introduce iov_iter_fault_in_writeable helper
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 1:26 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Jul 24, 2021 at 12:52:34PM -0700, Linus Torvalds wrote:
>
> > So I think the code needs to return 0 if _any_ fault was successful.
>
> s/any/the first/...

Yes, but as long as we do them in order, and stop when it fails, "any"
and "first" end up being the same thing ;)

> The same goes for fault-in for read

Yeah. That said, a partial write() (ie "read from user space") might
be something that a filesystem is not willing to touch for other
reasons, so I think returning -EFAULT in that case is, I think,
slightly more reasonable.

Things like "I have to prepare buffers to be filled" etc.

The partial read() case is at least something that a filesystem should
be able to handle fairly easily.

And I don't think returning -EFAULT early is necessarily wrong - we
obviously do it anyway if you give really invalid addresses.

But we have generally strived to allow partial IO for missing pages,
because people sometimes play games with unmapping things dynamically
or using mprotect() to catch modifications (ie doing things like catch
SIGSEGV/SIGBUS, and remap it).

But those kinds of uses tend to have to catch -EFAULT anyway, so I
guess it's not a big deal either way.

           Linus
