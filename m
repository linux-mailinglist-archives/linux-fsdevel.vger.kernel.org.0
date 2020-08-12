Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3B24269A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHLISn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 04:18:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgHLISn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:18:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5255620774;
        Wed, 12 Aug 2020 08:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597220322;
        bh=DZe4rDhjzxljBRgO7VQ+ytJ53LFjK1MMm84lYaTTDBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aoTbN6qbRHC8oLTWGWsg1IOq4qT55TJQzev+Ml+0+6WYL2d5Rr5res40LMxOW9Stk
         h6SlHs3E9bKMCM42TIdi3JvHICDxpR9+DIqlAw1cQrvA7JDwU6hA1GtOEVR1FymycK
         dmyF1wg1RL7LMKxfQKwABHqtuEwdM/q+lI94p+ww=
Date:   Wed, 12 Aug 2020 10:18:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH] hfs, hfsplus: Fix NULL pointer
 dereference in hfs_find_init()
Message-ID: <20200812081852.GA851575@kroah.com>
References: <20200812065556.869508-1-yepeilin.cs@gmail.com>
 <20200812070827.GA1304640@kroah.com>
 <20200812071306.GA869606@PWN>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812071306.GA869606@PWN>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 03:13:06AM -0400, Peilin Ye wrote:
> On Wed, Aug 12, 2020 at 09:08:27AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 12, 2020 at 02:55:56AM -0400, Peilin Ye wrote:
> > > Prevent hfs_find_init() from dereferencing `tree` as NULL.
> > > 
> > > Reported-and-tested-by: syzbot+7ca256d0da4af073b2e2@syzkaller.appspotmail.com
> > > Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> > > ---
> > >  fs/hfs/bfind.c     | 3 +++
> > >  fs/hfsplus/bfind.c | 3 +++
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> > > index 4af318fbda77..880b7ea2c0fc 100644
> > > --- a/fs/hfs/bfind.c
> > > +++ b/fs/hfs/bfind.c
> > > @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
> > >  {
> > >  	void *ptr;
> > >  
> > > +	if (!tree)
> > > +		return -EINVAL;
> > > +
> > >  	fd->tree = tree;
> > >  	fd->bnode = NULL;
> > >  	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> > > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > > index ca2ba8c9f82e..85bef3e44d7a 100644
> > > --- a/fs/hfsplus/bfind.c
> > > +++ b/fs/hfsplus/bfind.c
> > > @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
> > >  {
> > >  	void *ptr;
> > >  
> > > +	if (!tree)
> > > +		return -EINVAL;
> > > +
> > 
> > How can tree ever be NULL in these calls?  Shouldn't that be fixed as
> > the root problem here?
> 
> I see, I will try to figure out what is going on with the reproducer.

That's good to figure out.  Note, your patch might be the correct thing
to do, as that might be an allowed way to call the function.  But in
looking at all the callers, they seem to think they have a valid pointer
at the moment, so perhaps if this check is added, some other root
problem is papered over to be only found later on?

thanks,

greg k-h
