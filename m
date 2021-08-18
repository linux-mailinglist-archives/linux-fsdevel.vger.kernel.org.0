Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C3C3F0B4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhHRSx5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 14:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhHRSxz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:53:55 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662CC0613CF
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 11:53:20 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id b26so1402493uam.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Aug 2021 11:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVLIclKpwLs/EllaJbXfDnAEhIbk0tUG6YwA3fwwsCM=;
        b=VjlI5vzQcP68jcedrwYoawmC/G17u6wAsVnk2VtuJccgIigT3lKCeDhz2qPLg4HV8i
         sFM1WZNVUbOUTdV9g/SYBPp6518FCH7aaj4RxhvJs0KRHb8kRR8F952Ls1EKsBhMOR7r
         vjO308Z+rRostL8ZJjuA23xq8hm4Oi5M9W6uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVLIclKpwLs/EllaJbXfDnAEhIbk0tUG6YwA3fwwsCM=;
        b=DVNmk1p7Kzjil0Go2KYJhow2ukaeqJ0mXsXQKTBC35cIQIe3fqK29jCS5qthkA1a4g
         dKCeo2EIbOWTeN1o8MBaEWh1/Iu2LzXFbmgdxdlKsD4TYdLr4vBAzoqKIchQ165+lsXU
         +lq4jSXbBMelFHh2fU1ysG/rINySjCp+CznjSCyc7tCeoOlXL/ZW5fvBwtDQLmCtkV/L
         dme1Q54z5QGgfsoOAsIi3f4h/ugXW7/1zGrVwzGLL/yypklvmxFTYubgbIEGSbx/C0tP
         3P383dc9nb0KanCp2c0jfaEKhygtoaU7avnwFFn8tnEKtcHiGilts05lGdxeB1y7UHc7
         zIQg==
X-Gm-Message-State: AOAM532ZPqsOW2ZMypyn70gV+YAofnh7W/rqIICFBNPHEYPH+wSmvy3R
        hZWZW7K1cNauInSa6XbRTb7dXB8uei/OhxTzfnrrLA==
X-Google-Smtp-Source: ABdhPJw9qBXplks3neJYHjam2XpKpKF9oCj3I1kKEha/Gcfljy/ZP8Wqa52TxoXoGqXRYSN+XnIRi+y/yNKBN2gEN5A=
X-Received: by 2002:ab0:3a8f:: with SMTP id r15mr8238862uaw.13.1629312799709;
 Wed, 18 Aug 2021 11:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210818133400.830078-1-mszeredi@redhat.com> <20210818133400.830078-3-mszeredi@redhat.com>
 <CAHk-=wga+3G+mR-UyQ=pwqN2iS04k-O61bssvzyVk+vkdZkd1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wga+3G+mR-UyQ=pwqN2iS04k-O61bssvzyVk+vkdZkd1Q@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Aug 2021 20:53:08 +0200
Message-ID: <CAJfpeguQxpd6Wgc0Jd3ks77zcsAv_bn0q17L3VNnnmPKu11t8A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ovl: enable RCU'd ->get_acl()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        garyhuang <zjh.20052005@163.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Aug 2021 at 20:34, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 18, 2021 at 6:34 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> >  struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type)
> >  {
> > -       return rcu_dereference(*acl_by_type(inode, type));
> > +       struct posix_acl *acl = rcu_dereference(*acl_by_type(inode, type));
> > +
> > +       if (acl == ACL_DONT_CACHE)
> > +               acl = inode->i_op->get_acl(inode, type, LOOKUP_RCU);
> > +
> > +       return acl;
> >  }
>
> What? No.
>
> You just made get_cached_acl_rcu() return ERR_PTR(-EINVAL) for most filesystems.
>
> So now you've changed the behavior of get_cached_acl_rcu() ENTIRELY.
>
> It used to return either
>  (a) the ACL
>  (b) NULL
>  (c) ACL_DONT_CACHE/ACL_NOT_CACHED
>
> but now you've changed that (c) case to "ACL_NOT_CACHED or random error value".
>
> You can't just mix these kinds of entirely different return values like that.
>
> So no, this is not at all acceptable.
>
> I would suggest:
>
>  (a) make the first patch actually test explicitly for LOOKUP_RCU, so
> that it's clear to the filesystems what is going on.
>
>      So instead of that pattern of
>
>         if (flags)
>                 return ERR_PTR(-EINVAL);
>
>      I'd suggest using
>
>         if (flags & LOOKUP_RCU)
>                 return ERR_PTR(-ECHILD);

Okay.

>
>    so that it actually matches what lookup does for the "I can't do
> this under RCU", and so that any reader of the code understands what
> "flags" is all about.
>
> And then
>
>  (b) make the get_cached_acl_rcu() case handle errors _properly_
> instead of mixing the special ACL cache markers with error returns.
>
>      So instead of
>
>         if (acl == ACL_DONT_CACHE)
>                 acl = inode->i_op->get_acl(inode, type, LOOKUP_RCU);
>
>      maybe something more along the lines of
>
>         if (acl == ACL_DONT_CACHE) {
>                 struct posix_acl *lookup_acl;
>                 lookup_acl = inode->i_op->get_acl(inode, type, LOOKUP_RCU);
>                 if (!IS_ERR(lookup_acl))
>                         acl = lookup_acl;
>         }
>
>      or whatever.

Yes, that's better.   Just to explain why my version was not actually
buggy:  ACL_DONT_CACHE is only used in overlayfs and not in any other
filesystem, so ->get_acl(... LOOKUP_RCU) not returning an error was
implicit in the implementation.   But your version makes that error
handling explicit, which is definitely an improvement.

>
> I disagree with Al that a "bool" would be better. I think LOOKUP_RCU
> is good documentation, and consistent with lookup, but it really needs
> to be *consistent*.  Thus that
>
>         if (flags & LOOKUP_RCU)
>                 return ERR_PTR(-ECHILD);
>
> pattern, not some "test underscibed flags, return -EINVAL" pattern
> that looks entirely nonsensical.

Al suggested:

 if (rcu)
   return ERR_PTR(-ECHILD);

which is also good documentation.  It also makes sure that "flags" is
not overloaded with other functionality (which was the reason for the
defensive "if any flag set return error" pattern).

Thanks,
Miklos
