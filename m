Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 233B5ECA53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2019 22:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfKAVig (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Nov 2019 17:38:36 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33897 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbfKAVig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:38:36 -0400
Received: from dread.disaster.area (pa49-180-67-183.pa.nsw.optusnet.com.au [49.180.67.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 239EF3A03EA;
        Sat,  2 Nov 2019 08:38:26 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1iQech-0006ba-Hr; Sat, 02 Nov 2019 08:38:23 +1100
Date:   Sat, 2 Nov 2019 08:38:23 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
Message-ID: <20191101213823.GW4614@dread.disaster.area>
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
 <CAMuHMdXzyVBa4TZEc5eRaBzu50thgJ2TrHJLZqwhbQ=JASgWOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXzyVBa4TZEc5eRaBzu50thgJ2TrHJLZqwhbQ=JASgWOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=3wLbm4YUAFX2xaPZIabsgw==:117 a=3wLbm4YUAFX2xaPZIabsgw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=MeAgGD-zjQ4A:10
        a=7-415B0cAAAA:8 a=aJW9rHtRmq1v9DlCOwQA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 01, 2019 at 09:57:31PM +0100, Geert Uytterhoeven wrote:
> Hi Valdis,
> 
> On Thu, Oct 31, 2019 at 2:11 AM Valdis Kletnieks
> <valdis.kletnieks@vt.edu> wrote:
> > Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
> > patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
> > (c) if one patch, who gets to shepherd it through?
> >
> > There's currently 6 filesystems that have the same #define. Move it
> > into errno.h so it's defined in just one place.
> >
> > Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> 
> Thanks for your patch!
> 
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -98,6 +98,7 @@
> >  #define        EINPROGRESS     115     /* Operation now in progress */
> >  #define        ESTALE          116     /* Stale file handle */
> >  #define        EUCLEAN         117     /* Structure needs cleaning */
> > +#define        EFSCORRUPTED    EUCLEAN
> 
> I have two questions:
> a) Why not use EUCLEAN everywhere instead?
>     Having two different names for the same errno complicates grepping.

Because:
	a) EUCLEAN is horrible for code documentation. EFSCORRUPTED
	describes exactly the error being returned and/or checked for.

	b) we've used EFSCORRUPTED in XFS since 1993. i.e. it was an
	official, published error value on Irix, and we've kept it
	in the linux code for the past ~20 years because of a)

	c) Userspace programs that include filesystem specific
	headers have already been exposed to and use EFSCORRUPTED,
	so we can't remove/change it without breaking userspace.

	d) EUCLEAN has a convenient userspace string description
	that is appropriate for filesystem corruption: "Structure
	needs cleaning" is precisely what needs to happen. Repair of
	the filesystem (i.e. recovery to a clean state) is what is
	required to fix the error....

> b) Perhaps both errors should use different values?

That horse bolted to userspace years ago - this is just formalising
the practice that has spread across multiple linux filesystems from
XFS over the past ~10 years..

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
