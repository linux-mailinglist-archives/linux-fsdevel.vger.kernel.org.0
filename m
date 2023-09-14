Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4277A092D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbjINP1X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbjINP1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:27:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834D1FD8;
        Thu, 14 Sep 2023 08:27:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C244C433C7;
        Thu, 14 Sep 2023 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694705224;
        bh=u4RNU2x3e+56ehtYfJBNsPQzsza8+/kdZ+mJNRjhyzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozfEf/3Chy+F7tPp7fZjq9IrohhGbLE9N4aHzZwVJtPTslRZsam6ARH592+CAgQh2
         97vHgLrelEKJWTr3MSJxEtLQ4oq6fNHBcP1CQ/sBylUhJ8nvx7sWS9y5B1lYLIixpZ
         fJCsR6TAq+1p8TgYojoVuUonf+Qt6Mpur/K68cc2cXjCLQKVbEA97soFd/pcTDaQKV
         f08HFudn+re76iSSzjSf/gAj9CRoIKuO6GKK4FGXY73Q/9oHPKreDdj/8DgxHhbIrf
         JU93luHle4bfT9RmDZonL0amBpsRj8DxPQ/bKu77TT5POS0NA7zmLx47I/hgX1V6Xo
         hVrcWj0gC2gHw==
Date:   Thu, 14 Sep 2023 17:26:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 12:13:54PM +0200, Miklos Szeredi wrote:
> On Thu, 14 Sept 2023 at 11:28, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Sep 13, 2023 at 05:22:35PM +0200, Miklos Szeredi wrote:
> > > Add a way to query attributes of a single mount instead of having to parse
> > > the complete /proc/$PID/mountinfo, which might be huge.
> > >
> > > Lookup the mount by the old (32bit) or new (64bit) mount ID.  If a mount
> > > needs to be queried based on path, then statx(2) can be used to first query
> > > the mount ID belonging to the path.
> > >
> > > Design is based on a suggestion by Linus:
> > >
> > >   "So I'd suggest something that is very much like "statfsat()", which gets
> > >    a buffer and a length, and returns an extended "struct statfs" *AND*
> > >    just a string description at the end."
> >
> > So what we agreed to at LSFMM was that we split filesystem option
> > retrieval into a separate system call and just have a very focused
> > statx() for mounts with just binary and non-variable sized information.
> > We even gave David a hard time about this. :) I would really love if we
> > could stick to that.
> >
> > Linus, I realize this was your suggestion a long time ago but I would
> > really like us to avoid structs with variable sized fields at the end of
> > a struct. That's just so painful for userspace and universally disliked.
> > If you care I can even find the LSFMM video where we have users of that
> > api requesting that we please don't do this. So it'd be great if you
> > wouldn't insist on it.
> 
> I completely missed that.

No worries, I think the discussion touching on this starts at:
https://youtu.be/j3fp2MtRr2I?si=f-YBg6uWq80dV3VC&t=1603
(with David talking quietly without a microphone for some parts
unfortunately...)

> What I'm thinking is making it even simpler for userspace:
> 
> struct statmnt {
>   ...
>   char *mnt_root;
>   char *mountpoint;
>   char *fs_type;
>   u32 num_opts;
>   char *opts;
> };
> 
> I'd still just keep options nul delimited.
> 
> Is there a good reason not to return pointers (pointing to within the
> supplied buffer obviously) to userspace?

It's really unpleasant to program with. Yes, I think you pointed out
before that it often doesn't matter much as long as the system call is
really only relevant to some special purpose userspace.

But statmount() will be used pretty extensively pretty quickly for the
purpose of finding out mount options on a mount (Querying a whole
sequences of mounts via repeated listmount() + statmount() calls on the
other hand will be rarer.).

And there's just so many tools that need this: libmount, systemd, all
kinds of container runtimes, path lookup libraries such as libpathrs,
languages like go and rust that expose and wrap these calls and so on.

Most of these tools don't need to know about filesystem mount options
and if they do they can just query that through an extra system call. No
harm in doing that.

The agreement we came to to split out listing submounts into a separate
system call was exactly to avoid having to have a variable sized pointer
at the end of the struct statmnt (That's also part of the video above
btw.) and to make it as simple as possible.

Plus, the format for how to return arbitrary filesystem mount options
warrants a separate discussion imho as that's not really vfs level
information.

> > This will also allow us to turn statmnt() into an extensible argument
> > system call versioned by size just like we do any new system calls with
> > struct arguments (e.g., mount_setattr(), clone3(), openat2() and so on).
> > Which is how we should do things like that.
> 
> The mask mechanism also allow versioning of the struct.

Yes, but this is done with reserved space which just pushes away the
problem and bloats the struct for the sake of an unknown future. If we
were to use an extensible argument struct we would just version by size.
The only requirement is that you extend by 64 bit (see struct
clone_args) which had been extended.

> 
> >
> > Other than that I really think this is on track for what we ultimately
> > want.
> >
> > > +struct stmt_str {
> > > +     __u32 off;
> > > +     __u32 len;
> > > +};
> > > +
> > > +struct statmnt {
> > > +     __u64 mask;             /* What results were written [uncond] */
> > > +     __u32 sb_dev_major;     /* Device ID */
> > > +     __u32 sb_dev_minor;
> > > +     __u64 sb_magic;         /* ..._SUPER_MAGIC */
> > > +     __u32 sb_flags;         /* MS_{RDONLY,SYNCHRONOUS,DIRSYNC,LAZYTIME} */
> > > +     __u32 __spare1;
> > > +     __u64 mnt_id;           /* Unique ID of mount */
> > > +     __u64 mnt_parent_id;    /* Unique ID of parent (for root == mnt_id) */
> > > +     __u32 mnt_id_old;       /* Reused IDs used in proc/.../mountinfo */
> > > +     __u32 mnt_parent_id_old;
> > > +     __u64 mnt_attr;         /* MOUNT_ATTR_... */
> > > +     __u64 mnt_propagation;  /* MS_{SHARED,SLAVE,PRIVATE,UNBINDABLE} */
> > > +     __u64 mnt_peer_group;   /* ID of shared peer group */
> > > +     __u64 mnt_master;       /* Mount receives propagation from this ID */
> > > +     __u64 propagate_from;   /* Propagation from in current namespace */
> > > +     __u64 __spare[20];
> > > +     struct stmt_str mnt_root;       /* Root of mount relative to root of fs */
> > > +     struct stmt_str mountpoint;     /* Mountpoint relative to root of process */
> > > +     struct stmt_str fs_type;        /* Filesystem type[.subtype] */
> >
> > I think if we want to do this here we should add:
> >
> > __u64 fs_type
> > __u64 fs_subtype
> >
> > fs_type can just be our filesystem magic number and we introduce magic
> 
> It's already there: sb_magic.
> 
> However it's not a 1:1 mapping (ext* only has one magic).

That's a very odd choice but probably fixable by giving it a subtype.

> 
> > numbers for sub types as well. So we don't need to use strings here.
> 
> Ugh.

Hm, idk. It's not that bad imho. We'll have to make some ugly tradeoffs.
