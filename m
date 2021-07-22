Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795513D2F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 23:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhGVVSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 17:18:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37725 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231336AbhGVVSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 17:18:00 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16MLwOFW015534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jul 2021 17:58:24 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F2E6115C37C0; Thu, 22 Jul 2021 17:58:23 -0400 (EDT)
Date:   Thu, 22 Jul 2021 17:58:23 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: A shift-out-of-bounds in minix_statfs in fs/minix/inode.c
Message-ID: <YPnp/zXp3saLbz03@mit.edu>
References: <CAFcO6XOdMe-RgN8MCUT59cYEVBp+3VYTW-exzxhKdBk57q0GYw@mail.gmail.com>
 <YPhbU/umyUZLdxIw@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPhbU/umyUZLdxIw@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 21, 2021 at 06:37:23PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 22, 2021 at 01:14:06AM +0800, butt3rflyh4ck wrote:
> > ms = (struct minix_super_block *) bh->b_data; /// --------------> set
> > minix_super_block pointer
> > sbi->s_ms = ms;
> > sbi->s_sbh = bh;
> > sbi->s_mount_state = ms->s_state;
> > sbi->s_ninodes = ms->s_ninodes;
> > sbi->s_nzones = ms->s_nzones;
> > sbi->s_imap_blocks = ms->s_imap_blocks;
> > sbi->s_zmap_blocks = ms->s_zmap_blocks;
> > sbi->s_firstdatazone = ms->s_firstdatazone;
> > sbi->s_log_zone_size = ms->s_log_zone_size;  // ------------------>
> > set sbi->s_log_zone_size
> 
> So what you're saying is that if you construct a malicious minix image,
> you can produce undefined behaviour?  That's not something we're
> traditionally interested in, unless the filesystem is one customarily
> used for data interchange (like FAT or iso9660).

It's going to depend on the file system maintainer.  The traditional
answer is that block device is part of the Trusted Computing Base, and
malicious file system images are not considered part of the threat
model.  A system adminstration or developer which allows potentially
malicious agents to mount file system agents are cray-cray.

Unfortunately, those developers are also known as "Linux desktop devs"
(who implement unprivileged mounts of USB cards) or "container
evangelists" who think containers should be treated as being Just As
Good as VM's From A Security Perspective.

So I do care about this for ext4, although I don't guarantee immediate
response, as it's something that I usually end up doing on my own
time.  I do get cranky that Syzkaller makes it painful to extract out
the fuzzed file system image, and I much prefer those fuzzing systems
which provide the file system image and the C program used to trigger
the failre as two seprate files.  Or failing that, if there was some
trivial way to get the syzkaller reproducer program to disgorge the
file system image to a specified output file.  As a result, if I have
a choice of spending time investigating fuzzing report from a more
file-system friendly fuzzing program and syzkaller, I'll tend choose
to spend my time dealing with other file system fuzzing reports first.

The problem for Minix is that it does not have an active maintainer.
So if you submit fuzzing reports for Minix, it's unlikely anyone will
spend time working on it.  But if you submit a patch, it can go in,
probably via Andrew Morton.  (Recent Minix fixes that have gone in
this way: 0a12c4a8069 and 32ac86efff9)

Cheers,

					- Ted
					
