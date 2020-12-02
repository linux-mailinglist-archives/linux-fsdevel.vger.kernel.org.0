Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE02A2CB62F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 09:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgLBIEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 03:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387539AbgLBIEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:04:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627A0C0613CF;
        Wed,  2 Dec 2020 00:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uDBxn7MSIWHkb+0YhIz9IAuuaks9YFfm8h/fjLDE0Gg=; b=DyLJfLwoYd7AJsMsJ639+D7rFC
        Sv0fi5GI4grXGVtC7zThS3idLOU7j3eFG72t5458yA/ypko/CVOG9EQItQ3aTWtAnaVjpAL0XMBFc
        RVtS8VFzkZzU3vlIDnAWIEjmz2zBRrOvSSYWjAAdnF6YsCwV/kyyIks3+xXDTS5rIviQupaKv97yT
        BSZ5/jVWJmUOyFshZNHwobY6eYHKamM7Wrj2m7vdE1lrNEeo5LzhRd4xL6BkcF2tRqk8EQpwCjrB/
        jxhn7CbHD1jY3FYNnP7CqomcGEvAuFc4bJ929jRjgb7kd0aNwH2Ax+ylhqS4e0yPsNZZeopdj3+7J
        v1AbBNiA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkN70-0004Jt-2u; Wed, 02 Dec 2020 08:03:42 +0000
Date:   Wed, 2 Dec 2020 08:03:42 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoli Feng <xifeng@redhat.com>
Subject: Re: [PATCH 2/2] statx: move STATX_ATTR_DAX attribute handling to
 filesystems
Message-ID: <20201202080342.GB15726@infradead.org>
References: <e388f379-cd11-a5d2-db82-aa1aa518a582@redhat.com>
 <05a0f4fd-7f62-8fbc-378d-886ccd5b3f11@redhat.com>
 <20201201173905.GI143045@magnolia>
 <20201201205243.GK2842436@dread.disaster.area>
 <9ab51770-1917-fc05-ff57-7677f17b6e44@sandeen.net>
 <CAHk-=wjymrd42E6XfiXwR3NF5Fs4EhTzhUukCojEWpz0Vagvtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjymrd42E6XfiXwR3NF5Fs4EhTzhUukCojEWpz0Vagvtw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:12:19PM -0800, Linus Torvalds wrote:
> On Tue, Dec 1, 2020 at 2:03 PM Eric Sandeen <sandeen@sandeen.net> wrote:
> >
> > That's why I was keen to just add DAX unconditionally at this point, and if we want
> > to invent/refine meanings for the mask, we can still try to do that?
> 
> Oh Gods.  Let's *not* make this some "random filesystem choice" where
> now semantics depends on what some filesystem decided to do, and
> different filesystems have very subtly different semantics.
> 
> This all screams "please keep this in the VFS layer" so that we at
> least have _one_ place where these kinds of decisions are made.
> 
> I suspect very very few people actually end up caring about any of the
> STATX flags at all, of course. The fact that the DAX one was
> apparently entirely the wrong bit argues that this isn't all that
> important.

Agreed.  That whole support interface is just weird.  But the only
thing that remotely makes (a little bit of) sense is to just set all
bits known about by this particular kernel in the VFS.  Everything else
is going to be a complete mess.
