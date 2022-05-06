Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CCC51D52E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 12:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390797AbiEFKKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 06:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390795AbiEFKKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 06:10:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB1B5DA62;
        Fri,  6 May 2022 03:06:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B365F1F8D2;
        Fri,  6 May 2022 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651831597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXtfwfxPgKXJzB1ECQLLn99+7sPjHYlCi6MakpG51vA=;
        b=HjRgJPmeB7zKBcrYq/65eBhvKxjbfFTTRfmMljjFOn23d86o+BF9wzC7a/S+V5imB1aTK1
        V/MVfzG5d7VmdqgquJgNz/fggjx4VFRYl+NVBUnoE3S71Ozwkz8iv7O8tP/bE4+lRYTaZE
        OH0KU2RW4/Cvwu6EA4TMHT6V1aFlfDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651831597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NXtfwfxPgKXJzB1ECQLLn99+7sPjHYlCi6MakpG51vA=;
        b=yTvp2r5Qo52/WQz8+cXRWe4z8hvoYNJWGGoITjO8hMcHYI1bgSX55b3nvxWTp5BzQbrjHJ
        Y1n08MRidbsn2yBQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8167E2C143;
        Fri,  6 May 2022 10:06:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DD78BA0629; Fri,  6 May 2022 12:06:36 +0200 (CEST)
Date:   Fri, 6 May 2022 12:06:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify API - Tracking File Movement
Message-ID: <20220506100636.k2lm22ztxpyaw373@quack3.lan>
References: <YnOmG2DvSpvvOEOQ@google.com>
 <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan>
 <YnRhVgu6JKNinarh@google.com>
 <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 06-05-22 03:00:58, Amir Goldstein wrote:
> > > > HOWEVER! look at the way we implemented reporting of FAN_RENAME
> > > > (i.e. match_mask). We report_new location only if watching sb or watching
> > > > new dir. We did that for a reason because watcher may not have permissions
> > > > to read new dir. We could revisit this decision for a privileged group, but will
> > > > need to go back reading all the discussions we had about this point to see
> > > > if there were other reasons(?).
> > >
> > > Yeah, this is a good point. We are able to safely report the new parent
> > > only if the watching process is able to prove it is able to watch it.
> > > Adding even more special cases there would be ugly and error prone I'm
> > > afraid. We could certainly make this available only to priviledged
> > > notification groups but still it is one more odd corner case and the
> > > usecase does not seem to be that big.
> >
> > Sorry, I'm confused about the conclusion we've drawn here. Are we hard
> > up against not extending FAN_RENAME for the sole reason that the
> > implementation might be ugly and error prone?
> >
> > Can we not expose this case exclusively to privileged notification
> > groups/watchers? This case seems far simpler than what has already
> > been implemented in the FAN_RENAME series, that is as you mentioned,
> > trying to safely report the new parent only if the watching process is
> > able to prove it is able to watch it. If anything, I would've expected
> > the privileged case to be implemented prior to attempting to cover
> > whether the super block or target directory is being watched.
> 
> To be fair, that is what the "added complexity" for the privileged use
> case looks like:
> 
>                         /* Report both old and new parent+name if sb watching */
>                         report_old = report_new =
> +                               !FAN_GROUP_FLAG(group, FANOTIFY_UNPRIV) ||
>                                 match_mask & (1U << FSNOTIFY_ITER_TYPE_SB);
>                         report_old |=
>                                 match_mask & (1U << FSNOTIFY_ITER_TYPE_INODE);
> 
> There is a bit more complexity to replace FSNOTIFY_ITER_TYPE_INODE2
> with FSNOTIFY_ITER_TYPE_DIR1 and FSNOTIFY_ITER_TYPE_DIR1.
> 
> But I understand why Jan is hesitant about increasing the cases for
> already highly
> specialized code.
> 
> My only argument in favor of this case is that had we though about it before
> merging FAN_RENAME we would have probably included it.(?)

So I've slept on it and agree that allowing FAN_RENAME on a file with the
semantics Matthew wants is consistent with the current design and probably
the only sensible meaning we can give to it. I also agree that updating
permission checks for reporting parent dirs isn't that big of a headache
and maintenance burden going further.

I'm still somewhat concerned about how the propagation of two parent
directories and then formatting into the event is going to work out (i.e.,
how many special cases that's going to need) but I'm willing to have a look
at the patch. Maybe it won't be as bad as I was afraid :).

> > Ah, I really wanted to stay away from watching the super block for all
> > FAN_RENAME events. I feel like userspace wearing the pain for such
> > cases is suboptimal, as this is something that can effectively be done
> > in-kernel.

I agree that kernel can do this more efficiently than userspace but the
question is how much in terms of code (and thus maintenance overhead) are
we willing to spend for this IMO rather specialized feature. The code to
build necessary information to pass with the event, dealing with all
different types of watches and backends and then formatting it to the event
for userspace is complex as hell. Whenever I have to do or review some
non-trivial changes to it, my head hurts ;) And the amount of subtle
cornercase bugs we were fixing in that code over the years is just a
testimony of this. So that's why I'm reluctant to add even small
complications to it for something I find relatively specialized use (think
for how many userspace programs this feature is going to be useful, I don't
think many).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
