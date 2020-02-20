Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA6A6165B96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 11:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBTKeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 05:34:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726501AbgBTKen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582194882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbRiHn2UAAo1XhaSQjnQaPYh19kM6Kh7056eiuL/Ryo=;
        b=NjDV+Hdyxg0zMBZB8zr582tLfOk1YjRYU+3uvqFltugQn9LSf5bHAY1Jhol7FQ3zJVF6dN
        j3OrKzU47eKawxteomPfgxACihDdS8iB+A5wY9xOWT1UzWxSla7cUgDwFirqQBX7wNTKfT
        idPoF+/t41ftlu5eP4Yj/Clk4E+iLBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-qU9IaiWhN92zMfQkTauxHw-1; Thu, 20 Feb 2020 05:34:40 -0500
X-MC-Unique: qU9IaiWhN92zMfQkTauxHw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F8D1801FA6;
        Thu, 20 Feb 2020 10:34:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBEF85DA76;
        Thu, 20 Feb 2020 10:34:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200219163128.GB9496@magnolia>
References: <20200219163128.GB9496@magnolia> <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk> <158204550281.3299825.6344518327575765653.stgit@warthog.procyon.org.uk>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] vfs: syscall: Add fsinfo() to query filesystem information [ver #16]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <542410.1582194875.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 20 Feb 2020 10:34:35 +0000
Message-ID: <542411.1582194875@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong <darrick.wong@oracle.com> wrote:

> > +	p->f_blocks.hi	=3D 0;
> > +	p->f_blocks.lo	=3D buf.f_blocks;
> =

> Er... are there filesystems (besides that (xfs++)++ one) that require
> u128 counters?  I suspect that the Very Large Fields are for future
> expandability, but I also wonder about the whether it's worth the
> complexity of doing this, since the structures can always be
> version-revved later.

I'm making a relatively cheap allowance for future expansion.  Dave Chinne=
r
has mentioned at one of the LSFs that 16EiB may be exceeded soon (though I
hate to think of fscking such a beastie).  I know that the YFS variant of =
AFS
supports 96-bit vnode numbers (which I translate to inode numbers).  What =
I'm
trying to avoid is the problem we have with stat/statfs where under some
circumstances we have to return an error (ERANGE?) because we can't repres=
ent
the number if someone asks for an older version of the struct.

Since the buffer is (meant to be) pre-cleared, the filesystem can just ign=
ore
the high word if it's never going to set it.  In fact, fsinfo_generic_stat=
fs
doesn't need to set them either.

> XFS inodes are u64 values...
> ...and the max symlink target length is 1k, not PAGE_SIZE...

Yeah, and AFS(YFS) has 96-bit inode numbers.  The filesystem's fsinfo tabl=
e is
read first so that the filesystem can override this.

> ...so is the usage model here that XFS should call fsinfo_generic_limits
> to fill out the fsinfo_limits structure, modify the values in
> ctx->buffer as appropriate for XFS, and then return the structure size?

Actually, I should export some these so that you can do that.  I'll export
fsinfo_generic_{timestamp_info,supports,limits} for now.

> > +#define FSINFO_ATTR_VOLUME_ID		0x05	/* Volume ID (string) */
> > +#define FSINFO_ATTR_VOLUME_UUID		0x06	/* Volume UUID (LE uuid) */
> > +#define FSINFO_ATTR_VOLUME_NAME		0x07	/* Volume name (string) */
> =

> I think I've muttered about the distinction between volume id and
> volume name before, but I'm still wondering how confusing that will be
> for users?  Let me check my assumptions, though:
> =

> Volume ID is whatever's in super_block.s_id, which (at least for xfs and
> ext4) is the device name (e.g. "sda1").  I guess that's useful for
> correlating a thing you can call fsinfo() on against strings that were
> logged in dmesg.
>
> Volume name I think is the fs label (e.g. "home"), which I think will
> have to be implemented separately by each filesystem, and that's why
> there's no generic vfs implementation.

Yes.  For AFS, for example, this would be the name of the volume (which ma=
y be
changed), whereas the volume ID is the number in the protocol that actuall=
y
refers to the volume (which cannot be changed).

And, as you say, for blockdev mounts, the ID is the device name and the vo=
lume
name is filesystem specific.

> The 7 -> 0 -> 1 sequence here confused me until I figured out that
> QUERY_TYPE is the mask for QUERY_{PATH,FD}.

Changed to FSINFO_FLAGS_QUERY_MASK.

> > +struct fsinfo_limits {
> > +...
> > +	__u32	__reserved[1];
> =

> I wonder if these structures ought to reserve more space than a single u=
32...

No need.  Part of the way the interface is designed is that the version nu=
mber
for a particular VSTRUCT-type attribute is also the length.  So a newer
version is also longer.  All the old fields must be retained and filled in=
.
New fields are tagged on the end.

If userspace asks for an older version than is supported, it gets a trunca=
ted
return.  If it asks for a newer version, the extra fields it is expecting =
are
all set to 0.  Either way, the length (and thus the version) the kernel
supports is returned - not the length copied.

The __reserved fields are there because they represent padding (the struct=
 is
going to be aligned/padded according to __u64 in this case).  Ideally, I'd
mark the structs __packed, but this messes with the alignment and may make=
 the
compiler do funny tricks to get out any field larger than a byte.

I've renamed them to __padding.

> > +struct fsinfo_supports {
> > +	__u64	stx_attributes;		/* What statx::stx_attributes are supported *=
/
> > +	__u32	stx_mask;		/* What statx::stx_mask bits are supported */
> > +	__u32	ioc_flags;		/* What FS_IOC_* flags are supported */
> =

> "IOC"?  That just means 'ioctl'.  Is this field supposed to return the
> supported FS_IOC_GETFLAGS flags, or the supported FS_IOC_FSGETXATTR
> flags?

FS_IOC_[GS]ETFLAGS is what I meant.

> I suspect it would also be a big help to be able to tell userspace which
> of the flags can be set, and which can be cleared.

How about:

	__u32	fs_ioc_getflags;	/* What FS_IOC_GETFLAGS may return */
	__u32	fs_ioc_setflags_set;	/* What FS_IOC_SETFLAGS may set */
	__u32	fs_ioc_setflags_clear;	/* What FS_IOC_SETFLAGS may clear */

> > +struct fsinfo_timestamp_one {
> > +	__s64	minimum;	/* Minimum timestamp value in seconds */
> > +	__u64	maximum;	/* Maximum timestamp value in seconds */
> =

> Given that time64_t is s64, why is the maximum here u64?

Well, I assume it extremely unlikely that the maximum can be before 1970, =
so
there doesn't seem any need to allow the maximum to be negative.  Furtherm=
ore,
it would be feasible that you could encounter a filesystem with a u64
filesystem that doesn't support dates before 1970.

On the other hand, if Linux is still going when __s64 seconds from 1970 wr=
aps,
it will be impressive, but I'm not sure we'll be around to see it...  Some=
one
will have to cast a resurrection spell on Arnd to fix that one.

However, since signed/unsigned comparisons may have issues, I can turn it =
into
an __s64 also if that is preferred.

David

