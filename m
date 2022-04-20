Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCFE509261
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382695AbiDTVzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 17:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357179AbiDTVzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 17:55:45 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AEDB345513;
        Wed, 20 Apr 2022 14:52:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-115-138.pa.nsw.optusnet.com.au [49.181.115.138])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A37F310E5CE6;
        Thu, 21 Apr 2022 07:52:54 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nhIFo-002XWU-OW; Thu, 21 Apr 2022 07:52:52 +1000
Date:   Thu, 21 Apr 2022 07:52:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 1/8] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <20220420215252.GO1544202@dread.disaster.area>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220419140508.b6c4uit3u5hmdql4@wittgenstein>
 <625F6FE6.4010305@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <625F6FE6.4010305@fujitsu.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=626080b7
        a=/kVtbFzwtM2bJgxRVb+eeA==:117 a=/kVtbFzwtM2bJgxRVb+eeA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=omOdbC7AAAAA:8 a=VwQbUJbxAAAA:8
        a=7-415B0cAAAA:8 a=dB9dRndzBIRXieEivdAA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 20, 2022 at 01:27:39AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/19 22:05, Christian Brauner wrote:
> > On Tue, Apr 19, 2022 at 07:47:07PM +0800, Yang Xu wrote:
> >> This has no functional change. Just create and export inode_sgid_strip api for
> >> the subsequent patch. This function is used to strip S_ISGID mode when init
> >> a new inode.
> >>
> >> Acked-by: Christian Brauner (Microsoft)<brauner@kernel.org>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >>   fs/inode.c         | 22 ++++++++++++++++++----
> >>   include/linux/fs.h |  3 ++-
> >>   2 files changed, 20 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/inode.c b/fs/inode.c
> >> index 9d9b422504d1..3215e61a0021 100644
> >> --- a/fs/inode.c
> >> +++ b/fs/inode.c
> >> @@ -2246,10 +2246,8 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
> >>   		/* Directories are special, and always inherit S_ISGID */
> >>   		if (S_ISDIR(mode))
> >>   			mode |= S_ISGID;
> >> -		else if ((mode&  (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)&&
> >> -			 !in_group_p(i_gid_into_mnt(mnt_userns, dir))&&
> >> -			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> >> -			mode&= ~S_ISGID;
> >> +		else
> >> +			inode_sgid_strip(mnt_userns, dir,&mode);
> >>   	} else
> >>   		inode_fsgid_set(inode, mnt_userns);
> >>   	inode->i_mode = mode;
> >> @@ -2405,3 +2403,19 @@ struct timespec64 current_time(struct inode *inode)
> >>   	return timestamp_truncate(now, inode);
> >>   }
> >>   EXPORT_SYMBOL(current_time);
> >> +
> >> +void inode_sgid_strip(struct user_namespace *mnt_userns,
> >> +		      const struct inode *dir, umode_t *mode)
> >> +{
> >
> > I think with Willy agreeing in an earlier version with me and you
> > needing to resend anyway I'd say have this return umode_t instead of
> > passing a pointer.
> 
> IMO, I am fine with your and Willy way. But I need a reason otherwise
> I can't convince myself why not use mode pointer directly.

You should listen to experienced developers like Willy and Christian
when they say "follow existing coding conventions".  Indeed, Darrick
has also mentioned he'd prefer it to return the new mode, and I'd
also prefer that it returns the new mode.

> I have asked you and Willy before why return umode_t value is better, 
> why not modify mode pointer directly? Since we have use mode as 
> argument, why not modify mode pointer directly in function?

If the function had mulitple return status (e.g. an error or a mode)
the convention is to pass the mode output variable by reference and
return the error status. But there is only one return value from
this function - the mode - and hence it should be returned in the
return value, not passed by reference.

Passing by reference unnecessarily makes the code more complex and
less mainatainable.  Code that returns a single value is easy to
understand, is more flexible in the way callers can use it and it's
simpler to maintain.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
