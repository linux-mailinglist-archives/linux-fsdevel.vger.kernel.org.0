Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCB77AE1B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjIYWdA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 18:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjIYWc6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:32:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC829C
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 15:32:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692eed30152so1928084b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695681171; x=1696285971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pwLVVmQTUQrGSH3pGh3XF3uqJaa9jFlgARaefKp+8mY=;
        b=Rjp0iFGPqqPTMnBWJrncKiThxwSAysBQHZ4bO548nE66rh54R/0sIHpK6cfzVE8NpL
         1BDg86VCm6tTs2PLBix/wBR2YWOaxgTU62YgHnklvnMY7dqCpqEVz/NWdn+h3782Ntp8
         QBI9hNLgFEX0YV/1y97hpj9odbKPaDSsIQiXky+2TqDN17LbxFhdyJHFHbkCOTDQ5Snv
         6kITfg2+o4KxIuVu6cjjC+yVo+muLk92OoDwXR0aN9GGx3ipjIkX4m6wNdqZ15TLjCNA
         V/nbJrwhRCypKJ31oME97yXRosut0mGl3TXRyHO01VzzLI90AS6v0X+GrEVXjQ5c/sER
         +efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695681171; x=1696285971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwLVVmQTUQrGSH3pGh3XF3uqJaa9jFlgARaefKp+8mY=;
        b=vKXeE7Ed+so+KD6pVQHeYs5SmVi02tjqw8faVIoRAtdlkOxpoW65DqUQO4JzHII0AT
         8hWjjm9zUOzaoAYqif/SX1r5LQcLKuYr/nLbw0GnVu17byM+tEmwRHB89FZgqOxSUaKk
         0d+qGedzpWLHXlPLOhvOj/P6GyB3PvzmDiwo/Rv8tQIKPpOUlznZVQRUaxBmDcuay16n
         9Iqbfzi16ddpPPHoyLIgKZyh24u2Y3v+OHRE0+kpyD1BIPYU5eADBzqueHUCxgKOyWaF
         f52+R+zlZhrsiXwC81T4mM8iteOGpK7LhvMba0TA3qPaUP3EEY+KA6pHk3c2UAn6hL1/
         LjVA==
X-Gm-Message-State: AOJu0Yw5MDxaFnbRajh4Q0zF/4+Ztt4w3+AFNxwf01ARLAUVW9wccacu
        DvJZ1n8ubWUf6SVBxljuNH3SGQ==
X-Google-Smtp-Source: AGHT+IGSExR5ELqalz/sYqiUwKRFg391ZjTWn5JWmO0f7/iqkn4N4LDT0JlfUqYeKD/9YMkGFq7KMA==
X-Received: by 2002:a05:6a00:1a46:b0:68a:4103:9938 with SMTP id h6-20020a056a001a4600b0068a41039938mr6209219pfv.0.1695681171407;
        Mon, 25 Sep 2023 15:32:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id u13-20020aa7848d000000b00693055f7065sm538350pfn.219.2023.09.25.15.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 15:32:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qku8F-005aMN-11;
        Tue, 26 Sep 2023 08:32:47 +1000
Date:   Tue, 26 Sep 2023 08:32:47 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v8 0/5] fs: multigrain timestamps for XFS's change_cookie
Message-ID: <ZRIKj0E8P46kerqa@dread.disaster.area>
References: <20230922-ctime-v8-0-45f0c236ede1@kernel.org>
 <CAOQ4uxiNfPoPiX0AERywqjaBH30MHQPxaZepnKeyEjJgTv8hYg@mail.gmail.com>
 <5e3b8a365160344f1188ff13afb0a26103121f99.camel@kernel.org>
 <CAOQ4uxjrt6ca4VDvPAL7USr6_SspCv0rkRkMJ4_W2S6vzV738g@mail.gmail.com>
 <ZRC1pjwKRzLiD6I3@dread.disaster.area>
 <77d33282068035a3b42ace946b1be57457d2b60b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77d33282068035a3b42ace946b1be57457d2b60b.camel@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 06:14:05AM -0400, Jeff Layton wrote:
> On Mon, 2023-09-25 at 08:18 +1000, Dave Chinner wrote:
> > On Sat, Sep 23, 2023 at 05:52:36PM +0300, Amir Goldstein wrote:
> > > On Sat, Sep 23, 2023 at 1:46 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > 
> > > > On Sat, 2023-09-23 at 10:15 +0300, Amir Goldstein wrote:
> > > > > On Fri, Sep 22, 2023 at 8:15 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > > 
> > > > > > My initial goal was to implement multigrain timestamps on most major
> > > > > > filesystems, so we could present them to userland, and use them for
> > > > > > NFSv3, etc.
> > > > > > 
> > > > > > With the current implementation however, we can't guarantee that a file
> > > > > > with a coarse grained timestamp modified after one with a fine grained
> > > > > > timestamp will always appear to have a later value. This could confuse
> > > > > > some programs like make, rsync, find, etc. that depend on strict
> > > > > > ordering requirements for timestamps.
> > > > > > 
> > > > > > The goal of this version is more modest: fix XFS' change attribute.
> > > > > > XFS's change attribute is bumped on atime updates in addition to other
> > > > > > deliberate changes. This makes it unsuitable for export via nfsd.
> > > > > > 
> > > > > > Jan Kara suggested keeping this functionality internal-only for now and
> > > > > > plumbing the fine grained timestamps through getattr [1]. This set takes
> > > > > > a slightly different approach and has XFS use the fine-grained attr to
> > > > > > fake up STATX_CHANGE_COOKIE in its getattr routine itself.
> > > > > > 
> > > > > > While we keep fine-grained timestamps in struct inode, when presenting
> > > > > > the timestamps via getattr, we truncate them at a granularity of number
> > > > > > of ns per jiffy,
> > > > > 
> > > > > That's not good, because user explicitly set granular mtime would be
> > > > > truncated too and booting with different kernels (HZ) would change
> > > > > the observed timestamps of files.
> > > > > 
> > > > 
> > > > Thinking about this some more, I think the first problem is easily
> > > > addressable:
> > > > 
> > > > The ctime isn't explicitly settable and with this set, we're already not
> > > > truncating the atime. We haven't used any of the extra bits in the mtime
> > > > yet, so we could just carve out a flag in there that says "this mtime
> > > > was explicitly set and shouldn't be truncated before presentation".
> > > > 
> > > 
> > > I thought about this option too.
> > > But note that the "mtime was explicitly set" flag needs
> > > to be persisted to disk so you cannot store it in the high nsec bits.
> > > At least XFS won't store those bits if you use them - they have to
> > > be translated to an XFS inode flag and I don't know if changing
> > > XFS on-disk format was on your wish list.
> > 
> > Remember: this multi-grain timestamp thing was an idea to solve the
> > NFS change attribute problem without requiring *any* filesystem with
> > sub-jiffie timestamp capability to change their on-disk format to
> > implement a persistent change attribute that matches the new
> > requires of the kernel nfsd.
> > 
> > If we now need to change the on-disk format to support
> > some whacky new timestamp semantic to do this, then people have
> > completely lost sight of what problem the multi-grain timestamp idea
> > was supposed to address.
> > 
> 
> Yep. The main impetus for all of this was to fix XFS's change attribute
> without requiring an on-disk format change. If we have to rev the on-
> disk format, we're probably better off plumbing in a proper i_version
> counter and tossing this idea aside.
> 
> That said, I think all we'd need for this scheme is a single flag per
> inode (to indicate that the mtime shouldn't be truncated before
> presentation). If that's possible to do without fully revving the inode
> format, then we could still pursue this. I take it that's probably not
> the case though.

Older kernels that don't know what the flag means, but that should
be OK for an inode flag. The bigger issue is that none of the
userspace tools (xfs_db, xfs_repair, etc) know about it, so they
would have to be taught about it. And then there's testing it, which
likely means userspace needs visibility of the flag (e.g. FS_XFLAG
for it) and then there's more work....

It's really not worth it.

I think that Linus's suggestion of the in-memory inode timestamp
always being a 64bit, 100ns granularity value instead of a timespec
that gets truncated at sample time has merit as a general solution.

We also must not lose sight of the fact that the lazytime mount
option makes atime updates on XFS behave exactly as the nfsd/NFS
client application wants. That is, XFS will do in-memory atime
updates unless the atime update also sets S_VERSION to explicitly
bump the i_version counter if required. That leads to another
potential nfsd specific solution without requiring filesystems to
change on disk formats: the nfsd explicitly asks operations for lazy
atime updates...

And we must also keep in sight the fact that io_uring wants
non-blocking timestamp updates to be possible (for all types of
updates). Hence it looks to me like we have more than one use case
for per-operation/application specific timestamp update semantics.
Perhaps there's a generic solution to this problem (e.g.  operation
specific non-blocking, in-memory pure timestamp updates) that does
what everyone needs...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
