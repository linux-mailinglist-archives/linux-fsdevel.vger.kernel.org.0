Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847073BE90B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 15:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhGGNyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 09:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhGGNyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 09:54:11 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4B9C061574;
        Wed,  7 Jul 2021 06:51:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id B9C216830; Wed,  7 Jul 2021 09:51:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B9C216830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1625665889;
        bh=gPeRkpFOKLgol1iXgNjO2sQ0E29J+JaZmTVNPoXkTRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jod3VyGB4DhCJ+ICEBNzHaBiknO3C7zMEnZQxrc/ZyshSnI1azu8Jh3xQnRFlipuj
         eR+qgYiI0+vGTgH8Xb8eLUH4XMWmI/sN5jqPPlWTVKuDy5O0oOHIgQ8MD1naUe/Bes
         pbR2I2qCyVrFFtcEFK4qe4dIzAbxSHnGFEFhyTJw=
Date:   Wed, 7 Jul 2021 09:51:29 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e6d5398a02c516ce5e70@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] fcntl: fix potential deadlocks for
 &fown_struct.lock
Message-ID: <20210707135129.GA9446@fieldses.org>
References: <20210707023548.15872-1-desmondcheongzx@gmail.com>
 <20210707023548.15872-2-desmondcheongzx@gmail.com>
 <YOVENb3X/m/pNrYt@kroah.com>
 <14633c3be87286d811263892375f2dfa9a8ed40a.camel@kernel.org>
 <YOWHKk6Nq8bazYjB@kroah.com>
 <4dda1cad6348fced5fcfcb6140186795ed07d948.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dda1cad6348fced5fcfcb6140186795ed07d948.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 07, 2021 at 07:40:47AM -0400, Jeff Layton wrote:
> On Wed, 2021-07-07 at 12:51 +0200, Greg KH wrote:
> > On Wed, Jul 07, 2021 at 06:44:42AM -0400, Jeff Layton wrote:
> > > On Wed, 2021-07-07 at 08:05 +0200, Greg KH wrote:
> > > > On Wed, Jul 07, 2021 at 10:35:47AM +0800, Desmond Cheong Zhi Xi wrote:
> > > > > +	WARN_ON_ONCE(irqs_disabled());
> > > > 
> > > > If this triggers, you just rebooted the box :(
> > > > 
> > > > Please never do this, either properly handle the problem and return an
> > > > error, or do not check for this.  It is not any type of "fix" at all,
> > > > and at most, a debugging aid while you work on the root problem.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Wait, what? Why would testing for irqs being disabled and throwing a
> > > WARN_ON in that case crash the box?
> > 
> > If panic-on-warn is enabled, which is a common setting for systems these
> > days.
> 
> Ok, that makes some sense.

Wait, I don't get it.

How are we supposed to decide when to use WARN, when to use BUG, and
when to panic?  Do we really want to treat them all as equivalent?  And
who exactly is turning on panic-on-warn?

--b.
