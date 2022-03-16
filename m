Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317FE4DAF48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 12:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbiCPL57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355523AbiCPL5y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:57:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214EB5F248
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 04:56:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B0B901F38A;
        Wed, 16 Mar 2022 11:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647431798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxn/DCTtx1yVWSumEMRcXOg/gRhtZ0hCFjrb56PgRyE=;
        b=BjNDdenxKUxZg3YUusYnk3sGhjZ5wUpwmB1gv5N6s9pN9Ta/NCs/XaWFfz+obsAtrSEfXh
        Sll7FyeCBE+gWkJbQ4GQc4NBuoCNsvDj8tSVZQslbX0JLCMJhq43rSsYdsZfDaUeEq23oQ
        VqnbNqS8yYmG4QQILx/qtkDBraWDfYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647431798;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gxn/DCTtx1yVWSumEMRcXOg/gRhtZ0hCFjrb56PgRyE=;
        b=UZJs78BLLoIx77zWuG4kYV6ULhqThoSMqOhVO5op4uzm4rNa/3ZOdVbq4oy5ByDCF/lVJV
        znctVEg9HlE1khAg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25889A3B87;
        Wed, 16 Mar 2022 11:56:34 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2FD7A0615; Wed, 16 Mar 2022 12:56:32 +0100 (CET)
Date:   Wed, 16 Mar 2022 12:56:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220316115632.khj6m4npjrjviimi@quack3.lan>
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com>
 <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 14-03-22 11:28:23, Amir Goldstein wrote:
> On Mon, Mar 14, 2022 at 10:47 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 12-03-22 11:22:29, Srinivas wrote:
> > > If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> > > FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can be
> > > applied.
> > >
> > > However a path (file) exclusion can still be applied using
> > >
> > > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > > FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_FDCWD,
> > > "/tmp/fio/abc");  ===> path exclusion that works.
> > >
> > > I think the directory exclusion not working is a bug as otherwise AV
> > > solutions cant exclude directories when using FAN_MARK_MOUNT.
> > >
> > > I believe the change should be simple since we are already supporting
> > > path exclusions. So we should be able to add the same for the directory
> > > inode.
> > >
> > > 215676 – fanotify Ignoring/Excluding a Directory not working with
> > > FAN_MARK_MOUNT (kernel.org)
> >
> > Thanks for report! So I believe this should be fixed by commit 4f0b903ded
> > ("fsnotify: fix merge with parent's ignored mask") which is currently
> > sitting in my tree and will go to Linus during the merge (opening in a
> > week).
> 
> Actually, in a closer look, that fix alone is not enough.
> 
> With the current upstream kernel this should work to exclude events
> in a directory:
> 
> fanotify_mark(fd, FAN_MARK_ADD, FAN_EVENT_ON_CHILD |
>                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
>                        AT_FDCWD, "/tmp/fio/");
> fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
>                        FAN_MARK_IGNORED_SURV_MODIFY,
>                        FAN_OPEN_PERM | FAN_CLOSE_WRITE,
>                        AT_FDCWD, "/tmp/fio/");

Thinking about this again, it could also be considered a bug (although
convenient at times ;), that in current upstream kernel this combination of
marks results in ignoring the OPEN_PERM & CLOSE_WRITE events on children of
/tmp/fio, couldn't it? We probably should not consider the parent's ignore
mask for events on children to maintain compatibility with older kernels?
In theory it could bite someone unexpectedly...

And to enable this convenient functionality we should rather introduce the
new bit we've discussed. What do you think?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
