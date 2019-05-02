Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0238C11FD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfEBQMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 12:12:35 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39770 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfEBQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 12:12:35 -0400
Received: by mail-yw1-f65.google.com with SMTP id x204so1988258ywg.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSLCsKx/3zHBGhSHg1njzoPTGGKwKjyCJXnswFWwhnc=;
        b=FyQGCFBog4b3tC9I+3BRqMJCM+8Cz53VdmjI70LcMPJ89q+0/6+zmPUpSQFsaLgOxS
         xThSekzuDBa2Sd8JZVdo1qPwoiY/12UCz+YKr8Y+i42eI/gn2EhSXN81yEQvpjgjXZse
         LDZ9RadlxmjKBJQq/bPWth3YOrWlMgoSvA0uN8CqQSb9jHJ7o6I7vL9YBAfvLaW3AqUm
         mSpKJvbPFrzWAeVLypk4GnbeHqdOzTmnrRSdLl0ZpNz9ODx1Q8rrNmqBOkvhVJfkQM84
         dtdcJPIYI6zwIXlg0Q2x8EO2gkS27/BlHmBHhXmVtVCwmVpWLeXfc8AtZMnY6be543dC
         7LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSLCsKx/3zHBGhSHg1njzoPTGGKwKjyCJXnswFWwhnc=;
        b=Ws8cK3p/tpXxsGUcvXG5JD44lPWdmrvWFlA3mFMOhaxp7mrjcB+WR91NM8lqyh+UH2
         eUDnrO+0Zcw4fN4SblqAqg/0DvpHYWW7eGwI0ykaiXDnwV64Rq6R94mlvpmLLp7HVmBd
         VJzvaddjINutOTjvdstcou6+VGqxjCbtMitgXMblbrgsTUJqkPf2Dlta4HnqCIBk/1jR
         h7SHvI0Wt4FvM1rhypMr2Q+sEHxUwPKwWW+jmtyYgkS80+PyBQlxdwyS+wF3c5MlG62p
         LFyhsQPnBiO98yyc9WYbVrWqaq90AapicaRhXVXuoSUdPcYeEKGbSnzSKEmhuGu7aLgg
         D9eA==
X-Gm-Message-State: APjAAAUXftrSmkEqQpmLDC9bth6XywwV4QTG8b28K0xayyA5U2vky3K8
        3ujJDchTKVwCdXd6eim0tQsuEAuZ1VZmVokSZQI=
X-Google-Smtp-Source: APXvYqw5oR8ENsy3QOlODuxWFiotXAEWzattl+k9ERu00Pf1Orjja92kzGJkI/J7yoPrmBfheXUXS0PRmYcc6d5ZWZ0=
X-Received: by 2002:a25:952:: with SMTP id u18mr4004084ybm.397.1556813554183;
 Thu, 02 May 2019 09:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjZm6E2TmCv8JOyQr7f-2VB0uFRy7XEp8HBHQmMdQg+6w@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 May 2019 12:12:22 -0400
Message-ID: <CAOQ4uxgEicLTA4LtV2fpvx7okEEa=FtbYE7Qa_=JeVEGXz40kw@mail.gmail.com>
Subject: Re: [TOPIC] Extending the filesystem crash recovery guaranties contract
To:     lsf-pc@lists.linux-foundation.org,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
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

On Sat, Apr 27, 2019 at 5:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Suggestion for another filesystems track topic.
>
> Some of you may remember the emotional(?) discussions that ensued
> when the crashmonkey developers embarked on a mission to document
> and verify filesystem crash recovery guaranties:
>
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxj8YpYPPdEvAvKPKXO7wdBg6T1O3osd6fSPFKH9j=i2Yg@mail.gmail.com/
>
> There are two camps among filesystem developers and every camp
> has good arguments for wanting to document existing behavior and for
> not wanting to document anything beyond "use fsync if you want any guaranty".
>
> I would like to take a suggestion proposed by Jan on a related discussion:
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxjQx+TO3Dt7TA3ocXnNxbr3+oVyJLYUSpv4QCt_Texdvw@mail.gmail.com/
>
> and make a proposal that may be able to meet the concerns of
> both camps.
>
> The proposal is to add new APIs which communicate
> crash consistency requirements of the application to the filesystem.
>
> Example API could look like this:
> renameat2(..., RENAME_METADATA_BARRIER | RENAME_DATA_BARRIER)
> It's just an example. The API could take another form and may need
> more barrier types (I proposed to use new file_sync_range() flags).
>
> The idea is simple though.
> METADATA_BARRIER means all the inode metadata will be observed
> after crash if rename is observed after crash.
> DATA_BARRIER same for file data.
> We may also want a "ALL_METADATA_BARRIER" and/or
> "METADATA_DEPENDENCY_BARRIER" to more accurately
> describe what SOMC guaranties actually provide today.
>
> The implementation is also simple. filesystem that currently
> have SOMC behavior don't need to do anything to respect
> METADATA_BARRIER and only need to call
> filemap_write_and_wait_range() to respect DATA_BARRIER.
> filesystem developers are thus not tying their hands w.r.t future
> performance optimizations for operations that are not explicitly
> requesting a barrier.
>

An update: Following the LSF session on $SUBJECT I had a discussion
with Ted, Jan and Chris.

We were all in agreement that linking an O_TMPFILE into the namespace
is probably already perceived by users as the barrier/atomic operation that
I am trying to describe.

So at least maintainers of btrfs/ext4/ext2 are sympathetic to the idea of
providing the required semantics when linking O_TMPFILE *as long* as
the semantics are properly documented.

This is what open(2) man page has to say right now:

 *  Creating a file that is initially invisible, which is then
populated with data
    and adjusted to have  appropriate  filesystem  attributes  (fchown(2),
    fchmod(2), fsetxattr(2), etc.)  before being atomically linked into the
    filesystem in a fully formed state (using linkat(2) as described above).

The phrase that I would like to add (probably in link(2) man page) is:
"The filesystem provided the guaranty that after a crash, if the linked
 O_TMPFILE is observed in the target directory, than all the data and
 metadata modifications made to the file before being linked are also
 observed."

For some filesystems, btrfs in farticular, that would mean an implicit
fsync on the linked inode. On other filesystems, ext4/xfs in particular
that would only require at least committing delayed allocations, but
will NOT require inode fsync nor journal commit/flushing disk caches.

I would like to hear the opinion of XFS developers and filesystem
maintainers who did not attend the LSF session.

I have no objection to adding an opt-in LINK_ATOMIC flag
and pass it down to filesystems instead of changing behavior and
patching stable kernels, but I prefer the latter.

I believe this should have been the semantics to begin with
if for no other reason, because users would expect it regardless
of whatever we write in manual page and no matter how many
!!!!!!!! we use for disclaimers.

And if we can all agree on that, then O_TMPFILE is quite young
in historic perspective, so not too late to call the expectation gap
a bug and fix it.(?)

Taking this another step forward, if we agree on the language
I used above to describe the expected behavior, then we can
add an opt-in RENAME_ATOMIC flag to provide the same
semantics and document it in the same manner (this functionality
is needed for directories and non regular files) and all there is left
is the fun part of choosing the flag name ;-)

Thanks,
Amir.
