Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E3520343
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbiEIRMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 13:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239563AbiEIRMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 13:12:12 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44001A7295;
        Mon,  9 May 2022 10:08:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id eq14so10945965qvb.4;
        Mon, 09 May 2022 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yo3NrijSBqPuTyEcbTB4eBcpVFQwmd7L4uDdIrCqhWQ=;
        b=OMlfc28a5GA1DnGT8WH25DAsrq/v8RMrgyyJXyTXYWt539DFBJnJ/GOvCPYZQuAab8
         UIaQKdqidiHDQ40xZbOAUQRFdJC5BQ+RUmQ2QQ693cR5epXTWCEDrVIn3epU+EALnB4m
         CO6Qh326+Ff4mV9FoVkM867HHmtzNWLaG4TDWOuQHlY9T8YqvhI2IRfI9HJI/u38DVGQ
         LiPqFxEugStVgbWhlJH6CzgGBxKQjt9URms6GASRGwWK/dZtwqyprbJj6y75y91nrISj
         f7dNbXYy1Qun8XJ60tdUa7N5teBdwrb9c40egecLTNEcr3wDzDiOMleEL2OOkYp2P9oT
         TfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yo3NrijSBqPuTyEcbTB4eBcpVFQwmd7L4uDdIrCqhWQ=;
        b=xzdG5UtWXmb/GpzRsfXRmMuxoI3f0lTHcRRricmW8D25TwbdGeARVDgighuyYZ5vyP
         PTwdbeU7hjlMskKDoK6l9DWCvaFOkVkT1fc34D/sa9vVBuFYnNucP9+mNfHstbadDMyo
         UD1+mXHr4VUhKTXiLGDFDibVHwYKra7//H7PqnLovHEXNSA2rQvjM8zHeO1U5GdJYvPk
         6Pl1sTQ3/j0fY01b5VkCek1p6dlFVqLC7teXFFqdGO7PvIeBshwb2+I6ytvicpT59xPT
         Y5M9YZVhgJuEbE9NNnnwrP/oBNMDe3Cyr349RZMy4e7eL6sttHjkJrPg0OkIsyQW4lkJ
         R2Lg==
X-Gm-Message-State: AOAM5312yWd/hmTqQSRFF4qmDLoY16cAf6p97Al/kHMlyVzgDT2sLB2h
        tKG1viVZRaap9IU78ABW3RjIlYdXsvB7Oy9vFVI=
X-Google-Smtp-Source: ABdhPJzikB+tY3Q1jEiTjtMmSoseKp911t+FJg+kMGLtjX62ejAJKC2HTgYAaipTRHgPcw7D2joCjv03bxItXsQbpwY=
X-Received: by 2002:a05:6214:1c83:b0:443:6749:51f8 with SMTP id
 ib3-20020a0562141c8300b00443674951f8mr14279088qvb.74.1652116082591; Mon, 09
 May 2022 10:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAOQ4uxgCSJ2rpJkPy1FkP__7zhaVXO5dnZQXSzvk=fReaZH7Aw@mail.gmail.com> <20220509150856.cfsxn5t2tvev2njx@wittgenstein>
In-Reply-To: <20220509150856.cfsxn5t2tvev2njx@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 May 2022 20:07:50 +0300
Message-ID: <CAOQ4uxiqG-w8s+zRqk945UtJcE4u0zjPhSs=MSYJ0jMLLjUTFg@mail.gmail.com>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 9, 2022 at 6:09 PM Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, May 09, 2022 at 05:20:50PM +0300, Amir Goldstein wrote:
> > On Mon, May 9, 2022 at 3:48 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Tue, May 03, 2022 at 02:23:23PM +0200, Miklos Szeredi wrote:
> > > > This is a simplification of the getvalues(2) prototype and moving it to the
> > > > getxattr(2) interface, as suggested by Dave.
> > > >
> > > > The patch itself just adds the possibility to retrieve a single line of
> > > > /proc/$$/mountinfo (which was the basic requirement from which the fsinfo
> > > > patchset grew out of).
> > > >
> > > > But this should be able to serve Amir's per-sb iostats, as well as a host of
> > > > other cases where some statistic needs to be retrieved from some object.  Note:
> > > > a filesystem object often represents other kinds of objects (such as processes
> > > > in /proc) so this is not limited to fs attributes.
> > > >
> > > > This also opens up the interface to setting attributes via setxattr(2).
> > > >
> > > > After some pondering I made the namespace so:
> > > >
> > > > : - root
> > > > bar - an attribute
> > > > foo: - a folder (can contain attributes and/or folders)
> > > >
> > > > The contents of a folder is represented by a null separated list of names.
> > > >
> > > > Examples:
> > > >
> > > > $ getfattr -etext -n ":" .
> > > > # file: .
> > > > :="mnt:\000mntns:"
> > > >
> > > > $ getfattr -etext -n ":mnt:" .
> > > > # file: .
> > > > :mnt:="info"
> > > >
> > > > $ getfattr -etext -n ":mnt:info" .
> > > > # file: .
> > > > :mnt:info="21 1 254:0 / / rw,relatime - ext4 /dev/root rw\012"
> > >
> > > Hey Miklos,
> > >
> > > One comment about this. We really need to have this interface support
> > > giving us mount options like "relatime" back in numeric form (I assume
> > > this will be possible.). It is royally annoying having to maintain a
> > > mapping table in userspace just to do:
> > >
> > > relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
> > > ro       -> MS_RDONLY/MOUNT_ATTR_RDONLY
> > >
> > > A library shouldn't be required to use this interface. Conservative
> > > low-level software that keeps its shared library dependencies minimal
> > > will need to be able to use that interface without having to go to an
> > > external library that transforms text-based output to binary form (Which
> > > I'm very sure will need to happen if we go with a text-based
> > > interface.).
> > >
> >
> > No need for a library.
> > We can export:
> >
> > :mnt:attr:flags (in hex format)
>
> So a binary attribute or a hex value as a string which we have to parse
> in userspace into proper hex?
>

I do see the ugliness in that.
I personally have no objection to binary values in the leaves of the tree.
I don't the main concern that Greg raised was against binary structs,
which end up being an ABI compatibility nightmare.

> >
> > > >
> > > > $ getfattr -etext -n ":mntns:" .
> > > > # file: .
> > > > :mntns:="21:\00022:\00024:\00025:\00023:\00026:\00027:\00028:\00029:\00030:\00031:"
> > > >
> > > > $ getfattr -etext -n ":mntns:28:" .
> > > > # file: .
> > > > :mntns:28:="info"
> > > >
> > > > Comments?
> > >
> > > I'm not a fan of text-based APIs and I'm particularly not a fan of the
> > > xattr APIs. But at this point I'm ready to compromise on a lot as long
> > > as it gets us values out of the kernel in some way. :)
> > >
> > > I had to use xattrs extensively in various low-level userspace projects
> > > and they continue to be a source of races and memory bugs.
> > >
> > > A few initial questions:
> > >
> > > * The xattr APIs often require the caller to do sm like (copying some go
> > >   code quickly as I have that lying around):
> > >
> > >         for _, x := range split {
> > >                 xattr := string(x)
> > >                 // Call Getxattr() twice: First, to determine the size of the
> > >                 // buffer we need to allocate to store the extended attributes,
> > >                 // second, to actually store the extended attributes in the
> > >                 // buffer. Also, check if the size of the extended attribute
> > >                 // hasn't increased between the two calls.
> > >                 pre, err = unix.Getxattr(path, xattr, nil)
> > >                 if err != nil || pre < 0 {
> > >                         return nil, err
> > >                 }
> > >
> > >                 dest = make([]byte, pre)
> > >                 post := 0
> > >                 if pre > 0 {
> > >                         post, err = unix.Getxattr(path, xattr, dest)
> > >                         if err != nil || post < 0 {
> > >                                 return nil, err
> > >                         }
> > >                 }
> > >
> > >                 if post > pre {
> > >                         return nil, fmt.Errorf("Extended attribute '%s' size increased from %d to %d during retrieval", xattr, pre, post)
> > >                 }
> > >
> > >                 xattrs[xattr] = string(dest)
> > >         }
> > >
> > >   This pattern of requesting the size first by passing empty arguments,
> > >   then allocating the buffer and then passing down that buffer to
> > >   retrieve that value is really annoying to use and error prone (I do
> > >   of course understand why it exists.).
> > >
> > >   For real xattrs it's not that bad because we can assume that these
> > >   values don't change often and so the race window between
> > >   getxattr(GET_SIZE) and getxattr(GET_VALUES) often doesn't matter. But
> > >   fwiw, the post > pre check doesn't exist for no reason; we do indeed
> > >   hit that race.
> >
> > It is not really a race, you can do {} while (errno != ERANGE) and there
> > will be no race.
>
> I don't know what your definition of your race is but if a value can
> change between two calls and I have to call it in a loop until I get a
> consistent value then that's a race. At least I know of no better way of
> calling it.
>

For enumerating multiple keys we need a "short read", probably
offset too.
For leaf values that is less likely to be needed - I hope.

> >
> > >
> > >   In addition, it is costly having to call getxattr() twice. Again, for
> > >   retrieving xattrs it often doesn't matter because it's not a super
> > >   common operation but for mount and other info it might matter.
> > >
> >
> > samba and many other projects that care about efficiency solved this
> > a long time ago with an opportunistic buffer - never start with NULL buffer
> > most values will fit in a 1K buffer.
>
> I'm glad that it's been solved a long time ago. It's still not a good
> property for an interface.
>

All right. All I am saying is that the argument that calling getxattr() twice
is costly is not relevant most of the time.

> >
> > >   Will we have to use the same pattern for mnt and other info as well?
> > >   If so, I worry that the race is way more likely than it is for real
> > >   xattrs.
> > >
> > > * Would it be possible to support binary output with this interface?
> > >   I really think users would love to have an interfact where they can
> > >   get a struct with binary info back. I'm not advocating to make the
> > >   whole interface binary but I wouldn't mind having the option to
> > >   support it.
> > >   Especially for some information at least. I'd really love to have a
> > >   way go get a struct mount_info or whatever back that gives me all the
> > >   details about a mount encompassed in a single struct.
> > >
> >
> > I suggested that up thread and Greg has explicitly and loudly
> > NACKed it - so you will have to take it up with him
>
> This is a vfs API and ultimately I would think that if we agree as a
> subsystem that it would be desirable to have a way of providing binary
> output in the form of well-defined structs in some form then we are free
> to do so.
>

Perhaps the way to reconcile between the ABI issue and avoid userspace
parsing is if we export both.
As long as an exported binary blob is also self described as individual
keys, then userspace is both able to understand how to parse the blob
and does not need to parse text in every read of values.

> >
> > >   Callers like systemd will have to parse text and will end up
> > >   converting everything from text into binary anyway; especially for
> > >   mount information. So giving them an option for this out of the box
> > >   would be quite good.
> > >
> > >   Interfaces like statx aim to be as fast as possible because we exptect
> > >   them to be called quite often. Retrieving mount info is quite costly
> > >   and is done quite often as well. Maybe not for all software but for a
> > >   lot of low-level software. Especially when starting services in
> > >   systemd a lot of mount parsing happens similar when starting
> > >   containers in runtimes.
> > >
> >
> > This API is not for *everything*. Obviously it does not replace statx and some
> > info (like the cifs OFFLINE flag) should be added to statx.
>
> I'm not sure why you bring up this API as a replacement for statx().
> That was never part of the discussion. And I didn't think I gave the
> impression I was saying this.
>
> This is about mount information and you can't get a lot of meaningful
> mount information from statx(). Though tbh, I really think a mountx() or
> similar system call wouldn't hurt...

That was my point. This API solves problems - it may not solve all the problems.
If mountx() is needed for some performant application then I think this should
be discussed separately.

>
> > Whether or not mount info needs to get a special treatment like statx
> > is not proven.
>
> Hm, if we take that argument I could also claim that whether or not
> mount info needs to be given in textual form is not proven. Iow, I'm not
> sure what this is an argument for or against.
>
> In fact, most well-used vfs information providing APIs apart from a few
> such as the xattr APIs are based on well-defined structs. And I
> personally at least consider that to be a good thing.
>

It is good for well known information structures.
We want to have something that is flexible and easy to extend
including with fs specific info.

> But I'm willing to compromise and support the textual thing. But I'd
> still like to have the possibility to have some information provided in
> binary form. I don't think that needs to be off the table completely.
>

I am not opposed.

> > Miklos claims this is a notification issue-
> > With David Howells' mount notification API, systemd can be pointed at the new
> > mount that was added/removed/changed and then systemd will rarely need to
> > parse thousands of mounts info.
>
> You seem to be replying to things I didn't say. :)
>

Sorry.
I guess I did not understand why there needs to be a lot of parsing
of mounts when starting systemd services, but I am not a systemd export.

> The notification issue is orthogonal to that and yes, we need that.
> I'm just saying that I want the ability in principal for some properties
> to be given in binary form in addition to textual form. Performance may
> be an aspect of this but that's orthogonal to performance issues when
> being notified about mount changes and reacting to it in e.g. a service.
>
> >
> > > * If we decide to go forward with this interface - and I think I
> > >   mentioned this in the lsfmm session - could we please at least add a
> > >   new system call? It really feels wrong to retrieve mount and other
> > >   information through the xattr interfaces. They aren't really xattrs.
> > >
> > >   Imho, xattrs are a bit like a wonky version of streams already (One of
> > >   the reasons I find them quite unpleasant.). Making mount and other
> > >   information retrievable directly through the getxattr() interface will
> > >   turn them into a full-on streams implementation imho. I'd prefer not
> > >   to do that (Which is another reason I'd prefer at least a separate
> > >   system call.).
> >
> > If you are thinking about a read() like interface for xattr or any alternative
> > data stream then Linus has NACKed it times before.
>
> Please don't just make up an argument for me and then counter it. :D
>

Sorry. should have asked how you envision the new syscall instead of
assuming.

> >
> > However, we could add getxattr_multi() as Dave Chinner suggested for
> > enumerating multiple keys+ (optional) values.
> > In contrast to listxattr(), getxattr_multi() could allow a "short read"
> > at least w.r.t the size of the vector.
>
> Having "xattr" in the system call name is just confusing. These are
> fundamentally not "real" xattrs and we shouldn't mix semantics. There
> should be a clear distinction between traditional xattrs and this vfs
> and potentially fs information providing interface.
>

I know I am not the only one to disagree with that claim.
There is nothing "real" about traditional xattrs in my eyes.
It's just a key/value API.
The name xattr is just as arbitrary as statx and mountx in my eyes.
But I won't shed a tear if people decide to call this something else.

> Just thinking about what the manpage would look like. We would need to
> add a paragraph to xattr(7) explaining that in addition to the system.*,
> security.*, user.* and other namespaces we now also have a set of
> namespaces that function as ways to get information about mounts or
> other things instead of information attached to specific inodes.
>
> That's super random imho. If I were to be presented with this manpage
> I'd wonder if someone was too lazy to add a proper new system call with
> it's own semantics for this and just stuffed it into an existing API
> because it provided matching system call arguments. We can add a new
> system call. It's not that we're running out of them.
>
> Fwiw, and I'm genuinly _not_ trolling you could call it:
> fsinfo(int dfd, const char *path, const char *key, char *value);

And I genuinely don't care how to call this, but considering that we
will need the get/set/list variants my preference would be (as I said
in LSFMM - not sure if people heard me):

getxattrat(dirfd, path, key, value, AT_METAVERSE) ;-)
setxattrat()/listattrat()

This way we can avert the collision with fs that agree to store ":mnt:info"

Thanks,
Amir.
