Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1C45F704
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 23:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245572AbhKZXDH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 18:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhKZXBH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:01:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FAAC061574;
        Fri, 26 Nov 2021 14:57:53 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 804DDB8290E;
        Fri, 26 Nov 2021 22:57:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDB2C60174;
        Fri, 26 Nov 2021 22:57:48 +0000 (UTC)
Date:   Fri, 26 Nov 2021 22:57:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
Message-ID: <YaFmaJqyie6KZ2bY@arm.com>
References: <YaAROdPCqNzSKCjh@arm.com>
 <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <YZ6idVy3zqQC4atv@arm.com>
 <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211126222945.549971-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126222945.549971-1-agruenba@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 26, 2021 at 11:29:45PM +0100, Andreas Gruenbacher wrote:
> On Thu, Nov 25, 2021 at 11:42 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > As per Linus' reply, we can work around this by doing
> > a sub-page fault_in_writable(point_of_failure, align) where 'align'
> > should cover the copy_to_user() impreciseness.
> >
> > (of course, fault_in_writable() takes the full size argument but behind
> > the scene it probes the 'align' prefix at sub-page fault granularity)
> 
> That doesn't make sense; we don't want fault_in_writable() to fail or
> succeed depending on the alignment of the address range passed to it.

If we know that the arch copy_to_user() has an error of say maximum 16
bytes (or 15 rather on arm64), we can instead get fault_in_writeable()
to probe first 16 bytes rather than 1.

> Have a look at the below code to see what I mean.  Function
> copy_to_user_nofault_unaligned() should be further optimized, maybe as
> mm/maccess.c:copy_from_kernel_nofault() and/or per architecture
> depending on the actual alignment rules; I'm not sure.
[...]
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2051,13 +2051,30 @@ static noinline int key_in_sk(struct btrfs_key *key,
>  	return 1;
>  }
>  
> +size_t copy_to_user_nofault_unaligned(void __user *to, void *from, size_t size)
> +{
> +	size_t rest = copy_to_user_nofault(to, from, size);
> +
> +	if (rest) {
> +		size_t n;
> +
> +		for (n = size - rest; n < size; n++) {
> +			if (copy_to_user_nofault(to + n, from + n, 1))
> +				break;
> +		}
> +		rest = size - n;
> +	}
> +	return rest;

That's what I was trying to avoid. That's basically a fall-back to byte
at a time copy (we do this in copy_mount_options(); at some point we
even had a copy_from_user_exact() IIRC).

Linus' idea (if I got it correctly) was instead to slightly extend the
probing in fault_in_writeable() for the beginning of the buffer from 1
byte to some per-arch range.

I attempted the above here and works ok:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/btrfs-live-lock-fix

but too late to post it this evening, I'll do it in the next day or so
as an alternative to this series.

-- 
Catalin
