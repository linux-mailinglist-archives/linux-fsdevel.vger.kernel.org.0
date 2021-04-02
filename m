Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCDF352482
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 02:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhDBAhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 20:37:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhDBAhR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08A1E601FC;
        Fri,  2 Apr 2021 00:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617323837;
        bh=q9eOqOQf0zhwWcnb9R2/ehtWuFGHW/rqCoxgT1BwKQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrSU56eSZv9U69n/HlJqIJo01RTiJ9R1cas0jsW8Z+8b4Pc5hhVFuN0F/orjs9n4d
         ziRcUUWUXlGIq0jc1Jm/3p+UW195Gzk8RLVfZsEa94PDzRT88fe1UKwSdczGc03kaD
         R67GEY2ojlG72A6jS0WKx9UcP3do8lCe+stFkztuRsFNyYFOt4KGJScPY0af9UOo4Q
         vRVTqMiJniFzT7VWxajQ8uvFddqzosuE+3SZmHlPe0TAKcYQtAjgr5O7v4k22FFaVV
         V7o/Iv40tNRmPrqzWSkwmuUJiB+SxD8nqY61e5OQvCQfoks7JyZkO0F01tASVkPNX/
         VlQitrh8/74Bg==
Date:   Thu, 1 Apr 2021 17:37:16 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 01/18] vfs: introduce new file range exchange ioctl
Message-ID: <20210402003716.GG4090233@magnolia>
References: <161723932606.3149451.12366114306150243052.stgit@magnolia>
 <161723933214.3149451.12102627412985512284.stgit@magnolia>
 <CAOQ4uxgJVUXxJmzSfHRFTFfqrV+oGt8QV-E+_wq46DmS0QGZ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgJVUXxJmzSfHRFTFfqrV+oGt8QV-E+_wq46DmS0QGZ_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 06:32:02AM +0300, Amir Goldstein wrote:
> On Thu, Apr 1, 2021 at 4:13 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Introduce a new ioctl to handle swapping ranges of bytes between files.
> >
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  Documentation/filesystems/vfs.rst |   16 ++
> >  fs/ioctl.c                        |   42 +++++
> >  fs/remap_range.c                  |  283 +++++++++++++++++++++++++++++++++++++
> >  fs/xfs/libxfs/xfs_fs.h            |    1
> >  include/linux/fs.h                |   14 ++
> >  include/uapi/linux/fiexchange.h   |  101 +++++++++++++
> >  6 files changed, 456 insertions(+), 1 deletion(-)
> >  create mode 100644 include/uapi/linux/fiexchange.h
> >
> >
> > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> > index 2049bbf5e388..9f16b260bc7e 100644
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -1006,6 +1006,8 @@ This describes how the VFS can manipulate an open file.  As of kernel
> >                 loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
> >                                            struct file *file_out, loff_t pos_out,
> >                                            loff_t len, unsigned int remap_flags);
> > +                int (*xchg_file_range)(struct file *file1, struct file *file2,
> > +                                       struct file_xchg_range *fxr);
> 
> An obvious question: why is the xchgn_file_range op not using the
> unified remap_file_range() method with REMAP_XCHG_ flags?
> Surely replacing the remap_flags arg with struct file_remap_range.
> 
> I went to look for reasons and I didn't find them.
> Can you share your reasons for that?

Code simplicity.  The file2 freshness parameters don't apply to clone or
dedupe, and the current set of remap flags don't apply to exchange.  I'd
have to hunt down all the ->remap_range implementations and modify them
to error out on REMAP_FILE_EXCHANGE.  Multiplexing flags in this manner
would also require additional remap_flags interpretation code to
safeguard against callers who mix up which flags go with what piece of
functionality.

IOWS: it's not hard to do, but not something I want to do for an RFC
because the goal here is to gauge interest in having a userspace
interface at all.  Until I get to that point, tangling up the code
diverts my time towards rebasing and dealing with merge conflicts, at
the cost of time I can spend concentrating on making the algorithms
right.

--D

> Thanks,
> Amir.
