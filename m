Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D9F50C90B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Apr 2022 12:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbiDWKL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbiDWKLJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 06:11:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB7A1B2B00;
        Sat, 23 Apr 2022 03:08:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 298A6B80AD3;
        Sat, 23 Apr 2022 10:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB8AC385A5;
        Sat, 23 Apr 2022 10:08:01 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware with sub-page faults
Date:   Sat, 23 Apr 2022 11:07:51 +0100
Message-Id: <20220423100751.1870771-4-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220423100751.1870771-1-catalin.marinas@arm.com>
References: <20220423100751.1870771-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Use fault_in_subpage_writeable() instead of fault_in_writeable() to
ensure the permission is checked at the right granularity (smaller than
PAGE_SIZE).

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: a48b73eca4ce ("btrfs: fix potential deadlock in the search ioctl")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ioctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index be6c24577dbe..9bf0616a3069 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2565,7 +2565,12 @@ static noinline int search_ioctl(struct inode *inode,
 
 	while (1) {
 		ret = -EFAULT;
-		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
+		/*
+		 * Ensure that the whole user buffer is faulted in at sub-page
+		 * granularity, otherwise the loop may live-lock.
+		 */
+		if (fault_in_subpage_writeable(ubuf + sk_offset,
+					       *buf_size - sk_offset))
 			break;
 
 		ret = btrfs_search_forward(root, &key, path, sk->min_transid);
