Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7384480E6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Dec 2021 02:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhL2BNY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 20:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbhL2BNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 20:13:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EE6C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 17:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+nRTvO53WeuNv1E69jypme2WVDT32jB4X4TndGtcxyw=; b=LGV3UfBPp7rlTepDGAuRlTVVv7
        6dpMmkL3w7RJ7xlkVzB5atEJ7uPJjSNMfZdzamgYtt/1m6daoR3nwwoZO3w5kW4Yky53/3phgK2Jy
        SqSXJ8rMY/BnxXibqd0zdsaSu+lfgQQtiCFIFBq93uPKHYn0FploCEAm+hd+l8JEik3X8KigeiTjo
        hq/O0F7E22vkEugwVnzl404HA6t/ynUaQHw+zXDS/E+/qi11s10+UhBusoghHR98ZnMR1rRtx6dfA
        gNbBUKpFRLdITilfP3mUBW+bOPYf0gXRE/CIy2HrwS3Bw1iB1Xf0q9FdZvsuA7arnef7lI363qE4K
        O4IbGsXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2NWq-008dt6-DM; Wed, 29 Dec 2021 01:13:20 +0000
Date:   Wed, 29 Dec 2021 01:13:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     August Wikerfors <august.wikerfors@gmail.com>
Cc:     Mohan R <mohan43u@gmail.com>, uwe.sauter.de@gmail.com,
        almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
        Jan Kara <jack@suse.cz>
Subject: Re: Bug using new ntfs3 file system driver (5.15.2 on Arch Linux)
Message-ID: <Ycu2MGt/raXJ+wCb@casper.infradead.org>
References: <CAFYqD2pe-sjPrHXGsNCHa2fcdECNm44UEZbEn4P5VgygFnrn7A@mail.gmail.com>
 <YaJFoadpGAwPfdLv@casper.infradead.org>
 <CAP62yhUh2ULCaD4+RX6Lj_QZmJN+uh5L46xzb7NvrWU3vHeCfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP62yhUh2ULCaD4+RX6Lj_QZmJN+uh5L46xzb7NvrWU3vHeCfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 28, 2021 at 10:00:53PM +0100, August Wikerfors wrote:
> (resending from gmail due to bounce with outlook)
> 
> Hi, I ran into a bug with a very similar call trace, also when copying files
> with rsync from a filesystem mounted using ntfs3. I was able to reproduce it
> on both the default Arch Linux kernel (5.15.11-arch2-1) and on mainline
> 5.16-rc7.

Hi August!  This is very helpful; thank you for putting in the work to
figure this out.  I am still a little baffled:

> [  486.361177] RIP: 0010:0xffffff8306d925ff
> [  486.361192] Code: Unable to access opcode bytes at RIP 0xffffff8306d925d5.
> [  486.361214] RSP: 0018:ffffaa9ec0f8fb37 EFLAGS: 00010246
> [  486.361232] RAX: 0000000000000000 RBX: 00000000000002ab RCX: 0000000000000000
> [  486.361255] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  486.361279] RBP: ffaa9ec0f8fbf800 R08: 0000000000000000 R09: 0000000000000000
> [  486.361302] R10: 0000000000000000 R11: 0000000000000000 R12: ff99687f5746e000
> [  486.361324] R13: 00000001112ccaff R14: fffcbb8097368000 R15: 00000000000001ff
> [  486.361349]  ? page_cache_ra_unbounded+0x1c5/0x250
> [  486.361369]  ? filemap_get_pages+0x117/0x730
> [  486.361386]  ? make_kuid+0xf/0x20
> [  486.361401]  ? generic_permission+0x27/0x210
> [  486.361419]  ? walk_component+0x11d/0x1c0
> [  486.361435]  ? filemap_read+0xb9/0x360
> [  486.361451]  ? new_sync_read+0x159/0x1f0
> [  486.361467]  ? vfs_read+0xff/0x1a0
> [  486.361489]  ? ksys_read+0x67/0xf0
> [  486.361503]  ? do_syscall_64+0x5c/0x90
> 
> $ scripts/faddr2line vmlinux.5.15.11-arch2-1 page_cache_ra_unbounded+0x1c5/0x250
> page_cache_ra_unbounded+0x1c5/0x250:
> filemap_invalidate_unlock_shared at include/linux/fs.h:853
> (inlined by) page_cache_ra_unbounded at mm/readahead.c:240

So ... Jan added this code in commit 730633f0b7f9, but I don't see how
it could be buggy:

        filemap_invalidate_lock_shared(mapping);
... things that don't change mapping ...
        filemap_invalidate_unlock_shared(mapping);
and the _unlock_ appears to have a bad pointer.  Which makes no sense
to me.  Jan, any ideas?

