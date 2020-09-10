Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C80264BB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 19:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgIJRpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 13:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgIJRmb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:42:31 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6E22067C;
        Thu, 10 Sep 2020 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759750;
        bh=mKaGdeBMiz5ZqOc/kvJB3cAWhRV08AagdLUfAwMQwvE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AW8i7t3U2dVnW4Df2r86rtLf/Qkxa7XQ6kawV4X5oliq183NfO2vEwxuvvHJpT0c1
         a9cKCGRdxgwShK8L8BGhMPGvgx6uFgwDz/CIr/KXk07DKXBidYWP+6GZtAWa3ERS4d
         WXev5UprB9IrJp/ij3W4FONb/ByhGV9MJpLOVQV8=
Message-ID: <8842543f4c929f7004cf356224230516a7fe2fb7.camel@kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Jan Kara <jack@suse.cz>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     milan.opensource@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Date:   Thu, 10 Sep 2020 13:42:28 -0400
In-Reply-To: <87k0x2k0wn.fsf@notabene.neil.brown.name>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
         <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
         <20200908112742.GA2956@quack2.suse.cz>
         <e4f5ccb298170357ba16ae2870fde6a90ca2aa81.camel@kernel.org>
         <87k0x2k0wn.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-09-10 at 09:04 +1000, NeilBrown wrote:
> On Tue, Sep 08 2020, Jeff Layton wrote:
> 
> > On Tue, 2020-09-08 at 13:27 +0200, Jan Kara wrote:
> > > Added Jeff to CC since he has written the code...
> > > 
> > > On Mon 07-09-20 09:11:06, Michael Kerrisk (man-pages) wrote:
> > > > [Widening the CC to include Andrew and linux-fsdevel@]
> > > > [Milan: thanks for the patch, but it's unclear to me from your commit
> > > > message how/if you verified the details.]
> > > > 
> > > > Andrew, maybe you (or someone else) can comment, since long ago your
> > > > 
> > > >     commit f79e2abb9bd452d97295f34376dedbec9686b986
> > > >     Author: Andrew Morton <akpm@osdl.org>
> > > >     Date:   Fri Mar 31 02:30:42 2006 -0800
> > > > 
> > > > included a comment that is referred to in  stackoverflow discussion
> > > > about this topic (that SO discussion is in turn referred to by
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=194757).
> > > > 
> > > > The essence as I understand it, is this:
> > > > (1) fsync() (and similar) may fail EIO or ENOSPC, at which point data
> > > > has not been synced.
> > > > (2) In this case, the EIO/ENOSPC setting is cleared so that...
> > > > (3) A subsequent fsync() might return success, but...
> > > > (4) That doesn't mean that the data in (1) landed on the disk.
> > > 
> > > Correct.
> > > 
> > > > The proposed manual page patch below wants to document this, but I'd
> > > > be happy to have an FS-knowledgeable person comment before I apply.
> > > 
> > > Just a small comment below:
> > > 
> > > > On Sat, 29 Aug 2020 at 09:13, <milan.opensource@gmail.com> wrote:
> > > > > From: Milan Shah <milan.opensource@gmail.com>
> > > > > 
> > > > > This Fix addresses Bug 194757.
> > > > > Ref: https://bugzilla.kernel.org/show_bug.cgi?id=194757
> > > > > ---
> > > > >  man2/fsync.2 | 13 +++++++++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > > 
> > > > > diff --git a/man2/fsync.2 b/man2/fsync.2
> > > > > index 96401cd..f38b3e4 100644
> > > > > --- a/man2/fsync.2
> > > > > +++ b/man2/fsync.2
> > > > > @@ -186,6 +186,19 @@ In these cases disk caches need to be disabled using
> > > > >  or
> > > > >  .BR sdparm (8)
> > > > >  to guarantee safe operation.
> > > > > +
> > > > > +When
> > > > > +.BR fsync ()
> > > > > +or
> > > > > +.BR fdatasync ()
> > > > > +returns
> > > > > +.B EIO
> > > > > +or
> > > > > +.B ENOSPC
> > > > > +any error flags on pages in the file mapping are cleared, so subsequent synchronisation attempts
> > > > > +will return without error. It is
> > > > > +.I not
> > > > > +safe to retry synchronisation and assume that a non-error return means prior writes are now on disk.
> > > > >  .SH SEE ALSO
> > > > >  .BR sync (1),
> > > > >  .BR bdflush (2),
> > > 
> > > So the error state isn't really stored "on pages in the file mapping".
> > > Current implementation (since 4.14) is that error state is stored in struct
> > > file (I think this tends to be called "file description" in manpages) and
> > > so EIO / ENOSPC is reported once for each file description of the file that
> > > was open before the error happened. Not sure if we want to be so precise in
> > > the manpages or if it just confuses people. Anyway your takeway that no
> > > error on subsequent fsync() does not mean data was written is correct.
> > > 
> > > 
> > 
> > Thinking about it more, I think we ought to spell this out explicitly as
> > we can in the manpage. This is a point of confusion for a lot of people
> > and not understanding this can lead to data integrity bugs. Maybe
> > something like this in the NOTES section?
> > 
> > '''
> > When fsync returns an error, the file is considered to be "clean". A
> > subsequent call to fsync will not result in a reattempt to write out the
> > data, unless that data has been rewritten. Applications that want to
> > reattempt writing to the file after a transient error must re-write
> > their data.
> > '''
> > 
> > To be clear:
> > 
> > In practice, you'd only have to write enough to redirty each page in
> > most cases.
> 
> Nonononono.  In practice you have to repeat the entire write because you
> cannot know if the cached page is from before the write failure, or has
> since been flushed and reloaded.
> 

Oh, good point! There's no way for userland to know that, so you really
do have to rewrite the whole thing.

> > Also, it is hard to claim that the above behavior is universally true. A
> > filesystem could opt to keep the pages dirty for some errors, but the
> > vast majority just toss out the data whenever there is a writeback
> > problem.
> 
> ...and any filesystem that doesn't behave that way is wasting effort,
> because nothing else can be assumed.
> 

Yeah. I only made the point to be pedantic. There's no benefit to
documenting that, I think...

> Regarding your "NOTES" addition, I don't feel comfortable with the
> "clean" language.  I would prefer something like:
> 
>  When fsync() reports a failure (EIO, ENOSPC, EDQUOT) it must be assumed
>  that any write requests initiated since the previous successful fsync
>  was initiated may have failed, and that any cached data may have been
>  lost.  A future fsync() will not attempt to write out the same data
>  again.  If recovery is possible and desired, the application must
>  repeat all the writes that may have failed.
> 
>  If the regions of a file that were written to prior to a failed fsync()
>  are read, the content reported may not reflect the stored content, and
>  subsequent reads may revert to the stored content at any time.
> 

Much nicer.

Should we make a distinction between usage and functional classes of
errors in this? The "usage" errors will probably not result in the pages
being tossed out, but the functional ones almost certainly will...

-- 
Jeff Layton <jlayton@kernel.org>

