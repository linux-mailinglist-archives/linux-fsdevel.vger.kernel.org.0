Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8995625A4F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 07:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIBFTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 01:19:38 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52343 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726177AbgIBFTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 01:19:37 -0400
Received: from dread.disaster.area (pa49-195-191-192.pa.nsw.optusnet.com.au [49.195.191.192])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 328F23A705E;
        Wed,  2 Sep 2020 15:19:31 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kDLBC-00087G-Uv; Wed, 02 Sep 2020 15:19:30 +1000
Date:   Wed, 2 Sep 2020 15:19:30 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: Re: xattr names for unprivileged stacking?
Message-ID: <20200902051930.GJ12096@dread.disaster.area>
References: <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
 <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org>
 <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
 <20200831132339.GD14765@casper.infradead.org>
 <20200831142532.GC4267@mit.edu>
 <20200901033405.GF12096@dread.disaster.area>
 <20200901145205.GA558530@mit.edu>
 <20200901151453.GC558530@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901151453.GC558530@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=KcmsTjQD c=1 sm=1 tr=0 cx=a_idp_d
        a=vvDRHhr1aDYKXl+H6jx2TA==:117 a=vvDRHhr1aDYKXl+H6jx2TA==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=7-415B0cAAAA:8
        a=8nLuUakjdfBH0j0kmMAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:14:53AM -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 01, 2020 at 10:52:05AM -0400, Theodore Y. Ts'o wrote:
> > On Tue, Sep 01, 2020 at 01:34:05PM +1000, Dave Chinner wrote:
> > > 
> > > But, unlike your implication that this is -really complex and hard
> > > to do-, it's actually relatively trivial to do with the XFS
> > > implementation I mentioned as each ADS stream is a fully fledged
> > > inode that can point to shared data extents. If you can do data
> > > manipulation on a regular inode, you'll be able to do it on an ADS,
> > > and that includes copying ADS streams via reflink.
> > 
> > Is the reflink system call on a file with ADS's atomic, or not?

We can implement as wholly atomic if we want to, yes.

> > What
> > if there are a million files is ADS hierarchy which is 100
> > subdirectories deep in some places, comprising several TB's worth of
> > data?  Is that all going to fit in a single XFS transaction?

No, but we solved that "unbound transaction size" problem years ago
for reflink and reverse mapping updates. We have constructs like
intents and rolling atomic transactions to allow largely unbound
modifications to run without being limited by the maximum size
of a single transaction or even the size of the journal...

> > What if
> > you crash in the middle of it?

Intents track modification progress and allow recovery to restart
from exactly where the journal says the operation had got to....

> > Is a partially reflinked copy of an
> > ADS file OK?

Yes.

> > Or a reflinked ADS file missing some portion of the
> > alternate data streams?

I don't know what this is refering to.

> Oh, and if the answer is that the ADS inodes should be reflinked
> individually in userspace, wonderful!

You can do that too, if you want - FI_CLONE/clone_file_range work on
open file descriptors, not file names, so if you can represent an
ADS as a file descriptor, you can clone it, dedupe it, etc, just
like you can with an other user data file.

> An ADS inode could then just be
> a directory, like it was in the NeXT operating system, and copying an
> ADS file could *also* be done in userspace, as a cp -r.   :-)

And then you lose all the atomicity and recoverability of reflink
copies. So, not they are not equivalent, and demonstrate where the
limits of representing ADS as "directories in a file" reduce the
ability to atomically manipulate ADS as group of objects attached to
a file...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
