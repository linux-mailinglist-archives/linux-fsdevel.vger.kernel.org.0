Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7E746FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jul 2023 13:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjGDLTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jul 2023 07:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjGDLTK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:19:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E6199E
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jul 2023 04:18:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BCAB3227A5;
        Tue,  4 Jul 2023 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688469513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hye03PiA2kNMjv9ficz4Sho4/4UsihiFgkoDNSzas/Y=;
        b=uFCccE9IVg9ib8rYose53C9Y8t+594RLGMhHqmseSIZmBsJnDZy+5SYGkENgYM/KjIJyMK
        Y7VjC6m2xIPVxU00xML0PWsGlHHcLWjsZFretHzuGOCmzwLCEHbzz5NvXloAvh4mt7P0rE
        XSHaD+I5symFGztAQEbSw+R3Jcyq2Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688469513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hye03PiA2kNMjv9ficz4Sho4/4UsihiFgkoDNSzas/Y=;
        b=tJgwOqmJcf97hvewa7kcxKr2Fy6G3CBFy9QQ7JfVptc9Aigz7ce4abxBMfRpLYSmVwIrZS
        wHDbHq5M9k3ZiMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE268133F7;
        Tue,  4 Jul 2023 11:18:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Mah6KgkApGQ2DAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Jul 2023 11:18:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 33237A0722; Tue,  4 Jul 2023 13:18:33 +0200 (CEST)
Date:   Tue, 4 Jul 2023 13:18:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel
 internal pseudo fs
Message-ID: <20230704111833.c6yqnu5b6fhzit3k@quack3>
References: <20230629042044.25723-1-amir73il@gmail.com>
 <20230630-kitzeln-sitzt-c6b4325362e5@brauner>
 <CAOQ4uxheb7z=5ricKUz7JduQGVbxNRp-FNrViMtd0Dy6cAgOnQ@mail.gmail.com>
 <20230703112551.7fvcyibdxwtmjucf@quack3>
 <20230704-gedauert-beantragen-7334fb6b5cdf@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230704-gedauert-beantragen-7334fb6b5cdf@brauner>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 04-07-23 11:58:07, Christian Brauner wrote:
> On Mon, Jul 03, 2023 at 01:25:51PM +0200, Jan Kara wrote:
> > On Sat 01-07-23 19:25:14, Amir Goldstein wrote:
> > > On Fri, Jun 30, 2023 at 10:29 AM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Thu, Jun 29, 2023 at 07:20:44AM +0300, Amir Goldstein wrote:
> > > > > Hopefully, nobody is trying to abuse mount/sb marks for watching all
> > > > > anonymous pipes/inodes.
> > > > >
> > > > > I cannot think of a good reason to allow this - it looks like an
> > > > > oversight that dated back to the original fanotify API.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczxv2pm@quack3/
> > > > > Fixes: d54f4fba889b ("fanotify: add API to attach/detach super block mark")
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Jan,
> > > > >
> > > > > As discussed, allowing sb/mount mark on anonymous pipes
> > > > > makes no sense and we should not allow it.
> > > > >
> > > > > I've noted FAN_MARK_FILESYSTEM as the Fixes commit as a trigger to
> > > > > backport to maintained LTS kernels event though this dates back to day one
> > > > > with FAN_MARK_MOUNT. Not sure if we should keep the Fixes tag or not.
> > > > >
> > > > > The reason this is an RFC and that I have not included also the
> > > > > optimization patch is because we may want to consider banning kernel
> > > > > internal inodes from fanotify and/or inotify altogether.
> > > > >
> > > > > The tricky point in banning anonymous pipes from inotify, which
> > > > > could have existing users (?), but maybe not, so maybe this is
> > > > > something that we need to try out.
> > > > >
> > > > > I think we can easily get away with banning anonymous pipes from
> > > > > fanotify altogeter, but I would not like to get to into a situation
> > > > > where new applications will be written to rely on inotify for
> > > > > functionaly that fanotify is never going to have.
> > > > >
> > > > > Thoughts?
> > > > > Am I over thinking this?
> > > > >
> > > > > Amir.
> > > > >
> > > > >  fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
> > > > >  1 file changed, 14 insertions(+)
> > > > >
> > > > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > > > index 95d7d8790bc3..8240a3fdbef0 100644
> > > > > --- a/fs/notify/fanotify/fanotify_user.c
> > > > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > > > @@ -1622,6 +1622,20 @@ static int fanotify_events_supported(struct fsnotify_group *group,
> > > > >           path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
> > > > >               return -EINVAL;
> > > > >
> > > > > +     /*
> > > > > +      * mount and sb marks are not allowed on kernel internal pseudo fs,
> > > > > +      * like pipe_mnt, because that would subscribe to events on all the
> > > > > +      * anonynous pipes in the system.
> > > >
> > > > s/anonynous/anonymous/
> > > >
> > > > > +      *
> > > > > +      * XXX: SB_NOUSER covers all of the internal pseudo fs whose objects
> > > > > +      * are not exposed to user's mount namespace, but there are other
> > > > > +      * SB_KERNMOUNT fs, like nsfs, debugfs, for which the value of
> > > > > +      * allowing sb and mount mark is questionable.
> > > > > +      */
> > > > > +     if (mark_type != FAN_MARK_INODE &&
> > > > > +         path->mnt->mnt_sb->s_flags & SB_NOUSER)
> > > > > +             return -EINVAL;
> > > >
> > > 
> > > On second thought, I am not sure about  the EINVAL error code here.
> > > I used the same error code that Jan used for permission events on
> > > proc fs, but the problem is that applications do not have a decent way
> > > to differentiate between
> > > "sb mark not supported by kernel" (i.e. < v4.20) vs.
> > > "sb mark not supported by fs" (the case above)
> > > 
> > > same for permission events:
> > > "kernel compiled without FANOTIFY_ACCESS_PERMISSIONS" vs.
> > > "permission events not supported by fs" (procfs)
> > > 
> > > I have looked for other syscalls that react to SB_NOUSER and I've
> > > found that mount also returns EINVAL.
> > 
> > We tend to return EINVAL both for invalid (combination of) flags as well as
> > for flags applied to invalid objects in various calls. In practice there is
> > rarely a difference.
> > 
> > > So far, fanotify_mark() and fanotify_init() mostly return EINVAL
> > > for invalid flag combinations (also across the two syscalls),
> > > but not because of the type of object being marked, except for
> > > the special case of procfs and permission events.
> > > 
> > > mount(2) syscall OTOH, has many documented EINVAL cases
> > > due to the type of source object (e.g. propagation type shared).
> > > 
> > > I know there is no standard and EINVAL can mean many
> > > different things in syscalls, but I thought that maybe EACCES
> > > would convey more accurately the message:
> > > "The sb/mount of this fs is not accessible for placing a mark".
> > > 
> > > WDYT? worth changing?
> > > worth changing procfs also?
> > > We don't have that EINVAL for procfs documented in man page btw.
> > 
> > Well, EACCES translates to message "Permission denied" which as Christian
> > writes is justifiable but frankly I find it more confusing. Because when I
> > get "Permission denied", I go looking which permissions are wrong, perhaps
> > suspecting SELinux or other LSM and don't think that object type / location
> > is at fault.
> > 
> > I agree that with EINVAL it is impossible to distinguish "unsupported on
> > this object only" vs "completely unknown flag" but it doesn't seem like a
> > huge problem for userspace to me as I can think of workarounds even if
> > userspace wants to do something else than "report error and bail".
> 
> Userspace is pretty used to the flood of EINVAL from the vfs apis so
> they often have good workarounds. It doesn't mean it's something we
> should just discount ofc. I think having ways to surface more
> descriptive errors would overall be a good thing.

Oh, I absolutely agree with that. I'm just not sure whether returning
EACCES in this particular case is going to cause more or less confusion.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
