Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5ED51FF92
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 16:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiEIOZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbiEIOY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 10:24:58 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744251B1779;
        Mon,  9 May 2022 07:21:03 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p3so9010702qvi.7;
        Mon, 09 May 2022 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pExUNyYYIPkt0IB0wXS8TESJ4k6cYkZqL+O4WcFNaaU=;
        b=cKOVfDTdHoFf3VM6rt2ZZZbv2TQRM7VFXt4UmfSKWeAwSIx8tFS8N0k4UEFoTTsbSy
         bWDsT/04ZeT0tNMn7TlG7xVWi/mVePJEzrrEmLlLVe9MnbzCEVeD6b36d9DUXWNs2a6D
         3Y9ZCr3IlYO/Vxf8YFgcGMPuxAVI86bSR3VGt4lwqylX3OsRfssq9VExA0Rr2w8Hx6Lb
         RuvrjtnchTAZEN0DCqdXoelyppd7iKNVmwMfXepufJy1FMA4shPsXwyYJzmuLRIc+wFZ
         tJvAew3nsYIL2DrBr6k85GQdUx2rAIvc4ueewfAzWuIajPFKYbQccMRq3wxQHlxOG2S/
         ft9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pExUNyYYIPkt0IB0wXS8TESJ4k6cYkZqL+O4WcFNaaU=;
        b=DSdq9ki3M13giC2ZfP+DycRQM+dr2YhHpMtuW0RkxvjU4fg+QRDs1NjCdHwBq2iQGS
         Ml9/0XSt/vgFWUr/9aA67nEMVm43O2C6kET2kCkH2oTQDaV0wku/RIGIR/VoDlLuOsws
         nX7V5RrB/esVw74qt1rvwnlqNq55dhSOc+kdEXqzV5znCZxtoVmZO5mc0MtynE086uNi
         SWY3W9O8nTom4mXySD0DK4u0rzI3QuQgNZbkn52v5YDPDb66Qd/H85wydvCNtOqQuMSf
         KCQ5DkA/pcMYaUbPOZS5SJ1bxppRScuPqR7TRKv18DY82TwGZ6y1LyS15nUa8WE3baey
         PW+g==
X-Gm-Message-State: AOAM533GyGZ//tsZi/CIzSLmao31eI2iwD1rkJYMfA07AdGbuaBSTkW4
        uCR4REDSNKeDGUowzHEghaDXM+cd0+l5zbHRFQk=
X-Google-Smtp-Source: ABdhPJzAyLVabI4nBR+YrYJygx+ae75f0ra/E7d9iUXXkTgdbwPbrjm2XCa0cJ/oXHVxDe1v2sHuoq8QTV3mA8w9wlg=
X-Received: by 2002:a0c:c24e:0:b0:456:4217:8cb6 with SMTP id
 w14-20020a0cc24e000000b0045642178cb6mr13647743qvh.12.1652106062399; Mon, 09
 May 2022 07:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com> <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
In-Reply-To: <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 May 2022 17:20:50 +0300
Message-ID: <CAOQ4uxgCSJ2rpJkPy1FkP__7zhaVXO5dnZQXSzvk=fReaZH7Aw@mail.gmail.com>
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

On Mon, May 9, 2022 at 3:48 PM Christian Brauner <brauner@kernel.org> wrote:
>
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
> ro       -> MS_RDONLY/MOUNT_ATTR_RDONLY
>
> A library shouldn't be required to use this interface. Conservative
> low-level software that keeps its shared library dependencies minimal
> will need to be able to use that interface without having to go to an
> external library that transforms text-based output to binary form (Which
> I'm very sure will need to happen if we go with a text-based
> interface.).
>

No need for a library.
We can export:

:mnt:attr:flags (in hex format)

> >
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
>         for _, x := range split {
>                 xattr := string(x)
>                 // Call Getxattr() twice: First, to determine the size of the
>                 // buffer we need to allocate to store the extended attributes,
>                 // second, to actually store the extended attributes in the
>                 // buffer. Also, check if the size of the extended attribute
>                 // hasn't increased between the two calls.
>                 pre, err = unix.Getxattr(path, xattr, nil)
>                 if err != nil || pre < 0 {
>                         return nil, err
>                 }
>
>                 dest = make([]byte, pre)
>                 post := 0
>                 if pre > 0 {
>                         post, err = unix.Getxattr(path, xattr, dest)
>                         if err != nil || post < 0 {
>                                 return nil, err
>                         }
>                 }
>
>                 if post > pre {
>                         return nil, fmt.Errorf("Extended attribute '%s' size increased from %d to %d during retrieval", xattr, pre, post)
>                 }
>
>                 xattrs[xattr] = string(dest)
>         }
>
>   This pattern of requesting the size first by passing empty arguments,
>   then allocating the buffer and then passing down that buffer to
>   retrieve that value is really annoying to use and error prone (I do
>   of course understand why it exists.).
>
>   For real xattrs it's not that bad because we can assume that these
>   values don't change often and so the race window between
>   getxattr(GET_SIZE) and getxattr(GET_VALUES) often doesn't matter. But
>   fwiw, the post > pre check doesn't exist for no reason; we do indeed
>   hit that race.

It is not really a race, you can do {} while (errno != ERANGE) and there
will be no race.

>
>   In addition, it is costly having to call getxattr() twice. Again, for
>   retrieving xattrs it often doesn't matter because it's not a super
>   common operation but for mount and other info it might matter.
>

samba and many other projects that care about efficiency solved this
a long time ago with an opportunistic buffer - never start with NULL buffer
most values will fit in a 1K buffer.

>   Will we have to use the same pattern for mnt and other info as well?
>   If so, I worry that the race is way more likely than it is for real
>   xattrs.
>
> * Would it be possible to support binary output with this interface?
>   I really think users would love to have an interfact where they can
>   get a struct with binary info back. I'm not advocating to make the
>   whole interface binary but I wouldn't mind having the option to
>   support it.
>   Especially for some information at least. I'd really love to have a
>   way go get a struct mount_info or whatever back that gives me all the
>   details about a mount encompassed in a single struct.
>

I suggested that up thread and Greg has explicitly and loudly
NACKed it - so you will have to take it up with him

>   Callers like systemd will have to parse text and will end up
>   converting everything from text into binary anyway; especially for
>   mount information. So giving them an option for this out of the box
>   would be quite good.
>
>   Interfaces like statx aim to be as fast as possible because we exptect
>   them to be called quite often. Retrieving mount info is quite costly
>   and is done quite often as well. Maybe not for all software but for a
>   lot of low-level software. Especially when starting services in
>   systemd a lot of mount parsing happens similar when starting
>   containers in runtimes.
>

This API is not for *everything*. Obviously it does not replace statx and some
info (like the cifs OFFLINE flag) should be added to statx.
Whether or not mount info needs to get a special treatment like statx
is not proven.
Miklos claims this is a notification issue-
With David Howells' mount notification API, systemd can be pointed at the new
mount that was added/removed/changed and then systemd will rarely need to
parse thousands of mounts info.

> * If we decide to go forward with this interface - and I think I
>   mentioned this in the lsfmm session - could we please at least add a
>   new system call? It really feels wrong to retrieve mount and other
>   information through the xattr interfaces. They aren't really xattrs.
>
>   Imho, xattrs are a bit like a wonky version of streams already (One of
>   the reasons I find them quite unpleasant.). Making mount and other
>   information retrievable directly through the getxattr() interface will
>   turn them into a full-on streams implementation imho. I'd prefer not
>   to do that (Which is another reason I'd prefer at least a separate
>   system call.).

If you are thinking about a read() like interface for xattr or any alternative
data stream then Linus has NACKed it times before.

However, we could add getxattr_multi() as Dave Chinner suggested for
enumerating multiple keys+ (optional) values.
In contrast to listxattr(), getxattr_multi() could allow a "short read"
at least w.r.t the size of the vector.

Thanks,
Amir.
