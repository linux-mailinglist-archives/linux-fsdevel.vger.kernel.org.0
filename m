Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8C6258636
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 05:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIADeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 23:34:12 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53021 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbgIADeM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:34:12 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id D07963A7791;
        Tue,  1 Sep 2020 13:34:06 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1kCx3d-0004UZ-UH; Tue, 01 Sep 2020 13:34:05 +1000
Date:   Tue, 1 Sep 2020 13:34:05 +1000
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
Message-ID: <20200901033405.GF12096@dread.disaster.area>
References: <20200829180448.GQ1236603@ZenIV.linux.org.uk>
 <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk>
 <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org>
 <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org>
 <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
 <20200831132339.GD14765@casper.infradead.org>
 <20200831142532.GC4267@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831142532.GC4267@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=XJ9OtjpE c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=reM5J-MqmosA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=xfEPbtm7c9O_VaNvSaEA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 10:25:32AM -0400, Theodore Y. Ts'o wrote:
> On Mon, Aug 31, 2020 at 02:23:39PM +0100, Matthew Wilcox wrote:
> > On Mon, Aug 31, 2020 at 01:51:20PM +0200, Miklos Szeredi wrote:
> > > On Mon, Aug 31, 2020 at 1:37 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > 
> > > > As I said to Dave, you and I have a strong difference of opinion here.
> > > > I think that what you are proposing is madness.  You're making it too
> > > > flexible which comes with too much opportunity for abuse.
> > > 
> > > Such as?
> > 
> > One proposal I saw earlier in this thread was to do something like
> > $ runalt /path/to/file ls
> > which would open_alt() /path/to/file, fchdir to it and run ls inside it.
> > That's just crazy.
> 
> As I've said before, malware authors would love that features.  Most
> system administrators won't.
> 
> Oh, one other question about ADS; if a file system supports reflink,
> what is supposed to happen when you reflink a file?  You have to
> consider all of the ADS's to be reflinked as well? 

Absolutely.

But, unlike your implication that this is -really complex and hard
to do-, it's actually relatively trivial to do with the XFS
implementation I mentioned as each ADS stream is a fully fledged
inode that can point to shared data extents. If you can do data
manipulation on a regular inode, you'll be able to do it on an ADS,
and that includes copying ADS streams via reflink.

Indeed, this actually makes the 'cp' utility able to support ADS
wihtout modification. i.e 'cp --reflink=always' will "copy" ADS data
automatically, without even needing to be aware they exist....

Such behaviour is almost certainly no harder to implement in XFS as
an atomic, recoverable operation than the "unlink removes all the
ADSs attached to the inode" requirement.....

> In some ways, this
> is good, because the overhead and complexity will probably cause most
> file system maintainers to throw up their had, say this is madness,
> and refuse to implement it.  :-)

I disagree: requiring reflink to actually "copy" ADS transparently
actually makes things easier for userspace support of ADS.  Thanks
for suggesting the idea, Ted. :)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
