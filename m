Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000D745B276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 04:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhKXDOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 22:14:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhKXDOA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 22:14:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9DF260EB5;
        Wed, 24 Nov 2021 03:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1637723451;
        bh=rQ6AWf7uy9nsILunXnpVUg3RXJwc/VG1QpA06daW0yU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AcJn3kDB3DWTclIRd+lHM2MGk+DJVAV5niJUSu+QxI4sZ9nGvmi1/KwU5htKzwSQh
         8+uInGOvjLjS8mcndyNJKtAKesA2Cv8DzrOaOa0quO+tTn358xI8FRd5LbMaaYtT+6
         8V1oHsx84Ly+IG/7GCsJWVC5vTImvGoR/GESZfDE=
Date:   Tue, 23 Nov 2021 19:10:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        gladkov.alexey@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] fs: proc: store PDE()->data into inode->i_private
Message-Id: <20211123191048.56b25c5d2459f78631a61bfb@linux-foundation.org>
In-Reply-To: <CAMZfGtV7pNaVNtzPCmXnGgeojPzyVxXSeawnp5znJxkjFweAgA@mail.gmail.com>
References: <20211119041104.27662-1-songmuchun@bytedance.com>
        <YZdQ+0D7n5xCnw5A@infradead.org>
        <20211119145643.21bbd5ee8e2830dd72d983e3@linux-foundation.org>
        <CAMZfGtV7pNaVNtzPCmXnGgeojPzyVxXSeawnp5znJxkjFweAgA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 22 Nov 2021 12:13:33 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> On Sat, Nov 20, 2021 at 6:56 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Thu, 18 Nov 2021 23:23:39 -0800 Christoph Hellwig <hch@infradead.org> wrote:
> >
> > > On Fri, Nov 19, 2021 at 12:11:04PM +0800, Muchun Song wrote:
> > > > +
> > > > +/*
> > > > + * Obtain the private data passed by user through proc_create_data() or
> > > > + * related.
> > > > + */
> > > > +static inline void *pde_data(const struct inode *inode)
> > > > +{
> > > > +   return inode->i_private;
> > > > +}
> > > > +
> > > > +#define PDE_DATA(i)        pde_data(i)
> > >
> > > What is the point of pde_data?
> >
> > It's a regular old C function, hence should be in lower case.
> >
> > I assume the upper case thing is a holdover from when it was
> > implemented as a macro.
> >
> > >  If we really think changing to lower
> > > case is worth it (I don't think so, using upper case for getting at
> > > private data is a common idiom in file systems),
> >
> > It is?  How odd.
> >
> > I find the upper-case thing to be actively misleading.  It's mildly
> > surprising to discover that it's actually a plain old C function.
> >
> > > we can just do that
> > > scripted in one go.
> >
> > Yes, I'd like to see a followup patch which converts the current
> > PDE_DATA() callsites.
> >
> 
> You mean replace all PDE_DATA with pde_data in another patch?

That is indeed what I meant.
