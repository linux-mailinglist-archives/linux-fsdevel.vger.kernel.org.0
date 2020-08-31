Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9E325788A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 13:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHaLhP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgHaLhP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:37:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FC6C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kjuN3gLdNihgCEy8rhP06D5tqIj478uvJxaVYMG3EL0=; b=krPl0fsIszusDuXvtX/eALx9LR
        SzJOID/eYRzCyy4GZziByj+afvsPGnv2/kCrsZpri/yRy9rTfrxGgBzddeS3Yhnnhvj5J9DyqoHfJ
        SFEAnryxN1nXYfMz1vU+Nkr09F47tKS6zr4yOFMDZdKfRt+sVpWX06ZDdtU4TelOuZHTjylpR/441
        CHAYmkTfK0Y4hu/y4MtpbZLcviMoECrvtwDJyTSSxOKQAK42PTRsA95DaDLZW5Y3sHPs3yM9+fpGU
        Sx3Lokp0I7EAhi9tWQFaFY1izmdKO1LwtQy8GVaa7BAxNVV9PMovPhLYvdlxIRXeQJ/bBxCDfq0+A
        WvB6KREA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCi7V-0001Yk-B7; Mon, 31 Aug 2020 11:37:05 +0000
Date:   Mon, 31 Aug 2020 12:37:05 +0100
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
Message-ID: <20200831113705.GA14765@casper.infradead.org>
References: <20200827222457.GB12096@dread.disaster.area>
 <20200829160717.GS14765@casper.infradead.org>
 <20200829161358.GP1236603@ZenIV.linux.org.uk>
 <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
 <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 09:34:20AM +0200, Miklos Szeredi wrote:
> On Sun, Aug 30, 2020 at 9:10 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Aug 30, 2020 at 09:05:40PM +0200, Miklos Szeredi wrote:
> > > Yes, open(..., O_ALT) would be special.  Let's call it open_alt(2) to
> > > avoid confusion with normal open on a normal filesystem.   No special
> > > casing anywhere at all.   It's a completely new interface that returns
> > > a file which either has ->read/write() or ->iterate() and which points
> > > to an inode with empty i_ops.
> >
> > I think fiemap() should be allowed on a stream.  After all, these extents
> > do exist.  But I'm opposed to allowing getdents(); it'll only encourage
> > people to think they can have non-files as streams.
> 
> Call it whatever you want.  I think getdents (without lseek!!!)  is a
> fine interface for enumeration.
> 
> Also let me stress again, that this ALT thing is not just about
> streams, but a generic interface for getting OOB/meta/whatever data
> for a given inode/path.  Hence it must have a depth of at least 2, but
> limiting it to 2 would again be shortsighted.

As I said to Dave, you and I have a strong difference of opinion here.
I think that what you are proposing is madness.  You're making it too
flexible which comes with too much opportunity for abuse.  I just want
to see alternate data streams for the same filename in order to support
existing use cases.  You seem to be able to want to create an entire
new world inside a file, and that's just too confusing.
