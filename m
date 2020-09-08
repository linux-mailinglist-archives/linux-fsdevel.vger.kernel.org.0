Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC4C2610DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 13:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIHLic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 07:38:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:53366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbgIHL1p (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:27:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ED701AD7A;
        Tue,  8 Sep 2020 11:27:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8CDF1E1325; Tue,  8 Sep 2020 13:27:42 +0200 (CEST)
Date:   Tue, 8 Sep 2020 13:27:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     milan.opensource@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
Message-ID: <20200908112742.GA2956@quack2.suse.cz>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added Jeff to CC since he has written the code...

On Mon 07-09-20 09:11:06, Michael Kerrisk (man-pages) wrote:
> [Widening the CC to include Andrew and linux-fsdevel@]
> [Milan: thanks for the patch, but it's unclear to me from your commit
> message how/if you verified the details.]
> 
> Andrew, maybe you (or someone else) can comment, since long ago your
> 
>     commit f79e2abb9bd452d97295f34376dedbec9686b986
>     Author: Andrew Morton <akpm@osdl.org>
>     Date:   Fri Mar 31 02:30:42 2006 -0800
> 
> included a comment that is referred to in  stackoverflow discussion
> about this topic (that SO discussion is in turn referred to by
> https://bugzilla.kernel.org/show_bug.cgi?id=194757).
> 
> The essence as I understand it, is this:
> (1) fsync() (and similar) may fail EIO or ENOSPC, at which point data
> has not been synced.
> (2) In this case, the EIO/ENOSPC setting is cleared so that...
> (3) A subsequent fsync() might return success, but...
> (4) That doesn't mean that the data in (1) landed on the disk.

Correct.

> The proposed manual page patch below wants to document this, but I'd
> be happy to have an FS-knowledgeable person comment before I apply.

Just a small comment below:

> On Sat, 29 Aug 2020 at 09:13, <milan.opensource@gmail.com> wrote:
> >
> > From: Milan Shah <milan.opensource@gmail.com>
> >
> > This Fix addresses Bug 194757.
> > Ref: https://bugzilla.kernel.org/show_bug.cgi?id=194757
> > ---
> >  man2/fsync.2 | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/man2/fsync.2 b/man2/fsync.2
> > index 96401cd..f38b3e4 100644
> > --- a/man2/fsync.2
> > +++ b/man2/fsync.2
> > @@ -186,6 +186,19 @@ In these cases disk caches need to be disabled using
> >  or
> >  .BR sdparm (8)
> >  to guarantee safe operation.
> > +
> > +When
> > +.BR fsync ()
> > +or
> > +.BR fdatasync ()
> > +returns
> > +.B EIO
> > +or
> > +.B ENOSPC
> > +any error flags on pages in the file mapping are cleared, so subsequent synchronisation attempts
> > +will return without error. It is
> > +.I not
> > +safe to retry synchronisation and assume that a non-error return means prior writes are now on disk.
> >  .SH SEE ALSO
> >  .BR sync (1),
> >  .BR bdflush (2),

So the error state isn't really stored "on pages in the file mapping".
Current implementation (since 4.14) is that error state is stored in struct
file (I think this tends to be called "file description" in manpages) and
so EIO / ENOSPC is reported once for each file description of the file that
was open before the error happened. Not sure if we want to be so precise in
the manpages or if it just confuses people. Anyway your takeway that no
error on subsequent fsync() does not mean data was written is correct.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
