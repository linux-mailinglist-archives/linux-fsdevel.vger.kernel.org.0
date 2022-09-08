Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDBE5B247A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiIHRZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiIHRZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:25:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AA34F398;
        Thu,  8 Sep 2022 10:24:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 740B9B821D4;
        Thu,  8 Sep 2022 17:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2E1C433D7;
        Thu,  8 Sep 2022 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662657894;
        bh=5RwWtZAQsV8rQ6WEtGKbKdleHPjSdSyUVZNqRyCE/eM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRlN0pfUD9xuLABWeALrjLUrDFjn0LMhSECknUUklQFg9zkp/9r8aM/Q7Id3OVPtZ
         wTynxxgyVyBdBBIjt1V0zEj6mHEZKpJtkOX17Tnk1UvJBHXbgyfKy6vMZIunUN5WDZ
         YuVXP2BivVgiZk8ygz+0WCZ+jqfH8bxcpCVyh3lmjHGV7YKVGfOUwcNDQ6OqP0kELw
         j/RVFd8NT0U19s6Dvx+nvvGIKyZNWRX6R5BaIiOX9PhvjOgKJW//Fdk5yYbonDRCiy
         Eg+sTQkJQS6rBD+xAmVD03xvgEDGHdI+8kmklMO6GU+9MUjxvHl5xGRDSMr/jA94BX
         RF0cg+hrT8NVA==
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
Subject: [PATCH v5 1/8] iversion: clarify when the i_version counter must be updated
Date:   Thu,  8 Sep 2022 13:24:41 -0400
Message-Id: <20220908172448.208585-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220908172448.208585-1-jlayton@kernel.org>
References: <20220908172448.208585-1-jlayton@kernel.org>
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
the decades, but NFSv4 has certain expectations. Update the comments
in iversion.h to describe when the i_version must change.

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

