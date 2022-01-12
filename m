Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1274148CA03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbiALRnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 12:43:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43388 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243138AbiALRnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:43:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D4FBB81D6E;
        Wed, 12 Jan 2022 17:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35393C36AE5;
        Wed, 12 Jan 2022 17:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642009382;
        bh=L5o3p0wuBHzN9b7DsFmDk5i5nOc1gWICMYhr98lMFsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUeuVHe+nqNsG9Pll7a0kuKfqU0In+6N6fpi0pqA1YUGJJFYb1nVVUjd1KkEO9nYR
         r3AilCCE9tlzdEBaJHXqFh0WzyGjVB0gHMVHSNHiFsX8fJJ+bZnbyysTThtJo8ercj
         +kKXuaJYs2pC0iAYf6IoswpM1Op26BuHTpvAoJeeD/ISziQhHAl+Mx/ZJ75ZCPBcmD
         Ygk+90p0YYqo/b0/Jx5ja7MFa19ieRxfoqmKu04i/2hUqppT8roTlzCDaQJAjssc2u
         hhozyq9dtypeyCdv5O/vuiTDnIPw1E7DWQLIsIKPLnNQEMq+uAqndPxLzge/dVnBF3
         jqWWhfnp+GTqA==
Date:   Wed, 12 Jan 2022 09:43:01 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        richard.sharpe@primarydata.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        lance.shelton@hammerspace.com,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ntfs3@lists.linux.dev,
        Steve French <sfrench@samba.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: Re: [bug report] NFS: Support statx_get and statx_set ioctls
Message-ID: <20220112174301.GB19154@magnolia>
References: <20220111074309.GA12918@kili>
 <Yd1ETmx/HCigOrzl@infradead.org>
 <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg9V4Jsg3jRPnsk2AN7gPrNY8jRAc87tLvGW+TqH9OU-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 09:57:58AM +0200, Amir Goldstein wrote:
> On Wed, Jan 12, 2022 at 4:10 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Jan 11, 2022 at 10:43:09AM +0300, Dan Carpenter wrote:
> > > Hello Richard Sharpe,
> > >
> > > This is a semi-automatic email about new static checker warnings.
> > >
> > > The patch bc66f6805766: "NFS: Support statx_get and statx_set ioctls"
> > > from Dec 27, 2021, leads to the following Smatch complaint:
> >
> > Yikes, how did that crap get merged?
> 
> Did it? The bots are scanning through patches on ML:
> 
> https://lore.kernel.org/linux-nfs/20211227190504.309612-1-trondmy@kernel.org/
> 
> > Why the f**k does a remote file system need to duplicate stat?
> > This kind of stuff needs a proper discussion on linux-fsdevel.
> 
> +ntfs3 +linux-cifs +linux-api
> 
> The proposal of statx_get() is very peculiar.
> statx() was especially designed to be extended and accommodate
> a diversity of filesystem attributes.
> 
> Moreover, NFSv4 is not the only fs that supports those extra attributes.
> ntfs3 supports set/get of dos attrib bits via xattr SYSTEM_NTFS_ATTRIB.
> cifs support set/get of CIFS_XATTR_ATTRIB and CIFS_XATTR_CREATETIME.
> 
> Not only that, but Linux now has ksmbd which actually emulates
> those attributes on the server side (like samba) by storing a samba
> formatted blob in user.DOSATTRIB xattr.
> It should have a way to get/set them on filesystems that support them
> natively.
> 
> The whole thing shouts for standardization.
> 
> Samba should be able to get/set the extra attributes by statx() and
> ksmbd should be able to get them from the filesystem by vfs_getattr().
> 
> WRT statx_set(), standardization is also in order, both for userspace

So, uh, this is the first I've heard of statx_set in years.

I'm glad to hear that standardizing FSGETFLAGS/FSSETXATTR/etc is still
alive. :)

> API and for vfs API to be used by ksmbd and nfsd v4.
> 
> The new-ish vfs API fileattr_get/set() comes to mind when considering
> a method to set the dos attrib bits.
> Heck, FS_NODUMP_FL is the same as FILE_ATTRIBUTE_ARCHIVE.
> That will also make it easy for filesystems that support the fileattr flags
> to add support for FS_SYSTEM_FL, FS_HIDDEN_FL.
> 
> There is a use case for that. It can be inferred from samba config options
> "map hidden/system/archive" that are used to avoid the cost of getxattr
> per file during a "readdirplus" query. I recently quantified this cost on a
> standard file server and it was very high.
> 
> Which leaves us with an API to set the 'time backup' attribute, which
> is a "mutable creation time" [*].
> cifs supports setting it via setxattr and I guess ntfs3 could use an
> API to set it as well.
> 
> One natural interface that comes to mind is:
> 
> struct timespec times[3] = {/* atime, mtime, crtime */}
> utimensat(dirfd, path, times, AT_UTIMES_ARCHIVE);
> 
> and add ia_crtime with ATTR_CRTIME to struct iattr.
> 
> Trond,
> 
> Do you agree to rework your patches in this direction?
> Perhaps as the first stage, just use statx() and ioctls to set the
> attributes to give enough time for bikeshedding the set APIs
> and follow up with the generic set API patches later?
> 
> Thanks,
> Amir.
> 
> [*] I find it convenient to use the statx() terminology of "btime"
> to refer to the immutable birth time provided by some filesystems
> and to use "crtime" for the mutable creation time for archiving,
> so that at some point, some filesystems may provide both of
> these times independently.

I disagree because XFS and ext4 both use 'crtime' for the immutable
birth time, not a mutable creation time for archiving.  I think we'd
need to be careful about wording here if there is interest in adding a
user-modifiable file creation time (as opposed to creation time for a
specific instance of an inode) to filesystems.

Once a year or so we get a question/complaint from a user about how they
can't change the file creation time and we have to explain to them
what's really going on.

--D
