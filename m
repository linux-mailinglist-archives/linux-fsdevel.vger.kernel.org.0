Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9733526CBA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 22:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgIPUaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 16:30:20 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:54220 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgIPRM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:12:58 -0400
Date:   Wed, 16 Sep 2020 11:36:19 -0400
From:   Rich Felker <dalias@libc.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfs: block chmod of symlinks
Message-ID: <20200916153618.GT3265@brightrain.aerifal.cx>
References: <20200916002157.GO3265@brightrain.aerifal.cx>
 <20200916002253.GP3265@brightrain.aerifal.cx>
 <20200916061815.GB142621@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916061815.GB142621@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 08:18:15AM +0200, Greg KH wrote:
> On Tue, Sep 15, 2020 at 08:22:54PM -0400, Rich Felker wrote:
> > It was discovered while implementing userspace emulation of fchmodat
> > AT_SYMLINK_NOFOLLOW (using O_PATH and procfs magic symlinks; otherwise
> > it's not possible to target symlinks with chmod operations) that some
> > filesystems erroneously allow access mode of symlinks to be changed,
> > but return failure with EOPNOTSUPP (see glibc issue #14578 and commit
> > a492b1e5ef). This inconsistency is non-conforming and wrong, and the
> > consensus seems to be that it was unintentional to allow link modes to
> > be changed in the first place.
> > 
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> >  fs/open.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/fs/open.c b/fs/open.c
> > index 9af548fb841b..cdb7964aaa6e 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -570,6 +570,12 @@ int chmod_common(const struct path *path, umode_t mode)
> >  	struct iattr newattrs;
> >  	int error;
> >  
> > +	/* Block chmod from getting to fs layer. Ideally the fs would either
> > +	 * allow it or fail with EOPNOTSUPP, but some are buggy and return
> > +	 * an error but change the mode, which is non-conforming and wrong. */
> > +	if (S_ISLNK(inode->i_mode))
> > +		return -EOPNOTSUPP;
> 
> I still fail to understand why these "buggy" filesystems can not be
> fixed.  Why are you papering over a filesystem-specific-bug with this

Because that's what Christoph wanted, and it seems exposure of the
vector for applying chmod to symlinks was unintentional to begin with.
I have no preference how this is fixed as long as breakage is not
exposed to userspace via the new fchmodat2 syscall (since a broken
syscall would be worse than not having it at all).

> core kernel change that we will forever have to keep?

There's no fundamental reason it would have to be kept forever. The
contract remains "either it works and reports success, or it makes no
change and reports EOPNOTSUPP". It just can't do both.

Rich
