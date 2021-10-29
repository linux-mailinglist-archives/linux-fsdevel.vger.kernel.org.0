Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFED43F93D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 10:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhJ2IxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 04:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231533AbhJ2IxO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:53:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 574DE61075;
        Fri, 29 Oct 2021 08:50:44 +0000 (UTC)
Date:   Fri, 29 Oct 2021 10:50:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     andriy.shevchenko@linux.intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, revest@chromium.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] seq_file: fix passing wrong private data
Message-ID: <20211029085041.fhyi2kn3bdmxt6h4@wittgenstein>
References: <20211029032638.84884-1-songmuchun@bytedance.com>
 <20211029082620.jlnauplkyqmaz3ze@wittgenstein>
 <CAMZfGtUMLD183qHVt6=8gU4nnQD2pn1gZwZJOjCHFK73wK0=kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZfGtUMLD183qHVt6=8gU4nnQD2pn1gZwZJOjCHFK73wK0=kQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 29, 2021 at 04:43:40PM +0800, Muchun Song wrote:
> On Fri, Oct 29, 2021 at 4:26 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Fri, Oct 29, 2021 at 11:26:38AM +0800, Muchun Song wrote:
> > > DEFINE_PROC_SHOW_ATTRIBUTE() is supposed to be used to define a series
> > > of functions and variables to register proc file easily. And the users
> > > can use proc_create_data() to pass their own private data and get it
> > > via seq->private in the callback. Unfortunately, the proc file system
> > > use PDE_DATA() to get private data instead of inode->i_private. So fix
> > > it. Fortunately, there only one user of it which does not pass any
> > > private data, so this bug does not break any in-tree codes.
> > >
> > > Fixes: 97a32539b956 ("proc: convert everything to "struct proc_ops"")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  include/linux/seq_file.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> > > index 103776e18555..72dbb44a4573 100644
> > > --- a/include/linux/seq_file.h
> > > +++ b/include/linux/seq_file.h
> > > @@ -209,7 +209,7 @@ static const struct file_operations __name ## _fops = {                   \
> > >  #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)                           \
> > >  static int __name ## _open(struct inode *inode, struct file *file)   \
> > >  {                                                                    \
> > > -     return single_open(file, __name ## _show, inode->i_private);    \
> > > +     return single_open(file, __name ## _show, PDE_DATA(inode));     \
> > >  }                                                                    \
> > >                                                                       \
> > >  static const struct proc_ops __name ## _proc_ops = {                 \
> >
> > Hm, after your change DEFINE_SHOW_ATTRIBUTE() and
> > DEFINE_PROC_SHOW_ATTRIBUTE() macros do exactly the same things, right?:
> 
> Unfortunately, they are not the same. The difference is the
> operation structure, namely "struct file_operations" and
> "struct proc_ops".
> 
> DEFINE_SHOW_ATTRIBUTE() is usually used by
> debugfs while DEFINE_SHOW_ATTRIBUTE() is
> used by procfs.

Ugh, right, thanks for pointing that out. I overlooked the _proc_ops
appendix. Not sure what's right here. There seem to have been earlier
callers to DEFINE_PROC_SHOW_ATTRIBUTE() that relied on PDE_DATA() but
there's only one caller so that change wouldn't be too bad, I guess.
