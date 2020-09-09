Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D7263105
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgIIPyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 11:54:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:58714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgIIPxq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:53:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71E76B291;
        Wed,  9 Sep 2020 14:15:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 530AC1E12E5; Wed,  9 Sep 2020 16:14:53 +0200 (CEST)
Date:   Wed, 9 Sep 2020 16:14:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, milan.opensource@gmail.com,
        lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>, NeilBrown <neilb@suse.com>
Subject: Re: [PATCH] fsync.2: ERRORS: add EIO and ENOSPC
Message-ID: <20200909141453.GC29150@quack2.suse.cz>
References: <1598685186-27499-1-git-send-email-milan.opensource@gmail.com>
 <CAKgNAkiTjtdaQxbCYS67+SdqSPaGzJnfLEEMFgcoXjHLDxgemw@mail.gmail.com>
 <20200908112742.GA2956@quack2.suse.cz>
 <7be61144-0e77-3c31-d720-f2cbe56bc81e@gmail.com>
 <20200909112110.GA29150@quack2.suse.cz>
 <0f473a75-fd5a-82f7-1d0e-e9c168414498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f473a75-fd5a-82f7-1d0e-e9c168414498@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 09-09-20 13:58:50, Michael Kerrisk (man-pages) wrote:
> [CC += Neil, since he wrote the text we're talking about]
> 
> Hello Jan,
> 
> On 9/9/20 1:21 PM, Jan Kara wrote:
> > On Wed 09-09-20 12:52:48, Michael Kerrisk (man-pages) wrote:
> >>> So the error state isn't really stored "on pages in the file mapping".
> >>> Current implementation (since 4.14) is that error state is stored in struct
> >>> file (I think this tends to be called "file description" in manpages) and
> >>
> >> (Yes, "open file description" is the POSIX terminology for the thing that
> >> sits between the FD and the inode--struct file in kernel parlance--and I
> >> try to follow POSIX terminology in the manual pages where possible.
> >>
> >>> so EIO / ENOSPC is reported once for each file description of the file that
> >>> was open before the error happened. Not sure if we want to be so precise in
> >>> the manpages or if it just confuses people. 
> >>
> >> Well, people are confused now, so I think more detail would be good.
> >>
> >>> Anyway your takeway that no
> >>> error on subsequent fsync() does not mean data was written is correct.
> >>
> >> Thanks. (See also my rply to Jeff.)
> >>
> >> By the way, a question related to your comments above. In the 
> >> errors section, there is this:
> >>
> >>        EIO    An  error  occurred during synchronization.  This error may
> >>               relate to data written to some other file descriptor on the
> >> *             same  file.   Since Linux 4.13, errors from write-back will
> >>               be reported to all file descriptors that might have written
> >>               the  data  which  triggered  the  error.   Some filesystems
> >>               (e.g., NFS) keep close track of  which  data  came  through
> >>               which  file  descriptor,  and  give more precise reporting.
> >>               Other  filesystems  (e.g.,  most  local  filesystems)  will
> >>               report errors to all file descriptors that were open on the
> >> *             file when the error was recorded.
> >>
> >> In the marked (*) lines, we have the word "file". Is this accurate? I mean, I
> >> would normally take "file" in this context to mean the inode ('struct inode').
> >> But I wonder if really what is meant here is "open file description"
> >> ('struct file'). In other words, is the EIO being generated for all FDs 
> >> connected to the same open file description, or for all FDs for all of the
> >> open file descriptions connected to the inode? Your thoughts?
> > 
> > The error gets reported once for each "open file description" of the file
> > (inode) where the error happened. If there are multiple file descriptors
> > pointing to the same open file description, then only one of those file
> > descriptors will see the error. This is inevitable consequence of kernel
> > storing the error state in struct file and clearing it once it is
> > reported...
> 
> So, the text in wrong two respects, I believe:
> 
> * It should be phrased in terms of "open file description", not "file",
> in the lines that I marked.

No, I believe 'file' is correct on these two lines. I guess I wasn't
precise enough in my explanation of the mechanism :) We actually have two
places where we store error state. There's "error counter" in the inode and
then "last seen error" counter in struct file. Whenever "last seen error"
is less than "inode error counter" we report error from the syscall and set
"last seen error" in the used struct file to the current "inode error
counter". So whenever writeback error happens for the inode, all 'struct
file's will end up reporting the error exactly once.

> * Where it says "to all file descriptors" (twice), it should rather say
> "to any of the file descriptors [that refer to the open file description]"

This is correct but I'm not sure it captures well the fact that each open
file description is guaranteed to get a notification. So maybe I'd rephrase
it like "reported to all file descriptors" -> "reported to all open file
descriptions (if there are multiple file descriptors pointing to the same
open file description, the error is reported only to the first call
regardless of which of the descriptors it uses)"

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
