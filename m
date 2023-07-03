Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35FA745750
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 10:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGCI2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 04:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGCI2F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 04:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4F0DD
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 01:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03AD660E15
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jul 2023 08:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BBBC433C8;
        Mon,  3 Jul 2023 08:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688372883;
        bh=DJWW6hv/2OAgIMjbyjjSut9K3l2UlcBoWz8CEjxQDoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwhTRgUL20q4r10CSn6Ui8M8zNGeLiHwFUOOCd/0IWpSeu62ZChZShPsKa/Oq1MNh
         Y1XXmCivJWDdafPKyAGqYsNGNF8dG6Pt/dowYaSQznhxS+7usXaX0wpvOh5EtGPLRi
         OldECYqYEE40pzvZoSW7rnIerAXmJKStHHzToEhIxoVJx23FhWfUgbaKagsWqjI9Sa
         GhIWy3GRD5WfWMQMMaSsuPnc/8wrwwwbmcUMdjm5luxaV22cDvE0J48QNfhBuPwEYf
         RWgMC82J9P7eqUZ4lNOkpYocfUiHNNDsIcQSwzEmLAIgNVTksqS2oytMKiauv+CkRT
         fWvhMvrg/7Slg==
Date:   Mon, 3 Jul 2023 10:27:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel
 internal pseudo fs
Message-ID: <20230703-zutreffen-zertifikat-92d8fa74dc3e@brauner>
References: <20230629042044.25723-1-amir73il@gmail.com>
 <20230630-kitzeln-sitzt-c6b4325362e5@brauner>
 <CAOQ4uxheb7z=5ricKUz7JduQGVbxNRp-FNrViMtd0Dy6cAgOnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxheb7z=5ricKUz7JduQGVbxNRp-FNrViMtd0Dy6cAgOnQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 01, 2023 at 07:25:14PM +0300, Amir Goldstein wrote:
> On Fri, Jun 30, 2023 at 10:29 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Thu, Jun 29, 2023 at 07:20:44AM +0300, Amir Goldstein wrote:
> > > Hopefully, nobody is trying to abuse mount/sb marks for watching all
> > > anonymous pipes/inodes.
> > >
> > > I cannot think of a good reason to allow this - it looks like an
> > > oversight that dated back to the original fanotify API.
> > >
> > > Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczxv2pm@quack3/
> > > Fixes: d54f4fba889b ("fanotify: add API to attach/detach super block mark")
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Jan,
> > >
> > > As discussed, allowing sb/mount mark on anonymous pipes
> > > makes no sense and we should not allow it.
> > >
> > > I've noted FAN_MARK_FILESYSTEM as the Fixes commit as a trigger to
> > > backport to maintained LTS kernels event though this dates back to day one
> > > with FAN_MARK_MOUNT. Not sure if we should keep the Fixes tag or not.
> > >
> > > The reason this is an RFC and that I have not included also the
> > > optimization patch is because we may want to consider banning kernel
> > > internal inodes from fanotify and/or inotify altogether.
> > >
> > > The tricky point in banning anonymous pipes from inotify, which
> > > could have existing users (?), but maybe not, so maybe this is
> > > something that we need to try out.
> > >
> > > I think we can easily get away with banning anonymous pipes from
> > > fanotify altogeter, but I would not like to get to into a situation
> > > where new applications will be written to rely on inotify for
> > > functionaly that fanotify is never going to have.
> > >
> > > Thoughts?
> > > Am I over thinking this?
> > >
> > > Amir.
> > >
> > >  fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index 95d7d8790bc3..8240a3fdbef0 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -1622,6 +1622,20 @@ static int fanotify_events_supported(struct fsnotify_group *group,
> > >           path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
> > >               return -EINVAL;
> > >
> > > +     /*
> > > +      * mount and sb marks are not allowed on kernel internal pseudo fs,
> > > +      * like pipe_mnt, because that would subscribe to events on all the
> > > +      * anonynous pipes in the system.
> >
> > s/anonynous/anonymous/
> >
> > > +      *
> > > +      * XXX: SB_NOUSER covers all of the internal pseudo fs whose objects
> > > +      * are not exposed to user's mount namespace, but there are other
> > > +      * SB_KERNMOUNT fs, like nsfs, debugfs, for which the value of
> > > +      * allowing sb and mount mark is questionable.
> > > +      */
> > > +     if (mark_type != FAN_MARK_INODE &&
> > > +         path->mnt->mnt_sb->s_flags & SB_NOUSER)
> > > +             return -EINVAL;
> >
> 
> On second thought, I am not sure about  the EINVAL error code here.
> I used the same error code that Jan used for permission events on
> proc fs, but the problem is that applications do not have a decent way
> to differentiate between
> "sb mark not supported by kernel" (i.e. < v4.20) vs.
> "sb mark not supported by fs" (the case above)
> 
> same for permission events:
> "kernel compiled without FANOTIFY_ACCESS_PERMISSIONS" vs.
> "permission events not supported by fs" (procfs)
> 
> I have looked for other syscalls that react to SB_NOUSER and I've
> found that mount also returns EINVAL.
> 
> So far, fanotify_mark() and fanotify_init() mostly return EINVAL
> for invalid flag combinations (also across the two syscalls),
> but not because of the type of object being marked, except for
> the special case of procfs and permission events.
> 
> mount(2) syscall OTOH, has many documented EINVAL cases
> due to the type of source object (e.g. propagation type shared).

Many is an understatement. There's so many EINVALs.

> 
> I know there is no standard and EINVAL can mean many
> different things in syscalls, but I thought that maybe EACCES
> would convey more accurately the message:
> "The sb/mount of this fs is not accessible for placing a mark".
> 
> WDYT? worth changing?

I think it's not crazy to use EACCES to let users figure out that the fs
isn't supported. It really depends on how useful that is.

> worth changing procfs also?

Not sure if people would be confused if they got EACCES suddenly but
then again, they could've never used it.

> We don't have that EINVAL for procfs documented in man page btw.
