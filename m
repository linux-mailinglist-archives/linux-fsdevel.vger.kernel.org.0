Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F1B671145
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 03:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjARCmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 21:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjARCmO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:42:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F644FC10;
        Tue, 17 Jan 2023 18:42:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 111E6B819EE;
        Wed, 18 Jan 2023 02:42:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E29C433D2;
        Wed, 18 Jan 2023 02:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674009729;
        bh=GIj69U+p/3fjL/EJp7AIoI6YdpXbL7BOm8JswWVL47Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGvsDlm7NEN/ChZxI+MUrCb2QobdVI1xLDij1rHYIJVhpbgjplqAqi2V3e0dOSI4F
         xfk2yS3od+bRKYM3D4XD/Y9/5fzBhaq9FSCKvtPgEmXhjp8k2YEWvp2J6X77TaWFaL
         RY/D4rNwcmg5PkWmq0nXQL2vJPbZvc0663fDzhtd7De7EVfDy3j63+fQDJlB/HIVNi
         iIpDRSgNYG8Yx32kXsDA95/Ukz8xzgpoXK4LByQEQMLWH7DZaDv5RopY5BjEgeSUIV
         OwOMYvG8hm3Sxw1AH2PxNSgZGbB/DM96D4U+rBNkl6JsLgJLU0G8zClHTqweo63IX7
         dH+a4i3/sEQ9g==
Date:   Tue, 17 Jan 2023 18:42:09 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Allison Henderson <allison.henderson@oracle.com>
Cc:     Catherine Hoang <catherine.hoang@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Chandan Babu <chandan.babu@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 04/14] xfs: document the user interface for online fsck
Message-ID: <Y8dcge12A7FP9nrW@magnolia>
References: <167243825144.682859.12802259329489258661.stgit@magnolia>
 <167243825217.682859.14201039734624895373.stgit@magnolia>
 <4098826a3f69a53fd23df08eb8ffbb733d7f75ce.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4098826a3f69a53fd23df08eb8ffbb733d7f75ce.camel@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:03:29AM +0000, Allison Henderson wrote:
> On Fri, 2022-12-30 at 14:10 -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Start the fourth chapter of the online fsck design documentation,
> > which
> > discusses the user interface and the background scrubbing service.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  114
> > ++++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> > 
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst
> > b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index d630b6bdbe4a..42e82971e036 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -750,3 +750,117 @@ Proposed patchsets include `general stress
> > testing
> >  <
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.g
> > it/log/?h=race-scrub-and-mount-state-changes>`_
> >  and the `evolution of existing per-function stress testing
> >  <
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.g
> > it/log/?h=refactor-scrub-stress>`_.
> > +
> > +4. User Interface
> > +=================
> > +
> > +The primary user of online fsck is the system administrator, just
> > like offline
> > +repair.
> > +Online fsck presents two modes of operation to administrators:
> > +A foreground CLI process for online fsck on demand, and a background
> > service
> > +that performs autonomous checking and repair.
> > +
> > +Checking on Demand
> > +------------------
> > +
> > +For administrators who want the absolute freshest information about
> > the
> > +metadata in a filesystem, ``xfs_scrub`` can be run as a foreground
> > process on
> > +a command line.
> > +The program checks every piece of metadata in the filesystem while
> > the
> > +administrator waits for the results to be reported, just like the
> > existing
> > +``xfs_repair`` tool.
> > +Both tools share a ``-n`` option to perform a read-only scan, and a
> > ``-v``
> > +option to increase the verbosity of the information reported.
> > +
> > +A new feature of ``xfs_scrub`` is the ``-x`` option, which employs
> > the error
> > +correction capabilities of the hardware to check data file contents.
> > +The media scan is not enabled by default because it may dramatically
> > increase
> > +program runtime and consume a lot of bandwidth on older storage
> > hardware.
> > +
> > +The output of a foreground invocation is captured in the system log.
> > +
> > +The ``xfs_scrub_all`` program walks the list of mounted filesystems
> > and
> > +initiates ``xfs_scrub`` for each of them in parallel.
> > +It serializes scans for any filesystems that resolve to the same top
> > level
> > +kernel block device to prevent resource overconsumption.
> > +
> > +Background Service
> > +------------------
> > +
> I'm assuming the below systemd services are configurable right?

Yes, through the standard systemd overriddes.

> > +To reduce the workload of system administrators, the ``xfs_scrub``
> > package
> > +provides a suite of `systemd <https://systemd.io/>`_ timers and
> > services that
> > +run online fsck automatically on weekends.
> by default.

Fixed.

> > +The background service configures scrub to run with as little
> > privilege as
> > +possible, the lowest CPU and IO priority, and in a CPU-constrained
> > single
> > +threaded mode.
> "This can be tuned at anytime to best suit the needs of the customer
> workload."

Fixed.

> Then I think you can drop the below line...
> > +It is hoped that this minimizes the amount of load generated on the
> > system and
> > +avoids starving regular workloads.

Done.

> > +The output of the background service is also captured in the system
> > log.
> > +If desired, reports of failures (either due to inconsistencies or
> > mere runtime
> > +errors) can be emailed automatically by setting the ``EMAIL_ADDR``
> > environment
> > +variable in the following service files:
> > +
> > +* ``xfs_scrub_fail@.service``
> > +* ``xfs_scrub_media_fail@.service``
> > +* ``xfs_scrub_all_fail.service``
> > +
> > +The decision to enable the background scan is left to the system
> > administrator.
> > +This can be done by enabling either of the following services:
> > +
> > +* ``xfs_scrub_all.timer`` on systemd systems
> > +* ``xfs_scrub_all.cron`` on non-systemd systems
> > +
> > +This automatic weekly scan is configured out of the box to perform
> > an
> > +additional media scan of all file data once per month.
> > +This is less foolproof than, say, storing file data block checksums,
> > but much
> > +more performant if application software provides its own integrity
> > checking,
> > +redundancy can be provided elsewhere above the filesystem, or the
> > storage
> > +device's integrity guarantees are deemed sufficient.
> > +
> > +The systemd unit file definitions have been subjected to a security
> > audit
> > +(as of systemd 249) to ensure that the xfs_scrub processes have as
> > little
> > +access to the rest of the system as possible.
> > +This was performed via ``systemd-analyze security``, after which
> > privileges
> > +were restricted to the minimum required, sandboxing was set up to
> > the maximal
> > +extent possible with sandboxing and system call filtering; and
> > access to the
> > +filesystem tree was restricted to the minimum needed to start the
> > program and
> > +access the filesystem being scanned.
> > +The service definition files restrict CPU usage to 80% of one CPU
> > core, and
> > +apply as nice of a priority to IO and CPU scheduling as possible.
> > +This measure was taken to minimize delays in the rest of the
> > filesystem.
> > +No such hardening has been performed for the cron job.
> > +
> > +Proposed patchset:
> > +`Enabling the xfs_scrub background service
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.g
> > it/log/?h=scrub-media-scan-service>`_.
> > +
> > +Health Reporting
> > +----------------
> > +
> > +XFS caches a summary of each filesystem's health status in memory.
> > +The information is updated whenever ``xfs_scrub`` is run, or
> > whenever
> > +inconsistencies are detected in the filesystem metadata during
> > regular
> > +operations.
> > +System administrators should use the ``health`` command of
> > ``xfs_spaceman`` to
> > +download this information into a human-readable format.
> > +If problems have been observed, the administrator can schedule a
> > reduced
> > +service window to run the online repair tool to correct the problem.
> > +Failing that, the administrator can decide to schedule a maintenance
> > window to
> > +run the traditional offline repair tool to correct the problem.
> > +
> > +**Question**: Should the health reporting integrate with the new
> > inotify fs
> > +error notification system?
> > +
> > +**Question**: Would it be helpful for sysadmins to have a daemon to
> > listen for
> > +corruption notifications and initiate a repair?
> > +
> > +*Answer*: These questions remain unanswered, but should be a part of
> > the
> > +conversation with early adopters and potential downstream users of
> > XFS.
> I think if there's been no commentary at this point then likely they
> can't be answered at this time.  Perhaps for now it is reasonable to
> just let the be a potential improvement in the future if the demand for
> it arises. In any case, I think we should probably clean out the Q&A
> discussion prompts.

I'll change them to "future work Q's" so I don't forget to pursue them
after part 1 is merged.

> Rest looks good tho

:-D  Thanks!

--D

> Allison
> 
> > +
> > +Proposed patchsets include
> > +`wiring up health reports to correction returns
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=corruption-health-reports>`_
> > +and
> > +`preservation of sickness info during memory reclaim
> > +<
> > https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/
> > log/?h=indirect-health-reporting>`_.
> > 
> 
