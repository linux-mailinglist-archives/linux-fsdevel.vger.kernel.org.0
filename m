Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACDE254AC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 18:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH0QgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 12:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0QgA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:36:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7F5C061264
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2020 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=POz5KlPWoab8xpm5ZTfkzmvuB0rA075XsfUD5LnpLLo=; b=FYrSMosgDevmZFyCi3r9m2B4uK
        hGA3iJjNl1ZeH8l4XKM0Qzrlx1Ik3Pu0iex7E4LWHGYUblom9uerLX4+4cAsKYf88Zap+VVYL6j8+
        /poqUQABAXSAIr+KoayB0inzRaWWTbM0VvwOArTc575EzBo1O/lapqOW24QomJ6vOXKmxHGJCHQ0r
        9N8icesr+hxh9EWGWO2/wYAOSgOZ4jSvfZYEPmeEt+w+MhzUwue4tqAvejdfiHwDttHzD9xSy6ZFs
        tE0mZxYR8tGfJpBjOKw0y2Sfd2IhIiBttNJ6ym87OyedWYFpLWWzp1W30wliSNksV3idnwsCkWOPL
        u9SL1TAg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBKsC-0002hC-CN; Thu, 27 Aug 2020 16:35:36 +0000
Date:   Thu, 27 Aug 2020 17:35:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Frank van der Linden <fllinden@amazon.com>,
        Dave Chinner <david@fromorbit.com>, Greg Kurz <groug@kaod.org>,
        linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged
 stacking?)
Message-ID: <20200827163536.GK14765@casper.infradead.org>
References: <20200824222924.GF199705@mit.edu>
 <3331978.UQhOATu6MC@silver>
 <20200827140107.GH14765@casper.infradead.org>
 <159855515.fZZa9nWDzX@silver>
 <20200827144452.GA1236603@ZenIV.linux.org.uk>
 <20200827162935.GC2837@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827162935.GC2837@work-vm>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 05:29:35PM +0100, Dr. David Alan Gilbert wrote:
> * Al Viro (viro@zeniv.linux.org.uk) wrote:
> > On Thu, Aug 27, 2020 at 04:23:24PM +0200, Christian Schoenebeck wrote:
> > 
> > > Be invited for making better suggestions. But one thing please: don't start 
> > > getting offending.
> > > 
> > > No matter which delimiter you'd choose, something will break. It is just about 
> > > how much will it break und how likely it'll be in practice, not if.
> > 
> > ... which means NAK.  We don't break userland without very good reasons and
> > support for anyone's pet feature is not one of those.  It's as simple as
> > that.
> 
> I'm curious how much people expect to use these forks from existing
> programs - do people expect to be able to do something and edit a fork
> using their favorite editor or cat/grep/etc them?
> 
> I say that because if they do, then having a special syscall to open
> the fork wont fly; and while I agree that any form of suffix is a lost
> cause, I wonder what else is possible (although if it wasn't for the
> internal difficulties, I do have a soft spot for things that look like
> both files and directories showing the forks; but I realise I'm weird
> there).

I also have fond memories of !SquashFS but the problem is that some
people want named streams on _directories_, which means that these
directories need to be both directories-of-files and directories-of-streams.
That's harder to disambiguate.

I think providing two new tools (or variants on existing tools) --
streamcat and streamls should be enough to enable operating on named
streams from the command line.  If other tools want to provide the ability
to operate on named streams directly, that would be up to that tool.
