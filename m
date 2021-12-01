Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2632E4656A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 20:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352852AbhLATlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 14:41:55 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:48792 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352783AbhLATl3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:41:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC436CE20D7;
        Wed,  1 Dec 2021 19:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE066C53FD2;
        Wed,  1 Dec 2021 19:38:02 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page faults
Date:   Wed,  1 Dec 2021 19:37:50 +0000
Message-Id: <20211201193750.2097885-5-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201193750.2097885-1-catalin.marinas@arm.com>
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
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

Request a 'min_size' of (*buf_size - sk_offset) from
fault_in_writeable() to check this range for sub-page faults.

Fixes: a48b73eca4ce ("btrfs: fix potential deadlock in the search ioctl")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c7d74c8776a1..439cf38f320a 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2222,8 +2222,13 @@ static noinline int search_ioctl(struct inode *inode,
 	key.offset = sk->min_offset;
 
 	while (1) {
+		size_t len = *buf_size - sk_offset;
 		ret = -EFAULT;
-		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset, 0))
+		/*
+		 * Ensure that the whole user buffer is faulted in at sub-page
+		 * granularity, otherwise the loop may live-lock.
+		 */
+		if (fault_in_writeable(ubuf + sk_offset, len, len))
 			break;
 
 		ret = btrfs_search_forward(root, &key, path, sk->min_transid);
