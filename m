Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBAB2569D9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Aug 2020 21:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgH2TZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Aug 2020 15:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbgH2TZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:25:56 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96EAC061236
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2020 12:25:56 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kC6Ta-0079Df-Jd; Sat, 29 Aug 2020 19:25:22 +0000
Date:   Sat, 29 Aug 2020 20:25:22 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200829192522.GS1236603@ZenIV.linux.org.uk>
References: <20200816225620.GA28218@dread.disaster.area>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <20200827152207.GJ14765@casper.infradead.org>
 <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 29, 2020 at 09:13:24PM +0200, Miklos Szeredi wrote:

> > d_path() is the least of the problems, actually.  Directory tree structure on
> > those, OTOH, is a serious problem.  If you want to have getdents(2) on that
> > shite, you want an opened descriptor that looks like a directory.  And _that_
> > opens a large can of worms.  Because now you have fchdir(2) to cope with,
> > lookups going through /proc/self/fd/<n>/..., etc., etc.
> 
> Seriously, nobody wants fchdir().  And getdents() does not imply fchdir().

Yes, it does.  If it's a directory, fchdir(2) gets to deal with it.
If it's not, no getdents(2).  Unless you special-case the damn thing in
said fchdir(2).

> As for whether we'd need foobarat() on such a beast or let
> /proc/self/fd/<n> be dereferenced, I think no.  So comes the argument:
>  but then we'll break all those libraries and whatnot relying on these
> constructs.  Well, sorry, so would we if we didn't introduce this in
> the first place.  That's not really breaking anything, it's just
> setting expectations.

Translation: we'll special-case that in procfs, etc., etc. and handwave
the problems away.  Lovely...
