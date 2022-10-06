Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD85F6168
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Oct 2022 09:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiJFHJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 03:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiJFHJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:09:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70C47FFB9;
        Thu,  6 Oct 2022 00:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47AAEB8200E;
        Thu,  6 Oct 2022 07:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E297C433C1;
        Thu,  6 Oct 2022 07:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665040134;
        bh=GIycMYdJrWmWWTMboDPEwhhyBa0pYdnyXPpIPz/1g9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3Lp9GWXTMBfeqXYVRytWhkxNKCZMLUz+1kwDb/GYxdgZTo6bGSQrIy1sOlnLDMwM
         t0DqYUKIgTVLLH+YbDFp24lKzQeydM8087xjolddOejfddJHvhhKniM+L/0sNl/5Ex
         ZmAOuiygqLUrma0q7Ch80am6oILtiDUBdQzQIwGOeZ5eHKZruAvla5/cEaYwg9v2dO
         9rRPvtN7s4FqnGnB2TXbryWDnlKwppmOnqnG+4iBzQ7MU7KOOBaiY69Es3EdEfFkOu
         OeFXfFriHLO6cje/UJW/Q6i0MukUpMoC1OWhfUh5HFo9aXTZyFq1OA8bKkPXqz+aQ5
         jWQ6FQDJrb5Pw==
Date:   Thu, 6 Oct 2022 09:08:48 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] attr: use consistent sgid stripping checks
Message-ID: <20221006070848.r6uow4qw6vp5fuut@wittgenstein>
References: <20221005151433.898175-1-brauner@kernel.org>
 <20221005151433.898175-2-brauner@kernel.org>
 <20221005212851.GB2703033@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005212851.GB2703033@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 08:28:51AM +1100, Dave Chinner wrote:
> On Wed, Oct 05, 2022 at 05:14:31PM +0200, Christian Brauner wrote:
> > diff --git a/fs/inode.c b/fs/inode.c
> > index ba1de23c13c1..4f3257f5ed7a 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1949,26 +1949,44 @@ void touch_atime(const struct path *path)
> >  }
> >  EXPORT_SYMBOL(touch_atime);
> >  
> > -/*
> > - * The logic we want is
> > +/**
> > + * should_remove_sgid - determine whether the setgid bit needs to be removed
> > + * @mnt_userns:	User namespace of the mount the inode was created from
> > + * @inode: inode to check
> > + *
> > + * This function determines whether the setgid bit needs to be removed.
> > + * We retain backwards compatibility where we require the setgid bit to be
> > + * removed unconditionally if S_IXGRP is set. Otherwise we have the exact same
> > + * requirements as setattr_prepare() and setattr_copy().
> >   *
> > - *	if suid or (sgid and xgrp)
> > - *		remove privs
> > + * Return: true if setgit bit needs to be removed, false otherwise.
> >   */
> > -int should_remove_suid(struct dentry *dentry)
> > +static bool should_remove_sgid(struct user_namespace *mnt_userns,
> > +			       struct inode *inode)
> > +{
> > +	umode_t mode = inode->i_mode;
> > +
> > +	if (unlikely(mode & S_ISGID)) {
> > +		if ((mode & S_IXGRP) ||
> > +		    (!vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)) &&
> > +		     !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID)))
> > +			return true;
> > +	}
> > +
> > +	return false;
> 
> I find this sort of convoluted logic much easier to follow when it's
> written as a stacked set of single comparisons like so:
> 
> 	if (!(mode & S_ISGID))
> 		return false;
> 	if (mode & S_IXGRP)
> 		return true;
> 	if (vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode))
> 		return false;
> 	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID)
> 		return false;
> 	return true;

Good idea, I'll fix that up in tree.

Thanks!
Christian
