Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44FD44ED24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 20:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhKLTSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 14:18:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhKLTSw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 14:18:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7138C60F0F;
        Fri, 12 Nov 2021 19:16:00 +0000 (UTC)
Date:   Fri, 12 Nov 2021 19:15:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com
Subject: Re: [RFC] gfs2: Prevent endless loops in gfs2_file_buffered_write
Message-ID: <YY69bWxs22LNlLs6@arm.com>
References: <20211110174457.533866-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110174457.533866-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andreas,

On Wed, Nov 10, 2021 at 06:44:57PM +0100, Andreas Gruenbacher wrote:
> in commit 00bfe02f4796 ("gfs2: Fix mmap + page fault deadlocks for
> buffered I/O"), I've managed to introduce a hang in gfs2 due to the
> following check in iomap_write_iter:
> 
>   if (unlikely(fault_in_iov_iter_readable(i, bytes))) {
> 
> which fails if any of the iov iterator cannot be faulted in for reading.
> At the filesystem level, we're retrying the rest of the write if any of
> the iov iterator can be faulted in, so we can end up in a loop without
> ever making progress.  The fix in iomap_write_iter would be as follows:
> 
>   if (unlikely(fault_in_iov_iter_readable(i, bytes) == bytes)) {

My preference would be to check against the 'bytes' returned as above.
This allows the write to progress as much as possible rather than
stopping if any of the iovs cannot be faulted in. It would be more
consistent for MTE as well if we keep the fault-in check at the
beginning of the user buffers only. I mentioned it here:

https://lore.kernel.org/all/YYQk9L0D57QHc0gE@arm.com/

> The same bug exists in generic_perform_write, but I'm not aware of any
> callers of generic_perform_write that have page faults turned off.

Similar reason as above, though one may argue it's a slight ABI change.

> A related post-5.16 option would be to turn the pre-faulting in
> iomap_write_iter and generic_perform_write into post-faulting, but at
> the very least, that still needs a bit of performance analysis:
> 
>   https://lore.kernel.org/linux-fsdevel/20211026094430.3669156-1-agruenba@redhat.com/
>   https://lore.kernel.org/linux-fsdevel/20211027212138.3722977-1-agruenba@redhat.com/

I don't think that's urgent. At least generic_perform_write() will make
progress with a fault-in that checks the beginning of the buffer, even
with sub-page faults. For fault_in_iov_writable() I'll add an arch
callback, probe_user_writable_safe() or something (hopefully next week).

There is the direct I/O case but IIUC the user buffer is accessed via
the kernel mapping (kmap) and that cannot fault on access. I may have
missed something though.

For the search_ioctl() function in btrfs I thought of introducing
fault_in_writable_exact() that checks each sub-page granule in the arch
callback. This shouldn't be used on performance critical paths.

-- 
Catalin
