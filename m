Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E59C209C1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 11:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403905AbgFYJn0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 05:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389532AbgFYJnW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:43:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E3020709;
        Thu, 25 Jun 2020 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593078201;
        bh=mSBu+4/jJPqb52V+9HZ8ffwpbzaCZEKDhH25+czhvss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6iJmk5fJBGfc4kyvKVDTxCRFn+/FBEJu5bsIB0qaWweWEf0wjpbEaMPSTULu8GRY
         B9eA3Q1UiTqvooaCn8L54AKkwI+8IZrIOB0OX6qP4pHLVp70BNHD29Zl1tV9leR4yW
         lnh8pjQuKsCBEiDvKOSr200Is/Sykrs6fvxsM0JY=
Date:   Thu, 25 Jun 2020 11:43:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Kent <raven@themaw.net>
Cc:     Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
Message-ID: <20200625094317.GA3299764@kroah.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20200619153833.GA5749@mtj.thefacebook.com>
 <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
 <20200619222356.GA13061@mtj.duckdns.org>
 <fa22c563-73b7-5e45-2120-71108ca8d1a0@linux.vnet.ibm.com>
 <20200622175343.GC13061@mtj.duckdns.org>
 <82b2379e-36d0-22c2-41eb-71571e992b37@linux.vnet.ibm.com>
 <20200623231348.GD13061@mtj.duckdns.org>
 <ac4a2c133da21856439f907989c3f9d781857cbf.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac4a2c133da21856439f907989c3f9d781857cbf.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 04:15:19PM +0800, Ian Kent wrote:
> On Tue, 2020-06-23 at 19:13 -0400, Tejun Heo wrote:
> > Hello, Rick.
> > 
> > On Mon, Jun 22, 2020 at 02:22:34PM -0700, Rick Lindsley wrote:
> > > > I don't know. The above highlights the absurdity of the approach
> > > > itself to
> > > > me. You seem to be aware of it too in writing: 250,000 "devices".
> > > 
> > > Just because it is absurd doesn't mean it wasn't built that way :)
> > > 
> > > I agree, and I'm trying to influence the next hardware design.
> > > However,
> > 
> > I'm not saying that the hardware should not segment things into
> > however many
> > pieces that it wants / needs to. That part is fine.
> > 
> > > what's already out there is memory units that must be accessed in
> > > 256MB
> > > blocks. If you want to remove/add a GB, that's really 4 blocks of
> > > memory
> > > you're manipulating, to the hardware. Those blocks have to be
> > > registered
> > > and recognized by the kernel for that to work.
> > 
> > The problem is fitting that into an interface which wholly doesn't
> > fit that
> > particular requirement. It's not that difficult to imagine different
> > ways to
> > represent however many memory slots, right? It'd take work to make
> > sure that
> > integrates well with whatever tooling or use cases but once done this
> > particular problem will be resolved permanently and the whole thing
> > will
> > look a lot less silly. Wouldn't that be better?
> 
> Well, no, I am finding it difficult to imagine different ways to
> represent this but perhaps that's because I'm blinker eyed on what
> a solution might look like because of my file system focus.
> 
> Can "anyone" throw out some ideas with a little more detail than we
> have had so far so we can maybe start to formulate an actual plan of
> what needs to be done.

I think both Tejun and I have provided a number of alternatives for you
all to look into, and yet you all keep saying that those are impossible
for some unknown reason.

It's not up to me to tell you what to do to fix your broken interfaces
as only you all know who is using this and how to handle those changes.

It is up to me to say "don't do that!" and to refuse patches that don't
solve the root problem here.  I'll review these later on (I have 1500+
patches to review at the moment) as these are a nice
micro-optimization...

And as this conversation seems to just going in circles, I think this is
going to be my last response to it...

greg k-h
