Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62806A32A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Feb 2023 17:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBZQDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 11:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBZQDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:03:42 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53EC1041B;
        Sun, 26 Feb 2023 08:03:28 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.169])
        by gnuweeb.org (Postfix) with ESMTPSA id 19DE8831AF;
        Sun, 26 Feb 2023 16:03:23 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1677427408;
        bh=dk6mSe4MY5NIqRMjCLFlrLyUSKZZEVxaqAfyqXfwVa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6QRoXLqOsMTebWNx0TMa8JLFQVdx/XStS+s7pCIKLmXL1YwM68tMgh+aty7mpfTj
         CDYcYLrv1aihPsIr4VeASZQMuo8uhqBEvIRqB1L0IyXK4W1nYvvw/9XttO0PlH5It5
         BA8KHyfpV6+rCMMDHJ0kcrl0vxyKWnJSpCJv9RVe/nHQTPcAtCG1yYN9Rw8RuTGxUb
         EzxeckC0J4GDK81Y5bmNNanHEEdEV4e6hiIVZf0sNgZpvCfsDH+UeYHeeZstmnle33
         7SPKZLvxBvCMGXDE9A28i5TCvefHYrJ/q2HtSMLQ4dy9pj3k5kizVzFYSEn3V7QTyY
         SsmHAUF2408Jw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Tejun Heo <tj@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Filipe Manana <fdmanana@suse.com>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [RFC PATCH v1 2/6] btrfs: Change `mount_opt` type in `struct btrfs_fs_info` to `u64`
Date:   Sun, 26 Feb 2023 23:02:55 +0700
Message-Id: <20230226160259.18354-3-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
References: <20230226160259.18354-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On a 32-bit Linux system, `unsigned long` is 32-bit. In preparation to
add more mount options, change the type to `u64` because the enum for
this option has reached the max 32-bit capacity.

It does not make any difference on a system where `unsigned long` is
64-bit, only needed for the 32-bit system.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 fs/btrfs/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 4c477eae689148dd..6de61367b6686197 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -422,7 +422,7 @@ struct btrfs_fs_info {
 	 * required instead of the faster short fsync log commits
 	 */
 	u64 last_trans_log_full_commit;
-	unsigned long mount_opt;
+	u64 mount_opt;
 
 	unsigned long compress_type:4;
 	unsigned int compress_level;
-- 
Ammar Faizi

