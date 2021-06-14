Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F933A6006
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhFNKaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 06:30:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57230 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbhFNKaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 06:30:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CE48521983;
        Mon, 14 Jun 2021 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623666522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOWPNjCWzX1DRkRk6VdJvrye0T+iBFjk8WGKIdYFawI=;
        b=uMvtIA+/2rhSIZg+7lsxnb+MtxezyD84a6e3eLr5iMmUZsQEeGJwyx5QW/Y06PmwrCtiB9
        1yrebw/GZcNQ3zzjv4BDNkf94PmnP1Q4xeO3gG7nYHtpt0GPIHwgDVRQs2xncSKe+1XGEK
        pQ8quTU8quRf/myR8b+U4PvB90/F4lY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623666522;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOWPNjCWzX1DRkRk6VdJvrye0T+iBFjk8WGKIdYFawI=;
        b=fFojgXKhIU498hX44plfQ/miuchR6hMAPA+TaLLdCVzfu9AzAtJ70x4tRUe66Rj4B2IRsS
        o3RtbMAyQI64qYAg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id BC1B7A3B93;
        Mon, 14 Jun 2021 10:28:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 986121F2B82; Mon, 14 Jun 2021 12:28:42 +0200 (CEST)
Date:   Mon, 14 Jun 2021 12:28:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] fanotify: fix copy_event_to_user() fid error clean up
Message-ID: <20210614102842.GA29751@quack2.suse.cz>
References: <1ef8ae9100101eb1a91763c516c2e9a3a3b112bd.1623376346.git.repnop@google.com>
 <CAOQ4uxjHjXbFwWUnVp6cosDzFEE2ZqDwSvH97bU1eWWFvo99kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjHjXbFwWUnVp6cosDzFEE2ZqDwSvH97bU1eWWFvo99kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 11-06-21 10:04:06, Amir Goldstein wrote:
> On Fri, Jun 11, 2021 at 6:32 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > Ensure that clean up is performed on the allocated file descriptor and
> > struct file object in the event that an error is encountered while copying
> > fid info objects. Currently, we return directly to the caller when an error
> > is experienced in the fid info copying helper, which isn't ideal given that
> > the listener process could be left with a dangling file descriptor in their
> > fdtable.
> >
> > Fixes: 44d705b0370b1 ("fanotify: report name info for FAN_DIR_MODIFY event")
> > Fixes: 5e469c830fdb5 ("fanotify: copy event fid info to user")
> > Link: https://lore.kernel.org/linux-fsdevel/YMKv1U7tNPK955ho@google.com/T/#m15361cd6399dad4396aad650de25dbf6b312288e
> >
> 
> This newline should not be here.
> 
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > ---
> >
> > Hey Amir/Jan,
> >
> > I wasn't 100% sure what specific commit hash I should be referencing in the
> > fix tags, so please let me know if that needs to be changed.
> 
> Trick question.
> There are two LTS kernels where those fixes are relevant 5.4.y and 5.10.y
> (Patch would be picked up for latest stable anyway)
> The first Fixes: suggests that the patch should be applied to 5.10+
> and the second Fixes: suggests that the patch should be applied to 5.4+
> 
> In theory, you could have split this to two patches, one auto applied to 5.4+
> and the other auto applied to +5.10.
> 
> In practice, this patch would not auto apply to 5.4.y cleanly even if you
> split it and also, it's arguably not that critical to worth the effort,
> so I would keep the first Fixes: tag and drop the second to avoid the
> noise of the stable bots trying to apply the patch.

Actually I'd rather keep both Fixes tags. I agree this patch likely won't
apply for older kernels but it still leaves the information which code is
being fixed which is still valid and useful. E.g. we have an
inftrastructure within SUSE that informs us about fixes that could be
applicable to our released kernels (based on Fixes tags) and we then
evaluate whether those fixes make sense for us and backport them.

> > Should we also be CC'ing <stable@vger.kernel.org> so this gets backported?
> >
> 
> Yes and no.
> Actually CC-ing the stable list is not needed, so don't do it.
> Cc: tag in the commit message is somewhat redundant to Fixes: tag
> these days, but it doesn't hurt to be explicit about intentions.
> Specifying:
>     Cc: <stable@vger.kernel.org> # v5.10+
> 
> Could help as a hint in case the Fixes: tags is for an old commit, but
> you know that the patch would not apply before 5.10 and you think it
> is not worth the trouble (as in this case).

I agree that CC to stable is more or less made redundant by the Fixes tag
these days. I still do use the CC tag for fixes where I think it is really
important they get pushed to stable or if there's not any particular
problematic commit that can be added to Fixes tag. But it's more or less
personal preference these days.

Anyway I've added the patch to my tree and will probably send it to Linus
later this week since the fix is trivial and obvious...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
