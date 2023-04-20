Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185986E8BA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Apr 2023 09:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjDTHqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 03:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbjDTHq3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0267140F6;
        Thu, 20 Apr 2023 00:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0374163A52;
        Thu, 20 Apr 2023 07:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0046C433EF;
        Thu, 20 Apr 2023 07:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681976785;
        bh=wYo7yDBN5furC1kmQJhOjmje3ZrfuJc22xDctcedxts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SisjJi9UbXwKxY5yLEdip9iW0De1FwTySPxyRLd5F5eINrt6Qraxc4A8lvy+BEcUv
         HNjalx50qoBfiSTm8U1bntnEWVMBvsf+A7Lyi7mwcBF9GbxZqUuJQ5tN/6orbvkuH6
         Z+H/8NXxmmhGaK/KoF/yIr4zUlkgK27iiZcfoVynORX4dPeDx2lH/3j6u8J3Vcd7OV
         Db+QBg5zxeS7O7yPuA+uGxKU5h6edx1mhnGLeBD/0EOlt+zz9sD9ZNUdNnZojO5jk7
         iMcxFuDEjm5yBPW4lnubXQjzhO8Mp7k90ZGii2sqUzFJ9UPzTDchlBsILMrRVVjwOw
         e8xYyyclzRG5Q==
Date:   Thu, 20 Apr 2023 09:46:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
Message-ID: <20230420-funkverkehr-adler-7f6794bea737@brauner>
References: <20230414182903.1852019-1-amir73il@gmail.com>
 <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
 <CAOQ4uxj5UwDhV7XxWZ-Os+fzM=_N1DDWHpjmt6UnHr96EDriMw@mail.gmail.com>
 <20230418-absegnen-sputen-11212a0615c7@brauner>
 <CAOQ4uxgM2x93UKcJ5D5tfoTt8s0ChTrEheTGqTcndGoyGwS=7w@mail.gmail.com>
 <20230419-besungen-filzen-adad4a1f3247@brauner>
 <CAOQ4uxgPsxtNHgvETTUyYrguPmOBOK=jzRHgfivSDbbNPnzL2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgPsxtNHgvETTUyYrguPmOBOK=jzRHgfivSDbbNPnzL2w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 20, 2023 at 09:12:52AM +0300, Amir Goldstein wrote:
> On Wed, Apr 19, 2023 at 8:19 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Tue, Apr 18, 2023 at 06:20:22PM +0300, Amir Goldstein wrote:
> > > On Tue, Apr 18, 2023 at 5:12 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Tue, Apr 18, 2023 at 04:56:40PM +0300, Amir Goldstein wrote:
> > > > > On Tue, Apr 18, 2023 at 4:33 PM Christian Brauner <brauner@kernel.org> wrote:
> 
> [...]
> 
> > > > > Just thought of another reason:
> > > > >  c) FAN_UNMOUNT does not need to require FAN_REPORT_FID
> > > > >      so it does not depend on filesystem having a valid f_fsid nor
> > > > >      exports_ops. In case of "pseudo" fs, FAN_UNMOUNT can report
> > > > >      only MNTID record (I will amend the patch with this minor change).
> > > >
> > > > I see some pseudo fses generate f_fsid, e.g., tmpfs in mm/shmem.c
> > >
> > > tmpfs is not "pseudo" in my eyes, because it implements a great deal of the
> > > vfs interfaces, including export_ops.
> >
> > The term "pseudo" is somewhat well-defined though, no? It really just
> > means that there's no backing device associated with it. So for example,
> > anything that uses get_tree_nodev() including tmpfs. If erofs is
> > compiled with fscache support it's even a pseudo fs (TIL).
> >
> 
> Ok, "pseudo fs" is an ambiguous term.
> 
> For the sake of this discussion, let's refer to fs that use get_tree_nodev()
> "non-disk fs".
> 
> But as far as fsnotify is concerned, tmpfs is equivalent to xfs, because
> all of the changes are made by users via vfs.
> 
> Let's call fs where changes can occur not via vfs "remote fs", those
> include the network fs and some "internal fs" like the kernfs class of fs
> and the "simple fs" class of fs (i.e. simple_fill_super).
> 
> With all the remote fs, the behavior of fsnotify is (and has always been)
> undefined, that is, you can use inotify to subscribe for events and you
> never know what you will get when changes are not made via vfs.
> 
> Some people (hypothetical) may expect to watch nsfs for dying ns
> and may be disappointed to find out that they do not get the desired
> IN_DELETE event.
> 
> We have had lengthy discussions about remote fs change notifications
> with no clear decisions of the best API for them:
> https://lore.kernel.org/linux-fsdevel/20211025204634.2517-1-iangelak@redhat.com/
> 
> > >
> > > and also I fixed its f_fsid recently:
> > > 59cda49ecf6c shmem: allow reporting fanotify events with file handles on tmpfs
> >
> > Well thank you for that this has been very useful in userspace already
> > I've been told.
> >
> > >
> > > > At the risk of putting my foot in my mouth, what's stopping us from
> > > > making them all support f_fsid?
> > >
> > > Nothing much. Jan had the same opinion [1].
> >
> > I think that's what we should try to do without having thought too much
> > about potential edge-cases.
> >
> > >
> > > We could do either:
> > > 1. use uuid_to_fsid() in vfs_statfs() if fs has set s_uuid and not set f_fsid
> > > 2. use s_dev as f_fsid in vfs_statfs() if fs did not set f_fsid nor s_uuid
> > > 3. randomize s_uuid for simple fs (like tmpfs)
> > > 4. any combination of the above and more
> > >
> > > Note that we will also need to decide what to do with
> > > name_to_handle_at() for those pseudo fs.
> >
> > Doing it on the fly during vfs_statfs() feels a bit messy and could
> > cause bugs. One should never underestimate the possibility that there's
> > some fs that somehow would get into trouble because of odd behavior.
> >
> > So switching each fs over to generate a s_uuid seems the prudent thing
> > to do. Doing it the hard way also forces us to make sure that each
> > filesystem can deal with this.
> >
> > It seems that for pseudo fses we can just allocate a new s_uuid for each
> > instance. So each tmpfs instance - like your patch did - would just get
> > a new s_uuid.
> >
> > For kernel internal filesystems - mostly those that use init_pseudo -
> > the s_uuid would remain stable until the next reboot when it is
> > regenerated.
> >
> 
> I am fine with opt-in for every fs as long as we do not duplicate
> boilerplate code.
> An FS_ flag could be a simple way to opt-in for this generic behavior.
> 
> > Looking around just a little there's some block-backed fses like fat
> > that have an f_fsid but no s_uuid. So if we give those s_uuid then it'll
> > mean that the f_fsid isn't generated based on the s_uuid. That should be
> > ok though and shouldn't matter to userspace.
> >
> > Afterwards we could probably lift the ext4 and xfs specific ioctls to
> > retrieve the s_uuid into a generic ioctl to allow userspace to get the
> > s_uuid.
> >
> > That's my thinking without having crawled to all possible corner
> > cases... Also needs documenting that s_uuid is not optional anymore and
> > explain the difference between pseudo and device-backed fses. I hope
> > that's not completely naive...
> >
> 
> I don't think that the dichotomy of device-backed vs. pseudo is enough
> to describe the situation.
> 
> I think what needs to be better documented and annotated is what type
> of fsnotify services can be expected to work on a given fs.

You're looking at this solely from the angle of fanotify. In my earier
message I was looking at this as something that is generally useful.
Fanotify uses the s_uuid and f_fsid but they have value independent of
this.

> 
> Jan has already introduced FS_DISALLOW_NOTIFY_PERM to opt-out
> of permission events (for procfs).

That sounds like a decent solution.

> 
> Perhaps this could be generalized to s_type->fs_notify_supported_events
> or s_type->fs_notify_supported_features.
> 
> For example, if an fs opts-in to FAN_REPORT_FID, then it gets an auto
> allocated s_uuid and f_fsid if it did not fill them in fill_super and in statfs

This appears a layering violation to me. The s_uuid should be allocated
when the superblock is created just like tmpfs does it and not
retroactively/lazily when fanotify on the filesystem is reported.
