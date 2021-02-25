Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DE324E24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 11:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbhBYK0b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 05:26:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:59690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235096AbhBYKVA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:21:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3ABAAAAE;
        Thu, 25 Feb 2021 10:19:59 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id a21891c8;
        Thu, 25 Feb 2021 10:21:04 +0000 (UTC)
Date:   Thu, 25 Feb 2021 10:21:04 +0000
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
Message-ID: <YDd6EMpvZhHq6ncM@suse.de>
References: <20210222102456.6692-1-lhenriques@suse.de>
 <20210224142307.7284-1-lhenriques@suse.de>
 <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 24, 2021 at 06:10:45PM +0200, Amir Goldstein wrote:
> On Wed, Feb 24, 2021 at 4:22 PM Luis Henriques <lhenriques@suse.de> wrote:
> >
> > Update man-page with recent changes to this syscall.
> >
> > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > ---
> > Hi!
> >
> > Here's a suggestion for fixing the manpage for copy_file_range().  Note that
> > I've assumed the fix will hit 5.12.
> >
> >  man2/copy_file_range.2 | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> > index 611a39b8026b..b0fd85e2631e 100644
> > --- a/man2/copy_file_range.2
> > +++ b/man2/copy_file_range.2
> > @@ -169,6 +169,9 @@ Out of memory.
> >  .B ENOSPC
> >  There is not enough space on the target filesystem to complete the copy.
> >  .TP
> > +.B EOPNOTSUPP
> > +The filesystem does not support this operation.
> > +.TP
> >  .B EOVERFLOW
> >  The requested source or destination range is too large to represent in the
> >  specified data types.
> > @@ -187,7 +190,7 @@ refers to an active swap file.
> >  .B EXDEV
> >  The files referred to by
> >  .IR fd_in " and " fd_out
> > -are not on the same mounted filesystem (pre Linux 5.3).
> > +are not on the same mounted filesystem (pre Linux 5.3 and post Linux 5.12).
> 
> I think you need to drop the (Linux range) altogether.
> What's missing here is the NFS cross server copy use case.
> Maybe:
> 
> ...are not on the same mounted filesystem and the source and target filesystems
> do not support cross-filesystem copy.
> 
> You may refer the reader to VERSIONS section where it will say which
> filesystems support cross-fs copy as of kernel version XXX (i.e. cifs and nfs).
> 
> >  .SH VERSIONS
> >  The
> >  .BR copy_file_range ()
> > @@ -202,6 +205,11 @@ Applications should target the behaviour and requirements of 5.3 kernels.
> >  .PP
> >  First support for cross-filesystem copies was introduced in Linux 5.3.
> >  Older kernels will return -EXDEV when cross-filesystem copies are attempted.
> > +.PP
> > +After Linux 5.12, support for copies between different filesystems was dropped.
> > +However, individual filesystems may still provide
> > +.BR copy_file_range ()
> > +implementations that allow copies across different devices.
> 
> Again, this is not likely to stay uptodate for very long.
> The stable kernels are expected to apply your patch (because it fixes
> a regression)
> so this should be phrased differently.
> If it were me, I would provide all the details of the situation to
> Michael and ask him
> to write the best description for this section.

Thanks Amir.

Yeah, it's tricky.  Support was added and then dropped.   Since stable
kernels will be picking this patch,  maybe the best thing to do is to no
mention the generic cross-filesystem support at all...?  Or simply say
that 5.3 temporarily supported it but that support was later dropped.

Michael (or Alejandro), would you be OK handling this yourself as Amir
suggested?

Cheers,
--
Luís
