Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF483A42BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 15:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhFKNNO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 09:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhFKNNO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:13:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C642613DF;
        Fri, 11 Jun 2021 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623417076;
        bh=HjD6ATEHpIBvWwW2dFdI6JGuiSnbs0d11W1EQk87HK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEeYxrv2qE/H4pN9gcdAaIU4RGw4zLIA4uJlrOUd/sXlOnYfWL/q3+e+5PGQgxKPa
         1gjo1t2fUXvd5n7YWrPERdSj0Oan+en01fRDBTVe3/EXLRChsqFYinN5ZyFr0gnp8r
         fjmKmoEX6ZqT7IfTCsblEK0JEsV9uIaOJ4VHyt9c=
Date:   Fri, 11 Jun 2021 15:11:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/7] kernfs: add a revision to identify directory node
 changes
Message-ID: <YMNg8VD8XlUJGSK9@kroah.com>
References: <162322846765.361452.17051755721944717990.stgit@web.messagingengine.com>
 <162322859985.361452.14110524195807923374.stgit@web.messagingengine.com>
 <CAJfpeguzPEy+UAcyT4tcpvYxeTwB+64yxRw8Sh7UBROBuafYdw@mail.gmail.com>
 <03f6e366fb4ebb56b15541d53eda461a55d3d38e.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03f6e366fb4ebb56b15541d53eda461a55d3d38e.camel@themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 11, 2021 at 08:56:18PM +0800, Ian Kent wrote:
> On Fri, 2021-06-11 at 14:49 +0200, Miklos Szeredi wrote:
> > On Wed, 9 Jun 2021 at 10:50, Ian Kent <raven@themaw.net> wrote:
> > > 
> > > Add a revision counter to kernfs directory nodes so it can be used
> > > to detect if a directory node has changed during negative dentry
> > > revalidation.
> > > 
> > > There's an assumption that sizeof(unsigned long) <= sizeof(pointer)
> > > on all architectures and as far as I know that assumption holds.
> > > 
> > > So adding a revision counter to the struct kernfs_elem_dir variant
> > > of
> > > the kernfs_node type union won't increase the size of the
> > > kernfs_node
> > > struct. This is because struct kernfs_elem_dir is at least
> > > sizeof(pointer) smaller than the largest union variant. It's
> > > tempting
> > > to make the revision counter a u64 but that would increase the size
> > > of
> > > kernfs_node on archs where sizeof(pointer) is smaller than the
> > > revision
> > > counter.
> > > 
> > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > ---
> > >  fs/kernfs/dir.c             |    2 ++
> > >  fs/kernfs/kernfs-internal.h |   23 +++++++++++++++++++++++
> > >  include/linux/kernfs.h      |    5 +++++
> > >  3 files changed, 30 insertions(+)
> > > 
> > > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > > index 33166ec90a112..b3d1bc0f317d0 100644
> > > --- a/fs/kernfs/dir.c
> > > +++ b/fs/kernfs/dir.c
> > > @@ -372,6 +372,7 @@ static int kernfs_link_sibling(struct
> > > kernfs_node *kn)
> > >         /* successfully added, account subdir number */
> > >         if (kernfs_type(kn) == KERNFS_DIR)
> > >                 kn->parent->dir.subdirs++;
> > > +       kernfs_inc_rev(kn->parent);
> > > 
> > >         return 0;
> > >  }
> > > @@ -394,6 +395,7 @@ static bool kernfs_unlink_sibling(struct
> > > kernfs_node *kn)
> > > 
> > >         if (kernfs_type(kn) == KERNFS_DIR)
> > >                 kn->parent->dir.subdirs--;
> > > +       kernfs_inc_rev(kn->parent);
> > > 
> > >         rb_erase(&kn->rb, &kn->parent->dir.children);
> > >         RB_CLEAR_NODE(&kn->rb);
> > > diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-
> > > internal.h
> > > index ccc3b44f6306f..b4e7579e04799 100644
> > > --- a/fs/kernfs/kernfs-internal.h
> > > +++ b/fs/kernfs/kernfs-internal.h
> > > @@ -81,6 +81,29 @@ static inline struct kernfs_node
> > > *kernfs_dentry_node(struct dentry *dentry)
> > >         return d_inode(dentry)->i_private;
> > >  }
> > > 
> > > +static inline void kernfs_set_rev(struct kernfs_node *kn,
> > > +                                 struct dentry *dentry)
> > > +{
> > > +       if (kernfs_type(kn) == KERNFS_DIR)
> > > +               dentry->d_time = kn->dir.rev;
> > > +}
> > > +
> > > +static inline void kernfs_inc_rev(struct kernfs_node *kn)
> > > +{
> > > +       if (kernfs_type(kn) == KERNFS_DIR)
> > > +               kn->dir.rev++;
> > > +}
> > > +
> > > +static inline bool kernfs_dir_changed(struct kernfs_node *kn,
> > > +                                     struct dentry *dentry)
> > > +{
> > > +       if (kernfs_type(kn) == KERNFS_DIR) {
> > 
> > Aren't these always be called on a KERNFS_DIR node?
> 
> Yes they are.
> 
> > 
> > You could just reduce that to a WARN_ON, or remove the conditions
> > altogether then.
> 
> I was tempted to not use the check, a WARN_ON sounds better than
> removing the check, I'll do that in a v7.

No, WARN_ON is not ok, as systems will crash if panic-on-warn is set.

If these are impossible to hit, great, let's not check this and we can
just drop the code.  If they can be hit, then the above code is correct
and it should stay.

thanks,

greg k-h
