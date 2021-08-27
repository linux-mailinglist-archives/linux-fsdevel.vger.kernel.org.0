Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF79B3F9F97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhH0TGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 15:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhH0TGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:06:42 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F91C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:05:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so16438264lfu.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xurqpx2HBsUzvPtF9beAd23C15iGKZUtGtKLy9/65Yo=;
        b=ZCnYGG6oW+yh9/k4bIpx+5YJVuekh5B3BxAXApXeWgjP1VAyaSzCumlVz49LYpRpSt
         E7SrDcY9aS1dWjIAtv6pOr5SC4ltNzuJ7d7SIZ4uEgXFlv0fGe4/eQXFko1gO9F/7t9W
         74SaW+5xX2+Nhbgohi4k/EwOND3nF7mQg6AyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xurqpx2HBsUzvPtF9beAd23C15iGKZUtGtKLy9/65Yo=;
        b=pGUzffolzZpzjYCv9XbXSDy6YeqbB4dkVVNH+ndKQ0b9rgtFZ6IBKORBlzMUxKhTKz
         12SfPjCQjODy2oQzQruehO7khyj8pbdeS+agvB9qk7cMxx+xCzZ3CSNkvhiETpP2pHqf
         nhT47IO+vx1Mvn0Fqp06dNS8kHLwGmLt4RSAhE/Xme3G67tDmRKT5XfZnRVDE7KPi3pO
         OHH21oe1ujBa360q1wV6qGIVNLZeKBC0O0Nul2eUeNbaYOik2M2E/x1Jru6JtOBIymtJ
         fw7sanuR09aHqSvpKKLNOc9qQH1Kf6NEmDkVyrEaee6tsjVxATaYxaXqMCa/Njc0c3Wf
         v9Aw==
X-Gm-Message-State: AOAM531QHYkf++C7IqlGZDhj6Q4KmhtXULi8Sqfr8KKC/Sd6j2NmbQvd
        z8vq+ajV8BWQKhGWWOCRNkJKJs0tyuI6Bo/q
X-Google-Smtp-Source: ABdhPJxWP/CeI89XdBrZkEUxewg0mAo3vNqxGml00tIyxeadPvGkrQ7aJRz63MgGI4dUHfnCC5zY/A==
X-Received: by 2002:a19:e218:: with SMTP id z24mr7737818lfg.35.1630091151240;
        Fri, 27 Aug 2021 12:05:51 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id bt29sm669347lfb.4.2021.08.27.12.05.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 12:05:49 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id m18so2232986lfl.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 12:05:49 -0700 (PDT)
X-Received: by 2002:a05:6512:104b:: with SMTP id c11mr7660072lfb.201.1630091149264;
 Fri, 27 Aug 2021 12:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
In-Reply-To: <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Aug 2021 12:05:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
Message-ID: <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
Subject: Re: [PATCH v7 05/19] iov_iter: Introduce fault_in_iov_iter_writeable
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

On Fri, Aug 27, 2021 at 11:52 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Again, the calling conventions are wrong.  Make it success/failure or
> 0/-EFAULT.  And it's inconsistent for iovec and non-iovec cases as it is.

Al, the 0/-EFAULT thing DOES NOT WORK.

The whole "success vs failure" model is broken.

Because "success" for some people is "everything worked".

And for other people it is "at least _part_ of it worked".

So no, 0/-EFAULT fundamentally cannot work, because the return needs
to be able to handle that ternary situation (ie "nothing" vs
"something" vs "everything").

This is *literally* the exact same thing that we have for
copy_to/from_user(). And Andreas' solution (based on my suggestion) is
the exact same one that we have had for that code since basically day
#1.

The whole "0/-EFAULT" is simpler, yes. And it's what
"{get|put}_user()" uses, yes. And it's more common to a lot of other
functions that return zero or an error.

But see above. People *need* that ternary result, and "bytes/pages
uncopied" is not only the traditional one we use elsewhere in similar
situations, it's the one that has the easiest error tests for existing
users (because zero remains "everything worked").

Andreas originally had that "how many bytes/pages succeeded" return
value instead, and yes, that's also ternary. But it means that now the
common "complete success" test ends up being a lot uglier, and the
semantics of the function changes completely where "0" no longer means
success, and that messes up much more.

So I really think you are barking entirely up the wrong tree.

If there is any inconsistency, maybe we should make _more_ cases use
that "how many bytes/pages not copied" logic, but in a lot of cases
you don't actually need the ternary decision value.

So the inconsistency is EXACTLY the same as the one we have always had
for get|put_user() vs copy_to|from_user(), and it exists for the EXACT
same reason.

IOW, please explain how you'd solve the ternary problem without making
the code a lot uglier.

              Linus
