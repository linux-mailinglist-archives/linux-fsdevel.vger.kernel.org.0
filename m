Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A61490A2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 15:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiAQOVK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 09:21:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48754 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiAQOVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:21:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 21499212B5;
        Mon, 17 Jan 2022 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642429269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fB6+JXGtUucXFyeyLn4/PISgsUTJYu5gzxq/4bdi7dQ=;
        b=E76bFxBPo3kUDF7QzzJxdIOsJDrDWPgcrob/GJQB247WKyAytrXlRMIP9u0lnwQ9R7Qgr+
        FrU5nDuyjUOPYhIHt4Wu+WHpS2+MdvuU93NSxg4CAcM9Je5lPRuM6SZBgGaODwNFCvlgaR
        MXv95IpPxkjd9o2ApxX3jYfXteqMkgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642429269;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fB6+JXGtUucXFyeyLn4/PISgsUTJYu5gzxq/4bdi7dQ=;
        b=x9+PH1ogTIPIptxgFLinEdBX/aJC9aXG5tZ/ug3gbbDgVNEwzifLk2Mcx/XfGW4ulqkmOE
        EHbbpXPdcJgL7OBQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0B010A3B81;
        Mon, 17 Jan 2022 14:21:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 83E39A05E4; Mon, 17 Jan 2022 15:21:07 +0100 (CET)
Date:   Mon, 17 Jan 2022 15:21:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ivan Delalande <colona@arista.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: Potential regression after fsnotify_nameremove() rework in 5.3
Message-ID: <20220117142107.vpfmesnocsndbpar@quack3.lan>
References: <YeI7duagtzCtKMbM@visor>
 <CAOQ4uxjiFewan=kxBKRHr0FOmN2AJ-WKH3DT2-7kzMoBMNVWJA@mail.gmail.com>
 <YeNyzoDM5hP5LtGW@visor>
 <CAOQ4uxhaSh4cUMENkaDJij4t2M9zMU9nCT4S8j+z+p-7h6aDnQ@mail.gmail.com>
 <YeTVx//KrRKiT67U@visor>
 <CAOQ4uxibWbjFJ2-0qoARuyd2WD9PEd9HZ82knB0bcy8L92TOag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxibWbjFJ2-0qoARuyd2WD9PEd9HZ82knB0bcy8L92TOag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-01-22 15:14:53, Amir Goldstein wrote:
> On Mon, Jan 17, 2022 at 4:34 AM Ivan Delalande <colona@arista.com> wrote:
> >
> > On Sun, Jan 16, 2022 at 12:14:01PM +0200, Amir Goldstein wrote:
> > > On Sun, Jan 16, 2022 at 3:20 AM Ivan Delalande <colona@arista.com> wrote:
> > >> On Sat, Jan 15, 2022 at 09:50:20PM +0200, Amir Goldstein wrote:
> > >>> On Sat, Jan 15, 2022 at 5:11 AM Ivan Delalande <colona@arista.com> wrote:
> > >>>> Sorry to bring this up so late but we might have found a regression
> > >>>> introduced by your "Sort out fsnotify_nameremove() mess" patch series
> > >>>> merged in 5.3 (116b9731ad76..7377f5bec133), and that can still be
> > >>>> reproduced on v5.16.
> > >>>>
> > >>>> Some of our processes use inotify to watch for IN_DELETE events (for
> > >>>> files on tmpfs mostly), and relied on the fact that once such events are
> > >>>> received, the files they refer to have actually been unlinked and can't
> > >>>> be open/read. So if and once open() succeeds then it is a new version of
> > >>>> the file that has been recreated with new content.
> > >>>>
> > >>>> This was true and working reliably before 5.3, but changed after
> > >>>> 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
> > >>>> d_delete()") specifically. There is now a time window where a process
> > >>>> receiving one of those IN_DELETE events may still be able to open the
> > >>>> file and read its old content before it's really unlinked from the FS.
> > >>>
> > >>> This is a bit surprising to me.
> > >>> Do you have a reproducer?
> > >>
> > >> Yeah, I was using the following one to bisect this. It will print a
> > >> message every time it succeeds to read the file after receiving a
> > >> IN_DELETE event when run with something like `mkdir /tmp/foo;
> > >> ./indelchurn /tmp/foo`. It seems to hit pretty frequently and reliably
> > >> on various systems after 5.3, even for different #define-parameters.
> > >>
> > >
> > > I see yes, it's a race between fsnotify_unlink() and d_delete()
> > > fsnotify_unlink() in explicitly required to be called before d_delete(), so
> > > it has the d_inode information and that leaves a windows for opening
> > > the file from cached dentry before d_delete().
> > >
> > > I would rather that we try to address this not as a regression until
> > > there is proof of more users that expect the behavior you mentioned.
> > > I would like to provide you an API to opt-in for this behavior, because
> > > fixing it for everyone may cause other workloads to break.
> > >
> > > Please test the attached patch on top of v5.16 and use
> > > IN_DELETE|IN_EXCL_UNLINK as the watch mask for testing.
> > >
> > > I am assuming that it would be possible for you to modify the application
> > > and add the IN_EXCL_UNLINK flag and that your application does not
> > > care about getting IN_OPEN events on unlinked files?
> > >
> > > My patch overloads the existing flag IN_EXCL_UNLINK with a new
> > > meaning. It's a bit of a hack and we can use some other flag if we need to
> > > but it actually makes some sense that an application that does not care for
> > > events on d_unlinked() files will be guaranteed to not get those events
> > > after getting an IN_DELETE event. It is another form of the race that you
> > > described.
> > >
> > > Will that solution work out for you?
> >
> > Yeah, sounds perfect for us, and adding IN_EXCL_UNLINK to our
> > applications is fine indeed. I've tested the 5.16 patch on my laptop
> > with the reproducer and can't reproduce the issue. I've also tried the
> > 5.10 patch on our products and also stop seeing the issue both with
> > the reproducer but also with our internal applications and test cases
> > that made us look into this initially. So this looks like a good fix on
> > our side at least.
> >
> 
> I am glad the patch addresses your issue.
> However, I am not sure if I should even post it upstream,
> unless more people ask for it.
> 
> My point of view is that IN_DELETE does not have enough
> information for an "invalidate file" message.
> FAN_DELETE, otoh, with recently merged FAN_REPORT_TARGET_FID
> includes an information record with the unique and non-reusable file id of the
> unlinked inode.
> 
> That should allow your application to correctly invalidate the state files
> that it accesses on kernel >= v5.17.
> 
> Jan, do you have a different opinion?

Yeah, I was thinking about this. I don't quite like your hack with inotify
flag. Firstly, it requires cooperation from userspace (setting the flag),
secondly, d_drop() in fsnotify code is unexpected and ugly on the kernel
side, and overall adding yet another special case to fsnotify code is not
very compelling either.

I agree transitioning to fanotify may be a nice solution for the
application but I'm not sure how viable that is short term (requiring very
new kernel, maybe non-trivial cost of porting the application to fanotify).
Since this fully lies within the "we do not regress userspace" boundaries -
I'm not surprised the application does not expect to see a file for which
it got IN_DELETE event - I guess we should solve this transparently within
the kernel if we can. So far we've got only one report but I'd say there
are other applications like this out there, just they didn't transition to
new enough kernel yet or were lucky enough to not hit the problem yet.

One possibility I can see is: Add fsnotify primitive to create the event,
just not queue it in the notification queue yet (essentially we would
cut-short the event handling before calling fsnotify_insert_event() /
fsnotify_add_event()), only return it. Then another primitive would be for
queueing already prepared event. Then the sequence for unlink would be:

	LIST_HEAD(event_list);

	fsnotify_events_prepare(&event_list, ...);
	d_delete(dentry);
	fsnotify_events_report(&event_list);

And we can optionally wrap this inside d_delete_notify() to make it easier
on the callers. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
