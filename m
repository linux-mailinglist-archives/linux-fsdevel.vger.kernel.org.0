Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F617574B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 10:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCBJiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 04:38:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:48898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgCBJix (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:38:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC4492469C;
        Mon,  2 Mar 2020 09:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583141932;
        bh=afyeUw5VnZbUAYoxsLpHi50eMt+vGabCRyRpK0qjkKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7FvmEYtAwbRISDQY7cpWbE7ZT2VmfjytHB0Oe5CwmLnlGScTHDDwtdd8WGhgId0i
         +CCLK/MeafrNAiTtz+T//uVq1jW+TmYqxUCPeO8KmncEje4PVrxfH6HWXFBHukW1Nh
         2cVO5WvoXFuBx218U3sXyT3ocQItiPz4TChWNmJA=
Date:   Mon, 2 Mar 2020 10:38:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200302093850.GA1998325@kroah.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com>
 <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com>
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 02, 2020 at 10:09:51AM +0100, Miklos Szeredi wrote:
> On Fri, Feb 28, 2020 at 5:36 PM David Howells <dhowells@redhat.com> wrote:
> >
> > sysfs also has some other disadvantages for this:
> >
> >  (1) There's a potential chicken-and-egg problem in that you have to create a
> >      bunch of files and dirs in sysfs for every created mount and superblock
> >      (possibly excluding special ones like the socket mount) - but this
> >      includes sysfs itself.  This might work - provided you create sysfs
> >      first.
> 
> Sysfs architecture looks something like this (I hope Greg will correct
> me if I'm wrong):
> 
> device driver -> kobj tree <- sysfs tree
> 
> The kobj tree is created by the device driver, and the dentry tree is
> created on demand from the kobj tree.   Lifetime of kobjs is bound to
> both the sysfs objects and the device but not the other way round.
> I.e. device can go away while the sysfs object is still being
> referenced, and sysfs can be freely mounted and unmounted
> independently of device initialization.
> 
> So there's no ordering requirement between sysfs mounts and other
> mounts.   I might be wrong on the details, since mounts are created
> very early in the boot process...
> 
> >
> >  (2) sysfs is memory intensive.  The directory structure has to be backed by
> >      dentries and inodes that linger as long as the referenced object does
> >      (procfs is more efficient in this regard for files that aren't being
> >      accessed)
> 
> See above: I don't think dentries and inodes are pinned, only kobjs
> and their associated cruft.  Which may be too heavy, depending on the
> details of the kobj tree.

That is correct, they should not be pinned, that is what kernfs handles
and why we can handle 30k virtual block devices on a 31bit s390 instance
:)

So you shouldn't have to worry about memory for sysfs.

There are loads of other reasons probably not to use sysfs for this
instead :)

thanks,

greg k-h
