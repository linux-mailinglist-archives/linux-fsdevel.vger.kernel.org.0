Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A7626CDD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 23:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgIPQOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 12:14:53 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:54176 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgIPQOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Date:   Wed, 16 Sep 2020 11:41:22 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-api@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfs: block chmod of symlinks
Message-ID: <20200916154122.GU3265@brightrain.aerifal.cx>
References: <20200916002157.GO3265@brightrain.aerifal.cx>
 <20200916002253.GP3265@brightrain.aerifal.cx>
 <20200916062553.GB27867@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916062553.GB27867@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 07:25:53AM +0100, Christoph Hellwig wrote:
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
> Our usualy place for this would be setattr_prepare.  Also the comment
> style is off, and I don't think we should talk about buggy file systems
> here, but a policy to not allow the chmod.  I also suspect the right
> error value is EINVAL - EOPNOTSUPP isn't really used in normal posix
> file system interfaces.

EINVAL is non-conforming here. POSIX defines it as unsupported mode or
flag. Lack of support for setting an access mode on symlinks is a
distinct failure reason, and POSIX does not allow overloading error
codes like this.

Even if it were permitted, it would be bad to do this because it would
make it impossible for the application to tell whether the cause of
failure is an invalid mode or that the filesystem/implementation
doesn't support modes on symlinks. This matters because one is usually
a fatal error and the other is a condition to ignore. Moreover, the
affected applications (e.g. coreutils, tar, etc.) already accept
EOPNOTSUPP here from libc. Defining a new error would break them
unless libc translated whatever the syscall returns to the expected
EOPNOTSUPP.

Rich
