Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D244E5BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 12:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhKLLum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 06:50:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234825AbhKLLul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 06:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636717670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v4OuXUoeOpl8LUYZZqDtUhykb+3X5x4evTPnPE8XQsU=;
        b=amYcGApCm7N2pSJSgHSpcc7bJuUtpo/eTXR1lvG9zs48fp/FJfGY4/0bHfXeatgesLCJ1x
        F++XcD7YwmidUqpTmV/BgiDHQNO+oXK3ssMkPxekBVArk/2O6OIx5TDQxIaDr6rcs3TLnU
        iXYCw/z5g/L9xS8UOGJmkKu1VT4sUhA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-hl5dYlWSNu26VZ9rXuk5zg-1; Fri, 12 Nov 2021 06:47:49 -0500
X-MC-Unique: hl5dYlWSNu26VZ9rXuk5zg-1
Received: by mail-qv1-f69.google.com with SMTP id kl17-20020a056214519100b003ba5b03606fso8248094qvb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 03:47:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v4OuXUoeOpl8LUYZZqDtUhykb+3X5x4evTPnPE8XQsU=;
        b=YeTEB5RfVBO25AB5EvDKnS97pG3w5gIpIfSn4upxY0ku9opjpkjc5VuTC7p1a3NseG
         JWMQBtG7QPKPKa2XZzOhhPGxY7ZYcnI7nRpOLh6LVMQ5lSQfvr9XoQ2PRkB8+2+xZ7To
         Zv0x8xqrzGLKSb0AQjTe/Z2n+gM8SZ5YVSxDQDpyB9T0scvOOK3KF0uesogQd6z6MVas
         GrWA5GOkwdnEf5O7xXzzrhBQx7YTQGe+EiVrbOlEf0HT3NGEjR8K8hX7bJNzZGG8n+8d
         +MlBr3Vmm5CwuVkLYYmPD0fJjaXv6qr8jr7oUzM4OwfY3SQ9De8YtoTxVYJeMdka6Lv1
         O+jw==
X-Gm-Message-State: AOAM530iw1F6FDENhdGSZdoud4tYNs3/AppfKcibCkgP6dA/6OI4WvZu
        FvkcjT60b45ODIhjmjpZA0v5Nzwn7plhk/MqapHW88doWXW26Ww4/C3Kz1VWFXR4Ul41vuacz6R
        SN69qHLUamFZwxwUGgn8wTFOpWg==
X-Received: by 2002:a05:620a:298a:: with SMTP id r10mr11793935qkp.447.1636717669002;
        Fri, 12 Nov 2021 03:47:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCTDKvvfjdw0HJ8O++xPg61zXkuCOUyFz9+e2lPaastmbafow3rqRzgZFUMmLH7k5X2z2kuw==
X-Received: by 2002:a05:620a:298a:: with SMTP id r10mr11793911qkp.447.1636717668739;
        Fri, 12 Nov 2021 03:47:48 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id br17sm2649538qkb.10.2021.11.12.03.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 03:47:48 -0800 (PST)
Date:   Fri, 12 Nov 2021 06:47:46 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <YY5UYitVcs7pPklb@bfoster>
References: <163660195990.22525.6041281669106537689.stgit@mickey.themaw.net>
 <163660197073.22525.11235124150551283676.stgit@mickey.themaw.net>
 <YY1AEaHRLe+P4IYr@bfoster>
 <ed30a482ce8404de7974bc86b4c9fc98a5ae9060.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed30a482ce8404de7974bc86b4c9fc98a5ae9060.camel@themaw.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 12, 2021 at 07:10:19AM +0800, Ian Kent wrote:
> On Thu, 2021-11-11 at 11:08 -0500, Brian Foster wrote:
> 
> Hi Brian,
> 
> > On Thu, Nov 11, 2021 at 11:39:30AM +0800, Ian Kent wrote:
> > > When following a trailing symlink in rcu-walk mode it's possible to
> > > succeed in getting the ->get_link() method pointer but the link
> > > path
> > > string be deallocated while it's being used.
> > > 
> > > Utilize the rcu mechanism to mitigate this risk.
> > > 
> > > Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
> > > Signed-off-by: Ian Kent <raven@themaw.net>
> > > ---
> > >  fs/xfs/kmem.h      |    4 ++++
> > >  fs/xfs/xfs_inode.c |    4 ++--
> > >  fs/xfs/xfs_iops.c  |   10 ++++++++--
> > >  3 files changed, 14 insertions(+), 4 deletions(-)
> > > 
> > ...
> > > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > > index a607d6aca5c4..2977e19da7b7 100644
> > > --- a/fs/xfs/xfs_iops.c
> > > +++ b/fs/xfs/xfs_iops.c
> > > @@ -524,11 +524,17 @@ xfs_vn_get_link_inline(
> > >  
> > >         /*
> > >          * The VFS crashes on a NULL pointer, so return -
> > > EFSCORRUPTED if
> > > -        * if_data is junk.
> > > +        * if_data is junk. Also, if the path walk is in rcu-walk
> > > mode
> > > +        * and the inode link path has gone away due inode re-use
> > > we have
> > > +        * no choice but to tell the VFS to redo the lookup.
> > >          */
> > > -       link = ip->i_df.if_u1.if_data;
> > > +       link = rcu_dereference(ip->i_df.if_u1.if_data);
> > > +       if (!dentry && !link)
> > > +               return ERR_PTR(-ECHILD);
> > > +
> > 
> > One thing that concerns me slightly about this approach is that inode
> > reuse does not necessarily guarantee that if_data is NULL. It seems
> > technically just as possible (even if exceedingly unlikely) for link
> > to
> > point at newly allocated memory since the previous sequence count
> > validation check. The inode could be reused as another inline symlink
> > for example, though it's not clear to me if that is really a problem
> > for
> > the vfs (assuming a restart would just land on the new link
> > anyways?).
> > But the inode could also be reallocated as something like a shortform
> > directory, which means passing directory header data or whatever that
> > it
> > stores in if_data back to pick_link(), which is then further
> > processed
> > as a string.
> 
> This is the sort of feedback I was hoping for.
> 
> This sounds related to the life-cycle of xfs inodes and re-use.
> Hopefully someone here on the list can enlighten me on this.
> 
> The thing that comes to mind is that the inode re-use would
> need to occur between the VFS check that validates the inode
> is still ok and the use of link string. I think that can still
> go away even with the above check.
> 

Yeah... The original NULL ->get_link() problem was replicated with a
small delay in the lookup path (specifically in the symlink processing
path). This essentially widens the race window and allows a separate
task to invalidate the dentry between the time the last dentry sequence
validation occurred (and passed) and the attempt to call ->get_link()
becomes imminent. I think patch 1 largely addresses this issue because
we'll have revalidated the previous read of the function pointer before
we attempt to call it.

That leads to this patch, which suggests that even after the validation
fix a small race window still technically exists with the ->get_link()
code and inode teardown. In fact, it's not that hard to show that this
is true by modifying the original reproducer to push the delay out
beyond the check added by patch 1 (or into the ->get_link() callback).
Playing around with that a bit, it's possible to induce a ->get_link()
call to an inode that was reallocated as a shortform directory and
returns a non-NULL if_data fork of that dir back to the vfs (to be
interpreted as a symlink string). Nothing seems to explode on my quick
test, fortunately, but I don't think that's an interaction we want to
maintain.

Of course one caveat to all of that is that after patch 1, the race
window for that one might be so small as to make this impossible to
reproduce in practice (whereas the problem fixed by patch 1 has been
reproduced by users)...

> Hopefully someone can clarify what happens here.
> 
> > 
> > With that, I wonder why we wouldn't just return -ECHILD here like we
> > do
> > for the non-inline case to address the immediate problem, and then
> > perhaps separately consider if we can rework bits of the
> > reuse/reclaim
> > code to allow rcu lookup of inline symlinks under certain conditions.
> 
> Always switching to ref-walk mode would certainly resolve the
> problem too, yes, perhaps we have no choice ...
> 

Oh I don't think it's the only choice. I think Miklos' suggestion to use
->free_inode() is probably the right general approach. I just think a
switch to ref-walk mode might be a good incremental step to fix this
problem in a backportable way (s_op->free_inode() is newer relative to
the introduction of _get_link_inline()). We can always re-enable rcu
symlink processing once we get our inode teardown/reuse bits fixed up
accordingly.. Just my .02.

Brian

> Ian
> > 
> > FWIW, I'm also a little curious why we don't set i_link for inline
> > symlinks. I don't think that addresses this validation problem, but
> > perhaps might allow rcu lookups in the inline symlink common case
> > where
> > things don't change during the lookup (and maybe even eliminate the
> > need
> > for this custom inline callback)..?
> > 
> > Brian
> > 
> > >         if (XFS_IS_CORRUPT(ip->i_mount, !link))
> > >                 return ERR_PTR(-EFSCORRUPTED);
> > > +
> > >         return link;
> > >  }
> > >  
> > > 
> > > 
> > 
> 
> 

