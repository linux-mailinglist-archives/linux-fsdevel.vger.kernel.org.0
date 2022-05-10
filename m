Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3CB520A70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 02:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiEJA7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 20:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiEJA7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 20:59:36 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D38375A0A9;
        Mon,  9 May 2022 17:55:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2A831534592;
        Tue, 10 May 2022 10:55:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1noEA1-00A6UT-AL; Tue, 10 May 2022 10:55:33 +1000
Date:   Tue, 10 May 2022 10:55:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
Message-ID: <20220510005533.GA2306852@dread.disaster.area>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=6279b80a
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=CMf3WBuwh-sY1y9demkA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 09, 2022 at 02:48:15PM +0200, Christian Brauner wrote:
> On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> > This is a simplification of the getvalues(2) prototype and moving it to the
> > getxattr(2) interface, as suggested by Dave.
> > 
> > The patch itself just adds the possibility to retrieve a single line of
> > /proc/$$/mountinfo (which was the basic requirement from which the fsinfo
> > patchset grew out of).
> > 
> > But this should be able to serve Amir's per-sb iostats, as well as a host of
> > other cases where some statistic needs to be retrieved from some object.  Note:
> > a filesystem object often represents other kinds of objects (such as processes
> > in /proc) so this is not limited to fs attributes.
> > 
> > This also opens up the interface to setting attributes via setxattr(2).
> > 
> > After some pondering I made the namespace so:
> > 
> > : - root
> > bar - an attribute
> > foo: - a folder (can contain attributes and/or folders)
> > 
> > The contents of a folder is represented by a null separated list of names.
> > 
> > Examples:
> > 
> > $ getfattr -etext -n ":" .
> > # file: .
> > :="mnt:\000mntns:"
> > 
> > $ getfattr -etext -n ":mnt:" .
> > # file: .
> > :mnt:="info"
> > 
> > $ getfattr -etext -n ":mnt:info" .
> > # file: .
> > :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"
> 
> Hey Miklos,
> 
> One comment about this. We really need to have this interface support
> giving us mount options like "relatime" back in numeric form (I assume
> this will be possible.). It is royally annoying having to maintain a
> mapping table in userspace just to do:
> 
> relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
> ro	 -> MS_RDONLY/MOUNT_ATTR_RDONLY

You're asking for a complete change of output information there.
This has nothing to do with the mechanism for extracting key/value
information from the kernel.

i.e. we need to separate demands for "data I want" from "mechanism
to extract data".

> > $ getfattr -etext -n ":mntns:" .
> > # file: .
> > :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"
> > 
> > $ getfattr -etext -n ":mntns:28:" .
> > # file: .
> > :mntns:28:="info"
> > 
> > Comments?
> 
> I'm not a fan of text-based APIs and I'm particularly not a fan of the
> xattr APIs. But at this point I'm ready to compromise on a lot as long
> as it gets us values out of the kernel in some way. :)
> 
> I had to use xattrs extensively in various low-level userspace projects
> and they continue to be a source of races and memory bugs.
> 
> A few initial questions:
> 
> * The xattr APIs often require the caller to do sm like (copying some go
>   code quickly as I have that lying around):
> 
> 	for _, x := range split {
> 		xattr := string(x)
> 		// Call Getxattr() twice: First, to determine the size of the
> 		// buffer we need to allocate to store the extended attributes,
> 		// second, to actually store the extended attributes in the
> 		// buffer. Also, check if the size of the extended attribute
> 		// hasn't increased between the two calls.
> 		pre, err = unix.Getxattr(path, xattr, nil)
> 		if err != nil || pre < 0 {
> 			return nil, err
> 		}
> 
> 		dest = make([]byte, pre)
> 		post := 0
> 		if pre > 0 {
> 			post, err = unix.Getxattr(path, xattr, dest)
> 			if err != nil || post < 0 {
> 				return nil, err
> 			}
> 		}
> 
> 		if post > pre {
> 			return nil, fmt.Errorf("Extended attribute '%s' size increased from %d to %d during retrieval", xattr, pre, post)
> 		}
> 
> 		xattrs[xattr] = string(dest)
> 	}
> 
>   This pattern of requesting the size first by passing empty arguments,
>   then allocating the buffer and then passing down that buffer to
>   retrieve that value is really annoying to use and error prone (I do
>   of course understand why it exists.).

You're doing it wrong.

When you have an attr extraction loop like this, you allocate a
single 64kB buffer for the value, adn then call getattr() with the
buffer and a length of 64kB. Then the call returns both the value
length and the value in one syscall, and then the application can
allocate+copy into an exact sized buffer if it needs to.

Then you use the same 64kB buffer for the next getxattr() call.

I first saw this pattern in code written in the mid 1990s for
Irix, and for basic listxattr/getxattr operations to find and
retrieve key/value pairs this is much more efficient than the above.

The real problem is that the linux listxattr() syscall only returns
names. It's a shit API design at best, especially the part where it
cannot iterate over a list larger than a single buffer. If you've
got millions of xattrs, listxattr is fucking useless. The man page
is actively harmful - that's where everyone learns the double
getxattr anit-pattern you've described above.


With that in mind, go look at XFS_IOC_ATTRLIST_BY_HANDLE that I've
mentioned in previous discussions this topic.  Each attr entry
returned is one of these:

struct xfs_attrlist_ent {       /* data from attr_list() */
	__u32   a_valuelen;     /* number bytes in value of attr */
	char    a_name[1];      /* attr name (NULL terminated) */
};

It really needs a namelen to make parsing of the output buffer
simpler, but this is the model we should be following - listing
xattrs is no different from listing directory entries. Indeed,
a directory entries is basically just a name/value pair - the name
of the dirent and the inode number it points to is the value.

Further to that point, the control structure for
XFS_IOC_ATTRLIST_BY_HANDLE has a cursor value that works the same
way as readdir cookies do. Hence when iterating over xattrs that
require multiple syscalls to retrieve, the cursor allows the next
list syscall to start off listing exactly where the previous syscall
finished.

IOWs, what Linux really needs is a listxattr2() syscall that works
the same way that getdents/XFS_IOC_ATTRLIST_BY_HANDLE work. With the
list function returning value sizes and being able to iterate
effectively, every problem that listxattr() causes goes away.

And while we are at it, we need to consider a xattr2() syscall to
replace getxattr/setxattr. The model for that is
XFS_IOC_ATTRMULTI_BY_HANDLE, which allows operations to be performed
on mulitple xattrs in a single syscall. e.g. we can do a bulk get,
set and remove operation across multiple xattrs - we can even mix
and match get/set/remove operations on different xattrs in a single
call.

> * Would it be possible to support binary output with this interface?

The xattr API already supports binary names and values. The only
exception is you can't put NULLs in names because APIs use that as a
name terminator. if listxattr2() returns a namelen in it's
structure, then we could allow fully binary names, too (XFS already
fully supports this internally!). In the current API, values are
always determined by length, not null termiantions, so they are
also already fully binary capable.

>   I really think users would love to have an interfact where they can
>   get a struct with binary info back.

No. Not for kernel informational interfaces. We have ioctls and
syscalls for defining structured binary interfaces that pass
non-trivial objects. xattrs are no the place for this - they are
key/value object stores like sysfs is supposed to be, so I really
don't think we should support encoded binary data in xattrs under
this special mount namespace...

Solving the "retreive multiple values per syscall" problem is what
the bulk get interface (XFS_IOC_ATTRMULTI_BY_HANDLE) is for.

>   Callers like systemd will have to parse text and will end up
>   converting everything from text into binary anyway; especially for
>   mount information. So giving them an option for this out of the box
>   would be quite good.

That boat sailed years ago. You're making the same arguments about
binary extraction interfaces being way more efficient than ascii
based value-per-file interfaces like proc/sysfs that were made back
in the early 2000s. That boat has long sailed - while the current
method is somewhat inefficient, it certainly hasn't had all the
problems that maintaining binary interfaces over decades has had....

Much as it pains me to say it (because I came to Linux from an OS
that exported huge amounts of custom binary structures from the
kernel), having all the export interfaces dump human readable
information has proved far more flexible and usable than interfaces
that required binary parsers to dump information before it could be
used on the command line or in scripting languages....

> * If we decide to go forward with this interface - and I think I
>   mentioned this in the lsfmm session - could we please at least add a
>   new system call? It really feels wrong to retrieve mount and other
>   information through the xattr interfaces. They aren't really xattrs.

We are trying to expose structured key-value information. That's
exactly what the xattr API was orginally created to cater for...

>   Imho, xattrs are a bit like a wonky version of streams already (One of
>   the reasons I find them quite unpleasant.). Making mount and other
>   information retrievable directly through the getxattr() interface will
>   turn them into a full-on streams implementation imho. I'd prefer not
>   to do that (Which is another reason I'd prefer at least a separate
>   system call.).

And that's a total misunderstanding of what xattrs are.

Alternate data streams are just {file,offset} based data streams
accessed via ithe same read/write() mechanisms as the primary data
stream.

Xattrs provide an *atomic key-value object store API*, not an offset
based data stream API. They are completely different beasts,
intended for completely different purposes. ADS are redundant when you
have directories and files, whilst an atomic key-value store is
something completely different.

You do realise we have an independent, scalable, ACID compliant
key-value object store in every inode in an XFS filesystem, right?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
