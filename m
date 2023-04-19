Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE06E8038
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjDSRTK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjDSRTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:19:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBF67AA1;
        Wed, 19 Apr 2023 10:19:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BF4463B69;
        Wed, 19 Apr 2023 17:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB9EC433D2;
        Wed, 19 Apr 2023 17:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681924746;
        bh=Jn2bDE/AiC/C5l1xHvCadqv/n3u1woFUW6d117MZ/R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYhtDNKq0O6I39tdZKi68ph54dC58iJXYdKG+aR0an0grsbfMblyXuJlXZT+dIE2t
         hJfBwlC8311k/1DLleqSirI2g8vCppgV+8vq//IF0B7Zsdp/WRRekoLxJPZw4JTOvo
         tkcD+YeeCGrZ+vG2LLJaozhz7IETH7o+DNvAaKXsosy+DdTVAW/O3bKHASBhrapAp7
         g9ozYAjltLq8FOs6JNN1Oo8N+2DbMDcpXgF7GlmMOIqy38E3uMF8YOF3uFCNd+SSnO
         wQ3PLlQyj7O1UBzigKGcpefa4Y9O01o8ISSI00eo6qIHMBvuf3VCrJKu/Co2cpqiwp
         p7r5D2r5fPlcg==
Date:   Wed, 19 Apr 2023 19:19:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
Message-ID: <20230419-besungen-filzen-adad4a1f3247@brauner>
References: <20230414182903.1852019-1-amir73il@gmail.com>
 <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
 <CAOQ4uxj5UwDhV7XxWZ-Os+fzM=_N1DDWHpjmt6UnHr96EDriMw@mail.gmail.com>
 <20230418-absegnen-sputen-11212a0615c7@brauner>
 <CAOQ4uxgM2x93UKcJ5D5tfoTt8s0ChTrEheTGqTcndGoyGwS=7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgM2x93UKcJ5D5tfoTt8s0ChTrEheTGqTcndGoyGwS=7w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 06:20:22PM +0300, Amir Goldstein wrote:
> On Tue, Apr 18, 2023 at 5:12 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Apr 18, 2023 at 04:56:40PM +0300, Amir Goldstein wrote:
> > > On Tue, Apr 18, 2023 at 4:33 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Fri, Apr 14, 2023 at 09:29:01PM +0300, Amir Goldstein wrote:
> > > > > Jan,
> > > > >
> > > > > Followup on my quest to close the gap with inotify functionality,
> > > > > here is a proposal for FAN_UNMOUNT event.
> > > > >
> > > > > I have had many design questions about this:
> > > >
> > > > I'm going to humbly express what I feel makes sense to me when looking
> > > > at this from a user perspective:
> > > >
> > > > > 1) Should we also report FAN_UNMOUNT for marked inodes and sb
> > > > >    on sb shutdown (same as IN_UNMOUNT)?
> > > >
> > > > My preference would be if this would be a separate event type.
> > > > FAN_SB_SHUTDOWN or something.
> > >
> > > If we implement an event for this at all, I would suggest FAN_IGNORED
> > > or FAN_EVICTED, which has the same meaning as IN_IGNORED.
> > > When you get an event that the watch went away, it could be because of:
> > > 1. watch removed by user
> > > 2. watch removed because inode was evicted (with FAN_MARK_EVICTABLE)
> > > 3. inode deleted
> > > 4. sb shutdown
> > >
> > > IN_IGNORED is generated in all of the above except for inode evict
> > > that is not possible with inotify.
> > >
> > > User can figure out on his own if the inode was deleted or if fs was unmounted,
> > > so there is not really a need for FAN_SB_SHUTDOWN IMO.
> >
> > Ok, sounds good.
> >
> > >
> > > Actually, I think that FAN_IGNORED would be quite useful for the
> > > FAN_MARK_EVICTABLE case, but it is a bit less trivial to implement
> > > than FAN_UNMOUNT was.
> > >
> > > >
> > > > > 2) Should we also report FAN_UNMOUNT on sb mark for any unmounts
> > > > >    of that sb?
> > > >
> > > > I don't think so. It feels to me that if you watch an sb you don't
> > > > necessarily want to watch bind mounts of that sb.
> > > >
> > > > > 3) Should we report also the fid of the mount root? and if we do...
> > > > > 4) Should we report/consider FAN_ONDIR filter?
> > > > >
> > > > > All of the questions above I answered "not unless somebody requests"
> > > > > in this first RFC.
> > > >
> > > > Fwiw, I agree.
> > > >
> > > > >
> > > > > Specifically, I did get a request for an unmount event for containers
> > > > > use case.
> > > > >
> > > > > I have also had doubts regarding the info records.
> > > > > I decided that reporting fsid and mntid is minimum, but couldn't
> > > > > decide if they were better of in a single MNTID record or seprate
> > > > > records.
> > > > >
> > > > > I went with separate records, because:
> > > > > a) FAN_FS_ERROR has set a precendent of separate fid record with
> > > > >    fsid and empty fid, so I followed this precendent
> > > > > b) MNTID record we may want to add later with FAN_REPORT_MNTID
> > > > >    to all the path events, so better that it is independent
> > > >
> > >
> > > Just thought of another reason:
> > >  c) FAN_UNMOUNT does not need to require FAN_REPORT_FID
> > >      so it does not depend on filesystem having a valid f_fsid nor
> > >      exports_ops. In case of "pseudo" fs, FAN_UNMOUNT can report
> > >      only MNTID record (I will amend the patch with this minor change).
> >
> > I see some pseudo fses generate f_fsid, e.g., tmpfs in mm/shmem.c
> 
> tmpfs is not "pseudo" in my eyes, because it implements a great deal of the
> vfs interfaces, including export_ops.

The term "pseudo" is somewhat well-defined though, no? It really just
means that there's no backing device associated with it. So for example,
anything that uses get_tree_nodev() including tmpfs. If erofs is
compiled with fscache support it's even a pseudo fs (TIL).

> 
> and also I fixed its f_fsid recently:
> 59cda49ecf6c shmem: allow reporting fanotify events with file handles on tmpfs

Well thank you for that this has been very useful in userspace already
I've been told.

> 
> > At the risk of putting my foot in my mouth, what's stopping us from
> > making them all support f_fsid?
> 
> Nothing much. Jan had the same opinion [1].

I think that's what we should try to do without having thought too much
about potential edge-cases.

> 
> We could do either:
> 1. use uuid_to_fsid() in vfs_statfs() if fs has set s_uuid and not set f_fsid
> 2. use s_dev as f_fsid in vfs_statfs() if fs did not set f_fsid nor s_uuid
> 3. randomize s_uuid for simple fs (like tmpfs)
> 4. any combination of the above and more
> 
> Note that we will also need to decide what to do with
> name_to_handle_at() for those pseudo fs.

Doing it on the fly during vfs_statfs() feels a bit messy and could
cause bugs. One should never underestimate the possibility that there's
some fs that somehow would get into trouble because of odd behavior.

So switching each fs over to generate a s_uuid seems the prudent thing
to do. Doing it the hard way also forces us to make sure that each
filesystem can deal with this.

It seems that for pseudo fses we can just allocate a new s_uuid for each
instance. So each tmpfs instance - like your patch did - would just get
a new s_uuid.

For kernel internal filesystems - mostly those that use init_pseudo -
the s_uuid would remain stable until the next reboot when it is
regenerated.

Looking around just a little there's some block-backed fses like fat
that have an f_fsid but no s_uuid. So if we give those s_uuid then it'll
mean that the f_fsid isn't generated based on the s_uuid. That should be
ok though and shouldn't matter to userspace.

Afterwards we could probably lift the ext4 and xfs specific ioctls to
retrieve the s_uuid into a generic ioctl to allow userspace to get the
s_uuid.

That's my thinking without having crawled to all possible corner
cases... Also needs documenting that s_uuid is not optional anymore and
explain the difference between pseudo and device-backed fses. I hope
that's not completely naive...

> 
> Quoting Jan from [1]:
> "But otherwise the proposal to make name_to_handle_at() work even for
> filesystems not exportable through NFS makes sense to me. But I guess we
> need some buy-in from VFS maintainers for this." (hint hint).
> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20230417162721.ouzs33oh6mb7vtft@quack3/
