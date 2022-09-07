Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8118C5B030E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 13:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiIGLdr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 07:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiIGLd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 07:33:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289D4B69FE;
        Wed,  7 Sep 2022 04:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90DADB81C54;
        Wed,  7 Sep 2022 11:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A83C433D7;
        Wed,  7 Sep 2022 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662550404;
        bh=pgdqISJ78hjl4jnmYpYl02FTsH6QtwIm0GzwJzLcJeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jUc7JHz1Hr2VUZGmUY4B2Dzd5YyfayOVb2CGCl2Zf2UIARfJWnVLP+OXLTGgPO92g
         AhLkb5dQ9JbjsORHi2Ax36RR74jMzgvHINBHQI6UyFgf2jN5fn/63ipvLH4ra4ahtV
         skULuiwl0q3Wy+Vi1CS8FMxQupOejwnl6u4CtO5lcEv0x5O0a/y5xb1Zi/ewxZxXds
         jARtbume4Mw03XpbL02ybRsrBXOKeiXKY3NgiuX2Kny8KdaX6kWEtWVG7210oIERkE
         O/QczdmNwXrYTxn+O56xquvTObPPvgSm1Ujr2fWFDysoa2oMg1+MEm3g01n8Kp6hhR
         kOEgcTuiayIdA==
From:   Jeff Layton <jlayton@kernel.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, djwong@kernel.org,
        david@fromorbit.com, trondmy@hammerspace.com, neilb@suse.de,
        viro@zeniv.linux.org.uk, zohar@linux.ibm.com, xiubli@redhat.com,
        chuck.lever@oracle.com, lczerner@redhat.com, jack@suse.cz,
        bfields@fieldses.org, brauner@kernel.org, fweimer@redhat.com
Cc:     linux-api@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        Colin Walters <walters@verbum.org>
Subject: [PATCH v4 1/6] iversion: update comments with info about atime updates
Date:   Wed,  7 Sep 2022 07:33:13 -0400
Message-Id: <20220907113318.21810-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907113318.21810-1-jlayton@kernel.org>
References: <20220907113318.21810-1-jlayton@kernel.org>
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

Update the comments in iversion.h to describe when the i_version
must change.

Cc: Colin Walters <walters@verbum.org>
Cc: NeilBrown <neilb@suse.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>
Cc: Dave Chinner <david@fromorbit.com>
Link: https://lore.kernel.org/linux-xfs/166086932784.5425.17134712694961326033@noble.neil.brown.name/#t
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/iversion.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/iversion.h b/include/linux/iversion.h
index 3bfebde5a1a6..0555a3851dbf 100644
--- a/include/linux/iversion.h
+++ b/include/linux/iversion.h
@@ -9,8 +9,14 @@
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
+ * to timestamp granularity). If POSIX mandates that the ctime must change due
+ * to an operation, then the i_version counter must be incremented as well.
  *
  * Observers see the i_version as a 64-bit number that never decreases. If it
  * remains the same since it was last checked, then nothing has changed in the
-- 
2.37.3

