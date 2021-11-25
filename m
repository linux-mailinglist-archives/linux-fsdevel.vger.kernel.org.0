Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05D45E1E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 22:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357165AbhKYVHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 16:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbhKYVFu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 16:05:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0DDC061574;
        Thu, 25 Nov 2021 13:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6whOC0TKGHPxQK7AWkvSbq/nnQHgn420BvdvtIX5e9U=; b=fDmyyCipVl5lPnqbKdEPMegTzV
        HFDsVdla5bphMbGh+7EV0KFHgJLrVEjpxrC7U/+PPFFepp08yoIBFLW7U7hhOmc8MDJJFKatzWbXK
        WLyDBkfDAtHi7Yjd2VGTc2HhQH9qVumun2C6yBBrQuH49PvfUGHOpM4vgEey9HVHddPH78RKUDHZ0
        S88l0v/qDztowz1PSr4G7vVaZrSoQOjYdEzrairMtUjVtFkhQObIJojCclDLFOquxxJikzReA3JK/
        Lkbr76gzdZQH3z2bpMB8djessDrHZSR3hCTrW+27G2j3AvAEzAoxmw16XWjfbjTIuWeIYOBQiTssO
        W39v+IRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqLsz-007nbV-Ak; Thu, 25 Nov 2021 21:02:29 +0000
Date:   Thu, 25 Nov 2021 21:02:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <YZ/55fYE0l7ewo/t@casper.infradead.org>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com>
 <YZ9vM91Uj8g36VQC@arm.com>
 <CAHk-=wgUn1vBReeNcZNEObkxPQGhN5EUq5MC94cwF0FaQvd2rQ@mail.gmail.com>
 <YZ/1jflaSjgRRl2o@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ/1jflaSjgRRl2o@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 25, 2021 at 08:43:57PM +0000, Catalin Marinas wrote:
> > I really believe that the fix is to make the read/write probing just
> > be more aggressive.
> > 
> > Make the read/write probing require that AT LEAST <n> bytes be
> > readable/writable at the beginning, where 'n' is 'min(len,ALIGN)', and
> > ALIGN is whatever size that copy_from/to_user_xyz() might require just
> > because it might do multi-byte accesses.
> > 
> > In fact, make ALIGN be perhaps something reasonable like 512 bytes or
> > whatever, and then you know you can handle the btrfs "copy a whole
> > structure and reset if that fails" case too.
> 
> IIUC what you are suggesting, we still need changes to the btrfs loop
> similar to willy's but that should work fine together with a slightly
> more aggressive fault_in_writable().
> 
> A probing of at least sizeof(struct btrfs_ioctl_search_key) should
> suffice without any loop changes and 512 would cover it but it doesn't
> look generic enough. We could pass a 'probe_prefix' argument to
> fault_in_exact_writeable() to only probe this and btrfs would just
> specify the above sizeof().

How about something like this?

+++ b/mm/gup.c
@@ -1672,6 +1672,13 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)

        if (unlikely(size == 0))
                return 0;
+       if (SUBPAGE_PROBE_INTERVAL) {
+               while (uaddr < PAGE_ALIGN((unsigned long)uaddr)) {
+                       if (unlikely(__put_user(0, uaddr) != 0))
+                               goto out;
+                       uaddr += SUBPAGE_PROBE_INTERVAL;
+               }
+       }
        if (!PAGE_ALIGNED(uaddr)) {
                if (unlikely(__put_user(0, uaddr) != 0))
                        return size;

ARM then defines SUBPAGE_PROBE_INTERVAL to be 16 and the rest of us
leave it as 0.  That way we probe all the way to the end of the current
page and the start of the next page.

Oh, that needs to be checked to not exceed size as well ... anyway,
you get the idea.
