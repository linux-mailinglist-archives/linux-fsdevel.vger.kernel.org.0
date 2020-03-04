Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5892817933A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgCDPWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 10:22:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbgCDPWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:22:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583335373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eTaBFBZPc0pfImLCT+DWWsM1zO1I+2p7UGeVMcw2jEk=;
        b=LPpRnl+HXUq4mRnQUPxbaIXBJBLxThZf6OqDMAVoxIRqflqAmV8wAdHNPi0RmjNvazNGVA
        LuSeOQVcNMR9t2YD/5j9K2KM4DJJDYP39DyN9nAKu5mbKys/3mNd1SQfBWLmezWETFskvD
        fKwqnC0Sd1AHdbJMoomLg5Ep9BoWdcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-aH2beAGrNZG6ypYcSKXG9g-1; Wed, 04 Mar 2020 10:22:50 -0500
X-MC-Unique: aH2beAGrNZG6ypYcSKXG9g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E27C31005510;
        Wed,  4 Mar 2020 15:22:47 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE6991D7D;
        Wed,  4 Mar 2020 15:22:44 +0000 (UTC)
Date:   Wed, 4 Mar 2020 16:22:41 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
Message-ID: <20200304152241.iaiulvl5xisnuxp6@ws.net.home>
References: <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
 <20200303113814.rsqhljkch6tgorpu@ws.net.home>
 <20200303130347.GA2302029@kroah.com>
 <33d900c8061c40f70ba2b9d1855fd6bd1c2b68bb.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d900c8061c40f70ba2b9d1855fd6bd1c2b68bb.camel@themaw.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:01:33AM +0800, Ian Kent wrote:
> On Tue, 2020-03-03 at 14:03 +0100, Greg Kroah-Hartman wrote:
> > Actually, I like this idea (the syscall, not just the unlimited
> > beers).
> > Maybe this could make a lot of sense, I'll write some actual tests
> > for
> > it now that syscalls are getting "heavy" again due to CPU vendors
> > finally paying the price for their madness...
> 
> The problem isn't with open->read->close but with the mount info.
> changing between reads (ie. seq file read takes and drops the
> needed lock between reads at least once).

readfile() is not reaction to mountinfo. 

The motivation is that we have many places with trivial
open->read->close for very small text files due to /sys and /proc. The
current way how kernel delivers these small strings to userspace seems
pretty inefficient if we can do the same by one syscall.

    Karel

$ strace -e openat,read,close -c ps aux
...
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 43.32    0.004190           4       987           read
 31.42    0.003039           3       844         4 openat
 25.26    0.002443           2       842           close
------ ----------- ----------- --------- --------- ----------------
100.00    0.009672                  2673         4 total

$ strace -e openat,read,close -c lsns
...
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 39.95    0.001567           2       593           openat
 30.93    0.001213           2       597           close
 29.12    0.001142           3       365           read
------ ----------- ----------- --------- --------- ----------------
100.00    0.003922                  1555           total


$ strace -e openat,read,close -c lscpu
...
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 44.67    0.001480           7       189        52 openat
 34.77    0.001152           6       180           read
 20.56    0.000681           4       140           close
------ ----------- ----------- --------- --------- ----------------
100.00    0.003313                   509        52 total


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

