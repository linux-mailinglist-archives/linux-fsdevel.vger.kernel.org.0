Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00AB595349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 09:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiHPHDm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 03:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiHPHDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:03:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C187C515;
        Mon, 15 Aug 2022 19:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8805B8112C;
        Tue, 16 Aug 2022 02:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A7CC433C1;
        Tue, 16 Aug 2022 02:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660617016;
        bh=o/dgEp6rbBAETLpl5LAQ0rTHgbw6cR0xQc7hWgSeR0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzkDzXVjLQzwkMTz2NRz0r6sMz/rmuYTsWeALg2eUxGdxmNI/jlqHdiwtwhRAvI/p
         KS3YD8U2RDNvHpqBlwg9a/oG60eq3ZIQx0MPQH9k7te6jP+zBhBQzI5Sd9dzwtlybV
         YeUA9a4g61ezHpqCEACFG42Z5z7W3MjEYSI81ohbdNHv1VbNqUqBF0zsF6ib+TQ5mj
         aO4pEre6JCg7LMAgZiehQPVj0IhIjumWBunsnV9drfoxKmAF2JUGsVKOvOC76yQ+Gf
         72Hf7f1FzPHdyHUx5wgNmHPNeWJPp+p3+GkXmcKhm3NfahPPejF5v39x/tpeRpzuhX
         Vtfk9Qx28rllw==
Date:   Mon, 15 Aug 2022 19:30:15 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        chandan.babu@oracle.com, allison.henderson@oracle.com,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        catherine.hoang@oracle.com
Subject: Re: [PATCH 04/14] xfs: document the user interface for online fsck
Message-ID: <YvsBNxpwTYw2SpJt@magnolia>
References: <165989700514.2495930.13997256907290563223.stgit@magnolia>
 <165989702796.2495930.11103527352292676325.stgit@magnolia>
 <20220811002012.GO3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811002012.GO3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 11, 2022 at 10:20:12AM +1000, Dave Chinner wrote:
> On Sun, Aug 07, 2022 at 11:30:28AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Start the fourth chapter of the online fsck design documentation, which
> > discusses the user interface and the background scrubbing service.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  .../filesystems/xfs-online-fsck-design.rst         |  114 ++++++++++++++++++++
> >  1 file changed, 114 insertions(+)
> > 
> > 
> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
> > index d630b6bdbe4a..42e82971e036 100644
> > --- a/Documentation/filesystems/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs-online-fsck-design.rst
> > @@ -750,3 +750,117 @@ Proposed patchsets include `general stress testing
> >  <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=race-scrub-and-mount-state-changes>`_
> >  and the `evolution of existing per-function stress testing
> >  <https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-scrub-stress>`_.
> > +
> > +4. User Interface
> > +=================
> > +
> > +The primary user of online fsck is the system administrator, just like offline
> > +repair.
> > +Online fsck presents two modes of operation to administrators:
> > +A foreground CLI process for online fsck on demand, and a background service
> > +that performs autonomous checking and repair.
> > +
> > +Checking on Demand
> > +------------------
> > +
> > +For administrators who want the absolute freshest information about the
> > +metadata in a filesystem, ``xfs_scrub`` can be run as a foreground process on
> > +a command line.
> > +The program checks every piece of metadata in the filesystem while the
> > +administrator waits for the results to be reported, just like the existing
> > +``xfs_repair`` tool.
> > +Both tools share a ``-n`` option to perform a read-only scan, and a ``-v``
> > +option to increase the verbosity of the information reported.
> > +
> > +A new feature of ``xfs_scrub`` is the ``-x`` option, which employs the error
> > +correction capabilities of the hardware to check data file contents.
> > +The media scan is not enabled by default because it may dramatically increase
> > +program runtime and consume a lot of bandwidth on older storage hardware.
> 
> So '-x' runs a media scrub command? What does that do with software
> RAID?

Nothing special unless the RAID controller itself does parity checking
of reads -- the kernel doesn't have any API calls (that I know of) to do
that.  I think md-raid5 will check the parity, but afaict nothing else
(raid1) does that.

> Does that trigger parity checks of the RAID volume, or pass
> through to the underlying hardware to do physical media scrub?

Chaitanya proposed a userspace api so that xfs_scrub could actually ask
the hardware to perform a media verification[1], but willy pointed out
that it none of the device protocols have a means for the device to
prove that it did anything, so it stalled.

[1] https://lore.kernel.org/linux-fsdevel/20220713072019.5885-1-kch@nvidia.com/

> Or maybe both?

I wish. :)

> Rewriting the paragraph to be focussed around the functionality
> being provided (i.e "media scrubbing is a new feature of xfs_scrub.
> It provides .....")

Er.. you're doing that, or asking me to do it?

> > +The output of a foreground invocation is captured in the system log.
> 
> At what log level?

That depends on the message, but right now it only uses
LOG_{ERR,WARNING,INFO}.

Errors, corruptions, and unfixable problems are LOG_ERR.

Warnings are LOG_WARNING.

Notices of infomration, repairs completed, and optimizations made are
all recorded with LOG_INFO.

> > +The ``xfs_scrub_all`` program walks the list of mounted filesystems and
> > +initiates ``xfs_scrub`` for each of them in parallel.
> > +It serializes scans for any filesystems that resolve to the same top level
> > +kernel block device to prevent resource overconsumption.
> 
> Is this serialisation necessary for non-HDD devices?

That ultimately depends on the preferences of the sysadmins, but for the
initial push I'd rather err on the side of using fewer iops on a running
system.

> > +Background Service
> > +------------------
> > +
> > +To reduce the workload of system administrators, the ``xfs_scrub`` package
> > +provides a suite of `systemd <https://systemd.io/>`_ timers and services that
> > +run online fsck automatically on weekends.
> 
> Weekends change depending on where you are in the world, right? So
> maybe this should be more explicit?

Sunday at 3:10am, whenever that is in the local time zone.

> [....]
> 
> > +**Question**: Should the health reporting integrate with the new inotify fs
> > +error notification system?
> 
> Can the new inotify fs error notification system report complex
> health information structures?

In theory, yes, said the authors.

> How much pain is involved in making
> it do what we want, considering we already have a health reporting
> ioctl that can be polled?

I haven't tried this myself, but I think it involves defining a new type
code and message length within the inotify system.  The last time I
looked at the netlink protocol, I /think/ I saw that it's the case that
the consuming programs will read the header, see that there's a type
code and a buffer length, and decide to use it or skip it.

That said, there were some size and GFP_ limits on what could be sent,
so I don't know how difficult it would be to make this part actually
work in practice.  Gabriel said it wouldn't be too difficult once I was
ready.

> > +**Question**: Would it be helpful for sysadmins to have a daemon to listen for
> > +corruption notifications and initiate a repair?
> 
> Seems like an obvious extension to the online repair capability.

...too bad there are dragons thataways.

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
