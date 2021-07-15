Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE2C3CA056
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 16:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhGOOQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 10:16:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37130 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhGOOQG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 10:16:06 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B301622A72;
        Thu, 15 Jul 2021 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626358392; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=CnCez49KHBUKEtwx4tGXdaudaqGp4rBaqmANJJoSah0=;
        b=fisCpXuqqUeEeWU+3TruKE9Y3rJiwgEaI8tqS0LUIuCbJBphAL22fpiMyOmZ23H0DyQaKd
        Q4p7ohdRgUS3klJ9Wj35XcVkN8S0cL3ordLS6bQoXMjevC57Dwjs0MUFFabS4T6HfEpXhD
        9qeBC3wETrquS6TKqCvEsZH7yBgSrfk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6372113C38;
        Thu, 15 Jul 2021 14:13:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id trHBFXhC8GCuXAAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 15 Jul 2021 14:13:12 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] vfs: Optimize dedupe comparison
Date:   Thu, 15 Jul 2021 17:13:09 +0300
Message-Id: <20210715141309.38443-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently the comparison method vfs_dedupe_file_range_compare utilizes
is a plain memcmp. This effectively means the code is doing byte-by-byte
comparison. Instead, the code could do word-sized comparison without
adverse effect on performance, provided that the comparison's length is
at least as big as the native word size, as well as resulting memory
addresses are properly aligned.

On a workload consisting of running duperemove (a userspace program
doing deduplication of duplicated extents) on a fully-duplicated
dataset, consisting of 80g spread among 20k 4m files I get the following
results:

		Unpatched:		Patched:
real		21m45.275s		21m14.445s
user		0m0.986s		0m0.933s
sys		1m30.734s		1m8.900s (-25%)

Notable changes in the perf profiles:
 .... omitted for brevity ....
     0.29%     +1.01%  [kernel.vmlinux]         [k] vfs_dedupe_file_range_compare.constprop.0
    23.62%             [kernel.vmlinux]         [k] memcmp
 .... omitted for brevity ....

The memcmp is being eliminated altogether and instead is replaced by the
newly introduced loop in vfs_dedupe_file_range_compare, hence the
increase of cycles spent there by 1%.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/remap_range.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index e4a5fdd7ad7b..041e03b082ed 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -212,6 +212,7 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 	loff_t cmp_len;
 	bool same;
 	int error;
+	const uint8_t block_size = sizeof(unsigned long);

 	error = -EINVAL;
 	same = true;
@@ -256,9 +257,35 @@ static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		flush_dcache_page(src_page);
 		flush_dcache_page(dest_page);

-		if (memcmp(src_addr + src_poff, dest_addr + dest_poff, cmp_len))
-			same = false;

+		if (!IS_ALIGNED((unsigned long)(src_addr + src_poff), block_size) ||
+		    !IS_ALIGNED((unsigned long)(dest_addr + dest_poff), block_size) ||
+		    cmp_len < block_size) {
+			if (memcmp(src_addr + src_poff, dest_addr + dest_poff,
+				   cmp_len))
+				same = false;
+		} else {
+			int i;
+			size_t blocks = cmp_len / block_size;
+			loff_t rem_len = cmp_len - (blocks * block_size);
+			unsigned long *src = src_addr + src_poff;
+			unsigned long *dst = dest_addr + src_poff;
+
+			for (i = 0; i < blocks; i++) {
+				if (src[i] - dst[i]) {
+					same = false;
+					goto finished;
+				}
+			}
+
+			if (rem_len) {
+				src_addr += src_poff + (blocks * block_size);
+				dest_addr += dest_poff + (blocks * block_size);
+				if (memcmp(src_addr, dest_addr, rem_len))
+					same = false;
+			}
+		}
+finished:
 		kunmap_atomic(dest_addr);
 		kunmap_atomic(src_addr);
 unlock:
--
2.25.1

