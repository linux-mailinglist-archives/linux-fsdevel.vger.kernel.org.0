Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D43A1795B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbgCDQtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388063AbgCDQtV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:49:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C2922B48;
        Wed,  4 Mar 2020 16:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583340556;
        bh=htZq3MKYG3/FJ8bILu0qqA54TuTZg4n2O0B4bA60sUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFw/Q1NY4B+y7WTrekje+ZpgNyFzrIcZ7UTABnDsnjgXf0am4nQsbW5ZVxTNNjWld
         6g3+cMHNGJFGxmjYQ7wuvpNbSuU4C8wJW0QIQn6siOMOjhXevPQyX+4tWUsOTV/oDy
         NWsKv9WocDxBZSqHQrN8bsD7sTiXcsBN4pte4wXQ=
Date:   Wed, 4 Mar 2020 17:49:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200304164913.GB1763256@kroah.com>
References: <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <33d900c8061c40f70ba2b9d1855fd6bd1c2b68bb.camel@themaw.net>
 <20200304152241.iaiulvl5xisnuxp6@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304152241.iaiulvl5xisnuxp6@ws.net.home>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:22:41PM +0100, Karel Zak wrote:
> On Wed, Mar 04, 2020 at 10:01:33AM +0800, Ian Kent wrote:
> > On Tue, 2020-03-03 at 14:03 +0100, Greg Kroah-Hartman wrote:
> > > Actually, I like this idea (the syscall, not just the unlimited
> > > beers).
> > > Maybe this could make a lot of sense, I'll write some actual tests
> > > for
> > > it now that syscalls are getting "heavy" again due to CPU vendors
> > > finally paying the price for their madness...
> > 
> > The problem isn't with open->read->close but with the mount info.
> > changing between reads (ie. seq file read takes and drops the
> > needed lock between reads at least once).
> 
> readfile() is not reaction to mountinfo. 
> 
> The motivation is that we have many places with trivial
> open->read->close for very small text files due to /sys and /proc. The
> current way how kernel delivers these small strings to userspace seems
> pretty inefficient if we can do the same by one syscall.
> 
>     Karel
> 
> $ strace -e openat,read,close -c ps aux
> ...
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  43.32    0.004190           4       987           read
>  31.42    0.003039           3       844         4 openat
>  25.26    0.002443           2       842           close
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    0.009672                  2673         4 total
> 
> $ strace -e openat,read,close -c lsns
> ...
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  39.95    0.001567           2       593           openat
>  30.93    0.001213           2       597           close
>  29.12    0.001142           3       365           read
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    0.003922                  1555           total
> 
> 
> $ strace -e openat,read,close -c lscpu
> ...
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  44.67    0.001480           7       189        52 openat
>  34.77    0.001152           6       180           read
>  20.56    0.000681           4       140           close
> ------ ----------- ----------- --------- --------- ----------------
> 100.00    0.003313                   509        52 total

As a "real-world" test, would you recommend me converting one of the
above tools to my implementation of readfile to see how/if it actually
makes sense, or do you have some other tool you would rather see me try?

thanks,

greg k-h
