Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848B14DC50F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 12:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiCQLzL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 07:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiCQLzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:55:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF282628
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 04:53:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E253E1F390;
        Thu, 17 Mar 2022 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647518031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eKLJeRfpPbOGuXYwsOx3RTvTH3V7ea6MyzBnbvGfiU=;
        b=2j/fZzwYED8nk7HW9+B3xxU2k3HPrtgVyYeGrFtnXDjqXkbn3ZA0TEbLgpkwJIXlQavDtF
        snftWzsltG7aY1Enn07i1rEZCBUBLmucIga4C2StFkULrkcPJuisTmAAaK+08nPtQZrxK4
        mCcOLZazozEpFnLFDcmhETIe05RjWqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647518031;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1eKLJeRfpPbOGuXYwsOx3RTvTH3V7ea6MyzBnbvGfiU=;
        b=SjAhwaKr8infJ7h7eouGAEdS0hGk/HCsc/mQMjOCsHIo4Ja4vLzgEWVXSR7JUpEb/sFyeR
        vIY7LxNA412L+MCg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7A644A3B88;
        Thu, 17 Mar 2022 11:53:51 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C851DA0615; Thu, 17 Mar 2022 12:53:46 +0100 (CET)
Date:   Thu, 17 Mar 2022 12:53:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220317115346.ztz2g7tdvudx7ujd@quack3.lan>
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com>
 <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan>
 <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
 <20220315111536.jlnid26rv5pxjpas@quack3.lan>
 <CAOQ4uxhSKk=rPtF4vwiW0u1Yy4p8Rhdd+wKC2BLJxHR8Q9V9AA@mail.gmail.com>
 <20220316115058.a2ki6injgdp7xjf7@quack3.lan>
 <CAOQ4uxgG37z7h-OYtGsZ-1=oQNu-DVvQgbN5wNbLXf0ktY1htg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgG37z7h-OYtGsZ-1=oQNu-DVvQgbN5wNbLXf0ktY1htg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 16-03-22 15:42:44, Amir Goldstein wrote:
> > > The only thing is, as you wrote to Srinivas, there is really no practical
> > > way to make ignore mask with ON_CHILD work on old kernels, so
> > > what can users do if they want to write a portable program?
> > > Add this mark and hope for the best?
> >
> > OK, this objection probably tipped the balace towards a new flag for me :)
> >
> > > If users had FAN_MARK_PARENT, the outcome at least would
> > > have been predictable.
> > > Maybe FAN_MARK_PARENT is an overkill.
> > > Maybe what we need is FAN_MARK_IGNORED_ON_CHILD.
> > > It's not very pretty, but it is clear.
> >
> > Or how about FAN_MARK_IGNORED_MASK_CHECKED which would properly check for
> > supported bits in the ignore mask and then we can use ON_CHILD as I wanted
> > and we would regain ONDIR bit for future use as well?
> >
> 
> I don't follow the reasoning behind the name MASK_CHECKED.

My idea was that with FAN_IGNORED_MASK we did the mistake that passed
arguments (mask in particular) are not properly checked because we let
userspace set bits which are not really used in the ignore mask. So let's
fix this by properly checking the arguments and to do that safely we need a
new variant of FAN_IGNORED_MASK, hence FAN_IGNORED_MASK_CHECKED...

> If anything, I would rather introduce FAN_IGNORE_MARK.
> The reasoning is that users may think of this "ignore mark"
> as a separate mark from the "inode mark", so on this "mark" the
> meaning of ON_CHILD flags would be pretty clear.

Well, yes, you are speaking about effectively the same flag just under a
different name :) I agree my name is poor so I'm happy if we pick another
one. The only small reservation I have against the name FAN_IGNORE_MARK is
that we would now have to explain in the manpage a new concept of ignore
mark and tell this is just a new name for ignore mask which looks a bit
silly and perhaps confusing to developers used to the old naming.

> The fact that they are implemented as a single mark with two masks
> and that each mask also has some flags is an implementation detail.
> 
> If we go for FAN_IGNORE_MARK, we would disallow the combination
>   fanotify_mark(FAN_IGNORE_MARK, FAN_MARK_IGNORED_MASK, ...

Certainly.

> and I am also in favor of disallowing FAN_MARK_IGNORED_SURV_MODIFY.
> I find it completely useless for watching children and if people still need
> the ignored mask that does not survive modify, they can use the old API.

Well, but FAN_IGNORE_MARK is not just for watching children. You can still
ignore a single file with FAN_IGNORE_MARK. As much as I understand that
FAN_MARK_IGNORED_SURV_MODIFY complicates our life, I don't think we'll ever
be able to get rid of it completely so I don't see any value in disallowing
it with FAN_IGNORE_MARK.

> > > > With ONDIR I agree things are not as obvious. Historically we have applied
> > > > ignore mask even for events coming from directories regardless of ONDIR
> > > > flag in the ignore mask. So ignore mask without any special flag has the
> > > > implicit meaning of "apply to all events regardless of type of originating
> > > > inode". I don't think we can change that meaning at this point. We could
> > > > define meaning of ONDIR in ignore mask to either "ignore only events from
> > > > directories" or to "ignore only events from ordinary files". But neither
> > > > seems particularly natural or useful.
> > > >
> > >
> > > TBH, I always found it annoying that fanotify cannot be used to specify
> > > a filter to get only mkdirs, which is a pretty common thing to want to be
> > > notified of (i.e. for recursive watch).
> > > But I have no intention to propose API changes to fix that.
> >
> > I see, so we could repurpose ONDIR bit in ignore mask for EVENT_IGNORE_NONDIR
> > feature or something like that. But as you say, no pressing need...
> >
> 
> Alas, that does not fit nicely with the FAN_IGNORE_MARK abstraction.
> The inverse does:
> The "mark" with ONDIR captures all the create events and the "ignore mark"
> without ONDIR filters out the non-mkdir.

Yeah, I actually like the consistency here - the ordinary mask causes
the event to be generated IFF the same ignore mask/mark causes the event to be
discarded. It would mean that without ONDIR events from directories are not
ignored so that's a difference to current meaning of ignore masks but we
can do that modification with the new flag.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
