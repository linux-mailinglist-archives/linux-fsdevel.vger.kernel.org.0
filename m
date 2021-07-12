Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D193C5B4E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhGLLNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 07:13:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35038 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbhGLLNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 07:13:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B637822068;
        Mon, 12 Jul 2021 11:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626088216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MtJVUDhXGNYKcSeqgVKzOJ6/RLDwmSCmaxcNy9W6os=;
        b=IyAtr3vnoVSd/zhpYVudrQoS4YJoOZxCmVOXHuShmFV5LueeduNld+8NYCNb/Xqh8+fu/b
        OXgauVLGFep6kaB8tCP+Az+hRh62A+IoaDM0uyXYzoShq8C2l0G7pJwrhTYgRe8jApK+4D
        SJhsO2JtWAQAB2wJnzGxYiAGZ5b+bqY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626088216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MtJVUDhXGNYKcSeqgVKzOJ6/RLDwmSCmaxcNy9W6os=;
        b=kRR9sp7HRYq51+eZcsONvc1GU4955o06HwauMI/mh7EYVFAMOIgEu6d8FsPjH9CDY8zauR
        u/2EVdZ6/1J8aTBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id A41A2A3C5E;
        Mon, 12 Jul 2021 11:10:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4E6A51F2AA9; Mon, 12 Jul 2021 13:10:16 +0200 (CEST)
Date:   Mon, 12 Jul 2021 13:10:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Subject: Re: FAN_REPORT_CHILD_FID
Message-ID: <20210712111016.GC26530@quack2.suse.cz>
References: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgckzeRuiKSe7D=TVaJGTYwy4cbCFDpdWMQr1R_xXkJig@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Sun 11-07-21 20:02:29, Amir Goldstein wrote:
> I am struggling with an attempt to extend the fanotify API and
> I wanted to ask your opinion before I go too far in the wrong direction.
> 
> I am working with an application that used to use inotify rename
> cookies to match MOVED_FROM/MOVED_TO events.
> The application was converted to use fanotify name events, but
> the rename cookie functionality was missing, so I am carrying
> a small patch for FAN_REPORT_COOKIE.
> 
> I do not want to propose this patch for upstream, because I do
> not like this API.
> 
> What I thought was that instead of a "cookie" I would like to
> use the child fid as a way to pair up move events.
> This requires that the move events will never be merged and
> therefore not re-ordered (as is the case with inotify move events).
> 
> My thinking was to generalize this concept and introduce
> FAN_REPORT_CHILD_FID flag. With that flag, dirent events
> will report additional FID records, like events on a non-dir child
> (but also for dirent events on subdirs).

I'm starting to get lost in what reports what so let me draw a table here:

Non-directories
				DFID	FID	CHILD_FID
ACCESS/MODIFY/OPEN/CLOSE/ATTRIB parent	self	self
CREATE/DELETE/MOVE		-	-	-
DELETE_SELF/MOVE_SELF		x	self	self
('-' means cannot happen, 'x' means not generated)

Directories
				DFID	FID	CHILD_FID
ACCESS/MODIFY/OPEN/CLOSE/ATTRIB self	self	self
CREATE/DELETE/MOVE		self	self	target
DELETE_SELF/MOVE_SELF		x	self	self

Did I get this right?

I guess "CHILD_FID" seems somewhat confusing as it isn't immediately clear
from the name what it would report e.g. for open of a non-directory. Maybe
we could call it "TARGET_FID"? Also I'm not sure it needs to be exclusive
with FID. Sure it doesn't make much sense to report both FID and CHILD_FID
but does the exclusivity buy us anything? I guess I don't have strong
opinion either way, I'm just curious.
 
> Either FAN_REPORT_CHILD_FID would also prevent dirent events
> from being merged or we could use another flag for that purpose,
> but I wasn't able to come up with an idea for a name for this flag :-/
> 
> I sketched this patch [1] to implement the flag and to document
> the desired semantics. It's only build tested and I did not even
> implement the merge rules listed in the commit message.
> 
> [1] https://github.com/amir73il/linux/commits/fanotify_child_fid

WRT changes to merging: Whenever some application wants to depend on the
ordering of events I'm starting to get suspicious. What is it using these
events for? How is renaming different from linking a file into a new dir
and unlinking it from the previous one which is a series of events that
could be merged? Also fanotify could still be merging events happening
after rename to events before rename. Can the application tolerate that?
Inotify didn't do this because it is always merging only to the last event
in the queue.

When we were talking about FID events in the past (in the context of
directory events) we always talked about application just maintaining a set
of dirs (plus names) to look into. And that is safe and sound. But what you
talk about now seems rather fragile at least from the limited information I
have about your usecase...

> There are other benefits from FAN_REPORT_CHILD_FID which are
> not related to matching move event pairs, such as the case described
> in this discussion [2], where I believe you suggested something along
> the lines of FAN_REPORT_CHILD_FID.
> 
> [2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhEsbfA5+sW4XPnUKgCkXtwoDA-BR3iRO34Nx5c4y7Nug@mail.gmail.com/

Yes, I can see FAN_REPORT_CHILD_FID (or however we call it) can be useful
at times (in fact I think we made a mistake that we didn't make reported
FID to always be what you now suggest as CHILD_FID, but we found that out
only when DFID+NAME implementation settled so that train was long gone).
So I have no problem with that functionality as such.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
