Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0851F5DA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 23:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgFJVTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 17:19:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgFJVTY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:19:24 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985B72072E;
        Wed, 10 Jun 2020 21:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591823964;
        bh=kKyDiU0/UB9Ct/ho+PM0wjzZ9KjHfNMjLQ0wPGw7GWg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K3A/3KYtsM442gkErVWP+R/oKC3+bEGFkDcxGE0Taod/Ze0sSh/kk9wGw8LPFdt83
         VtTluqRNcgOYIqzQbIt4tzRs/dmQB2UC+QX5IifWsfiLdO2gXomYBut4GwPiy1+8Ht
         BiwO5pGz0OPtA3UEDICp3f7Igysr3pE/+c6hZazE=
Message-ID: <fe141babe698296f96fde39a8da85005506fd0f0.camel@kernel.org>
Subject: Re: [PATCH][man-pages] sync.2: syncfs() now returns errors if
 writeback fails
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Jun 2020 17:19:22 -0400
In-Reply-To: <20200610155013.GA1339@sol.localdomain>
References: <20200610103347.14395-1-jlayton@kernel.org>
         <20200610155013.GA1339@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-06-10 at 08:50 -0700, Eric Biggers wrote:
> On Wed, Jun 10, 2020 at 06:33:47AM -0400, Jeff Layton wrote:
> > A patch has been merged for v5.8 that changes how syncfs() reports
> > errors. Change the sync() manpage accordingly.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  man2/sync.2 | 24 +++++++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/man2/sync.2 b/man2/sync.2
> > index 7198f3311b05..27e04cff5845 100644
> > --- a/man2/sync.2
> > +++ b/man2/sync.2
> > @@ -86,11 +86,26 @@ to indicate the error.
> >  is always successful.
> >  .PP
> >  .BR syncfs ()
> > -can fail for at least the following reason:
> > +can fail for at least the following reasons:
> >  .TP
> >  .B EBADF
> >  .I fd
> >  is not a valid file descriptor.
> > +.TP
> > +.B EIO
> > +An error occurred during synchronization.
> > +This error may relate to data written to any file on the filesystem, or on
> > +metadata related to the filesytem itself.
> > +.TP
> > +.B ENOSPC
> > +Disk space was exhausted while synchronizing.
> > +.TP
> > +.BR ENOSPC ", " EDQUOT
> > +Data was written to a files on NFS or another filesystem which does not
> > +allocate space at the time of a
> > +.BR write (2)
> > +system call, and some previous write failed due to insufficient
> > +storage space.
> >  .SH VERSIONS
> >  .BR syncfs ()
> >  first appeared in Linux 2.6.39;
> > @@ -121,6 +136,13 @@ or
> >  .BR syncfs ()
> >  provide the same guarantees as fsync called on every file in
> >  the system or filesystem respectively.
> > +.PP
> > +In mainline kernel versions prior to 5.8,
> > +.\" commit 735e4ae5ba28c886d249ad04d3c8cc097dad6336
> > +.BR syncfs ()
> > +will only fail with EBADF when passed a bad file descriptor. In 5.8
> > +and later kernels, it will also report an error if one or more inodes failed
> > +to be written back since the last syncfs call.
> 
> The sentence "In mainline kernel versions prior to 5.8, syncfs() will only fail
> with EBADF when passed a bad file descriptor" is ambiguous.  It could mean that
> EBADF can now mean other things too.
> 
> Maybe write: "In mainline kernel versions prior to 5.8, syncfs() will only fail
> when passed a bad file descriptor (EBADF)."
> 
> - Eric

Good point. Fixed in my tree using your verbiage. I'll send out a v2
patch once I give others a chance to comment.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>

