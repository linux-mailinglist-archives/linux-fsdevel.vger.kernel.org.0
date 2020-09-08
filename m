Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F7A261469
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgIHQUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 12:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731843AbgIHQUH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:07 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28EC205CB;
        Tue,  8 Sep 2020 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599581448;
        bh=v2zsVbidV/dpXBuxnNOOWyBxJCinNIceKjsE+Knsapc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qcRMUHSfIbb1We5HAkPbiDyxoStGFeeDjZQINQRCiB02sz2KJR+wSF9e8rh2hFWX/
         pRdR7L5L4Ji67IrqudFk9FYmW37g7LVLBI5MLHW7kGBwH6bYgz6ktZzXzMdso0klAC
         fZP1Nr1+cyUG5NNMwSPOjPXC4hfYj4cgJjooh2u8=
Message-ID: <f4d38a20cb0f25b137fe07a7f43358ab3a459038.camel@kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
From:   Jeff Layton <jlayton@kernel.org>
To:     Jan Kara <jack@suse.cz>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     milan.opensource@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date:   Tue, 08 Sep 2020 12:10:46 -0400
In-Reply-To: <20200908112742.GA2956@quack2.suse.cz>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
         <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
         <20200908112742.GA2956@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-09-08 at 13:27 +0200, Jan Kara wrote:
> Added Jeff to CC since he has written the code...
> 
> On Mon 07-09-20 09:11:06, Michael Kerrisk (man-pages) wrote:
> > [Widening the CC to include Andrew and linux-fsdevel@]
> > [Milan: thanks for the patch, but it's unclear to me from your commit
> > message how/if you verified the details.]
> > 
> > Andrew, maybe you (or someone else) can comment, since long ago your
> > 
> >     commit f79e2abb9bd452d97295f34376dedbec9686b986
> >     Author: Andrew Morton <akpm@osdl.org>
> >     Date:   Fri Mar 31 02:30:42 2006 -0800
> > 
> > included a comment that is referred to in  stackoverflow discussion
> > about this topic (that SO discussion is in turn referred to by
> > https://bugzilla.kernel.org/show_bug.cgi?id=194757).
> > 
> > The essence as I understand it, is this:
> > (1) fsync() (and similar) may fail EIO or ENOSPC, at which point data
> > has not been synced.
> > (2) In this case, the EIO/ENOSPC setting is cleared so that...
> > (3) A subsequent fsync() might return success, but...
> > (4) That doesn't mean that the data in (1) landed on the disk.
> 
> Correct.
> 
> > The proposed manual page patch below wants to document this, but I'd
> > be happy to have an FS-knowledgeable person comment before I apply.
> 
> Just a small comment below:
> 
> > On Sat, 29 Aug 2020 at 09:13, <milan.opensource@gmail.com> wrote:
> > > From: Milan Shah <milan.opensource@gmail.com>
> > > 
> > > This Fix addresses Bug 194757.
> > > Ref: https://bugzilla.kernel.org/show_bug.cgi?id=194757
> > > ---
> > >  man2/fsync.2 | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/man2/fsync.2 b/man2/fsync.2
> > > index 96401cd..f38b3e4 100644
> > > --- a/man2/fsync.2
> > > +++ b/man2/fsync.2
> > > @@ -186,6 +186,19 @@ In these cases disk caches need to be disabled using
> > >  or
> > >  .BR sdparm (8)
> > >  to guarantee safe operation.
> > > +
> > > +When
> > > +.BR fsync ()
> > > +or
> > > +.BR fdatasync ()
> > > +returns
> > > +.B EIO
> > > +or
> > > +.B ENOSPC
> > > +any error flags on pages in the file mapping are cleared, so subsequent synchronisation attempts
> > > +will return without error. It is
> > > +.I not
> > > +safe to retry synchronisation and assume that a non-error return means prior writes are now on disk.
> > >  .SH SEE ALSO
> > >  .BR sync (1),
> > >  .BR bdflush (2),
> 
> So the error state isn't really stored "on pages in the file mapping".
> Current implementation (since 4.14) is that error state is stored in struct
> file (I think this tends to be called "file description" in manpages) and
> so EIO / ENOSPC is reported once for each file description of the file that
> was open before the error happened. Not sure if we want to be so precise in
> the manpages or if it just confuses people. Anyway your takeway that no
> error on subsequent fsync() does not mean data was written is correct.
> 
> 								Honza
> 

Yep.

My only comment is that there is nothing special about EIO and ENOSPC.
All errors are the same in this regard. Basically, issuing a new fsync
after a failed one doesn't do any good. You need to redirty the pages
first.
-- 
Jeff Layton <jlayton@kernel.org>

