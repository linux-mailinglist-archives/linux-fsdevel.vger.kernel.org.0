Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753A2522F1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 11:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiEKJQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 05:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240976AbiEKJQN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 05:16:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD7F2182B;
        Wed, 11 May 2022 02:16:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D84EDB8214F;
        Wed, 11 May 2022 09:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997C6C340EB;
        Wed, 11 May 2022 09:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652260567;
        bh=5Va5HOpXAM/hH9BBm5/LpiUFnaEkuG8P9DfnwvtHNmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O/tOn+cwpbUTzmT7dHHtp7mjGYIstHXbfbn9WJ91+f0fWAUrgEMbXqjsuDb6a99Fp
         wnViv0rVfN5iCvLDwrYxoHaC8c5PzMczurQmENEyJsYg6VMKmVHkxW0KJDa/BXdGBI
         HpIpTY5Wt57PcUUcj0aELORd6vNNzLLXShzrq6vlWk4zRQEkGLRKflAYwI4PktDzkN
         Coai3N/OO+1kUmhFN1z8UHrQ6XWyON09m46/rSe32BjcmutxI5i2wLmlbofpSKfAuq
         f2XakiM4+Vx+0YxpGliXvNCMf65qzGY9ZnTMfaqNIH/OBAJQVq4Amd39rqX1mKVGoE
         GJZJ/JVfxCOtQ==
Date:   Wed, 11 May 2022 11:16:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
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
Message-ID: <20220511091600.ohjve547itnadav5@wittgenstein>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <20220510005533.GA2306852@dread.disaster.area>
 <20220510124033.lobf33hxey4quza3@wittgenstein>
 <20220511004200.GE2306852@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220511004200.GE2306852@dread.disaster.area>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 11, 2022 at 10:42:00AM +1000, Dave Chinner wrote:
> On Tue, May 10, 2022 at 02:40:33PM +0200, Christian Brauner wrote:
> > On Tue, May 10, 2022 at 10:55:33AM +1000, Dave Chinner wrote:
> > > On Mon, May 09, 2022 at 02:48:15PM +0200, Christian Brauner wrote:
> > > > On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> > > >   I really think users would love to have an interfact where they can
> > > >   get a struct with binary info back.
> > > 
> > > No. Not for kernel informational interfaces. We have ioctls and
> > 
> > That feels like semantics. statx is in all sensible readings of the
> > words a kernel informational interface.
> 
> statx is an special purpose binary syscall interface for returning
> inode specific information, it's not an abstract, generic
> informational interface.

I want the ability to also have a statx like interface for some basic
mount information is what I'm saying; so a special-purpose interface. I
nowhere argued that statx is a _generic_ information interface.

> 
> > I'm really looking at this from the perspective of someone who uses
> > these interfaces regularly in userspace and a text-based interface for
> > very basic information such as detailed information about a mount is
> > cumbersome. I know people like to "counter" with "parsing strings is
> > easy" but it remains a giant pain for userspace; at least for basic
> > info.
> 
> As I said last reply, you are making all the same arguements against
> text based information interfaces that were made against proc and
> sysfs a long long time again. they weren't convincing a couple of
> decades ago, and there aren't really convincing now. Text-based

I'm not in general opposed to an interface that allows to retrieve
text-based values. I mentioned this earlier in the thread more than
once. Also, we're not talking about pseudo-filesystems here.

I'm saying I want the ability to get some basic information in binary
form. Whether it's as part of this interface or another.

Also, *xattr() interfaces aren't really just text-based as you've
mentioned yourself. They return binary data such as struct
vfs_ns_cap_data or struct posix_acl_xattr_entry.

> key/value data is hard to screw up in the long run, binary
> interfaces have a habit of biting hard whenever the contents of
> the binary structure needs to change...

I partially agree. If we're talking about a netlink like protocol with
complex structs, sure. If we're talking about statx or openat2 then I
don't think so. These are not structs that constantly change and newer
system calls are designed with extensions in mind.

I also think there's a misunderstanding here: I really want to stress
that I'm not arguing for the necessity for a generic binary information
retrieval interface. I also mentioned this earlier. I really just want
the ability to still have some well-defined, special-purpose binary
interface similar to e.g. statx that isn't rejected with the argument
that you can get it text-based from *xattr. And I think others have
agreed in other parts of the thread that is still ok. If that's is
indeed true I'm content.

> 
> > > >   Imho, xattrs are a bit like a wonky version of streams already (One of
> > > >   the reasons I find them quite unpleasant.). Making mount and other
> > > >   information retrievable directly through the getxattr() interface will
> > > >   turn them into a full-on streams implementation imho. I'd prefer not
> > > >   to do that (Which is another reason I'd prefer at least a separate
> > > >   system call.).
> > > 
> > > And that's a total misunderstanding of what xattrs are.
> > > 
> > > Alternate data streams are just {file,offset} based data streams
> > > accessed via ithe same read/write() mechanisms as the primary data
> > > stream.
> > 
> > That's why I said "wonky". But I'm not going to argue this point. I
> > think you by necessity have wider historical context on these things
> > that I lack. But I don't find it unreasonable to also see them as an
> > additional information channel.
> > 
> > Sure, they are a generic key=value store for anything _in principle_. In
> > practice however xattrs are very much perceived and used as information
> > storage on files, a metadata side-channel if you will.
> 
> That's how *you* perceive them, not how everyone perceives them.

I mean, this is as an argument we can't bring to a conclusion or that
will bring us forward in understanding each other. All I could reply to
that is "No, that's how *you* perceive them." in return. I don't know
how this would help.

Let's put it this way, if you go into userspace and ask users of xattrs
what they think xattrs are then they will not come up with a technical
definition for a completely generic key=value interface based on
filesystem btree consideration. They will see them as specific
attributes on files speaking from experience.

> 
> > All I'm claiming here is that it will confuse the living hell out of
> > users if the getxattr() api suddenly is used not to just set and get
> > information associated with inodes but to also provides filesystem or
> > mount information.
> 
> Why would it confuse people? The xattr namespace is already well
> known to be heirarchical and context dependent based on the intial
> name prefix (user, security, btrfs, trusted, etc). i.e. if you don't
> know that the context the xattr acts on is determined by the initial
> name prefix, then you need to read the xattr(7) man page again:

I take it this is a rhetorical device here and you know that I've not
just patched these codepaths multiple times in the kernel but also
extensively programmed with xattrs in userspace for various container
projects.

The reasons why I think it confuses people I already explained in
various parts earlier in the thread. And there are at least two replies
to this thread that find it confusing as well. If you can't relate to
any of these reasons then me reiterating them won't bring this forward.

> 
> Extended attribute namespaces
> 
> 	Attribute  names  are  null-terminated  strings.   The
> 	attribute name is always specified in the fully qualified
> 	namespace.attribute form, for example, user.mime_type,
> 	trusted.md5sum, system.posix_acl_access, or
> 	security.selinux.
> 
> 	The namespace mechanism is used to define different classes
> 	of extended attributes.  These different classes exist for
> 	several reasons;  for  example, the permissions and
> 	capabilities required for manipulating extended attributes
> 	of one namespace may differ to another.
> 
> 	Currently,  the  security, system, trusted, and user
> 	extended attribute classes are defined as described below.
> 	Additional classes may be added in the future.
> 
> > That's a totally a totally differnet type of information. Sure, it may
> > fit well in the key=value scheme because the xattr key=value _interface_
> > is generic but that's a very technical argument.
> 
> Yet adding a new xattr namespace for a new class of information that
> is associated the mount that the path/inode/fd is associated with is
> exactly what the xattr namespaces are intended to allow. And it is
> clearly documented that new classes "may be added in the future".

Fwiw, I don't think the "Additional classes may be added in the future."
means that this interface in principle can be used to retrieve any
key=value based information. If that was really the case then xattr(7)
should really put your definition below on to their.

> 
> I just don't see where the confusion would come from...

Again, there's people who can relate to the arguments even on this
thread but if you can't relate to any of them at all and can't see where
we're coming from than me reiterating all of it once more won't help.

> 
> > 
> > I'm looking at this from the experience of a user of the API for a
> > moment and in code they'd do in one place:
> > 
> > getxattr('/super/special/binary', "security.capability", ...);
> > 
> > and then in another place they do:
> > 
> > getxattr('/path/to/some/mount', "mntns:info", ...);
> > 
> > that is just flatout confusing.
> 
> Why? Both are getting different classes of key/value information
> that is specific to the given path. Just because on is on-disk and
> the other is ephemeral doesn't make it in any way confusing. This is
> exactly what xattr namesapces are intended to support...
> 
> > > Xattrs provide an *atomic key-value object store API*, not an offset
> > > based data stream API. They are completely different beasts,
> > > intended for completely different purposes. ADS are redundant when you
> > > have directories and files, whilst an atomic key-value store is
> > > something completely different.
> > > 
> > > You do realise we have an independent, scalable, ACID compliant
> > > key-value object store in every inode in an XFS filesystem, right?
> > 
> > So far this was a really mail with good background information but I'm
> > struggling to make sense of what that last sentence is trying to tell
> > me. :)
> 
> That people in the past have built large scale data storage
> applications that use XFS inodes as key based object stores, not as
> a offset based data stream. Who needs atomic write() functionality
> when you have ACID set and replace operations for named objects?
> 
> The reality is that modern filesystems are really just btree based
> object stores with high performance transaction engines overlaid
> with a POSIX wrapper. And in the case of xattrs, we effectively
> expose that btree based key-value database functionality directly to
> userspace....
> 
> Stop thinking like xattrs are some useless metadata side channel,

I did say they are a "metadata side channel"; I very much never called
them "useless".
(I don't like it a lot that a subset of them - posix acls - store
additional {g,u}id information on disk but that's a totally different
topic.)

> and start thinking of them as an atomic object store that stores and
> retreives millions of small (< 1/2 the filesystem block size) named
> objects far space effciently than a directory structure full of
> small files indexed by object hash.

What you outline is the perspective of a probably +20 years kernel and
very low-level system software developer. I appreciate that perspective
and I can very much appreciate that this is how we can conceptualize
xattrs in the kernel.

But on the other side of the equation is userspace and it can't be the
expectation that this is how they conceptualize the *xattr() kernel
interfaces based on the manpage or system call. This is so generic that
it becomes meaningless.

By this definition we can just start retrieving any type of information
via this interface all across the kernel. And you'd probably argue that
in principle we could. But then we can also just go back to calling it
getvalues().

I think that's another part of the disconnect between our viewpoints:
you perceive the *xattr() interfaces as a super generic retrieval method
for an abstract key=value storage. And so adding anything in there is
fine as long as it has key=value semantics. I find that to be a shift in
how the *xattr() interfaces are currently used and even how they are
defined.

I think we've pretty much tried to explain our viewpoints in detail and
we don't seem to be getting to common ground for some of it and as I
said somewhere else in the thread I have no intention of blocking this
if people want this interface including making this a direct part of
getxattr() and Linus accepts it.
