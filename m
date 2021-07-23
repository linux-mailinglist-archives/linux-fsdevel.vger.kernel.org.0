Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6AC3D37A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhGWImW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 04:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232347AbhGWImV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:42:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 551FF60ED4;
        Fri, 23 Jul 2021 09:22:53 +0000 (UTC)
Date:   Fri, 23 Jul 2021 11:22:50 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: A shift-out-of-bounds in minix_statfs in fs/minix/inode.c
Message-ID: <20210723092250.6nvmikgcs4v5ekix@wittgenstein>
References: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
 <YPhbU/umyUZLdxIw@casper.infradead.org>
 <YPnp/zXp3saLbz03@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPnp/zXp3saLbz03@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 22, 2021 at 05:58:23PM -0400, Theodore Ts'o wrote:
> On Wed, Jul 21, 2021 at 06:37:23PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 22, 2021 at 01:14:06AM +0800, butt3rflyh4ck wrote:
> > > ms = (struct minix_super_block *) bh->b_data; /// --------------> set
> > > minix_super_block pointer
> > > sbi->s_ms = ms;
> > > sbi->s_sbh = bh;
> > > sbi->s_mount_state = ms->s_state;
> > > sbi->s_ninodes = ms->s_ninodes;
> > > sbi->s_nzones = ms->s_nzones;
> > > sbi->s_imap_blocks = ms->s_imap_blocks;
> > > sbi->s_zmap_blocks = ms->s_zmap_blocks;
> > > sbi->s_firstdatazone = ms->s_firstdatazone;
> > > sbi->s_log_zone_size = ms->s_log_zone_size;  // ------------------>
> > > set sbi->s_log_zone_size
> > 
> > So what you're saying is that if you construct a malicious minix image,
> > you can produce undefined behaviour?  That's not something we're
> > traditionally interested in, unless the filesystem is one customarily
> > used for data interchange (like FAT or iso9660).
> 
> It's going to depend on the file system maintainer.  The traditional
> answer is that block device is part of the Trusted Computing Base, and
> malicious file system images are not considered part of the threat
> model.  A system adminstration or developer which allows potentially
> malicious agents to mount file system agents are cray-cray.
> 
> Unfortunately, those developers are also known as "Linux desktop devs"
> (who implement unprivileged mounts of USB cards) or "container

That has always been a weird approach for sure.

> evangelists" who think containers should be treated as being Just As
> Good as VM's From A Security Perspective.

Mounting virtual filesystems like procfs, sysfs, cgroupfs, devpts,
binderfs and so on in unprivileged containers makes a lot of sense but
for filesystems like ext4, xfs, or btrfs making them mountable inside
unprivileged containers aka user namespaces never made a lot of sense to
me.

Most users don't really want to or need to expose a whole filesystem
image to their containers anyway. It's much more common that they want
to expose a part of an existing filesystem that has been mounted by an
administrator before. Which means they create bind mounts of the
directories that they want to expose. And as soon as the filesystem
supports idmapped mounts like ext4 does you can then serve all of those
use-cases including creating an idmapped mount of the whole filesystem
itself. And then you shouldn't need to require that the filesystem must
be able to mount untrusted images.

> 
> So I do care about this for ext4, although I don't guarantee immediate
> response, as it's something that I usually end up doing on my own
> time.  I do get cranky that Syzkaller makes it painful to extract out
> the fuzzed file system image, and I much prefer those fuzzing systems
> which provide the file system image and the C program used to trigger
> the failre as two seprate files.  Or failing that, if there was some
> trivial way to get the syzkaller reproducer program to disgorge the
> file system image to a specified output file.  As a result, if I have
> a choice of spending time investigating fuzzing report from a more
> file-system friendly fuzzing program and syzkaller, I'll tend choose
> to spend my time dealing with other file system fuzzing reports first.
> 
> The problem for Minix is that it does not have an active maintainer.
> So if you submit fuzzing reports for Minix, it's unlikely anyone will
> spend time working on it.  But if you submit a patch, it can go in,
> probably via Andrew Morton.  (Recent Minix fixes that have gone in
> this way: 0a12c4a8069 and 32ac86efff9)
> 
> Cheers,
> 
> 					- Ted> 					
