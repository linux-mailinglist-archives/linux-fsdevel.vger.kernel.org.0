Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DB522894
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 02:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiEKAmJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 20:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiEKAmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 20:42:07 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 686591B57AA;
        Tue, 10 May 2022 17:42:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 2B7C25345BC;
        Wed, 11 May 2022 10:42:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1noaQS-00AUmR-E4; Wed, 11 May 2022 10:42:00 +1000
Date:   Wed, 11 May 2022 10:42:00 +1000
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
Message-ID: <20220511004200.GE2306852@dread.disaster.area>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <20220510005533.GA2306852@dread.disaster.area>
 <20220510124033.lobf33hxey4quza3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510124033.lobf33hxey4quza3@wittgenstein>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=627b065d
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=7-415B0cAAAA:8
        a=-VcIyIBGfY_eVRxBFnQA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 02:40:33PM +0200, Christian Brauner wrote:
> On Tue, May 10, 2022 at 10:55:33AM +1000, Dave Chinner wrote:
> > On Mon, May 09, 2022 at 02:48:15PM +0200, Christian Brauner wrote:
> > > On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> > >   I really think users would love to have an interfact where they can
> > >   get a struct with binary info back.
> > 
> > No. Not for kernel informational interfaces. We have ioctls and
> 
> That feels like semantics. statx is in all sensible readings of the
> words a kernel informational interface.

statx is an special purpose binary syscall interface for returning
inode specific information, it's not an abstract, generic
informational interface.

> I'm really looking at this from the perspective of someone who uses
> these interfaces regularly in userspace and a text-based interface for
> very basic information such as detailed information about a mount is
> cumbersome. I know people like to "counter" with "parsing strings is
> easy" but it remains a giant pain for userspace; at least for basic
> info.

As I said last reply, you are making all the same arguements against
text based information interfaces that were made against proc and
sysfs a long long time again. they weren't convincing a couple of
decades ago, and there aren't really convincing now. Text-based
key/value data is hard to screw up in the long run, binary
interfaces have a habit of biting hard whenever the contents of
the binary structure needs to change...

> > >   Imho, xattrs are a bit like a wonky version of streams already (One of
> > >   the reasons I find them quite unpleasant.). Making mount and other
> > >   information retrievable directly through the getxattr() interface will
> > >   turn them into a full-on streams implementation imho. I'd prefer not
> > >   to do that (Which is another reason I'd prefer at least a separate
> > >   system call.).
> > 
> > And that's a total misunderstanding of what xattrs are.
> > 
> > Alternate data streams are just {file,offset} based data streams
> > accessed via ithe same read/write() mechanisms as the primary data
> > stream.
> 
> That's why I said "wonky". But I'm not going to argue this point. I
> think you by necessity have wider historical context on these things
> that I lack. But I don't find it unreasonable to also see them as an
> additional information channel.
> 
> Sure, they are a generic key=value store for anything _in principle_. In
> practice however xattrs are very much perceived and used as information
> storage on files, a metadata side-channel if you will.

That's how *you* perceive them, not how everyone perceives them.

> All I'm claiming here is that it will confuse the living hell out of
> users if the getxattr() api suddenly is used not to just set and get
> information associated with inodes but to also provides filesystem or
> mount information.

Why would it confuse people? The xattr namespace is already well
known to be heirarchical and context dependent based on the intial
name prefix (user, security, btrfs, trusted, etc). i.e. if you don't
know that the context the xattr acts on is determined by the initial
name prefix, then you need to read the xattr(7) man page again:

Extended attribute namespaces

	Attribute  names  are  null-terminated  strings.   The
	attribute name is always specified in the fully qualified
	namespace.attribute form, for example, user.mime_type,
	trusted.md5sum, system.posix_acl_access, or
	security.selinux.

	The namespace mechanism is used to define different classes
	of extended attributes.  These different classes exist for
	several reasons;  for  example, the permissions and
	capabilities required for manipulating extended attributes
	of one namespace may differ to another.

	Currently,  the  security, system, trusted, and user
	extended attribute classes are defined as described below.
	Additional classes may be added in the future.

> That's a totally a totally differnet type of information. Sure, it may
> fit well in the key=value scheme because the xattr key=value _interface_
> is generic but that's a very technical argument.

Yet adding a new xattr namespace for a new class of information that
is associated the mount that the path/inode/fd is associated with is
exactly what the xattr namespaces are intended to allow. And it is
clearly documented that new classes "may be added in the future".

I just don't see where the confusion would come from...

> 
> I'm looking at this from the experience of a user of the API for a
> moment and in code they'd do in one place:
> 
> getxattr('/super/special/binary', "security.capability", ...);
> 
> and then in another place they do:
> 
> getxattr('/path/to/some/mount', "mntns:info", ...);
> 
> that is just flatout confusing.

Why? Both are getting different classes of key/value information
that is specific to the given path. Just because on is on-disk and
the other is ephemeral doesn't make it in any way confusing. This is
exactly what xattr namesapces are intended to support...

> > Xattrs provide an *atomic key-value object store API*, not an offset
> > based data stream API. They are completely different beasts,
> > intended for completely different purposes. ADS are redundant when you
> > have directories and files, whilst an atomic key-value store is
> > something completely different.
> > 
> > You do realise we have an independent, scalable, ACID compliant
> > key-value object store in every inode in an XFS filesystem, right?
> 
> So far this was a really mail with good background information but I'm
> struggling to make sense of what that last sentence is trying to tell
> me. :)

That people in the past have built large scale data storage
applications that use XFS inodes as key based object stores, not as
a offset based data stream. Who needs atomic write() functionality
when you have ACID set and replace operations for named objects?

The reality is that modern filesystems are really just btree based
object stores with high performance transaction engines overlaid
with a POSIX wrapper. And in the case of xattrs, we effectively
expose that btree based key-value database functionality directly to
userspace....

Stop thinking like xattrs are some useless metadata side channel,
and start thinking of them as an atomic object store that stores and
retreives millions of small (< 1/2 the filesystem block size) named
objects far space effciently than a directory structure full of
small files indexed by object hash.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
