Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51272192400
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Mar 2020 10:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCYJ1K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 05:27:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:51036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgCYJ1K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 05:27:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 193EFACBD;
        Wed, 25 Mar 2020 09:27:08 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CA9E41E10FB; Wed, 25 Mar 2020 10:27:07 +0100 (CET)
Date:   Wed, 25 Mar 2020 10:27:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 10/14] fanotify: divorce fanotify_path_event and
 fanotify_fid_event
Message-ID: <20200325092707.GF28951@quack2.suse.cz>
References: <20200319151022.31456-1-amir73il@gmail.com>
 <20200319151022.31456-11-amir73il@gmail.com>
 <20200324175029.GD28951@quack2.suse.cz>
 <CAOQ4uxhh8DJC+5xPjGaph8yKXa_hSxi7ua0s3wUDaV7MPcaStw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhh8DJC+5xPjGaph8yKXa_hSxi7ua0s3wUDaV7MPcaStw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 25-03-20 09:24:37, Amir Goldstein wrote:
> On Tue, Mar 24, 2020 at 7:50 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 19-03-20 17:10:18, Amir Goldstein wrote:
> > > Breakup the union and make them both inherit from abstract fanotify_event.
> > >
> > > fanotify_path_event, fanotify_fid_event and fanotify_perm_event inherit
> > > from fanotify_event.
> > >
> > > type field in abstract fanotify_event determines the concrete event type.
> > >
> > > fanotify_path_event, fanotify_fid_event and fanotify_perm_event are
> > > allocated from separate memcache pools.
> > >
> > > The separation of struct fanotify_fid_hdr from the file handle that was
> > > done for efficient packing of fanotify_event is no longer needed, so
> > > re-group the file handle fields under struct fanotify_fh.
> > >
> > > The struct fanotify_fid, which served to group fsid and file handle for
> > > the union is no longer needed so break it up.
> > >
> > > Rename fanotify_perm_event casting macro to FANOTIFY_PERM(), so that
> > > FANOTIFY_PE() and FANOTIFY_FE() can be used as casting macros to
> > > fanotify_path_event and fanotify_fid_event.
> > >
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > So I was pondering about this commit. First I felt it should be split and
> 
> Oh yeh. The split makes things much clearer!
> 
> > second when splitting the commit I've realized I dislike how you rely on
> > 'struct fanotify_event' being the first in events that inherit it. That is
> > not well maintainable long term since over the time, hidden dependencies on
> > this tend to develop (you already had like four in this patch) and then
> > when you need to switch away from that in the future, you have a horrible
> > time untangling the mess... I also wanted helpers like FANOTIFY_PE() to be
> > inline functions to get type safety and realized you actually use
> > FANOTIFY_PE() both for fsnotify_event and fanotify_event which is hacky as
> 
> Excellent! I avoided the FANOTIFY_E/fsn_event  related cleanups, but now
> code looks much better and safe.
> 
> > well. Finally, I've realized that fanotify was likely broken when
> > generating overflow events (create_fd() was returning -EOVERFLOW which
> > confused the caller - still need to write a testcase for that) and you
> > silently fix that so I wanted that as separate commit as well.
> 
> I don't think you will find a test case.
> Before the divorce patch, the meaning of fanotify_event_has_path() is:
>          event->fh_type == FILEID_ROOT;
> but overflow event with NULL path has:
>          event->fh_type = FILEID_INVALID;
> 
> So -EOVERFLOW code in was not reachable.

Ah, right. Thanks for clarification. Actually, I think now that we have
fanotify event 'type' notion, I'd like to make overflow event a separate
type which will likely simplify a bunch of code (e.g. we get rid of a
strange corner case of 'path' being included in the event but being
actually invalid). Not sure whether I'll do it for this merge window,
probably not since we're in a bit of a hurry.

> Meaning that your patch "fanotify: Fix handling of overflow event" is
> correct, but its commit message is wrong.
> It also says: "by default fanotify event queues are unlimited",
> but FAN_UNLIMITED_QUEUE is opt-in???

Yeah, that was just me bending reality to what I thought it should be :)
Thanks for correcting me. I've rewritten the changelog to:

    fanotify: Simplify create_fd()
    
    create_fd() is never used with invalid path. Also the only thing it
    needs to know from fanotify_event is the path. Simplify the function to
    take path directly and assume it is correct.
    
    Signed-off-by: Jan Kara <jack@suse.cz>

> > All in all this commit ended up like three commits I'm attaching. I'd be
> > happy if you could have a look through them but the final code isn't that
> > different and LTP passes so I'm reasonably confident I didn't break
> > anything.
> 
> The split and end result look very good.
> After rebasing my fanotify_name branch on top of your changes, it also
> fixed an error in FAN_REPORT_NAME test, which I was going to look
> at later, so your cleanup paid off real fast :-)

Glad to hear that :) Today I hope to finish processing your series (only
the final patch is missing now) and will push out the result after testing
everything.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
