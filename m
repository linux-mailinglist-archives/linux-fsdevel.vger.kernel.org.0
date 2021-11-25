Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8A45E1CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 21:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357210AbhKYUtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 15:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242104AbhKYUrO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:47:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D2BD6101B;
        Thu, 25 Nov 2021 20:44:00 +0000 (UTC)
Date:   Thu, 25 Nov 2021 20:43:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
Message-ID: <YZ/1jflaSjgRRl2o@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com>
 <YZ9vM91Uj8g36VQC@arm.com>
 <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 10:13:25AM -0800, Linus Torvalds wrote:
> On Thu, Nov 25, 2021 at 3:10 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > For this specific btrfs case, if we want go with tuning the offset based
> > on the fault address, we'd need copy_to_user_nofault() (or a new
> > function) to be exact.
> 
> I really don't see why you harp on the exactness.

I guess because I always thought we either fix fault_in_writable() to
probe the whole range (this series) or we change the loops to take the
copy_to_user() returned value into account when re-faulting.

> I really believe that the fix is to make the read/write probing just
> be more aggressive.
> 
> Make the read/write probing require that AT LEAST <n> bytes be
> readable/writable at the beginning, where 'n' is 'min(len,ALIGN)', and
> ALIGN is whatever size that copy_from/to_user_xyz() might require just
> because it might do multi-byte accesses.
> 
> In fact, make ALIGN be perhaps something reasonable like 512 bytes or
> whatever, and then you know you can handle the btrfs "copy a whole
> structure and reset if that fails" case too.

IIUC what you are suggesting, we still need changes to the btrfs loop
similar to willy's but that should work fine together with a slightly
more aggressive fault_in_writable().

A probing of at least sizeof(struct btrfs_ioctl_search_key) should
suffice without any loop changes and 512 would cover it but it doesn't
look generic enough. We could pass a 'probe_prefix' argument to
fault_in_exact_writeable() to only probe this and btrfs would just
specify the above sizeof().

> Don't require that the fundamental copying routines (and whatever
> fixup the code might need) be some kind of byte-precise - it's the
> error case that should instead be made stricter.
> 
> If the user gave you a range that triggered a pointer color mismatch,
> then returning an error is fine, rather than say "we'll do as much as
> we can and waste time and effort on being byte-exact too".

Yes, I'm fine with not copying anything at all, I just want to avoid the
infinite loop.

I think we are down to three approaches:

1. Probe the whole range in fault_in_*() for sub-page faults, no need to
   worry about copy_*_user() failures.

2. Get fault_in_*() to probe a sufficient prefix to cover the uaccess
   inexactness. In addition, change the btrfs loop to fault-in from
   where the copy_to_user() failed (willy's suggestion combined with
   the more aggressive probing in fault_in_*()).

3. Implement fault_in_exact_writeable(uaddr, size, probe_prefix) where
   loops that do some rewind would pass an appropriate value.

(1) is this series, (2) requires changing the loop logic, (3) looks
pretty simple.

I'm happy to attempt either (2) or (3) with a preference for the latter.

-- 
Catalin
