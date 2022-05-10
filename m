Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2352144A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 13:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbiEJL5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 07:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiEJL5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 07:57:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E327F111;
        Tue, 10 May 2022 04:53:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47908B81A0A;
        Tue, 10 May 2022 11:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9E7C385A6;
        Tue, 10 May 2022 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652183604;
        bh=X1QVwFClp9JxInrjSYxI0mlCNQbr24dNo7/S+95efN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syghnmj5lzHfIY+E5v4jJE0hutUfRYSXUe1UD9qXPiNu62ZV8BYEt7Ia1EkeeLDCx
         pq7Uflq901Qrs9jnDOhQlWOjY3FAeP4SlQHwiWDs7D0gBnt35Xsmpl4WY8TZcLvOEf
         xZqguXt1m8t14Y94scKtgonMzmagKqsm0crte2di4LsGzos3h2SsRYZewWCrfIElYl
         NhUVaQDq6soEaHe40x80rNFogPlV4Se5aEFRSCPOP1NLvCeHXqJpMD4XkSKhttQpn7
         AXOQyBkcQij/Kt/rbopkC+0AN5i36i6tMlDxCY7V6doaXUpNfZK8Rhz86L9ONXhfYu
         9UqXGFdNjabzA==
Date:   Tue, 10 May 2022 13:53:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20220510115316.acr6gl5ayqszada6@wittgenstein>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
 <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
 <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegveWaS5pR3O1c_7qLnaEDWwa8oi26x2v_CwDXB_sir1tg@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 10, 2022 at 05:49:04AM +0200, Miklos Szeredi wrote:
> On Mon, 9 May 2022 at 14:48, Christian Brauner <brauner@kernel.org> wrote:
> 
> > One comment about this. We really need to have this interface support
> > giving us mount options like "relatime" back in numeric form (I assume
> > this will be possible.). It is royally annoying having to maintain a
> > mapping table in userspace just to do:
> >
> > relatime -> MS_RELATIME/MOUNT_ATTR_RELATIME
> > ro       -> MS_RDONLY/MOUNT_ATTR_RDONLY
> >
> > A library shouldn't be required to use this interface. Conservative
> > low-level software that keeps its shared library dependencies minimal
> > will need to be able to use that interface without having to go to an
> > external library that transforms text-based output to binary form (Which
> > I'm very sure will need to happen if we go with a text-based
> > interface.).
> 
> Agreed.
> 
> >   This pattern of requesting the size first by passing empty arguments,
> >   then allocating the buffer and then passing down that buffer to
> >   retrieve that value is really annoying to use and error prone (I do
> >   of course understand why it exists.).
> >
> >   For real xattrs it's not that bad because we can assume that these
> >   values don't change often and so the race window between
> >   getxattr(GET_SIZE) and getxattr(GET_VALUES) often doesn't matter. But
> >   fwiw, the post > pre check doesn't exist for no reason; we do indeed
> >   hit that race.
> 
> That code is wrong.  Changing xattr size is explicitly documented in

When recursively changing the ownership of a filesystem tree for a
container some xattrs will need to be updated as well.

For example, if I have files with POSIX ACLs set which store {g,u}ids
then the ACL needs to be updated to store the {g,u}id mapped to the
container so the container can interpret them when started.

That is a rather sensitive operation with loads of potentials for bugs.
So if a POSIX ACL changes beneath the chowning daemon they must be
conservative because it means that there's concurrent modfication or
possibly an attack going on.

In general, I feel it's a bit easy to judge the code is wrong without
looking at the concrete scenario.

I'm also unsure how the manpage implies it's not an error condition.
Afaict, it only implies that the caller needs to handle the case where
the xattr changes. Whether or not that's an error is up to the caller to
decide. If the caller expects to be the sole user of a specific
filesystems then a changing xattr in between should probably be an error
condition.

But I think we're starting to go on a detour.

> the man page as a non-error condition:
> 
>        If size is specified as zero, these calls return the  current  size  of
>        the  named extended attribute (and leave value unchanged).  This can be
>        used to determine the size of the buffer that should be supplied  in  a
>        subsequent  call.   (But, bear in mind that there is a possibility that
>        the attribute value may change between the two calls,  so  that  it  is
>        still necessary to check the return status from the second call.)
> 
> >
> >   In addition, it is costly having to call getxattr() twice. Again, for
> >   retrieving xattrs it often doesn't matter because it's not a super
> >   common operation but for mount and other info it might matter.
> 
> You don't *have* to retrieve the size, it's perfectly valid to e.g.
> start with a fixed buffer size and double the size until the result
> fits.

Yes, I understand and accept that. I'm just not fond of such APIs.

> 
> > * Would it be possible to support binary output with this interface?
> >   I really think users would love to have an interfact where they can
> >   get a struct with binary info back.
> 
> I think that's bad taste.   fsinfo(2) had the same issue.  As well as
> mount(2) which still interprets the last argument as a binary blob in
> certain cases (nfs is one I know of).

In the same vein I could argue it's bad taste that everything gets
returned as a string. But I do agree that binary blobs through void
pointers aren't elegant.

I just worry that if we have an interface and there's a legitimate
subset of users that would be well served by a simple struct for e.g.,
mount properties any attempt to get something like this in the form of a
separate system call will be shut down with the argument that we already
have an interface for this.

So I'd compromise if we have your/any other interface return binary
blobs. But of course I'd be equally happy if we'd at least expose basic
mount information in the form of a separate system call.

> 
> >   Especially for some information at least. I'd really love to have a
> >   way go get a struct mount_info or whatever back that gives me all the
> >   details about a mount encompassed in a single struct.
> 
> If we want that, then can do a new syscall with that specific struct
> as an argument.

Ok, that sounds good to me.

> 
> >   Callers like systemd will have to parse text and will end up
> >   converting everything from text into binary anyway; especially for
> >   mount information. So giving them an option for this out of the box
> >   would be quite good.
> 
> What exactly are the attributes that systemd requires?

We keep a repo with ideas for (kernel) extensions - we should probably
publish that somewhere - but the list we used for a prototype roughly
contains:

* mount flags MOUNT_ATTR_RDONLY etc.
* time flags MOUNT_ATTR_RELATIME etc. (could probably be combined with
  mount flags. We missed the opportunity to make them proper enums
  separate from other mount flags imho.)
* propagation "flags" (MS_SHARED)
* peer group
* mnt_id of the mount
* mnt_id of the mount's parent
* owning userns

There's a bit more advanced stuff systemd would really want but which I
think is misplaced in a mountinfo system call including:
* list of primary and auxiliary block device major/minor
* diskseq value of those device nodes (This is a new block device
  feature we added that allows preventing device recycling issues when
  e.g. removing usb devices very quickly and is needed for udev.)
* uuid/fsid
* feature flags (O_TMPFILE, RENAME_EXCHANGE supported etc.)

> 
> >   Interfaces like statx aim to be as fast as possible because we exptect
> >   them to be called quite often. Retrieving mount info is quite costly
> >   and is done quite often as well. Maybe not for all software but for a
> >   lot of low-level software. Especially when starting services in
> >   systemd a lot of mount parsing happens similar when starting
> >   containers in runtimes.
> 
> Was there ever a test patch for systemd using fsinfo(2)?  I think not.
> 
> Until systemd people start to reengineer the mount handing to allow
> for retrieving a single mount instead of the complete mount table we
> will never know where the performance bottleneck lies.

I defer to Ian and Karel to answer that. Both did work to prove that
point triggered by one of your objections to fsinfo() iirc. Karel's
commits at least are here:
https://github.com/util-linux/util-linux/tree/topic/fsinfo

> 
> >
> > * If we decide to go forward with this interface - and I think I
> >   mentioned this in the lsfmm session - could we please at least add a
> >   new system call? It really feels wrong to retrieve mount and other
> >   information through the xattr interfaces. They aren't really xattrs.
> 
> I'd argue with that statement.  These are most definitely attributes.
> As for being extended, we'd just extended the xattr interface...

I just have a really hard time understanding how this belongs into the
(f)getxattr() system call family and why it would be a big deal to just
make this a separate system call.

I saw that Dave has a long mail on the history of all this so maybe
that'll help me. I hope I get around to reading it in detail today.

> 
> Naming aside... imagine that read(2) has always been used to retrieve
> disk data, would you say that reading data from proc feels wrong?
> And in hindsight, would a new syscall for the purpose make any sense?

I think past interface decisions don't need to always inform future
interface decisions.
And fwiw, yes. Imho, there's stuff in proc that should indeed have been
covered by a dedicated system call instead of a read-like interface.
