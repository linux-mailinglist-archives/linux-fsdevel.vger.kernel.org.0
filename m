Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29CB1ED6A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 21:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFCTTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 15:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCTS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 15:18:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A531AC08C5C0;
        Wed,  3 Jun 2020 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lrwx+3uqHzFddqxqcgr/zdMCuwvQi6n3hRWXrYFebv8=; b=uCuzDMXK9d3RRGVOEhuwsXMgGZ
        SOXOAc99JfOo6LdQfoGhu177kZVdOf7GClJeB2bUygphtFUu0cv94kkk6d1pTK1r/OsG/5P88QKHB
        UVwk4moBPK8jB/XjVVDttwFaDRfXouHIwR1Ctf/UsViQoCmeDDEHKeU29pPqKw/MkD6Rf/5SU8Ok+
        EtOGlpBee2+0JzZAAXWzsfOOY99HDP5Yrcf9I4AzWvWqcdSyHB37ykcKori8fuMVMxp48Ca8OUpiy
        J+OdKRKZmd8mEu064cyjIUOIijFPkbhnfwvAzGw5tHYKdmI/kzEaESaoLSPCM9UPMIX5cs+8CN+UC
        8H0rAM7A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgYub-0004tx-21; Wed, 03 Jun 2020 19:18:53 +0000
Date:   Wed, 3 Jun 2020 12:18:52 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz
Subject: Re: [PATCH] iomap: Return zero in case of unsuccessful pagecache
 invalidation before DIO
Message-ID: <20200603191852.GQ19604@bombadil.infradead.org>
References: <20200528192103.xm45qoxqmkw7i5yl@fiona>
 <20200529002319.GQ252930@magnolia>
 <20200601151614.pxy7in4jrvuuy7nx@fiona>
 <CAL3q7H60xa0qW4XdneDdeQyNcJZx7DxtwDiYkuWB5NoUVPYdwQ@mail.gmail.com>
 <CAL3q7H4=N2pfnBSiJ+TApy9kwvcPE5sB92sxcVZN10bxZqQpaA@mail.gmail.com>
 <20200603190252.GG8204@magnolia>
 <CAL3q7H4gHHHKMNifbTthvT3y3KaTZDSX+L0z7f1uXz7rzDe8BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4gHHHKMNifbTthvT3y3KaTZDSX+L0z7f1uXz7rzDe8BA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 03, 2020 at 08:10:50PM +0100, Filipe Manana wrote:
> On Wed, Jun 3, 2020 at 8:02 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > On Wed, Jun 03, 2020 at 12:32:15PM +0100, Filipe Manana wrote:
> > > On Wed, Jun 3, 2020 at 12:23 PM Filipe Manana <fdmanana@gmail.com> wrote:
> > > > Btw, this is causing a regression in Btrfs now. The problem is that
> > > > dio_warn_stale_pagecache() sets an EIO error in the inode's mapping:
> > > >
> > > > errseq_set(&inode->i_mapping->wb_err, -EIO);
> > > >
> > > > So the next fsync on the file will return that error, despite the
> > > > fsync having completed successfully with any errors.
> > > >
> > > > Since patchset to make btrfs direct IO use iomap is already in Linus'
> > > > tree, we need to fix this somehow.
> >
> > Y'all /just/ sent the pull request containing that conversion 2 days
> > ago.  Why did you move forward with that when you knew there were
> > unresolved fstests failures?
> >
> > Now I'm annoyed because I feel like you're trying to strong-arm me into
> > making last minute changes to iomap when you could have held off for
> > another cycle.
> 
> If you are talking to me, I'm not trying to strong-arm anyone nor
> point a fingers.
> I'm just reporting a problem that I found earlier today while testing
> some work I was doing.

I think the correct response to having just found the bug is to back the
btrfs-to-iomap conversion out of Linus' tree.  I don't think changing
the iomap code at this time is the right approach.
