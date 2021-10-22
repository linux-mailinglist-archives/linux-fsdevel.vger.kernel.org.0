Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A6F437C74
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhJVSJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 14:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233380AbhJVSJL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32ED1610A4;
        Fri, 22 Oct 2021 18:06:49 +0000 (UTC)
Date:   Fri, 22 Oct 2021 19:06:45 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
Message-ID: <YXL9tRher7QVmq6N@arm.com>
References: <20211019134204.3382645-1-agruenba@redhat.com>
 <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com>
 <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com>
 <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:19:40PM -1000, Linus Torvalds wrote:
> On Wed, Oct 20, 2021 at 12:44 PM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > However, with MTE doing both get_user() every 16 bytes and
> > gup can get pretty expensive.
> 
> So I really think that anything that is performance-critical had
> better only do the "fault_in_write()" code path in the cold error path
> where you took a page fault.
[...]
> So I wouldn't worry too much about the performance concerns. It simply
> shouldn't be a common or hot path.
> 
> And yes, I've seen code that does that "fault_in_xyz()" before the
> critical operation that cannot take page faults, and does it
> unconditionally.
> 
> But then it isn't the "fault_in_xyz()" that should be blamed if it is
> slow, but the caller that does things the wrong way around.

Some more thinking out loud. I did some unscientific benchmarks on a
Raspberry Pi 4 with the filesystem in a RAM block device and a
"dd if=/dev/zero of=/mnt/test" writing 512MB in 1MB blocks. I changed
fault_in_readable() in linux-next to probe every 16 bytes:

- ext4 drops from around 261MB/s to 246MB/s: 5.7% penalty

- btrfs drops from around 360MB/s to 337MB/s: 6.4% penalty

For generic_perform_write() Dave Hansen attempted to move the fault-in
after the uaccess in commit 998ef75ddb57 ("fs: do not prefault
sys_write() user buffer pages"). This was reverted as it was exposing an
ext4 bug. I don't whether it was fixed but re-applying Dave's commit
avoids the performance drop.

btrfs_buffered_write() has a comment about faulting pages in before
locking them in prepare_pages(). I suspect it's a similar problem and
the fault_in() could be moved, though I can't say I understand this code
well enough.

Probing only the first byte(s) in fault_in() would be ideal, no need to
go through all filesystems and try to change the uaccess/probing order.

-- 
Catalin
