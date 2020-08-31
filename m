Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4A3257A4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgHaNXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 09:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaNXq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:23:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFB8C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UGABF2KCeW63W+ASYVLYgPWW4c67C4h7YV6l1pW7a2g=; b=cozp/v0FXDt6rAAhVaUA4TUTS4
        qT25Y6042rFq+ZuGQ39Wa5UbvC2dkLgz1dSEfvH3ufa3lLaLww1fYC9ZDIiY1gIm5yYwfbGnBBRs8
        5NP4/bkCxeuocOulnR2TqQCVTGY58uL3ahwv0aP4gYE1z0xsH485s8/EY3JkgIZP3283QpX5ELhDM
        TFIWNvtDspFz+qJiIpSsAVqjFRY936xvvpCIig8tyfoY86ZE7TEsrRIj4MGhQFchM2S/asWbGDSa2
        vEtkxNUUgor4P6opLF7q6nOZF48ilZsieK7hoNHOby67NJV58rMPWLahZaP9RH2nrtTg623Uc8rNa
        mXdY7iVg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCjmd-0000Y8-Mf; Mon, 31 Aug 2020 13:23:39 +0000
Date:   Mon, 31 Aug 2020 14:23:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200831132339.GD14765@casper.infradead.org>
References: <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
 <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org>
 <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 01:51:20PM +0200, Miklos Szeredi wrote:
> On Mon, Aug 31, 2020 at 1:37 PM Matthew Wilcox <willy@infradead.org> wrote:
> 
> > As I said to Dave, you and I have a strong difference of opinion here.
> > I think that what you are proposing is madness.  You're making it too
> > flexible which comes with too much opportunity for abuse.
> 
> Such as?

One proposal I saw earlier in this thread was to do something like
$ runalt /path/to/file ls
which would open_alt() /path/to/file, fchdir to it and run ls inside it.
That's just crazy.

> >  I just want
> > to see alternate data streams for the same filename in order to support
> > existing use cases.  You seem to be able to want to create an entire
> > new world inside a file, and that's just too confusing.
> 
> To whom?  I'm sure users of ancient systems with a flat directory
> found directory trees very confusing.  Yet it turned out that the
> hierarchical system beat the heck out of the flat one.

Which doesn't mean that multiple semi-hidden hierarchies are going to
be better than one visible hierarchy.
