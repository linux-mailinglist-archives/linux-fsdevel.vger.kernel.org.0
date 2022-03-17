Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E9F4DC847
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 15:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiCQOD5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiCQODz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:03:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84791E3E00
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 07:02:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6F3A71F38D;
        Thu, 17 Mar 2022 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647525757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ex8ZXTNGiDgAiPCf0sJm44XeKtmdoRWgMApFRqiediw=;
        b=rAWi0fZfOt+eBpXcDFRY7k9PnNS4rjGKhO+cvirG2Duj9hrbCI1gT85yFl5ptfG4dENEDx
        4RAXaGzYQ3Kj1QEMbdS6kOe8Q3prk9bzf+mP3FhBdPgFFIkSa1HJ0d2GGPWJJNmKTMLTjZ
        ALCXGuEwO7RZeKP5WAMsZ8KfHYHoCSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647525757;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ex8ZXTNGiDgAiPCf0sJm44XeKtmdoRWgMApFRqiediw=;
        b=VNumQ2ip80ddhj+0Uve3w0VGixN3r4MeZohv/5I8qYFv+6KPC7o74DNlePtuyrcc5LNAU3
        Ad0pl8BGcG4yzaAg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5F99EA3B89;
        Thu, 17 Mar 2022 14:02:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 06FAFA0615; Thu, 17 Mar 2022 15:02:37 +0100 (CET)
Date:   Thu, 17 Mar 2022 15:02:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Srinivas <talkwithsrinivas@yahoo.co.in>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220317140236.p5ztvqebb34cilhb@quack3.lan>
References: <20220314084706.ncsk754gjywkcqxq@quack3.lan>
 <CAOQ4uxiDubhONM3w502anndtbqy73q_Kt5bOQ07zbATb8ndvVA@mail.gmail.com>
 <20220314113337.j7slrb5srxukztje@quack3.lan>
 <CAOQ4uxhwXgqbMKMSQJwNqQpKi-iAtS4dsFwkeDDMv=Y0ewp=og@mail.gmail.com>
 <20220315111536.jlnid26rv5pxjpas@quack3.lan>
 <CAOQ4uxhSKk=rPtF4vwiW0u1Yy4p8Rhdd+wKC2BLJxHR8Q9V9AA@mail.gmail.com>
 <20220316115058.a2ki6injgdp7xjf7@quack3.lan>
 <CAOQ4uxgG37z7h-OYtGsZ-1=oQNu-DVvQgbN5wNbLXf0ktY1htg@mail.gmail.com>
 <20220317115346.ztz2g7tdvudx7ujd@quack3.lan>
 <CAOQ4uxgupVpDSwN0EKw8hWVdyzK06DYyV9wBhmySz42nb_oNMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgupVpDSwN0EKw8hWVdyzK06DYyV9wBhmySz42nb_oNMA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-03-22 15:03:03, Amir Goldstein wrote:
> > > If anything, I would rather introduce FAN_IGNORE_MARK.
> > > The reasoning is that users may think of this "ignore mark"
> > > as a separate mark from the "inode mark", so on this "mark" the
> > > meaning of ON_CHILD flags would be pretty clear.
> >
> > Well, yes, you are speaking about effectively the same flag just under a
> > different name :) I agree my name is poor so I'm happy if we pick another
> > one. The only small reservation I have against the name FAN_IGNORE_MARK is
> > that we would now have to explain in the manpage a new concept of ignore
> > mark and tell this is just a new name for ignore mask which looks a bit
> > silly and perhaps confusing to developers used to the old naming.
> 
> Right. here is a first go at that (along with a name change):
> 
> "FAN_MARK_IGNORE - This flag has a similar effect as setting the
>  FAN_MARK_IGNORED_MASK flag - the events in mask shall be added
>  to or removed from the ignore mask.
>  Unlike the FAN_MARK_IGNORED_MASK flag, this flag also has the effect
>  that the FAN_EVENT_ON_CHILD and FAN_ONDIR flags take effect on the
>  ignored mask, because with FAN_MARK_IGNORED_MASK, those flags
>  have no effect. Note that unlike the FAN_MARK_IGNORED_MASK flag,
>  unless FAN_ONDIR flag is set with FAN_MARK_IGNORE, events on
>  directories will not be ignored."
> 
> What I like about this name is that the command
> fanotify_mark(FAN_MARK_ADD | FAN_MARK_IGNORE,
>                        FAN_MARK_OPEN | FAN_EVENT_ON_CHILD, ...
> sounds like spoken English ("add a rule to ignore open events (also)
> on children").
> 
> Please let me know if you agree with that flag name.

Yes, with this explanation I like the new name. Thanks for the effort!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
