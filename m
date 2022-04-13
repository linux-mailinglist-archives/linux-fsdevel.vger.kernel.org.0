Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAD4FF618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiDMLxg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 07:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiDMLxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:53:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBC32DA96
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 04:51:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4C9A6210EB;
        Wed, 13 Apr 2022 11:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649850673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jQOEjOG8tZnH3GSxwIzWA5XiO/spC4FNKiwq/TKwDE=;
        b=jexm85osa/My8EMhc1evzn05l9Y1ZyWgybDhoKyNcFzduTIQg+vJQZV+4Y1SDUtqIqlvCJ
        7e28rXc9ZmR+JIEtj8a4nFisPTmDmp3C738fhAe9x0iMHd1p6x8KL2CsYBeoUjVg0D7eM/
        vvE9ibaz4OuUMgc+ldI2BrrKBitF8rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649850673;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2jQOEjOG8tZnH3GSxwIzWA5XiO/spC4FNKiwq/TKwDE=;
        b=ov47ZM+yx3TOvyXRNVaPXJskHaRexvhi+Xnpe4A9lUKTbIx1qJno6G7nTXIyXXFkO2nIPY
        at6ETF+6SCccMGCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2531FA3B83;
        Wed, 13 Apr 2022 11:51:13 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D9459A0615; Wed, 13 Apr 2022 13:51:12 +0200 (CEST)
Date:   Wed, 13 Apr 2022 13:51:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220413115112.df3okrcutiqvsfry@quack3.lan>
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com>
 <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan>
 <CAOQ4uxgSubkz84_21qa5mPpBn7qHJUsA35ciJ5JHOH2UmAnnbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgSubkz84_21qa5mPpBn7qHJUsA35ciJ5JHOH2UmAnnbA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-04-22 14:09:12, Amir Goldstein wrote:
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
> Jan,
> 
> Just a heads up - you were right about this inconsistency and I have both
> patches to fix it [1] and LTP test to reproduce the issue [2] and started work
> on the new FAN_MARK_IGNORE API.
> The new API has no tests yet, but it has a man page draft [3].
> 
> The description of the bugs as I wrote them in the fix commit message:
> 
>     This results in several subtle changes of behavior, hopefully all
>     desired changes of behavior, for example:
> 
>     - Group A has a mount mark with FS_MODIFY in mask
>     - Group A has a mark with ignored mask that does not survive FS_MODIFY
>       and does not watch children on directory D.
>     - Group B has a mark with FS_MODIFY in mask that does watch children
>       on directory D.
>     - FS_MODIFY event on file D/foo should not clear the ignored mask of
>       group A, but before this change it does
> 
>     And if group A ignored mask was set to survive FS_MODIFY:
>     - FS_MODIFY event on file D/foo should be reported to group A on account
>       of the mount mark, but before this change it is wrongly ignored
> 
>     Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events
> on child and on dir")

Thanks for looking into this! Yeah, the change in behavior looks OK to me.

								Honza

> [1] https://github.com/amir73il/linux/commits/fan_mark_ignore
> [2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
> [3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
