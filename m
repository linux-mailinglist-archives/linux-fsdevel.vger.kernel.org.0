Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1D459C0A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiHVNdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 09:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiHVNdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 09:33:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D223A1A3;
        Mon, 22 Aug 2022 06:33:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70D9661190;
        Mon, 22 Aug 2022 13:33:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA37C433C1;
        Mon, 22 Aug 2022 13:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661175191;
        bh=XXoXVTwv4p663PKv29Ug+s5+Q9mMsY4SeFyX9qyLO3k=;
        h=From:To:Cc:Subject:Date:From;
        b=Y69UKGM3eqjCqXyVWILpXzm3HHnUVFNxp9O49y6Uz020SjbEOnQ4/P8B2pM+W1hs2
         /GM9JeR3zf2RcUC5Ny249iiba1/ICi2MjjuTVaRHGVkExESDkP9gH6T/cDI8v8d/Fk
         izGGAvfChPCWKEU0EQmHFmplhUevqkTRzzkd/XuCZCmhGfVE5bPj/DY4w9ND61FK5D
         ShR8eN1uSEWbYWFZ81iMXtdFMCZD+rCa6dpozxQe3NGEyYf/9yo/X3tTvR6JPD6Lmu
         cILu31VAIMpU6t7r4/dfPznXwM5uVfruXtQUYl3T0pankxf7T2VMYHUHKfiBA1i/WH
         1FFgDiUOli0xA==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH] iversion: update comments with info about atime updates
Date:   Mon, 22 Aug 2022 09:33:09 -0400
Message-Id: <20220822133309.86005-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an explicit paragraph codifying that atime updates due to reads
should not be counted against the i_version counter. None of the
existing subsystems that use the i_version want those counted, and
there is an easy workaround for those that do.

Cc: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: Dave Chinner <david@fromorbit.com>
Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326033@noble.neil.brown.name/#t
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/iversion.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 3bfebde5a1a6..da6cc1cc520a 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -9,8 +9,8 @@
  * ---------------------------
  * The change attribute (i_version) is mandated by NFSv4 and is mostly for
  * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
- * appear different to observers if there was a change to the inode's data or
- * metadata since it was last queried.
+ * appear different to observers if there was an explicit change to the inode's
+ * data or metadata since it was last queried.
  *
  * Observers see the i_version as a 64-bit number that never decreases. If it
  * remains the same since it was last checked, then nothing has changed in the
@@ -18,6 +18,12 @@
  * anything about the nature or magnitude of the changes from the value, only
  * that the inode has changed in some fashion.
  *
+ * Note that atime updates due to reads or similar activity do _not_ represent
+ * an explicit change to the inode. If the only change is to the atime and it
+ * wasn't set via utimes() or a similar mechanism, then i_version should not be
+ * incremented. If an observer cares about atime updates, it should plan to
+ * fetch and store them in conjunction with the i_version.
+ *
  * Not all filesystems properly implement the i_version counter. Subsystems that
  * want to use i_version field on an inode should first check whether the
  * filesystem sets the SB_I_VERSION flag (usually via the IS_I_VERSION macro).
-- 
2.37.2

