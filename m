Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9339155DAC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiF0LiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 07:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234796AbiF0LhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:37:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49198DF60;
        Mon, 27 Jun 2022 04:32:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F2A091F916;
        Mon, 27 Jun 2022 11:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656329546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6B26m7hZb5f6q7+2IetdlL6egI3QatMfk0ix1U2uzk0=;
        b=Hq+EZRk0YdKKA4QNRzWkwV5ft9v5CSJ2JFRCi3lTijIYK91u5DEC4OiZhtl9d2pDDu8m3A
        Acd9jqL1i8fNNEOthLgKPbX3j1z1/S8q3JY50dnk90+aq5OeJ/jIe6D6tFlY1d4Vr0nMAx
        WpPqMqp7cB0Mk+7Qo2ERHdwkqJApXek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656329546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6B26m7hZb5f6q7+2IetdlL6egI3QatMfk0ix1U2uzk0=;
        b=ekUBWGcJ98sQhN/81UsWmVx4k7kEDbamu2mbr9IKfEXDQkW5sfT8Gakf6V7UH/GhIELPp7
        gpkvmZnf+3dBBaBQ==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D10062C141;
        Mon, 27 Jun 2022 11:32:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8D428A062F; Mon, 27 Jun 2022 13:32:24 +0200 (CEST)
Date:   Mon, 27 Jun 2022 13:32:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] fanotify: prepare for setting event flags in
 ignore mask
Message-ID: <20220627113224.kr2725conevh53u4@quack3.lan>
References: <20220624143538.2500990-1-amir73il@gmail.com>
 <20220624143538.2500990-2-amir73il@gmail.com>
 <CAOQ4uxjRzu_Y8eE=C=PnKjzCiDK5k5NBM1dxYttd8yfoy2DnUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjRzu_Y8eE=C=PnKjzCiDK5k5NBM1dxYttd8yfoy2DnUg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 26-06-22 10:57:46, Amir Goldstein wrote:
> On Fri, Jun 24, 2022 at 5:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> > The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> > ignore mask is always implicitly applied to events on directories.
> >
> > Define a mark flag that replaces this legacy behavior with logic of
> > applying the ignore mask according to event flags in ignore mask.
> >
> > Implement the new logic to prepare for supporting an ignore mask that
> > ignores events on children and ignore mask that does not ignore events
> > on directories.
> >
> > To emphasize the change in terminology, also rename ignored_mask mark
> > member to ignore_mask and use accessors to get only the effective
> > ignored events or the ignored events and flags.
> >
> > This change in terminology finally aligns with the "ignore mask"
> > language in man pages and in most of the comments.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> 
> [...]
> 
> > @@ -336,7 +337,7 @@ static int send_to_group(__u32 mask, const void *data, int data_type,
> >                 fsnotify_foreach_iter_mark_type(iter_info, mark, type) {
> >                         if (!(mark->flags &
> >                               FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY))
> > -                               mark->ignored_mask = 0;
> > +                               mark->ignore_mask = 0;
> >                 }
> >         }
> 
> Doh! I missed (again) the case of:
> !FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY && !FS_EVENT_ON_CHILD
> 
> I was starting to look at a fix, but then I stopped to think about the
> justification
> for FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY on a directory.
> 
> The man page does say:
> "... the ignore mask is cleared when a modify event occurs for the ignored file
>      or directory."
> But ignore mask on a parent never really worked when this man page was
> written and there is no such thing as a "modify event" on the directory itself.
> 
> Furthermore, let's look at the motivation for IGNORED_SURV_MODIFY -
> it is meant (I think) to suppress open/access permission events on a file
> whose content was already scanned for malware until the content of that
> file is modified - an important use case.
> 
> But can that use case be extended to all files in a directory?
> In theory, anti-malware software could scan a directory and call it "clean"
> until any of the files therein is modified. However, an infected file can also
> be moved into the "clean" directory, so unless we introduce a flag
> IGNORED_DOES_NOT_SURV_MOVED_TO, supporting
> !IGNORED_SURV_MODIFY on a directory seems useless.
> 
> That leads me to suggest the thing I like most - deprecate.
> Until someone comes up with a case to justify !IGNORED_SURV_MODIFY
> on a directory, trying to set FAN_MARK_IGNORE on a directory without
> IGNORED_SURV_MODIFY will return EISDIR.
> 
> We could also say that IGNORED_SURV_MODIFY is implied on
> a directory, but I think the EISDIR option is cleaner and easier to
> document - especially for the case of "upgrading" a directory mark
> from FAN_MARK_IGNORED_MASK to new FAN_MARK_IGNORE.
> 
> We could limit that behavior to an ignore mask with EVENT_ON_CHILD
> but that will just complicate things for no good reason.

I think all of the above was reflected in your proposal in another email
and I agree.

> Semi-related, we recently did:
> ceaf69f8eadc ("fanotify: do not allow setting dirent events in mask of non-dir")
> We could have also disallowed FAN_ONDIR and FAN_EVENT_ON_CHILD
> on non-dir inode. Too bad I didn't see it.
> Do you think that we can/should "fix" FAN_REPORT_TARGET_FID to include
> those restrictions?

Yes, I think we could still amend the behavior. It isn't upstream for long
and the combination is non-sensical in the first place... In the worst case
we can revert without too much harm here.

> I would certainly like to disallow dirent events and the extra dir flags
> for setting FAN_MARK_IGNORE on a non-dir inode.
> 
> I am going to be on two weeks vacation v5.19-rc5..v5.19-rc7,
> so unless we have clear answers about the API questions above
> early this week, FAN_MARK_IGNORE will probably have to wait
> another cycle.

I'm on vacation next week as well. Let's see whether we'll be able to get
things into shape for the merge window...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
