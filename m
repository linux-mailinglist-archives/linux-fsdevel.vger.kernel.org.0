Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD245073D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 15:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236634AbhKOOl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 09:41:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:34180 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhKOOk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 09:40:59 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BA9C11FD69;
        Mon, 15 Nov 2021 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636987072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5MbPxtJGshaYfzYcqfDRNTlvt/LRhOEKlRQlOIkG4k=;
        b=TCC+JauX9OsG+8KKKUXv1ZGjkuiaVYZQ+tVbhMeYwpmPVtdjcJZY6zuch1cCICgGAc0Re3
        fgves/v8LaCguew3mUmdHp/5WQsm1I9K4a7FckPzqo2OIMUVp1dTJ/FNrriOP4TE39wRhY
        NzYV13pjS/OQ6fiCW98RR4c7cngayX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636987072;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5MbPxtJGshaYfzYcqfDRNTlvt/LRhOEKlRQlOIkG4k=;
        b=Zc2Ry2/GdHvXf9NVXJcwojJ4pGr378scYQj6tBkPLx9QL2diQtF9/QFkYiuEQw42R/dxLl
        cbCJL6apNwYIKLBw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A8106A3B9A;
        Mon, 15 Nov 2021 14:37:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 14DE61E11F3; Mon, 15 Nov 2021 15:37:50 +0100 (CET)
Date:   Mon, 15 Nov 2021 15:37:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/7] Report more information in fanotify dirent events
Message-ID: <20211115143750.GE23412@quack2.suse.cz>
References: <20211029114028.569755-1-amir73il@gmail.com>
 <CAOQ4uxjazEx=bL6ZfLaGCfH6pii=OatQDoeWc+74AthaaUC49g@mail.gmail.com>
 <20211112163955.GA30295@quack2.suse.cz>
 <CAOQ4uxgT5a7UFUrb5LCcXo77Uda4t5c+1rw+BFDfTAx8szp+HQ@mail.gmail.com>
 <CAOQ4uxgEbjkMMF-xVTdfWcLi4y8DGNit5Eeq=evby2nWCuiDVw@mail.gmail.com>
 <20211115102330.GC23412@quack2.suse.cz>
 <CAOQ4uxiBFkkbKU=yimLXoYKHFWOoUYrXfg4Kw_CkF=hcSGOm3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiBFkkbKU=yimLXoYKHFWOoUYrXfg4Kw_CkF=hcSGOm3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-11-21 14:22:49, Amir Goldstein wrote:
> > > A variant of option 3, is that FAN_RENAME will be an event mask flag
> > > that can be added to FAN_MOVE events, to request that if both FROM/TO events
> > > are going to be reported, then a single joint event will be reported
> > > instead, e.g:
> > >
> > > #define FAN_MOVE (FAN_MOVED_FROM | FAN_MOVED_TO)
> > > #define FAN_RENAME (FAN_MOVE | __FAN_MOVE_JOIN)
> > >
> > > Instead of generating an extra FS_RENAME event in fsnotify_move(),
> > > fsnotify() will search for matching marks on the moved->d_parent->d_inode
> > > of MOVED_FROM event add the mark as the FSNOTIFY_OBJ_TYPE_PARENT
> > > mark iterator type and then fanotify_group_event_mask() will be able
> > > to tell if the
> > > event should be reported as FAN_MOVED_FROM, FAN_MOVED_TO or a joint
> > > FAN_RENAME.
> > >
> > > If a group has the FAN_RENAME mask on the new parent dir, then
> > > FS_MOVED_TO events can be dropped, because the event was already
> > > reported as FAN_MOVED_TO or FAN_RENAME with the FS_MOVED_FROM
> > > event.
> > >
> > > Am I over complicating this?
> > > Do you have a better and clearer semantics to propose?
> >
> > So from API POV I like most keeping FAN_RENAME separate from FAN_MOVED_TO &
> > FAN_MOVED_FROM. It would be generated whenever source or target is tagged
> > with FAN_RENAME, source info is provided if source is tagged, target info
> > is provided when target is tagged (both are provides when both are tagged).
> > So it is kind of like FAN_MOVED_FROM | FAN_MOVED_TO but with guaranteed
> > merging. This looks like a clean enough and simple to explain API. Sure it
> > duplicates FAN_MOVED_FROM & FAN_MOVED_TO a lot but I think the simplicity
> > of the API outweights the duplication. Basically FAN_MOVED_FROM &
> > FAN_MOVED_TO could be deprecated with this semantics of FAN_RENAME although
> > I don't think we want to do it for compatibility reasons.
> 
> Well, not only for compatibility.
> The ability to request events for files moved into directory ~/inbox/ and files
> moved out of directory ~/outbox/ cannot be expressed with FAN_RENAME
> alone...

If you ask for FAN_RENAME on ~/inbox, you can then filter out the "move
out" events based on the information coming with the event to userspace.
But I agree it requires more work in userspace to simulate FAN_MOVED_FROM.

> > Implementation-wise we have couple of options. Currently the simplest I can
> > see is that fsnotify() would iterate marks on both source & target dirs
> > (like we already do for inode & parent) when it handles FS_RENAME event. In
> 
> Yes. I already have a WIP branch (fan_reanme) using
> FSNOTIFY_OBJ_TYPE_PARENT for the target dir mark.
> 
> Heads up: I intend to repurpose FS_DN_RENAME, by sending FS_RENAME
> to ->handle_inode_event() backends only if (parent_mark == inode_mark).
> Duplicating FS_MOVED_FROM I can cope with, but wasting 3 flags for
> the same event is too much for me to bare ;-)

:)

> > fanotify_handle_event() we will decide which info to report with FAN_RENAME
> > event based on which marks in iter_info have FS_RENAME set (luckily mount
> > marks are out of question for rename events so it will be relatively
> > simple). What do you think?
> 
> I like it. However,
> If FAN_RENAME can have any combination of old,new,old+new info
> we cannot get any with a single new into type
> FAN_EVENT_INFO_TYPE_DFID_NAME2
> 
> (as in this posting)

We could define only DFID2 and DFID_NAME2 but I agree it would be somewhat
weird to have DFID_NAME2 in an event and not DFID_NAME.

> We can go with:
> #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME   6
> #define FAN_EVENT_INFO_TYPE_NEW_DFID_NAME  7
> #define FAN_EVENT_INFO_TYPE_OLD_DFID               8
> #define FAN_EVENT_INFO_TYPE_NEW_DFID              9
> 
> Or we can go with:
> /* Sub-types common to all three fid info types */
> #define FAN_EVENT_INFO_FID_OF_OLD_DIR     1
> #define FAN_EVENT_INFO_FID_OF_NEW_DIR    2
> 
> struct fanotify_event_info_header {
>        __u8 info_type;
>        __u8 sub_type;
>        __u16 len;
> };
> 
> (as in my wip branch fanotify_fid_of)

When we went the way of having different types for FID and DFID, I'd
continue with OLD_DFID_NAME, NEW_DFID_NAME, ... and keep the padding byte
free for now (just in case there's some extension which would urgently need
it).
 
> We could also have FAN_RENAME require FAN_REPORT_NAME
> that would limit the number of info types, but I cannot find a good
> justification for this requirement.

Yeah, I would not force that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
