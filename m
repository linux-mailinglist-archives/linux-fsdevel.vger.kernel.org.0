Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BE75826AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiG0Mco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 08:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiG0McY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF31A1FCC4;
        Wed, 27 Jul 2022 05:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C06B614A4;
        Wed, 27 Jul 2022 12:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7C1C433D6;
        Wed, 27 Jul 2022 12:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658925132;
        bh=g/KeDrK+jJ4tTe8vBs+mW9oom/Igowkt6lbTWbMxH/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryJKaFyVScAyCGIRcG7LRDOPmJ/Bm1zrFBXA+eVHnOBYRzMF2KZNozRjrrUbtiCdM
         V05BaE0lB+NDSg3bv2TfLEtaO/Czwb2jqzw2bg6mTmkA8c0I7ICZ2hDBM1KfMPxlms
         ujxEKIb6H7af2u9aKZHiz0ah+6W4bGtsWXFWirl5VRLJFkg7jb6pZYlMRACNvpaLmQ
         Z39IClsGUIb/O9a6hRFLuXt67WorI+uB9v9KQrmEKpM4JSWhyJMeOsgkcDEdIB+UGv
         AlHAP7vLjmJdcwXazwglXr2HXkFJnXUIqWBu+sOGhi3RNK6BeMGHMx3AuzYURZIJw6
         4TDAZlXxAES9g==
Date:   Wed, 27 Jul 2022 14:32:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yongchen Yang <yoyang@redhat.com>
Subject: Re: [RFC PATCH] vfs: don't check may_create_in_sticky if the file is
 already open/created
Message-ID: <20220727123207.akq6dlnuqviwtwx5@wittgenstein>
References: <20220726202333.165490-1-jlayton@kernel.org>
 <8e4d498a3e8ed80ada2d3da01e7503e082be31a3.camel@kernel.org>
 <20220727113406.ewu4kzsoo643cf66@wittgenstein>
 <b1d3c63ef5a7e8f98966552b4509381aae25afb6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1d3c63ef5a7e8f98966552b4509381aae25afb6.camel@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 27, 2022 at 08:04:34AM -0400, Jeff Layton wrote:
> On Wed, 2022-07-27 at 13:34 +0200, Christian Brauner wrote:
> > On Tue, Jul 26, 2022 at 04:27:56PM -0400, Jeff Layton wrote:
> > > On Tue, 2022-07-26 at 16:23 -0400, Jeff Layton wrote:
> > > > NFS server is exporting a sticky directory (mode 01777) with root
> > > > squashing enabled. Client has protect_regular enabled and then tries to
> > > > open a file as root in that directory. File is created (with ownership
> > > > set to nobody:nobody) but the open syscall returns an error.
> > > > 
> > > > The problem is may_create_in_sticky, which rejects the open even though
> > > > the file has already been created/opened. Only call may_create_in_sticky
> > > > if the file hasn't already been opened or created.
> > > > 
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=1976829
> > > > Reported-by: Yongchen Yang <yoyang@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/namei.c | 13 +++++++++----
> > > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index 1f28d3f463c3..7480b6dc8d27 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -3495,10 +3495,15 @@ static int do_open(struct nameidata *nd,
> > > >  			return -EEXIST;
> > > >  		if (d_is_dir(nd->path.dentry))
> > > >  			return -EISDIR;
> > > > -		error = may_create_in_sticky(mnt_userns, nd,
> > > > -					     d_backing_inode(nd->path.dentry));
> > > > -		if (unlikely(error))
> > > > -			return error;
> > > > +		if (!(file->f_mode & (FMODE_OPENED | FMODE_CREATED))) {
> > > > +			error = may_create_in_sticky(mnt_userns, nd,
> > > > +						d_backing_inode(nd->path.dentry));
> > > > +			if (unlikely(error)) {
> > > > +				printk("%s: f_mode=0x%x oflag=0x%x\n",
> > > > +					__func__, file->f_mode, open_flag);
> > > > +				return error;
> > > > +			}
> > > > +		}
> > > >  	}
> > > >  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
> > > >  		return -ENOTDIR;
> > > 
> > > I'm pretty sure this patch is the wrong approach, actually, since it
> > > doesn't fix the regular (non-atomic) open codepath. Any thoughts on what
> > 
> > Hey Jeff,
> > 
> > I haven't quite understood why that won't work for the regular open
> > codepaths. I'm probably missing something obvious.
> > 
> 
> In the normal open codepaths, FMODE_OPENED | FMODE_CREATED are still
> clear. If we're not doing an atomic_open (i.e. the dentry doesn't exist
> yet or is negative), then nothing really happens until you get to the
> vfs_open call.

Hm, so for atomic open with O_CREAT it's:

path_openat()
-> open_last_lookups()
   -> lookup_open()
      /* 
       * This is ->atomic_open() and FMODE_CREATED is set in the fs so
       * for NFS it's done in:
       * fs/nfs/dir.c:           file->f_mode |= FMODE_CREATED;
       */
      -> atomic_open()

and for regular O_CREAT open it's:

path_openat()
-> open_last_lookups()
   -> lookup_open()
      {
        if (!dentry->d_inode && (open_flag & O_CREAT)) {
                file->f_mode |= FMODE_CREATED;
      }


and that should all get surfaced to:

path_openat()
   -> do_open()
      -> may_create_in_sticky()

?
