Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AC64D9A25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 12:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347915AbiCOLQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 07:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347918AbiCOLQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 07:16:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8BD51E4F
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 04:15:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF9B01F391;
        Tue, 15 Mar 2022 11:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647342936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9gU4fD6Z6EB5UsgIWSP2dt7WCGxK3pCPZwYP+9G1gA=;
        b=h7Fb8Zmft3YNEnlRFyNlXz+7+I8eCijvJSQUvqx9SMvbn5A0Vww9uW8pz6KLnyOG3/Nh9/
        ZkLzZJOCMW2BpKxdmtDWxKzu3T8CNCxHoyrdqxxu+QAb5PteOjJ/Q3kKhuXl0fJvqfEY+7
        kBqfEruFjpa2L6SzVr+6EJz+urEk0sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647342936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9gU4fD6Z6EB5UsgIWSP2dt7WCGxK3pCPZwYP+9G1gA=;
        b=EA6dGRxSfq9URT7munsz+WdRQaHU4h+hyw1bjHVcWNvXVrl+bQ8Suj0+fVjbne9IYtUqfW
        Je9srBA9AKOqS1DA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BB99EA3B81;
        Tue, 15 Mar 2022 11:15:36 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 660F8A0615; Tue, 15 Mar 2022 12:15:36 +0100 (CET)
Date:   Tue, 15 Mar 2022 12:15:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220315111536.jlnid26rv5pxjpas@quack3.lan>
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com>
 <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan>
 <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-03-22 21:17:11, Amir Goldstein wrote:
> On Mon, Mar 14, 2022 at 1:33 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 14-03-22 11:28:23, Amir Goldstein wrote:
> > > On Mon, Mar 14, 2022 at 10:47 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Sat 12-03-22 11:22:29, Srinivas wrote:
> > > > > If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> > > > > FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can be
> > > > > applied.
> > > > >
> > > > > However a path (file) exclusion can still be applied using
> > > > >
> > > > > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > > > > FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_FDCWD,
> > > > > "/tmp/fio/abc");  ===> path exclusion that works.
> > > > >
> > > > > I think the directory exclusion not working is a bug as otherwise AV
> > > > > solutions cant exclude directories when using FAN_MARK_MOUNT.
> > > > >
> > > > > I believe the change should be simple since we are already supporting
> > > > > path exclusions. So we should be able to add the same for the directory
> > > > > inode.
> > > > >
> > > > > 215676 – fanotify Ignoring/Excluding a Directory not working with
> > > > > FAN_MARK_MOUNT (kernel.org)
> > > >
> > > > Thanks for report! So I believe this should be fixed by commit 4f0b903ded
> > > > ("fsnotify: fix merge with parent's ignored mask") which is currently
> > > > sitting in my tree and will go to Linus during the merge (opening in a
> > > > week).
> > >
> > > Actually, in a closer look, that fix alone is not enough.
> > >
> > > With the current upstream kernel this should work to exclude events
> > > in a directory:
> > >
> > > fanotify_mark(fd, FAN_MARK_ADD, FAN_EVENT_ON_CHILD |
> > >                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> > >                        AT_FDCWD, "/tmp/fio/");
> > > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > >                        FAN_MARK_IGNORED_SURV_MODIFY,
> > >                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
> > >                        AT_FDCWD, "/tmp/fio/");
> > >
> > > The first call tells fanotify that the inode mark on "/tmp/foo" is
> > > interested in events on children (and not only on self).
> > > The second call sets the ignored mark for open/close events.
> > >
> > > The fix only removed the need to include the events in the
> > > first call.
> > >
> > > Should we also interpret FAN_EVENT_ON_CHILD correctly
> > > in a call to fanotify_mark() to set an ignored mask?
> > > Possibly. But that has not been done yet.
> > > I can look into that if there is interest.
> >
> > Oh, right. I forgot about the need for FAN_EVENT_ON_CHILD in the
> > mark->mask. It seems we can set FAN_EVENT_ON_CHILD in the ignored_mask as
> > well but it just gets ignored currently. So we would need to propagate it
> > even from ignore_mask to inode->i_fsnotify_mask. But send_to_group() would
> > also need to be more careful now with ignore masks and apply them from
> > parent only if the particular mark has FAN_EVENT_ON_CHILD in the ignore
> > mask. Interestingly fanotify_group_event_mask() does explicitely apply
> > ignore_mask from the parent regardless of FAN_EVENT_ON_CHILD flags. So
> > there is some inconsistency there and it would need some tweaking...
> >
> 
> I am thinking why do we need the duplicate and unaligned ignore mask logic
> in send_to_group() at all?

I agree the duplication is not good.

> With fanotify the only backend using the ->handle_event() multi mark
> flavor, maybe we should keep it simple and let fanotify do all the specific
> mark ignore logic internally?

Well, if we leave handling of ignore marks completely to ->handle_event()
then we pay the cost of indirect call even for ignored events. Not sure how
much will it be visible in the overall costs, it's probably worth
benchmarking and we'll see.

> > Overall I guess the functionality makes sense to me (in fact it is somewhat
> > surprising it is not working like that from the beginning), API-wise it is
> > not outright horrible, and technically it seems doable. What do you think?
> 
> I think that having ONDIR and ON_CHILD in ignored mask is source for
> confusion. Imagine a mount mark with FAN_ONDIR and ignored mark (on dir
> inode) without FAN_ONDIR.  What should the outcome be?
> Don't ignore the events on dir because ignore mask does not have ONDIR?
> That is not the obvious behavior that people will expect.
> 
> ON_CHILD may be a different case, but I also prefer not to deviate it from
> ONDIR.
> 
> The only thing I can think of to add clarification is FAN_MARK_PARENT.
> 
> man page already says:
> "The flag has no effect when marking mounts and filesystems."
> It can also say:
> "The flag has no effect when set in the ignored mask..."
> "The flag is implied for both mask and ignored mask when marking
>  directories with FAN_MARK_PARENT".
> 
> Implementation wise, this would be very simple, because we already
> force set FAN_EVENT_ON_CHILD for FAN_MARK_MOUNT
> and FAN_MARK_FILESYSTEM with REPORT_DIR_FID, se we can
> also force set it for FAN_MARK_PARENT.
> 
> But maybe it's just me that thinks this would be more clear??

Yeah, I'm not sure if adding another flag that iteracts with ON_CHILD or
ONDIR adds any clarity to this mess. In my opinion defining that ON_CHILD
flag in the ignore mask means "apply this ignore mask to events from
immediate children" has an intuitive meaning as it is exactly matching the
semantics of ON_CHILD in the normal mark mask.

With ONDIR I agree things are not as obvious. Historically we have applied
ignore mask even for events coming from directories regardless of ONDIR
flag in the ignore mask. So ignore mask without any special flag has the
implicit meaning of "apply to all events regardless of type of originating
inode". I don't think we can change that meaning at this point. We could
define meaning of ONDIR in ignore mask to either "ignore only events from
directories" or to "ignore only events from ordinary files". But neither
seems particularly natural or useful.

Another concern is that currently fanotify_mark() ignores both ONDIR and
ON_CHILD flags in the ignore mask. So there is a chance someone happens to
set them by accident. For the ON_CHILD flag I would be willing to take a
chance and assign the meaning to this flag because I think chances for
real world breakage are really low. But for ONDIR, given it is unclear
whether ignore masks should apply for directory events without that flag, I
think the chances someone sets it "just to be sure" are high enough that I
would be reluctant to take that chance. So for ONDIR I think we are more or
less stuck with keeping it unused in the ignore mask.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
