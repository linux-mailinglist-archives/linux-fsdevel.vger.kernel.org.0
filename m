Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9422D3A3D07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 09:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhFKH0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 03:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhFKH0c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 03:26:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10AC2610F8;
        Fri, 11 Jun 2021 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623396274;
        bh=eKKhPnUkL4pgYuDAKY7Rx51nKIGr0JtWZHxxxfchKKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=diO1/dqMKjm0S0mCvngI8WWtm2PEe4ws1RRn5OxyP5vnL7OBFXwq/uIhFaZqj55VN
         BTZ1rOzgvK4XvTNr1xXuOYqxMWRYkGw+t4sDlISksRYITYGk3g8N/tIt5QErYRDPFV
         moq2bT05CxN26MQJlvwtTNDSlvD2A6NQ2tJBCPxA=
Date:   Fri, 11 Jun 2021 09:24:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: fix copy_event_to_user() fid error clean up
Message-ID: <YMMPsB0Z/TI1ps9F@kroah.com>
References: <1ef8ae9100101eb1a91763c516c2e9a3a3b112bd.1623376346.git.repnop@google.com>
 <CAOQ4uxjHjXbFwWUnVp6cosDzFEE2ZqDwSvH97bU1eWWFvo99kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjHjXbFwWUnVp6cosDzFEE2ZqDwSvH97bU1eWWFvo99kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 11, 2021 at 10:04:06AM +0300, Amir Goldstein wrote:
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
> In practice, this patch would not auto apply to 5.4.y cleanly even if you split
> it and also, it's arguably not that critical to worth the effort, so I would
> keep the first Fixes: tag and drop the second to avoid the noise of the
> stable bots trying to apply the patch.
> 
> If you want to do a service to the 5.4.y downstream community,
> you can send a backport patch directly to stable list *after* this patch
> is applied to master.
> 
> >
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
> 
> But if you do specify stable kernel version hint, try not to get it wrong
> like I did :-/
> https://lore.kernel.org/linux-fsdevel/20210608122829.GI5562@quack2.suse.cz/
> 
> CC-ing Greg in case my understanding of the stable kernel patch
> candidate analysis process is wrong.

Nope, that's right, and splitting this up would have been great, but we
can deal with it.

thanks,

greg k-h
