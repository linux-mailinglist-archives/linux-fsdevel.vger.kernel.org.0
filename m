Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E985A5133D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiD1Mln (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 08:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiD1Mll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:41:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C8EAD121
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 05:38:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D8B101F37F;
        Thu, 28 Apr 2022 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651149504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gp8BlE5sFVUaPn10ogQ0KMZxtUkqkmDcQ6AvvkjXAPI=;
        b=Ci700uHSt9xQ6nvoGyiLsuaVlafpnxNyLWJaJvkDUDrxanN/0j02WXST3SUT59MnBHDL8V
        Q3rKIgv7yeKYBFGsQiWoHvC8KdJJ3v0hJTkihriDiym4stAWzGHk+KhwG6pOMVKspVl60N
        34vejbo3syXL+TS/QtLuMtZdMnei1U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651149504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gp8BlE5sFVUaPn10ogQ0KMZxtUkqkmDcQ6AvvkjXAPI=;
        b=Xp3uB7dp/q5vjtjnFSd/2Ljlnpg4YeAvy1QPiR6LZZDMNOUXdXbzCg7i0EZEJmF/a/i8qC
        3lzk9pwyEB0UqkAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C1B2F2C141;
        Thu, 28 Apr 2022 12:38:24 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 77F9DA061A; Thu, 28 Apr 2022 14:38:24 +0200 (CEST)
Date:   Thu, 28 Apr 2022 14:38:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220428123824.ssq72ovqg2nao5f4@quack3.lan>
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com>
 <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan>
 <CAOQ4uxgSubkz84_21qa5mPpBn7qHJUsA35ciJ5JHOH2UmAnnbA@mail.gmail.com>
 <20220413115112.df3okrcutiqvsfry@quack3.lan>
 <CAOQ4uxhvR8Kr99V1gCmBxRWQqQuhCLz9h30YhEYjF-qkdOpjaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhvR8Kr99V1gCmBxRWQqQuhCLz9h30YhEYjF-qkdOpjaQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 14-04-22 14:02:27, Amir Goldstein wrote:
> > > Jan,
> > >
> > > Just a heads up - you were right about this inconsistency and I have both
> > > patches to fix it [1] and LTP test to reproduce the issue [2] and started work
> > > on the new FAN_MARK_IGNORE API.
> > > The new API has no tests yet, but it has a man page draft [3].
> > >
> > > The description of the bugs as I wrote them in the fix commit message:
> > >
> > >     This results in several subtle changes of behavior, hopefully all
> > >     desired changes of behavior, for example:
> > >
> > >     - Group A has a mount mark with FS_MODIFY in mask
> > >     - Group A has a mark with ignored mask that does not survive FS_MODIFY
> > >       and does not watch children on directory D.
> > >     - Group B has a mark with FS_MODIFY in mask that does watch children
> > >       on directory D.
> > >     - FS_MODIFY event on file D/foo should not clear the ignored mask of
> > >       group A, but before this change it does
> > >
> > >     And if group A ignored mask was set to survive FS_MODIFY:
> > >     - FS_MODIFY event on file D/foo should be reported to group A on account
> > >       of the mount mark, but before this change it is wrongly ignored
> > >
> > >     Fixes: 2f02fd3fa13e ("fanotify: fix ignore mask logic for events
> > > on child and on dir")
> >
> > Thanks for looking into this! Yeah, the change in behavior looks OK to me.
> >
> 
> And I got sufficiently annoyed by our mixed terminology of "ignored mask"
> and "ignore mask". Man pages only use the latter and also most of the
> comments in code and many of the commit messages but not all of them
> and variable name is of course the former, so I decided to take action:
> 
> commit 6c6f07348c0c587e2bdcdb997caa30f852e818ef
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Tue Apr 12 13:25:34 2022 +0300
> 
>     fanotify: prepare for setting event flags in ignore mask
> 
> [...]
> 
>     To emphasize the change in terminology, also rename ignored_mask mark
>     member to ignore_mask and use accessor to get only ignored events or
>     events and flags.
> 
>     This change in terminology finally aligns with the "ignore mark"
>     language in man pages and in most of the comments.
> 
> I hope I didn't take it too far...

Forgot to respond to this one but it makes sense to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
