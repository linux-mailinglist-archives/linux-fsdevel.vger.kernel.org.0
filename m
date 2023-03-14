Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987AD6B8831
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 03:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCNCO0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 22:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCNCOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:14:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA37B30EB;
        Mon, 13 Mar 2023 19:14:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56428614A6;
        Tue, 14 Mar 2023 02:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2823C433EF;
        Tue, 14 Mar 2023 02:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678760062;
        bh=TLxubRg2wj4/bxK478LTNwiY+jupRRwciwxIPviGdyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ttrKgsv1vSJ6shxVSeuf0XxhkrnLLyw4ba1gH07Vx1HZkpmCUHxX9dYY3pITjfSkD
         h445S7hCmRdzlPMfqBxthxWUWJJ7KaRBie3fHH+/d5AqGdRbbEUgpaMcorPyx8u60W
         nLoKfqA1xN75fRlQOPQLcVL3OsrEnXrqP5OvvtmoA1rmHUcNEeIUHnzNbnxekoK77b
         gs1FdkK17yTVl5c0L1N97vRXzS/u0oQ8R00Ju9lE8cI11ir9ptoWleMvcftv8q/w4+
         2lvgQkLkAoEtLGWNgPy1NwFA1IStY9ftG6+UV5GPcpYrMvNvMzUxXkVgbcQF9t5dhL
         XaXIe6J0tClmA==
Date:   Mon, 13 Mar 2023 19:14:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [LSF TOPIC] online repair of filesystems: what next?
Message-ID: <20230314021422.GE11394@frogsfrogsfrogs>
References: <20230309160000.GC1637786@frogsfrogsfrogs>
 <87v8j9ixvy.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8j9ixvy.fsf@doe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 09, 2023 at 11:56:57PM +0530, Ritesh Harjani wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
> 
> > On Thu, Mar 09, 2023 at 08:54:39AM +1100, Dave Chinner wrote:
> >> On Wed, Mar 08, 2023 at 06:12:06PM +0100, Jan Kara wrote:
> >> > Hi!
> >> >
> >> > I'm interested in this topic. Some comments below.
> >> >
> >> > On Tue 28-02-23 12:49:03, Darrick J. Wong wrote:
> >> > > Five years ago[0], we started a conversation about cross-filesystem
> >> > > userspace tooling for online fsck.  I think enough time has passed for
> >> > > us to have another one, since a few things have happened since then:
> >> > >
> >> > > 1. ext4 has gained the ability to send corruption reports to a userspace
> >> > >    monitoring program via fsnotify.  Thanks, Collabora!
> >> > >
> >> > > 2. XFS now tracks successful scrubs and corruptions seen during runtime
> >> > >    and during scrubs.  Userspace can query this information.
> >> > >
> >> > > 3. Directory parent pointers, which enable online repair of the
> >> > >    directory tree, is nearing completion.
> >> > >
> >> > > 4. Dave and I are working on merging online repair of space metadata for
> >> > >    XFS.  Online repair of directory trees is feature complete, but we
> >> > >    still have one or two unresolved questions in the parent pointer
> >> > >    code.
> >> > >
> >> > > 5. I've gotten a bit better[1] at writing systemd service descriptions
> >> > >    for scheduling and performing background online fsck.
> >> > >
> >> > > Now that fsnotify_sb_error exists as a result of (1), I think we
> >> > > should figure out how to plumb calls into the readahead and writeback
> >> > > code so that IO failures can be reported to the fsnotify monitor.  I
> >> > > suspect there may be a few difficulties here since fsnotify (iirc)
> >> > > allocates memory and takes locks.
> >> >
> >> > Well, if you want to generate fsnotify events from an interrupt handler,
> >> > you're going to have a hard time, I don't have a good answer for that.
> >>
> >> I don't think we ever do that, or need to do that. IO completions
> >> that can throw corruption errors are already running in workqueue
> >> contexts in XFS.
> >>
> >> Worst case, we throw all bios that have IO errors flagged to the
> >> same IO completion workqueues, and the problem of memory allocation,
> >> locks, etc in interrupt context goes away entire.
> >
> > Indeed.  For XFS I think the only time we might need to fsnotify about
> > errors from interrupt context is writeback completions for a pure
> > overwrite?  We could punt those to a workqueue as Dave says.  Or figure
> > out a way for whoever's initiating writeback to send it for us?
> >
> > I think this is a general issue for the pagecache, not XFS.  I'll
> > brainstorm with willy the next time I encounter him.
> >
> >> > But
> >> > offloading of error event generation to a workqueue should be doable (and
> >> > event delivery is async anyway so from userspace POV there's no
> >> > difference).
> >>
> >> Unless I'm misunderstanding you (possible!), that requires a memory
> >> allocation to offload the error information to the work queue to
> >> allow the fsnotify error message to be generated in an async manner.
> >> That doesn't seem to solve anything.
> >>
> >> > Otherwise locking shouldn't be a problem AFAICT. WRT memory
> >> > allocation, we currently preallocate the error events to avoid the loss of
> >> > event due to ENOMEM. With current usecases (filesystem catastrophical error
> >> > reporting) we have settled on a mempool with 32 preallocated events (note
> >> > that preallocated event gets used only if normal kmalloc fails) for
> >> > simplicity. If the error reporting mechanism is going to be used
> >> > significantly more, we may need to reconsider this but it should be doable.
> >> > And frankly if you have a storm of fs errors *and* the system is going
> >> > ENOMEM at the same time, I have my doubts loosing some error report is
> >> > going to do any more harm ;).
> >>
> >> Once the filesystem is shut down, it will need to turn off
> >> individual sickness notifications because everything is sick at this
> >> point.
> >
> > I was thinking that the existing fsnotify error set should adopt a 'YOUR
> > FS IS DEAD' notification.  Then when the fs goes down due to errors or
> > the shutdown ioctl, we can broadcast that as the final last gasp of the
> > filesystem.
> >
> >> > > As a result of (2), XFS now retains quite a bit of incore state about
> >> > > its own health.  The structure that fsnotify gives to userspace is very
> >> > > generic (superblock, inode, errno, errno count).  How might XFS export
> >> > > a greater amount of information via this interface?  We can provide
> >> > > details at finer granularity -- for example, a specific data structure
> >> > > under an allocation group or an inode, or specific quota records.
> >> >
> >> > Fsnotify (fanotify in fact) interface is fairly flexible in what can be
> >> > passed through it. So if you need to pass some (reasonably short) binary
> >> > blob to userspace which knows how to decode it, fanotify can handle that
> >> > (with some wrapping). Obviously there's a tradeoff to make how much of the
> >> > event is generic (as that is then easier to process by tools common for all
> >> > filesystems) and how much is fs specific (which allows to pass more
> >> > detailed information). But I guess we need to have concrete examples of
> >> > events to discuss this.
> >>
> >> Fine grained health information will always be filesystem specific -
> >> IMO it's not worth trying to make it generic when there is only one
> >> filesystem that tracking and exporting fine-grained health
> >> information. Once (if) we get multiple filesystems tracking fine
> >> grained health information, then we'll have the information we need
> >> to implement a useful generic set of notifications, but until then I
> >> don't think we should try.
> >
> > Same here.  XFS might want to send the generic notifications and follow
> > them up with more specific information?
> >
> >> We should just export the notifications the filesystem utilities
> >> need to do their work for the moment.  When management applications
> >> (e.g Stratis) get to the point where they can report/manage
> >> filesystem health and need that information from multiple
> >> filesystems types, then we can work out a useful common subset of
> >> fine grained events across those filesystems that the applications
> >> can listen for.
> >
> > If someone wants to write xfs_scrubd that listens for events and issues
> > XFS_IOC_SCRUB_METADATA calls I'd be all ears. :)
> >
> 
> Does it make sense to have more generic FS specific application daemon
> which can listen on such events from fanotify and take admin actions
> based on that.
> For e.g. If any FS corruption is encountered causing FS shutdown and/or
> ro mount.

If we ever wire up generic notifications for the pagecache and iomap
then I guess we /could/ at least build a generic service to do things
like blast the user's session notifier/sysadmin's monitoring service
when things go wrong.

> 1. then taking a xfs metadump which can later be used for analysis
> of what went wrong (ofcourse this will need more thinking on how and
> where to store it).
> 2. Initiating xfs_scrub with XFS_IOC_SCRUB_METATA call.

These things are all /very/ filesystem specific.  For things like
metadump and auto-scrubbing I think we'd need something in xfsprogs, not
a generic tool.

> 3. What else?
> 
> Ofcourse in production workloads the metadump can be collected by
> obfuscating file/directory names ;)

That said... it would be pretty useful if there was *some* ability to
automate capture of metadata dumps for ext4 and xfs.  Once the fs goes
offline it's probably safe to capture the dump since (presumably) the fs
will not be writing to the block device any more.

The hard part is having a place to dump that much information.  Do we
still trust the running system enough to handle it, or would we be
better off deferring that to a kdump payload?

--D

> -ritesh
