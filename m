Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4720C4DAF23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 12:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355453AbiCPLwW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Mar 2022 07:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355462AbiCPLwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:52:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE565821
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Mar 2022 04:51:05 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F2AB21125;
        Wed, 16 Mar 2022 11:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647431464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67aUddn27qf6jHBtXuAhMdDeMDo+3enNKv6w+CD/9/k=;
        b=bgC4gE73OP/kO0MCvU3sBZgHA2UfS+KvoT23h2J4UKGfJCSHGJr5/0F1k9o8+C/vmVxqn+
        lyv0mLeJGeJPNoAfmTuvhOrMC2rA//UOhQsMzrbLzchsFtsB4eZ1AxhlDrIK7RGM5hSK8b
        9wy/lycM66poortB1RpGY1V6IZWX9Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647431464;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=67aUddn27qf6jHBtXuAhMdDeMDo+3enNKv6w+CD/9/k=;
        b=oSpG6MYnrT7PrGmJcv3G89XzXH9Cca9pDbxFRaM9xZa87g54gBoRGs/bejy5Y7b0FCIYJI
        XaIUlO1lpLsH2yDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C2520A3B8A;
        Wed, 16 Mar 2022 11:50:59 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 80F32A0615; Wed, 16 Mar 2022 12:50:58 +0100 (CET)
Date:   Wed, 16 Mar 2022 12:50:58 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220316115058.a2ki6injgdp7xjf7@quack3.lan>
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com>
 <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan>
 <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
 <20220315111536.jlnid26rv5pxjpas@quack3.lan>
 <CAOQ4uxhSKk=rPtF4vwiW0u1Yy4p8Rhdd+wKC2BLJxHR8Q9V9AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhSKk=rPtF4vwiW0u1Yy4p8Rhdd+wKC2BLJxHR8Q9V9AA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-03-22 15:07:24, Amir Goldstein wrote:
> > > > Overall I guess the functionality makes sense to me (in fact it is somewhat
> > > > surprising it is not working like that from the beginning), API-wise it is
> > > > not outright horrible, and technically it seems doable. What do you think?
> > >
> > > I think that having ONDIR and ON_CHILD in ignored mask is source for
> > > confusion. Imagine a mount mark with FAN_ONDIR and ignored mark (on dir
> > > inode) without FAN_ONDIR.  What should the outcome be?
> > > Don't ignore the events on dir because ignore mask does not have ONDIR?
> > > That is not the obvious behavior that people will expect.
> > >
> > > ON_CHILD may be a different case, but I also prefer not to deviate it from
> > > ONDIR.
> > >
> > > The only thing I can think of to add clarification is FAN_MARK_PARENT.
> > >
> > > man page already says:
> > > "The flag has no effect when marking mounts and filesystems."
> > > It can also say:
> > > "The flag has no effect when set in the ignored mask..."
> > > "The flag is implied for both mask and ignored mask when marking
> > >  directories with FAN_MARK_PARENT".
> > >
> > > Implementation wise, this would be very simple, because we already
> > > force set FAN_EVENT_ON_CHILD for FAN_MARK_MOUNT
> > > and FAN_MARK_FILESYSTEM with REPORT_DIR_FID, se we can
> > > also force set it for FAN_MARK_PARENT.
> > >
> > > But maybe it's just me that thinks this would be more clear??
> >
> > Yeah, I'm not sure if adding another flag that iteracts with ON_CHILD or
> > ONDIR adds any clarity to this mess. In my opinion defining that ON_CHILD
> > flag in the ignore mask means "apply this ignore mask to events from
> > immediate children" has an intuitive meaning as it is exactly matching the
> > semantics of ON_CHILD in the normal mark mask.
> >
> 
> Ok.
> 
> The only thing is, as you wrote to Srinivas, there is really no practical
> way to make ignore mask with ON_CHILD work on old kernels, so
> what can users do if they want to write a portable program?
> Add this mark and hope for the best?

OK, this objection probably tipped the balace towards a new flag for me :)

> If users had FAN_MARK_PARENT, the outcome at least would
> have been predictable.
> Maybe FAN_MARK_PARENT is an overkill.
> Maybe what we need is FAN_MARK_IGNORED_ON_CHILD.
> It's not very pretty, but it is clear.

Or how about FAN_MARK_IGNORED_MASK_CHECKED which would properly check for
supported bits in the ignore mask and then we can use ON_CHILD as I wanted
and we would regain ONDIR bit for future use as well?

> > With ONDIR I agree things are not as obvious. Historically we have applied
> > ignore mask even for events coming from directories regardless of ONDIR
> > flag in the ignore mask. So ignore mask without any special flag has the
> > implicit meaning of "apply to all events regardless of type of originating
> > inode". I don't think we can change that meaning at this point. We could
> > define meaning of ONDIR in ignore mask to either "ignore only events from
> > directories" or to "ignore only events from ordinary files". But neither
> > seems particularly natural or useful.
> >
> 
> TBH, I always found it annoying that fanotify cannot be used to specify
> a filter to get only mkdirs, which is a pretty common thing to want to be
> notified of (i.e. for recursive watch).
> But I have no intention to propose API changes to fix that.

I see, so we could repurpose ONDIR bit in ignore mask for EVENT_IGNORE_NONDIR
feature or something like that. But as you say, no pressing need...

> > Another concern is that currently fanotify_mark() ignores both ONDIR and
> > ON_CHILD flags in the ignore mask. So there is a chance someone happens to
> > set them by accident. For the ON_CHILD flag I would be willing to take a
> > chance and assign the meaning to this flag because I think chances for
> > real world breakage are really low. But for ONDIR, given it is unclear
> > whether ignore masks should apply for directory events without that flag, I
> > think the chances someone sets it "just to be sure" are high enough that I
> > would be reluctant to take that chance. So for ONDIR I think we are more or
> > less stuck with keeping it unused in the ignore mask.
> >
> 
> I agree with your risk assessment, so no hard objection to ON_CHILD
> on ignored mask.
> If we go with FAN_MARK_IGNORED_ON_CHILD it will not be a concern
> at all.
> 
> I should be able to find some time to fix this one way or the other
> when we decide on the design.

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
