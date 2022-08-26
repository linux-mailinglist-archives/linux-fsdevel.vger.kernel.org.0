Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971825A314B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 23:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344729AbiHZVrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 17:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbiHZVrL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:47:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4917FBE4CB;
        Fri, 26 Aug 2022 14:47:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8D1F61263;
        Fri, 26 Aug 2022 21:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5204FC433C1;
        Fri, 26 Aug 2022 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661550429;
        bh=D45PYjSz97etPghw1Xih5xud6PKdbXoB4GAMHrVTVWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PfAdfILJwEYpDoeED324CpLATv+DqXE7iT1H9OOHA29yxVF5zVdLnEY2bAXyse7F7
         mCWxe/uHySvmYJqWnINspAB9GBdK9PNqasigc+of1xQQ0LWgpnkuzTpfRuJ6eWX3mb
         gymePYkysSn3UXTQmxBUamknsmDWTMm2xVHuvQTMwMJYAJqJXCp+uO3UO+bZbWpHAl
         kRH+h1xnEZ6a+PGkWltbtzGqkAeLibIu89QbBb3T9HjAZ5mry+eVDpwtJngKKDAgqh
         u5f7SCkCH2ulASydhyZvIPrUG1HH/qMAzHkpqRNmOKUJJjv8NAeX/GKdDQE/rZMois
         uFX0CayIEkpKQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        brauner@kernel.org
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ceph@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Subject: [PATCH v3 1/7] iversion: update comments with info about atime updates
Date:   Fri, 26 Aug 2022 17:46:57 -0400
Message-Id: <20220826214703.134870-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826214703.134870-1-jlayton@kernel.org>
References: <20220826214703.134870-1-jlayton@kernel.org>
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

The i_version field in the kernel has had different semantics over
the decades, but we're now proposing to expose it to userland via
statx. This means that we need a clear, consistent definition of
what it means and when it should change.

Update the comments in iversion.h to describe how a conformant
i_version implementation is expected to behave. This definition
suits the current users of i_version (NFSv4 and IMA), but is
loose enough to allow for a wide range of possible implementations.

Cc: Colin Walters <walters@verbum.org>
Cc: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: Dave Chinner <david@fromorbit.com>
Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326033@noble.neil.brown.name/#t
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/iversion.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 3bfebde5a1a6..45e93e1b4edc 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -9,8 +9,19 @@
  * ---------------------------
  * The change attribute (i_version) is mandated by NFSv4 and is mostly for
  * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
- * appear different to observers if there was a change to the inode's data or
- * metadata since it was last queried.
+ * appear different to observers if there was an explicit change to the inode's
+ * data or metadata since it was last queried.
+ *
+ * An explicit change is one that would ordinarily result in a change to the
+ * inode status change time (aka ctime). The version must appear to change, even
+ * if the ctime does not (since the whole point is to avoid missing updates due
+ * to timestamp granularity). If POSIX mandates that the ctime must change due
+ * to an operation, then the i_version counter must be incremented as well.
+ *
+ * A conformant implementation is allowed to increment the counter in other
+ * cases, but this is not optimal. NFSv4 and IMA both use this value to determine
+ * whether caches are up to date. Spurious increments can cause false cache
+ * invalidations.
  *
  * Observers see the i_version as a 64-bit number that never decreases. If it
  * remains the same since it was last checked, then nothing has changed in the
@@ -66,6 +77,14 @@
  * Storing the value to disk therefore does not count as a query, so those
  * filesystems should use inode_peek_iversion to grab the value to be stored.
  * There is no need to flag the value as having been queried in that case.
+ *
+ * Notes on atime updates
+ * ----------------------
+ * Access time (atime) updates due to reads or similar activity do not represent
+ * an explicit change to the inode data or metadata. If the only change to the
+ * inode is the atime, then i_version should not be incremented. If an observer
+ * cares about atime updates, it should plan to fetch and store the atime in
+ * conjunction with the i_version.
  */
 
 /*
-- 
2.37.2

