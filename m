Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E273B4295D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 19:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhJKRj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 13:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232708AbhJKRj6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:39:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A26E60560;
        Mon, 11 Oct 2021 17:37:56 +0000 (UTC)
Date:   Mon, 11 Oct 2021 18:37:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][arm64] possible infinite loop in btrfs search_ioctl()
Message-ID: <YWR2cPKeDrc0uHTK@arm.com>
References: <20210827164926.1726765-6-agruenba@redhat.com>
 <YSkz025ncjhyRmlB@zeniv-ca.linux.org.uk>
 <CAHk-=wh5p6zpgUUoY+O7e74X9BZyODhnsqvv=xqnTaLRNj3d_Q@mail.gmail.com>
 <YSk7xfcHVc7CxtQO@zeniv-ca.linux.org.uk>
 <CAHk-=wjMyZLH+ta5SohAViSc10iPj-hRnHc-KPDoj1XZCmxdBg@mail.gmail.com>
 <YSk+9cTMYi2+BFW7@zeniv-ca.linux.org.uk>
 <YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk>
 <YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk>
 <YS40qqmXL7CMFLGq@arm.com>
 <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YS5KudP4DBwlbPEp@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 31, 2021 at 03:28:57PM +0000, Al Viro wrote:
> On Tue, Aug 31, 2021 at 02:54:50PM +0100, Catalin Marinas wrote:
> > An arm64-specific workaround would be for pagefault_disable() to disable
> > tag checking. It's a pretty big hammer, weakening the out of bounds
> > access detection of MTE. My preference would be a fix in the btrfs code.
> > 
> > A btrfs option would be for copy_to_sk() to return an indication of
> > where the fault occurred and get fault_in_pages_writeable() to check
> > that location, even if the copying would restart from an earlier offset
> > (this requires open-coding copy_to_user_nofault()). An attempt below,
> > untested and does not cover read_extent_buffer_to_user_nofault():
> 
> Umm...  There's another copy_to_user_nofault() call in the same function
> (same story, AFAICS).

I cleaned up this patch [1] but I realised it still doesn't solve it.
The arm64 __copy_to_user_inatomic(), while ensuring progress if called
in a loop, it does not guarantee precise copy to the fault position. The
copy_to_sk(), after returning an error, starts again from the previous
sizeof(sh) boundary rather than from where the __copy_to_user_inatomic()
stopped. So it can get stuck attempting to copy the same search header.

An ugly fix is to fall back to byte by byte copying so that we can
attempt the actual fault address in fault_in_pages_writeable().

If the sh being recreated in copy_to_sk() is the same on the retried
iteration, we could use an *sk_offset that is not a multiple of
sizeof(sh) in order to have progress. But it's not clear to me whether
the data being copied can change once btrfs_release_path() is called.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=devel/btrfs-fix

-- 
Catalin
