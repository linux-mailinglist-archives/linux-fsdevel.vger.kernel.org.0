Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8FF437E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbfFMPB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 11:01:56 -0400
Received: from fieldses.org ([173.255.197.46]:52414 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732521AbfFMObv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 10:31:51 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 34E742012; Thu, 13 Jun 2019 10:31:51 -0400 (EDT)
Date:   Thu, 13 Jun 2019 10:31:51 -0400
From:   "J . Bruce Fields" <bfields@fieldses.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@poochiereds.net>,
        linux-fsdevel@vger.kernel.org,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Subject: Re: [PATCH v2] locks: eliminate false positive conflicts for write
 lease
Message-ID: <20190613143151.GC2145@fieldses.org>
References: <20190612172408.22671-1-amir73il@gmail.com>
 <20190612183156.GA27576@fieldses.org>
 <CAJfpegvj0NHQrPcHFd=b47M-uz2CY6Hnamk_dJvcrUtwW65xBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvj0NHQrPcHFd=b47M-uz2CY6Hnamk_dJvcrUtwW65xBw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:13:15PM +0200, Miklos Szeredi wrote:
> On Wed, Jun 12, 2019 at 8:31 PM J . Bruce Fields <bfields@fieldses.org> wrote:
> >
> > How do opens for execute work?  I guess they create a struct file with
> > FMODE_EXEC and FMODE_RDONLY set and they decrement i_writecount.  Do
> > they also increment i_readcount?  Reading do_open_execat and alloc_file,
> > looks like it does, so, good, they should conflict with write leases,
> > which sounds right.
> 
> Right, but then why this:
> 
> > > +     /* Eliminate deny writes from actual writers count */
> > > +     if (wcount < 0)
> > > +             wcount = 0;
> 
> It's basically a no-op, as you say.  And it doesn't make any sense
> logically, since denying writes *should* deny write leases as well...

Yes.  I feel like the negative writecount case is a little nonobvious,
so maybe replace that by a comment, something like this?:

--b.

diff --git a/fs/locks.c b/fs/locks.c
index 2056595751e8..379829b913c1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1772,11 +1772,12 @@ check_conflicting_open(struct file *filp, const long arg, int flags)
 	if (arg == F_RDLCK && wcount > 0)
 		return -EAGAIN;
 
-	/* Eliminate deny writes from actual writers count */
-	if (wcount < 0)
-		wcount = 0;
-
-	/* Make sure that only read/write count is from lease requestor */
+	/*
+	 * Make sure that only read/write count is from lease requestor.
+	 * Note that this will result in denying write leases when wcount
+	 * is negative, which is what we want.  (We shouldn't grant
+	 * write leases on files open for execution.)
+	 */
 	if (filp->f_mode & FMODE_WRITE)
 		self_wcount = 1;
 	else if (filp->f_mode & FMODE_READ)
