Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C913A7BB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhFOKZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 06:25:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48946 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhFOKZx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:25:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 11741218D9;
        Tue, 15 Jun 2021 10:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623752628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zx1+H5kZys4XHA/cSswXIZfUdofMCrzekalmAlujhLY=;
        b=W525TgWBxMQ6oGoxjVFCLNtXw055IM0/UOJamxpVaKZT+lDRncrHX96rhBhhnPWy5WRLWT
        vcvr2kwZt6f8tlbn/MMHeqM6P37W3VVIGhtG4KJwdvcsr1fvkeEidIdlypiEIOREPctLpS
        YNsh+0ggp9QJIrSSEUOfOQYoGOWeZDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623752628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zx1+H5kZys4XHA/cSswXIZfUdofMCrzekalmAlujhLY=;
        b=hCPTbbj1UgFJyycgNIFVJ15CUdZlT1HFjYp5F1SfQocpSPNK4yh9VYh+X7g5hnYjim9X/a
        yIaDSh1X37ZdbgBA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id F34D9A3B93;
        Tue, 15 Jun 2021 10:23:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D61181F2C88; Tue, 15 Jun 2021 12:23:47 +0200 (CEST)
Date:   Tue, 15 Jun 2021 12:23:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: fix copy_event_to_user() fid error clean up
Message-ID: <20210615102347.GJ29751@quack2.suse.cz>
References: <1ef8ae9100101eb1a91763c516c2e9a3a3b112bd.1623376346.git.repnop@google.com>
 <CAOQ4uxjHjXbFwWUnVp6cosDzFEE2ZqDwSvH97bU1eWWFvo99kw@mail.gmail.com>
 <20210614102842.GA29751@quack2.suse.cz>
 <YMhx0CceoqRKBz9D@google.com>
 <YMh14THCE3x+lkV9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMh14THCE3x+lkV9@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-06-21 11:41:53, Greg KH wrote:
> On Tue, Jun 15, 2021 at 07:24:32PM +1000, Matthew Bobrowski wrote:
> > On Mon, Jun 14, 2021 at 12:28:42PM +0200, Jan Kara wrote:
> > > On Fri 11-06-21 10:04:06, Amir Goldstein wrote:
> > > > On Fri, Jun 11, 2021 at 6:32 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > > Trick question.
> > > > There are two LTS kernels where those fixes are relevant 5.4.y and 5.10.y
> > > > (Patch would be picked up for latest stable anyway)
> > > > The first Fixes: suggests that the patch should be applied to 5.10+
> > > > and the second Fixes: suggests that the patch should be applied to 5.4+
> > > > 
> > > > In theory, you could have split this to two patches, one auto applied to 5.4+
> > > > and the other auto applied to +5.10.
> > > > 
> > > > In practice, this patch would not auto apply to 5.4.y cleanly even if you
> > > > split it and also, it's arguably not that critical to worth the effort,
> > > > so I would keep the first Fixes: tag and drop the second to avoid the
> > > > noise of the stable bots trying to apply the patch.
> > > 
> > > Actually I'd rather keep both Fixes tags. I agree this patch likely won't
> > > apply for older kernels but it still leaves the information which code is
> > > being fixed which is still valid and useful. E.g. we have an
> > > inftrastructure within SUSE that informs us about fixes that could be
> > > applicable to our released kernels (based on Fixes tags) and we then
> > > evaluate whether those fixes make sense for us and backport them.
> > >
> > > > > Should we also be CC'ing <stable@vger.kernel.org> so this gets backported?
> > > > >
> > > > 
> > > > Yes and no.
> > > > Actually CC-ing the stable list is not needed, so don't do it.
> > > > Cc: tag in the commit message is somewhat redundant to Fixes: tag
> > > > these days, but it doesn't hurt to be explicit about intentions.
> > > > Specifying:
> > > >     Cc: <stable@vger.kernel.org> # v5.10+
> > > > 
> > > > Could help as a hint in case the Fixes: tags is for an old commit, but
> > > > you know that the patch would not apply before 5.10 and you think it
> > > > is not worth the trouble (as in this case).
> > > 
> > > I agree that CC to stable is more or less made redundant by the Fixes tag
> > > these days.
> 
> No, it is NOT.
> 
> We have to pick up the "Fixes:" stuff because of maintainers and
> developers that forget to use Cc: stable like has been documented.
> 
> But we don't always do it as quickly as a cc: stable line will offer.
> And sometimes we don't get to those at all.
> 
> So if you know it needs to go to a stable kernel, ALWAYS put a cc:
> stable as the documentation says to do so.  This isn't a new
> requirement, it's been this way for 17 years now!

OK, as I said I do add cc: stable when I think the patch should go to
stable. But practically patches with the Fixes tag get to stable so
reliably that I was suspecting you actually have a bot processing Linus'
tree and forwarding all patches with Fixes tag to stable as well :) If
that's not the case, I'm sorry for misguiding Matthew.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
