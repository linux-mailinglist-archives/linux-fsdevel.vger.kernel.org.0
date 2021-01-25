Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C31E30327E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 04:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbhAYKQW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 05:16:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:46902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727379AbhAYKPO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:15:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C7F2AF0F;
        Mon, 25 Jan 2021 10:13:10 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 629e0216;
        Mon, 25 Jan 2021 10:14:02 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v4 05/17] ceph: crypto context handling for ceph
References: <20210120182847.644850-1-jlayton@kernel.org>
        <20210120182847.644850-6-jlayton@kernel.org> <87y2gk53ft.fsf@suse.de>
        <48cd711c7f99e6bd52f4ba0565eb54589843ac89.camel@kernel.org>
Date:   Mon, 25 Jan 2021 10:14:01 +0000
In-Reply-To: <48cd711c7f99e6bd52f4ba0565eb54589843ac89.camel@kernel.org> (Jeff
        Layton's message of "Fri, 22 Jan 2021 12:26:38 -0500")
Message-ID: <874kj5wcgm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jeff Layton <jlayton@kernel.org> writes:

> On Fri, 2021-01-22 at 16:41 +0000, Luis Henriques wrote:
>> Jeff Layton <jlayton@kernel.org> writes:
>> 
>> > Store the fscrypt context for an inode as an encryption.ctx xattr.
>> > When we get a new inode in a trace, set the S_ENCRYPTED bit if
>> > the xattr blob has an encryption.ctx xattr.
>> > 
>> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> > ---
>> >  fs/ceph/Makefile |  1 +
>> >  fs/ceph/crypto.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>> >  fs/ceph/crypto.h | 24 ++++++++++++++++++++++++
>> >  fs/ceph/inode.c  |  6 ++++++
>> >  fs/ceph/super.c  |  3 +++
>> >  fs/ceph/super.h  |  1 +
>> >  fs/ceph/xattr.c  | 32 ++++++++++++++++++++++++++++++++
>> >  7 files changed, 109 insertions(+)
>> >  create mode 100644 fs/ceph/crypto.c
>> >  create mode 100644 fs/ceph/crypto.h
>> > 
>> > diff --git a/fs/ceph/Makefile b/fs/ceph/Makefile
>> > index 50c635dc7f71..1f77ca04c426 100644
>> > --- a/fs/ceph/Makefile
>> > +++ b/fs/ceph/Makefile
>> > @@ -12,3 +12,4 @@ ceph-y := super.o inode.o dir.o file.o locks.o addr.o ioctl.o \
>> >  
>> > 
>> > 
>> > 
>> >  ceph-$(CONFIG_CEPH_FSCACHE) += cache.o
>> >  ceph-$(CONFIG_CEPH_FS_POSIX_ACL) += acl.o
>> > +ceph-$(CONFIG_FS_ENCRYPTION) += crypto.o
>> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
>> > new file mode 100644
>> > index 000000000000..dbe8b60fd1b0
>> > --- /dev/null
>> > +++ b/fs/ceph/crypto.c
>> > @@ -0,0 +1,42 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +#include <linux/ceph/ceph_debug.h>
>> > +#include <linux/xattr.h>
>> > +#include <linux/fscrypt.h>
>> > +
>> > +#include "super.h"
>> > +#include "crypto.h"
>> > +
>> > +static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
>> > +{
>> > +	return __ceph_getxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len);
>> > +}
>> > +
>> > +static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t len, void *fs_data)
>> > +{
>> > +	int ret;
>> > +
>> > +	WARN_ON_ONCE(fs_data);
>> > +	ret = __ceph_setxattr(inode, CEPH_XATTR_NAME_ENCRYPTION_CONTEXT, ctx, len, XATTR_CREATE);
>> > +	if (ret == 0)
>> > +		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
>> > +	return ret;
>> > +}
>> > +
>> > +static bool ceph_crypt_empty_dir(struct inode *inode)
>> > +{
>> > +	struct ceph_inode_info *ci = ceph_inode(inode);
>> > +
>> > +	return ci->i_rsubdirs + ci->i_rfiles == 1;
>> > +}
>> 
>> This is very tricky, as this check can't really guaranty that the
>> directory is empty.  We need to make sure no other client has access to
>> this directory during the whole operation of setting policy.  Would it be
>> enough to ensure we have Fxc here?
>> 
>
> That's a good point. Yes, we probably should do just that. I'll take a
> look and see what we need as far as caps go to ensure exclusion.
>
> empty_dir is only called when setting the context, so we can grab cap
> refs at that point and then just check to make sure it's empty here.
>
>> > +
...
>> > +static struct fscrypt_operations ceph_fscrypt_ops = {
>> > +/* Return true if inode's xattr blob has an xattr named "name" */
>> > +bool ceph_inode_has_xattr(struct ceph_inode_info *ci, const char *name)
>> > +{
>> > +	void *p, *end;
>> > +	u32 numattr;
>> > +	size_t namelen;
>> > +
>> > +	lockdep_assert_held(&ci->i_ceph_lock);
>> > +
>> > +	if (!ci->i_xattrs.blob || ci->i_xattrs.blob->vec.iov_len <= 4)
>> > +		return false;
>> > +
>> > +	namelen = strlen(name);
>> > +	p = ci->i_xattrs.blob->vec.iov_base;
>> > +	end = p + ci->i_xattrs.blob->vec.iov_len;
>> > +	ceph_decode_32_safe(&p, end, numattr, bad);
>> > +
>> > +	while (numattr--) {
>> > +		u32 len;
>> > +
>> > +		ceph_decode_32_safe(&p, end, len, bad);
>> > +		ceph_decode_need(&p, end, len, bad);
>> > +		if (len == namelen && !memcmp(p, name, len))
>> > +			return true;
>> > +		p += len;
>> > +		ceph_decode_32_safe(&p, end, len, bad);
>> > +		ceph_decode_skip_n(&p, end, len, bad);
>> > +	}
>> > +bad:
>> > +	return false;
>> > +}
>> 
>> I wonder if it wouldn't be better have an extra flag in struct
>> ceph_inode_info instead of having to go through the xattr list every time
>> we update an inode with data from the MDS.
>> 
>
> It is ugly, I'll grant you that. A flag in ceph_inode_info won't really
> help though. We'd need some sort of flag in the inode info transmitted
> from the MDS.
>
> For now, we only call this for I_NEW inodes, but now I'm wondering if we
> need to check it every time, to ensure that everything works if you see
> the directory before another client encrypts it.
>
> We may want to extend the protocol with such a flag, but the xattr
> buffer is not usually that long. For now, I'm inclined to live with
> parsing this info each time.

Ok, makes sense.  Thanks for clarifying.  I guess that getting the Fxc
caps when encrypting a dir (setting the context) may actually prevent the
race you mention anyway.

Cheers,
-- 
Luis
