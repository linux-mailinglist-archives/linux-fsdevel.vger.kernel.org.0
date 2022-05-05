Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5585751C0DF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379793AbiEENfb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 09:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379779AbiEENfV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 09:35:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC4C579A0;
        Thu,  5 May 2022 06:31:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 827491F8D8;
        Thu,  5 May 2022 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651757460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yu7EmBWTh8I8ZvaS9U7Bg+Zpvf52X+oUYhr1/0LsjnE=;
        b=gZu4fsL2aRni8RvH5UXgGEXf4Ry4y28/DkI+kh8QGSpIDEhEfnXgxsinwyZ/UkP+kUe5+K
        tOj7WjAkLUeqbwU9sgrjfjzEAlVAcRhFc0gWaI0OoHk/S6i4Elvq3dDWk9JUNilejMEFIL
        F9ffSIClZ1YhAgWBVh2/CjzOm8EliLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651757460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yu7EmBWTh8I8ZvaS9U7Bg+Zpvf52X+oUYhr1/0LsjnE=;
        b=jL7mA9NgA3Ueg3SJ85B3JazyToNo5uXhTTHfwBOiXpgMhNsYqLf1Po156+P6AXkmBqzzmp
        bdIjl4KxMVldGqCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 591512C142;
        Thu,  5 May 2022 13:31:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0E643A0627; Thu,  5 May 2022 15:30:57 +0200 (CEST)
Date:   Thu, 5 May 2022 15:30:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify API - Tracking File Movement
Message-ID: <20220505133057.zm5t6vumc4xdcnsg@quack3.lan>
References: <YnOmG2DvSpvvOEOQ@google.com>
 <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 05-05-22 15:56:16, Amir Goldstein wrote:
> On Thu, May 5, 2022 at 2:22 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello Matthew!
> >
> > On Thu 05-05-22 20:25:31, Matthew Bobrowski wrote:
> > > I was having a brief chat with Amir the other day about an idea/use
> > > case that I have which at present don't believe is robustly supported
> > > by the fanotify API. I was wondering whether you could share some
> > > thoughts on supporting the following idea.
> > >
> > > I have a need to track file movement across a filesystem without
> > > necessarily burdening the system by having to watch the entire
> > > filesystem for such movements. That is, knowing when file /dir1/a had
> > > been moved from /dir1/a to /dir2/a and then from /dir2/a to /dir3/a
> > > and so on. Or more simply, knowing the destination/new path of the
> > > file once it has moved.
> >
> > OK, and the places the file moves to can be arbitrary? That seems like a
> > bit narrow usecase :)
> >
> > > Initially, I was thinking of using FAN_MOVE_SELF, but it doesn't quite
> > > cut it. For such events, you only know the target location or path of
> > > a file had been modified once it has subsequently been moved
> > > elsewhere. Not to mention that path resolution using the file
> > > identifier from such an event may not always work. Then there's
> > > FAN_RENAME which could arguably work. This would include setting up a
> > > watch on the parent directory of the file of interest and then using
> > > the information record of type FAN_EVENT_INFO_TYPE_NEW_DFID_NAME to
> > > figure out the new target location of the file once it has been moved
> > > and then resetting the mark on the next parent directory once the new
> > > target location is known. But, as Amir rightfully mentioned, this
> > > rinse and repeat mark approach is suboptimal as it can lead to certain
> > > race conditions.
> >
> > It seems to me you really want FAN_MOVE_SELF but you'd need more
> > information coming with it like the new parent dir, wouldn't you? It would
> > be relatively easy to add that info but it would kind of suck that it would
> > be difficult to discover in advance whether the directory info will arrive
> > with the event or not. But that actually would seem to be the case for
> > FAN_RENAME as well because we didn't seem to bother to refuse FAN_RENAME on
> > a file. Amir?
> >
> 
> No, we did not, but it is also not refused for all the other dirent events and
> it was never refused by inotify too, so that behavior is at least consistent.
> But if we do want to change the behavior of FAN_RENAME on file, my preference
> would be to start with a Fixes commit that forbis that, backport it to stable
> and then allow the new behavior upstream.
> I can post the fix patch.

Yeah, I think we should do that. Thanks for looking into this!

> > > Having briefly mentioned all this, what is your stance on maybe
> > > extending out FAN_RENAME to also cover files? Or, maybe you have
> > > another approach/idea in mind to cover such cases i.e. introducing a
> > > new flag FAN_{TRACK,TRACE}.
> >
> > So extending FAN_MOVE_SELF or FAN_RENAME looks OK to me, not much thoughts
> > beyond that :).
> 
> Both FAN_RENAME and FAN_REPORT_TARGET_FID are from v5.17
> which is rather new and it is highly unlikely that anyone has ever used them,
> so I think we can get away with fixing the API either way.
> Not to mention that the man pages have not been updated.
> 
> This is from the man page that is pending review:
> 
>        FAN_REPORT_TARGET_FID (since Linux 5.17)
>               Events for fanotify groups initialized with this flag
> will contain additional information
>               about the child correlated with directory entry
> modification events...
>               For the directory entry modification events
>               FAN_CREATE,  FAN_DELETE,  FAN_RENAME,  and  FAN_MOVE,
> an  additional...
> 
>        FAN_MOVED_TO (since Linux 5.1)
>               Create an event when a file or directory has been moved
> to a marked parent directory...
> 
>        FAN_RENAME (since Linux 5.17)
>               This  event contains the same information provided by
> events FAN_MOVED_FROM
>               and FAN_MOVED_TO, ...
> 
>        FAN_MOVE_SELF (since Linux 5.1)
>               Create an event when a marked file or directory itself
> has been moved...
> 
> I think it will be easier to retrofit this functionality of FAN_RENAME
> (i.e. ...provided
> by events FAN_MOVED_FROM, FAN_MOVED_TO, and FAN_MOVE_SELF).
> Looking at the code, I think it will also be much easier to implement
> for FAN_RENAME
> because it is special-cased for reporting.
> 
> HOWEVER! look at the way we implemented reporting of FAN_RENAME
> (i.e. match_mask). We report_new location only if watching sb or watching
> new dir. We did that for a reason because watcher may not have permissions
> to read new dir. We could revisit this decision for a privileged group, but will
> need to go back reading all the discussions we had about this point to see
> if there were other reasons(?).

Yeah, this is a good point. We are able to safely report the new parent
only if the watching process is able to prove it is able to watch it.
Adding even more special cases there would be ugly and error prone I'm
afraid. We could certainly make this available only to priviledged
notification groups but still it is one more odd corner case and the
usecase does not seem to be that big. So maybe watching on sb for
FAN_RENAME and just quickly filtering based on child FID would be better
solution than fiddling with new event for files?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
