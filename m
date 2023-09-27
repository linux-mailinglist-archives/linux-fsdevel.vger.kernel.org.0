Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0FB7B0541
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjI0NV7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjI0NVy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:21:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF364126
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Sep 2023 06:21:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E81C433C7;
        Wed, 27 Sep 2023 13:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695820912;
        bh=OQoK06lrcpD3fVrzh9jJ814jEBCF92IPWwOUbqrz2fQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=bREBQSlsXSrNTHIIgsZsRlEuXTmRhiMOk5AebtjsC2p5DoxKC15cU/3wVYbII3zlB
         FXbWpE9XttVQgXM0HhiqPoXd6xPhgQZy1Yse5Jm1JFvm9y34TkGtVZO93qx8LEFXqg
         06eztUvnNmzHPwN6MB6lYRujiKpPl+pv6Ld2gV/nlVsz2BjVgj3PW4DXMMtTrqLUPz
         xVMt7P4uy6FWz0snKBl02Z+Ul7yawdlw+XkGd9hAMn4sJvE23q5YvUIOQKKr9m2uiX
         HuE8AZhQ+ZDn03TvJkP9zsDz6fwVkFLoW59dtLgC3GEiDJzaaBWOinSuLFdmdKtQDP
         iapwXFoawi5/A==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 27 Sep 2023 15:21:20 +0200
Subject: [PATCH 7/7] porting: document block device freeze and thaw changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230927-vfs-super-freeze-v1-7-ecc36d9ab4d9@kernel.org>
References: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
In-Reply-To: <20230927-vfs-super-freeze-v1-0-ecc36d9ab4d9@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OQoK06lrcpD3fVrzh9jJ814jEBCF92IPWwOUbqrz2fQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSK6KQYni6uetBxtG3LrDZGrZgHTxxPBDF7m4ayTL/6fNHC
 aR8CO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaS0MrIcDq2VVj8gG3QBY0Vxi7JLt
 O0NLV+nf9ctWehvvyGXzts+RgZXvzRq1ppefbE9AncZ6/3nxGO7rnKPWdD+wOJ5wdLw5cdZgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 Documentation/filesystems/porting.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 4d05b9862451..fef97a2e6729 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1045,3 +1045,28 @@ filesystem type is now moved to a later point when the devices are closed:
 As this is a VFS level change it has no practical consequences for filesystems
 other than that all of them must use one of the provided kill_litter_super(),
 kill_anon_super(), or kill_block_super() helpers.
+
+---
+
+**mandatory**
+
+Block device freezing and thawing have been moved to holder operations. As we
+can now go straight from block devcie to superblock the get_active_super()
+and bd_fsfreeze_sb members in struct block_device are gone.
+
+The bd_fsfreeze_mutex is gone as well since we can rely on the bd_holder_lock
+to protect against concurrent freeze and thaw.
+
+Before this change, get_active_super() would only be able to find the
+superblock of the main block device, i.e., the one stored in sb->s_bdev. Block
+device freezing now works for any block device owned by a given superblock, not
+just the main block device.
+
+When thawing we now grab an active reference so we can hold bd_holder_lock
+across thaw without the risk of deadlocks (because the superblock goes away
+which would require us to take bd_holder_lock). That allows us to get rid of
+bd_fsfreeze_mutex. Currently we just reacquire s_umount after thaw_super() and
+drop the active reference we took before. This someone could grab an active
+reference before we dropped the last one. This shouldn't be an issue. If it
+turns out to be one we can reshuffle the code to simply hold s_umount when
+thaw_super() returns and drop the reference.

-- 
2.34.1

