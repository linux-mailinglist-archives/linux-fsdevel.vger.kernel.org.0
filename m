Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A486E582D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 06:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDREqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 00:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDREqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD24272C;
        Mon, 17 Apr 2023 21:46:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A401C62227;
        Tue, 18 Apr 2023 04:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5A4C433EF;
        Tue, 18 Apr 2023 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681793202;
        bh=NCtkKHv/36bYUk97UIcBuSh1o3C0lTseScm0jINFwBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UikzA5VyRf45JNOup1D9xUDtl98cZqrGKGWwBCNJm6vQszT6sU7eD89zGblKlQ+1x
         hRRRq08+swRu3Z35wYCPCZ1d1vus23PL4Lpr8PbCMqCWy7dJVz5CWmeVOgpuakY2HA
         tjWFuervtYaSpXz61I59Asgn1/BXxQNmclS+rllTkThcLQSv6/0Cp1PYjFQKyKhMX9
         5qMw7D5zSIQfVtYQmEeTvgsejZ8qVx5vWNYyknNnP5nhTGdtNa6rgDJNnC150cacrr
         pVeJpsgJANi6WduSM3omrW59nzhqxw1UcMY9e9F5U72UxQRmACxYcwPhK1Z5io1o3T
         IJOX9ml32ClQA==
Date:   Mon, 17 Apr 2023 21:46:41 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        xfs <linux-xfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF TOPIC] online repair of filesystems: what next?
Message-ID: <20230418044641.GD360881@frogsfrogsfrogs>
References: <Y/5ovz6HI2Z47jbk@magnolia>
 <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj6mNbGQBSpg-KpSiDa2UugBFXki4HhM4DPvXeAQMnRWg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 15, 2023 at 03:18:05PM +0300, Amir Goldstein wrote:
> On Tue, Feb 28, 2023 at 10:49 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > Hello fsdevel people,
> >
> > Five years ago[0], we started a conversation about cross-filesystem
> > userspace tooling for online fsck.  I think enough time has passed for
> > us to have another one, since a few things have happened since then:
> >
> > 1. ext4 has gained the ability to send corruption reports to a userspace
> >    monitoring program via fsnotify.  Thanks, Collabora!
> >
> > 2. XFS now tracks successful scrubs and corruptions seen during runtime
> >    and during scrubs.  Userspace can query this information.
> >
> > 3. Directory parent pointers, which enable online repair of the
> >    directory tree, is nearing completion.
> >
> > 4. Dave and I are working on merging online repair of space metadata for
> >    XFS.  Online repair of directory trees is feature complete, but we
> >    still have one or two unresolved questions in the parent pointer
> >    code.
> >
> > 5. I've gotten a bit better[1] at writing systemd service descriptions
> >    for scheduling and performing background online fsck.
> >
> > Now that fsnotify_sb_error exists as a result of (1), I think we
> > should figure out how to plumb calls into the readahead and writeback
> > code so that IO failures can be reported to the fsnotify monitor.  I
> > suspect there may be a few difficulties here since fsnotify (iirc)
> > allocates memory and takes locks.
> >
> > As a result of (2), XFS now retains quite a bit of incore state about
> > its own health.  The structure that fsnotify gives to userspace is very
> > generic (superblock, inode, errno, errno count).  How might XFS export
> > a greater amount of information via this interface?  We can provide
> > details at finer granularity -- for example, a specific data structure
> > under an allocation group or an inode, or specific quota records.
> >
> > With (4) on the way, I can envision wanting a system service that would
> > watch for these fsnotify events, and transform the error reports into
> > targeted repair calls in the kernel.  This of course would be very
> > filesystem specific, but I would also like to hear from anyone pondering
> > other usecases for fsnotify filesystem error monitors.
> >
> > Once (3) lands, XFS gains the ability to translate a block device IO
> > error to an inode number and file offset, and then the inode number to a
> > path.  In other words, your file breaks and now we can tell applications
> > which file it was so they can failover or redownload it or whatever.
> > Ric Wheeler mentioned this in 2018's session.
> >
> > The final topic from that 2018 session concerned generic wrappers for
> > fsscrub.  I haven't pushed hard on that topic because XFS hasn't had
> > much to show for that.  Now that I'm better versed in systemd services,
> > I envision three ways to interact with online fsck:
> >
> > - A CLI program that can be run by anyone.
> >
> > - Background systemd services that fire up periodically.
> >
> > - A dbus service that programs can bind to and request a fsck.
> >
> > I still think there's an opportunity to standardize the naming to make
> > it easier to use a variety of filesystems.  I propose for the CLI:
> >
> > /usr/sbin/fsscrub $mnt that calls /usr/sbin/fsscrub.$FSTYP $mnt
> >
> > For systemd services, I propose "fsscrub@<escaped mountpoint>".  I
> > suspect we want a separate background service that itself runs
> > periodically and invokes the fsscrub@$mnt services.  xfsprogs already
> > has a xfs_scrub_all service that does that.  The services are nifty
> > because it's really easy to restrict privileges, implement resource
> > usage controls, and use private name/mountspaces to isolate the process
> > from the rest of the system.
> >
> > dbus is a bit trickier, since there's no precedent at all.  I guess
> > we'd have to define an interface for filesystem "object".  Then we could
> > write a service that establishes a well-known bus name and maintains
> > object paths for each mounted filesystem.  Each of those objects would
> > export the filesystem interface, and that's how programs would call
> > online fsck as a service.
> >
> > Ok, that's enough for a single session topic.  Thoughts? :)
> 
> Darrick,
> 
> Quick question.
> You indicated that you would like to discuss the topics:
> Atomic file contents exchange
> Atomic directio writes

This one ^^^^^^^^ topic should still get its own session, ideally with
Martin Petersen and John Garry running it.  A few cloud vendors'
software defined storage stacks can support multi-lba atomic writes, and
some database software could take advantage of that to reduce nested WAL
overhead.

> Are those intended to be in a separate session from online fsck?
> Both in the same session?
> 
> I know you posted patches for FIEXCHANGE_RANGE [1],
> but they were hiding inside a huge DELUGE and people
> were on New Years holidays, so nobody commented.

After 3 years of sparse review comments, I decided to withdraw
FIEXCHANGE_RANGE from general consideration after realizing that very
few filesystems actually have the infrastructure to support atomic file
contents exchange, hence there's little to be gained from undertaking
fsdevel bikeshedding.

> Perhaps you should consider posting an uptodate
> topic suggestion to let people have an opportunity to
> start a discussion before LSFMM.

TBH, most of my fs complaints these days are managerial problems (Are we
spending too much time on LTS?  How on earth do we prioritize projects
with all these drive by bots??  Why can't we support large engineering
efforts better???) than technical.

(I /am/ willing to have a "Online fs metadata reconstruction: How does
it work, and can I have some of what you're smoking?" BOF tho)

--D

> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/167243843494.699466.5163281976943635014.stgit@magnolia/
