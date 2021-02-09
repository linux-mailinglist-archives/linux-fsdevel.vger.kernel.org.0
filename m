Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC0314AFA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhBII5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 03:57:40 -0500
Received: from mail107.syd.optusnet.com.au ([211.29.132.53]:59915 "EHLO
        mail107.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230174AbhBIIzu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:55:50 -0500
Received: from dread.disaster.area (pa49-181-52-82.pa.nsw.optusnet.com.au [49.181.52.82])
        by mail107.syd.optusnet.com.au (Postfix) with ESMTPS id 0A57DD5EE63;
        Tue,  9 Feb 2021 19:55:02 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1l9OnV-00Dt2U-WE; Tue, 09 Feb 2021 19:55:02 +1100
Date:   Tue, 9 Feb 2021 19:55:01 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>, jack@suse.com,
        viro@zeniv.linux.org.uk, amir73il@gmail.com, dhowells@redhat.com,
        darrick.wong@oracle.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [RFC] Filesystem error notifications proposal
Message-ID: <20210209085501.GS4626@dread.disaster.area>
References: <87lfcne59g.fsf@collabora.com>
 <YAoDz6ODFV2roDIj@mit.edu>
 <87pn1xdclo.fsf@collabora.com>
 <YBM6gAB5c2zZZsx1@mit.edu>
 <871rdydxms.fsf@collabora.com>
 <YBnTekVOQipGKXQc@mit.edu>
 <87wnvi8ke2.fsf@collabora.com>
 <20210208221916.GN4626@dread.disaster.area>
 <YCHgkReD1waTItKm@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCHgkReD1waTItKm@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=7pwokN52O8ERr2y46pWGmQ==:117 a=7pwokN52O8ERr2y46pWGmQ==:17
        a=kj9zAlcOel0A:10 a=qa6Q16uM49sA:10 a=7-415B0cAAAA:8
        a=OzhJ6n3p6WiJYu67YDUA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 08:08:33PM -0500, Theodore Ts'o wrote:
> On Tue, Feb 09, 2021 at 09:19:16AM +1100, Dave Chinner wrote:
> > Nope, not convinced at all. As a generic interface, it cannot be
> > designed explicitly for the needs of a single filesystem, especially
> > when there are other filesystems needing to implement similar
> > functionality.
> >
> > As Amir pointed up earlier in the thread, XFS already already has
> > extensive per-object verification and error reporting facilicities...
> 
> Sure, but asking Collabora to design something which works for XFS and
> not for ext4 is also not fair.

<blink>

No, Ted, I did no such thing.

Do you really think that I have so little respect for Gabriel, Amir
or Jan or anyone else on -fsdevel that I would waste their precious
time by behaving like a toxic, selfish, narcissistic asshole who
cares only about a single filesystem to the exclusion of everything
else?

Maybe you haven't seen the big picture problem yet? That is,
multiple actors have spoken of their need for a generic fs
notification functionality and their requirements are not wholly
centered around a single filesystem. The application stacks that
need these notifications don't care what filesystem is being used to
store the data; they just want to know when certain things happen to
whatever filesystem their data is in and they want it in a
single, common, well defined format.

They most definitely do not want to have a N different ENOSPC
message formats that they have to understand in userspace. They want
one format that covers ENOSPC, shutdown, emergency remount-ro, inode
corruption, data corruption, bad blocks, writeback failures, etc
across all filesystems. This cannot be acheived by re-implmenting
the notification wheel repeatedly in every filesystem we need to
provide notifications from.

Hence we need a notification subsystem that uses common messages
for common events across ext4, ceph, btrfs, gfs2, NFS and other
filesystems. There is nothing in what I described that is XFS
specific, and quite frankly I don't give a shit about XFS here - I
just used it as an example to derive a generic message format that
covers a large number of the requirements we already have for
information the notification subsystem needs to provide.

So I'll make this very clear, because it is fundamental,
non-negotiable requirement:

*WE* *DO* *NOT* *WANT* *COMPETING* *FILESYSTEM* *NOTIFICATION*
*SUBSYSTEMS* *IN* *THE* *KERNEL*.

That means we have to work together to find common ground and a
solution that works for everyone.  What I've suggested allows all
filesystems to supply the same information for the same events.  It
also allows filesystems to include their own private diagnostic
information appended to the generic message, thereby fulfulling both
the goals of both David Howells' original patchset and Gabriel's
derived ext4 specific patchset.

It works for everyone - it's a win-win scenario - and it lays the
foundation for further common notifications to be created that are
useful to userspace, as well as supporting customised filesystem
specific notifications that largely makes it future proof.

The design and message formats can be refined simply by
collaborating to ensure that everyone's requirements are stated and
met.  If you have technical comments on this proposal, then I'm all
ears.

You know what Google's requirements for notifications are, so how
about you go back to my email and respond with to whether the
message format contains enough information for your employer's
needs.  This way we can improve the structure and ensure that the
resulting message format and infrastructure design can do what
everyone needs.

I should not have to remind you of your responsibilities, Ted.
Please try harder to understand what other people say and be
truthful, respectful and constructive in future discussions.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
