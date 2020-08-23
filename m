Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5CF24F086
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 01:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHWXkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Aug 2020 19:40:23 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:43433 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgHWXkW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:40:22 -0400
Received: from dread.disaster.area (pa49-181-146-199.pa.nsw.optusnet.com.au [49.181.146.199])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id EA2D0107E4D;
        Mon, 24 Aug 2020 09:40:07 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k9zao-0000j3-HL; Mon, 24 Aug 2020 09:40:06 +1000
Date:   Mon, 24 Aug 2020 09:40:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged
 stacking?)
Message-ID: <20200823234006.GD7728@dread.disaster.area>
References: <20200728105503.GE2699@work-vm>
 <20200816230908.GI17456@casper.infradead.org>
 <20200817002930.GB28218@dread.disaster.area>
 <2859814.QYyEAd97eH@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2859814.QYyEAd97eH@silver>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0 cx=a_idp_d
        a=GorAHYkI+xOargNMzM6qxQ==:117 a=GorAHYkI+xOargNMzM6qxQ==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=sN8XJPRm1X3ZCSLF_skA:9 a=7VcMNz9s8RdlawYE:21 a=_CcSTsZO4Aje-SqZ:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 12:37:17PM +0200, Christian Schoenebeck wrote:
> On Montag, 17. August 2020 00:56:20 CEST Dave Chinner wrote:
> > > That's yet another question: should xattrs and forks share the same data-
> > > and namespace, or rather be orthogonal to each other.
> > 
> > Completely orthogonal. Alternate data streams are not xattrs, and
> > xattrs are not ADS....
> 
> Agreed. Their key features (atomic small data vs. non-atomic large data) and 
> their typical uses cases are probably too different for trying to stitch them 
> somehow in an erroneous way into a shared space. Plus it would actually be 
> beneficial if forks had their own xattrs.
> 
> On Montag, 17. August 2020 02:29:30 CEST Dave Chinner wrote:
> > I'd stop calling these "forks" already, too. The user wants
> > "alternate data streams", while a "resource fork" is an internal
> > filesystem implementation detail used to provide ADS
> > functionality...
> 
> The common terminology can certainly still be argued. I understand that from 
> fs implementation perspective "fork" is probably ambiguous. But from public 
> API (i.e. user space side) perspective the term "fork" does make sense, and so 
> far I have not seen a better general term for this. Plus the ambiguous aspects 
> on fs side are not exposed to the public side.
> 
> The term "alternate data stream" suggests that this is just about the raw data 
> stream, but that's probably not what this feature will end up being limited 
> to. E.g. I think they will have their own permissions on the long term (see 
> below). Plus the term ADS is ATM somewhat sticky to the Microsoft universe.

ADS is the windows term, which is where the majority of people who
use or want to ADS come from. Novell called the "multiple data
streams", and solaris 9 implemented "extended attributes" (ADS)
using inode forks. Apple allows a "data fork" (user data), "resource
forks" (ADS) and now "named forks" which they then used to implement
extended attributes.  Not the solaris ones, the linux style fixed
length key-value xattrs.

Quite frankly, the naming in this area is a complete and utter mess,
and the only clear, unabiguous name for this feature is "alternate
data streams". I don't care that it's something that comes from an
MS background - if your only argument against it is "Microsoft!"
then you're on pretty shakey ground...

> > IOWs, with a filesystem inode fork implementation like this for ADS,
> > all we really need is for the VFS to pass a magic command to
> > ->lookup() to tell us to use the ADS namespace attached to the inode
> > rather than use the primary inode type/state to perform the
> > operation.
> 
> IMO starting with a minimalistic approach, in a way Solaris developers 
> originally introduced forks, would IMO make sense for Linux as well:

<snip>

That's pretty much what the proposed O_ALT did, except it used a
fully qualified path name to define the ADS to open.

> - No subforks as starting point, and hence path separator '/' inside fork 
>   names would be prohibited initially to avoid future clashes.

Can't do that - changing the behaviour of the ADS name handling is
effectively an on-disk filesystem format change. i.e. if we allow it
in future kernels, then we have to mark the filesystem as "/" being
valid so that older kernels and repair utilities won't consider this
as invalid/corrupt and trash the ADS associated with the name.

IOWs, we either support it from the start, or we never support it.

> > Hence all the ADS support infrastructure is essentially dentry cache
> > infrastructure allowing a dentry to be both a file and directory,
> > and providing the pathname resolution that recognises an ADS
> > redirection. Name that however you want - we've got to do an on-disk
> > format change to support ADS, so we can tell the VFS we support ADS
> > or not. And we have no cares about existing names in the filesystem
> > conflicting with the ADS pathname identifier because it's a mkfs
> > time decision. Given that special flags are needed for the openat()
> > call to resolve an ADS (e.g. O_ALT), we know if we should parse the
> > ADS identifier as an ADS the moment it is seen...
> 
> So you think there should be a built-in full qualified path name resolution to 
> forks right from the start? E.g. like on Windows "C:\some\where\sheet.pdf:foo" 
> -> fork "foo" of file "sheet.pdf"?

No. I really don't care how the user interface works. That's for
people who write the syscalls to argue about.

What I was describing is how the internal kernel implementation -
the interaction between the VFS and the filesystem - needs to work.
ADS needs to be supported in some way by the VFS; if ADS are going
to be seekable user data files, then they have to be implemented as
path/dentry/inode tuples that a struct file can point to. IOWs,
internally they need to be seen as first class VFS citizens, and the
VFS needs mechanisms to tell the filesystem to look up the ADS
namespace rather than the inode itself....

> > > I don't understand why a fork would be permitted to have its own
> > > permissions.  That makes no sense.  Silly Solaris.
> > 
> > I can't think of a reason why, either, but the above implementation
> > for XFS would support it if the presentation layer allows it... :)
> 
> I would definitely not add this right from the start of course, but on the 
> long term it actually does make senses for them having their own permissions, 
> simply because there are already applications for that:
> 
> E.g. on some systems forks are used to tag files for security relevant issues, 
> for instance where the file originated from (a trusted vs. untrusted source). 

Key-value data like is what the security xattr namespace is for, not
ADS....

> If it was a untrusted source, the user is made aware about this circumstance 
> by the system when attempting to open the file. In this use case the fork 
> would probably have more restrictive permissions than the actual file.

That requires opening the user data fork to walk the ADS to find
key-value pairs that tell it it must not open the file.  We already
have infrastructure for this sort of thing via LSMs that store their
own private key-value data in the security xattrs namespace that
users can't modify. If you have security permission data that is
larger than can be stored in an xattr, then you've got bigger
problems than a lack of ADS.

OTOH, storing the merkle tree data for fsverity would be a perfect
use for a hidden ADS stream that the user cannot see or modify. The
current fsverity implementation is a nasty hack that stores the
merkle tree data in the same file but hides it beyond EOF so that
only the kernel can access it directly. That only works for a single
non-user data stream, though, so if we wanted more file-offset based
integrity or security data, we've got nowhere to put it.

IOWs, now that I think about it, we should be allowing non-user
per-ADS permissions to be set right from the start because I can
think of several filesystem/kernel internal features that could make
use of such functionality that we would want to remain hidden from
users.

> OTOH forks are used to extend existing files in non-obtrusive way. Say you 
> have some sort of (e.g. huge) master file, and a team works on that file. Then 
> the individual people would attach their changes solely as forks to the master 
> file with their ownership, probably even with complex ACLs, to prevent certain 
> users from touching (or even reading) other ones changes. In this use case the 
> master file might be readonly for most people, while the individual forks 
> being anywhere between more permissive or more restrictive.

You're demonstrating the exact reasons why ADS have traditionally
been considered harmful by Linux developers.  You can do all that
with normal directories and files - you do not need ADS to implement
a fully functional multi-user content management system.

ADS does not make constructs like this simpler or easier for
applications to implement or manage. e.g. If you use traditional
directories and files, you don't need to modify backup applications
and file manipulation tools to correctly copy such constructs....

Keep in mind that you are not going to get universal support for ADS
any time soon as most filesystems will require on-disk format
changes to support them. Further, you are goign to have to wait for
the entire OS ecosystem to grow support for ADS (e.g. cp, tar,
rsync, file, etc) before you can actually use it sanely in
production systems. Even if we implement kernel support right now,
it will be years before it will be widely available and supported at
an OS/distro level...

IOWs, applications that want to do "ADS-like" stuff are going to
have to be written for the lowest common denominator (i.e. no ADS
support at all) for a long time yet.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
