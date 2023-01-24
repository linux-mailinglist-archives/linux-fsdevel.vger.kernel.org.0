Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3691967A2C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 20:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjAXTah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjAXTaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:30:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5804DBDC;
        Tue, 24 Jan 2023 11:30:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ACD761323;
        Tue, 24 Jan 2023 19:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC9EC433EF;
        Tue, 24 Jan 2023 19:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674588633;
        bh=7icNKyCzEc+AGNwxXSz8RhAIx0cDMmt7igP9nFBKIrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFjMvDbVbNFKgJn4lxivMvgzp/tDIEw9JKcAQ6WEIDS6lN25HTVXKxuCvlXN9sRb2
         1mCRdMwbOuTgi8m2BQfJmgF7cU28fMVYC0s0DSDWsN/u5iSE2OWxi32MZ87S548WMx
         WCnMBODaCGiEeRIfQKtkmpa/r5GLDVSTL+mgoX+CxbwUo4oUcfUqAkBvhH5ngInf1n
         YbnzgUmOTrSJuEMlqDSNPUVyIxIu115IsFuT6Xf+ve6HXp1xipXGt9zlxmfkl4vQq+
         M+BW1XA8rKK24ZfWZBsbIyPAsBqQ9K/NzmAt1wMreoWOB0aCl/FwdfUqA2NUgOTXcz
         zKgv5NZznoZmg==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, Colin Walters <walters@verbum.org>
Subject: [PATCH v8 RESEND 2/8] fs: clarify when the i_version counter must be updated
Date:   Tue, 24 Jan 2023 14:30:19 -0500
Message-Id: <20230124193025.185781-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124193025.185781-1-jlayton@kernel.org>
References: <20230124193025.185781-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The i_version field in the kernel has had different semantics over
the decades, but NFSv4 has certain expectations. Update the comments
in iversion.h to describe when the i_version must change.

Cc: Colin Walters <walters@verbum.org>
Cc: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/iversion.h | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 6755d8b4f20b..fced8115a5f4 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -9,8 +9,25 @@
  * ---------------------------
  * The change attribute (i_version) is mandated by NFSv4 and is mostly for
  * knfsd, but is also used for other purposes (e.g. IMA). The i_version must
- * appear different to observers if there was a change to the inode's data or
- * metadata since it was last queried.
+ * appear larger to observers if there was an explicit change to the inode's
+ * data or metadata since it was last queried.
+ *
+ * An explicit change is one that would ordinarily result in a change to the
+ * inode status change time (aka ctime). i_version must appear to change, even
+ * if the ctime does not (since the whole point is to avoid missing updates due
+ * to timestamp granularity). If POSIX or other relevant spec mandates that the
+ * ctime must change due to an operation, then the i_version counter must be
+ * incremented as well.
+ *
+ * Making the i_version update completely atomic with the operation itself would
+ * be prohibitively expensive. Traditionally the kernel has updated the times on
+ * directories after an operation that changes its contents. For regular files,
+ * the ctime is usually updated before the data is copied into the cache for a
+ * write. This means that there is a window of time when an observer can
+ * associate a new timestamp with old file contents. Since the purpose of the
+ * i_version is to allow for better cache coherency, the i_version must always
+ * be updated after the results of the operation are visible. Updating it before
+ * and after a change is also permitted.
  *
  * Observers see the i_version as a 64-bit number that never decreases. If it
  * remains the same since it was last checked, then nothing has changed in the
-- 
2.39.1

