Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB2E3A8A48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhFOUnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 16:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbhFOUnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:43:03 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA181C061574;
        Tue, 15 Jun 2021 13:40:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y7so48239wrh.7;
        Tue, 15 Jun 2021 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IMjvX9hfQnFo8c8T6Oa+lxK8589Rb/CvuLF9yLKTHb0=;
        b=i8ulPueW4eSGAFNJIGTawwLwOUCCF/68M+vbfBTbNh7rYA2OciLl13aiU1qhCwmjTZ
         a9AqZiwmKd+yxIEqPXOswQJU7ZaG9kMSxh5HIzOIiwDXMwGCiwk20O7qRzvEVDHgeTBG
         EJV6hna4JKRc04XiJN60p3ucTJ9JZ98yo6WLKnrToeV9uCFSa+j/qp1RQmo2oOuimOrO
         zfLWSXNkg7Xk8zGWnmOL0FdIKtNiWXVB87NnOBg5q0IvwTHSFjrfSTHa2uN/spazmAXI
         SWPXUwH1MWO2xpgN/njwGXrEKf+zED2dmjHT59V5r+NZ5JTiIfzm8AFHGLdrPFDXvrLI
         MA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IMjvX9hfQnFo8c8T6Oa+lxK8589Rb/CvuLF9yLKTHb0=;
        b=ocO8Fdte1OD5UCC5JKq4nTZCSqLzPTdhxEeNDidY4iRXL7TqCoFEm67J4C+QrzEfxZ
         qHdzKcIBAQffZYLv5mmJmnL/sTmyidwLUrmzHdfrO6eg6ZRHh0gR3CcrTYEUPAQwxvXn
         XfHavZYm/t0ZZPH2PnrRv4c5TQiLY8TSrFvSrRKpGwSxKAt9DjuKONIpkrypudkqHAAE
         qkRWZd9lGD1U2blMOMagzhQxN6FDtODz1nOfE1/TrdTkryhsuSxFl9MQjS2NYtHdY1dg
         1vrhpWafVrDQ1ETqJqgvIWbztyfFbDXsm4rPskO4U6HSgNoP0srFQxG5TfPZEJt/4g2o
         T4mQ==
X-Gm-Message-State: AOAM533E2quDSBJ3cR3Ynirg1HenBA7Eo6t7whBYQIjxMDYYwwA4bQJ+
        aUBvOonPH1BUuB1HnnLvMkzd3wUxzWIXhNrfQE4=
X-Google-Smtp-Source: ABdhPJxqp/ESz5upedV1r3eEylaoPl9d6aaSFyarULArTgNIHSCANEcBAVEybt1O9EzcyPkkeiHgO1n03ajaP4sbIlM=
X-Received: by 2002:adf:f6d1:: with SMTP id y17mr1145358wrp.250.1623789657126;
 Tue, 15 Jun 2021 13:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210615154952.2744-1-justin.he@arm.com> <20210615154952.2744-2-justin.he@arm.com>
In-Reply-To: <20210615154952.2744-2-justin.he@arm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Jun 2021 23:40:40 +0300
Message-ID: <CAHp75Vdpw6A0r0cjJKF8XhGL0-PccXHS1BXL1w04P37-027jUw@mail.gmail.com>
Subject: Re: [PATCH RFCv4 1/4] fs: introduce helper d_path_unsafe()
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 6:56 PM Jia He <justin.he@arm.com> wrote:
>
> This helper is similar to d_path except that it doesn't take any
> seqlock/spinlock. It is typical for debugging purpose. Besides,

purposes

> an additional return value *prenpend_len* is used to get the full
> path length of the dentry.
>
> prepend_name_with_len() enhances the behavior of prepend_name().
> Previously it will skip the loop at once in __prepen_path() when the
> space is not enough. __prepend_path() gets the full length of dentry
> together with the parent recusively.

recursively

>
> Besides, if someone invokes snprintf with small but positive space,
> prepend_name_with() needs to move and copy the string partially.
>
> More than that, kasnprintf will pass NULL _buf_ and _end_, hence

kasprintf()

> it returns at the very beginning with false in this case;
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  fs/d_path.c            | 83 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/dcache.h |  1 +
>  2 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 23a53f7b5c71..4fc224eadf58 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -68,9 +68,66 @@ static bool prepend_name(struct prepend_buffer *p, const struct qstr *name)
>         return true;
>  }
>
> +static bool prepend_name_with_len(struct prepend_buffer *p, const struct qstr *name,
> +                        int orig_buflen)
> +{
> +       const char *dname = smp_load_acquire(&name->name); /* ^^^ */

What does this funny comment mean?

> +       int dlen = READ_ONCE(name->len);
> +       char *s;
> +       int last_len = p->len;
> +
> +       p->len -= dlen + 1;
> +
> +       if (unlikely(!p->buf))
> +               return false;
> +
> +       if (orig_buflen <= 0)
> +               return false;
> +       /*
> +        * The first time we overflow the buffer. Then fill the string
> +        * partially from the beginning
> +        */
> +       if (unlikely(p->len < 0)) {
> +               int buflen = strlen(p->buf);
> +
> +               s = p->buf;
> +
> +               /* Still have small space to fill partially */
> +               if (last_len > 0) {
> +                       p->buf -= last_len;
> +                       buflen += last_len;
> +               }
> +
> +               if (buflen > dlen + 1) {
> +                       /* This dentry name can be fully filled */
> +                       memmove(p->buf + dlen + 1, s, buflen - dlen - 1);
> +                       p->buf[0] = '/';
> +                       memcpy(p->buf + 1, dname, dlen);
> +               } else if (buflen > 0) {
> +                       /* Partially filled, and drop last dentry name */
> +                       p->buf[0] = '/';
> +                       memcpy(p->buf + 1, dname, buflen - 1);
> +               }
> +
> +               return false;
> +       }
> +
> +       s = p->buf -= dlen + 1;
> +       *s++ = '/';

> +       while (dlen--) {
> +               char c = *dname++;
> +
> +               if (!c)
> +                       break;
> +               *s++ = c;

I'm wondering why can't memcpy() be used here as well.

> +       }
> +       return true;
> +}
>  static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
>                           const struct path *root, struct prepend_buffer *p)
>  {
> +       int orig_buflen = p->len;
> +
>         while (dentry != root->dentry || &mnt->mnt != root->mnt) {
>                 const struct dentry *parent = READ_ONCE(dentry->d_parent);
>
> @@ -97,8 +154,7 @@ static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
>                         return 3;
>
>                 prefetch(parent);
> -               if (!prepend_name(p, &dentry->d_name))
> -                       break;
> +               prepend_name_with_len(p, &dentry->d_name, orig_buflen);
>                 dentry = parent;
>         }
>         return 0;
> @@ -263,6 +319,29 @@ char *d_path(const struct path *path, char *buf, int buflen)
>  }
>  EXPORT_SYMBOL(d_path);
>
> +/**
> + * d_path_unsafe - fast return the full path of a dentry without taking
> + * any seqlock/spinlock. This helper is typical for debugging purpose.

purposes

Haven't you got kernel doc validation warnings? Please, describe
parameters as well.

> + */
> +char *d_path_unsafe(const struct path *path, char *buf, int buflen,
> +                   int *prepend_len)
> +{
> +       struct path root;
> +       struct mount *mnt = real_mount(path->mnt);
> +       DECLARE_BUFFER(b, buf, buflen);
> +
> +       rcu_read_lock();
> +       get_fs_root_rcu(current->fs, &root);
> +
> +       prepend(&b, "", 1);
> +       __prepend_path(path->dentry, mnt, &root, &b);
> +       rcu_read_unlock();
> +
> +       *prepend_len = b.len;
> +
> +       return b.buf;
> +}
> +
>  /*
>   * Helper function for dentry_operations.d_dname() members
>   */
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 9e23d33bb6f1..ec118b684055 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -301,6 +301,7 @@ char *dynamic_dname(struct dentry *, char *, int, const char *, ...);
>  extern char *__d_path(const struct path *, const struct path *, char *, int);
>  extern char *d_absolute_path(const struct path *, char *, int);
>  extern char *d_path(const struct path *, char *, int);
> +extern char *d_path_unsafe(const struct path *, char *, int, int*);
>  extern char *dentry_path_raw(const struct dentry *, char *, int);
>  extern char *dentry_path(const struct dentry *, char *, int);
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
