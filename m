Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345CB43F925
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhJ2Iqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 04:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhJ2Iqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:46:46 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2566EC061570
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 01:44:17 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id t127so22342436ybf.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENq4tjivAFtiLBoYaEjwhbRErXjlHM0kRyDue+qYR8s=;
        b=wRn5p+8tRNX5KLoW5FWn6gbyOOsxcJsU6RD5Ia1CYcJmX4QNemi4NBR1v1FhdoFBWN
         CxzEwVaSfJD7rqFooBD/Xk8DgteDg2OUUabV1EX8aimjdrJa6wA1aCjfKcW7drJbuph9
         LpCWC5/xpF1SQ2oZ2hTFijmDbGaaRKaAbbKuEPD5WjY1TlU66NyhY7lV9voUwhJnMK0B
         VEYBn+ZvcEMzCajC4hlEkqV0gEFFAGHQgIjEsY03dS/B0Hc8vjltNuATxMHLgP5Jy/Qh
         sJV1y6dl9Y58Bu5jSugY84sgQssseEqzx5/2u+2Crw6wMAsPBg81y0o0xcYh23URjyqC
         /ykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENq4tjivAFtiLBoYaEjwhbRErXjlHM0kRyDue+qYR8s=;
        b=3svQ8dpH1S5CE1qGGBol04G8na97CVmL42nYnEr42fDJfIRzC0ze6hTa13IEd6O2oO
         ubN62otqjQ6iCGuUpiBpphH8Ii8R8gOg8HZCzLioiKNynCmudn3ZKXwpj3haBP26p9Ct
         a4xdaNeDbjOPgsrnufnmeCbiNfvgD5FT00R/8Y2W0zyQgbqIV6Yy6JPxl3He3hdqH8rY
         e13fcOONC6QwZ5brQnjc43cWCrlMbfOTOBV0x3HaqIkW+UYYpseh4TSF7ZqMpyN7Zzcn
         ypMBtE4LaOcAxoB08vfCRN8I/7p2v39CNeyT9uoY5vc2BBzzROI18uFnCpIbkHoUnYVp
         zslA==
X-Gm-Message-State: AOAM532iTKuD7PbwPdMHT4wkBnOLq6K/arEOoCqWqRBxQlyPGllRyvN4
        L13bEZQ15g1g2+oOqI2NLrVfEWRYQcbGhmYfF3a4dg==
X-Google-Smtp-Source: ABdhPJxyHQR9n5o6twKULKxgFVOpVVXROEmQZR/EKRl6qL52zK8Dzfugbqjb0Ygz5V+6TXY8xU3LBGJ13typbBD3Iro=
X-Received: by 2002:a25:ad02:: with SMTP id y2mr10484185ybi.141.1635497056643;
 Fri, 29 Oct 2021 01:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211029032638.84884-1-songmuchun@bytedance.com> <20211029082620.jlnauplkyqmaz3ze@wittgenstein>
In-Reply-To: <20211029082620.jlnauplkyqmaz3ze@wittgenstein>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 29 Oct 2021 16:43:40 +0800
Message-ID: <CAMZfGtUMLD183qHVt6=8gU4nnQD2pn1gZwZJOjCHFK73wK0=kQ@mail.gmail.com>
Subject: Re: [PATCH] seq_file: fix passing wrong private data
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     andriy.shevchenko@linux.intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, revest@chromium.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 4:26 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Oct 29, 2021 at 11:26:38AM +0800, Muchun Song wrote:
> > DEFINE_PROC_SHOW_ATTRIBUTE() is supposed to be used to define a series
> > of functions and variables to register proc file easily. And the users
> > can use proc_create_data() to pass their own private data and get it
> > via seq->private in the callback. Unfortunately, the proc file system
> > use PDE_DATA() to get private data instead of inode->i_private. So fix
> > it. Fortunately, there only one user of it which does not pass any
> > private data, so this bug does not break any in-tree codes.
> >
> > Fixes: 97a32539b956 ("proc: convert everything to "struct proc_ops"")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/seq_file.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> > index 103776e18555..72dbb44a4573 100644
> > --- a/include/linux/seq_file.h
> > +++ b/include/linux/seq_file.h
> > @@ -209,7 +209,7 @@ static const struct file_operations __name ## _fops = {                   \
> >  #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)                           \
> >  static int __name ## _open(struct inode *inode, struct file *file)   \
> >  {                                                                    \
> > -     return single_open(file, __name ## _show, inode->i_private);    \
> > +     return single_open(file, __name ## _show, PDE_DATA(inode));     \
> >  }                                                                    \
> >                                                                       \
> >  static const struct proc_ops __name ## _proc_ops = {                 \
>
> Hm, after your change DEFINE_SHOW_ATTRIBUTE() and
> DEFINE_PROC_SHOW_ATTRIBUTE() macros do exactly the same things, right?:

Unfortunately, they are not the same. The difference is the
operation structure, namely "struct file_operations" and
"struct proc_ops".

DEFINE_SHOW_ATTRIBUTE() is usually used by
debugfs while DEFINE_SHOW_ATTRIBUTE() is
used by procfs.

Thanks.

>
> #define DEFINE_SHOW_ATTRIBUTE(__name)                                   \
> static int __name ## _open(struct inode *inode, struct file *file)      \
> {                                                                       \
>         return single_open(file, __name ## _show, inode->i_private);    \
> }                                                                       \
>                                                                         \
> static const struct file_operations __name ## _fops = {                 \
>         .owner          = THIS_MODULE,                                  \
>         .open           = __name ## _open,                              \
>         .read           = seq_read,                                     \
>         .llseek         = seq_lseek,                                    \
>         .release        = single_release,                               \
> }
>
> #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)                              \
> static int __name ## _open(struct inode *inode, struct file *file)      \
> {                                                                       \
>         return single_open(file, __name ## _show, inode->i_private);    \
> }                                                                       \
>
> Can't you just replace the single instance where
> DEFINE_PROC_SHOW_ATTRIBUTE with DEFINE_SHOW_ATTRIBUTE() and remove
> DEFINE_PROC_SHOW_ATTRIBUTE completely?
>
> Christian
