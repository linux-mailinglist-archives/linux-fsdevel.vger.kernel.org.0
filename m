Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3603634787F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 13:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhCXM3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 08:29:04 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:45388 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232207AbhCXM2c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 08:28:32 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lP2aZ-008pxL-JV; Wed, 24 Mar 2021 12:26:19 +0000
Date:   Wed, 24 Mar 2021 12:26:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 01/18] vfs: add miscattr ops
Message-ID: <YFsv63/2auZZs3ec@zeniv-ca.linux.org.uk>
References: <20210322144916.137245-1-mszeredi@redhat.com>
 <20210322144916.137245-2-mszeredi@redhat.com>
 <YFrH098Tbbezg2hI@zeniv-ca.linux.org.uk>
 <CAJfpegvy-bSoorAnPVRUxGjR5s10sJp3qRS0K-O91PcDvLSEPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvy-bSoorAnPVRUxGjR5s10sJp3qRS0K-O91PcDvLSEPg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 09:45:02AM +0100, Miklos Szeredi wrote:
> On Wed, Mar 24, 2021 at 6:03 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Mon, Mar 22, 2021 at 03:48:59PM +0100, Miklos Szeredi wrote:
> >
> > minor nit: copy_fsxattr_{to,from}_user() might be better.
> >
> > > +int fsxattr_copy_to_user(const struct miscattr *ma, struct fsxattr __user *ufa)
> > > +{
> > > +     struct fsxattr fa = {
> > > +             .fsx_xflags     = ma->fsx_xflags,
> > > +             .fsx_extsize    = ma->fsx_extsize,
> > > +             .fsx_nextents   = ma->fsx_nextents,
> > > +             .fsx_projid     = ma->fsx_projid,
> > > +             .fsx_cowextsize = ma->fsx_cowextsize,
> > > +     };
> >
> > That wants a comment along the lines of "guaranteed to be gap-free",
> > since otherwise you'd need memset() to avoid an infoleak.
> 
> Isn't structure initialization supposed to zero everything not
> explicitly initialized?

All fields, but not the padding...

> The one in io_uring() seems wrong also, as a beast needing
> file_dentry() should never get out of overlayfs and into io_uring:

That one would be wrong in overlayfs as well - we'd better had the
same names in all layers...

> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -9297,7 +9297,7 @@ static void __io_uring_show_fdinfo(struct
> io_ring_ctx *ctx, struct seq_file *m)
>                 struct file *f = *io_fixed_file_slot(ctx->file_data, i);
> 
>                 if (f)
> -                       seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
> +                       seq_printf(m, "%5u: %pD\n", i, f);
>                 else
>                         seq_printf(m, "%5u: <none>\n", i);
>         }
> 
> 
> Thanks,
> Miklos
