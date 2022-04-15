Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A920F50202A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 03:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348492AbiDOBnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 21:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347526AbiDOBnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:43:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7316BAAC98;
        Thu, 14 Apr 2022 18:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05D25621EB;
        Fri, 15 Apr 2022 01:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB09C385A5;
        Fri, 15 Apr 2022 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649986836;
        bh=8pwyMPDhcPpKw9NOfMifzIJtH3N0yh7dJbmJbueDwTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cknh+559PwDLi2srJSH1eAtUacipDpYtBQhV3ITV1dpWa1LC8taXWjFLk3YK/uAVQ
         yyM53otqKSZk59Ih4NB3AYDLfZR0B2ETq2YxjW+AWxTuL0ju/caYS9UYZsJmm5/ThG
         GRdnMpX+KVZj3bRqmsOJcV+rG4uXDM2uIaVsDuFO+Ha/kE9OokByaORK0A4Uf4+tUG
         Wk6f+yYpKZG1kx6pYQEhQxqcZ9TIJMql2Nnd8gThXhz04vYPh6ibfn9QNatrLNfTyG
         2XeSwd1XjqioJZRkeTKerjzinBZQeDODMkYo99HuR7DZCezVOerDhsosCBFW/HlbzM
         9T1NC/K0lK+xQ==
Date:   Thu, 14 Apr 2022 18:40:35 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v2 1/3] vfs: Add inode_sgid_strip() api
Message-ID: <20220415014035.GA16996@magnolia>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220414155707.GA17059@magnolia>
 <6258D64F.8030903@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6258D64F.8030903@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 01:18:57AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/14 23:57, Darrick J. Wong wrote:
> > On Thu, Apr 14, 2022 at 03:57:17PM +0800, Yang Xu wrote:
> >> inode_sgid_strip() function is used to strip S_ISGID mode
> >> when creat/open/mknod file.
> >>
> >> Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >>   fs/inode.c         | 18 ++++++++++++++++++
> >>   include/linux/fs.h |  3 ++-
> >>   2 files changed, 20 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/inode.c b/fs/inode.c
> >> index 9d9b422504d1..d63264998855 100644
> >> --- a/fs/inode.c
> >> +++ b/fs/inode.c
> >> @@ -2405,3 +2405,21 @@ struct timespec64 current_time(struct inode *inode)
> >>   	return timestamp_truncate(now, inode);
> >>   }
> >>   EXPORT_SYMBOL(current_time);
> >> +
> >> +void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
> >> +		      umode_t *mode)
> >> +{
> >> +	if (!dir || !(dir->i_mode&  S_ISGID))
> >> +		return;
> >> +	if ((*mode&  (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
> >> +		return;
> >> +	if (S_ISDIR(*mode))
> >> +		return;
> >> +	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
> >> +		return;
> >> +	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> >> +		return;
> >> +
> >> +	*mode&= ~S_ISGID;
> >> +}
> >
> > Thanks for cleaning up the multiple if statements from last time.
> >
> > I still would like to see patch 1 replace the code in inode_init_owner
> > so that we can compare before and after in the same patch.  Patch 2 can
> > then be solely about moving the callsite around the VFS.
> >
> Ok, then patch 1 can named as"fs/inode: move inode sgid strip operation 
> from inode_init_owner into inode_sgid_strip".  What do you think about it?

Sounds good to me.

--D

> 
> Best Regards
> Yang Xu
> > --D
> >
> >> +EXPORT_SYMBOL(inode_sgid_strip);
> >> diff --git a/include/linux/fs.h b/include/linux/fs.h
> >> index bbde95387a23..94d94219fe7c 100644
> >> --- a/include/linux/fs.h
> >> +++ b/include/linux/fs.h
> >> @@ -1897,7 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
> >>   void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
> >>   		      const struct inode *dir, umode_t mode);
> >>   extern bool may_open_dev(const struct path *path);
> >> -
> >> +void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
> >> +		      umode_t *mode);
> >>   /*
> >>    * This is the "filldir" function type, used by readdir() to let
> >>    * the kernel specify what kind of dirent layout it wants to have.
> >> --
> >> 2.27.0
> >>
