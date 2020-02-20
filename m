Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A271659E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 10:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgBTJJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 04:09:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36977 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgBTJJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 04:09:47 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j4hq0-0006gp-7x; Thu, 20 Feb 2020 09:09:40 +0000
Date:   Thu, 20 Feb 2020 10:09:39 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Ian Kent <raven@themaw.net>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        mszeredi@redhat.com, christian@brauner.io,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] VFS: Filesystem information and notifications [ver
 #16]
Message-ID: <20200220090939.4e2mpmdixcyruzda@wittgenstein>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
 <20200219144613.lc5y2jgzipynas5l@wittgenstein>
 <c9a6f929b57e0c21c8845c211d1e3eab09d09633.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9a6f929b57e0c21c8845c211d1e3eab09d09633.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:42:15PM +0800, Ian Kent wrote:
> On Wed, 2020-02-19 at 15:46 +0100, Christian Brauner wrote:
> > On Tue, Feb 18, 2020 at 05:04:55PM +0000, David Howells wrote:
> > > Here are a set of patches that adds system calls, that (a) allow
> > > information about the VFS, mount topology, superblock and files to
> > > be
> > > retrieved and (b) allow for notifications of mount topology
> > > rearrangement
> > > events, mount and superblock attribute changes and other superblock
> > > events,
> > > such as errors.
> > > 
> > > ============================
> > > FILESYSTEM INFORMATION QUERY
> > > ============================
> > > 
> > > The first system call, fsinfo(), allows information about the
> > > filesystem at
> > > a particular path point to be queried as a set of attributes, some
> > > of which
> > > may have more than one value.
> > > 
> > > Attribute values are of four basic types:
> > > 
> > >  (1) Version dependent-length structure (size defined by type).
> > > 
> > >  (2) Variable-length string (up to 4096, including NUL).
> > > 
> > >  (3) List of structures (up to INT_MAX size).
> > > 
> > >  (4) Opaque blob (up to INT_MAX size).
> > 
> > I mainly have an organizational question. :) This is a huge patchset
> > with lots and lots of (good) features. Wouldn't it make sense to make
> > the fsinfo() syscall a completely separate patchset from the
> > watch_mount() and watch_sb() syscalls? It seems that they don't need
> > to
> > depend on each other at all. This would make reviewing this so much
> > nicer and likely would mean that fsinfo() could proceed a little
> > faster.
> 
> The remainder of the fsinfo() series would need to remain useful
> if this was done.
> 
> For context I want work on improving handling of large mount
> tables.

Yeah, I've talked to David about this; polling on a large mountinfo file
is not great, I agree.

> 
> Ultimately I expect to solve a very long standing autofs problem
> of using large direct mount maps without prohibitive performance
> overhead (and there a lot of rather challenging autofs changes to
> do for this too) and I believe the fsinfo() system call, and
> related bits, is the way to do this.
> 
> But improving the handling of large mount tables for autofs
> will have the side effect of improvements for other mount table
> users, even in the early stages of this work.
> 
> For example I want to use this for mount table handling improvements
> in libmount. Clearly that ultimately needs mount change notification
> in the end but ...
> 
> There's a bunch of things that need to be done alone the way
> to even get started.
> 
> One thing that's needed is the ability to call fsinfo() to get
> information on a mount to avoid constant reading of the proc based
> mount table, which happens a lot (since the mount info. needs
> to be up to date) so systemd (and others) would see an improvement
> with the fsinfo() system call alone able to be used in libmount.
> 
> But for the fsinfo() system call to be used for this the file
> system specific mount options need to also be obtained when
> using fsinfo(). That means the super block operation fsinfo uses
> to provide this must be implemented for at least most file systems.
> 
> So separating out the notifications part, leaving whatever is needed
> to still be able to do this, should be fine and the system call
> would be immediately useful once the super operation is implemented
> for the needed file systems.
> 
> Whether the implementation of the super operation should be done
> as part of this series is another question but would certainly
> be a challenge and make the series more complicated. But is needed
> for the change to be useful in my case.

I think what would might work - and what David had already brought up
briefly - is to either base the fsinfo branch on top of the mount
notificaiton branch or break the notification counters pieces into a
separate patch and base both mount notifications and fsinfo on top of
it.

Christian
