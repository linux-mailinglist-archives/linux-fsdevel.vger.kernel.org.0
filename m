Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6732B7B45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 11:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgKRK03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 05:26:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53029 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgKRK03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:26:29 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kfKfP-00051l-1W; Wed, 18 Nov 2020 10:26:23 +0000
Date:   Wed, 18 Nov 2020 11:26:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH v2 36/39] overlayfs: do not mount on top of idmapped
 mounts
Message-ID: <20201118102622.f54adhoqucnwvel6@wittgenstein>
References: <20201115103718.298186-1-christian.brauner@ubuntu.com>
 <20201115103718.298186-37-christian.brauner@ubuntu.com>
 <CAOQ4uxi3OpvT5P7jQyPqGGK9tnhk_fni10G6+a3KC=-60udkTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi3OpvT5P7jQyPqGGK9tnhk_fni10G6+a3KC=-60udkTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 15, 2020 at 02:31:46PM +0200, Amir Goldstein wrote:
> On Sun, Nov 15, 2020 at 12:42 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > Prevent overlayfs from being mounted on top of idmapped mounts until we
> > have ported it to handle this case and added proper testing for it.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> > ---
> > /* v2 */
> > patch introduced
> > ---
> >  fs/overlayfs/super.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> > index 0d4f2baf6836..3cacc3d3fb65 100644
> > --- a/fs/overlayfs/super.c
> > +++ b/fs/overlayfs/super.c
> > @@ -1708,6 +1708,12 @@ static struct ovl_entry *ovl_get_lowerstack(struct super_block *sb,
> >                 if (err)
> >                         goto out_err;
> >
> > +               if (mnt_idmapped(stack[i].mnt)) {
> > +                       err = -EINVAL;
> > +                       pr_err("idmapped lower layers are currently unsupported\n");
> > +                       goto out_err;
> > +               }
> > +
> >                 lower = strchr(lower, '\0') + 1;
> >         }
> >
> > @@ -1939,6 +1945,12 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
> >                 if (err)
> >                         goto out_err;
> >
> > +               if (mnt_idmapped(upperpath.mnt)) {
> > +                       err = -EINVAL;
> > +                       pr_err("idmapped lower layers are currently unsupported\n");
> > +                       goto out_err;
> > +               }
> > +
> 
> Both checks should be replaced with one check in ovl_mount_dir_noesc()
> right next to ovl_dentry_weird() check and FWIW the error above about
> "lower layers" when referring to upperpath.mnt is confusing.
> "idmapped layers..." should be fine.

Noted, thanks!

Christian
