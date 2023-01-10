Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A1663669
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 01:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjAJAsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 19:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237926AbjAJAs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 19:48:29 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8749418B2F
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 16:48:27 -0800 (PST)
Received: from letrec.thunk.org (host-67-21-23-146.mtnsat.com [67.21.23.146] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30A0mBTk022940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Jan 2023 19:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1673311704; bh=/Qguy+w19nMJ/dPdiq0LvpnYKF7e9BDcp2Cx4Pspn0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RmxML1AqeaLkd3JRTxQPepxH+UC+Rl9VmqP3JB+g6CuNpX5kvtVIwKylbzMW4pT6+
         StButKgf3wY8E+E9RXTKvUSjy1AXfPvRFZdopsXQ+wCmJ4NIOOaHWXhSsgxVwqEyuj
         xx3KHZ73FkoVviOKIVXJ64EuPXfjXLmipweeITZoRr+SQXY3OKa6xvNIq/woJkgnK/
         m17mtHp3ZVGBeJzES8lhpWvouirDKjIS0AeABA0CU56/uxzXI4lDB02qABIL6uHoC7
         YDGm8KnS/+IRoI89HX3GrvThSiKsdvgWcIuXa2D1BOTE9cQzdR1YfRjR8Vt51YlNic
         IhL6Z1ovyNJbQ==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 130828C0850; Mon,  9 Jan 2023 19:48:08 -0500 (EST)
Date:   Mon, 9 Jan 2023 19:48:08 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Anadon <joshua.r.marshall.1991@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: Do I really need to add mount2 and umount3 syscalls for some
 crazy experiment
Message-ID: <Y7y1yNOfaGlOyhz6@mit.edu>
References: <CAFkJGRdxR=0GeRWiu2g0QrVNzMLqYpqZm6+Ac5Baz2DcL39HTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkJGRdxR=0GeRWiu2g0QrVNzMLqYpqZm6+Ac5Baz2DcL39HTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 08, 2023 at 11:46:38PM -0500, Anadon wrote:
> I am looking into implementing a distributed RAFT filesystem for
> reasons.  Before this, I want what is in effect a simple pass-through
> filesystem.  Something which just takes in calls to open, read, close,
> etc and forwards them to a specified mounted* filesystem.  Hopefully
> through FUSE before jumping straight into kernel development.
> 
> Doing this and having files appear in two places by calling `mount()`
> then calling the (potentially) userland functions to the mapped file
> by changing the file path is a way to technically accomplish
> something.  This has the effect of the files being accessible in two
> locations.

I fon't quite understand *why* you want to implement a passthrough
filesystem in terms of how it relates to creating a distributed RAFT
file system.

Files (and indeed, entire directory hierarchies) being accessible in
two locations is not a big deal; this can be done using a bind mount
without needing any kernel code.

And if the question is how to deal with files that can be modified
externally, from a system elsewhere in the local network (or
cluster/cell), well, all networked file systems such as NFS, et.al.,
do this.  If a networked file system knows that a particular file has
been modified, it can easily invalidate the local page cache copies of
the file.  Now, if that file is currently being used, and is being
mmap'ed into some process's address space, perhaps as the read-only
text (code) segment, what the semantics should be if it is modified
remotely out from under that process --- or whether the file should be
allowed to be modified at all if it is being used in certain ways, is
a semantic/design/policy question you need to answer before we can
talk about how this might be implemented.

> The problems start where the underlying filesystem won't
> notify my passthrough layer if there are changes made.

Now, how an underlying file system might notify your passthrough layer
will no doubt be comletely different from how a distributed/networked
file system will notify the node-level implementation of that file
system.  So I'm not at all sure how this is relevant for your use
case.  (And if you want a file to appear in two places at the same
time, just make that file *be* the same file in two places via a bind
mount.)

>  What would be better is to have some struct with all
> relevant function pointers and data accessible.  That sounds like
> adding syscalls `int mount2(const char* device, ..., struct
> return_fs_interface)` and `int umuont3(struct return_fs_interface)`.

I don't understand what you want to do here.  What is going to be in
this "struct return_fs_interface"?  Function pointers?  Do you really
want to have kernel code calling userspace functions?  Uh, that's a
really bad idea.  You should take a closer look at how the FUSE
kernel/usersace interface works, if the goal is to do something like
this via a userspace FUSE-like scheme.

> I have looked at `fsopen(...)` as an alternative, but it still does
> not meet my use case.  Another way would be to compile in every
> filesystem driver but this just seems downright mad.  Is there a good
> option I have overlooked?  Am I even asking in the right place?

I'm not sure what "compiling in efvery filesystem driver" is trying to
accomplish.  Compiling into *what*?   For what purpose?

I'm not sure you are asking the right questions.  It might be better
to say in more detail what are the functional requirements what it is
you are trying to achieve, before asking people to evaluate potential
implementation approaches.

Best regards,

						- Ted
