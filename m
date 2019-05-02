Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA53812486
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 00:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEBWTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 18:19:43 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37718 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBWTn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 18:19:43 -0400
Received: by mail-yw1-f66.google.com with SMTP id a62so2843891ywa.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 15:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zUgR45+Y9Iiu+aNCS+/Um6xfkxcmabw+J8Fa9pNlQZ8=;
        b=JuKrLkBhoMICX+GTEZK5meyqoANwPQaxhUj/a3D123J15AXd6OqMskeo/9e7te/VaR
         IUD4GouC14+xIUa6mbYhhYcgxmxduRMewY7X773xqYSKJ4+rZplIXx4C6HoTc7+WQjHB
         Qu5qNR9MXV7eZ5pmfoC8F8X/a2KBeXIQp1zgZIqCCc1uNChlp9bVrAUyKZC1a79bpctt
         9/u7Z+BE7KLsrA8RO/5zVRgL7M90ibFAlXEita0y9Z9ExuyRTWwtdOoilQXjmrkahYKe
         0LqtsBhi8Htqu2A601AsyAGVsCHM1+JKQwJV22B2+k8QQUFcbI/kHZfyA1JxUtGCaNT/
         4wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zUgR45+Y9Iiu+aNCS+/Um6xfkxcmabw+J8Fa9pNlQZ8=;
        b=DkivM2tHuJXOr5kCK5b6gYk0hPizc95eu6aXjWMooWIr8B4aptV/1Nhn8FlsSs5oR0
         MkpZj10fCEaW3C4FYlyduDV22kszAi+BQXZj5hniUOhUqOZOepv7AFbzaDAc2236zN1x
         q4tr15mnSwhV1LPJ9GsInyrPDJe1Bp9OGlTQxz17Gy06SDHESgfulAKtDiwA7B6G9BMC
         y5zax3N+z5KSSNg4DzgtvAV3QFHXdiKrRecoGNCDsl0s9aiT9EmpCK1wiVfg0wZZvvVU
         4DJOlPoJV/dI4axwO59iIhqGu6qkd6vkpY9isYi4NpWzXGUvrdXgl1Q6zrnwsC8MbDMg
         0C3A==
X-Gm-Message-State: APjAAAUco2NJFSk2HLUzznww5Hmd3S/qMmNVKf1MC0Qo4LyZZlh18zmk
        4dyYpbq1TtH51jHLopA6WEoXnt0ocmQ5DhpnQIE=
X-Google-Smtp-Source: APXvYqx/2fVFJeVeVMLcwBiWDCNjPCA8Abul3xwSof770TJHdOZ8uLeuNTRjiaMlSWYH0vX1HL34iFMgbaSWMgxq2s0=
X-Received: by 2002:a25:d64a:: with SMTP id n71mr5553461ybg.462.1556835582155;
 Thu, 02 May 2019 15:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
 <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com> <20190502210524.GI5200@magnolia>
In-Reply-To: <20190502210524.GI5200@magnolia>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 May 2019 18:19:30 -0400
Message-ID: <CAOQ4uxjYhR9pt0a0O6K3f=ZnsqAXP=KBf5nkEt2adTuPLdWx3w@mail.gmail.com>
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties contract
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jayashree Mohan <jaya@cs.utexas.edu>,
        Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>,
        Filipe Manana <fdmanana@suse.com>, Chris Mason <clm@fb.com>,
        lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 5:05 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, May 02, 2019 at 12:12:22PM -0400, Amir Goldstein wrote:
> > On Sat, Apr 27, 2019 at 5:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Suggestion for another filesystems track topic.
> > >
> > > Some of you may remember the emotional(?) discussions that ensued
> > > when the crashmonkey developers embarked on a mission to document
> > > and verify filesystem crash recovery guaranties:
> > >
> > > https://lore.kernel.org/linux-fsdevel/CAOQ4uxj8YpYPPdEvAvKPKXO7wdBg6T1O3osd6fSPFKH9j=i2Yg@mail.gmail.com/
> > >
> > > There are two camps among filesystem developers and every camp
> > > has good arguments for wanting to document existing behavior and for
> > > not wanting to document anything beyond "use fsync if you want any guaranty".
> > >
> > > I would like to take a suggestion proposed by Jan on a related discussion:
> > > https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQx+TO3Dt7TA3ocXnNxbr3+oVyJLYUSpv4QCt_Texdvw@mail.gmail.com/
> > >
> > > and make a proposal that may be able to meet the concerns of
> > > both camps.
> > >
> > > The proposal is to add new APIs which communicate
> > > crash consistency requirements of the application to the filesystem.
> > >
> > > Example API could look like this:
> > > renameat2(..., RENAME_METADATA_BARRIER | RENAME_DATA_BARRIER)
> > > It's just an example. The API could take another form and may need
> > > more barrier types (I proposed to use new file_sync_range() flags).
> > >
> > > The idea is simple though.
> > > METADATA_BARRIER means all the inode metadata will be observed
> > > after crash if rename is observed after crash.
> > > DATA_BARRIER same for file data.
> > > We may also want a "ALL_METADATA_BARRIER" and/or
> > > "METADATA_DEPENDENCY_BARRIER" to more accurately
> > > describe what SOMC guaranties actually provide today.
> > >
> > > The implementation is also simple. filesystem that currently
> > > have SOMC behavior don't need to do anything to respect
> > > METADATA_BARRIER and only need to call
> > > filemap_write_and_wait_range() to respect DATA_BARRIER.
> > > filesystem developers are thus not tying their hands w.r.t future
> > > performance optimizations for operations that are not explicitly
> > > requesting a barrier.
> > >
> >
> > An update: Following the LSF session on $SUBJECT I had a discussion
> > with Ted, Jan and Chris.
> >
> > We were all in agreement that linking an O_TMPFILE into the namespace
> > is probably already perceived by users as the barrier/atomic operation that
> > I am trying to describe.
> >
> > So at least maintainers of btrfs/ext4/ext2 are sympathetic to the idea of
> > providing the required semantics when linking O_TMPFILE *as long* as
> > the semantics are properly documented.
> >
> > This is what open(2) man page has to say right now:
> >
> >  *  Creating a file that is initially invisible, which is then
> > populated with data
> >     and adjusted to have  appropriate  filesystem  attributes  (fchown(2),
> >     fchmod(2), fsetxattr(2), etc.)  before being atomically linked into the
> >     filesystem in a fully formed state (using linkat(2) as described above).
> >
> > The phrase that I would like to add (probably in link(2) man page) is:
> > "The filesystem provided the guaranty that after a crash, if the linked
> >  O_TMPFILE is observed in the target directory, than all the data and
>
> "if the linked O_TMPFILE is observed" ... meaning that if we can't
> recover all the data+metadata information then it's ok to obliterate the
> file?  Is the filesystem allowed to drop the tmpfile data if userspace
> links the tmpfile into a directory but doesn't fsync the directory?
>

Yes! Yes! Definitely allowed!

Linking an O_TMPFILE has a single possible use case -
an "atomic" creation of a fully baked file.

I am trying hard to explain that for my use case, durability
is not a requirement from the "atomic" creation, but rather
"if the linked O_TMPFILE is observed" semantics.

> TBH I would've thought the basis of the RENAME_ATOMIC (and LINK_ATOMIC?)
> user requirement would be "Until I say otherwise I want always to be
> able to read <data> from this given string <pathname>."
>

Sadly, it is even hard for me to explain the difference to filesystem
developers,
so what is the hope with mortal users, but what can I do, the kernel has
and interface for durability (several of them), but no interface for what I need
(ordering), so I must introduce one.

The good news, and that the key argument in my sales pitch, is that some
users already have expectations that are not documented and not correct
about rename/link, so hopefully, if we add and document those flags,
situation cannot get worse.

> (vs. regular Unix rename/link where we make you specify how much you
> care about that by hitting us on the head with a file fsync and then a
> directory fsync.)

OK. Perhaps a solution to this human interface issue is introducing
two pairs of flags LINK_SYNC and LINK_ATOMIC.
I did not think that the former is needed, but maybe it is just needed
as a way to document what LINK_ATOMIC is *not*, e.g.:

"LINK_SYNC
 If the operation succeeds, the filesystem provides the guaranty that
 after a crash, the linked O_TMPFILE will be observed in the target
 directory and that all the data and metadata modifications made to
 the file before being linked are also observed."

LINK_ATOMIC
 If the operation succeeds, the filesystem provides the guaranty that
 after a crash, if the linked O_TMPFILE is observed in the target
 directory, then all the data and metadata modifications made to the
 file before being linked are also observed.
 LINK_ATOMIC is often cheaper than LINK_SYNC, because it does
 not require flushing volatile disk write caches, but it does not provide
 the guaranty that the file will be observed in the target directory after
 crash."

My intuition about this is "less is better", so prefer not add two flags.

>
> >  metadata modifications made to the file before being linked are also
> >  observed."
> >
> > For some filesystems, btrfs in farticular, that would mean an implicit
> > fsync on the linked inode. On other filesystems, ext4/xfs in particular
> > that would only require at least committing delayed allocations, but
> > will NOT require inode fsync nor journal commit/flushing disk caches.
>
> I don't think it does much good to commit delalloc blocks but not flush
> dirty overwrites, and I don't think it makes a lot of sense to flush out
> overwrite data without also pushing out the inode metadata too.

My intention was that this flag will call filemap_write_and_wait_range()
on ext4/xfs, which is what my application does today to get the desired
result. From there on, we can rely on "strictly ordered metadata consistency"
(SOMC) to provide what the interface needs.

>
> FWIW I'm ok with the "Here's a 'I'm really serious' flag that carries
> with it a full fsync, though how to sell developers on using it?
>

I am an application developer and I have no need of such flag
I have a need for another flag, which is why I started this discussion...
But also, this is why my preference is to NOT add a LINK_ATOMIC
flag at all and just assume that users cannot possibly think it is a good
outcome to observe a half baked linked O_TMPFILE after crash
and give users what they want.


> > I would like to hear the opinion of XFS developers and filesystem
> > maintainers who did not attend the LSF session.
>
> I miss you all too.  Sorry I couldn't make it this year. :(
>
> > I have no objection to adding an opt-in LINK_ATOMIC flag
> > and pass it down to filesystems instead of changing behavior and
> > patching stable kernels, but I prefer the latter.
> >
> > I believe this should have been the semantics to begin with
> > if for no other reason, because users would expect it regardless
> > of whatever we write in manual page and no matter how many
> > !!!!!!!! we use for disclaimers.
> >
> > And if we can all agree on that, then O_TMPFILE is quite young
> > in historic perspective, so not too late to call the expectation gap
> > a bug and fix it.(?)
>
> Why would linking an O_TMPFILE be a special case as opposed to making
> hard links in general?  If you hardlink a dirty file then surely you'd
> also want to be able to read the data from the new location?
>

Because of the use case that O_TMPFILE implies, whatever users
do before file is linked is expected to be private and unexposed to
others. You cannot say the same about making modifications to a linked
file. I don't mind adding LINK_ATOMIC and then it will obviously be respected
also for linking nlink > 0.


> > Taking this another step forward, if we agree on the language
> > I used above to describe the expected behavior, then we can
> > add an opt-in RENAME_ATOMIC flag to provide the same
> > semantics and document it in the same manner (this functionality
> > is needed for directories and non regular files) and all there is left
> > is the fun part of choosing the flag name ;-)
>
> Will have to think about /that/ some more.
>

For your amusement, here are some suggestions that I had
that folks here did not like:
RENAME_BARRIER
RENAME_ORDERED

Thanks,
Amir.
