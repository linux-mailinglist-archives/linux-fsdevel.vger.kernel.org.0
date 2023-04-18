Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9101D6E66D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjDROMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjDROMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:12:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4191D146C6;
        Tue, 18 Apr 2023 07:12:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83D0D63546;
        Tue, 18 Apr 2023 14:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A399C4339B;
        Tue, 18 Apr 2023 14:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681827137;
        bh=fIJoW4Z2b2oziXL6Gxwyi/4GPVTy0BFbbYBsmszniNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5zo0S3Vwl8QjPHAIIoYqt6Sgg4FrGPCtUfUvz1cv9wMHZANcfPq7ptT20jCBdRen
         TGtpR8hunSO2naIYzsCoAyIAL+JB6c4YOuClPUO+KD3iVlTTNlZfPPTVM3HnYPg29G
         q5mxBiuhU0UbQJS57MxiqKWP6bIt/llM8XBNWd1A0IPAIfH4e4bpCU69pl8CYmg5lJ
         rnNRGisu/PPPOss5jL9qSqIc8Kh6w05qSNCxxtbWh1grlkQsjUiO8fuXzlXb7ghpMK
         8lu28mzVhAbEVAQnrWC5VcuJGogIQxA/SnJEEXkmTg0GxEQL6UnzlwfAlN97nbzKVJ
         Rc4wBu/BTIMkg==
Date:   Tue, 18 Apr 2023 16:12:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
Message-ID: <20230418-absegnen-sputen-11212a0615c7@brauner>
References: <20230414182903.1852019-1-amir73il@gmail.com>
 <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
 <CAOQ4uxj5UwDhV7XxWZ-Os+fzM=_N1DDWHpjmt6UnHr96EDriMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj5UwDhV7XxWZ-Os+fzM=_N1DDWHpjmt6UnHr96EDriMw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 18, 2023 at 04:56:40PM +0300, Amir Goldstein wrote:
> On Tue, Apr 18, 2023 at 4:33 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Apr 14, 2023 at 09:29:01PM +0300, Amir Goldstein wrote:
> > > Jan,
> > >
> > > Followup on my quest to close the gap with inotify functionality,
> > > here is a proposal for FAN_UNMOUNT event.
> > >
> > > I have had many design questions about this:
> >
> > I'm going to humbly express what I feel makes sense to me when looking
> > at this from a user perspective:
> >
> > > 1) Should we also report FAN_UNMOUNT for marked inodes and sb
> > >    on sb shutdown (same as IN_UNMOUNT)?
> >
> > My preference would be if this would be a separate event type.
> > FAN_SB_SHUTDOWN or something.
> 
> If we implement an event for this at all, I would suggest FAN_IGNORED
> or FAN_EVICTED, which has the same meaning as IN_IGNORED.
> When you get an event that the watch went away, it could be because of:
> 1. watch removed by user
> 2. watch removed because inode was evicted (with FAN_MARK_EVICTABLE)
> 3. inode deleted
> 4. sb shutdown
> 
> IN_IGNORED is generated in all of the above except for inode evict
> that is not possible with inotify.
> 
> User can figure out on his own if the inode was deleted or if fs was unmounted,
> so there is not really a need for FAN_SB_SHUTDOWN IMO.

Ok, sounds good.

> 
> Actually, I think that FAN_IGNORED would be quite useful for the
> FAN_MARK_EVICTABLE case, but it is a bit less trivial to implement
> than FAN_UNMOUNT was.
> 
> >
> > > 2) Should we also report FAN_UNMOUNT on sb mark for any unmounts
> > >    of that sb?
> >
> > I don't think so. It feels to me that if you watch an sb you don't
> > necessarily want to watch bind mounts of that sb.
> >
> > > 3) Should we report also the fid of the mount root? and if we do...
> > > 4) Should we report/consider FAN_ONDIR filter?
> > >
> > > All of the questions above I answered "not unless somebody requests"
> > > in this first RFC.
> >
> > Fwiw, I agree.
> >
> > >
> > > Specifically, I did get a request for an unmount event for containers
> > > use case.
> > >
> > > I have also had doubts regarding the info records.
> > > I decided that reporting fsid and mntid is minimum, but couldn't
> > > decide if they were better of in a single MNTID record or seprate
> > > records.
> > >
> > > I went with separate records, because:
> > > a) FAN_FS_ERROR has set a precendent of separate fid record with
> > >    fsid and empty fid, so I followed this precendent
> > > b) MNTID record we may want to add later with FAN_REPORT_MNTID
> > >    to all the path events, so better that it is independent
> >
> 
> Just thought of another reason:
>  c) FAN_UNMOUNT does not need to require FAN_REPORT_FID
>      so it does not depend on filesystem having a valid f_fsid nor
>      exports_ops. In case of "pseudo" fs, FAN_UNMOUNT can report
>      only MNTID record (I will amend the patch with this minor change).

I see some pseudo fses generate f_fsid, e.g., tmpfs in mm/shmem.c
At the risk of putting my foot in my mouth, what's stopping us from
making them all support f_fsid?
