Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48646A60A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjB1UtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 15:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjB1UtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:49:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8C0CA18;
        Tue, 28 Feb 2023 12:49:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 555DCB80E4D;
        Tue, 28 Feb 2023 20:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B22CC433EF;
        Tue, 28 Feb 2023 20:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677617344;
        bh=exxFF2JJICCNFK4dOi3fq/MWs7vdRA0W94WXLIxiaMA=;
        h=Date:From:To:Cc:Subject:From;
        b=NZLHVaPnPIL+PcCxdhDP46plItvfQj7yFr8kk5jUnG8tfTZnLRiCE2atNh2jEO1mC
         hwKWANLAyuemrRVo40f3+hH8lnnO6oONMjMIQBb0pcGFlwCQ38+IqNOy2Ynfiq0wE/
         ZWyIkNSaNqv+00IJ7pr9TNvZFvBhAjRTiyqOay+tiXGcyspYSh/YTlOemBJ6vhF60U
         KF+AG0r44DFOPaZWwTkj+Vz00gYzN3fLS0B8IbciRpvneN4MQsMVw1ienOXR6jvH64
         Sl7yx9dV4/k+4P6NkgYMEdnpbjA4I/6JtJlFYt6xB1whghPS3Wick9MirMW+h3aiFr
         GB6rdk5692G2Q==
Date:   Tue, 28 Feb 2023 12:49:03 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: [LSF TOPIC] online repair of filesystems: what next?
Message-ID: <Y/5ovz6HI2Z47jbk@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello fsdevel people,

Five years ago[0], we started a conversation about cross-filesystem
userspace tooling for online fsck.  I think enough time has passed for
us to have another one, since a few things have happened since then:

1. ext4 has gained the ability to send corruption reports to a userspace
   monitoring program via fsnotify.  Thanks, Collabora!

2. XFS now tracks successful scrubs and corruptions seen during runtime
   and during scrubs.  Userspace can query this information.

3. Directory parent pointers, which enable online repair of the
   directory tree, is nearing completion.

4. Dave and I are working on merging online repair of space metadata for
   XFS.  Online repair of directory trees is feature complete, but we
   still have one or two unresolved questions in the parent pointer
   code.

5. I've gotten a bit better[1] at writing systemd service descriptions
   for scheduling and performing background online fsck.

Now that fsnotify_sb_error exists as a result of (1), I think we
should figure out how to plumb calls into the readahead and writeback
code so that IO failures can be reported to the fsnotify monitor.  I
suspect there may be a few difficulties here since fsnotify (iirc)
allocates memory and takes locks.

As a result of (2), XFS now retains quite a bit of incore state about
its own health.  The structure that fsnotify gives to userspace is very
generic (superblock, inode, errno, errno count).  How might XFS export
a greater amount of information via this interface?  We can provide
details at finer granularity -- for example, a specific data structure
under an allocation group or an inode, or specific quota records.

With (4) on the way, I can envision wanting a system service that would
watch for these fsnotify events, and transform the error reports into
targeted repair calls in the kernel.  This of course would be very
filesystem specific, but I would also like to hear from anyone pondering
other usecases for fsnotify filesystem error monitors.

Once (3) lands, XFS gains the ability to translate a block device IO
error to an inode number and file offset, and then the inode number to a
path.  In other words, your file breaks and now we can tell applications
which file it was so they can failover or redownload it or whatever.
Ric Wheeler mentioned this in 2018's session.

The final topic from that 2018 session concerned generic wrappers for
fsscrub.  I haven't pushed hard on that topic because XFS hasn't had
much to show for that.  Now that I'm better versed in systemd services,
I envision three ways to interact with online fsck:

- A CLI program that can be run by anyone.

- Background systemd services that fire up periodically.

- A dbus service that programs can bind to and request a fsck.

I still think there's an opportunity to standardize the naming to make
it easier to use a variety of filesystems.  I propose for the CLI:

/usr/sbin/fsscrub $mnt that calls /usr/sbin/fsscrub.$FSTYP $mnt

For systemd services, I propose "fsscrub@<escaped mountpoint>".  I
suspect we want a separate background service that itself runs
periodically and invokes the fsscrub@$mnt services.  xfsprogs already
has a xfs_scrub_all service that does that.  The services are nifty
because it's really easy to restrict privileges, implement resource
usage controls, and use private name/mountspaces to isolate the process
from the rest of the system.

dbus is a bit trickier, since there's no precedent at all.  I guess
we'd have to define an interface for filesystem "object".  Then we could
write a service that establishes a well-known bus name and maintains
object paths for each mounted filesystem.  Each of those objects would
export the filesystem interface, and that's how programs would call
online fsck as a service.

Ok, that's enough for a single session topic.  Thoughts? :)

--D

[0] https://lwn.net/Articles/754504/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=scrub-optimize-by-default
