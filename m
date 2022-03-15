Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2BB4D96B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 09:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiCOIvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 04:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiCOIvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:51:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6D04C795
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 01:50:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 43D232191E;
        Tue, 15 Mar 2022 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647334233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDW+aezEnd30oN0czhiURri4JdoaHUESnfEdHSniOzQ=;
        b=q7nyarRcM2Ep2V57eFsUDV80fxb16U/CVqVYo+b63MDiCU7ICVxs8hkpvBp/cMRak7N70j
        6WrwGrMed5FnpY6Oh9XBmNCIWG9R7V9fGCEKpzeEPNqALGDDU7DDdFn+yVKH7Me/yzvpui
        InJAm937CKXRYnZH/++5zayNqN1aI0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647334233;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDW+aezEnd30oN0czhiURri4JdoaHUESnfEdHSniOzQ=;
        b=JUQEtpOVEtxXHviBu0Zmzqw+g7kb52XrC0pS2B5RiB79bTXey4BInaO+mJQypydOSj5O+B
        ByW3jdIh//4OoRCw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25A7EA3B97;
        Tue, 15 Mar 2022 08:50:33 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6319CA0615; Tue, 15 Mar 2022 09:50:30 +0100 (CET)
Date:   Tue, 15 Mar 2022 09:50:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Srinivas <talkwithsrinivas@yahoo.co.in>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220315085030.5xgcbvl6bxqc6ddj@quack3.lan>
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com>
 <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <1167838778.1530955.1647323074465@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1167838778.1530955.1647323074465@mail.yahoo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-03-22 05:44:34, Srinivas wrote:
> 
> >> With the current upstream kernel this should work to exclude events in a directory:
> 
> >> fanotify_mark(fd, FAN_MARK_ADD, FAN_EVENT_ON_CHILD |
>                       FAN_OPEN_PERM | FAN_CLOSE_WRITE,
>                       AT_FDCWD, "/tmp/fio/");
> >> fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
>                       FAN_MARK_IGNORED_SURV_MODIFY,
>                       FAN_OPEN_PERM | FAN_CLOSE_WRITE,
>                       AT_FDCWD, "/tmp/fio/");
> 
> 
> This works perfectly fine on the newer kernels but does not on the older
> kernels.  Is there any way we could get this working too on the old 3.x
> and 4.x kernels? (without the need for patching etc.)

No, I don't think there is a way. Combining ignore marks on directories
with mount / superblock marks was made possible only by fsnotify changes
that went into 5.9 kernel (commit 497b0c5a7c06 ("fsnotify: send event to
parent and child with single callback") in particular). Before that the
notification core did not have information from the parent directory
available when generating event for a mount mark and so ignore mask could
not be applied.  So only ignore marks on individual files worked until that
moment.

								Honza

> On Monday, 14 March, 2022, 02:58:30 pm IST, Amir Goldstein <amir73il@gmail.com> wrote:  
>  On Mon, Mar 14, 2022 at 10:47 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sat 12-03-22 11:22:29, Srinivas wrote:
> > > If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> > > FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can be
> > > applied.
> > >
> > > However a path (file) exclusion can still be applied using
> > >
> > > fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> > > FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_FDCWD,
> > > "/tmp/fio/abc");  ===> path exclusion that works.
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
>                       FAN_OPEN_PERM | FAN_CLOSE_WRITE,
>                       AT_FDCWD, "/tmp/fio/");
> fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
>                       FAN_MARK_IGNORED_SURV_MODIFY,
>                       FAN_OPEN_PERM | FAN_CLOSE_WRITE,
>                       AT_FDCWD, "/tmp/fio/");
> 
> The first call tells fanotify that the inode mark on "/tmp/foo" is
> interested in events on children (and not only on self).
> The second call sets the ignored mark for open/close events.
> 
> The fix only removed the need to include the events in the
> first call.
> 
> Should we also interpret FAN_EVENT_ON_CHILD correctly
> in a call to fanotify_mark() to set an ignored mask?
> Possibly. But that has not been done yet.
> I can look into that if there is interest.
> In retrospect, FAN_EVENT_ON_CHILD and FAN_ONDIR would have
> been more clear as FAN_MARK_ flags, but that's too late.
> 
> Thanks,
> Amir.
>   
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
