Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683873BEA5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 17:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhGGPJa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 11:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:36318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232084AbhGGPJa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6909F61CC0;
        Wed,  7 Jul 2021 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625670409;
        bh=meAqswieIwvglWxHVG7o8tCUh+PaGXqIKM7610mdBRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ifbyG30kR+elhqc/M7He0RvljFsanuwgzukhqgOpYhpFwIv6TlI3xLqSyR8zlzOhe
         ikdopdgkXRGXAyM6+aoYSirbsi5uysEeK53V+65DvNbMd+Zr181AfBVyMJ8F5IbL33
         oWCITkCkZT4ZbHdhBbxw7htM3HIjzS9QJ8mtY7ow=
Date:   Wed, 7 Jul 2021 17:06:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] fcntl: fix potential deadlocks for
 &fown_struct.lock
Message-ID: <YOXDBZR2RSfiM+A3@kroah.com>
References: <20210707023548.15872-1-desmondcheongzx@gmail.com>
 <20210707023548.15872-2-desmondcheongzx@gmail.com>
 <YOVENb3X/m/pNrYt@kroah.com>
 <14633c3be87286d811263892375f2dfa9a8ed40a.camel@kernel.org>
 <YOWHKk6Nq8bazYjB@kroah.com>
 <4dda1cad6348fced5fcfcb6140186795ed07d948.camel@kernel.org>
 <20210707135129.GA9446@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707135129.GA9446@fieldses.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 09:51:29AM -0400, J. Bruce Fields wrote:
> On Wed, Jul 07, 2021 at 07:40:47AM -0400, Jeff Layton wrote:
> > On Wed, 2021-07-07 at 12:51 +0200, Greg KH wrote:
> > > On Wed, Jul 07, 2021 at 06:44:42AM -0400, Jeff Layton wrote:
> > > > On Wed, 2021-07-07 at 08:05 +0200, Greg KH wrote:
> > > > > On Wed, Jul 07, 2021 at 10:35:47AM +0800, Desmond Cheong Zhi Xi wrote:
> > > > > > +	WARN_ON_ONCE(irqs_disabled());
> > > > > 
> > > > > If this triggers, you just rebooted the box :(
> > > > > 
> > > > > Please never do this, either properly handle the problem and return an
> > > > > error, or do not check for this.  It is not any type of "fix" at all,
> > > > > and at most, a debugging aid while you work on the root problem.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > Wait, what? Why would testing for irqs being disabled and throwing a
> > > > WARN_ON in that case crash the box?
> > > 
> > > If panic-on-warn is enabled, which is a common setting for systems these
> > > days.
> > 
> > Ok, that makes some sense.
> 
> Wait, I don't get it.
> 
> How are we supposed to decide when to use WARN, when to use BUG, and
> when to panic?  Do we really want to treat them all as equivalent?  And
> who exactly is turning on panic-on-warn?

You never use WARN or BUG, unless the system is so messed up that you
can not possibly recover from the issue.  Don't be lazy, handle the
error properly and report it upwards.

thanks,

greg k-h
