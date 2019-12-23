Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2B1299CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 19:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfLWSUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 13:20:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:57758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbfLWSUD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 13:20:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C01D2B127;
        Mon, 23 Dec 2019 18:19:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CFA2B1E0B47; Mon, 23 Dec 2019 19:19:56 +0100 (CET)
Date:   Mon, 23 Dec 2019 19:19:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: File monitor problem
Message-ID: <20191223181956.GB17813@quack2.suse.cz>
References: <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz>
 <CAOQ4uxjda6iQ1D0QEVB18TcrttVpd7uac++WX0xAyLvxz0x7Ew@mail.gmail.com>
 <20191204190206.GA8331@bombadil.infradead.org>
 <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz>
 <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 19-12-19 09:33:24, Amir Goldstein wrote:
> On Mon, Dec 16, 2019 at 5:00 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > On Wed, Dec 11, 2019 at 3:58 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > Hi Jan,
> >
> > I have something working.
> >
> > Patches:
> > https://github.com/amir73il/linux/commits/fanotify_name
> >
> > Simple test:
> > https://github.com/amir73il/ltp/commits/fanotify_name
> >
> > I will post the patches after I have a working demo, but in the mean while here
> > is the gist of the API from the commit log in case you or anyone has comments
> > on the API.
> >
> > Note that in the new event flavor, event mask is given as input
> > (e.g. FAN_CREATE) to filter the type of reported events, but
> > the event types are hidden when event is reported.

Makes some sense I guess but at the same time won't this be rather
confusing for users of the API?

Also I've read you proposal and I'm somewhat wondering whether we are not
overengineering this. I can see the need for FAN_DIR_MODIFIED_WITH_NAME
(stupid name, I know) - generated when something changed with names in a
particular directory, reported with FID of the directory and the name
inside that directory involved with the change. Directory watching
application needs this to keep track of "names to check". Is the name
useful with any other type of event? _SELF events cannot even sensibly have
it so no discussion there as you mention below. Then we have OPEN, CLOSE,
ACCESS, ATTRIB events. Do we have any use for names with those?

								Honza

> > Besides the dirent event types, events "on child" (i.e. MODIFY) can also be
> > reported with name to a directory watcher.
> >
> > For now, "on child" events cannot be requested for filesystem/mount
> > watch, but I think we should consider this possibility so I added
> > a check to return EINVAL if this combination is attempted.
> >
> 
> Hi Jan,
> 
> Thinking out loud again.
> 
> Assuming the concept of FAN_REPORT_FID_NAME as described in the
> commit messages below is acceptable, the way to deal with dirent events
> is clear as well as the way to deal with events "on child" for a watched dir
> and those are what the branch fanotify_name implemented.
> 
> I've spend the last few days trying to figure out the "best" way to handle the
> rest of the events. And by "best" I mean, least to explain in man page, while
> providing the needed functionality to users.
> 
> This is what I got to so far. Patches are shaping up on branch
> fanotify_name-wip same branch name for ltp tests:
> 
> For a group initialized with FAN_REPORT_FID_NAME:
> 1. Events report mask with only FAN_WITH_NAME flag
> 2. Reported name follows fid but may be empty in some cases
> 3. Dirent events (create/delete/move) report a non-empty name
> 4. Events "on child" on watched dir report a non-empty name
> 5. Events "on self" (delete_self/move_self) report an empty name
> 6. Events "possible on child" (open/access/modify/close/attrib) are
>     reported only in their "on child" flavor when set on a sb/mount mark
> 7. The flag FAN_EVENT_ON_CHILD on a sb/mount mark is ignored
>     (as in current upstream kernel and man page), but the events are
>     reported with non-empty name and parent dir fid, same as in the
>     case where all directories under sb/mount have been marked
>     with FAN_EVENT_ON_CHILD (a.k.a slow recursive watch)
> 
> There are some open questions regarding the fine details of items 5-7:
> - Should "self" events with empty name on dir be reported?
> - Should "self" events with empty name on non-dir be reported?
> - Should open/access/attrib on watched dir itself report an
>   event with empty name?
> - Should open/access/attrib on root sb/mount root dir report an
>   event with empty name?
> - Should open/access/modify/attrib on non-dir report an event
>   with empty name?
> 
> For full disclosure, in the out-of-tree patches [1] we use in CTERA
> the answer to all the open questions above is:
> "Yes, but the filesystem monitor is only using the self events on dirs".
> 
> The problem with this approach is that there is currently no way
> for users to request certain events ONLY_ONDIR. A typical filesystem
> monitor is only interested in self events on directories, but requesting
> self events will fill the queue with unneeded self events on files.
> 
> Another valid answer to all these questions could be:
> "No, because user can already get those events by opening another
> group with FAN_REPORT_FID".
> 
> The problem with this approach is that it is harder to document (?)
> and harder for users to use (?).
> 
> Therefore, I am leaning toward this middle ground solution:
> 
> 8. If a non-empty name is reported, fid is identifying a directory
> 9. Events on non-directory with empty name are not reported.
>     user may use another group with FAN_REPORT_FID to get
>     those events
> 
> I could use some guidance here.
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/linux/commits/fanotify_filename
> 
> >
> > commit 91e0af27ac329f279167e74761fb5303ebbc1c08
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Mon Dec 16 08:39:21 2019 +0200
> >
> >     fanotify: report name info with FAN_REPORT_FID_NAME
> >
> >     With init flags FAN_REPORT_FID_NAME, report events with name in variable
> >     length fanotify_event_info record similar to how fid's are reported.
> >     When events are reported with name, the reported fid identifies the
> >     directory and the name follows the fid. The info record type for this
> >     event info is FAN_EVENT_INFO_TYPE_FID_NAME.
> >
> >     There are several ways that an application can use this information:
> >
> >     1. When watching a single directory, the name is always relative to
> >     the watched directory, so application need to fstatat(2) the name
> >     relative to the watched directory.
> >
> >     2. When watching a set of directories, the application could keep a map
> >     of dirfd for all watched directories and hash the map by fid obtained
> >     with name_to_handle_at(2).  When getting a name event, the fid in the
> >     event info could be used to lookup the base dirfd in the map and then
> >     call fstatat(2) with that dirfd.
> >
> >     3. When watching a filesystem (FAN_MARK_FILESYSTEM) or a large set of
> >     directories, the application could use open_by_handle_at(2) with the fid
> >     in event info to obtain dirfd for the directory where event happened and
> >     call fstatat(2) with this dirfd.
> >
> >     The last option scales better for a large number of watched directories.
> >     The first two options may be available in the future also for non
> >     privileged fanotify watchers, because open_by_handle_at(2) requires
> >     the CAP_DAC_READ_SEARCH capability.
> >
> >     Legacy inotify events are reported with name and event mask (e.g. "foo",
> >     FAN_CREATE | FAN_ONDIR).  That can lead users to the conclusion that
> >     there is *currently* an entry "foo" that is a sub-directory, when in fact
> >     "foo" may be negative or non-dir by the time user gets the event.
> >
> >     To make it clear that the current state of the named entry is unknown,
> >     the new fanotify event intentionally hides this information and reports
> >     only the flag FAN_WITH_NAME in event mask.  This should make it harder
> >     for users to make wrong assumptions and write buggy applications.
> >
> >     We reserve the combination of FAN_EVENT_ON_CHILD on a filesystem/mount
> >     mark and FAN_REPORT_NAME group for future use, so for now this
> >     combination is invalid.
> >
> >     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > commit 76a509dbc06fd58ec6636484f87896044cd99022
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Fri Dec 13 11:58:02 2019 +0200
> >
> >     fanotify: implement basic FAN_REPORT_FID_NAME logic
> >
> >     Dirent events will be reported in one of two flavors depending on
> >     fanotify init flags:
> >
> >     1. Dir fid info + mask that includes the specific event types and
> >        optional FAN_ONDIR flag.
> >     2. Dir fid info + name + mask that includes only FAN_WITH_NAME flag.
> >
> >     To request the second event flavor, user will need to set the
> >     FAN_REPORT_FID_NAME flags in fanotify_init().
> >
> >     The first flavor is already supported since kernel v5.1 and is
> >     intended to be used for watching directories in "batch mode" - user
> >     is notified when directory is changed and re-scans the directory
> >     content in response.  This event flavor is stored more compactly in
> >     event queue, so it is optimal for workloads with frequent directory
> >     changes (e.g. many files created/deleted).
> >
> >     The second event flavor is intended to be used for watching large
> >     directories, where the cost of re-scan of the directory on every change
> >     is considered too high.  The watcher getting the event with the directory
> >     fid and entry name is expected to call fstatat(2) to query the content of
> >     the entry after the change.
> >
> >     Events "on child" will behave similarly to dirent events, with a small
> >     difference - the first event flavor without name reports the child fid.
> >     The second flavor with name info reports the parent fid, because the
> >     name is relative to the parent directory.
> >
> >     At the moment, event name info reporting is not implemented, so the
> >     FAN_REPORT_NAME flag is not yet valid as input to fanotify_init().
> >
> >     Signed-off-by: Amir Goldstein <amir73il@gmail.com>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
