Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF08B45E288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 22:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350799AbhKYVeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 16:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351924AbhKYVcS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:32:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AE0A60527;
        Thu, 25 Nov 2021 21:29:04 +0000 (UTC)
Date:   Thu, 25 Nov 2021 21:29:01 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <YaAAHfAaOg2tmLKU@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com>
 <YZ9vM91Uj8g36VQC@arm.com>
 <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
 <YZ/1jflaSjgRRl2o@arm.com>
 <YZ/55fYE0l7ewo/t@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ/55fYE0l7ewo/t@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 09:02:29PM +0000, Matthew Wilcox wrote:
> On Thu, Nov 25, 2021 at 08:43:57PM +0000, Catalin Marinas wrote:
> > > I really believe that the fix is to make the read/write probing just
> > > be more aggressive.
> > > 
> > > Make the read/write probing require that AT LEAST <n> bytes be
> > > readable/writable at the beginning, where 'n' is 'min(len,ALIGN)', and
> > > ALIGN is whatever size that copy_from/to_user_xyz() might require just
> > > because it might do multi-byte accesses.
> > > 
> > > In fact, make ALIGN be perhaps something reasonable like 512 bytes or
> > > whatever, and then you know you can handle the btrfs "copy a whole
> > > structure and reset if that fails" case too.
> > 
> > IIUC what you are suggesting, we still need changes to the btrfs loop
> > similar to willy's but that should work fine together with a slightly
> > more aggressive fault_in_writable().
> > 
> > A probing of at least sizeof(struct btrfs_ioctl_search_key) should
> > suffice without any loop changes and 512 would cover it but it doesn't
> > look generic enough. We could pass a 'probe_prefix' argument to
> > fault_in_exact_writeable() to only probe this and btrfs would just
> > specify the above sizeof().
> 
> How about something like this?
> 
> +++ b/mm/gup.c
> @@ -1672,6 +1672,13 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
> 
>         if (unlikely(size == 0))
>                 return 0;
> +       if (SUBPAGE_PROBE_INTERVAL) {
> +               while (uaddr < PAGE_ALIGN((unsigned long)uaddr)) {
> +                       if (unlikely(__put_user(0, uaddr) != 0))
> +                               goto out;
> +                       uaddr += SUBPAGE_PROBE_INTERVAL;
> +               }
> +       }
>         if (!PAGE_ALIGNED(uaddr)) {
>                 if (unlikely(__put_user(0, uaddr) != 0))
>                         return size;
> 
> ARM then defines SUBPAGE_PROBE_INTERVAL to be 16 and the rest of us
> leave it as 0.  That way we probe all the way to the end of the current
> page and the start of the next page.

It doesn't help if the copy_to_user() fault happens 16 bytes into the
second page for example. The fault_in() passes, copy_to_user() fails and
the loop restarts from the same place. With sub-page faults, the page
boundary doesn't have any relevance. We want to probe the beginning of
the buffer that's at least as big as the loop rewind size even if it
goes past a page boundary.

-- 
Catalin
