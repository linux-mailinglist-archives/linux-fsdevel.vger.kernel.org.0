Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9835245CD18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 20:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244133AbhKXTXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 14:23:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243268AbhKXTXm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:23:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8AB0604DA;
        Wed, 24 Nov 2021 19:20:26 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] Avoid live-lock in fault-in+uaccess loops with sub-page faults
Date:   Wed, 24 Nov 2021 19:20:21 +0000
Message-Id: <20211124192024.2408218-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

There are a few places in the filesystem layer where a uaccess is
performed in a loop with page faults disabled, together with a
fault_in_*() call to pre-fault the pages. On architectures like arm64
with MTE (memory tagging extensions) or SPARC ADI, even if the
fault_in_*() succeeded, the uaccess can still fault indefinitely.

In general this is not an issue since such code restarts the
fault_in_*() from where the uaccess failed, therefore guaranteeing
forward progress. The btrfs search_ioctl(), however, rewinds the
fault_in_*() position and it can live-lock. This was reported by Al
here:

https://lore.kernel.org/r/YSqOUb7yZ7kBoKRY@zeniv-ca.linux.org.uk

There's also an analysis by Al of other fault-in places:

https://lore.kernel.org/r/YSldx9uhMYhT/G8X@zeniv-ca.linux.org.uk

and another sub-thread on the same topic:

https://lore.kernel.org/r/YXBFqD9WVuU8awIv@arm.com

So far only btrfs search_ioctl() seems to be affected and that's what
this series addresses. The existing loops like generic_perform_write()
already guarantee forward progress.

Andreas raised a concern about O_DIRECT accesses since on fault the user
address is rewound to a block size boundary. I tried ext4, btrfs and
gfs2 and I could not get any of them to live-lock. Depending on the
alignment of the user buffer (page or not), I found two behaviours:

- the copy to or from the user buffer succeeds entirely if it goes
  through the kernel mapping (GUP, kmap'ed page; user MTE tags are not
  checked) or

- the copy partially succeeds after a few attempts at uaccess on the
  faulting same address (the highest number of attempts in my tests was
  11 with btrfs).

Given the high cost of such sub-page probing (which is done prior to the
uaccess) my proposal is to only change the btrfs search_ioctl() (as per
the last patch). We can extend the API and call places in the future if
needed but I hope filesystems already deal with this in other ways.

Thanks.

Catalin Marinas (3):
  mm: Introduce fault_in_exact_writeable() to probe for sub-page faults
  arm64: Add support for sub-page faults user probing
  btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page
    faults

 arch/Kconfig                     |  7 +++++++
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/uaccess.h | 33 ++++++++++++++++++++++++++++++++
 fs/btrfs/ioctl.c                 |  3 ++-
 include/linux/pagemap.h          |  1 +
 include/linux/uaccess.h          | 21 ++++++++++++++++++++
 mm/gup.c                         | 19 ++++++++++++++++++
 7 files changed, 84 insertions(+), 1 deletion(-)

