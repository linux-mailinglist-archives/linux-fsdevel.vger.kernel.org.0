Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00AC23A7AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 11:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhFOJoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 05:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231238AbhFOJoA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:44:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D6D061209;
        Tue, 15 Jun 2021 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623750116;
        bh=1wCtGWkPwZYMZRCrMSWmhYOo8bpfpG5fhKivDsxr82Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fb+N/DjqV9HoU8TednOHKh0AkSgHITcIK2ybjN33caA8RZj7IsUXQGxwwMWDyqLaj
         RckWOLnRkGGM18p2kt7ftLdtt6P+/EVyauzh6/UfpFiPC/z1itEYBmJBwQqwLz+7PJ
         11gbIwa7i0i2bN0+SPasE+TmY9UwE39slBfMiw9A=
Date:   Tue, 15 Jun 2021 11:41:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: fix copy_event_to_user() fid error clean up
Message-ID: <YMh14THCE3x+lkV9@kroah.com>
References: <1ef8ae9100101eb1a91763c516c2e9a3a3b112bd.1623376346.git.repnop@google.com>
 <CAOQ4uxjHjXbFwWUnVp6cosDzFEE2ZqDwSvH97bU1eWWFvo99kw@mail.gmail.com>
 <20210614102842.GA29751@quack2.suse.cz>
 <YMhx0CceoqRKBz9D@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMhx0CceoqRKBz9D@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 15, 2021 at 07:24:32PM +1000, Matthew Bobrowski wrote:
> On Mon, Jun 14, 2021 at 12:28:42PM +0200, Jan Kara wrote:
> > On Fri 11-06-21 10:04:06, Amir Goldstein wrote:
> > > On Fri, Jun 11, 2021 at 6:32 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > Trick question.
> > > There are two LTS kernels where those fixes are relevant 5.4.y and 5.10.y
> > > (Patch would be picked up for latest stable anyway)
> > > The first Fixes: suggests that the patch should be applied to 5.10+
> > > and the second Fixes: suggests that the patch should be applied to 5.4+
> > > 
> > > In theory, you could have split this to two patches, one auto applied to 5.4+
> > > and the other auto applied to +5.10.
> > > 
> > > In practice, this patch would not auto apply to 5.4.y cleanly even if you
> > > split it and also, it's arguably not that critical to worth the effort,
> > > so I would keep the first Fixes: tag and drop the second to avoid the
> > > noise of the stable bots trying to apply the patch.
> > 
> > Actually I'd rather keep both Fixes tags. I agree this patch likely won't
> > apply for older kernels but it still leaves the information which code is
> > being fixed which is still valid and useful. E.g. we have an
> > inftrastructure within SUSE that informs us about fixes that could be
> > applicable to our released kernels (based on Fixes tags) and we then
> > evaluate whether those fixes make sense for us and backport them.
> >
> > > > Should we also be CC'ing <stable@vger.kernel.org> so this gets backported?
> > > >
> > > 
> > > Yes and no.
> > > Actually CC-ing the stable list is not needed, so don't do it.
> > > Cc: tag in the commit message is somewhat redundant to Fixes: tag
> > > these days, but it doesn't hurt to be explicit about intentions.
> > > Specifying:
> > >     Cc: <stable@vger.kernel.org> # v5.10+
> > > 
> > > Could help as a hint in case the Fixes: tags is for an old commit, but
> > > you know that the patch would not apply before 5.10 and you think it
> > > is not worth the trouble (as in this case).
> > 
> > I agree that CC to stable is more or less made redundant by the Fixes tag
> > these days.

No, it is NOT.

We have to pick up the "Fixes:" stuff because of maintainers and
developers that forget to use Cc: stable like has been documented.

But we don't always do it as quickly as a cc: stable line will offer.
And sometimes we don't get to those at all.

So if you know it needs to go to a stable kernel, ALWAYS put a cc:
stable as the documentation says to do so.  This isn't a new
requirement, it's been this way for 17 years now!

thanks,

greg k-h
