Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4B31E71F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 08:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhBRHuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 02:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231317AbhBRHqH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 02:46:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4722D64DE0;
        Thu, 18 Feb 2021 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613633693;
        bh=sjajRiTXns4+pD+gjYTsvSp91C0M53TJNj6vUwdi4zI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuuVLco0VtpvNqIZUSpPN0Ndt0DVjY30kFF+9i7jVsea7VCkByEQacOwl8C/FiWbo
         FAQIIojb/4410HMJVvN09W/dBS/mXtuK9ged/kDsSbarIJ8WOWygRjS6MWt6G9iLLX
         tPfsDE0sq+g/EQLfVZFTi7Ki/t5dWuwfstyBgdTw=
Date:   Thu, 18 Feb 2021 08:34:49 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Henriques <lhenriques@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Message-ID: <YC4YmTWtIgeyjZ6h@kroah.com>
References: <87blckj75z.fsf@suse.de>
 <CAOQ4uxiiy_Jdi3V1ait56=zfDQRBu_5gb+UsCo8GjMZ6XRhozw@mail.gmail.com>
 <874kibkflh.fsf@suse.de>
 <CAOQ4uxgRK3vXH8uAJKy8cFLL8siKnMMN8h6hx4yZeA5Fe0ZZYA@mail.gmail.com>
 <CAFX2Jfk0X=jKBpOzjq7k-U6SEwFn1Atw62BK2DzavM8XgeLUaQ@mail.gmail.com>
 <CAH2r5mvybG3mRUfHUub9B+nk5WrQ5Fvzu5pZ+ZynqZg4c4ct2A@mail.gmail.com>
 <CAOQ4uxhqaTUwD8Lw+9HWWj61EXRv4X-eE3u4DFeWnv_VOUZF5A@mail.gmail.com>
 <CAH2r5msmtuk0f8FuZxdRBQ2d_VKXexctcP0OmnLXoDEBien-nQ@mail.gmail.com>
 <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
 <216103D5-0575-4BFC-9802-2C21A1B12DF9@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <216103D5-0575-4BFC-9802-2C21A1B12DF9@dilger.ca>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 05:50:35PM -0700, Andreas Dilger wrote:
> On Feb 17, 2021, at 1:08 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > 
> > You are missing my point.
> > Never mind which server. The server does not *need* to rely on
> > vfs_copy_file_range() to copy files from XFS to ext4.
> > The server is very capable of implementing the fallback generic copy
> > in case source/target fs do not support native {copy,remap}_file_range().
> > 
> > w.r.t semantics of copy_file_range() syscall vs. the fallback to userespace
> > 'cp' tool (check source file size before copy or not), please note that the
> > semantics of CIFS_IOC_COPYCHUNK_FILE are that of the former:
> > 
> >        rc = cifs_file_copychunk_range(xid, src_file.file, 0, dst_file, 0,
> >                                        src_inode->i_size, 0);
> > 
> > It will copy zero bytes if advertised source file size if zero.
> > 
> > NFS server side copy semantics are currently de-facto the same
> > because both the client and the server will have to pass through this
> > line in vfs_copy_file_range():
> > 
> >        if (len == 0)
> >                return 0;
> > 
> > IMO, and this opinion was voiced by several other filesystem developers,
> > the shortend copy semantics are the correct semantics for copy_file_range()
> > syscall as well as for vfs_copy_file_range() for internal kernel users.
> > 
> > I guess what this means is that if the 'cp' tool ever tries an opportunistic
> > copy_file_range() syscall (e.g. --cfr=auto), it may result in zero size copy.
> 
> Having a syscall that does the "wrong thing" when called on two files
> doesn't make sense.  Expecting userspace to check whether source/target
> files supports CFR is also not practical.  This is trivial for the
> kernel to determine and return -EOPNOTSUPP to the caller if the source
> file (procfs/sysfs/etc) does not work with CFR properly.

How does the kernel "know" that a specific file in a specific filesystem
will not work with CFR "properly"?  That goes back to the original patch
which tried to label each and every filesystem type with a
"supported/not supported" type of flag, which was going to be a mess,
especially as it seems that this might be a file-specific thing, not a
filesystem-specific thing.

The goal of the patch _should_ be that the kernel figure it out itself,
but so far no one seems to be able to explain how that can be done :(

So, any hints?

thanks,

greg k-h
