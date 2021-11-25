Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2905F45D8DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhKYLP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 06:15:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232138AbhKYLN7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:13:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C807360230;
        Thu, 25 Nov 2021 11:10:45 +0000 (UTC)
Date:   Thu, 25 Nov 2021 11:10:43 +0000
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
Message-ID: <YZ9vM91Uj8g36VQC@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
 <20211124192024.2408218-4-catalin.marinas@arm.com>
 <YZ6arlsi2L3LVbFO@casper.infradead.org>
 <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgHqjX3kenSk5_bCRM+ZC-tgndBMfbVVsbp0CwJf2DU-w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 03:00:00PM -0800, Linus Torvalds wrote:
> On Wed, Nov 24, 2021 at 12:04 PM Matthew Wilcox <willy@infradead.org> wrote:
> > (where __copy_to_user_nofault() is a new function that does exactly what
> > copy_to_user_nofault() does, but returns the number of bytes copied)
> 
> If we want the "how many bytes" part, then we should just make
> copy_to_user_nofault() have the same semantics as a plain
> copy_to_user().
> 
> IOW, change it to return "number of bytes not copied".
> 
> Looking at the current uses, such a change would be trivial. The only
> case that wants a 0/-EFAULT error is the bpf_probe_write_user(),
> everybody else already just wants "zero for success", so changing
> copy_to_user_nofault() would be trivial.

I agree, if we want the number of byte not copied, we should just change
copy_{to,from}_user_nofault() and their callers (I can count three
each).

For this specific btrfs case, if we want go with tuning the offset based
on the fault address, we'd need copy_to_user_nofault() (or a new
function) to be exact. IOW, fall back to byte-at-a-time copy until it
hits the real faulting address.

-- 
Catalin
