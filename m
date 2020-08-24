Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B387250129
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHXPbF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 11:31:05 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:39849 "EHLO
        lizzy.crudebyte.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgHXPag (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=suep5CnynQcYZCpmE5AMesXHjd9m4w0D6hQ2xKiEdOc=; b=L4BpCHgl5QpSkEKgxc2oruIVR6
        DxgtpCDAsThBbL5HYqZLx427eqxrAj9hXdHFt4Kfr11pUSgPg931hu/IpN5X0YrEgwewON3BREaS+
        WCi6loq4cmLqfTUe9XdARwqY8A0858AmqkukmRfyR3QmRJ+TY40pkqHSeVPviAwDSiuQ9dGB052Gt
        js0EEV64AMmboHe3YW9phzqN1ogXxFNAboeKVuQo0mh09VlLptrpsaC5IebmZ9NI7Ec5PPAI7MqKG
        ROE59tjfMM/hT/hyxFU1w6Pif0Rmv+QuC3vfbIebE9Vt8ZXTnGvfyXeqKx3//9jZ/+Qaf15fu7Vn/
        dSqQHh/Q==;
From:   Christian Schoenebeck <qemu_oss@crudebyte.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, mszeredi@redhat.com, vgoyal@redhat.com,
        gscrivan@redhat.com, dwalsh@redhat.com, chirantan@chromium.org,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: file forks vs. xattr (was: xattr names for unprivileged stacking?)
Date:   Mon, 24 Aug 2020 17:30:18 +0200
Message-ID: <3081309.dU5VghuM72@silver>
In-Reply-To: <20200823234006.GD7728@dread.disaster.area>
References: <20200728105503.GE2699@work-vm> <2859814.QYyEAd97eH@silver> <20200823234006.GD7728@dread.disaster.area>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Montag, 24. August 2020 01:40:06 CEST Dave Chinner wrote:
> On Mon, Aug 17, 2020 at 12:37:17PM +0200, Christian Schoenebeck wrote:
> > On Montag, 17. August 2020 00:56:20 CEST Dave Chinner wrote:
> > > IOWs, with a filesystem inode fork implementation like this for ADS,
> > > all we really need is for the VFS to pass a magic command to
> > > ->lookup() to tell us to use the ADS namespace attached to the inode
> > > rather than use the primary inode type/state to perform the
> > > operation.
> > 
> > IMO starting with a minimalistic approach, in a way Solaris developers
> 
> > originally introduced forks, would IMO make sense for Linux as well:
> <snip>
> 
> That's pretty much what the proposed O_ALT did, except it used a
> fully qualified path name to define the ADS to open.

Hu, you're right! There is indeed a somewhat congruent effort & discussion
going on in parallel. Pulling in Miklos into CC for that reason:
https://lore.kernel.org/lkml/CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com/

However the motivation of that other thread's PR was rather a procfs-like
system as a unified way to retrieve implementation specific info from an
underlying fs, and the file fork aspect would just be a 'side product'.

Core motivation of that other thread (scroll down a bit):
https://lore.kernel.org/lkml/52483.1597190733@warthog.procyon.org.uk/

> > On Montag, 17. August 2020 02:29:30 CEST Dave Chinner wrote:
> > > I'd stop calling these "forks" already, too. The user wants
> > > "alternate data streams", while a "resource fork" is an internal
> > > filesystem implementation detail used to provide ADS
> > > functionality...
> > 
> > The common terminology can certainly still be argued. I understand that
> > from fs implementation perspective "fork" is probably ambiguous. But from
> > public API (i.e. user space side) perspective the term "fork" does make
> > sense, and so far I have not seen a better general term for this. Plus
> > the ambiguous aspects on fs side are not exposed to the public side.
> > 
> > The term "alternate data stream" suggests that this is just about the raw
> > data stream, but that's probably not what this feature will end up being
> > limited to. E.g. I think they will have their own permissions on the long
> > term (see below). Plus the term ADS is ATM somewhat sticky to the
> > Microsoft universe.
> ADS is the windows term, which is where the majority of people who
> use or want to ADS come from. Novell called the "multiple data
> streams", and solaris 9 implemented "extended attributes" (ADS)
> using inode forks. Apple allows a "data fork" (user data), "resource
> forks" (ADS) and now "named forks" which they then used to implement
> extended attributes.  Not the solaris ones, the linux style fixed
> length key-value xattrs.
> 
> Quite frankly, the naming in this area is a complete and utter mess,

Absolutely!

> and the only clear, unabiguous name for this feature is "alternate
> data streams". I don't care that it's something that comes from an
> MS background - if your only argument against it is "Microsoft!"
> then you're on pretty shakey ground...

It wasn't. My main argument really was, quote: 'The term "alternate data
stream" suggests that this is just about the raw data stream, but that's
probably not what this feature will end up being limited to. E.g. I think they
will have their own permissions on the long term ...'

> > - No subforks as starting point, and hence path separator '/' inside fork
> > 
> >   names would be prohibited initially to avoid future clashes.
> 
> Can't do that - changing the behaviour of the ADS name handling is
> effectively an on-disk filesystem format change. i.e. if we allow it
> in future kernels, then we have to mark the filesystem as "/" being
> valid so that older kernels and repair utilities won't consider this
> as invalid/corrupt and trash the ADS associated with the name.
> 
> IOWs, we either support it from the start, or we never support it.

You have a point there. OTOH I don't think this would be a show stopper. This
feature set will introduce backward incompatibility anyway.

If somebody really would need to run an ancient kernel on a fs that already
contains subforks, then this fs could also be accessed via pass-through fs
inside VM guest & host running a more recent kernel, ... or by accessing it
remotely via fileserver, etc. There are options.

> > > Hence all the ADS support infrastructure is essentially dentry cache
> > > infrastructure allowing a dentry to be both a file and directory,
> > > and providing the pathname resolution that recognises an ADS
> > > redirection. Name that however you want - we've got to do an on-disk
> > > format change to support ADS, so we can tell the VFS we support ADS
> > > or not. And we have no cares about existing names in the filesystem
> > > conflicting with the ADS pathname identifier because it's a mkfs
> > > time decision. Given that special flags are needed for the openat()
> > > call to resolve an ADS (e.g. O_ALT), we know if we should parse the
> > > ADS identifier as an ADS the moment it is seen...
> > 
> > So you think there should be a built-in full qualified path name
> > resolution to forks right from the start? E.g. like on Windows
> > "C:\some\where\sheet.pdf:foo" -> fork "foo" of file "sheet.pdf"?
> 
> No. I really don't care how the user interface works. That's for
> people who write the syscalls to argue about.

Actually I did not have user space in mind either, it was more about the
dentry cache which made me thinking that a built-in path resolution right from
the start would make sense. But OTOH the Linux dentry cache at its heart only
maintains a first-order relationship to calculate the lookup hashes, i.e.:

	dentry_hash = hash(dentry_ptr, child_name);

So it would not really be required to have a full qualified path resolution.

But yet again, in that other thread about that fs meta info API, the argument
was if there was no built-in path resolution right from the start, then user
space apps and libs would start building their own path name resolution on
top of openat(), which might end up in a mess for the ecosystem. They have a
strong argument there.

But as they already pointed out, it would be a problem to actually agree about
a delimiter between the filename and the fork name portion. Miklos suggested a
a double/triple slash, but I agree with other ones that this would render
misbehaviours with all sorts of existing applications:
https://lore.kernel.org/lkml/c013f32e-3931-f832-5857-2537a0b3d634@schaufler-ca.com/

They also came up with some other questions that we have not discussed here:
https://lore.kernel.org/lkml/20200812143957.GQ1236603@ZenIV.linux.org.uk/
https://lore.kernel.org/lkml/20200812213041.GV1236603@ZenIV.linux.org.uk/

> What I was describing is how the internal kernel implementation -
> the interaction between the VFS and the filesystem - needs to work.
> ADS needs to be supported in some way by the VFS; if ADS are going
> to be seekable user data files, then they have to be implemented as
> path/dentry/inode tuples that a struct file can point to. IOWs,
> internally they need to be seen as first class VFS citizens, and the
> VFS needs mechanisms to tell the filesystem to look up the ADS
> namespace rather than the inode itself....

Yes, sure.

> > > > I don't understand why a fork would be permitted to have its own
> > > > permissions.  That makes no sense.  Silly Solaris.
> > > 
> > > I can't think of a reason why, either, but the above implementation
> > > for XFS would support it if the presentation layer allows it... :)
> > 
> > I would definitely not add this right from the start of course, but on the
> > long term it actually does make senses for them having their own
> > permissions, simply because there are already applications for that:
> > 
> > E.g. on some systems forks are used to tag files for security relevant
> > issues, for instance where the file originated from (a trusted vs.
> > untrusted source).
> Key-value data like is what the security xattr namespace is for, not
> ADS....

If it was only about storing a boolean like security.trusted = YES,
then you were right. However that example actually stores info which could
easily exceed the 4k limit of Linux xattrs, e.g. it stores the original URI of
the source.

> IOWs, now that I think about it, we should be allowing non-user
> per-ADS permissions to be set right from the start because I can
> think of several filesystem/kernel internal features that could make
> use of such functionality that we would want to remain hidden from
> users.

Right, actually while reading through that other thread, I realized that my
initial attitude, that is kicking off with a very limited feature set, is
probably contra productive, as they pointed out you'd easily end up handling
such forks as something completely different than regular directories and
files, so you would probably deviate from a unified VFS code base, start
adding new structs, adding exceptions, etc.

> > OTOH forks are used to extend existing files in non-obtrusive way. Say you
> > have some sort of (e.g. huge) master file, and a team works on that file.
> > Then the individual people would attach their changes solely as forks to
> > the master file with their ownership, probably even with complex ACLs, to
> > prevent certain users from touching (or even reading) other ones changes.
> > In this use case the master file might be readonly for most people, while
> > the individual forks being anywhere between more permissive or more
> > restrictive.
> 
> You're demonstrating the exact reasons why ADS have traditionally
> been considered harmful by Linux developers.  You can do all that
> with normal directories and files - you do not need ADS to implement
> a fully functional multi-user content management system.

You're talking from a system-level-dev POV. Just by realizing that this
example could also be mapped into a regular directory structure does not mean
it would be better, nor friendlier from user-POV. From user POV it is one
file, that you would present to the user as directory instead.

---

Ok, maybe I should make this more clear with another example: one major use
case for forks/ADS is extending (e.g. proprietary) binary file formats with
new features. Say company B is developing an editor application that supports
working directly with a binary media file (format) of another company A. And
say that company B's application has some feature that don't exist in app of
company A.

What shall it do? B could try adding their own chunks to the binary file
somewhere, but what happens in practice is that when another user now opens
the file with app A, it would often end up either refusing to open the file at
all, or it would crash, or it would simply drop and lose the info stored
previously by app B once the user saves the file again with app A. With
certain versions of app A it might work, with other versions it doesn't.
That's a nightmare to maintain.

By storing those extended features as named fork, e.g. "com.Bcorp.featureX",
you can easily circumvent that problem. App A still only works on the main
stream. So it can still safely open the file, and it would neither modify nor
drop the file's feature extensions of company B.

> Keep in mind that you are not going to get universal support for ADS
> any time soon as most filesystems will require on-disk format
> changes to support them. Further, you are goign to have to wait for
> the entire OS ecosystem to grow support for ADS (e.g. cp, tar,
> rsync, file, etc) before you can actually use it sanely in
> production systems. Even if we implement kernel support right now,
> it will be years before it will be widely available and supported at
> an OS/distro level...

Sure, that's a chicken egg problem.

Being realistic, I don't expect that forks are something that would be landing
in Linux very soon. I think it is an effort that will take its time, probably
as a Linux-test-fork / PoC for quite a while, up to a point where a common
acceptance is reached.

But file forks already exist on other systems for multiple good reasons. So I
think it makes sense to thrive the effort on Linux as well.

Best regards,
Christian Schoenebeck


