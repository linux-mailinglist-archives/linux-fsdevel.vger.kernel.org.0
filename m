Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC32207B89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406102AbgFXSaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406095AbgFXSaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:30:04 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD6C061573;
        Wed, 24 Jun 2020 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YxfY4voDP1UhcO+l6FbB+Nx2rRw+jE/Yukegx6aKPqw=; b=nOPZsU1FrUeTZMqMVbvJKpxt8v
        1WLdpn2e0diIqc8X8j8FaWSoYsf9Kr/RbZrEiR1MkHurJXfEK8K5fsPAToLTZWSuBYLO+nYwkovtT
        fM+OYU9k/CamxXhQFaz+E8EUBvG4KDLwOizxmJ7TmPxQDHGSoCMIe74m+Cr+3Fm64cc+rvhixgluX
        vqIaDTsPddb73S9NvUytR4I0KMl9pOk9Gnkp/QzhQbsvHvW2Mf3zSA3e81fDvqFvUhtgzcPFzJpnS
        C4j0SQvz6m3NC9PRWW3g3szWZGnNWFlk6vHVLQ5gqoYfyZnI4G+sdHe5JFzQmjreCUIdFOF+Evllr
        ZnYYxMzg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joA9Y-0004Im-IU; Wed, 24 Jun 2020 18:29:44 +0000
Date:   Wed, 24 Jun 2020 19:29:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200624182944.GT21350@casper.infradead.org>
References: <20200624162901.1814136-1-hch@lst.de>
 <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de>
 <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <20200624181437.GA26277@lst.de>
 <CAHk-=wgC4a9rKrKLTHbH5cA5dyaqqy4Hnsr+re144AiJuNwv9Q@mail.gmail.com>
 <20200624182437.GB26405@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624182437.GB26405@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:24:37PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 11:20:26AM -0700, Linus Torvalds wrote:
> > On Wed, Jun 24, 2020 at 11:14 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > So we'd need new user copy functions for just those cases
> > 
> > No. We'd open-code them. They'd look at "oh, I'm supposed to use a
> > kernel pointer" and just use those.
> > 
> > IOW, basically IN THE CODE that cares (and the whole argument is that
> > this code is one or two special cases) you do
> > 
> >     /* This has not been converted to the new world order */
> >     if (get_fs() == KERNEL_DS) memcpy(..) else copy_from_user();
> > 
> > You're overdesigning things. You're making them more complex than they
> > need to be.
> 
> I wish it was so simple.  I really don't like overdesigns, trust me.
> 
> But please take a look at setsockopt and all the different instances
> (count 90 .setsockopt wireups, and they then branch out into
> various subroutines as well).  I really don't want to open code that
> there, but we could do helper specific to setsockopt.

Can we do a setsockopt_iter() which replaces optval/optlen with an iov_iter?
