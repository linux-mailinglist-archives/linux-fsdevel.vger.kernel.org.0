Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFC214C3E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 13:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGEL6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 07:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgGEL6u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 07:58:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6F5820708;
        Sun,  5 Jul 2020 11:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593950329;
        bh=pEThZSurgEAGI6bD+iWUpXIlCqpTIfabn5t/AHWOQ6M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QdZlzL5SQXxiIeV3CUEn3VhPIvbTnfU6UpG6IjAHEklPweIXNnomInzKT+zTi2sHy
         AMdqOR/QdJN3kK4RgJ5Q5WL+pyNevx/K6ERDjL6AD0zpE5VTy2Lp9kCdMf6Mwpb42t
         X/oL4jT+z/nmZEHkoVxsWSUSG6NcJoiCGry+TBw0=
Date:   Sun, 5 Jul 2020 13:58:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705115851.GB1227929@kroah.com>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
 <20200705031208.GS25523@casper.infradead.org>
 <CAODFU0q=nDdx7D1NUxTQshBjqgTCYPpKzog78XZLjoPqnZqXvw@mail.gmail.com>
 <20200705032732.GT25523@casper.infradead.org>
 <CAODFU0rSqQsO9rSiA8Ke=+mk_NgEdFDHPMfmXGSmzmkqQh1KYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0rSqQsO9rSiA8Ke=+mk_NgEdFDHPMfmXGSmzmkqQh1KYw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 06:09:03AM +0200, Jan Ziak wrote:
> On Sun, Jul 5, 2020 at 5:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Jul 05, 2020 at 05:18:58AM +0200, Jan Ziak wrote:
> > > On Sun, Jul 5, 2020 at 5:12 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > You should probably take a look at io_uring.  That has the level of
> > > > complexity of this proposal and supports open/read/close along with many
> > > > other opcodes.
> > >
> > > Then glibc can implement readfile using io_uring and there is no need
> > > for a new single-file readfile syscall.
> >
> > It could, sure.  But there's also a value in having a simple interface
> > to accomplish a simple task.  Your proposed API added a very complex
> > interface to satisfy needs that clearly aren't part of the problem space
> > that Greg is looking to address.
> 
> I believe that we should look at the single-file readfile syscall from
> a performance viewpoint. If an application is expecting to read a
> couple of small/medium-size files per second, then neither readfile
> nor readfiles makes sense in terms of improving performance. The
> benefits start to show up only in case an application is expecting to
> read at least a hundred of files per second. The "per second" part is
> important, it cannot be left out. Because readfile only improves
> performance for many-file reads, the syscall that applications
> performing many-file reads actually want is the multi-file version,
> not the single-file version.

It also is a measurable increase over reading just a single file.
Here's my really really fast AMD system doing just one call to readfile
vs. one call sequence to open/read/close:

	$ ./readfile_speed -l 1
	Running readfile test on file /sys/devices/system/cpu/vulnerabilities/meltdown for 1 loops...
	Took 3410 ns
	Running open/read/close test on file /sys/devices/system/cpu/vulnerabilities/meltdown for 1 loops...
	Took 3780 ns

370ns isn't all that much, yes, but it is 370ns that could have been
used for something else :)

Look at the overhead these days of a syscall using something like perf
to see just how bad things have gotten on Intel-based systems (above was
AMD which doesn't suffer all the syscall slowdowns, only some).

I'm going to have to now dig up my old rpi to get the stats on that
thing, as well as some Intel boxes to show the problem I'm trying to
help out with here.  I'll post that for the next round of this patch
series.

> I am not sure I understand why you think that a pointer to an array of
> readfile_t structures is very complex. If it was very complex then it
> would be a deep tree or a large graph.

Of course you can make it more complex if you want, but look at the
existing tools that currently do many open/read/close sequences.  The
apis there don't lend themselves very well to knowing the larger list of
files ahead of time.  But I could be looking at the wrong thing, what
userspace programs are you thinking of that could be easily converted
into using something like this?

thanks,

greg k-h
