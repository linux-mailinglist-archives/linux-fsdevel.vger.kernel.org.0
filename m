Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85145CD1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 20:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbhKXTXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 14:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:56706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244333AbhKXTXq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:23:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EAB560F6B;
        Wed, 24 Nov 2021 19:20:34 +0000 (UTC)
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
Subject: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page faults
Date:   Wed, 24 Nov 2021 19:20:24 +0000
Message-Id: <20211124192024.2408218-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124192024.2408218-1-catalin.marinas@arm.com>
References: <20211124192024.2408218-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit a48b73eca4ce ("btrfs: fix potential deadlock in the search
ioctl") addressed a lockdep warning by pre-faulting the user pages and
attempting the copy_to_user_nofault() in an infinite loop. On
architectures like arm64 with MTE, an access may fault within a page at
a location different from what fault_in_writeable() probed. Since the
sk_offset is rewound to the previous struct btrfs_ioctl_search_header
boundary, there is no guaranteed forward progress and search_ioctl() may
live-lock.

Use fault_in_exact_writeable() instead which probes the entire user
buffer for faults at sub-page granularity.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/ioctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 92138ac2a4e2..23167c72fa47 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2223,7 +2223,8 @@ static noinline int search_ioctl(struct inode *inode,
 
 	while (1) {
 		ret = -EFAULT;
-		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
+		if (fault_in_exact_writeable(ubuf + sk_offset,
+					     *buf_size - sk_offset))
 			break;
 
 		ret = btrfs_search_forward(root, &key, path, sk->min_transid);
